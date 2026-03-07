
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

function timezsh() {
  shell=${1-$SHELL}
  for i in $(seq 1 10); do time $shell -i -c exit; done
}

function gcauth() {
   gcloud auth application-default login
   gcloud auth application-default set-quota-project ${GOOGLE_CLOUD_PROJECT}
}

function gcautht() {
   gcloud auth application-default login --no-launch-browser
   gcloud auth application-default set-quota-project ${GOOGLE_CLOUD_PROJECT}
}

