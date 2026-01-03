from pydantic import BaseModel

class Document(BaseModel):
    path: str
    filename: str
    type: str
