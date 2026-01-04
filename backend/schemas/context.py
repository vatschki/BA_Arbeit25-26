from pydantic import BaseModel

class Context(BaseModel):
    company_name: str
    year: str
    standard_code: str