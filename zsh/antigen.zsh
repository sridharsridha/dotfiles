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
	magic-enter
	ssh-agent
	extract
	tmux
	git
	fzf

	# Alias Tool tip
	djui/alias-tips

        # Use FZF for ZSH tab completion
	# Aloxaf/fzf-tab

	# colorfull ls
	supercrabtree/k

	zsh-users/zsh-completions
	zsh-users/zsh-autosuggestions
	zsh-users/zsh-syntax-highlighting
	HeroCC/LS_COLORS
	rupa/z

EOBUNDLES

# Lead ZSH themes
if ! is-at-least 5.1; then
   POWERLEVEL9K_INSTALLATION_PATH=$ANTIGEN_BUNDLES/bhilburn/powerlevel9k
   POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(dir dir_writable vcs)
   POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=(status root_indicator background_jobs history)
   POWERLEVEL9K_BACKGROUND_JOBS_VERBOSE=true
   POWERLEVEL9K_COMMAND_EXECUTION_TIME_THRESHOLD=2
   antigen theme bhilburn/powerlevel9k powerlevel9k
else
   antigen theme romkatv/powerlevel10k
fi

# Tell antigen that you're done.
antigen apply
