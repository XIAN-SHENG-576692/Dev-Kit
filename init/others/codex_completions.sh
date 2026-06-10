#!/bin/bash

mkdir -p /etc/bash_completion.d
mkdir -p ~/.zsh/completions
mkdir -p ~/.config/fish/completions

echo "eval \"\$(codex completion bash)\"" > /etc/bash_completion.d/codex
echo "eval \"\$(codex completion zsh)\"" > ~/.zsh/completions/_codex
echo "eval \"\$(codex completion fish)\"" > ~/.config/fish/completions/codex.fish
