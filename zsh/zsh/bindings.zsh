# zsh autosuggestions bindings
bindkey '^Y' autosuggest-accept

# zsh-history-substring-search configuration
# Use cat -v to find codes.
bindkey '^P' history-substring-search-up
bindkey '^N' history-substring-search-down

# C-z to toggle current process (background/foreground)
fancy-ctrl-z () {
  if [[ $#BUFFER -eq 0 ]]; then
    BUFFER="fg"
    zle accept-line
  else
    zle push-input
    zle clear-screen
  fi
}
zle -N fancy-ctrl-z
bindkey '^Z' fancy-ctrl-z

