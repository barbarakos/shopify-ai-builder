#!/bin/bash
# Usage: ./scripts/generate-image.sh "prompt" output-filename.jpg
# Requires: REPLICATE_API_TOKEN in environment or .env

set -e

PROMPT="$1"
OUTPUT_FILENAME="$2"
OUTPUT_PATH="assets/${OUTPUT_FILENAME}"

if [ -z "$REPLICATE_API_TOKEN" ] && [ -f ".env" ]; then
  set -a; source .env; set +a
fi

if [ -z "$REPLICATE_API_TOKEN" ]; then
  echo "ERROR: REPLICATE_API_TOKEN not set. Copy .env.example to .env and add your key."
  exit 1
fi

if [ -z "$PROMPT" ] || [ -z "$OUTPUT_FILENAME" ]; then
  echo "Usage: ./scripts/generate-image.sh \"<prompt>\" <output-filename.jpg>"
  exit 1
fi

command -v python3 >/dev/null 2>&1 || { echo "ERROR: python3 is required but not installed."; exit 1; }

echo "Generating image..."
echo "Output: $OUTPUT_PATH"

ENHANCED_PROMPT="${PROMPT}, professional photography, 4k, photorealistic, brand campaign"
export ENHANCED_PROMPT

JSON_BODY=$(python3 - <<'PYEOF'
import json, os
body = {
    "version": "ac732df83cea7fff18b8472768c88ad041fa750ff7682a21affe81863cbe77e4",
    "input": {
        "prompt": os.environ.get("ENHANCED_PROMPT", ""),
        "negative_prompt": "cartoon, illustration, low quality, blurry, watermark, text",
        "width": 1024,
        "height": 1024,
        "num_inference_steps": 30
    }
}
print(json.dumps(body))
PYEOF
)

RESPONSE=$(curl -s -X POST \
  -H "Authorization: Token $REPLICATE_API_TOKEN" \
  -H "Content-Type: application/json" \
  -d "$JSON_BODY" \
  https://api.replicate.com/v1/predictions)

PREDICTION_ID=$(echo "$RESPONSE" | python3 -c "import sys,json; print(json.load(sys.stdin)['id'])")
echo "Prediction ID: $PREDICTION_ID"

for i in {1..30}; do
  sleep 3
  STATUS_RESPONSE=$(curl -s \
    -H "Authorization: Token $REPLICATE_API_TOKEN" \
    "https://api.replicate.com/v1/predictions/${PREDICTION_ID}")
  STATUS=$(echo "$STATUS_RESPONSE" | python3 -c "import sys,json; print(json.load(sys.stdin)['status'])")
  echo "Status: $STATUS"
  if [ "$STATUS" = "succeeded" ]; then
    IMAGE_URL=$(echo "$STATUS_RESPONSE" | python3 -c "import sys,json; print(json.load(sys.stdin)['output'][0])")
    curl -s -o "$OUTPUT_PATH" "$IMAGE_URL"
    echo "Saved to $OUTPUT_PATH"
    exit 0
  elif [ "$STATUS" = "failed" ]; then
    echo "ERROR: Image generation failed"
    echo "$STATUS_RESPONSE"
    exit 1
  fi
done

echo "ERROR: Timed out waiting for image"
exit 1
