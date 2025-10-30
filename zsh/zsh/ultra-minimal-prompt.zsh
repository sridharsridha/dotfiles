# Ultra-minimal prompt for problematic mosh connections
# Source this file in .zshrc.local if fast-prompt.zsh still has issues:
# source ~/.zsh/ultra-minimal-prompt.zsh

# Absolute minimum prompt - just directory and $
PROMPT='%~$ '

# Disable everything that could cause rendering issues
RPROMPT=''
PROMPT_EOL_MARK=''

# Disable git entirely
export DISABLE_UNTRACKED_FILES_DIRTY="true"
unset git_prompt_info

# Disable autosuggestions completely
ZSH_AUTOSUGGEST_CLEAR_WIDGETS+=(
  accept-line
  push-line
  push-line-or-edit
  bracketed-paste
)
# Make suggestions invisible (effectively disabled)
export ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=black,bg=black'

# Disable syntax highlighting
unset ZSH_HIGHLIGHT_HIGHLIGHTERS 2>/dev/null
typeset -gA ZSH_HIGHLIGHT_STYLES 2>/dev/null
ZSH_HIGHLIGHT_MAXLENGTH=0

# Remove all precmd/preexec hooks except essential ones
typeset -ag precmd_functions
typeset -ag preexec_functions
# Keep only zlong_alert if desired, remove others
precmd_functions=(${precmd_functions:#vcs_info})
precmd_functions=(${precmd_functions:#git_prompt_info})

# Simplify prompt options
unsetopt prompt_cr
unsetopt prompt_sp
setopt no_prompt_bang

echo "Ultra-minimal prompt loaded. No syntax highlighting or autosuggestions."
