import requests

'''
Der CI4Client ist ein einfacher Client zum Senden von Pipeline-Ergebnissen an CI4. Er verwendet die Bibliothek
*requests*, um HTTP-POST-Anfragen an die CI4-API zu stellen. Der Client wird mit der Basis-URL der CI4-Instanz,
einem Pipeline-Secret zur Authentifizierung sowie optional mit einem Timeout für Anfragen initialisiert.
Die Methode *send_pipeline_result* nimmt die Job-ID, den Status, den Fortschritt, eine Nachricht und das Ergebnis als
Parameter entgegen und sendet diese an die CI4-API. Wenn der Statuscode der Antwort nicht 200 ist, wird ein
*RuntimeError* mit den Details der Antwort ausgelöst. Andernfalls gibt die Methode die JSON-Antwort von CI4 zurück.
'''
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
