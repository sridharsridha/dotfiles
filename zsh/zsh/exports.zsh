# Setup terminal, and turn on colors
export CLICOLOR=1

export KEYTIMEOUT=1

if type "nvim" > /dev/null; then
  export EDITOR='nvim'
else
  export EDITOR='vim'
fi

export PAGER='less'
export LESS='--ignore-case --raw-control-chars'
export LANG=en_US.UTF-8

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