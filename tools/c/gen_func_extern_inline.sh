#!/bin/bash

if [ "$#" -ne 1 ]; then
    echo "Usage: $0 <source_file.c>"
    exit 1
fi

SCRIPT_DIR=$(cd $(dirname $0); pwd)

# Configuration
ROOT_DIR=$(cd "${SCRIPT_DIR}/.."; pwd)
ENV_DIR="${ROOT_DIR}/env"
ENV_FILE="${ENV_DIR}/.env"

# Configuration Load
source "${ENV_FILE}"

INPUT_FILE_PATH=$1
INPUT_FILE_DIR="$(dirname "$INPUT_FILE_PATH")"
INPUT_FILE_BASE_NAME="$(basename "$INPUT_FILE_PATH")"
INPUT_FILE_BASE_NAME_NO_EXTENSION="${INPUT_FILE_BASE_NAME%.*}"

OUTPUT_FILE_PATH="${INPUT_FILE_DIR}/${INPUT_FILE_BASE_NAME_NO_EXTENSION}_extern_inline.c"

source "${PYTHON_VENV_ACTIVATE}"

RESULT=$(python3 "${SCRIPT_DIR}/gen_func_extern_inline.py" "${INPUT_FILE_PATH}")

cat << EOF > "${OUTPUT_FILE_PATH}"
#include "${INPUT_FILE_BASE_NAME}"
$(echo -e "${RESULT}")
EOF

deactivate
