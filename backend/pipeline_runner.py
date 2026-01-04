def run_pipeline(
    pdf_path: str,
    job_id: str,
    requirement: dict | None = None,
    context: dict | None = None,
    api_config: dict | None = None
):
    print(f"[JOB {job_id}] Pipeline gestartet")
    print(f"[JOB {job_id}] PDF: {pdf_path}")

    if context:
        print(f"[JOB {job_id}] Firma: {context.company_name}")
        print(f"[JOB {job_id}] Jahr: {context.year}")
        print(f"[JOB {job_id}] Standard: {context.standard_code}")


    if requirement:
        print(f"[JOB {job_id}] Requirement: {requirement.code}")

    # HIER später:
    # extract_text(pdf_path)
    # chunk_text(...)
    # embed(...)
    # store_results(...)

    return {
        "message": "Pipeline Dummy ausgeführt",
        "job_id": job_id
    }
