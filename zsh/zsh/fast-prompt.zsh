# Fast prompt for remote servers
# Source this file in .zshrc.local on slow remote servers:
# source ~/.zsh/fast-prompt.zsh

# Simple, fast prompt without git info
# Use basic ANSI colors instead of oh-my-zsh variables for stability
PROMPT='%F{green}%~%f$ '

# Disable expensive git checks
export DISABLE_UNTRACKED_FILES_DIRTY="true"
unset git_prompt_info

# Remove precmd hooks that might be slow
typeset -ag precmd_functions
precmd_functions=(${precmd_functions:#vcs_info})
precmd_functions=(${precmd_functions:#git_prompt_info})

# Optimize autosuggestions for mosh - use even dimmer color
export ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=240'
export ZSH_AUTOSUGGEST_USE_ASYNC=1
export ZSH_AUTOSUGGEST_BUFFER_MAX_SIZE=15

# Disable syntax highlighting which can cause flickering
unset ZSH_HIGHLIGHT_HIGHLIGHTERS
typeset -A ZSH_HIGHLIGHT_STYLES 2>/dev/null

# Disable all prompt escapes that could cause recalculation
setopt prompt_subst
PROMPT_EOL_MARK=''

# Remove any right prompt
RPROMPT=''
