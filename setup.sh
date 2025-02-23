#!/bin/bash

# Setting up necessary directories
XDG_CONFIG_HOME="$HOME/.config"
DOTFILES_DIR="$HOME/Repos/github.com/diogoguedes11/dotfiles"

# Move into scripts folder
#cd scripts && chmod +x dirs.sh && chmod +x apps.sh
# Execute scripts
#./dirs.sh
#./apps.sh

# Root dotfiles directory
#cd ../

dotfiles=(
  .bash_profile
  .bashrc
  .inputrc
  .tmux.conf
)

folders=(
  k9s
  vim
 # skhd
)

for file in "${dotfiles[@]}"; do
  ln -sf "$DOTFILES_DIR/bash/$file" "$HOME/$file"
done

for folder in "${folders[@]}"; do
  ln -sf "$DOTFILES_DIR/$folder" "$XDG_CONFIG_HOME/$folder"
done
