# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.

# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"


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
fpath=(path/to/zsh-completions/src $fpath)
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

export GOROOT=/usr/local/go
export GOPATH=$HOME/go
export PATH=$GOPATH/bin:$GOROOT/bin:$PATH

# alias
alias gcb='git checkout -b'
alias ga='git add .'
alias gc='git commit -m'
alias gp='git push origin'
alias gs='git status'
alias tfa='terraform apply '
alias tfp='terraform plan'
alias v='vim'
alias gal='gcloud auth login'
alias gap='gcloud auth application-default login'
alias gitk='git log --graph'


# kubectl
alias k='kubectl'
alias kgp='kubectl get pods'
alias kc='kubectx'
alias kn='kubens'
alias kgs='kubectl get services'

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

eval "$(direnv hook zsh)"
eval "$(starship init zsh)"
export PATH="$PATH:/opt/nvim-linux64/bin"
export PATH="$HOME/.local/bin:$PATH"


