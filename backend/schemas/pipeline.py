from pydantic import BaseModel
from schemas.document import Document
from schemas.requirement import Requirement
from schemas.context import Context

class PipelineRequest(BaseModel):
    document: Document
    requirement: Requirement
    context: Context
    api_config: dict
