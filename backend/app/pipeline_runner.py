import logging
from pathlib import Path
from typing import Dict
from app.schemas.context import Context
from app.schemas.api_config import ApiConfig
from app.schemas.requirement import Requirement
from app.pdf_parsing.parser_manager import Parser 
from app.pdf_parsing.schema.extensions import FileExtensionType
from app.debugHelpers.doob_dump import dump_json_debug, cleanup_debug_dir, dump_requirements_debug, write_output_json
from app.config import Config
from app.llm.block_selector import BlockSelector
from app.llm.block_extractor import BlockExtractor
from app.llm.llm_client_manager import LLMClientManager
from app.services.doob_to_json import doob_to_json_blocklimit, doob_to_json, requirements_to_json, make_flat_result_json
from app.services.doob_filtering import filter_doob_by_category, filter_doob_by_pages
from app.services.job_status import update_status
from app.integrations.ci4_client import CI4Client
from app.services.storage_cleanup import limit_job_storage, limit_debug_jobs


logger = logging.getLogger(__name__)

def run_pipeline(
    pdf_path: str,
    job_id: str,
    requirement: dict,
    context: Context,
    api_config: ApiConfig
):
    
    try:
        config = Config.load()

        job_dir = Path(f"storage/jobs/{job_id}")
        job_dir.mkdir(parents=True, exist_ok=True)
        update_status(job_id, step="starting", percent=0, message="Pipeline gestartet")

        debug_mode = config.debug_enabled
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
        page_numbers = None
        if context.relevant_pages:
            page_numbers = context.relevant_pages
            logger.info(f"[JOB {job_id}] --------------------- User-defined relevant pages: {page_numbers}")

        try:
            doob_document = parser.toBlock(
                file_path=Path(pdf_path),
                file_extension=FileExtensionType.PDF,
                page_numbers=None # Filterung nach Seitanzahlen von anfang an Fehlgeschlagen. Kan später umgesetzt werden deswegen nur None 
            )
        except ValueError as e:
            # === NOT COMPATIBLE CALLBACK ===
            logger.warning(f"[JOB {job_id}] PDF nicht kompatibel: {e}")

            update_status(
                job_id,
                step="not_compatible",
                percent=100,
                message=str(e)
            )

            try:
                ci4 = CI4Client(
                    base_url=config.base_url,
                    pipeline_secret=config.pipeline_secret
                )
                ci4.send_pipeline_result(
                    job_id=job_id,
                    status="not_compatible",
                    progress=100,
                    message=str(e),
                    result=None
                )
            except Exception:
                logger.exception(f"[JOB {job_id}] CI4 not_compatible callback fehlgeschlagen")

            return {
                "job_id": job_id,
                "status": "not_compatible",
            }

        

        update_status(job_id, "pdf_parsed", 20, "PDF analysiert")

        
        if debug_mode:
            dump_json_debug(
                doob_document=doob_document,
                job_id=job_id,
                company_name=context.company_name,
                name="doob"
            )
        
        analysis_json = None
        analysis_json = doob_to_json(
            doob=doob_document,
            job_id=job_id,
            company_name=context.company_name,
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
        SEARCH_TERM_START = f"{context.main_standard_code} , {context.main_standard_name} , {context.main_standard_description} , {context.main_standard_description_eng}"
        SEARCH_TERM_END = f"{context.second_standard_code} , {context.second_standard_name} , {context.second_standard_description} , {context.second_standard_description_eng}"

        if context.relevant_pages and len(context.relevant_pages) > 0:
            logger.info(f"[JOB {job_id}] Using user-defined relevant pages for selection.")

            relevant_pages = context.relevant_pages
            update_status(job_id, "user_page_selection_done", 40, "Vom User vorgegebene Seiten verwendet")

        else:
            selector = BlockSelector(llm_client, config)
            relevant_pages = selector.select_blocks_iterative(
                analysis_json=analysis_json,
                search_term_start=SEARCH_TERM_START,
                search_term_end=SEARCH_TERM_END,
            )

            if not relevant_pages:
                logger.warning(f"[JOB {job_id}] No relevant pages found for selection")

                update_status(
                    job_id,
                    step="no_match",
                    percent=100,
                    message="In dem Dokument konnten keine passenden Textstellen zu den gewählten Standards gefunden werden."
                )

                # ---------- ERROR / NO-MATCH CALLBACK ----------
                try:
                    ci4 = CI4Client(
                        base_url=config.base_url,
                        pipeline_secret=config.pipeline_secret
                    )
                    ci4.send_pipeline_result(
                        job_id=job_id,
                        status="no_match",
                        progress=100,
                        message="In dem Dokument konnten keine passenden Textstellen zu den gewählten Standards gefunden werden.",
                        result=[]
                    )
                except Exception:
                    logger.exception(f"[JOB {job_id}] CI4 no-match callback fehlgeschlagen")

                return {
                    "job_id": job_id,
                    "status": "no_match",
                }

        

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
        requirement_json = requirements_to_json(requirement)

        if debug_mode:
            dump_requirements_debug(
                requirements_json=requirement_json,
                job_id=job_id,
                name="requirement_json"
            )
        
        extractor = BlockExtractor(llm_client)

        extracted_result = extractor.extract_values(
            filtered_json=filtered_json,
            requirement_json=requirement_json
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

        result_json = make_flat_result_json(
            result_json=extracted_result,
            job_id=job_id,
            company_name=context.company_name
        )
        
        update_status(job_id, "result_ready", 95, "Ergebnis bereit")

        if debug_mode:
            write_output_json(
                final_json=result_json,
                output_dir=f"debug/{job_id}",
                filename="final_result.json"
            )
        
        update_status(job_id, "finished", 100, "Pipeline abgeschlossen")

        # ---------- SUCCESS CALLBACK ----------
        try:
            ci4 = CI4Client(
                base_url=config.base_url,
                pipeline_secret=config.pipeline_secret
            )
            ci4.send_pipeline_result(
                job_id=job_id,
                status="finished",
                progress=100,
                message="Pipeline abgeschlossen",
                result=result_json['results']
            )
        except Exception:
            logger.exception(f"[JOB {job_id}] CI4 success callback fehlgeschlagen")

        return {
            "job_id": job_id,
            "status": "finished",
        }
        
    except Exception as e:
        # ==================================
        # ERROR HANDLING
        # ==================================
        logger.exception(f"[JOB {job_id}] Pipeline fehlgeschlagen")

        update_status(
            job_id,
            step="error",
            percent=100,
            message=str(e)
        )

        limit_job_storage(config.max_jobs)
        limit_debug_jobs(config.max_debug_jobs)

        # ---------- ERROR CALLBACK ----------
        try:
            ci4 = CI4Client(
                base_url=config.base_url,
                pipeline_secret=config.pipeline_secret
            )
            ci4.send_pipeline_result(
                job_id=job_id,
                status="error",
                progress=100,
                message=str(e),
                result=None
            )
        except Exception:
            logger.exception(f"[JOB {job_id}] CI4 error callback fehlgeschlagen")

        return {
            "job_id": job_id,
            "status": "error",
        }

