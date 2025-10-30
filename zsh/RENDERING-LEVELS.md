# ZSH Rendering Optimization Levels for Mosh

Choose the right configuration level based on your connection quality and rendering issues.

## The Problem

When using mosh, you may experience:
1. **Flickering characters** - Characters flash or change color as you type
2. **Cursor jumping** - Cursor jumps to start of line briefly
3. **Ghost characters** - Old text doesn't clear properly
4. **Delayed rendering** - Characters appear with lag

The main causes:
- **fast-syntax-highlighting**: Recolors text as you type (major cause)
- **zsh-autosuggestions**: Updates suggestions in real-time
- **Complex prompts**: Git status, colors, etc.
- **Mosh prediction**: Conflicts with ZSH features

## Level 1: Default Configuration (Optimized)

**What it includes:**
- All features enabled
- Automatic mosh detection and optimization
- Syntax highlighting with length limits
- Async autosuggestions

**Who it's for:** Good connections, minimal flickering acceptable

**How to use:** Already active by default after sourcing `~/.zshrc`

**Expected behavior:**
- ✓ Full syntax highlighting
- ✓ Git prompt info
- ✓ Autosuggestions
- ⚠ Slight flickering may occur on slower connections

---

## Level 2: Fast Prompt (Recommended for Mosh)

**What it disables:**
- Git prompt info
- Syntax highlighting
- Complex prompt formatting

**What it keeps:**
- Autosuggestions (optimized)
- Command history
- All functionality

**Who it's for:** Mosh users experiencing moderate flickering

**How to use:**
```bash
# Add to ~/.zshrc.local on the remote server
source ~/.zsh/fast-prompt.zsh
```

**Expected behavior:**
- ✓ Simple green prompt: `/path/to/dir$ `
- ✓ Dimmed autosuggestions (fg=240)
- ✓ No syntax color changes while typing
- ✗ No git branch info in prompt

**Files:** `zsh/zsh/fast-prompt.zsh`

---

## Level 3: Ultra-Minimal (For Problem Connections)

**What it disables:**
- Everything from Level 2, PLUS:
- Autosuggestions (made invisible)
- All syntax highlighting
- All prompt hooks

**What it keeps:**
- Basic prompt
- Command execution
- History (search with Ctrl+R)

**Who it's for:** Very slow connections or persistent flickering issues

**How to use:**
```bash
# Add to ~/.zshrc.local on the remote server
source ~/.zsh/ultra-minimal-prompt.zsh
```

**Expected behavior:**
- ✓ Plain text prompt: `/path/to/dir$ `
- ✓ Zero flickering
- ✓ Instant response
- ✗ No visual features at all

**Files:** `zsh/zsh/ultra-minimal-prompt.zsh`

---

## Client-Side Optimization (Important!)

**Do this on your LOCAL machine** (where you run mosh from):

### Best Fix: Disable Mosh Prediction

Add to your **local** `~/.zshrc`:
```bash
export MOSH_PREDICTION_DISPLAY=never
```

This single change often fixes all flickering issues!

**Why it works:** Mosh's client-side prediction tries to guess what will happen, conflicting with ZSH's real-time syntax highlighting and autosuggestions.

### Alternative: Adaptive Prediction
```bash
export MOSH_PREDICTION_DISPLAY=adaptive
```

Only uses prediction on high-latency connections.

---

## Quick Comparison Table

| Feature | Default | Fast Prompt | Ultra-Minimal |
|---------|---------|-------------|---------------|
| Syntax highlighting | ✓ (limited) | ✗ | ✗ |
| Autosuggestions | ✓ (async) | ✓ (dimmed) | ✗ |
| Git prompt | ✓ (cached) | ✗ | ✗ |
| Colored prompt | ✓ | ✓ (simple) | ✗ |
| Flickering | Low-Med | Very Low | None |
| Startup time | ~300ms | ~150ms | ~50ms |

---

## How to Switch Between Levels

### On the Remote Server

Edit `~/.zshrc.local`:

```bash
# Level 1: Default (comment out everything)
# (no additional config needed)

# Level 2: Fast prompt
source ~/.zsh/fast-prompt.zsh

# Level 3: Ultra-minimal
source ~/.zsh/ultra-minimal-prompt.zsh
```

Then reload:
```bash
source ~/.zshrc
```

### Testing

After changing levels, test:
```bash
# Type slowly and watch for flickering
ls -la /usr/local/bin

# Try backspacing
echo "hello world"
# (then backspace the entire line)

# Check autosuggestions (if enabled)
git
# (should see gray suggestion)
```

---

## Troubleshooting Specific Issues

### Issue: Cursor jumps to start of line
**Cause:** Syntax highlighting redrawing
**Fix:** Use Level 2 (fast-prompt) or disable syntax highlighting:
```bash
ZSH_HIGHLIGHT_MAXLENGTH=0
```

### Issue: Characters flicker/change color
**Cause:** fast-syntax-highlighting plugin
**Fix:** Use Level 2 or 3, or set client-side `MOSH_PREDICTION_DISPLAY=never`

### Issue: Suggestions don't clear
**Cause:** Mosh prediction conflicts
**Fix:** Client-side `export MOSH_PREDICTION_DISPLAY=never`

### Issue: Everything is slow
**Cause:** NVM, git checks, or plugins
**Fix:** Check `zsh/PERFORMANCE.md` for optimization guide

---

## Recommended Setup

**For most mosh users:**

1. **On local machine** `~/.zshrc`:
   ```bash
   export MOSH_PREDICTION_DISPLAY=never
   ```

2. **On remote server** `~/.zshrc.local`:
   ```bash
   source ~/.zsh/fast-prompt.zsh
   ```

3. **Reconnect:**
   ```bash
   mosh user@server
   ```

This gives you autosuggestions with minimal flickering.

---

## Files Reference

- `zsh/zsh/mosh-fixes.zsh` - Automatic fixes (always loaded on SSH/mosh)
- `zsh/zsh/fast-prompt.zsh` - Level 2 configuration
- `zsh/zsh/ultra-minimal-prompt.zsh` - Level 3 configuration
- `zsh/MOSH-FIXES.md` - Detailed troubleshooting guide
- `zsh/PERFORMANCE.md` - General performance optimization
- `scripts/fix-mosh-rendering.sh` - Diagnostic script
