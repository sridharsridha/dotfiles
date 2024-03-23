
function ialias { # If command you want to alias to exists, do it, else print an error
	if command -v $2 >/dev/null 2>&1; then
		alias $1=$2
	elif [[ "$ialias_mute" != 'true' ]]; then
		#echo "Command '$baseCmd' not found, using '$oldCmd'"
		true
		#alias $oldCmd='echo "Command $baseCmd not found, using $oldCmd" && $oldCmd'
	fi
}

function ipath { # If directory exists, add it to path
	dir="$1"

	if [ -d $dir ]; then
		export PATH="$PATH:$dir"
	fi
}

function = { # Simple Calculator
	calc="${@//p/+}"
	calc="${calc//x/*}"
	bc -l <<<"scale=10;$calc"
}

function profVimStartUpTime() {
	if [[ "$1" == "" ]]; then
		cmd=nvim
	else
		cmd=$1
	fi
	rm -rf ~/profile.log 2>&1 > /dev/null
	$cmd --cmd 'profile start ~/profile.log' \
		--cmd 'profile func *' \
		--cmd 'profile file *' \
		-c 'profdel func *' \
		-c 'profdel file *' \
		-c 'qa!'
			$cmd ~/profile.log
}

function cdebug() {
	if [[ -a $1 ]]; then
		outname=$1:t:r
		ext=$1:t:e
		# compile the binary
		rm /tmp/$outname &> /dev/null
		if [[ $ext == 'cpp' ]]; then
			g++ -std=c++17 -Wshadow -Wall -fsanitize=address -fsanitize=undefined -D_GLIBCXX_DEBUG -Wpedantic -Wno-unused-result -g $1 -o /tmp/$outname
		else
			exit -1
		fi
		if [ -f /tmp/$outname ]; then
			lldb /tmp/$outname
		fi
	fi
}

function crun() {
	if [[ -a $1 ]]; then
		outname=$1:t:r
		ext=$1:t:e
		# compile the binary
		rm /tmp/$outname &> /dev/null
		if [[ $ext == 'cpp' ]]; then
			g++ -std=c++17 -xc++ -fsanitize=address -fsanitize=undefined -Wno-unused-result -Wpedantic -Wshadow -Wall -O2 -Wno-unused-result $1 -o /tmp/$outname
		else
			exit -1
		fi
		if [ -f /tmp/$outname ]; then
			/tmp/$outname
		fi
	fi
}

# cd to an ancestral directory
function cu() {
	if [[ -z $1 ]]; then
		echo Please give a dirname
		return 1
	fi
	local d="$(dirname "$(pwd)")"
	while [[ "$(basename "$d")" != $1 ]] && [[ $d != "/" ]]; do
		d="$(dirname "$d")"
	done
	if [[ $d == "/" ]]; then
		echo \"$1\" is not present in current path
	else
		cd "$d"
	fi
}
# function _cu () {
# 	compadd $(dirname "$PWD" | tr / \\n)
# }
# compdef _cu cu

# Copy the full absolute path into the clipboard, and also echo it. Handles the
# path in the argument, if any, else `pwd`.
function copy-path() {
	local apath=
	if [[ -d "$1" ]]; then
		apath=$(cd "$1" && pwd)
	elif [[ -f "$1" ]]; then
		apath="$PWD/$1"
	fi
	echo -n $apath | pbcopy
	echo "Copied '$apath' to clipboard."
}

# Check if the given files (as arguments) are the same files, using md5 hashing.
function same-files() {
	local quite=false
	if [[ $1 == -q ]]; then
		quite=true
		shift
	fi
	if [[ "$(md5sum "$@" | cut -d' ' -f1 | uniq | wc -l)" == 1 ]]; then
		$quite || echo Yes. They are the same, according to md5 hashing.
	else
		$quite || echo No. They are NOT the same, according to md5 hashing.
		return 1
	fi
}

alias epoch-show='date +%s'
function epoch-read() {
	date --date @$1
}

# Freeze and unfreeze processes (for example: stop firefox)
function stop(){
  if [ $# -ne 1 ]; then
          echo 1>&2 Usage: stop process
  else
    PROCESS=$1
    echo "Stopping processes with the word ${tGreen}$1${tReset}"
    ps axw | grep -i $1 | awk -v PROC="$1" '{print $1}' | xargs kill -STOP
  fi
}

function cont(){
  if [ $# -ne 1 ]; then
          echo 1>&2 Usage: cont process
  else
    PROCESS=$1
    echo "Continuing processes with the word ${tGreen}$1${tReset}"
    ps axw | grep -i $1 | awk -v PROC="$1" '{print $1}' | xargs kill -CONT
  fi
}

# Revert all the files in the diff
#
# Param: 1 - diff file
# example: revert_diff test.diff
function revert_diff() {
   grep "+++" $1 | awk -F " " '{print $2}'  | xargs svn revert
}

function cscope_gen()
{
   rm -f cscope.files cscope.out cscope.po.out
   find `pwd` -name '[^.]*.[chlyCGHL]' -print | grep -v CVS > cscope.files
   cscope -buqk -F cscope.files
}

function image_clean(){
   docker rm -v $(docker ps --filter status=exited -q 2>/dev/null) 2>/dev/null
   docker rmi $(docker images --filter dangling=true -q 2>/dev/null) 2>/dev/null
}

function splitPane() {
   case "$1" in
      -h|--horizontal)
         shift 1
         splitBelow "$@" ;;
      -v|--vertical)
         shift 1
         splitRight "$@" ;;
      -s|--smart)
         shift 1
         smartSplit "$@" ;;
      *)
         echo "Unknown option '$1'" 1>&2
         return 2 ;;
   esac
}

function splitBelow() {
   tmux split-window -v -c '#{pane_current_path}' "$@"
}

function splitRight() {
   tmux split-window -h -c '#{pane_current_path}' "$@"
}

function smartSplit() {
   # NerdFont appear to have a 4:10 width:height ratio
   # adjust the coefficients to suite your font
   local ROWS=$(tmux display-message -p '#{pane_height}')
   local COLS=$(tmux display-message -p '#{pane_width}')
   # echo $((ROWS*10)) $((COLS*4))
   if [ $((ROWS*10)) -lt $((COLS*4)) ]; then
      splitRight "$@"
   else
      splitBelow "$@"
   fi
}

function frg() {
   [ $# -eq 0  ] && return
   local out cols
   if out=$(rg "$@" . --vimgrep | fzf --ansi); then
      setopt sh_word_split
      cols=(${out//:/  })
      unsetopt sh_word_split
      vim ${cols[1]} +"normal! ${cols[2]}zz"
   fi
}

timezsh() {
  shell=${1-$SHELL}
  for i in $(seq 1 10); do /usr/bin/time $shell -i -c exit; done
}
