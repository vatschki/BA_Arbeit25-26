from pydantic import BaseModel

'''
Schema für die Anforderung, die für die Anforderungserstellung verwendet wird.
Es enthält Informationen über die ID, den Code, den Titel und den Datentyp der Anforderung,
die für die Anforderungserstellung relevant sind.
'''

class Requirement(BaseModel):
    id: int
    code: str
    title: str
    data_type: str | None = None
