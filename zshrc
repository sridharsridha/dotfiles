[[ -z "$PS1" ]] && return

# Load Antigen
[[ -f ~/.zsh/antigen.zsh ]] && source ~/.zsh/antigen.zsh

# Load custom configurations
[[ -f ~/.zsh/functions.zsh ]] && source ~/.zsh/functions.zsh
[[ -f ~/.zsh/aliases.zsh ]] && source ~/.zsh/aliases.zsh
[[ -f ~/.zsh/exports.zsh ]] && source ~/.zsh/exports.zsh
[[ -f ~/.zsh/bindings.zsh ]] && source ~/.zsh/bindings.zsh
[[ -f ~/.zsh/hooks.zsh ]] && source ~/.zsh/hooks.zsh
[[ -f ~/.zsh/fzf.zsh ]] && source ~/.zsh/fzf.zsh

# Oh-my-zsh's configurations
DISABLE_AUTO_TITLE="true"
DISABLE_UNTRACKED_FILES_DIRTY="true"
[ -z "$SSH_CONNECTION" ] && ZSH_TMUX_AUTOSTART="true"
ZSH_AUTOSUGGEST_USE_ASYNC="true"

# FZF installation
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# Node installation
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm

# Load the private bash config files
CUSTOM="${HOME}/.zshrc.local"
if [[ -e "${CUSTOM}" ]]; then
	# shellcheck disable=SC1090
	source $CUSTOM
fi

