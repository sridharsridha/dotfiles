
# When I type a directory path, just cd to it.
setopt auto_cd

# ZSH notification for long commands.
# Source: <https://github.com/kevinywlui/zlong_alert.zsh/blob/master/zlong_alert.zsh>
# Use zsh/datetime for $EPOCHSECONDS
zmodload zsh/datetime || return

# Be sure we can actually set hooks
autoload -Uz add-zsh-hook || return

# Set commands to ignore if needed
zlong_ignore_cmds='vim ssh mo mongo man watch crontab pgcli tmux'

# Set as true to ignore commands starting with a space
zlong_ignorespace=true

# Need to set an initial timestamps otherwise, we'll be comparing an empty
# string with an integer.
zlong_timestamp=$EPOCHSECONDS

# Define the alerting function, do the text processing here
zlong_alert_func() {
	local cmd=$1
	local secs=$2
	local ftime=$(printf '%dh:%dm:%ds\n' $(($secs / 3600)) $(($secs % 3600 / 60)) $(($secs % 60)))
	# osascript -e "display notification \"Time taken: $ftime\" with title \"Completed $cmd\""
	echo -n "Finished in $ftime.\a"
}

zlong_alert_pre() {
	zlong_last_cmd=$1

	if [[ $zlong_ignorespace == 'true' && ${zlong_last_cmd:0:1} == [[:space:]] ]]; then
		# set internal variables to nothing ignoring this command
		zlong_last_cmd=''
		zlong_timestamp=0
	else
		zlong_timestamp=$EPOCHSECONDS
	fi

}

zlong_alert_post() {
	local duration=$(($EPOCHSECONDS - $zlong_timestamp))
	local lasted_long=$(($duration - ${REPORTTIME:-15}))
	local cmd_head=$(echo $zlong_last_cmd | awk '{printf $1}')
	if [[ $lasted_long -gt 0 && ! -z $zlong_last_cmd && ! $zlong_ignore_cmds =~ $cmd_head ]]; then
		zlong_alert_func $zlong_last_cmd duration
	fi
	zlong_last_cmd=''
}

add-zsh-hook preexec zlong_alert_pre
add-zsh-hook precmd zlong_alert_post

# Automatically list directory contents on `cd`.
# auto-ls () { ls -FG; }
# chpwd_functions=( auto-ls $chpwd_functions )

