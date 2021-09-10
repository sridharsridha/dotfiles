## Add Antigen
[[ -f ~/.zsh/antigen/antigen.zsh ]] && source ~/.zsh/antigen/antigen.zsh

# Load the oh-my-zsh's library, so antigen treat it as a bundle and we can directly
# use the names to get the plugins.
# For non on-my-zsh plugins we need <git_user>/<repro> format.
antigen use oh-my-zsh

# Load antigen plugins
antigen bundles <<EOBUNDLES
	# Oh-my-zsh plugins
	command-not-found
	colored-man-pages
	# magic-enter
	extract
	tmux
	git
	fzf
	# bol
	# bofh

	# autojump directories
	rupa/z
	# zabb z abbr for a directory
	Mellbourn/zabb
	# Alias Tool tip
	djui/alias-tips

   # Use FZF for ZSH tab completion
	# Aloxaf/fzf-tab

	# Autonotify long running commands when finished
	# MichaelAquilina/zsh-auto-notify

	# Use bd to move up folders
	Tarrasch/zsh-bd

	# adds pbcopy, pbpaste and clip
	zpm-zsh/clipboard

	# C-h
	micrenda/zsh-nohup

	# Todo
	AlexisBRENON/oh-my-zsh-reminder

	# colorfull ls
	supercrabtree/k

	# marlonrichert/zsh-autocomplete
	# zsh-users/zsh-history-substring-search
	zsh-users/zsh-completions
	zsh-users/zsh-autosuggestions
	zsh-users/zsh-syntax-highlighting

EOBUNDLES

# Lead ZSH themes
# if ! is-at-least 5.1; then
#    antigen theme robbyrussell
# else
#    antigen theme romkatv/powerlevel10k
# fi
antigen theme robbyrussell

# Tell antigen that you're done.
antigen apply
