#!/bin/bash

cat << EOF > "$HOME/.elan/ld-library-path.env"
#!/bin/sh
# Dynamically locate the active Lean toolchain's lib directory
if command -v lean &> /dev/null; then
    LIB="\$(lean --print-prefix)/lib"
    case ":\${LD_LIBRARY_PATH}:" in
        *:"\${LIB}":*)
            ;;
        *)
            export LD_LIBRARY_PATH="\${LIB}:\${LD_LIBRARY_PATH}"
            ;;
    esac
fi
EOF

mkdir -p ~/.config/fish

source "$HOME/.elan/env"
echo "source \"\$HOME/.elan/env\"" >> ~/.bashrc
echo "source \"\$HOME/.elan/env\"" >> ~/.zshrc
echo "source \"\$HOME/.elan/env\"" >> ~/.config/fish/config.fish

source "$HOME/.elan/ld-library-path.env"
echo "source \"\$HOME/.elan/ld-library-path.env\"" >> ~/.bashrc
echo "source \"\$HOME/.elan/ld-library-path.env\"" >> ~/.zshrc
echo "source \"\$HOME/.elan/ld-library-path.env\"" >> ~/.config/fish/config.fish
