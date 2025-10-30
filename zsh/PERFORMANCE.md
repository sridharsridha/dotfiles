# ZSH Performance Optimization Guide

This guide helps you optimize zsh startup and prompt rendering time, especially for remote servers accessed via mosh/ssh.

## What's Already Optimized

The following optimizations are now built into the default zshrc:

1. **Git prompt caching**: Git status is only checked every 60 seconds instead of on every prompt
2. **Disabled untracked files check**: `DISABLE_UNTRACKED_FILES_DIRTY=true` speeds up git status
3. **Lazy NVM loading**: NVM is only loaded when you actually use node/npm/npx
4. **Conditional plugins**: `command-not-found` and `alias-tips` are disabled on SSH connections

## For Very Slow Remote Servers

If you're still experiencing slowness on a remote server, add this to your `~/.zshrc.local` on that server:

```bash
# Use fast prompt without git info
source ~/.zsh/fast-prompt.zsh
```

This replaces the oh-my-zsh theme with a simple, fast prompt and disables all git checks.

## Measuring Performance

### Quick Test
Run this to see your current zsh startup time:
```bash
time zsh -i -c exit
```

### Detailed Profile
Use the profiling script:
```bash
cd ~/dotfiles/zsh
chmod +x profile-zsh.sh
./profile-zsh.sh
```

### Find Slow Parts
Add to the top of your `~/.zshrc`:
```bash
zmodload zsh/zprof
```

Add to the bottom:
```bash
zprof
```

Then run:
```bash
zsh -i -c exit
```

## Common Slowness Causes

1. **Git repositories with many files**: The git prompt checks status on every command
   - Solution: Use `DISABLE_UNTRACKED_FILES_DIRTY=true` (already enabled)
   - Alternative: Use the fast-prompt.zsh

2. **NVM loading**: Takes 200-500ms on every shell startup
   - Solution: Lazy loading (already implemented)

3. **Large history files**: Can slow down history operations
   - Check: `wc -l ~/.zsh_history`
   - Solution: Trim if over 50,000 lines

4. **Network-mounted home directories**: I/O operations are slow
   - Solution: Use local shell config if possible

5. **Antigen plugin updates**: Checks for updates periodically
   - Solution: Disable with `export ANTIGEN_AUTO_CONFIG=false`

## Additional Optimizations

### Disable Syntax Highlighting on Remote Servers
Add to `~/.zshrc.local`:
```bash
# Disable syntax highlighting (saves ~50ms per prompt)
ZSH_HIGHLIGHT_MAXLENGTH=0
```

### Skip All Git Info
Add to `~/.zshrc.local`:
```bash
export DISABLE_MAGIC_FUNCTIONS=true
export DISABLE_AUTO_UPDATE=true
export DISABLE_UPDATE_PROMPT=true
```

### Minimal Plugin Set
Create a `~/.zshrc.local` with:
```bash
# Skip slow plugins
export ZSH_DISABLE_COMPFIX=true
typeset -ag precmd_functions
typeset -ag preexec_functions
```

## Benchmarks

Expected startup times:
- **Local machine**: 100-300ms
- **Remote server (optimized)**: 200-500ms
- **Remote server (with fast-prompt)**: 50-150ms

If you're seeing >1 second startup times, investigate using the profiling tools above.
