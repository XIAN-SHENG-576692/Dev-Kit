#!/bin/bash

mkdir -p ~/.config/fish

source "$HOME/.elan/env"
echo "source \"\$HOME/.elan/env\"" >> ~/.bashrc
echo "source \"\$HOME/.elan/env\"" >> ~/.zshrc
echo "source \"\$HOME/.elan/env\"" >> ~/.config/fish/config.fish
