## Add Antigen
[[ -f ~/.zsh/antigen/antigen.zsh ]] && source ~/.zsh/antigen/antigen.zsh

# Load the oh-my-zsh's library, so antigen treat it as a bundle and we can directly
# use the names to get the plugins.
# For non on-my-zsh plugins we need <git_user>/<repro> format.
antigen use oh-my-zsh

# Bundles from the default repo (robbyrussell's oh-my-zsh).
antigen bundle git
# antigen bundle pip
antigen bundle command-not-found
antigen bundle fzf
antigen bundle djui/alias-tips
# antigen bundle alexrochas/zsh-path-environment-explorer
antigen bundle unixorn/autoupdate-antigen.zshplugin

# Syntax highlighting bundle.
antigen bundle zsh-users/zsh-completions
antigen bundle zsh-users/zsh-autosuggestions
antigen bundle zsh-users/zsh-syntax-highlighting
# antigen bundle zsh-users/zsh-history-substring-search

# Lead ZSH themes
# antigen theme sindresorhus/pure marionebl/paternoster agnoster robbyrussell
antigen theme robbyrussell

# Tell antigen that you're done.
antigen apply
