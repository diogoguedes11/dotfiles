#/bin/bash

os=$(cat /etc/os-release)

if echo "$os" | grep -o "Ubuntu"; then
  echo "Executing installer for Ubuntu..."
  # requirements
  sudo apt-get install build-essential procps curl file git

  # Install homebrew
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

  # Install fzf
  git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
  ~/.fzf/install

  # kubernetes
  curl -lo "https://dl.k8s.io/release/$(curl -l -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
  sudo install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl
  # tmux
  apt install tmux
  # vim
  apt install vim
  # k9s
  brew install derailed/k9s/k9s
  # Install starship
  curl -sS https://starship.rs/install.sh | sh
  # Obsidian
  sudo snap install obsidian --classic
fi
else
  echo "Installing in MacOS"
  # installing tmux
  brew install tmux
  # Install fzf
  git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
  ~/.fzf/install
  # installing vim 
  brew install vim 
  # installing k9s 
  brew install k9s
  # Window manager
  brew install koekeishiya/formulae/skhd
  skhd --start-service
  # Install starship
  curl -sS https://starship.rs/install.sh | sh
fi
