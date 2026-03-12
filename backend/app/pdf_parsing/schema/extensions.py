from enum import Enum

'''
Dieses Modul definiert das Enum FileExtensionType, das unterstützte Dateiendungen und ihre entsprechenden
MIME-Typen für das Parsen von PDF-Dateien repräsentiert.
'''

class FileExtensionType(str, Enum):
    def __new__(cls, value: str, mimetype: str):
        obj = str.__new__(cls, value)
        obj._value_ = value
        obj._mimetype = mimetype
        return obj

    @property
    def mimetype(self) -> str:
        return self._mimetype

    PDF = (".pdf", "application/pdf")
