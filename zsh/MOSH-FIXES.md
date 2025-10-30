# Mosh + ZSH Autosuggestions Rendering Fixes

This guide addresses rendering glitches with zsh-autosuggestions when using mosh to connect to remote servers.

## Problem

When using mosh with zsh-autosuggestions, you may see:
- Ghost characters or duplicate text
- Autosuggestions not clearing properly
- Flickering or jumpy cursor
- Characters appearing in wrong positions

This happens because mosh's client-side prediction conflicts with zsh-autosuggestions' rendering.

## Automatic Fixes Applied

The dotfiles now include automatic fixes for mosh connections:

### 1. Autosuggestions Configuration (`zsh/zsh/exports.zsh`)
- **Async mode**: Prevents blocking the main thread
- **Better color**: `fg=240` or `fg=8` (less bright, more stable)
- **Clear widgets**: Properly clears suggestions on actions
- **Buffer limits**: Prevents slowdown on long commands

### 2. Mosh-Specific Fixes (`zsh/zsh/mosh-fixes.zsh`)
- **Display refresh**: Ctrl+L now clears screen and refreshes display
- **Manual rebind**: Better widget compatibility
- **TERM fixes**: Ensures 256-color support

## Client-Side Mosh Configuration

For the best experience, configure mosh on your **local machine** (iTerm/client):

### Option 1: Disable Mosh Prediction (Most Reliable)
Add to your `~/.zshrc` or `~/.bashrc` on your **local machine**:
```bash
export MOSH_PREDICTION_DISPLAY=never
```

Then connect:
```bash
mosh user@server
```

This disables mosh's predictive text, eliminating conflicts entirely.

### Option 2: Adaptive Prediction (Balanced)
```bash
export MOSH_PREDICTION_DISPLAY=adaptive
```

Mosh will use prediction only when network latency is high.

### Option 3: Always Show Prediction
```bash
export MOSH_PREDICTION_DISPLAY=always
```

Shows predictions but may have more glitches.

## iTerm2-Specific Settings

In iTerm2 preferences:

1. **Profiles → Terminal → Terminal Emulation**
   - Report Terminal Type: `xterm-256color`

2. **Profiles → Text**
   - Enable "Use built-in Powerline glyphs" if using powerline fonts
   - Disable "Draw bold text in bright colors" (can cause rendering issues)

3. **Profiles → Keys**
   - Enable "Left Option key acts as: +Esc"
   - Enable "Right Option key acts as: +Esc"

## Manual Fix When Glitches Occur

If you see rendering glitches during a session:

1. **Press Ctrl+L**: This now clears screen AND refreshes the display
2. **Type any character then backspace**: Forces a redraw
3. **Press Esc then Ctrl+C**: Clears the line and resets state

## Testing the Fix

After applying these changes:

```bash
# 1. Reload your shell
source ~/.zshrc

# 2. Test autosuggestions
# Type a common command slowly and watch the suggestions
ls
cd
git status

# 3. Test that suggestions clear properly
# Type a partial command, see suggestion, then press Enter
# The suggestion should disappear cleanly
```

## Advanced Debugging

### Check if Mosh is Being Used
```bash
echo $MOSH_CONNECTION
echo $SSH_CONNECTION
```

If mosh is active, `$MOSH_CONNECTION` will be set.

### Check Current Autosuggestions Settings
```bash
echo $ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE
echo $ZSH_AUTOSUGGEST_USE_ASYNC
```

### Test Different Colors
Add to `~/.zshrc.local` and experiment:
```bash
# Try different gray levels (232-255 for grayscale)
export ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=8'    # dark gray
export ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=240'  # medium gray
export ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=244'  # lighter gray
```

### Disable Autosuggestions on Slow Connections
If the problem persists on very slow connections, add to `~/.zshrc.local` on the remote server:
```bash
# Disable autosuggestions entirely
ZSH_AUTOSUGGEST_MANUAL_REBIND=1
typeset -a ZSH_AUTOSUGGEST_STRATEGY
ZSH_AUTOSUGGEST_STRATEGY=()
```

## Progressive Solutions

If issues persist, try these configurations in order:

### Level 1: Fast Prompt (disables syntax highlighting)
```bash
# Add to ~/.zshrc.local on the remote server
source ~/.zsh/fast-prompt.zsh
```
Keeps autosuggestions but removes flickering from syntax highlighting.

### Level 2: Ultra-Minimal (disables everything)
```bash
# Add to ~/.zshrc.local on the remote server
source ~/.zsh/ultra-minimal-prompt.zsh
```
Plain prompt with zero visual features - guaranteed no flickering.

See `RENDERING-LEVELS.md` for detailed comparison of all levels.

## Known Issues

1. **tmux + mosh + autosuggestions**: Triple combination can be extra glitchy
   - Solution: Use `MOSH_PREDICTION_DISPLAY=never` or disable tmux status bar updates

2. **Very high latency (>500ms)**: Autosuggestions may lag behind typing
   - Solution: Increase `ZSH_AUTOSUGGEST_BUFFER_MAX_SIZE=10` (lower = faster)

3. **Wide characters or emoji**: Can cause misalignment
   - This is a known mosh limitation with wide characters

## Verifying the Fix Works

After setup, you should see:
- ✅ Smooth, gray autosuggestions as you type
- ✅ Suggestions disappear cleanly when you press Enter
- ✅ No ghost characters or duplicated text
- ✅ Cursor stays in the correct position

If problems persist, try the client-side mosh configuration above.
