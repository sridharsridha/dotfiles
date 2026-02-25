# Setup terminal, and turn on colors
export CLICOLOR=1
export KEYTIMEOUT=1

export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8

# Disable mosh client-side prediction to prevent typing lag and glitches
export MOSH_PREDICTION_DISPLAY=never

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

# Fix zsh-autosuggestions rendering with mosh
# Mosh's prediction can interfere with autosuggestions
if [[ -n "$SSH_CONNECTION" ]] || [[ -n "$MOSH_CONNECTION" ]]; then
  # Use a more visible color for suggestions over mosh
  export ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=240'

  # Use async mode to prevent blocking
  export ZSH_AUTOSUGGEST_USE_ASYNC=1

  # Clear suggestion when using mosh prediction
  export ZSH_AUTOSUGGEST_CLEAR_WIDGETS=(
    "expand-or-complete"
    "accept-line"
    "push-line"
    "push-line-or-edit"
  )

  # Strategy: use history first, then completion
  export ZSH_AUTOSUGGEST_STRATEGY=(history completion)

  # Buffer max size to prevent slowdown
  export ZSH_AUTOSUGGEST_BUFFER_MAX_SIZE=20
fi

# Paths {{{
###########
paths=( \
	.\
	~\
	~/bin\
	~/.bin\
	~/.dotfiles/bin\
   ~/dotfiles/bin\
   ~/.dotfiles/scripts\
   ~/dotfiles/scripts\
	~/scripts\
	~/.local/bin\
	/opt/homebrew/bin\
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

