#!/bin/bash

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

if [ -f "$SCRIPT_DIR/.env" ]; then
    source "$SCRIPT_DIR/.env"
else
    echo "Error: .env file not found."
    exit 1
fi

if [ -z "$PROVIDER_URL" ] || [ -z "$USER_ID" ] || [ -z "$PASSWORD" ]; then
    echo "Error: Missing required variables."
    exit 1
fi

# 1. Check if we ALREADY have internet. If we get "Success", exit silently.
if curl --max-time 3 -s http://captive.apple.com | grep -q "Success"; then
    exit 0
fi

# 2. We don't have internet. Bypass the frontend modal and send the login payload directly.
curl -L --connect-timeout 5 --max-time 10 -s -X POST "$PROVIDER_URL" \
-H "User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/120.0.0.0 Safari/537.36" \
-d "userId=$USER_ID" \
-d "password=$PASSWORD" \
-d "serviceName=ProntoAuthentication" \
-o /dev/null