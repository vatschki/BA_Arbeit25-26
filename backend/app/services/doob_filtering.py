from typing import Dict, List
from pathlib import Path
import json
import logging
from app.pdf_parsing.schema.doob_document import (
    DOOB
)

logger = logging.getLogger(__name__)

ALLOWED_TEXT_CATEGORIES = {
    "NarrativeText",
    "Title",
}

'''
Dieses Modul enthält Funktionen zur Filterung von DOOB-Dokumenten basierend auf bestimmten Kriterien.
Es bietet die Möglichkeit, DOOB-Dokumente nach Seitenzahlen oder nach Kategorien zu filtern.
Die Funktion `filter_doob_by_pages` ermöglicht es, nur die Blöcke eines DOOB-Dokuments zu behalten,
die auf bestimmten Seitenzahlen erscheinen. Die Funktion `filter_doob_by_category` ermöglicht es,
nur die Blöcke eines DOOB-Dokuments zu behalten, die zu bestimmten Kategorien gehören, in diesem Fall
"NarrativeText" und "Title". Beide Funktionen geben ein neues DOOB-Dokument zurück, das nur die gefilterten Blöcke enthält.
'''

def filter_doob_by_pages(doob: DOOB, pages: List[int]) -> DOOB:

    logger.info(f"Filtering DOOB for pages: {pages}")

    pages_set = set(pages)

    filtered_blocks = [
        block for block in doob.content
        if block.pagenumber in pages_set
    ]

    return DOOB(
        content=filtered_blocks,
        metadata=doob.metadata,
    )


def filter_doob_by_category(
    doob: DOOB,
) -> DOOB:

    logger.info(f"Filtering DOOB for categories: {ALLOWED_TEXT_CATEGORIES}")

    filtered_blocks = [
        block
        for block in doob.content
        if block.category in ALLOWED_TEXT_CATEGORIES
    ]

    return DOOB(
        content=filtered_blocks,
        metadata=doob.metadata,
    )