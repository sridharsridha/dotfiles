is_linux="$([[ $(uname) == Linux ]] && echo true || echo false)"
is_macos="$([[ $(uname) == Darwin ]] && echo true || echo false)"

alias c='clear'
alias rm='rm -i'
alias f='find'
alias tree='tree -C --charset utf-8'
alias le=less
alias wget='wget -c'                        # Preferred 'wget' implementation (resume download)
alias cp='cp -iv'                            # Preferred 'cp' implementation
alias mv='mv -iv'                            # Preferred 'mv' implementation
alias gentags='ctags -R .'
alias grep='grep -n --color=auto'
alias mem='free -h'
alias disk='df -h'

# I like verbose in chmod & chown
alias chmod='chmod -v'
alias chown='chown -v'
alias sudo='sudo -E ' # Makes sudo use aliases, from https://askubuntu.com/a/22043/353466

alias plz='sudo $(fc -nl -1)' # Repeat last command with sudo

alias clanginc='clang -Wp,-v -E -xc -x c++ /dev/null'

alias search-txt='function _search(){find ./ -type f -exec grep --color=always -Hil "$1" {} \;};_search'
alias path='echo -e ${PATH//:/\\n}' # Formatted path

alias mkdir='mkdir -pv' # Verbose & Parents mkdir flag
alias md='mkdir'
function mcd() {
	mkdir "$@" && cd "$1"
}

alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"' # Coppied from default Ubuntu bash config
alias d='dirs -v | head -10'

# Enable color support
if [[ -x /usr/bin/dircolors ]]; then
	if [[ -r ~/.dircolors ]]; then
		eval "$(dircolors -b ~/.dircolors)"
	else
		eval "$(dircolors -b)"
	fi
	alias ls='ls --color=auto'
	alias grep='grep --color=auto'
	alias fgrep='fgrep --color=auto'
	alias egrep='egrep --color=auto'
fi

if $is_linux; then
	alias ll='ls -l --almost-all --classify --human-readable'
	alias la='ls --almost-all'
	alias l='ls --classify'
elif $is_macos; then
	alias l='ls -FG'
	alias la='ls -AG'
	alias ll='ls -lhG'
	alias lal='ls -lAhG'
fi

if $is_linux; then
	function o() {
		if type "xdg-open" > /dev/null; then
			xdg-open "$@" &
		fi
	}
else
	alias o=open
fi

# Mosh.
alias moshkill='kill `pidof mosh-server`' # Kill all mosh servers

# Tmux.
alias tmd="tmux detach -a"
alias tma="tmux attach -d"
alias tmcp='tmux capture-pane -p -J -S - -E - | sed ‘s/[ \t]*$//’ | $EDITOR -'

# Nvim.
alias vim=nvim
alias vi=nvim
