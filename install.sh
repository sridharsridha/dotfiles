#!/bin/bash -
###############################################################################
# setup.sh
# This script creates everything needed to setup this dotfiles
###############################################################################

# Unoffical Bash "strict mode"
# http://redsymbol.net/articles/unofficial-bash-strict-mode/
set -euo pipefail
IFS=$'\t\n' # Stricter IFS settings
ORIGINAL_IFS=$IFS

echo "Installing dotfiles..."

git submodule update --init --recursive

echo "Installing zsh dotfiles..."
echo ln -s ${PWD}/zsh ~/.zsh
ln -s ${PWD}/zsh ~/.zsh || true
echo ln -s ${PWD}/zshrc ~/.zshrc
ln -s ${PWD}/zshrc ~/.zshrc || true

echo "Installing tmux dotfiles..."
echo ln -s ${PWD}/tmux.conf ~/.tmux.conf
ln -s ${PWD}/tmux.conf ~/.tmux.conf || true

echo "Installing neovim dotfiles..."
echo ln -s ${PWD}/nvim ~/.config/nvim
ln -s ${PWD}/nvim ~/.config/nvim || true
