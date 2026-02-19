import requests


class CI4Client:
    def __init__(self, base_url: str, pipeline_secret: str, timeout: int = 30):
        self.base_url = base_url.rstrip("/")
        self.pipeline_secret = pipeline_secret
        self.timeout = timeout

    def send_pipeline_result(
        self,
        job_id: str,
        status: str,
        progress: int,
        message: str,
        result: dict
    ):
        payload = {
            "job_id": job_id,
            "status": status,
            "progress": progress,
            "message": message,
            "result": result
        }

        response = requests.post(
            f"{self.base_url}/internal/pipeline/result",
            json=payload,
            headers={
                "X-PIPELINE-TOKEN": self.pipeline_secret,
                "Content-Type": "application/json"
            },
            timeout=self.timeout
        )


        if response.status_code != 200:
            raise RuntimeError(
                f"CI4 rejected payload ({response.status_code}): {response.text}"
            )
        
        print("STATUS:", response.status_code)
        print("HEADERS:", response.headers)
        print("BODY:", response.text)


        return response.json()
