from pathlib import Path
from typing import Optional, Union

from pdf_parsing.schema.extensions import FileExtensionType


class Validator:

    supported_extensions = [
        FileExtensionType.PDF
    ]

    def validate_data(
        self,
        file_path: Union[Path, str, None] = None,
        file_extension: Optional[Union[str, FileExtensionType]] = None,
    ) -> FileExtensionType:

        if file_path is None:
            raise ValueError("Es wurde kein Dateipfad angegeben.")
        
        if isinstance(file_path, str):
            file_path = Path(file_path)

        if not file_path.exists():
            raise FileNotFoundError(f"Datei nicht gefunden: {file_path}")

        if file_extension is None:
            file_extension = file_path.suffix
       
        if isinstance(file_extension, str):
            try:
                file_extension = FileExtensionType(file_extension)
            except ValueError:
                raise ValueError(f"Die Dateiendung '{file_extension}' wird nicht unterstützt.")

        if file_extension not in self.supported_extensions:
            raise ValueError(
                f"Die Dateiendung '{file_extension.value}' wird nicht unterstützt."
            )

        return file_extension
