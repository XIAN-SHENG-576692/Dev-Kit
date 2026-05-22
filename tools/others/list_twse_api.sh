#!/bin/bash
# ============================================================
# Prerequisite:
#   - curl
# ============================================================

SCRIPT_DIR=$(cd $(dirname $0); pwd)

API_BASE_URL="https://openapi.twse.com.tw/v1"

API_ROUTE_ARRAY=$(curl https://openapi.twse.com.tw/v1/swagger.json \
    | jq -r '.paths | keys[]')

printf "%s\n" "${API_ROUTE_ARRAY[@]}" \
    | xargs -I {} echo "${API_BASE_URL}{}"
