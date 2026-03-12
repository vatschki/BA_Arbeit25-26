import json
import os
import time

BASE_PATH = "storage/jobs"

'''
Dieses Modul bietet Funktionen zur Verwaltung des Status von Jobs, die in einem Verzeichnis gespeichert werden.
'''

def update_status(job_id: str, step: str, percent: int, message: str):
    os.makedirs(f"{BASE_PATH}/{job_id}", exist_ok=True)

    status = {
        "job_id": job_id,
        "step": step,
        "percent": percent,
        "message": message,
        "updated_at": time.time()
    }

    with open(f"{BASE_PATH}/{job_id}/status.json", "w", encoding="utf-8") as f:
        json.dump(status, f, ensure_ascii=False, indent=2)
