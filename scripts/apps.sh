#/bin/bash

# Install packages (MACOS version)

brew install tmux

brew install --cask alacritty

# Install fzf
git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
~/.fzf/install

brew install neovim

brew install k9s

# Window manager
brew install koekeishiya/formulae/skhd
skhd --start-service
