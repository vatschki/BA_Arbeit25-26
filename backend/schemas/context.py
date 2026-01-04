from pydantic import BaseModel

class Context(BaseModel):
    company_name: str
    year: int
    standard_code: str