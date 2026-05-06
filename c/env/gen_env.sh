#!/bin/bash

SCRIPT_DIR=$(cd $(dirname $0); pwd)

# Configuration
ROOT_DIR="${SCRIPT_DIR}/../.."
chmod -R +x "${ROOT_DIR}"

# Generate
"${ROOT_DIR}/env/gen_env.sh"
cat <<EOF

ENV_DIR="${SCRIPT_DIR}"
ENV_INSTALL_TXT="\${ENV_DIR}/install.txt"

PYTHON_ENV_DIR="${SCRIPT_DIR}/python"
PYTHON_REQUIREMENTS_TXT="\${PYTHON_ENV_DIR}/requirements.txt"
PYTHON_VENV="\${PYTHON_ENV_DIR}/venv"
PYTHON_VENV_ACTIVATE="\${PYTHON_VENV}/bin/activate"

VSCODE_EXTENSIONS_TXT="\${ENV_DIR}/vscode_extensions.txt"
EOF
