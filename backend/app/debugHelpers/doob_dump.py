from pathlib import Path
from typing import List, Dict, Any
import json
from datetime import datetime
import time
from app.services.doob_to_json import doob_to_json, write_output_json
import logging

'''
Dieses Modul stellt Hilfsfunktionen bereit, um Doob-Dokumente und Anforderungen zu Debugging-Zwecken in JSON-Dateien
zu exportieren. Die exportierten Dateien werden in einem „debug“-Verzeichnis gespeichert und nach Job-ID organisiert.
Jede Datei wird mit der Job-ID und einem beschreibenden Namen benannt, sodass ihr Inhalt leicht identifiziert werden
kann. Das Modul enthält außerdem eine Bereinigungsfunktion, die alte Debug-Dateien nach Ablauf einer festgelegten
Lebensdauer (TTL) entfernt.
'''
def dump_json_debug(
    doob_document,
    job_id: str,
    company_name: str,
    name: str,
    output_dir: str = "debug",

):
    output_path = Path(output_dir) / job_id
    output_path.mkdir(parents=True, exist_ok=True)

    final_json = doob_to_json(doob_document, job_id, company_name)

    write_output_json(
        final_json=final_json,
        output_dir=output_path,
        filename=f"{job_id}_{name}.json"
    )


def dump_requirements_debug(
    requirements_json: List[Dict[str, Any]],
    job_id: str,
    name: str,
    output_dir: str = "debug",
):
    output_path = Path(output_dir) / job_id
    output_path.mkdir(parents=True, exist_ok=True)

    write_output_json(
        final_json=requirements_json,
        output_dir=output_path,
        filename=f"{job_id}_{name}_requirements.json",
    )




def cleanup_debug_dir(ttl_hours: int = 24):
    cutoff = time.time() - ttl_hours * 3600
    for file in Path("debug").glob("*.json"):
        if file.stat().st_mtime < cutoff:
            file.unlink()
