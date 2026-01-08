from pydantic import BaseModel

class Context(BaseModel):
    company_name: str
    year: str

    main_standard_code: str
    main_standard_name: str
    main_standard_description: str
    main_standard_description_eng: str

    second_standard_code: str
    second_standard_name: str
    second_standard_description: str
    second_standard_description_eng: str
