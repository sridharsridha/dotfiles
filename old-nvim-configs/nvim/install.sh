#!/bin/bash -

# Unoffical Bash "strict mode"
# http://redsymbol.net/articles/unofficial-bash-strict-mode/
set -euo pipefail
IFS=$'\t\n' # Stricter IFS settings
ORIGINAL_IFS=$IFS

# Install tmux
echo ln -s ${PWD} ~/.config/nvim
ln -s ${PWD} ~/.config/nvim

echo ln -s ${PWD}/ccls ~/.ccls
ln -s ${PWD}/ccls ~/.ccls
