from app.llm.gemini_client import GeminiClient
from app.llm.base_client import BaseLLMClient
import logging

logger = logging.getLogger(__name__)


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
