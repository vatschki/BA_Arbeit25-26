import os
import uuid
from fastapi import HTTPException
from pipeline_runner import run_pipeline
from schemas.pipeline import PipelineRequest

def start_pipeline(req: PipelineRequest):
    pdf_path = req.document.path

    if not os.path.exists(pdf_path):
        raise HTTPException(
            status_code=404,
            detail=f"PDF nicht gefunden: {pdf_path}"
        )

    job_id = str(uuid.uuid4())

    run_pipeline(
        pdf_path=pdf_path,
        requirement=req.requirement,
        context=req.context,
        job_id=job_id
    )

    return {
        "status": "ok",
        "job_id": job_id
    }
