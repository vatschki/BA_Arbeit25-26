from pydantic import BaseModel
from app.schemas.document import Document
from app.schemas.requirement import Requirement
from app.schemas.context import Context

class PipelineRequest(BaseModel):
    document: Document
    requirement: Requirement
    context: Context
    api_config: dict
