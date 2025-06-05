#!/bin/bash
set -e
# -- Zettelkasten and Development Repos --
setup_zettelkasten() {

  echo "Setting up Zettelkasten"
  mkdir -p ~/Zettelkasten/
  cd ~/Zettelkasten/
  git clone git@github.com:diogoguedes11/second-brain.git
  cd ~
}

setup_development() {

  echo "Setting up Development"
  mkdir -p ~/Repos/Development/
  mkdir -p ~/Repos/github.com/diogoguedes11/
  cd ~/Repos/github.com/diogoguedes11/
  git clone https://github.com/diogoguedes11/dotfiles
  git clone git@github.com:diogoguedes11/lab.git
  git clone git@github.com:diogoguedes11/diogoguedes11.git
  git clone git@github.com:diogoguedes11/homelab.git
  cd ~/Repos/Development/
  git clone git@github.com:diogoguedes11/cloud-projects.git
  cd ~
}

# setup_zettelkasten
setup_development

echo "[✔]  Development directories set up."