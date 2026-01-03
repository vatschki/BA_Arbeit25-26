from fastapi import APIRouter
from schemas.pipeline import PipelineRequest
from services.pipeline_services import start_pipeline

router = APIRouter(
    prefix="/pipeline",
    tags=["pipeline"]
)

@router.post("/start")
async def pipeline_start(req: PipelineRequest):
    return start_pipeline(req)
