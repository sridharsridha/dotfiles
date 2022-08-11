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
echo "Update submodules..."
git submodule update --init --recursive

cmd_exist() {
	local cmd=$1
	local exist=$(command -v $cmd &> /dev/null)
	return $exist
}

symlink() {
	local source=$1
	local target=$2
	if [[ -e $source ]]; then
		[[ -e $target ]] && mv -f $target ${target}.old
		echo ln -s $source $target
		ln -s $source $target
	fi
}

dir_exist() {
	local dir=$1
	local exist=$(test -d $dir)
	return $exist
}


echo Installing fonts...
if dir_exist ~/Library/Fonts/; then
		for f in ${PWD}/fonts/*; do
			if [[ ! -e "~/Library/Fonts/${f}" ]]; then # TODO: permission issue, always false
				echo sudo cp "$f" ~/Library/Fonts/
				sudo cp "$f" ~/Library/Fonts/
			fi
		done
fi

echo Installing zsh soft links
if cmd_exist zsh; then
	symlink ${PWD}/zsh/zsh ~/.zsh
	symlink ${PWD}/zsh/zshrc ~/.zshrc 
fi


echo Installing bash soft links
if cmd_exist bash; then
   symlink ${PWD}/bash/bashrc ~/.bashrc
   symlink ${PWD}/bash/bash_profile ~/.bash_profile
   symlink ${PWD}/bash/inputrc ~/.inputrc
fi

echo Installing tmux dotfiles...
if cmd_exist tmux; then
	 [[ ! -e ~/.tmux ]] && mkdir ~/.tmux
	 symlink ${PWD}/tmux/tmux.conf ~/.tmux.conf
fi

echo Installing neovim configuration symlink
if cmd_exist nvim; then
	symlink ${PWD}/nvim ~/.config/nvim
fi

echo Installing iTerm2 dotfiles...
if dir_exist /Applications/iTerm.app; then
	# Specify the preferences directory to iTerm2
	echo defaults write com.googlecode.iterm2.plist PrefsCustomFolder -string $PWD
	defaults write com.googlecode.iterm2.plist PrefsCustomFolder -string $PWD/iterm
	# Tell iTerm2 to use the custom preferences in the directory
	echo defaults write com.googlecode.iterm2.plist LoadPrefsFromCustomFolder -bool true
	defaults write com.googlecode.iterm2.plist LoadPrefsFromCustomFolder -bool true
fi

echo Installing git dotfiles...
if cmd_exist git; then
	symlink $PWD/git/gitconfig ~/.gitconfig
	symlink $PWD/git/gitignore ~/.gitignore
	symlink $PWD/git/gitattributes ~/.gitattributes
fi

