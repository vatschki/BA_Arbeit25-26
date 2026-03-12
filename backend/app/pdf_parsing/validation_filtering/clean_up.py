from unstructured.documents.elements import Element
import re
from typing import List
import logging


'''
Die Klasse Filter bietet Funktionen zur Bereinigung von Elementen, die aus PDF-Dokumenten extrahiert wurden.
Insbesondere enthält sie eine Methode, die doppelte oder sehr ähnliche Elemente basierend auf ihrem Textinhalt entfernt.
Die Methode filter_elements_partition_pdf nimmt eine Liste von Elementen als Eingabe und gibt eine bereinigte Liste
zurück, in der nur einzigartige Elemente enthalten sind. Dabei wird der Text jedes Elements normalisiert, indem er
in Kleinbuchstaben umgewandelt, überflüssige Leerzeichen entfernt und mehrere aufeinanderfolgende Leerzeichen durch
ein einzelnes Leerzeichen ersetzt werden. Elemente ohne Text oder mit leerem Text werden automatisch ausgeschlossen.
Diese Bereinigung hilft dabei, die Qualität der extrahierten Daten zu verbessern, indem redundante Informationen
entfernt werden, was insbesondere bei der Verarbeitung großer PDF-Dokumente von Vorteil sein kann.
'''

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
