#!/bin/bash

SCRIPT_DIR=$(cd $(dirname $0); pwd)

# Configuration
ROOT_DIR=$(cd "${SCRIPT_DIR}/.."; pwd)

${ROOT_DIR}/init/env/gen_env.sh

# ==================================================
${ROOT_DIR}/init/env/rm_install_txt.sh

${ROOT_DIR}/init/env/gen_install_txt.sh \
    --install \
    ${ROOT_DIR}/init/env/install/dev_typst.txt \

${ROOT_DIR}/init/setup.sh

source ${ROOT_DIR}/init/others/install_rustc.sh

# ==================================================
${ROOT_DIR}/init/env/rm_install_txt.sh

${ROOT_DIR}/init/env/gen_install_txt.sh \
    --cargo-install \
    ${ROOT_DIR}/init/env/cargo/dev_typst.txt \
    --install \
    ${ROOT_DIR}/init/env/install/common.txt \
    ${ROOT_DIR}/init/env/install/llm.txt \
    --vscode-extensions \
    ${ROOT_DIR}/init/env/vscode_extensions/common.txt \
    ${ROOT_DIR}/init/env/vscode_extensions/dev_typst.txt \
    ${ROOT_DIR}/init/env/vscode_extensions/llm.txt \

${ROOT_DIR}/init/setup.sh
