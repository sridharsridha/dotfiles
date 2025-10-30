# Mosh-specific fixes for rendering issues
# This file is automatically sourced when using mosh/ssh

# Only apply these fixes when connected via mosh or ssh
if [[ -n "$SSH_CONNECTION" ]] || [[ -n "$MOSH_CONNECTION" ]]; then

  # Fix for mosh prediction interfering with zsh-autosuggestions
  # Disable mosh client-side prediction which causes rendering glitches
  # Note: This should be set on the CLIENT side before connecting
  # export MOSH_PREDICTION_DISPLAY=always  # or 'never' to fully disable

  # Widget to manually refresh the display when glitches occur
  function mosh-refresh() {
    zle reset-prompt
    zle -R
  }
  zle -N mosh-refresh

  # Bind Ctrl+L to clear screen AND refresh display
  function clear-and-refresh() {
    clear
    zle reset-prompt
    zle -R
  }
  zle -N clear-and-refresh
  bindkey '^L' clear-and-refresh

  # Additional autosuggestions widget fixes
  # Ensure autosuggestions play nice with mosh's character prediction
  ZSH_AUTOSUGGEST_MANUAL_REBIND=1

  # Partial accept with forward-char should work correctly
  ZSH_AUTOSUGGEST_PARTIAL_ACCEPT_WIDGETS=(
    forward-char
    forward-word
    emacs-forward-word
    vi-forward-char
    vi-forward-word
    vi-forward-word-end
    vi-forward-blank-word
    vi-forward-blank-word-end
    vi-find-next-char
    vi-find-next-char-skip
  )

  # Accept widgets should clear properly
  ZSH_AUTOSUGGEST_ACCEPT_WIDGETS=(
    end-of-line
    vi-end-of-line
    vi-add-eol
  )

  # Fix TERM for better color support
  if [[ "$TERM" == "screen" ]] || [[ "$TERM" == "screen-256color" ]]; then
    export TERM=screen-256color
  elif [[ "$TERM" == "xterm" ]]; then
    export TERM=xterm-256color
  fi

  # Reduce visual noise from suggestions
  # Make suggestions less bright to reduce flickering perception
  ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=240'

  # Disable or reduce syntax highlighting to prevent flickering
  # This is often the main cause of character jumping with mosh
  ZSH_HIGHLIGHT_MAXLENGTH=100  # Limit syntax highlighting to short commands

  # Optionally disable specific highlighters that cause most flickering
  # Uncomment the next line if you still see flickering:
  # ZSH_HIGHLIGHT_HIGHLIGHTERS=(main brackets)

fi
