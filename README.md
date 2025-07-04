# Dotfiles

Personal dotfiles and setup scripts for quickly configuring a new Linux development environment.

## Features

- Automated installation of essential tools and CLI utilities
- Zsh with Oh My Zsh, plugins, and themes
- Starship prompt
- Homebrew for Linux
- FZF, direnv, Helm, Kubectl, Flux CD, Azure CLI, tfenv, k9s, and more
- Easily extensible for your own preferences

## Quick Start

Clone this repository and run the install script:

```bash
git clone https://github.com/diogoguedes11/dotfiles.git
cd dotfiles
./install.sh
```

**Note:** The script will install packages using `apt` and may prompt for your password.

## What Gets Installed

- **Zsh** and [Oh My Zsh](https://ohmyz.sh/)
  - Plugins: zsh-autosuggestions, zsh-syntax-highlighting, wd
- **Starship** prompt
- **Homebrew** for Linux
- **FZF** (fuzzy finder)
- **direnv**
- **Helm**
- **Kubectl**
- **Flux CD**
- **Azure CLI**
- **tfenv**
- **k9s**
- Other essentials: curl, git, unzip, build-essential, wget, gnupg, lsb-release, software-properties-common

## Customization

Feel free to modify `install.sh` to add or remove tools as needed.

## After Installation

- Restart your terminal or run `exec zsh` to start using Zsh and the new configuration.

## License

MIT