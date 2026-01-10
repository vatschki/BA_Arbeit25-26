from typing import Dict, List, Any
from pathlib import Path
import json
from app.schemas.requirement import Requirement
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


def requirements_to_json(requirements: List[Requirement]) -> List[Dict[str, Any]]:

    return [req.model_dump() for req in requirements]


def write_output_json(final_json: dict, output_dir="debug", filename="default_name.json"):
    Path(output_dir).mkdir(parents=True, exist_ok=True)

    output_path = Path(output_dir) / filename

    with output_path.open("w", encoding="utf-8") as f:
        json.dump(final_json, f, ensure_ascii=False, indent=2)



def make_flat_result_json(result_json: dict, job_id: str, company_name: str) -> dict:

    flat_results = []

    for i, match in enumerate(result_json.get("matches", []), start=1):
        for b, block in enumerate(match.get("matched_blocks", []), start=1):
            page = block.get("page")

            flat_results.append({
                "job_id": job_id,
                "company": company_name,
                "report_requirement": match.get("report_requirement"),
                "disclosure_requirement": match.get("disclosure_requirement"),
                "paragraph": match.get("paragraph"),
                "title": match.get("title"),
                "associated_requirements": match.get("associated_requirements", []),
                "page": page,
                "text": block.get("text"),
                "page_id": f"{page}-{i}-{b}"
            })

    return {
        "results": flat_results
    }





