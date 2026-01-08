import logging
from pathlib import Path
from typing import Dict
from app.schemas.context import Context
from app.schemas.api_config import ApiConfig
from app.schemas.requirement import Requirement
from app.pdf_parsing.parser_manager import Parser 
from app.pdf_parsing.schema.extensions import FileExtensionType
from app.debugHelpers.doob_dump import dump_json_debug, cleanup_debug_dir
from app.config import Config
from app.llm.block_selector import BlockSelector
from app.llm.llm_client_manager import LLMClientManager
from app.services.doob_to_json import doob_to_json_blocklimit, doob_to_json
from app.services.doob_filtering import filter_doob_by_category, filter_doob_by_pages
from app.services.job_status import update_status


logger = logging.getLogger(__name__)

def run_pipeline(
    pdf_path: str,
    job_id: str,
    requirement: dict,
    context: Context,
    api_config: ApiConfig
):
    debug_mode = Config().debug_enabled
    logger.info(f"Debug mode: {debug_mode}")
    logger.info(f"[JOB {job_id}] Pipeline gestartet")
    logger.info(f"[JOB {job_id}] PDF: {pdf_path}")

    # 1. Kontext validieren
    if context is None or context.company_name is None:
        raise ValueError("context.company_name ist erforderlich für den Parser")
    
    provider = api_config.provider_name
    model_name = api_config.model_name
    api_key = api_config.api_key

    # LLM Client
    llm_client = LLMClientManager.create(
        provider=provider,
        model_name=model_name,
        api_key=api_key
    )
    
    # 2. Parser initialisieren
    parser = Parser(
        company=context.company_name
    )

    logger.info(f"[JOB {job_id}] Parser initialisiert für Firma: {context.company_name}")

    # 3. PDF parsen
    doob_document = parser.toBlock(
        file_path=Path(pdf_path),
        file_extension=FileExtensionType.PDF
    )

    update_status(job_id, "pdf_parsed", 20, "PDF analysiert")

    if debug_mode:
        dump_json_debug(
            doob_document=doob_document,
            job_id=job_id,
            company_name=context.company_name,
            name="doob"
        )
    
    analysis_json = None
    analysis_json = doob_to_json_blocklimit(
        doob=doob_document,
        job_id=job_id,
        company_name=context.company_name,
        blocklimit=90
    )

    if debug_mode:
        logger.info(f"[JOB {job_id}] Debug: Doob JSON dump completed.")
        dump_json_debug(
            doob_document=doob_document,
            job_id=job_id,
            company_name=context.company_name,
            name="analysis"
        )


    #4. Erster LLM Call Selection
    selector = BlockSelector(llm_client)
    SEARCH_TERM_START = f"{context.main_standard_code} , {context.main_standard_name} , {context.main_standard_description} , {context.main_standard_description_eng}"
    SEARCH_TERM_END = f"{context.second_standard_code} , {context.second_standard_name} , {context.second_standard_description} , {context.second_standard_description_eng}"

    relevant_pages = selector.select_blocks(
        json=analysis_json,
        search_term_start=SEARCH_TERM_START,
        search_term_end=SEARCH_TERM_END,
    )

    update_status(job_id, "llm_block_selection_done", 40, "Relevante Seiten ausgewählt")

    #5. Filtern der relevanten Blöcke
    filtered_json=None

    filtered_doob = filter_doob_by_pages(
        doob=doob_document,
        pages=relevant_pages
    )
    filtered_doob = filter_doob_by_category(
        doob=filtered_doob,
    )
    filtered_json = doob_to_json(
        doob=filtered_doob,
        job_id=job_id,
        company_name=context.company_name,
    )

    update_status(job_id, "block_filtering", 60, "Relevante Blöcke gefiltert")

    if debug_mode:
        dump_json_debug(
            doob_document=filtered_doob,
            job_id=job_id,
            company_name=context.company_name,
            name="filtered_doob"
        )
    
    # Zweiter LLM Call Extraction

    # muss noch überprüft und gerichtet werden 
    requirement_json = requirement

    extractor = BlockSelector(llm_client)

    extracted_result = extractor.extract_values(
        json=filtered_json,
        requirement=requirement_json
    )

    update_status(job_id, "llm_block_extraction_done", 85, "Requirements extrahiert")

    if debug_mode:
        dump_json_debug(
            doob_document=filtered_doob,
            job_id=job_id,
            company_name=context.company_name,
            name="extracted_result"
        )

    #Alle wichtigen infos ausgeben
    logger.info(
        f"[JOB {job_id}] Pipeline abgeschlossen | Blocks: {len(doob_document.content)}"
        f" | Filtered Blocks: {len(filtered_doob.content)}"
        f" | Extracted Items: {len(extracted_result)}"

    )

    update_status(job_id, "finished", 100, "Pipeline abgeschlossen")

    return {
        "message": "Pipeline Dummy ausgeführt",
        "job_id": job_id,
        "result": extracted_result
    }
