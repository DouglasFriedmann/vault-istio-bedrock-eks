import os
import boto3
from fastapi import FastAPI
from pydantic import BaseModel
from prometheus_fastapi_instrumentator import Instrumentator

app = FastAPI()
Instrumentator().instrument(app).expose(app)

MODEL_ID = os.getenv("BEDROCK_MODEL_ID", "us.amazon.nova-2-lite-v1:0")
REGION = os.getenv("AWS_REGION", "us-east-1")
SYSTEM_PROMPT_FILE = os.getenv("SYSTEM_PROMPT_FILE", "/vault/secrets/system_prompt")

bedrock = boto3.client("bedrock-runtime", region_name=REGION)


class PromptRequest(BaseModel):
    prompt: str


@app.get("/healthz")
def healthz():
    return {"status": "ok"}


@app.post("/ask")
def ask(req: PromptRequest):
    system_prompt = "You are the VIBE cloud assistant."

    if os.path.exists(SYSTEM_PROMPT_FILE):
        with open(SYSTEM_PROMPT_FILE, "r") as f:
            system_prompt = f.read().strip()

    response = bedrock.converse(
            modelId=MODEL_ID,
            system=[{"text": system_prompt}],
            messages=[
                {
                    "role": "user",
                    "content": [{"text": req.prompt}],
                }
            ],
        )

    return {
        "answer": response["output"]["message"]["content"][0]["text"]
    }

