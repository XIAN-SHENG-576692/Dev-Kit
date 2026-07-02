#!/bin/bash

# 2026-05-22_17-33_RTK filter
# https://github.com/rtk-ai/rtk/tree/develop
# https://www.rtk-ai.app/docs/

curl -fsSL https://raw.githubusercontent.com/rtk-ai/rtk/master/install.sh | sh

rtk init --global    # installs hook + patches settings.json
rtk init --global --gemini
rtk init --codex    # creates AGENTS.md or patches existing one
