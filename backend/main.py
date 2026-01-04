from fastapi import FastAPI, HTTPException
from pydantic import BaseModel
from typing import Dict, Any
import uuid
import os

from pipeline_runner import run_pipeline

app = FastAPI()


# -----------------------------
# Request Models (passend zu CI4)
# -----------------------------

class DocumentModel(BaseModel):
    path: str
    filename: str
    type: str


class RequirementModel(BaseModel):
    id: int
    code: str
    title: str
    data_type: str


class ContextModel(BaseModel):
    company_name: str
    year: str
    standard_code: str


class PipelineRequest(BaseModel):
    document: DocumentModel
    requirement: RequirementModel
    context: ContextModel
    api_config: Dict[str, Any]


# -----------------------------
# Endpoint
# -----------------------------

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
