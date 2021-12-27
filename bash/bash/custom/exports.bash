# Setup terminal, and turn on colors
export CLICOLOR=1

export KEYTIMEOUT=1

if type "nvim" > /dev/null; then
  export EDITOR='nvim'
else
  export EDITOR='vim'
fi

# Increase Bash history size. Allow 32³ entries; the default is 500.
export HISTSIZE='32768';
export HISTFILESIZE="${HISTSIZE}";
# Omit duplicates and commands that begin with a space from history.
export HISTCONTROL='ignoreboth';

export PAGER='less -X'
export LESS='--ignore-case --raw-control-chars'
export LANG='en_US.UTF-8'
export LC_ALL='en_US.UTF-8'

# Hide the “default interactive shell is now zsh” warning on macOS.
export BASH_SILENCE_DEPRECATION_WARNING=1;

# Paths {{{
###########
paths=( \
	.\
	~\
	~/bin\
	~/.dotfiles/bin\
	~/scripts\
	/usr/local/opt/llvm/bin\
	/opt/local/bin\
	/usr/local/bin\
	/usr/bin\
	/bin\
	/opt/local/sbin\
	/usr/local/sbin\
	/usr/sbin\
	/sbin\
)
export PATH=$(IFS=:; echo "${paths[*]}")

generic_paths=(
	$FZF_SHELL/bin
)
# Enable default exports
export PATH=$PATH:$(IFS=:; echo "${generic_paths[*]}")
