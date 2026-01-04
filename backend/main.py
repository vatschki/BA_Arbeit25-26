from fastapi import FastAPI
from api.routes.pipeline import router as pipeline_router

app = FastAPI()

app.include_router(pipeline_router)