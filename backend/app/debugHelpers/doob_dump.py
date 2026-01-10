from pathlib import Path
from typing import List, Dict, Any
import json
from datetime import datetime
import time
from app.services.doob_to_json import doob_to_json, write_output_json
import logging


def dump_json_debug(
    doob_document,
    job_id: str,
    company_name: str,
    name: str,
    output_dir: str = "debug",

):
    output_path = Path(output_dir)
    output_path.mkdir(parents=True, exist_ok=True)

    final_json = doob_to_json(doob_document, job_id, company_name)

    write_output_json(
        final_json=final_json,
        output_dir=output_dir,
        filename=f"{job_id}_{name}.json"
    )


def dump_requirements_debug(
    requirements_json: List[Dict[str, Any]],
    job_id: str,
    name: str,
    output_dir: str = "debug",
):
    output_path = Path(output_dir)
    output_path.mkdir(parents=True, exist_ok=True)

    write_output_json(
        final_json=requirements_json,
        output_dir=output_dir,
        filename=f"{job_id}_{name}_requirements.json",
    )




def cleanup_debug_dir(ttl_hours: int = 24):
    cutoff = time.time() - ttl_hours * 3600
    for file in Path("debug").glob("*.json"):
        if file.stat().st_mtime < cutoff:
            file.unlink()
