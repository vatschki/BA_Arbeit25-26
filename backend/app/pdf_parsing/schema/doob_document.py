import uuid
from typing import Any, Dict, List, Optional, Tuple

from pydantic import BaseModel, Field, field_validator


# --------------------
# Basis-Typen
# --------------------
 
class Block(BaseModel):
   
    block_id: uuid.UUID = Field(default_factory=uuid.uuid4)
    metadata: Dict[str, Any] = Field(default_factory=dict)

    page_range: Optional[Tuple[int, int]] = None

    pagenumber: Optional[int] = None               
    element_type: Optional[str] = None      
    category: Optional[str] = None          
    text_len: Optional[int] = None  

    company : Optional[str] = None         

    @field_validator("page_range")
    @classmethod
    def validate_page_range(cls, value: Optional[Tuple[int, int]]) -> Optional[Tuple[int, int]]:
        if value is None:
            return value
        start, end = value
        if start > end:
            raise ValueError(
                "Die erste Seitenzahl im page_range muss <= der zweiten sein."
            )
        return value


class TextBlock(Block):

    text: str
    pagenumber: Optional[int] = None

    def __str__(self) -> str:
        return self.text


# --------------------
# Spezifische Text-Blöcke
# --------------------

class TitleBlock(TextBlock):
    
    def __str__(self) -> str:
        # z.B. als Markdown-Heading
        return f"# {self.pagenumber, self.text}"


class SubtitleBlock(TextBlock):
    
    depth: int = 0  

    def __str__(self) -> str:
        heading_level = min(self.depth + 2, 6)
        return f"{'#' * heading_level} {self.text}"


class HeaderBlock(TextBlock):
   
    def __str__(self) -> str:
        return f"[HEADER] {self.text}"


class FooterBlock(TextBlock):
    
    def __str__(self) -> str:
        return f"[FOOTER] {self.text}"


# --------------------
# Nicht-Text-Blöcke
# --------------------

class ImageBlock(Block):

    text: Optional[str] = None       
    caption: Optional[str] = None    

    def __str__(self) -> str:
        caption = self.caption or "Bild"
        return f"[IMAGE: {caption}]"


class TableBlock(Block):

    text: Optional[str] = None     
    caption: Optional[str] = None

    def __str__(self) -> str:
        if self.text:
            return self.text
        caption = self.caption or "Tabelle"
        return f"[TABLE: {caption}]"


# --------------------
# Dokument-Typ
# --------------------

class DOOB(BaseModel):

    file_name: Optional[str] = None
    content: List[Block]
    metadata: Dict[str, Any] = Field(default_factory=dict)

    def __str__(self) -> str:
        lines: List[str] = []
        for block in self.content:
            lines.append(str(block))
        return "\n\n".join(lines)
