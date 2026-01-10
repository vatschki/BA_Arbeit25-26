from fastapi import FastAPI, HTTPException, BackgroundTasks
from pydantic import BaseModel
from typing import Dict, Any
import uuid
import os
import json

from app.pipeline_runner import run_pipeline
from app.schemas.pipeline import PipelineRequest

# -----------------------------
# Endpoint
# -----------------------------

app = FastAPI()

@app.post("/pipeline/start")
async def pipeline_start(
    req: PipelineRequest,
    background_tasks: BackgroundTasks
):
    pdf_path = req.document.path

    # --- Validierung ---
    if req.document.type.lower() != "pdf":
        raise HTTPException(status_code=400, detail="Nur PDF-Dateien erlaubt")

    if not os.path.exists(pdf_path):
        raise HTTPException(
            status_code=404,
            detail={"error": "PDF nicht gefunden", "path": pdf_path}
        )

    # --- Job ---
    job_id = str(uuid.uuid4())

    # --- Asynchron starten ---
    background_tasks.add_task(
        run_pipeline,
        pdf_path=pdf_path,
        job_id=job_id,
        requirement=req.requirement,
        context=req.context,
        api_config=req.api_config
    )

    return {
        "job_id": job_id,
        "status": "started"
    }

@app.get("/pipeline/status/{job_id}")
def pipeline_status(job_id: str):
    path = f"storage/jobs/{job_id}/status.json"

    if not os.path.exists(path):
        return {
            "job_id": job_id,
            "step": "starting",
            "percent": 0,
            "message": "Pipeline wird initialisiert"
        }
    
    with open(path, "r", encoding="utf-8") as f:
        return json.load(f)
