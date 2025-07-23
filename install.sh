#!/bin/bash

set -e

echo "[*] Updating system..."
sudo apt update
sudo apt upgrade -y

echo "[*] Installing essentials..."
sudo apt install -y curl git unzip build-essential wget gnupg lsb-release software-properties-common
# -- Git --
echo "[*] Setting up Git..."
sudo apt install -y git

# -- ZSH --
if ! command -v zsh &> /dev/null; then
    echo "[*] Installing ZSH..."
    sudo apt install -y zsh
    echo "[*] Setting ZSH as default shell..."
    if [ "$EUID" -eq 0 ]; then
        echo "[!] Please run this script as a regular user to change your shell."
    else
        chsh -s "$(which zsh)"
    fi
else
    echo "[*] ZSH is already installed."
fi
# -- Oh My Zsh --
if [ ! -d "$HOME/.oh-my-zsh/custom/plugins/zsh-autosuggestions" ]; then
    echo "[*] Installing Zsh Autosuggestions..."
    git clone https://github.com/zsh-users/zsh-autosuggestions.git "$HOME/.oh-my-zsh/custom/plugins/zsh-autosuggestions"
else
    echo "[*] Zsh Autosuggestions is already installed."
fi

# Install wd plugin
curl -L https://github.com/mfaerevaag/wd/raw/master/install.sh -o /tmp/wd_install.sh
# Optionally inspect /tmp/wd_install.sh before running
sh /tmp/wd_install.sh


if [ ! -d "$HOME/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting" ]; then
    echo "[*] Installing Zsh Syntax Highlighting..."
    git clone https://github.com/zsh-users/zsh-syntax-highlighting.git "$HOME/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting"
else
    echo "[*] Zsh Syntax Highlighting is already installed."
fi

# -- Starship --
if [ ! -f "$HOME/.config/starship.toml" ]; then
    echo "[*] Installing Starship..."
    curl -sS https://starship.rs/install.sh | sh -s -- --yes
else
    echo "[*] Starship is already installed."
fi

#  -- HOMEBREW --
#  -- HOMEBREW --
if ! command -v brew &> /dev/null; then
    echo "[*] Installing Homebrew..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
else
    echo "[*] Homebrew is already installed."
    eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
fi
# -- FZF --
if [ ! -d "$HOME/.fzf" ]; then
    echo "[*] Installing FZF..."
    git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
    ~/.fzf/install
else
    echo "[*] FZF is already installed."
fi

# -- direnv --
echo "[*] Installing direnv..."
sudo apt install -y direnv

# -- HELM --
if ! command -v helm &> /dev/null; then
    echo "[*] Installing Helm..."
    curl https://raw.githubusercontent.com/helm/helm/master/scripts/get-helm-3 | bash
else
    echo "[*] Helm is already installed."
fi

# -- Kubectl --
if ! command -v kubectl &> /dev/null; then
    echo "[*] Installing Kubectl..."
    curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
    chmod +x kubectl
    sudo mv kubectl /usr/local/bin/
else
    echo "[*] Kubectl is already installed."
fi

# -- Flux CD --
if ! command -v flux &> /dev/null; then
    echo "[*] Installing Flux CD..."
    curl -s https://fluxcd.io/install.sh | sudo bash
else
    echo "[*] Flux CD is already installed."
fi

# -- Azure CLI --
if ! command -v az &> /dev/null; then
    echo "[*] Installing Azure CLI..."
    curl -sL https://aka.ms/InstallAzureCLIDeb | sudo bash
else
    echo "[*] Azure CLI is already installed."
fi

# -- TFEnv --
# -- TFEnv --
if [ ! -d "$HOME/.tfenv" ]; then
    echo "[*] Installing TFEnv..."
    git clone https://github.com/tfutils/tfenv.git ~/.tfenv
else
    echo "[*] TFEnv is already installed."
fi

# -- k9s --
if ! command -v k9s &> /dev/null; then
    echo "[*] Installing k9s..."
    if ! command -v brew &> /dev/null; then
        eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
    fi
    brew install k9s
else
    echo "[*] k9s is already installed."
fi

echo "[✔] All tools installed."
echo "Please restart your terminal or run 'exec zsh' for ZSH, Oh My Zsh, and Starship to take effect."
echo "You may need to add Homebrew to your PATH if not already done."
