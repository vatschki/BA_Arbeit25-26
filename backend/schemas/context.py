from pydantic import BaseModel

class Context(BaseModel):
    company_id: int
    year: int
    standard_id: int