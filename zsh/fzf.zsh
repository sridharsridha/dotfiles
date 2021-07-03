# FZF
FZF_SHELL=$HOME/.zsh/fzf
if [[ ! -d "$FZF_SHELL" ]]; then
	echo "Installing fzf-shell."
	git clone https://github.com/junegunn/fzf.git "$FZF_SHELL"
	$FZF_SHELL/install --all
fi

generic_paths=(
	$FZF_SHELL/bin
)
# Enable default exports
export PATH=$PATH:$(IFS=:; echo "${generic_paths[*]}")
