#!/bin/bash

curl --proto '=https' --tlsv1.2 https://sh.rustup.rs -sSf | sh

mkdir -p /etc/bash_completion.d
mkdir -p ~/.zsh/completions
mkdir -p ~/.config/fish/completions

source "$HOME/.cargo/env"
echo "source \"\$HOME/.cargo/env\"" > /etc/bash_completion.d/cargo
echo "source \"\$HOME/.cargo/env\"" > ~/.zsh/completions/_cargo
echo "source \"\$HOME/.cargo/env\"" > ~/.config/fish/completions/cargo.fish
