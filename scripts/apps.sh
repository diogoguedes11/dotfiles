#/bin/bash

# Install packages (MACOS version)

MACOS_INFO=$OSTYPE

if [[ -z $MACOS_INFO ]]; then
  echo "Executing installer for Linux..."
  # requirements
  sudo apt-get install build-essential procps curl file git

  # brew installation
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

  # Install fzf
  git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
  ~/.fzf/install

  # kubernetes
  curl -lo "https://dl.k8s.io/release/$(curl -l -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
  sudo install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl
  # tmux
  apt install tmux
  # neovim
  snap install nvim --classic
  # k9s
  brew install derailed/k9s/k9s

else
  echo "Installing in MacOS"
  # installing tmux
  brew install tmux
  # installing alacritty
  brew install --cask alacritty
  # Install fzf
  git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
  ~/.fzf/install
  # installing neovim
  brew install neovim
  # installing neovim
  brew install k9s
  # Window manager
  brew install koekeishiya/formulae/skhd
  skhd --start-service
fi
