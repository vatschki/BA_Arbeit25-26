import json
import re
from typing import List
from app.llm.base_client import BaseLLMClient
from app.config import Config
import logging

logger = logging.getLogger(__name__)

'''
BlockSelector ist eine Klasse, die ein LLM verwendet, um ein beschädigtes Inhaltsverzeichnis zu analysieren und
Seitenzahlen zu bestimmten Kapiteln zu identifizieren. Sie arbeitet in zwei Phasen: In der ersten Phase werden Blöcke
des Inhaltsverzeichnisses iterativ verarbeitet, um mögliche Treffer für den Zielkapitel-Titel sowie für den folgenden
Kapitel-Titel zu finden. In der zweiten Phase erfolgt eine Validierung, bei der benachbarte Blöcke überprüft werden,
um zusätzliche Treffer zu finden und die Ergebnisse zu bestätigen. Die Klasse erstellt dafür einen Prompt für das LLM,
der die Aufgabe der Strukturrekonstruktion sowie strenge Regeln zur Identifizierung von Kapiteln und Seitenzahlen
betont. Die Antwort des LLM wird anschließend geparst, um die Seitenzahlen zu extrahieren, die dann als sortierte
Liste zurückgegeben werden. Die Klasse ist dafür ausgelegt, in einer größeren Dokumentanalyse-Pipeline eingesetzt zu
werden, in der sie hilft, relevante Seiten für bestimmte Kapitel anhand eines möglicherweise beschädigten
Inhaltsverzeichnisses zu bestimmen.
'''

class BlockSelector:

    def __init__(self, llm_client: BaseLLMClient, config: Config, window_size: int = 90):
        self.llm = llm_client
        self.config = config
        self.window_size = window_size

    def select_blocks_iterative(
        self,
        analysis_json: dict,
        search_term_start: str,
        search_term_end: str,
    ) -> List[int]:

        blocks = analysis_json.get("blocks", [])
        total_blocks = len(blocks)

        found_pages: set[int] = set()
        offset = 0

        FIRST_PHASE_LIMIT = self.window_size * 5
        VALIDATION_WINDOWS = 2

        phase = "FIRST"

        while offset < total_blocks:

            window_blocks = blocks[offset: offset + self.window_size]
            logger.info(f"[SELECTOR] {phase} blocks {offset}–{offset + len(window_blocks) - 1}")

            window_json = {**analysis_json, "blocks": window_blocks}
            pages = self._run_single_call(window_json, search_term_start, search_term_end)

            if pages:
                before = len(found_pages)
                found_pages.update(pages)

                # ---------- VALIDATION ----------
                logger.info("[SELECTOR] Hit found → entering validation")

                validation_offset = offset + self.window_size
                new_found = False

                for i in range(VALIDATION_WINDOWS):
                    if validation_offset >= total_blocks:
                        break

                    v_blocks = blocks[validation_offset: validation_offset + self.window_size]
                    logger.info(f"[SELECTOR] VALIDATE blocks {validation_offset}–{validation_offset + len(v_blocks) - 1}")

                    v_json = {**analysis_json, "blocks": v_blocks}
                    v_pages = self._run_single_call(v_json, search_term_start, search_term_end)

                    if v_pages:
                        prev = len(found_pages)
                        found_pages.update(v_pages)
                        if len(found_pages) > prev:
                            new_found = True
                            logger.info("[SELECTOR] New pages found in validation → terminating")
                            return sorted(found_pages)

                    validation_offset += self.window_size

                # ---------- no new pages in validation → continue search ----------
                logger.info("[SELECTOR] No new pages in validation → continuing search")
                offset = validation_offset
                phase = "GLOBAL"
                continue

            # ---------- No pages found ----------
            offset += self.window_size

            if phase == "FIRST" and offset >= FIRST_PHASE_LIMIT:
                logger.info("[SELECTOR] Phase1 finished → switching to GLOBAL")
                phase = "GLOBAL"

        if not found_pages:
            logger.info("[SELECTOR] No pages found at all")
            return []

        return sorted(found_pages)

    
    def _run_single_call(
    self,
    analysis_json: dict,
    search_term_start: str,
    search_term_end: str,
    ) -> List[int]:
        

        prompt = self._build_prompt(
            analysis_json=analysis_json,
            search_term_start=search_term_start,
            search_term_end=search_term_end,
        )
        # logger with searchterm start and end 
        logger.info(f"Selecting blocks with start term: {search_term_start} and end term: {search_term_end}")

        response = self.llm.generate(prompt)

        if self.config.debug_enabled:
            logger.debug(f"LLM Response: {response}")

        return self._parse_response(response)


    def _build_prompt(self, analysis_json: dict, search_term_start: str, search_term_end: str) -> str:
        return f"""

                    You are a deterministic document-structure reconstruction system.

                    IMPORTANT CONTEXT:
                    You are NOT analyzing document content.
                    You are analyzing a CORRUPTED TABLE OF CONTENTS extracted from a PDF.
                    All hierarchy, indentation and ordering may be broken.
                    Chapter titles and page numbers may appear in separate blocks.

                    TASK:
                    Reconstruct where the requested chapter is located in the document
                    based ONLY on table-of-contents evidence.

                    CHAPTER IDENTIFICATION:
                    - TARGET CHAPTER TITLE (start boundary):
                    "{search_term_start}"

                    - FOLLOWING CHAPTER TITLE (end boundary):
                    "{search_term_end}"

                    INTERPRETATION RULES (STRICT):
                    1. Treat all blocks as TOC candidates.
                    2. A chapter is identified ONLY by textual similarity to the given titles.
                    3. Page numbers are ONLY valid if they appear explicitly in the blocks.
                    4. Page numbers may appear:
                    - inside title text
                    - as standalone numeric blocks near a title
                    5. Ignore document body text. Assume NO chapter content is present.

                    BOUNDARY LOGIC:
                    - Determine the FIRST page number associated with the TARGET CHAPTER.
                    - Determine the FIRST page number associated with the FOLLOWING CHAPTER.

                    PAGE RANGE RULES:
                    - If BOTH boundaries are found:
                    Output all page numbers X where:
                        start_page ≤ X < end_page
                    - If ONLY the TARGET CHAPTER is found:
                    Output all page numbers X where:
                        X ≥ start_page
                    - If ONLY the FOLLOWING CHAPTER is found:
                    Output all page numbers X where:
                        X < end_page
                    - If NO boundary can be identified reliably:
                    Output nothing.

                    CRITICAL CONSTRAINTS:
                    - Use ONLY information explicitly present in the provided blocks
                    - Do NOT assume hierarchy or order
                    - Do NOT infer missing page numbers
                    - Do NOT guess chapter structure
                    - Do NOT use semantic knowledge about the topic
                    - This is a STRUCTURE reconstruction task, not a content task

                    OUTPUT FORMAT (STRICT):
                    - Output ONLY page numbers
                    - SINGLE LINE ONLY
                    - Separate numbers using "|"
                    - No spaces
                    - No text
                    - No JSON
                    - No explanations

                    DOCUMENT BLOCKS (CORRUPTED TABLE OF CONTENTS):
                    {json.dumps(analysis_json, ensure_ascii=False)}
                    

                """

    def _parse_response(self, response: str) -> List[int]:
        if not response:
            return []

        raw = response.strip()
        if not raw:
            return []

        # Split an | ODER Zeilenumbrüchen (auch gemischt)
        parts = re.split(r"[|\r\n]+", raw)

        pages: List[int] = []
        for part in parts:
            part = part.strip()
            if part.isdigit():
                pages.append(int(part))

        if self.config.debug_enabled:
            logger.info(f"Selected pages: {pages}")

        return sorted(set(pages))