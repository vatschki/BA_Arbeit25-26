import google.generativeai as genai
from app.llm.base_client import BaseLLMClient
import logging

logger = logging.getLogger(__name__)


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
