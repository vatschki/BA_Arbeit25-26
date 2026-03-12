from pydantic import BaseModel
from typing import List, Optional

'''
Schema für den Kontext, der für die Anforderungserstellung verwendet wird.
Es enthält Informationen über das Unternehmen, das Jahr, die relevanten Standards und die Seitenzahlen,
die für die Anforderungserstellung relevant sind.
'''

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

    relevant_pages: Optional[List[int]] = None
