def run_pipeline(pdf_path, requirement=None, context=None, job_id=None):
    print(f"[JOB {job_id}] Pipeline gestartet")
    print(f"PDF: {pdf_path}")
    print(f"Requirement: {requirement.code if requirement else 'N/A'}")

    # Hier kommt später echte Logik rein
    return {
        "message": "Pipeline ausgeführt (Dummy)",
        "job_id": job_id
    }
