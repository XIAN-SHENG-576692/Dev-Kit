#!/bin/bash

SCRIPT_DIR=$(cd $(dirname $0); pwd)

# Configuration
ROOT_DIR=$(cd "${SCRIPT_DIR}/../.."; pwd)
ENV_DIR="${ROOT_DIR}/env"
ENV_FILE="${ENV_DIR}/.env"

# Parameters
INIT_DIR="${ROOT_DIR}/init"
mkdir -p "${INIT_DIR}"
PYTHON_DIR="${ENV_DIR}/python"
mkdir -p "${PYTHON_DIR}"
PYTHON_VENV_DIR="${PYTHON_DIR}/venv"
mkdir -p "${PYTHON_VENV_DIR}"

ENV=(
    ENV_DIR="${ENV_DIR}"
    ENV_FILE="${ENV_FILE}"
    INIT_DIR="${INIT_DIR}"
    INIT_ENV_DIR="${INIT_DIR}/env"
    INSTALL_TXT="${ENV_DIR}/install.txt"
    PYTHON_DIR="${PYTHON_DIR}"
    PYTHON_REQUIREMENTS_TXT="${PYTHON_DIR}/requirements.txt"
    PYTHON_VENV_DIR="${PYTHON_VENV_DIR}"
    PYTHON_VENV_ACTIVATE="${PYTHON_VENV_DIR}/bin/activate"
    ROOT_DIR="${ROOT_DIR}"
    TOOLS_DIR="${ROOT_DIR}/tools"
    VSCODE_EXTENSIONS_TXT="${ENV_DIR}/vscode_extensions.txt"
)
ENV_CONTEXT=$(printf "%s" "$first" "${ENV[@]/#/\\n}")

# Output
echo -e ${ENV_CONTEXT} > "${ENV_FILE}"
