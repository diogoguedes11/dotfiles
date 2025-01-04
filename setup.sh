#!/bin/bash

DOTFILES_DIR="$HOME/Repos/github.com/diogobytes/dotfiles"
XDG_CONFIG_HOME="$HOME/.config"

create_directories() {
  local directories=("$@")
  for dir in "${directories[@]}"; do
    mkdir -p "$dir"
  done
}

create_symlinks() {
  local items=("$@")
  for item in "${items[@]}"; do
    IFS=':' read -r source target <<<"$item"
    if [ -L "$target" ]; then
      echo "Removing existing symlink $target"
      unlink "$target"
    elif [ -d "$target" ]; then
      echo "Warning: $target is a directory. Skipping..."
      continue
    elif [ -e "$target" ]; then
      echo "Warning: $target already exists. Skipping..."
      continue
    fi
    ln -s "$DOTFILES_DIR/$source" "$target"
    echo "Created symlink for $source"
  done
}

common_directories=(
  "$XDG_CONFIG_HOME/alacritty"
  "$XDG_CONFIG_HOME/alacritty/themes"
  "$XDG_CONFIG_HOME/skhd"
  "$XDG_CONFIG_HOME/k9s"
)

common_items=(
  "alacritty.toml:$XDG_CONFIG_HOME/alacritty/alacritty.toml"
  "k9s/skin.yml:$XDG_CONFIG_HOME/k9s/skin.yml"
  ".inputrc:$HOME/.inputrc"
  ".tmux.conf:$HOME/.tmux.conf"
  "nvim:$XDG_CONFIG_HOME/nvim"
  "skhdrc:$XDG_CONFIG_HOME/skhd/skhdrc"
  ".zprofile:$HOME/.zprofile"
  ".zshrc:$HOME/.zshrc"
)

create_directories "${common_directories[@]}"
create_symlinks "${common_items[@]}"

# bash symlink

ln -sf "$DOTFILES_DIR/bash/.bash_profile" "$HOME"/.bash_profile
ln -sf "$DOTFILES_DIR/bash/.bashrc" "$HOME"/.bashrc
