import logging
from pydantic import BaseModel


logger = logging.getLogger(__name__)

class Config(BaseModel):
    debug_enabled: bool = True
    store_doob: bool = True
    max_blocks: int | None = 100
    ttl_hours: int | None = 24

    logger.info(f"Config initialized: enabled={debug_enabled}, store_doob={store_doob}, max_blocks={max_blocks}")

