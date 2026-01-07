from fastapi import FastAPI, HTTPException
from pydantic import BaseModel
from typing import Dict, Any
import uuid
import os

from pipeline_runner import run_pipeline
from schemas.pipeline import PipelineRequest

# -----------------------------
# Endpoint
# -----------------------------

app = FastAPI()

@app.post("/pipeline/start")
async def pipeline_start(req: PipelineRequest):
    pdf_path = req.document.path

    # Sicherheitschecks
    if req.document.type.lower() != "pdf":
        raise HTTPException(status_code=400, detail="Nur PDF-Dateien erlaubt")

    if not os.path.exists(pdf_path):
        raise HTTPException(
            status_code=404,
            detail={
                "error": f"PDF nicht gefunden",
                "path": pdf_path}
        )

    # Job-ID generieren
    job_id = str(uuid.uuid4())

    # Dummy-Pipeline starten
    run_pipeline(
        pdf_path=pdf_path,
        job_id=job_id,
        requirement=req.requirement,
        context=req.context,
        api_config=req.api_config
    )

    return {
        "job_id": job_id
    }
