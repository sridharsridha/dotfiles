# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Overview

This is a personal dotfiles repository for macOS development environment configuration. The repository uses a Python-based installer (`install.py`) that manages dotfile installation through symlinks and can perform full macOS environment setup.

## Core Installation System

### Main Commands

```bash
# Install all dotfiles (default)
python3 install.py

# Install specific applications
python3 install.py -i zsh tmux neovim

# Delete specific dotfiles
python3 install.py -d git

# Full macOS setup (Homebrew, packages, SSH, GitHub auth)
python3 install.py --setup-macos

# Preview changes without executing
python3 install.py -i zsh --dry-run
```

### Configuration Architecture

The installer is driven by `config.yaml`, which defines:
- **Apps**: Each application has `install_steps` and `delete_steps` with actions like:
  - `symlink`: Link dotfiles from repo to home directory
  - `remove_symlink`: Remove symlinks
  - `run_command`: Execute shell commands
  - `ensure_dir`: Create directories
  - `install_fonts`/`delete_fonts`: Manage fonts
- **Path placeholders**: `$HOME`, `$CONFIG` (~/.config), `$PWD` (current directory)
- **Conditional installation**: Apps have `check` sections (e.g., `cmd_exists`, `dir_exists`)

When modifying `config.yaml`, follow the existing pattern of defining both install and delete steps for any new application.

## Repository Structure

### Shell Configuration

**Zsh** (primary shell):
- Entry point: `zsh/zshrc`
- Modular configuration in `zsh/zsh/`:
  - `functions.zsh`: Custom shell functions
  - `aliases.zsh`: Command aliases
  - `exports.zsh`: Environment variables
  - `history.zsh`: History configuration
  - `hooks.zsh`: Shell hooks
  - `bindings.zsh`: Key bindings
- Uses **Antigen** plugin manager for oh-my-zsh, autosuggestions, syntax highlighting
- Auto-installs fzf if missing

**Bash**: Available in `bash/` directory with bashrc, bash_profile, inputrc

### Neovim Configuration

Location: `nvim-2.0/`

Architecture:
- Entry point: `nvim-2.0/init.lua` loads modules from `lua/config/`:
  - `options.lua`: Editor options
  - `mappings.lua`: Key mappings
  - `autocmds.lua`: Autocommands
  - `lazy.lua`: Lazy.nvim plugin manager configuration
- Plugin configurations:
  - `lua/plugins/`: Active plugin configs
  - `lua/experimental/`: Experimental/alternative plugins
- Utilities: `lua/utils/`
- Uses **lazy.nvim** for plugin management

### Git Configuration

- Custom diff/merge tools using neovim-remote (nvr)
- Git LFS enabled
- User: sridharsridha <sridha.in@gmail.com>
- Default branch: master
- Local config override: `~/.gitconfig.local`

### Terminal Emulators

- **WezTerm**: `wezterm/wezterm.lua`
- **Ghostty**: `ghostty/config`
- **iTerm2**: Preferences in `iterm/` directory (loaded via defaults)

### Other Tools

- **tmux**: `tmux/tmux.conf`
- **bat**: Syntax highlighting cat replacement, config in `bat/config`
- **eza**: Modern ls replacement, config in `eza/`
- **yapf**: Python formatter config in `yapf/`

## Custom Utilities

### Shell Functions (zsh/zsh/functions.zsh)

Key functions for development:
- `cu <dirname>`: cd to an ancestral directory by name
- `copy-path [file]`: Copy absolute path to clipboard
- `crun <file.cpp>`: Compile and run C++ with sanitizers
- `cdebug <file.cpp>`: Compile C++ and launch in lldb
- `profVimStartUpTime`: Profile vim/nvim startup time
- `splitPane -h/-v/-s`: Smart tmux pane splitting
- `frg <pattern>`: Fuzzy ripgrep search with vim integration
- `gcauth`/`gcautht`: Google Cloud authentication helpers
- `same-files`: Check if files are identical using md5

### Work Script (scripts/work.py)

SSH/container workspace manager:
- Uses fzf for interactive container selection
- Supports mosh/ssh for remote connections
- Auto-launches tmux sessions on remote hosts
- Usage: `python3 scripts/work.py <userserver> [-a mosh] [-p port]`

## Development Workflow

### Adding New Dotfiles

1. Add application directory to repo root
2. Define configuration in `config.yaml`:
   - Add to `apps:` section
   - Specify `check` conditions
   - Define `install_steps` and `delete_steps`
3. Test with `--dry-run` flag
4. Run installer for that app

### Package Management

Packages installed during `--setup-macos`:
- **Brew packages**: eza, tmux, neovim, mosh, zsh, node, gh
- **Cask packages**: visual-studio-code, obsidian
- **NPM packages**: vim-language-server

Update package lists in `config.yaml` under `macos_setup` section.

## Git Workflow

- Uses neovim-remote for diffs and merges
- LFS enabled for large files
- Local config overrides in `~/.gitconfig.local` (not tracked)
- Hide dirty/status in oh-my-zsh git prompts

## Notes

- The installer preserves existing dotfiles as `.bkp` before symlinking
- Font installation copies TTF files from `fonts/` to `~/Library/Fonts`
- Submodules are auto-initialized during installation
- Local configuration files (`.zshrc.local`, `.zshrc.secure`, `.gitconfig.local`) are sourced if present but not tracked in git
