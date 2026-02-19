from pydantic import BaseModel
from typing import List
from app.schemas.document import Document
from app.schemas.requirement import Requirement
from app.schemas.context import Context
from app.schemas.api_config import ApiConfig

class PipelineRequest(BaseModel):
    document: Document
    requirement: List[Requirement]
    context: Context
    api_config: ApiConfig
