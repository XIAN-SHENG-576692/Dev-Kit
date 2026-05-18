#!/bin/bash

SCRIPT_DIR=$(cd $(dirname $0); pwd)

# Configuration
ROOT_DIR=$(cd "${SCRIPT_DIR}/.."; pwd)
ENV_DIR="${ROOT_DIR}/env"
ENV_FILE="${ENV_DIR}/.env"

# Configuration Load
source "${ENV_FILE}"
source "${PYTHON_VENV_ACTIVATE}"

python3 "${SCRIPT_DIR}/gen_iter_files.py" $@

deactivate
