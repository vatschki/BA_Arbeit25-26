import json
import re
from typing import List
from app.llm.base_client import BaseLLMClient

'''
Der BlockExtractor ist dafür verantwortlich, mithilfe eines Sprachmodells relevante Informationen aus Dokumentblöcken
auf Basis vorgegebener Anforderungen zu extrahieren. Als Eingabe erhält er ein gefiltertes JSON mit Dokumentblöcken
sowie ein JSON mit den Anforderungen. Daraus wird ein Prompt für das LLM erstellt, und die Antworten werden
anschließend verarbeitet, um Übereinstimmungen zwischen den Dokumentblöcken und den Anforderungen zu identifizieren.
Der Extraktionsprozess ist so gestaltet, dass auch große Dokumente verarbeitet werden können, indem die Blöcke in
Teilmengen (Chunks) verarbeitet werden. Zusätzlich werden ausführliche Debugging-Informationen bereitgestellt,
um die Größe und Struktur der Eingaben überwachen zu können. Das finale Ergebnis ist ein strukturiertes JSON,
das die gefundenen Anforderungen und die dazugehörigen Dokumentblöcke enthält, wobei eine Normalisierung und
Deduplizierung durchgeführt wird, um saubere Ergebnisse sicherzustellen.
'''

class BlockExtractor:

    def __init__(self, llm_client: BaseLLMClient):
        self.llm = llm_client

    def extract_values(
    self,
    filtered_json: dict,
    requirement_json: dict,
    ) -> dict:
        prompt = self._build_prompt(
            filtered_json=filtered_json,
            requirement_json=requirement_json,
        )

        MAX_BLOCKS_PER_CALL = 50

        blocks = filtered_json.get("blocks", [])
        if not blocks:
            raise ValueError("filtered_json contains no blocks")

        responses = []

        print(f"[EXTRACTOR] Total blocks: {len(blocks)}")
        print(f"[EXTRACTOR] Blocks per call: {MAX_BLOCKS_PER_CALL}")

        for i in range(0, len(blocks), MAX_BLOCKS_PER_CALL):
            block_chunk = blocks[i : i + MAX_BLOCKS_PER_CALL]

            filtered_json_chunk = {
                **filtered_json,
                "blocks": block_chunk,
            }

            prompt = self._build_prompt(
                filtered_json=filtered_json_chunk,
                requirement_json=requirement_json,
            )

            # ================= DEBUG =================
            doc_str = json.dumps(filtered_json_chunk, ensure_ascii=False)
            req_str = json.dumps(requirement_json, ensure_ascii=False)

            print("\n========== LLM INPUT DEBUG ==========")
            print(f"[DEBUG] Chunk blocks:           {i}–{i + len(block_chunk) - 1}")
            print(f"[DEBUG] document_blocks chars: {len(doc_str)}")
            print(f"[DEBUG] requirements chars:     {len(req_str)}")
            print(f"[DEBUG] full prompt chars:      {len(prompt)}")

            if len(prompt) > 60_000:
                print("[WARNING] Prompt is very large – high risk of truncation")

            print("\n========== END DEBUG ==========\n")
            # ========================================

            response = self.llm.generate(prompt)

            print("\n========== RAW LLM RESPONSE ==========\n")
            print(response)
            print("\n=====================================\n")

            responses.append(response)

        # Parsing / Merging bewusst noch nicht implementiert
        return self._build_final_json_response(responses)


    def _build_prompt(self, filtered_json: dict, requirement_json: dict) -> str:

        JSON_INPUT = {
            "document_blocks": filtered_json,
            "requirements": requirement_json,
        }

        return f"""

                    You are a deterministic sustainability requirement matching system.

                    GOAL:
                    Identify sustainability disclosure requirements that are explicitly and unambiguously
                    addressed in a report, based solely on the provided document text.

                    ABSOLUTE PRECISION POLICY:
                    - You MUST only include a requirement if there is clear, direct, and explicit evidence.
                    - If there is any uncertainty, ambiguity, or implicit reasoning, you MUST omit the requirement.
                    - Precision is strictly more important than completeness.

                    ────────────────────────────────────────────
                    DATA SOURCE ISOLATION (CRITICAL)
                    ────────────────────────────────────────────

                    The system receives TWO separate JSON inputs:

                    1) "requirements" JSON:
                    - Contains ESRS requirement codes, titles, paragraphs, and disclosure definitions.
                    - Defines WHAT qualifies as a requirement.

                    2) "document_blocks" JSON:
                    - Contains the report text blocks, block IDs, pages, headings, and structural roles.
                    - This is the ONLY permissible source of disclosure evidence.

                    STRICT CONSTRAINTS:
                    - All matching decisions MUST be based EXCLUSIVELY on the content of "document_blocks".
                    - You MUST NOT use external knowledge, assumptions, ESG expectations,
                    prior training data, or internet information.
                    - Requirement definitions describe WHAT to look for, but NEVER constitute evidence.

                    ────────────────────────────────────────────
                    DOCUMENT CONTEXT & BLOCK HANDLING
                    ────────────────────────────────────────────

                    DISCLOSURE CONTEXT DEFINITION:
                    - A disclosure context is defined by the most recent preceding block
                    that has a structural role indicating a heading or section title.
                    - Blocks without such a heading MUST inherit the disclosure context
                    of the closest preceding heading block.
                    - Consecutive blocks sharing the same inherited context form ONE single disclosure context.
                    - Evidence aggregation is permitted ONLY within the same disclosure context.
                    - Blocks MUST NOT be treated as independent disclosure topics
                    unless a new heading context is explicitly present.

                    ────────────────────────────────────────────
                    REQUIREMENT MATCHING LOGIC
                    ────────────────────────────────────────────

                    GENERAL MATCHING PRINCIPLE:
                    A requirement may be considered addressed ONLY IF:
                    - Explicit evidence exists within a single disclosure context, AND
                    - The evidence is direct, specific, and verifiable from the document_blocks alone.

                    MULTI-PARAGRAPH DISCLOSURES:
                    - A single disclosure context MAY fulfill multiple paragraph-level requirements ONLY IF:
                    - the exact paragraph identifiers are explicitly referenced in the text, OR
                    - the disclosure content for each paragraph is explicitly and independently present.

                    ────────────────────────────────────────────
                    PARAGRAPH EVIDENCE POLICY (REFERENCE-AWARE)
                    ────────────────────────────────────────────

                    Definitions:
                    - Reference-evidence: the text explicitly lists paragraph identifiers
                    (e.g. "(E4-1_13b, 13c, 13e)").
                    - Content-evidence: the disclosure content described by the requirement
                    is explicitly and unambiguously present in the text,
                    regardless of identifier mention.

                    A requirement may be matched if EITHER condition holds:

                    (A) Reference-evidence:
                    - The exact normalized paragraph identifier of the requirement
                    is explicitly listed in the text within the same disclosure context.

                    (B) Content-evidence:
                    - The requirement’s disclosure content is explicitly and unambiguously present.

                    Constraints:
                    - A paragraph identifier list constitutes evidence ONLY
                    for the identifiers explicitly listed.
                    - Mentioning a disclosure family (e.g. "E4-1") alone
                    is NOT evidence for any paragraph-level requirement.
                    - No inference beyond explicit references or explicit content is permitted.

                    ────────────────────────────────────────────
                    REQUIREMENT FAMILY BOUNDARIES
                    ────────────────────────────────────────────

                    FAMILY ISOLATION RULE:
                    - Requirements from different disclosure families MUST NOT be matched
                    based on thematic or semantic similarity.
                    - A requirement from another family may be matched ONLY IF:
                    - its exact paragraph identifier is explicitly referenced, OR
                    - its specific disclosure content is explicitly present
                        within the same disclosure context.
                    - Topic similarity NEVER overrides family boundaries.

                    ────────────────────────────────────────────
                    APPLICATION REQUIREMENTS (AR) — NON-BLOCKING
                    ────────────────────────────────────────────

                    APPLICATION REQUIREMENT HANDLING:
                    - Application Requirements (ARs) are NOT standalone requirements.
                    - ARs are treated as OPTIONAL ANNOTATIONS ONLY.
                    - ARs MUST NEVER:
                    - influence whether a primary ESRS requirement is considered matched,
                    - introduce additional conditions for matching,
                    - invalidate otherwise valid evidence,
                    - require verification of AR-specific disclosure content.

                    AR EXTRACTION RULE:
                    - If AR codes are explicitly mentioned in the same disclosure context
                    as a matched primary requirement,
                    they MAY be included in the output under "associated_requirements".
                    - If AR-specific content is not explicitly identifiable,
                    the ARs are simply omitted.
                    - The presence or absence of ARs MUST NOT affect
                    the matching decision for ESRS requirements.

                    ────────────────────────────────────────────
                    NORMALIZATION
                    ────────────────────────────────────────────

                    PARAGRAPH NORMALIZATION:
                    - Normalize paragraph identifiers by removing spaces and punctuation
                    (e.g. "13 d" → "13d").

                    ────────────────────────────────────────────
                    TASK
                    ────────────────────────────────────────────

                    For each requirement in "requirements":
                    1) Evaluate all disclosure contexts for valid reference-evidence
                    or content-evidence.
                    2) ONLY IF such evidence exists, create a match entry.
                    3) Collect ALL document blocks belonging to the same disclosure context
                    that directly support the match.
                    4) Include ARs ONLY as optional annotations
                    according to the AR handling rules above.

                    ────────────────────────────────────────────
                    OUTPUT FORMAT
                    ────────────────────────────────────────────

                    Return ONLY valid JSON in the following structure:

                    {{
                    "matches": [
                        {{
                        "report_requirement": "<requirements[i].code>",
                        "disclosure_requirement": "<requirements[i].disclosure_requirement>",
                        "paragraph": "<normalized requirements[i].paragraph>",
                        "title": "<requirements[i].title>",
                        "associated_requirements": ["<AR code>"],
                        "matched_blocks": [
                            {{
                            "block_id": <block_id>,
                            "page": <page_number>,
                            "text": "<original block text>"
                            }}
                        ]
                        }}
                    ]
                    }}

                    ────────────────────────────────────────────
                    FINAL CONSTRAINTS
                    ────────────────────────────────────────────

                    - If a requirement is not explicitly and unambiguously addressed,
                    it MUST NOT appear in the output.
                    - ARs MUST NEVER block or downgrade a valid ESRS paragraph match.
                    - Do NOT output explanations, comments, or text outside the JSON.

                    ────────────────────────────────────────────
                    INPUT DATA (AUTHORITATIVE)
                    ────────────────────────────────────────────

                    The following JSON is the ONLY data you may analyze.
                    It contains BOTH document blocks and requirements.
                    Do NOT assume any additional data.

                    {json.dumps(JSON_INPUT, ensure_ascii=False)}

                """

    
    def _build_final_json_response(self, responses: List[str]) -> dict:
        all_matches = []

        for idx, response in enumerate(responses):
            try:
                parsed = self._extract_json_from_response(response)
            except Exception as e:
                print(f"[ERROR] Failed to parse response {idx}: {e}")
                continue

            all_matches.extend(parsed.get("matches", []))

        normalized = self._normalize_matches(all_matches)

        return {
            "matches": self._deduplicate_matches(normalized)
        }



    def _extract_json_from_response(self, response: str) -> dict:
        response = response.strip()

        # Entferne Codefences
        response = re.sub(r"^```(?:json)?\s*", "", response)
        response = re.sub(r"\s*```$", "", response)

        try:
            return json.loads(response)
        except json.JSONDecodeError:
            pass

        # Fallback: balanced JSON extraction
        start = response.find("{")
        if start == -1:
            raise ValueError("No JSON object start found")

        stack = 0
        for i, char in enumerate(response[start:], start=start):
            if char == "{":
                stack += 1
            elif char == "}":
                stack -= 1
                if stack == 0:
                    return json.loads(response[start:i + 1])

        raise ValueError("No complete JSON object found")

    

    def _deduplicate_matches(self, matches: list) -> list:
        unique = {}

        for match in matches:
            block_ids = tuple(
                sorted(b["block_id"] for b in match.get("matched_blocks", []))
            )

            key = (
                match["report_requirement"],
                match.get("paragraph"),
                block_ids
            )

            if key not in unique:
                unique[key] = match
            else:
                # Merge associated_requirements defensiv
                existing = unique[key]
                existing_ar = set(existing.get("associated_requirements", []))
                new_ar = set(match.get("associated_requirements", []))
                existing["associated_requirements"] = sorted(existing_ar | new_ar)

        return list(unique.values())
    
    def _normalize_matches(self, matches: list) -> list:
        normalized = []

        for m in matches:
            if not isinstance(m, dict):
                continue

            # Pflichtfeld
            req = m.get("report_requirement")
            if not isinstance(req, str) or not req.strip():
                continue

            normalized.append({
                "report_requirement": req,
                "disclosure_requirement": m.get("disclosure_requirement"),
                "paragraph": m.get("paragraph"),
                "title": m.get("title"),
                "associated_requirements": (
                    m.get("associated_requirements")
                    if isinstance(m.get("associated_requirements"), list)
                    else []
                ),
                "matched_blocks": [
                    {
                        "block_id": b.get("block_id"),
                        "page": b.get("page"),
                        "text": b.get("text"),
                    }
                    for b in (m.get("matched_blocks") or [])
                    if isinstance(b, dict) and "block_id" in b
                ],
            })

        return normalized
