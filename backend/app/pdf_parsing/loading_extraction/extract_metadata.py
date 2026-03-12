from typing import Any, Dict, Optional
from unstructured.documents.elements import Element

'''
Die Klasse MetadataExtractor ist dafür verantwortlich, relevante Metadaten aus einem gegebenen Element zu extrahieren.
Sie berücksichtigt dabei sowohl die Basis-Metadaten, die in einem möglichen "metadata"-Attribut des Elements enthalten
sein können, als auch direkte Informationen aus dem Element selbst. Die extrahierten Metadaten umfassen unter anderem
Dateiinformationen, Koordinaten, Sprachen, Seitenzahlen und Kategorietiefe. Zusätzlich werden spezifische Informationen
für bestimmte Elementtypen wie Bilder und Tabellen berücksichtigt. Die Klasse ermöglicht es, diese Metadaten in einem
strukturierten Format zurückzugeben, um sie in weiteren Verarbeitungsschritten oder Analysen zu verwenden.
'''


class MetadataExtractor:
    BASE_FIELDS = (
        "file_name",
        "file_directory",
        "last_modified",
        "filetype",
        "coordinates",
        "parent_id",
        "languages",
    )

    def __init__(self, company: str | None = None) -> None:
        self.company = company

    def extract_metadata(
        self,
        element: Element,
        normalized_type: str,
    ) -> tuple[Dict[str, Any], Optional[tuple[int, int]], int]:

        metadata_obj = getattr(element, "metadata", None)
        metadata: Dict[str, Any] = {}

        # Basis-Metadaten
        if metadata_obj is not None:
            for field in self.BASE_FIELDS:
                value = getattr(metadata_obj, field, None)
                if value is not None:
                    metadata[field] = value

        # page_number
        page_number: Optional[int] = None
        if metadata_obj is not None:
            pn = getattr(metadata_obj, "page_number", None)
            if pn is not None:
                page_number = pn
                metadata["page_number"] = pn

        # category_depth
        category_depth = 0
        if metadata_obj is not None and hasattr(metadata_obj, "category_depth"):
            category_depth = getattr(metadata_obj, "category_depth") or 0
        elif hasattr(element, "category_depth"):
            category_depth = getattr(element, "category_depth", 0) or 0

        #page_range
        page_range: Optional[tuple[int, int]] = None
        if page_number is not None:
            page_range = (page_number, page_number)

        metadata["category_depth"] = category_depth
        if page_range is not None:
            metadata["page_range"] = page_range

        #direkte Infos
        text = getattr(element, "text", "") or ""
        metadata["text_len"] = len(text)
        metadata["category"] = getattr(element, "category", None)
        metadata["element_type"] = type(element).__name__

        if self.company is not None:
            metadata["company"] = self.company

        #Image
        if normalized_type == "Image":
            if metadata_obj is not None:
                mime = getattr(metadata_obj, "image_mime_type", None)
                if mime:
                    metadata["image_mime_type"] = mime
        
        #Table
        if normalized_type == "Table":
            text_as_html = getattr(element, "text_as_html", None)

            if text_as_html is None and metadata_obj is not None:
                text_as_html = getattr(metadata_obj, "text_as_html", None)

            if text_as_html:
                metadata["text_as_html"] = text_as_html

        return metadata, page_range, category_depth
