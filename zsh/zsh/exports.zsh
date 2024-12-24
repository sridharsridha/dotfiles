# Setup terminal, and turn on colors
export CLICOLOR=1
export KEYTIMEOUT=1

# export LC_ALL="en_US.UTF-8"
# export LC_CTYPE="en_US.UTF-8"
# export LANG="en_US.UTF-8"

export EDITOR='nvim'
export PAGER='less'
export LESS='--ignore-case --raw-control-chars'
export VISUAL='nvim'
export TZ="Asia/Kolkata"

# Paths {{{
###########
paths=( \
	.\
	~\
	~/bin\
	~/.dotfiles/bin\
	~/scripts\
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
	/opt/homebrew/bin\
)
# Enable default exports
export PATH=$PATH:$(IFS=:; echo "${generic_paths[*]}")

