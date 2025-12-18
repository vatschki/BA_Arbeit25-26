def run_pipeline(pdf_path, job_id=None, **kwargs):
    print(f"[JOB {job_id}] Pipeline gestartet für Datei: {pdf_path}")
    
    #Provisorisch
    return {
        "message": "Pipeline ausgeführt (Dummy).",
        "pdf_processed": pdf_path
    }
