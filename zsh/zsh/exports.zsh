# Setup terminal, and turn on colors
export CLICOLOR=1
export KEYTIMEOUT=1

if type "nvim" > /dev/null; then
  export EDITOR='nvim'
else
  export EDITOR='vim'
fi

export PAGER='less'
export LESS='--ignore-case --raw-control-chars'
# export LANG="en_US.UTF-8"
# export LC_ALL="en_US.UTF-8"
export TZ="Asia/Kolkata"

# Cppman bash completion support with '::'
# export COMP_WORDBREAKS=" /\"\'><;|&("

# Paths {{{
###########
paths=( \
	.\
	~\
	~/bin\
	~/.dotfiles/bin\
	~/scripts\
	/opt/local/bin\
	/usr/local/bin\
	/usr/bin\
	/bin\
	/opt/local/sbin\
	/usr/local/sbin\
	/usr/sbin\
	/sbin\
)
export PATH=$(IFS=:; echo "${paths[*]}")

generic_paths=(
	/opt/homebrew/bin\
)
# Enable default exports
export PATH=$PATH:$(IFS=:; echo "${generic_paths[*]}")

# Colourize man output
export LESS_TERMCAP_mb=$(printf "\e[1;37m")
export LESS_TERMCAP_md=$(printf "\e[1;37m")
export LESS_TERMCAP_me=$(printf "\e[0m")
export LESS_TERMCAP_se=$(printf "\e[0m")
export LESS_TERMCAP_so=$(printf "\e[1;47;30m")
export LESS_TERMCAP_ue=$(printf "\e[0m")
export LESS_TERMCAP_us=$(printf "\e[0;36m")
export LESS=-iRX

