#!/bin/bash

set -e  # Exit immediately if a command exits with a non-zero status

# Colors for logging
RED='\033[0;31m'
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

log() {
    echo -e "${BLUE}[INFO] $1${NC}"
}

success() {
    echo -e "${GREEN}[SUCCESS] $1${NC}"
}

warn() {
    echo -e "${YELLOW}[WARN] $1${NC}"
}

error() {
    echo -e "${RED}[ERROR] $1${NC}"
}

# Keep sudo alive
ask_sudo() {
    sudo -v
    while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &
}

# --- OS DETECTION ---
get_os() {
    if [[ "$OSTYPE" == "darwin"* ]]; then
        echo "macos"
    elif [[ "$OSTYPE" == "linux-gnu"* ]]; then
        echo "linux"
    else
        error "Unsupported OS"
        exit 1
    fi
}

OS=$(get_os)

# --- PACKAGE MANAGER SETUP ---
setup_package_manager() {
    if [ "$OS" == "macos" ]; then
        if ! command -v brew &> /dev/null; then
            log "Installing Homebrew (macOS)..."
            /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
            # Add brew to path for the current session
            eval "$(/opt/homebrew/bin/brew shellenv)"
        else
            log "Homebrew already installed. Updating..."
            brew update
        fi
    elif [ "$OS" == "linux" ]; then
        log "Updating Apt (Linux)..."
        sudo apt update && sudo apt upgrade -y
        sudo apt install -y curl unzip build-essential wget gnupg git zsh
    fi
}

# --- INSTALL TOOLS ---
install_tools() {
    log "Installing Core & DevOps Tools..."

    if [ "$OS" == "macos" ]; then
        # List of Brew packages
        PACKAGES=(
            git wget curl zsh starship fzf bat tree
            stow jq ripgrep
            kubernetes-cli helm fluxcd/tap/flux
            terraform azure-cli gh
            visual-studio-code iterm2 docker raycast
            font-jetbrains-mono-nerd-font
        )

        brew install "${PACKAGES[@]}"

    elif [ "$OS" == "linux" ]; then
        # Linux specific installation (some tools need manual install or snap)
        sudo apt install -y fzf bat ripgrep stow jq

        # Install Azure CLI
        if ! command -v az &> /dev/null; then
            curl -sL https://aka.ms/InstallAzureCLIDeb | sudo bash
        fi

        # Install Kubectl
        if ! command -v kubectl &> /dev/null; then
            curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
            chmod +x kubectl
            sudo mv kubectl /usr/local/bin/
        fi

        # Install Helm
        if ! command -v helm &> /dev/null; then
            curl https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3 | bash
        fi
    fi
}

# --- SHELL CONFIGURATION ---
setup_shell() {
    log "Configuring ZSH & Starship..."

    # Install Oh My Zsh if missing
    if [ ! -d "$HOME/.oh-my-zsh" ]; then
        sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
    fi

    # Install Starship (Prompt)
    if ! command -v starship &> /dev/null; then
        curl -sS https://starship.rs/install.sh | sh -s -- --yes
    fi

    # Change default shell
    if [ "$SHELL" != "$(which zsh)" ]; then
        log "Changing default shell to ZSH..."
        chsh -s "$(which zsh)"
    fi
}

# --- DOTFILES LINKING ---
setup_dotfiles() {
    log "Linking Dotfiles using GNU Stow..."

    # Ensure dotfiles directory exists
    if [ -d "$HOME/dotfiles" ]; then
        cd "$HOME/dotfiles"
        # Only stow directories that exist in the repo
        for dir in zsh git starship; do
            if [ -d "$dir" ]; then
                log "Stowing $dir..."
                stow --target="$HOME" "$dir"
            fi
        done
        cd - > /dev/null
    else
        warn "Dotfiles directory (~/dotfiles) not found. Skipping Stow."
    fi
}

# --- EXECUTION FLOW ---
ask_sudo
log "Starting Setup for: $OS"
setup_package_manager
install_tools
setup_shell
setup_dotfiles

success "Setup Complete! Please restart your terminal."