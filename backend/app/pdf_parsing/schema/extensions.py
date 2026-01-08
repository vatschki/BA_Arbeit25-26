from enum import Enum

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
