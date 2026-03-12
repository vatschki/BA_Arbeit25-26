import google.generativeai as genai
from app.llm.base_client import BaseLLMClient
import logging

logger = logging.getLogger(__name__)

'''
GeminiClient ist ein Client zur Interaktion mit dem Gemini-LLM von Google. Er wird mit einem API-Schlüssel und einem
Modellnamen initialisiert und verwendet die Bibliothek *genai*, um den API-Schlüssel zu konfigurieren und eine
*GenerativeModel*-Instanz zu erstellen. Die Methode *generate* nimmt einen Prompt als Eingabe entgegen und
ruft die Methode *generate_content* des Modells auf, um eine Antwort zu erhalten. Die Methode ist mit einer
Temperatur von 0 konfiguriert, um deterministische Ausgaben zu gewährleisten. Wenn die Antwort Text enthält,
wird der bereinigte Text zurückgegeben; andernfalls wird ein Fehler protokolliert und „NOT_FOUND“ zurückgegeben.
Dieser Client kann in der Anwendung verwendet werden, um auf Basis von Prompts Inhalte mit dem Gemini-LLM zu generieren.
'''

class GeminiClient(BaseLLMClient):

    def __init__(self, api_key: str, model_name: str):
        logger.info(f"Initializing GeminiClient with model: {model_name}")
        genai.configure(api_key=api_key)
        self.model = genai.GenerativeModel(model_name)

    def generate(self, prompt: str) -> str:
        response = self.model.generate_content(
            prompt,
            generation_config={
                "temperature": 0,
            },
        )
        try:
            return response.text.strip()
        except ValueError:
            logger.error("ValueError encountered while generating content")
            return "NOT_FOUND"
