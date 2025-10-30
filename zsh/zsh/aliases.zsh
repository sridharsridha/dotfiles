alias c='clear'
alias rm='rm -i'
alias cp='cp -iv'                            # Preferred 'cp' implementation
alias mv='mv -iv'                            # Preferred 'mv' implementation
alias grep='grep --color=auto'

# I like verbose in chmod & chown
alias chmod='chmod -v'
alias chown='chown -v'
alias sudo='sudo -E ' # Makes sudo use aliases, from https://askubuntu.com/a/22043/353466

alias search-txt='function _search(){find ./ -type f -exec grep --color=always -Hil "$1" {} \;};_search'
alias path='echo -e ${PATH//:/\\n}' # Formatted path

alias mkdir='mkdir -pv' # Verbose & Parents mkdir flag
alias d='dirs -v | head -10'

# Mosh.
alias moshk='kill `pidof mosh-server`' # Kill all mosh servers

# Tmux.
alias tmd="tmux detach -a"
alias tma="tmux attach -d"
alias tmcp='tmux capture-pane -p -J -S - -E - | sed ‘s/[ \t]*$//’ | $EDITOR -'

alias gclogin='gcloud auth application-default login'
alias gclogint='gcloud auth application-default login --no-launch-browser'
alias gcquota='gcloud auth application-default set-quota-project ${GOOGLE_CLOUD_PROJECT}'

if command -v eza &> /dev/null; then
   alias ls='eza --icons --color=always --group-directories-first'
   alias ll='eza -alF --icons --color=always --group-directories-first'
   alias la='eza -a --icons --color=always --group-directories-first'
   alias l='eza -F --icons --color=always --group-directories-first'
   alias l.='eza -a | egrep "^\."'
fi

