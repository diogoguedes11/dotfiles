# dotfiles

My personal dotfiles for macOS/Linux and Windows development environments.

## Quick Setup

### macOS/Linux

```bash
./setup.sh
```

### Windows

```powershell
./setup-windows.ps1
```

## What's Included

- **zsh**: Shell configuration
- **git**: Git configuration and aliases
- **ghostty**: Terminal emulator settings
- **starship**: Cross-shell prompt configuration

## Manual Linking (Optional)

If you prefer to use GNU Stow:

```bash
stow --target=$HOME zsh git ghostty
```
