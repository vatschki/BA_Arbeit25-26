import argparse
import json
import os
import sys
import traceback
import logging
from datetime import datetime
from pydantic import ValidationError

from app.pipeline_runner import run_pipeline 
from app.schemas.pipeline import PipelineRequest

logging.basicConfig(
    level=logging.INFO,
    format="%(asctime)s [%(levelname)s] %(message)s",
    handlers=[
        logging.StreamHandler(sys.stdout)
    ]
)

logger = logging.getLogger(__name__)


def main():
    parser = argparse.ArgumentParser()
    parser.add_argument("--job-id", required=True)
    parser.add_argument("--jobs-root", required=True) 
    args = parser.parse_args()

    job_id = args.job_id
    job_dir = os.path.join(args.jobs_root, job_id)
    req_path = os.path.join(job_dir, "request.json")

    logger.info(f"Args received: {sys.argv}")
    logger.info(f"Job ID: {job_id}")
    logger.info(f"Jobs root: {args.jobs_root}")
    logger.info(f"Request path: {req_path}")

    try:
        if not os.path.exists(req_path):
            raise RuntimeError(f"request.json not found: {req_path}")

        with open(req_path, "r", encoding="utf-8") as f:
            raw_data = json.load(f)

        try:
            req = PipelineRequest(**raw_data)
        except ValidationError as e:
            write_status(job_dir, {
                "job_id": job_id,
                "step": "error",
                "percent": 100,
                "message": f"Validation error: {e}"
            })
            sys.exit(1)

        pdf_path = req.document.path

        # Initialstatus
        write_status(job_dir, {
            "job_id": job_id,
            "step": "starting",
            "percent": 1,
            "message": "Pipeline gestartet",
            "ts": datetime.utcnow().isoformat() + "Z",
        })

        # Hier rufst du deine Pipeline
        run_pipeline(
            pdf_path=req.document.path,
            job_id=job_id,
            requirement=req.requirement,
            context=req.context,
            api_config=req.api_config,
            jobs_root=args.jobs_root
        )

    except Exception as e:
        # Fehlerstatus + stacktrace optional
        write_status(job_dir, {
            "job_id": job_id,
            "step": "error",
            "percent": 100,
            "message": str(e),
            "ts": datetime.utcnow().isoformat() + "Z",
        })
        with open(os.path.join(job_dir, "error.log"), "w", encoding="utf-8") as f:
            f.write(traceback.format_exc())
        sys.exit(1)

def write_status(job_dir: str, payload: dict):
    os.makedirs(job_dir, exist_ok=True)
    path = os.path.join(job_dir, "status.json")
    with open(path, "w", encoding="utf-8") as f:
        json.dump(payload, f, ensure_ascii=False, indent=2)

if __name__ == "__main__":
    main()
