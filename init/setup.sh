#!/bin/bash

SCRIPT_DIR=$(cd $(dirname $0); pwd)

# Configuration
ROOT_DIR=$(cd "${SCRIPT_DIR}/.."; pwd)
ENV_DIR="${ROOT_DIR}/env"
ENV_FILE="${ENV_DIR}/.env"

source "${ENV_FILE}"

# Installation
cat "${INSTALL_TXT}" \
    | grep -v '^#' \
    | xargs -L 1 "${TOOLS_DIR}/utils/install_cross_platform.sh"

grep -v '^#' "${VSCODE_EXTENSIONS_TXT}" \
    | xargs -L 1 code --force --install-extension

if command -v npm >/dev/null 2>&1; then
    grep -v '^#' "${NPM_INSTALL_TXT}" \
        | xargs npm install -g
fi

if command -v python3 >/dev/null 2>&1; then
    python3 -m venv "${PYTHON_VENV_DIR}" \
        && source "${PYTHON_VENV_ACTIVATE}" \
        && pip3 install -r "${PYTHON_REQUIREMENTS_TXT}" \
        && pip3 list \
        && deactivate
fi
