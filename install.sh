#!/bin/bash -
###############################################################################
# setup.sh
# This script creates everything needed to setup this dotfiles
###############################################################################

echo "MacOsx Setup"

# Unoffical Bash "strict mode"
# http://redsymbol.net/articles/unofficial-bash-strict-mode/
set -euo pipefail
IFS=$'\t\n' # Stricter IFS settings
ORIGINAL_IFS=$IFS

# Install Fonts
echo "Installing fonts..."
echo sudo cp ${PWD}/fonts/* ~/Library/Fonts/
sudo cp ${PWD}/fonts/* ~/Library/Fonts/

# iTerm2 installation
echo "Installing iTerm2 dotfiles..."
# Specify the preferences directory to iTerm2
echo defaults write com.googlecode.iterm2.plist PrefsCustomFolder -string ${PWD}
defaults write com.googlecode.iterm2.plist PrefsCustomFolder -string ${PWD}
# Tell iTerm2 to use the custom preferences in the directory
echo defaults write com.googlecode.iterm2.plist LoadPrefsFromCustomFolder -bool true
defaults write com.googlecode.iterm2.plist LoadPrefsFromCustomFolder -bool true

# Install git config
echo "Installing git dotfiles..."
echo ln -s ${PWD}/gitconfig ~/.gitconfig
ln -s ${PWD}/gitconfig ~/.gitconfig
echo ln -s ${PWD}/gitignore ~/.gitignore
ln -s ${PWD}/gitignore ~/.gitignore
echo ln -s ${PWD}/gitattributes ~/.gitattributes
ln -s ${PWD}/gitattributes ~/.gitattributes
