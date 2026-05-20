#!/bin/bash

SCRIPT_DIR=$(cd $(dirname $0); pwd)

usage() {
    echo "Usage: $0 [OPTION]..."
    echo ""
    echo "Options:"
    echo "  -c, --cargo, --cargo-install [FILE_0 FILE_1 ...]"
    echo "  -h, --help"
    echo "  -i, --in, --install [FILE_0 FILE_1 ...]"
    echo "  -n, --npm, --npm-install [FILE_0 FILE_1 ...]"
    echo "  -p, --python, --python-requirements [FILE_0 FILE_1 ...]"
    echo "  -v, --vs, --vscode-extensions [FILE_0 FILE_1 ...]"
    exit 1
}

if [ "$#" -eq 0 ]; then
    usage
fi

CARGO_INSTALL_ARRAY=()
INSTALL_ARRAY=()
NPM_INSTALL_ARRAY=()
PYTHON_REQUIREMENTS_ARRAY=()
VSCODE_EXTENSIONS_ARRAY=()

while [[ $# -gt 0 ]]; do
    case "$1" in
        -c|--cargo|--cargo-install)
            shift
            # Loop until the next argument is an option or we run out of arguments
            while [[ $# -gt 0 && ! "$1" =~ ^- ]]; do
                CARGO_INSTALL_ARRAY+=("$1")
                shift
            done
            ;;
        -h|--help)
            usage
            ;;
        -i|--in|--install)
            shift
            # Loop until the next argument is an option or we run out of arguments
            while [[ $# -gt 0 && ! "$1" =~ ^- ]]; do
                INSTALL_ARRAY+=("$1")
                shift
            done
            ;;
        -n|--npm|--npm-install)
            shift
            # Loop until the next argument is an option or we run out of arguments
            while [[ $# -gt 0 && ! "$1" =~ ^- ]]; do
                NPM_INSTALL_ARRAY+=("$1")
                shift
            done
            ;;
        -p|--python|python-requirements)
            shift
            # Loop until the next argument is an option or we run out of arguments
            while [[ $# -gt 0 && ! "$1" =~ ^- ]]; do
                PYTHON_REQUIREMENTS_ARRAY+=("$1")
                shift
            done
            ;;
        -v|--vs|--vscode-extensions)
            shift
            # Loop until the next argument is an option or we run out of arguments
            while [[ $# -gt 0 && ! "$1" =~ ^- ]]; do
                VSCODE_EXTENSIONS_ARRAY+=("$1")
                shift
            done
            ;;
        *)
            echo "Unknown option: $1"
            usage
            ;;
    esac
done

# Configuration
ROOT_DIR=$(cd "${SCRIPT_DIR}/../.."; pwd)
ENV_DIR="${ROOT_DIR}/env"
ENV_FILE="${ENV_DIR}/.env"

# Configuration Load
source "${ENV_FILE}"
source "${TOOLS_DIR}/utils/join_by_string.sh"

# Configuration cargo Install
CARGO_INSTALL=()
for item in ${CARGO_INSTALL_ARRAY[@]}; do
    mapfile -t -O "${#CARGO_INSTALL[@]}" CARGO_INSTALL < <(grep -Ev '^#|^$' "${item}")
done
CARGO_INSTALL=($(printf "%s\n" "${CARGO_INSTALL[@]}" | awk '!x[$0]++'))
CARGO_INSTALL_CONTEXT=$(join_by_string "\n" "${CARGO_INSTALL[@]}")

# Configuration Install
INSTALL=()
for item in ${INSTALL_ARRAY[@]}; do
    mapfile -t -O "${#INSTALL[@]}" INSTALL < <(grep -Ev '^#|^$' "${item}")
done
INSTALL=($(printf "%s\n" "${INSTALL[@]}" | awk '!x[$0]++'))
INSTALL_CONTEXT=$(join_by_string "\n" "${INSTALL[@]}")

# Configuration npm Install
NPM_INSTALL=()
for item in ${NPM_INSTALL_ARRAY[@]}; do
    mapfile -t -O "${#NPM_INSTALL[@]}" NPM_INSTALL < <(grep -Ev '^#|^$' "${item}")
done
NPM_INSTALL=($(printf "%s\n" "${NPM_INSTALL[@]}" | awk '!x[$0]++'))
NPM_INSTALL_CONTEXT=$(join_by_string "\n" "${NPM_INSTALL[@]}")

# Configuration Python requirements
PYTHON_REQUIREMENTS=()
for item in ${PYTHON_REQUIREMENTS_ARRAY[@]}; do
    mapfile -t -O "${#PYTHON_REQUIREMENTS[@]}" PYTHON_REQUIREMENTS < <(grep -Ev '^#|^$' "${item}")
done
PYTHON_REQUIREMENTS=($(printf "%s\n" "${PYTHON_REQUIREMENTS[@]}" | awk '!x[$0]++'))
PYTHON_REQUIREMENTS_CONTEXT=$(join_by_string "\n" "${PYTHON_REQUIREMENTS[@]}")

# Configuration VSCode extensions
VSCODE_EXTENSIONS=()
for item in ${VSCODE_EXTENSIONS_ARRAY[@]}; do
    mapfile -t -O "${#VSCODE_EXTENSIONS[@]}" VSCODE_EXTENSIONS < <(grep -Ev '^#|^$' "${item}")
done
VSCODE_EXTENSIONS=($(printf "%s\n" "${VSCODE_EXTENSIONS[@]}" | awk '!x[$0]++'))
VSCODE_EXTENSIONS_CONTEXT=$(join_by_string "\n" "${VSCODE_EXTENSIONS[@]}")

# Output
echo -e ${CARGO_INSTALL_CONTEXT} > "${CARGO_INSTALL_TXT}"
echo -e ${INSTALL_CONTEXT} > "${INSTALL_TXT}"
echo -e ${NPM_INSTALL_CONTEXT} > "${NPM_INSTALL_TXT}"
echo -e ${PYTHON_REQUIREMENTS_CONTEXT} > "${PYTHON_REQUIREMENTS_TXT}"
echo -e ${VSCODE_EXTENSIONS_CONTEXT} > "${VSCODE_EXTENSIONS_TXT}"
