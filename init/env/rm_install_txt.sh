#!/bin/bash

SCRIPT_DIR=$(cd $(dirname $0); pwd)

# Configuration
ROOT_DIR=$(cd "${SCRIPT_DIR}/../.."; pwd)
ENV_DIR="${ROOT_DIR}/env"
ENV_FILE="${ENV_DIR}/.env"

# Configuration Load
source "${ENV_FILE}"

cd "${ENV_DIR}" \
&& $(rm *.txt 2> /dev/null || true)
