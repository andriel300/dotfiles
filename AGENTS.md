# AGENTS.md - Dotfiles Repository Guide

## Overview

This is a dotfiles repository containing configuration files for a Hyprland-based Linux desktop environment. It is managed using **GNU stow** to create symlinks from `~/.config/` to this repository.

## Repository Structure

```
dotfiles/
├── .config/           # Main configuration directory
│   ├── hypr/          # Hyprland compositor config
│   ├── nvim/          # Neovim (LazyVim) config
│   ├── alacritty/     # Terminal config
│   ├── ghostty/       # Terminal config
│   ├── kitty/         # Terminal config
│   ├── rofi/          # App launcher config
│   ├── dunst/         # Notification daemon
│   ├── picom/         # Compositor
│   ├── fastfetch/     # System info display
│   ├── lazygit/       # Git TUI config
│   └── ...            # Other app configs
├── scripts/           # Shell scripts for system management
├── .zshrc             # Zsh configuration
└── .tmux.conf         # Tmux configuration
```

## Installation

```bash
# Clone the repository
git clone https://github.com/andriel300/dotfiles.git
cd dotfiles

# Create symlinks using GNU stow
stow .
# Or to overwrite existing configs:
stow --adopt .
```

## Build/Lint/Test Commands

This is a configuration repository, not a software project. There are no build or test commands.

- **No build system** (no Makefile, no package.json, no Cargo.toml)
- **No tests** to run
- **No CI/CD** pipeline

When editing configs, verify manually by restarting the relevant application.

## Code Style Guidelines

### General Principles

- Configuration files follow the conventions of each application
- Use comments to document non-obvious settings
- Keep configs modular (Hyprland uses `source` directives for splitting)

### Neovim (Lua)

- Uses **LazyVim** framework
- Follows **LazyVim** conventions (see `.config/nvim/lazyvim.json`)
- Lua formatting: **Stylua** (see `.config/nvim/stylua.toml`)
  - Indent type: Tabs
  - Indent width: 2
  - Column width: 80
- Place custom configs in `.config/nvim/lua/`

### Hyprland Config

- Uses `.conf` syntax (key = value pairs)
- Modular structure in `.config/hypr/conf.d/`
- Keybindings in `keybinding.conf`
- Follows Hyprland v0.35+ syntax

### Shell Scripts (scripts/)

- Use `#!/usr/bin/env zsh` or `#!/usr/bin/env bash`
- Use `set -euo pipefail` for strict error handling
- Add descriptive comments for non-trivial scripts

### Terminal Configs

- **Alacritty**: TOML format (`.config/alacritty/alacritty.toml`)
- **Ghostty**: TOML format (`.config/ghostty/config`)
- **Kitty**:.conf format (`.config/kitty/kitty.conf`)

### Rofi Config

- Uses `.rasi` format (rasi is a CSS-like syntax)
- See `.config/rofi/config.rasi` for examples

### Environment Variables

- Set in `.zshrc` (zsh) or `.config/hypr/conf.d/03-environment.conf`
- Use `export VAR=value` syntax

## Common Tasks

### Reload a config without full restart

- Hyprland: `hyprctl reload` or `killall Hyprland` + restart
- Neovim: `:Lazy reload` or restart Neovim
- Shell: `source ~/.zshrc`

### Add a new application config

1. Create directory in `.config/`
2. Add your config files
3. Run `stow .` to create symlinks

## Notes for Agents

- This is a **dotfiles** repo, not an application repo
- Do NOT add build/test infrastructure
- When asked to "lint", understand there's nothing to lint
- Focus on maintaining consistency with existing configs
- Be careful with scripts in `scripts/` - they may modify the system