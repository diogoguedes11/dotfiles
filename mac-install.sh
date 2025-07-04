#!/bin/bash

# Homebrew install (if missing)
if ! command -v brew &> /dev/null; then
  echo "Installing Homebrew..."
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

echo "Updating Homebrew..."
brew update

# CLI Essentials
brew install git wget curl jq tree 

# Docker & Containers
brew install --cask docker
brew install kubectl helm  

# Cloud CLIs
brew install azure-cli google-cloud-sdk

# Infra as Code
brew install terraform ansible


# Package Managers
brew install npm pyenv


# Install k9s
brew install k9s

# Dev Utilities
brew install --cask iterm2 visual-studio-code 

# Zsh + Oh My Zsh
brew install zsh zsh-autosuggestions zsh-syntax-highlighting
if [ ! -d "$HOME/.oh-my-zsh" ]; then
  echo "Installing Oh My Zsh..."
  sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
fi

echo "DevOps setup complete! Please restart your terminal."