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
