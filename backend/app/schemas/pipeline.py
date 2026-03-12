from pydantic import BaseModel
from typing import List
from app.schemas.document import Document
from app.schemas.requirement import Requirement
from app.schemas.context import Context
from app.schemas.api_config import ApiConfig

'''
Schema für die Anforderung, die an die Pipeline übergeben wird.
Es enthält Informationen über das Dokument, die Anforderungen, den Kontext und die API-Konfiguration, die
für die Anforderungserstellung relevant sind.
'''

class PipelineRequest(BaseModel):
    document: Document
    requirement: List[Requirement]
    context: Context
    api_config: ApiConfig
