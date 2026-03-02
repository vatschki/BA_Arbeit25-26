import shutil
from pathlib import Path


def limit_job_storage(max_jobs: int):
    jobs_path = Path("storage/jobs")
    debug_path = Path("debug")

    if not jobs_path.exists():
        return

    job_dirs = [d for d in jobs_path.iterdir() if d.is_dir()]
    job_dirs.sort(key=lambda d: d.stat().st_mtime)

    while len(job_dirs) > max_jobs:
        oldest = job_dirs.pop(0)

        shutil.rmtree(oldest, ignore_errors=True)

        debug_dir = debug_path / oldest.name
        if debug_dir.exists():
            shutil.rmtree(debug_dir, ignore_errors=True)

def limit_debug_jobs(max_debug_jobs: int):
    debug_path = Path("debug")

    if not debug_path.exists():
        return

    debug_dirs = [d for d in debug_path.iterdir() if d.is_dir()]
    debug_dirs.sort(key=lambda d: d.stat().st_mtime)

    while len(debug_dirs) > max_debug_jobs:
        oldest = debug_dirs.pop(0)
        shutil.rmtree(oldest, ignore_errors=True)
