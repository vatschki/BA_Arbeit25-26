# Python Backend Service (FastAPI)

## Overview

This backend service processes PDF documents, extracts structured data, 
applies validation and filtering logic, and integrates LLM-based 
processing (e.g. Gemini).  

It is designed as a standalone FastAPI service that is consumed by the CI4 frontend.

---

## Architecture

The backend is structured into modular components:

- `app/llm/`  
  LLM client abstraction and block processing logic.

- `app/pdf_parsing/`  
  PDF loading, metadata extraction, validation, and schema definitions.

- `app/services/`  
  Business logic services (filtering, transformation, job status handling).

- `app/integrations/`  
  Integration layer (e.g. CI4 client communication).

- `app/schemas/`  
  Pydantic models for structured data handling.

- `storage/`  
  Job state persistence.

- `debug/`  
  Debug artifacts and intermediate processing results.

---

## Setup

Create virtual environment:

```bash
python3 -m venv venv
source venv/bin/activate
```

Install dependencies:

```bash
pip install -r requirements.txt
```

---

## Run the Service

```bash
uvicorn main:app --reload
```

Default host: `http://127.0.0.1:8000`

---

## Dependencies

All dependencies are defined in:

```
requirements.txt
```

The environment can be reproduced using:

```bash
pip install -r requirements.txt
```

---

## Notes

- `.env` file is excluded from version control.
- `venv/`, `__pycache__/`, and debug artifacts are ignored via `.gitignore`.
- The service is designed for reproducibility and modular extensibility.


## Architectural Pattern

The backend follows a modular service-oriented architecture:

- Clear separation of concerns (LLM, parsing, services, schemas)
- External system integration via defined client interfaces
- Structured pipeline execution via `pipeline_runner.py`
- Persistent job state tracking