#!/bin/bash

mkdir -p /etc/bash_completion.d
mkdir -p ~/.zsh/completions
mkdir -p ~/.config/fish/completions

codex completion bash > /etc/bash_completion.d/codex
codex completion zsh > ~/.zsh/completions/_codex
codex completion fish > ~/.config/fish/completions/codex.fish
