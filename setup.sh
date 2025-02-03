#!/bin/bash

# Setting up necessary directories
cd $DOTFILES_DIR/scripts

chmod +x dirs.sh
chmod +x apps.sh
./dirs.sh
./apps.sh

# Setting up dotfiles links

DOTFILES_DIR="$HOME/Repos/github.com/diogoguedes11/dotfiles"
XDG_CONFIG_HOME="$HOME/.config"
cd $DOTFILES_DIR

ln -sf "$DOTFILES_DIR/bash/.bash_profile" "$HOME/.bash_profile"
ln -sf "$DOTFILES_DIR/bash/.bashrc" "$HOME/.bashrc"
ln -sf "$DOTFILES_DIR/bash/.inputrc" "$HOME/.inputrc"
ln -sf "$DOTFILES_DIR/.tmux.conf" "$HOME/.tmux.conf"
ln -sf "$DOTFILES_DIR/k9s" "$XDG_CONFIG_HOME/k9s"
ln -sf "$DOTFILES_DIR/nvim" "$XDG_CONFIG_HOME/nvim"
ln -sf "$DOTFILES_DIR/alacritty" "$XDG_CONFIG_HOME/alacritty"
ln -sf "$DOTFILES_DIR/nvim" "$XDG_CONFIG_HOME/nvim"
ln -sf "$DOTFILES_DIR/vim" "$XDG_CONFIG_HOME/vim"
ln -sf "$DOTFILES_DIR/skhd" "$XDG_CONFIG_HOME/skhd"
