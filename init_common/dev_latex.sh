#!/bin/bash

SCRIPT_DIR=$(cd $(dirname $0); pwd)

# Configuration
ROOT_DIR=$(cd "${SCRIPT_DIR}/.."; pwd)

${ROOT_DIR}/init/env/gen_env.sh

${ROOT_DIR}/init/env/gen_install_env.sh \
    --install \
    ${ROOT_DIR}/init/env/install/common.txt \
    ${ROOT_DIR}/init/env/install/dev_latex.txt \
    ${ROOT_DIR}/init/env/install/llm.txt \
    --vscode-extensions \
    ${ROOT_DIR}/init/env/vscode_extensions/common.txt \
    ${ROOT_DIR}/init/env/vscode_extensions/dev_latex.txt \
    ${ROOT_DIR}/init/env/vscode_extensions/llm.txt \

${ROOT_DIR}/init/setup.sh
