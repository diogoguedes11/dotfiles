a#!/bin/bash

set -e

# Cores para logs
RED='\033[0;31m'
GREEN='\033[0;32m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

log() {
    echo -e "${BLUE}[*] $1${NC}"
}

success() {
    echo -e "${GREEN}[✔] $1${NC}"
}

error() {
    echo -e "${RED}[✘] $1${NC}"
}

ask_sudo() {
    sudo -v
    while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &
}

update_system() {
    log "Updating system..."
    sudo apt update && sudo apt upgrade -y
}

install_essentials() {
    log "Installing essentials (curl, git, build-essential, etc)..."
    sudo apt install -y curl unzip build-essential wget gnupg lsb-release software-properties-common direnv zsh
}

setup_zsh_omz() {
    if ! command -v zsh &> /dev/null; then
        log "Installing ZSH..."
        sudo apt install -y zsh
    fi

    if [ "$SHELL" != "$(which zsh)" ]; then
        log "Setting ZSH as default shell (requires password)..."
        chsh -s "$(which zsh)"
    else
        log "ZSH is already default shell."
    fi

    if [ ! -d "$HOME/.oh-my-zsh" ]; then
        log "Installing Oh My Zsh..."
        sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
    fi

    ZSH_CUSTOM=${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}

    if [ ! -d "$ZSH_CUSTOM/plugins/zsh-autosuggestions" ]; then
        log "Installing Zsh Autosuggestions..."
        git clone https://github.com/zsh-users/zsh-autosuggestions.git "$ZSH_CUSTOM/plugins/zsh-autosuggestions"
    fi

    if [ ! -d "$ZSH_CUSTOM/plugins/zsh-syntax-highlighting" ]; then
        log "Installing Zsh Syntax Highlighting..."
        git clone https://github.com/zsh-users/zsh-syntax-highlighting.git "$ZSH_CUSTOM/plugins/zsh-syntax-highlighting"
    fi

    if [ ! -d "$ZSH_CUSTOM/plugins/wd" ]; then
         log "Installing 'wd' plugin..."
         git clone https://github.com/mfaerevaag/wd.git "$ZSH_CUSTOM/plugins/wd"
    fi

    if ! command -v starship &> /dev/null; then
        log "Installing Starship..."
        curl -sS https://starship.rs/install.sh | sh -s -- --yes
    else
        log "Starship already installed."
    fi
}

install_brew_and_tools() {
    if ! command -v brew &> /dev/null; then
        log "Installing Homebrew..."
        NONINTERACTIVE=1 /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

        if [ -f "/home/linuxbrew/.linuxbrew/bin/brew" ]; then
             eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
        fi
    else
        log "Homebrew is already installed."
        eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
    fi

    brew_tools=(k9s kubectx)
    for tool in "${brew_tools[@]}"; do
        if ! command -v "$tool" &> /dev/null; then
            log "Installing $tool via Homebrew..."
            brew install "$tool"
        else
            log "$tool is already installed."
        fi
    done
}

install_devops_tools() {
    if [ ! -d "$HOME/.fzf" ]; then
        log "Installing FZF..."
        git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
        ~/.fzf/install --all
    fi

    if ! command -v helm &> /dev/null; then
        log "Installing Helm..."
        curl https://raw.githubusercontent.com/helm/helm/master/scripts/get-helm-3 | bash
    fi

    if ! command -v kubectl &> /dev/null; then
        log "Installing Kubectl..."
        KUBECTL_VERSION=$(curl -L -s https://dl.k8s.io/release/stable.txt)
        curl -LO "https://dl.k8s.io/release/${KUBECTL_VERSION}/bin/linux/amd64/kubectl"
        chmod +x kubectl
        sudo mv kubectl /usr/local/bin/
    fi
    # FluxCD
    if ! command -v flux &> /dev/null; then
        log "Installing Flux CD..."
        curl -s https://fluxcd.io/install.sh | sudo bash
    fi

    # Azure CLI
    if ! command -v az &> /dev/null; then
        log "Installing Azure CLI..."
        curl -sL https://aka.ms/InstallAzureCLIDeb | sudo bash
    fi

    # TFEnv
    if [ ! -d "$HOME/.tfenv" ]; then
        log "Installing TFEnv..."
        git clone https://github.com/tfutils/tfenv.git ~/.tfenv
    fi
}


# -- Repositories Setup --
setup_repos() {
    log "Setting up directory structure and cloning repos..."
    # Usar -p para não dar erro se a pasta já existir
    mkdir -p ~/Zettelkasten/
    mkdir -p ~/Repos/Development/
    mkdir -p ~/Repos/github.com/diogoguedes11/

    # Função auxiliar para clonar se não existir
    clone_if_not_exists() {
        local repo_url=$1
        local dest_dir=$2
        if [ ! -d "$dest_dir/.git" ]; then
            log "Cloning $(basename "$dest_dir")..."
            git clone "$repo_url" "$dest_dir"
        else
            log "Repo $(basename "$dest_dir") already exists. Skipping."
        fi
    }

    # Zettelkasten
    clone_if_not_exists "git@github.com:diogoguedes11/second-brain.git" "$HOME/Zettelkasten/second-brain"

    # Development Repos
    cd ~/Repos/github.com/diogoguedes11/
    clone_if_not_exists "git@github.com:diogoguedes11/dotfiles.git" "dotfiles"
    clone_if_not_exists "git@github.com:diogoguedes11/lab.git" "lab"
    clone_if_not_exists "git@github.com:diogoguedes11/diogoguedes11.git" "diogoguedes11"
    clone_if_not_exists "git@github.com:diogoguedes11/homelab.git" "homelab"

    # Cloud Projects
    clone_if_not_exists "git@github.com:diogoguedes11/cloud-projects.git" "$HOME/Repos/Development/cloud-projects"

    cd ~
}


# ==============================================
# EXECUTE
# ==============================================
ask_sudo
update_system
install_essentials
setup_zsh_omz
install_brew_and_tools
install_devops_tools

log "SYSTEM TOOLS INSTALLED. Now setting up repos..."
log "⚠️  Ensure your SSH keys are authorized on GitHub, or the next steps will fail."
sleep 3

setup_repos

success "Bootstrapping complete!"
log "Please log out and log back in for all shell changes (ZSH, Brew PATH, groups) to take effect."