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

eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
fpath=(path/to/zsh-completions/src $fpath)
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
#pick  enable GPG signing
export GPG_TTY=$(tty)
export GPGKEY=EACD6834F234349C
if [ ! -f ~/.gnupg/S.gpg-agent ]; then
	eval $( gpg-agent --daemon --options ~/.gnupg/gpg-agent.conf )
fi
export GPG_AGENT_INFO=${HOME}/.gnupg/S.gpg-agent:0:1

export GOROOT=/usr/local/go
export GOPATH=$HOME/go
export PATH=$GOPATH/bin:$GOROOT/bin:$PATH

export VISUAL=vim
export EDITOR=vim
export BROWSER="edge"

# ========================= DIRS ======================================
export REPOS="$HOME/Repos"
export GITUSER="diogoguedes11"
export GHREPOS="$REPOS/github.com/$GITUSER"
export DOTFILES="$GHREPOS/dotfiles"
export LAB="$GHREPOS/lab"
export HOMELAB="$GHREPOS/homelab"
export SCRIPTS="$DOTFILES/scripts"
export DEVFOLDER="$REPOS/Development/"

# ========================= HISTORY  ======================================
export HISTFILE=~/.histfile
export HISTSIZE=25000
export SAVEHIST=25000
export HISTCONTROL=ignorespace


# ============================= ALIAS ============================= 

# Git
alias gcb='git checkout -b'
alias ga='git add .'
alias gc='git commit -m'
alias gp='git push origin'
alias gs='git status'
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



eval "$(direnv hook zsh)"
source <(kubectl completion zsh)
eval "$(starship init zsh)"
source /usr/share/doc/fzf/examples/key-bindings.zsh
source /usr/share/doc/fzf/examples/completion.zsh
export PATH="$HOME/.local/bin:$PATH"


# The next line updates PATH for the Google Cloud SDK.
if [ -f '/home/diogo/google-cloud-sdk/path.zsh.inc' ]; then . '/home/diogo/google-cloud-sdk/path.zsh.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/home/diogo/google-cloud-sdk/completion.zsh.inc' ]; then . '/home/diogo/google-cloud-sdk/completion.zsh.inc'; fi
