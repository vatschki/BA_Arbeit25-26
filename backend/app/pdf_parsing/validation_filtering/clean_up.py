from unstructured.documents.elements import Element
import re
from typing import List
import logging


class Filter:

    def filter_elements_partition_pdf(self, elements: List[Element]) -> List[Element]:

        seen = set()
        unique_elements: List[Element] = []

        for element in elements:
            text = getattr(element, "text", None)
            norm_text = self.__normalize_text(text)

            if norm_text is None or norm_text == "":
                continue

            key = norm_text

            if key in seen:
                continue

            seen.add(key)
            unique_elements.append(element)

        return unique_elements
    

    def __normalize_text(self, text: str | None) -> str:
        if text is None:
            return ""
        t = text.lower()
        t = t.strip()
        t = re.sub(r'\s+', ' ', t)
        return t
