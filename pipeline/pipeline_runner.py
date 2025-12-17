def run_pipeline(pdf_path, job_id=None, **kwargs):
    print(f"[JOB {job_id}] Pipeline gestartet für Datei: {pdf_path}")

    # Hier rufst du deine echte Pipeline-Funktion auf
    # Example:
    # text = extract_text(pdf_path)
    # chunks = chunk_text(text)
    # embeddings = embed(chunks)

    return {
        "message": "Pipeline ausgeführt (Dummy).",
        "pdf_processed": pdf_path
    }
