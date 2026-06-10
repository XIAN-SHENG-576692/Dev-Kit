#!/bin/bash

SCRIPT_DIR=$(cd $(dirname $0); pwd)

# Configuration
ROOT_DIR=$(cd "${SCRIPT_DIR}/../.."; pwd)
ENV_DIR="${ROOT_DIR}/env"
ENV_FILE="${ENV_DIR}/.env"

# Configuration Load
source "${ENV_FILE}"

rm "${CARGO_INSTALL_TXT}" 2> /dev/null
rm "${INSTALL_TXT}" 2> /dev/null
rm "${NPM_INSTALL_TXT}" 2> /dev/null
rm "${PYTHON_REQUIREMENTS_TXT}" 2> /dev/null
rm "${VSCODE_EXTENSIONS_TXT}" 2> /dev/null

exit 0
