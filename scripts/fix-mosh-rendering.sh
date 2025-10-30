#!/bin/bash
# Quick script to fix mosh rendering issues with zsh-autosuggestions

echo "=== Mosh + ZSH Autosuggestions Rendering Fix ==="
echo ""

# Check if we're in a mosh session
if [[ -n "$MOSH_CONNECTION" ]]; then
    echo "✓ Currently in a MOSH session"
    echo "  MOSH_CONNECTION=$MOSH_CONNECTION"
elif [[ -n "$SSH_CONNECTION" ]]; then
    echo "✓ Currently in an SSH session"
    echo "  SSH_CONNECTION=$SSH_CONNECTION"
else
    echo "⚠ Not currently in a remote session"
    echo "  This script is most useful when run on a remote server"
fi

echo ""
echo "Current autosuggestions settings:"
echo "  Highlight style: ${ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE:-not set}"
echo "  Async mode: ${ZSH_AUTOSUGGEST_USE_ASYNC:-not set}"
echo "  Strategy: ${ZSH_AUTOSUGGEST_STRATEGY:-not set}"

echo ""
echo "=== Recommended Fixes ==="
echo ""
echo "1. SERVER SIDE (automatic - already applied if you sourced .zshrc):"
echo "   - Async autosuggestions enabled"
echo "   - Color optimized for mosh (fg=8 or fg=240)"
echo "   - Buffer limits applied"
echo ""
echo "2. CLIENT SIDE (your local machine - recommended):"
echo "   Add to your LOCAL ~/.zshrc or ~/.bashrc:"
echo ""
echo "   # Disable mosh prediction to prevent conflicts"
echo "   export MOSH_PREDICTION_DISPLAY=never"
echo ""
echo "   Then reconnect with: mosh user@server"
echo ""
echo "3. QUICK FIX for current session:"
echo "   Press Ctrl+L to refresh the display"
echo ""

# Offer to create a local config
echo ""
read -p "Apply server-side optimizations to ~/.zshrc.local? (y/n) " -n 1 -r
echo
if [[ $REPLY =~ ^[Yy]$ ]]; then
    cat >> ~/.zshrc.local << 'EOF'

# Mosh rendering fixes (added by fix-mosh-rendering.sh)
export ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=8'
export ZSH_AUTOSUGGEST_USE_ASYNC=1
export ZSH_AUTOSUGGEST_BUFFER_MAX_SIZE=20
export ZSH_AUTOSUGGEST_STRATEGY=(history completion)
EOF
    echo "✓ Added to ~/.zshrc.local"
    echo "  Reload with: source ~/.zshrc"
fi

echo ""
echo "For more details, see: ~/dotfiles/zsh/MOSH-FIXES.md"
