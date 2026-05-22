#!/bin/bash
# ============================================================
# Prerequisite:
#   - curl
# ============================================================

SCRIPT_DIR=$(cd $(dirname $0); pwd)

API_BASE_URL="https://www.tpex.org.tw/openapi/v1"

API_ROUTE_ARRAY=$(curl https://www.tpex.org.tw/openapi/swagger.json \
    | jq -r '.paths | keys[]')

printf "%s\n" "${API_ROUTE_ARRAY[@]}" \
    | xargs -I {} echo "${API_BASE_URL}{}"
