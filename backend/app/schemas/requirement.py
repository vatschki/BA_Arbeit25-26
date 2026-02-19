from pydantic import BaseModel

class Requirement(BaseModel):
    id: int
    code: str
    title: str
    data_type: str | None = None
