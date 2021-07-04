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

# Install Fonts
echo "Installing fonts..."
echo sudo cp ${PWD}/fonts/* ~/Library/Fonts/
sudo cp ${PWD}/fonts/* ~/Library/Fonts/ || true

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

# iTerm2 installation
echo "Installing iTerm2 dotfiles..."
# Specify the preferences directory to iTerm2
echo defaults write com.googlecode.iterm2.plist PrefsCustomFolder -string ${PWD}
defaults write com.googlecode.iterm2.plist PrefsCustomFolder -string ${PWD}/iterm || true
# Tell iTerm2 to use the custom preferences in the directory
echo defaults write com.googlecode.iterm2.plist LoadPrefsFromCustomFolder -bool true
defaults write com.googlecode.iterm2.plist LoadPrefsFromCustomFolder -bool true || true

# Install git config
echo "Installing git dotfiles..."
echo ln -s ${PWD}/git/gitconfig ~/.gitconfig
ln -s ${PWD}/git/gitconfig ~/.gitconfig || true
echo ln -s ${PWD}/git/gitignore ~/.gitignore
ln -s ${PWD}/git/gitignore ~/.gitignore || true
echo ln -s ${PWD}/git/gitattributes ~/.gitattributes
ln -s ${PWD}/git/gitattributes ~/.gitattributes || true
