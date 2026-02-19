from pathlib import Path
from typing import Dict, List
from unstructured.documents.elements import Element
from pprint import pprint
import logging

from app.pdf_parsing.loading_extraction.loading_pdf import Loader
from app.pdf_parsing.validation_filtering.validator import Validator
from app.pdf_parsing.schema.doob_document import (
    Block, 
    TitleBlock, 
    HeaderBlock, 
    TextBlock, 
    ImageBlock, 
    TableBlock, 
    SubtitleBlock, 
    FooterBlock,
    DOOB)
from app.pdf_parsing.schema.extensions import FileExtensionType
from app.pdf_parsing.loading_extraction.extract_metadata import MetadataExtractor

class Parser:

    def __init__(self, validator: Validator | None = None, loader: Loader | None = None, company: str | None = None) -> None:

        if company is None or company.strip() == "":
            logging.error("Parser-Initialisierung abgebrochen: 'company' ist None oder leer.")
            raise ValueError("company must not be None or empty")

        self.validator = validator or Validator()
        self.loader = loader or Loader()
        self.metadata_extractor = MetadataExtractor(company=company)

    supported_extensions = [
        FileExtensionType.PDF
    ]

    CATEGORY_TO_BLOCK_TYPE = {
        "Title": "Title",
        "Subtitle": "Subtitle",
        "Header": "Header",
        "Footer": "Footer",
        "Image": "Image",
        "Table": "Table",
        "Text": "Text",
        "NarrativeText": "Text",
        "ListItem": "Text",
        "FigureCaption": "Text",
        "UncategorizedText": "UncategorizedText",
        "PageBreak": None,
        "PageNumber": None,
    }


    def toBlock(
        self,
        file_path: Path | str,
        file_extension: str | FileExtensionType | None = None,
        page_numbers: list[int] | None = None
        ) -> DOOB: #Dokument out of Blocks

        file_extension = self.validator.validate_data(
            file_path=file_path, 
            file_extension=file_extension
        )
        
        elements: List[Element] = self.loader.load(
            file_path=file_path,
            file_extension=file_extension,
            page_numbers=page_numbers
        )

        return self.__to_doob_document(elements)
    
    
    def __to_doob_document(self, elements: list[Element]) -> DOOB:
        blocks = []
        for element in elements:
            block = self.__format_element_to_block(element)
            if block:
                blocks.append(block)
        return DOOB(
            content = blocks,
            metadata = {}
        )        

    def __format_element_to_block(self, element: Element) -> Block | None:
        element_type = element.category
        normalized_type = self.CATEGORY_TO_BLOCK_TYPE.get(element_type, None)

        if normalized_type is None:
            return None
                     
        text = getattr(element, "text", "") or ""
        if text is None or text.strip() == "":
            return None

        block_metadata, page_range, category_depth = self.metadata_extractor.extract_metadata(
            element=element,
            normalized_type=normalized_type,
        )
        
        pagenumber = block_metadata.get("page_number")
        category = block_metadata.get("category")
        element_type = block_metadata.get("element_type")
        text_len = block_metadata.get("text_len")
        company = block_metadata.get("company")

        block_types: Dict[str, Block] = {
            "Title": TitleBlock(
                text=text,
                pagenumber=pagenumber,
                category=category,
                element_type=element_type,
                text_len=text_len,
                company=company,
                metadata=block_metadata,
                page_range=page_range

            ),
            "Subtitle": SubtitleBlock(
                text=text,
                pagenumber=pagenumber,
                category=category,
                element_type=element_type,
                text_len=text_len,
                depth=category_depth,
                company=company,
                metadata=block_metadata,
                page_range=page_range
            ),
            "Header": HeaderBlock(
                text=text,
                pagenumber=pagenumber,
                category=category,
                element_type=element_type,
                text_len=text_len,
                company=company,
                metadata=block_metadata,
                page_range=page_range
            ),

            "Text": TextBlock(
                text=text,
                pagenumber=pagenumber,
                category=category,
                element_type=element_type,
                text_len=text_len,
                company=company,
                metadata=block_metadata,
                page_range=page_range

            ),
            "UncategorizedText": TextBlock(
                text=text,
                pagenumber=pagenumber,
                category=category,
                element_type=element_type,
                text_len=text_len,
                company=company,
                metadata=block_metadata,
                page_range=page_range

            ),
            "Image": ImageBlock(
                text=text,
                pagenumber=pagenumber,
                category=category,
                element_type=element_type,
                text_len=text_len,
                company=company,
                metadata=block_metadata,
                page_range=page_range

            ),
            "Table": TableBlock(
                text=text,
                pagenumber=pagenumber,
                category=category,
                element_type=element_type,
                text_len=text_len,
                company=company,
                metadata=block_metadata,
                page_range=page_range

            ),
            "Footer": FooterBlock(
                text=text,
                pagenumber=pagenumber,
                category=category,
                element_type=element_type,
                text_len=text_len,
                company=company,
                metadata=block_metadata,
                page_range=page_range

            )
        }

        return block_types.get(normalized_type, None)







