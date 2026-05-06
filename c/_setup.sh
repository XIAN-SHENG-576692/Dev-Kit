#!/bin/bash

SCRIPT_DIR=$(cd $(dirname $0); pwd)

# Generate env file
ENV_DIR="${SCRIPT_DIR}/env"
chmod -R +x "${ENV_DIR}"
"${ENV_DIR}/gen_env.sh" > "${ENV_DIR}/config.env"

# Configuration
. "${ENV_DIR}/config.env"

# Set permissions
chmod -R +x "${ROOT_DIR}"
chmod -R +x "${SCRIPT_DIR}"

# Installation
cat "${ROOT_ENV_INSTALL_TXT}" "${ENV_INSTALL_TXT}" \
    | grep -v '^#' \
    | xargs -L 1 "${ROOT_DIR}/install_cross_platform.sh" \
    && python3 -m venv "${PYTHON_VENV}" \
    && source "${PYTHON_VENV_ACTIVATE}" \
    && pip3 install -r "${PYTHON_REQUIREMENTS_TXT}" \
    && pip3 list \
    && deactivate

grep -v '^#' "${ROOT_ENV_VSCODE_EXTENSIONS_TXT}" | xargs -L 1 code --force --install-extension
grep -v '^#' "${VSCODE_EXTENSIONS_TXT}" | xargs -L 1 code --force --install-extension
