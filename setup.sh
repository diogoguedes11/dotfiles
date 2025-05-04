#!/bin/bash

# Setting up necessary directories
XDG_CONFIG_HOME="$HOME/.config"
DOTFILES_DIR="$HOME/Repos/github.com/diogoguedes11/dotfiles"

dotfiles=(
  .zshrc
)

folders=(
  vim
 # skhd
)

for file in "${dotfiles[@]}"; do
  ln -sf "$DOTFILES_DIR/zsh/$file" "$HOME/$file"
done
