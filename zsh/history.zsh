# HISTORY
HISTSIZE=10000
SAVEHIST=9000
HISTFILE=~/.zsh_history
HISTCONTROL=ignoredups:erasedups
HISTIGNORE="exit"
setopt inc_append_history # Update History in all windows on command execution
setopt hist_ignore_all_dups
setopt hist_ignore_space
