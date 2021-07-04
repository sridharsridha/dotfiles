#!/bin/sh

# Homebrew Script for OSX
# To execute: save and `chmod +x ./brew-install-script.sh` then `./brew-install-script.sh`

echo "Installing brew..."
# /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"

# Terminal Applications
terminal_applications=(
  "llvm"
  "node"
  "python"
  "ccache"
  "doxygen"
  "conan"
  "clang-tidy"
  "cppcheck"
  "ccls"
  "clang-format"
  "shfmt"
  "yapf"
  "pylint"
  "shellcheck"
  "tmux"
  "neovim"
  "zsh"
  "zsh-completions"
  "bash"
  "universal-ctags"
  "global"
  "cscope"
  "git"
  "git-lfs"
  "hub"
  "unzip"
  "wget"
  "rg"
  "ack"
  "grep"
  "awk"
  "the_silver_searcher"
  "tree"
  "fd"
  "mosh"
)

# Cast Applications
cask_applications=(
  "github-desktop"
  "keybase"
  "slack"
  "skype"
  "google-chrome"
  "dropbox"
  "anki"
)

node_applications=(
  "bash-language-server"
  "vim-language-server"
)

for app in "${terminal_applications[@]}"
do
	brew install --force $app
done

for app in "${cask_applications[@]}"
do
	brew cask install $app
done

for app in "${node_applications[@]}"
do
	npm i -g $app
done

