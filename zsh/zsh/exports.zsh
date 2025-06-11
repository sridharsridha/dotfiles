# Setup terminal, and turn on colors
export CLICOLOR=1
export KEYTIMEOUT=1

export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8

if [[ "$TERM_PROGRAM" == "ghostty" ]]; then
    export TERM=xterm-256color
fi
export EZA_COLORS="di=1;36"

export EDITOR='nvim'
export PAGER='less'
export LESS='--ignore-case --raw-control-chars'
export VISUAL='nvim'
export TZ="Asia/Kolkata"

# zsh history substring search.
export HISTORY_SUBSTRING_SEARCH_ENSURE_UNIQUE=1
# https://man.archlinux.org/man/zshzle.1#CHARACTER_HIGHLIGHTING
export HISTORY_SUBSTRING_SEARCH_HIGHLIGHT_FOUND='fg=green,standout' # bold
export HISTORY_SUBSTRING_SEARCH_HIGHLIGHT_NOT_FOUND='fg=red,underline'
export HISTORY_SUBSTRING_SEARCH_GLOBBING_FLAGS='i'

# Paths {{{
###########
paths=( \
	.\
	~\
	~/bin\
   ~/.bin\
	~/.dotfiles/bin\
	~/scripts\
   ~/.local/bin\
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

