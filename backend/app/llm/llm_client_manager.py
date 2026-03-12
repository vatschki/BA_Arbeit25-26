from app.llm.gemini_client import GeminiClient
from app.llm.base_client import BaseLLMClient
import logging

logger = logging.getLogger(__name__)

'''
LLMClientManager ist eine Factory-Klasse, die für die Erstellung von LLM-Client-Instanzen verantwortlich ist.
Sie bietet eine statische Methode *create*, die den Namen des gewünschten LLM-Anbieters, den API-Schlüssel, den
Modellnamen und optionale zusätzliche Parameter entgegennimmt. Basierend auf dem angegebenen Anbieter wird die
entsprechende LLM-Client-Instanz erstellt und zurückgegeben. Derzeit unterstützt die Factory die Erstellung
eines *GeminiClient* für den Gemini-LLM von Google. Wenn ein unbekannter Anbieter angegeben wird, wird eine
ValueError-Ausnahme ausgelöst. Diese Factory ermöglicht es der Anwendung, flexibel verschiedene LLM-Clients zu
integrieren, ohne dass der Rest des Codes von den spezifischen Implementierungsdetails der Clients abhängig ist.
'''

class LLMClientManager:

    @staticmethod
    def create(provider: str, api_key: str, model_name: str, **kwargs) -> BaseLLMClient:
        provider = provider.lower()

        if provider == "gemini":
            logger.info(f"Creating GeminiClient")
            return GeminiClient(
                api_key=api_key,
                model_name=model_name,
            )

        raise ValueError(f"Unknown LLM provider: {provider}")
