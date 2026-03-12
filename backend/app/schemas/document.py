from pydantic import BaseModel

'''
Schema für Dokumentinformationen, die für die Anforderungserstellung verwendet werden.
Es enthält Informationen über den Pfad, den Dateinamen und den Typ des Dokuments, die für die
Anforderungserstellung relevant sind.
'''

class Document(BaseModel):
    path: str
    filename: str
    type: str
