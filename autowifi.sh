#!/bin/bash

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

if [ -f "$SCRIPT_DIR/.env" ]; then
    source "$SCRIPT_DIR/.env"
else
    echo "Error: .env file not found. Please copy .env.example to .env and configure it."
    exit 1
fi

if [ -z "$PROVIDER_URL" ] || [ -z "$USER_ID" ] || [ -z "$PASSWORD" ]; then
    echo "Error: Missing required variables (PROVIDER_URL, USER_ID, PASSWORD). Check your .env file."
    exit 1
fi

curl -s -X POST "$PROVIDER_URL" \
-d "userId=$USER_ID" \
-d "password=$PASSWORD" \
-d "serviceName=ProntoAuthentication"