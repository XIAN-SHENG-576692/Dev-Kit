#!/bin/bash

curl --proto '=https' --tlsv1.2 https://sh.rustup.rs -sSf | sh

mkdir -p ~/.config/fish

source "$HOME/.cargo/env"
echo "source \"\$HOME/.cargo/env\"" >> ~/.bashrc
echo "source \"\$HOME/.cargo/env\"" >> ~/.zshrc
echo "source \"\$HOME/.cargo/env\"" >> ~/.config/fish/config.fish
