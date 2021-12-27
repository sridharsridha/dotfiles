# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# [[ -z "$PS1" ]] && return
export FZF_BASE=$HOME/.zsh/fzf

# Load Antigen
source ~/.zsh/antigen.zsh
source ~/.zsh/functions.zsh
source ~/.zsh/aliases.zsh
source ~/.zsh/exports.zsh
source ~/.zsh/bindings.zsh
source ~/.zsh/hooks.zsh

# Oh-my-zsh's configurations
DISABLE_AUTO_TITLE="true"
DISABLE_UNTRACKED_FILES_DIRTY="true"
[ -z "$SSH_CONNECTION" ] && ZSH_TMUX_AUTOSTART="true"
ZSH_AUTOSUGGEST_USE_ASYNC="true"

# FZF installation
[ ! -f ~/.fzf.zsh ] && $FZF_BASE/install --all
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

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
# [[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

export PATH="$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin:$PATH"

test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"

