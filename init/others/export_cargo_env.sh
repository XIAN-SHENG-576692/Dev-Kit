#!/bin/bash

mkdir -p "$HOME/.cargo"

cat << EOF > "$HOME/.cargo/env"
#!/bin/sh
# rustup shell setup
# affix colons on either side of \$PATH to simplify matching
case ":\${PATH}:" in
    *:"\$HOME/.cargo/bin":*)
        ;;
    *)
        # Prepending path in case a system-installed rustc needs to be overridden
        export PATH="\$HOME/.cargo/bin:\$PATH"
        ;;
esac
EOF

mkdir -p ~/.config/fish

source "$HOME/.cargo/env"
echo "source \"\$HOME/.cargo/env\"" >> ~/.bashrc
echo "source \"\$HOME/.cargo/env\"" >> ~/.zshrc
echo "source \"\$HOME/.cargo/env\"" >> ~/.config/fish/config.fish
