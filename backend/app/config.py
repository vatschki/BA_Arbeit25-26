import logging
from pathlib import Path
from pydantic import BaseModel, ValidationError
from dotenv import dotenv_values

logger = logging.getLogger(__name__)

ENV_PATH = Path(__file__).resolve().parent / ".env"

'''
Die Klasse Config ist verantwortlich für das Laden und Validieren der Konfigurationseinstellungen aus einer .env-Datei.
Sie verwendet Pydantic, um die Konfiguration zu validieren und sicherzustellen, dass alle erforderlichen
Umgebungsvariablen vorhanden und korrekt formatiert sind. Die Konfiguration umfasst Einstellungen wie Debug-Modus,
Speicheroptionen, maximale Blockanzahl, TTL, Pipeline-Geheimnis und Basis-URL. Wenn die Konfiguration erfolgreich
geladen wird, werden relevante Informationen geloggt.
'''

class Config(BaseModel):
    debug_enabled: bool
    store_doob: bool
    max_blocks: int
    ttl_hours: int
    pipeline_secret: str
    base_url: str

    @classmethod
    def load(cls) -> "Config":
        env = dotenv_values(ENV_PATH)

        try:
            config = cls(
                debug_enabled=env["DEBUG_ENABLED"],
                store_doob=env["STORE_DOOB"],
                max_blocks=int(env["MAX_BLOCKS"]),
                ttl_hours=int(env["TTL_HOURS"]),
                pipeline_secret=env["PIPELINE_SECRET"],
                base_url=env["BASE_URL"],
                max_jobs=int(env.get("MAX_STORAGE_JOBS")),
                max_debug_jobs=int(env.get("MAX_DEBUG_JOBS")),
            )
        except KeyError as e:
            raise RuntimeError(f"Missing required env var: {e.args[0]}") from e
        except ValidationError as e:
            raise RuntimeError(f"Invalid config values: {e}") from e

        logger.info(
            "Config loaded successfully (base_url=%s, debug=%s)",
            config.base_url,
            config.debug_enabled,
        )

        return config
# 