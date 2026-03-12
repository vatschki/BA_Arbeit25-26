from pathlib import Path
from typing import List, Union
import logging
import fitz
from unstructured.partition.pdf import partition_pdf
from unstructured.documents.elements import Element

from app.pdf_parsing.schema.extensions import FileExtensionType
from app.pdf_parsing.validation_filtering.clean_up import Filter

logger = logging.getLogger(__name__)
logging.basicConfig(level=logging.INFO, format='%(asctime)s - %(levelname)s - %(message)s')

'''
Die Klasse Loader ist verantwortlich für das Laden von PDF-Dokumenten und die Extraktion von Elementen daraus.
'''

class Loader:
   
    def load(
        self,
        file_path: Union[str, Path],
        file_extension: FileExtensionType,
        page_numbers: List[int] | None = None
    ) -> List[Element]:

        if isinstance(file_path, Path):
            file_path = str(file_path)

        if not self._pdf_is_text_extractable(file_path):
            raise ValueError("PDF enthält keinen extrahierbaren Unicode-Text.")
        
        elements: List[Element] = partition_pdf(
            filename=file_path,
            strategy="fast",
            infer_table_structure=True,
            page_numbers=page_numbers
        )
        logging.info(f"Anzahl der geladenen Elemente vor der Bereinigung: {len(elements)}")
        f = Filter()
        filtered_elements = f.filter_elements_partition_pdf(elements)
        logging.info(f"Anzahl der geladenen Elemente nach der clean_up: {len(filtered_elements)}")
        return filtered_elements
    
    def _pdf_is_text_extractable(self, path: str, sample_pages: int = 3) -> bool:
        doc = fitz.open(path)
        n = len(doc)
        if n == 0:
            return False

        indices = {0, n // 2, n - 1}
        indices = list(indices)[:sample_pages]

        texts = []
        for i in indices:
            t = doc[i].get_text()
            if t:
                texts.append(t)

        combined = " ".join(texts).strip()
        if not combined:
            return False

        if "(cid:" in combined:
            return False

        letters = sum(c.isalpha() for c in combined)
        digits = sum(c.isdigit() for c in combined)
        spaces = sum(c.isspace() for c in combined)
        total = len(combined)

        if total == 0:
            return False

        ratio_letters = letters / total
        ratio_spaces = spaces / total

        if ratio_letters < 0.4:
            return False

        if ratio_spaces < 0.05:
            return False

        return True
