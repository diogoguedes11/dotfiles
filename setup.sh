#!/bin/bash

DOTFILES_DIR="$HOME/Repos/github.com/diogoguedes11/dotfiles"
XDG_CONFIG_HOME="$HOME/.config"

ln -sf "$DOTFILES_DIR/bash/.bash_profile" "$HOME/.bash_profile"
ln -sf "$DOTFILES_DIR/bash/.bashrc" "$HOME/.bashrc"
ln -sf "$DOTFILES_DIR/bash/.inputrc" "$HOME/.inputrc"
ln -sf "$DOTFILES_DIR/.tmux.conf" "$HOME/.tmux.conf"
ln -sf "$DOTFILES_DIR/k9s" "$XDG_CONFIG_HOME/k9s"
ln -sf "$DOTFILES_DIR/nvim" "$XDG_CONFIG_HOME/nvim"
