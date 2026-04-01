#!/bin/bash
# Usage: ./scripts/generate-image.sh "prompt" output-filename.jpg [theme-dir] [ref-image-path]
# theme-dir: path to Shopify theme repo (default: current directory)
# ref-image-path: optional path to a reference image for image-to-image generation
# Requires: GEMINI_API_KEY in environment or .env

set -e

PROMPT="$1"
OUTPUT_FILENAME="$2"
THEME_DIR="${3:-.}"
REF_IMAGE_PATH="${4:-}"
OUTPUT_PATH="${THEME_DIR}/assets/${OUTPUT_FILENAME}"

MODEL="gemini-2.5-flash-image"

if [ -z "$GEMINI_API_KEY" ] && [ -f ".env" ]; then
  set -a; source .env; set +a
fi

if [ -z "$GEMINI_API_KEY" ]; then
  echo "ERROR: GEMINI_API_KEY not set. Copy .env.example to .env and add your key."
  echo "Get a free key at https://aistudio.google.com/apikey"
  exit 1
fi

if [ -z "$PROMPT" ] || [ -z "$OUTPUT_FILENAME" ]; then
  echo "Usage: ./scripts/generate-image.sh \"<prompt>\" <output-filename.jpg> [theme-dir] [ref-image-path]"
  exit 1
fi

command -v python3 >/dev/null 2>&1 || { echo "ERROR: python3 is required but not installed."; exit 1; }

echo "Generating image..."
echo "Output: $OUTPUT_PATH"
[ -n "$REF_IMAGE_PATH" ] && echo "Reference image: $REF_IMAGE_PATH"

ENHANCED_PROMPT="${PROMPT}, professional brand photography, 4k, photorealistic"
export ENHANCED_PROMPT
export REF_IMAGE_PATH
export OUTPUT_PATH

# Build request JSON
JSON_BODY=$(python3 - <<'PYEOF'
import json, os, base64, mimetypes

prompt = os.environ.get("ENHANCED_PROMPT", "")
ref_path = os.environ.get("REF_IMAGE_PATH", "").strip()

parts = [{"text": prompt}]

if ref_path:
    mime_type, _ = mimetypes.guess_type(ref_path)
    if not mime_type or not mime_type.startswith("image/"):
        mime_type = "image/jpeg"
    with open(ref_path, "rb") as f:
        image_data = base64.b64encode(f.read()).decode("utf-8")
    parts.append({
        "inlineData": {
            "mimeType": mime_type,
            "data": image_data
        }
    })

body = {
    "contents": [{"parts": parts}],
    "generationConfig": {
        "responseModalities": ["IMAGE"],
        "imageConfig": {"imageSize": "1K"}
    }
}
print(json.dumps(body))
PYEOF
)

# Call Gemini API — write response to temp file to avoid shell quoting issues
RESPONSE_FILE=$(mktemp)
trap 'rm -f "$RESPONSE_FILE"' EXIT

curl -s -X POST \
  -H "x-goog-api-key: $GEMINI_API_KEY" \
  -H "Content-Type: application/json" \
  -d "$JSON_BODY" \
  "https://generativelanguage.googleapis.com/v1beta/models/${MODEL}:generateContent" \
  > "$RESPONSE_FILE"

export RESPONSE_FILE

# Extract and save image
python3 - <<'PYEOF'
import json, base64, os, sys

response_file = os.environ.get("RESPONSE_FILE", "")
output_path = os.environ.get("OUTPUT_PATH", "")

with open(response_file, "r") as f:
    raw = f.read()

try:
    data = json.loads(raw)
except json.JSONDecodeError as e:
    print(f"ERROR: Failed to parse API response: {e}", file=sys.stderr)
    print("Response was:", raw[:500], file=sys.stderr)
    sys.exit(1)

if "error" in data:
    print(f"ERROR: API error: {data['error'].get('message', str(data['error']))}", file=sys.stderr)
    sys.exit(1)

candidates = data.get("candidates", [])
if not candidates:
    print("ERROR: No candidates in response", file=sys.stderr)
    print("Response:", json.dumps(data, indent=2)[:1000], file=sys.stderr)
    sys.exit(1)

parts = candidates[0].get("content", {}).get("parts", [])
image_part = None
for part in parts:
    if "inlineData" in part and part["inlineData"].get("mimeType", "").startswith("image/"):
        image_part = part["inlineData"]
        break

if not image_part:
    print("ERROR: No image in response parts", file=sys.stderr)
    text_parts = [p.get("text", "") for p in parts if "text" in p]
    if text_parts:
        print("Model text response:", " ".join(text_parts)[:300], file=sys.stderr)
    sys.exit(1)

image_bytes = base64.b64decode(image_part["data"])
out_dir = os.path.dirname(output_path)
if out_dir:
    os.makedirs(out_dir, exist_ok=True)
with open(output_path, "wb") as f:
    f.write(image_bytes)

print(f"Saved to {output_path}")
PYEOF
