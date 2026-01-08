from pathlib import Path
from typing import List, Union
import logging
from unstructured.partition.pdf import partition_pdf
from unstructured.documents.elements import Element

from app.pdf_parsing.schema.extensions import FileExtensionType
from app.pdf_parsing.validation_filtering.clean_up import Filter

logger = logging.getLogger(__name__)
logging.basicConfig(level=logging.INFO, format='%(asctime)s - %(levelname)s - %(message)s')

class Loader:
   
    def load(
        self,
        file_path: Union[str, Path],
        file_extension: FileExtensionType
    ) -> List[Element]:

        if isinstance(file_path, Path):
            file_path = str(file_path)
        
        elements: List[Element] = partition_pdf(
            filename=file_path,
            strategy="fast",
            infer_table_structure=True,
        )
        logging.info(f"Anzahl der geladenen Elemente vor der Bereinigung: {len(elements)}")
        f = Filter()
        filtered_elements = f.filter_elements_partition_pdf(elements)
        logging.info(f"Anzahl der geladenen Elemente nach der clean_up: {len(filtered_elements)}")
        return filtered_elements
