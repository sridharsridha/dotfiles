#!/usr/bin/env bash

# Find out where Bash-it is located, with a reasonable fallback
__BASH_IT_INSTALL=${BASH_IT:-$HOME/bash/bash_it}

if [ ! -f "$__BASH_IT_INSTALL/bash_it.sh" ] ; then
  echo "Bash-it not found at $__BASH_IT_INSTALL."
  # shellcheck disable=SC2016
  echo 'Please set the $BASH_IT variable to point to your Bash-it installation.'
  exit 1
else
  echo "Bash-it location  : $__BASH_IT_INSTALL"
fi

# Bash-it needs to be sourced in order to call "bash-it show" in the script.
# shellcheck disable=SC1090
source "$__BASH_IT_INSTALL/bash_it.sh"

# Allow the user to provide a context name, e.g. 'home' or 'work'.
# If no context is provided, use 'default'.
BACKUP_FILE_NAME_CONTEXT=${1:-default}

BACKUP_FILE_NAME="$HOME/.homesick/repos/dotfiles/bash_it_config_$BACKUP_FILE_NAME_CONTEXT.sh"

echo "Backing up to file: $BACKUP_FILE_NAME"

# Reusable function that does the "bash-it show" parsing and prints the results
# in the desired format.
function __build-enable-array() {
  local component_type="$1"

  echo ""
  echo "# An array with the $component_type instances to enable"
  echo "__enable_$component_type=("
  # Parse the output of "bash-it show" to find out what is currently enabled,
  # then print each item to an array. Use one line per entry for easier diffing.
  bash-it show "$component_type" | grep "\\[x\\]" | awk '{print "  " $1}' | sort
  echo ")"
}

function __enable-component() {
  local component_type="$1"

  echo ""
  echo "# Disable all $component_type instances"
  echo "echo 'Disable all $component_type instances:'"
  # shellcheck disable=SC2016
  echo 'bash-it disable '"$component_type"' all'
  echo ""
  echo "# Enable all $component_type instances in one call"
  echo "echo 'Enable $component_type instances:'"
  # shellcheck disable=SC2016
  echo 'bash-it enable '"$component_type"' "${__enable_'"$component_type"'[@]}"'
  echo "echo ''"
}

# Print the desired output to the created file
{
  # Create the boiler plate code block first...
  cat <<'CONTENT_HEADER_END'
#!/usr/bin/env bash
CONTENT_HEADER_END

  # Now add the individual parts
  __build-enable-array "alias"
  __build-enable-array "completion"
  __build-enable-array "plugin"

  # Create the boiler plate code block first...
  cat <<'CONTENT_FOOTER_END'

# Find out where Bash-it is located, with a reasonable fallback
__BASH_IT_INSTALL=${BASH_IT:-$HOME/.bash_it}

if [ ! -f "$__BASH_IT_INSTALL/bash_it.sh" ] ; then
  echo "Bash-it not found at $__BASH_IT_INSTALL."
  # shellcheck disable=SC2016
  echo 'Please set the $BASH_IT variable to point to your Bash-it installation.'
  exit 1
else
  echo "Bash-it location  : $__BASH_IT_INSTALL"
fi

# shellcheck disable=SC1090
source "$__BASH_IT_INSTALL/bash_it.sh"

echo ''
CONTENT_FOOTER_END

  __enable-component "alias"
  __enable-component "completion"
  __enable-component "plugin"
} > "$BACKUP_FILE_NAME"

chmod +x "$BACKUP_FILE_NAME"
