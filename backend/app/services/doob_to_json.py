from typing import Dict, List
from pathlib import Path
import json
from app.pdf_parsing.schema.doob_document import (
    DOOB,
    Block,
    TitleBlock,
    SubtitleBlock,
    HeaderBlock,
    TextBlock,
    TableBlock,
    ImageBlock,
    FooterBlock,
)

STRUCTURAL_ROLE = {
    TitleBlock: "title",
    SubtitleBlock: "subtitle",
    HeaderBlock: "header",
    TextBlock: "content",
    TableBlock: "content",
    ImageBlock: "illustrative",
    FooterBlock: "noise",
}


def _block_to_dict(block: Block, idx: int) -> Dict:
    return {
        "block_id": f"b_{idx:04d}",
        "block_type": block.__class__.__name__.replace("Block", ""),
        "structural_role": STRUCTURAL_ROLE.get(type(block), "unknown"),
        "text": block.text,
        "page": block.pagenumber,
        "category": block.category,
        "text_len": block.text_len,
        "metadata": {
            "page_range": block.page_range,
            "element_type": block.element_type,
        },
    }


def doob_to_json(
    doob: DOOB, 
    job_id: str, 
    company_name: str
) -> Dict:
    return {
        "document_metadata": {
            "company": company_name,
            "job_id": job_id,
            "document_type": "pdf",
        },
        "blocks": [
            _block_to_dict(block, idx)
            for idx, block in enumerate(doob.content, start=1)
        ],
    }

def doob_to_json_blocklimit(
    doob: DOOB,
    job_id: str,
    company_name: str,
    blocklimit: int,
) -> Dict:
    return {
        "document_metadata": {
            "company": company_name,
            "job_id": job_id,
            "document_type": "pdf",
        },
        "blocks": [
            _block_to_dict(block, idx)
            for idx, block in enumerate(doob.content[:blocklimit], start=1)
        ],
    }


def write_output_json(final_json: dict, output_dir="output", filename="matches_final.json"):
    Path(output_dir).mkdir(parents=True, exist_ok=True)

    output_path = Path(output_dir) / filename

    with output_path.open("w", encoding="utf-8") as f:
        json.dump(final_json, f, ensure_ascii=False, indent=2)

    print(f"[OUTPUT] Final JSON written to {output_path}")




