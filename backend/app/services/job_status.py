import json
import os
import time
import logging

logger = logging.getLogger(__name__)

def update_status(
    job_id: str,
    step: str,
    percent: int,
    message: str,
    jobs_root: str
):
    job_dir = os.path.join(jobs_root, job_id)
    os.makedirs(job_dir, exist_ok=True)

    status = {
        "job_id": job_id,
        "step": step,
        "percent": percent,
        "message": message,
        "updated_at": time.time()
    }

    status_path = os.path.join(job_dir, "status.json")

    with open(status_path, "w", encoding="utf-8") as f:
        json.dump(status, f, ensure_ascii=False, indent=2)
