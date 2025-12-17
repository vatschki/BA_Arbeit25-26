from fastapi import FastAPI
from pydantic import BaseModel
import uuid
import os

from pipeline_runner import run_pipeline

app = FastAPI()

class PipelineRequest(BaseModel):
    pdf_path: str
    company_id: int | None = None
    year: int | None = None
    standard_id: int | None = None
    requirement_id: int | None = None

@app.post("/pipeline/start")
async def pipeline_start(req: PipelineRequest):

    # Sicherheitschecks
    if not os.path.exists(req.pdf_path):
        return {
            "status": "error",
            "message": "PDF nicht gefunden: " + req.pdf_path
        }

    # Job-ID generieren
    job_id = str(uuid.uuid4())

    # Pipeline starten
    result = run_pipeline(req.pdf_path, job_id=job_id)

    return {
        "status": "ok",
        "job_id": job_id,
        "result": result
    }
