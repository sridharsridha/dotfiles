## Add Antigen
[[ -f ~/.zsh/antigen/antigen.zsh ]] && source ~/.zsh/antigen/antigen.zsh

# Load the oh-my-zsh's library, so antigen treat it as a bundle and we can directly
# use the names to get the plugins.
# For non on-my-zsh plugins we need <git_user>/<repro> format.
antigen use oh-my-zsh

# Load antigen plugins
antigen bundles <<EOBUNDLES
	command-not-found
	# colored-man-pages
	# zsh-interactive-cd
	# history-substring-search
	# magic-enter
	# extract
	# tmux
	# git
	fzf
	# bol
	# bofh
	# rupa/z
	# djui/alias-tips
	# Aloxaf/fzf-tab
	# MichaelAquilina/zsh-auto-notify
	# Tarrasch/zsh-bd
	# zpm-zsh/clipboard
	# micrenda/zsh-nohup
	# AlexisBRENON/oh-my-zsh-reminder
	# colorfull ls
	# supercrabtree/k
	zsh-users/zsh-completions
	zsh-users/zsh-autosuggestions
	zsh-users/zsh-syntax-highlighting
EOBUNDLES

# Lead ZSH themes
antigen theme robbyrussell

# Tell antigen that you're done.
antigen apply
