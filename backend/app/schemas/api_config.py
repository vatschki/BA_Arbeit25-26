from pydantic import BaseModel, Field, field_validator

'''
Schema für die API-Konfiguration eines LLM-Providers.
'''

class ApiConfig(BaseModel):
    provider_name: str = Field(..., min_length=1)
    model_name: str = Field(..., min_length=1)
    api_key: str = Field(..., min_length=1)

    @field_validator("provider_name", "model_name", "api_key")
    @classmethod
    def no_empty_strings(cls, v: str) -> str:
        if not v.strip():
            raise ValueError("must not be empty")
        return v
