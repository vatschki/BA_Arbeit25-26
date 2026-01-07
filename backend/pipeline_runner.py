import logging
from pathlib import Path
from typing import Dict
from schemas.context import Context
from schemas.api_config import ApiConfig
from schemas.requirement import Requirement
from pdf_parsing.parser_manager import Parser 
from pdf_parsing.schema.extensions import FileExtensionType


logger = logging.getLogger(__name__)

def run_pipeline(
    pdf_path: str,
    job_id: str,
    requirement: Requirement,
    context: Context,
    api_config: ApiConfig
):
    logger.info(f"[JOB {job_id}] Pipeline gestartet")
    logger.info(f"[JOB {job_id}] PDF: {pdf_path}")

    # 1. Kontext validieren
    if context is None or context.company_name is None:
        raise ValueError("context.company_name ist erforderlich für den Parser")

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

    logger.info(
        f"[JOB {job_id}] Parsing abgeschlossen | Blocks: {len(doob_document.content)}"
    )

    return {
        "message": "Pipeline Dummy ausgeführt",
        "job_id": job_id
    }
