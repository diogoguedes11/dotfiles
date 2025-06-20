# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.

# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Add wisely, as too many plugins slow down shell startup.
plugins=(

  autoupdate
  aws
  azure
  direnv
  docker
  encode64
  kubectl
  gcloud
  gh
  git
  helm
  npm
  pip
  ssh-agent
  sudo
  terraform
  wd
  zsh-autosuggestions
  zsh-history-substring-search
  zsh-syntax-highlighting

)
source $ZSH/oh-my-zsh.sh
eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"


# ========================= DIRS ======================================
export REPOS="$HOME/Repos"
export GITUSER="diogoguedes11"
export GHREPOS="$REPOS/github.com/$GITUSER"
export DOTFILES="$GHREPOS/dotfiles"
export LAB="$GHREPOS/lab"
export HOMELAB="$GHREPOS/homelab"
export SCRIPTS="$DOTFILES/scripts"
export DEVFOLDER="$REPOS/Development/"

export GOROOT=/usr/local/go
export GOPATH=$HOME/go
export PATH=$GOPATH/bin:$GOROOT/bin:$PATH

# ============================= ALIAS ============================= 

# Git
alias gcb='git checkout -b'
alias ga='git add .'
alias gc='git commit -m'
alias gp='git push origin'
alias gs='git status'
alias gitk='git log --graph'
# Terraform
alias tfa='terraform apply '
alias tfp='terraform plan'
alias tfi='terraform init'
alias tfd='terraform destroy'
alias v='vim'
# Google Cloud
alias gal='gcloud auth login'
alias gap='gcloud auth application-default login'
alias gitk='git log --graph'
# Listing files
alias ls='ls --color=auto'
alias ll='ls -la'
alias la='ls -lathr'
# Workflow
alias dot='cd $GHREPOS/dotfiles'
alias repos='cd $REPOS'
alias lab="cd $LAB"
alias homelab="cd $HOMELAB"
alias ghrepos='cd $GHREPOS'
alias c="clear"
alias d="cd $DEVFOLDER"
# kubectl
alias k='kubectl'
alias kgp='kubectl get pods'
alias kc='kubectx'
alias kn='kubens'
alias kgs='kubectl get services'


# ========================= PATHS ======================================
eval "$(direnv hook zsh)"
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
source <(kubectl completion zsh)
eval "$(starship init zsh)"
export PATH="$HOME/.local/bin:$PATH"
export PATH="$HOME/.tfenv/bin:$PATH"
eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh


wd() {
  . /home/diogo/bin/wd/wd.sh
}
