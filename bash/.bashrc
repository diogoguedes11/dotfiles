#
# ~/.bashrc
#
#
# Inspired by Mischa van der burg.

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# Set vi super mode
set -o vi

# keybinds
bind -x '"\C-l":clear'
# ~~~~~~~~~~~~~~~ Environment Variables ~~~~~~~~~~~~~~~~~~~~~~~~

export VISUAL=nvim
export EDITOR=nvim

# config
export BROWSER="edge"

# directories
export REPOS="$HOME/Repos"
export GITUSER="diogoguedes11"
export GHREPOS="$REPOS/github.com/$GITUSER"
export DOTFILES="$GHREPOS/dotfiles"
export LAB="$GHREPOS/lab"
export HOMELAB="$GHREPOS/homelab"
export SCRIPTS="$DOTFILES/scripts"
export ZETTELKASTEN="$HOME/Zettelkasten/second-brain/"
export DEVFOLDER="$REPOS/Development/"

# ~~~~~~~~~~~~~~~ History ~~~~~~~~~~~~~~~~~~~~~~~~

export HISTFILE=~/.histfile
export HISTSIZE=25000
export SAVEHIST=25000
export HISTCONTROL=ignorespace

# ~~~~~~~~~~~~~~~ Functions ~~~~~~~~~~~~~~~~~~~~~~~~

clone() {
  local repo="$1" user
  local repo="${repo#https://github.com/}"
  local repo="${repo#git@github.com:}"
  if [[ $repo =~ / ]]; then
    user="${repo%%/*}"
  else
    user="$GITUSER"
    [[ -z "$user" ]] && user="$USER"
  fi
  local name="${repo##*/}"
  local userd="$REPOS/github.com/$user"
  local path="$userd/$name"
  [[ -d "$path" ]] && cd "$path" && return
  mkdir -p "$userd"
  cd "$userd"
  echo gh repo clone "$user/$name" -- --recurse-submodule
  gh repo clone "$user/$name" -- --recurse-submodule
  cd "$name"
} && export -f clone

# ~~~~~~~~~~~~~~~ SSH ~~~~~~~~~~~~~~~~~~~~~~~~
# SSH Script from arch wiki

if ! pgrep -u "$USER" ssh-agent >/dev/null; then
  ssh-agent >"$XDG_RUNTIME_DIR/ssh-agent.env"
fi
if [[ ! "$SSH_AUTH_SOCK" ]]; then
  source "$XDG_RUNTIME_DIR/ssh-agent.env" >/dev/null
fi

# Only run on Ubuntu

#if [[ $(grep -E "^(ID|NAME)=" /etc/os-release | grep -q "ubuntu")$? == 0 ]]; then
#  eval "$(ssh-agent -s)" >/dev/null
#  eval "$(fzf --bash)"
#fi

# ~~~~~~~~~~~~~~~ Prompt ~~~~~~~~~~~~~~~~~~~~~~~~

eval "$(starship init bash)"

# ~~~~~~~~~~~~~~~ Aliases ~~~~~~~~~~~~~~~~~~~~~~~~

alias v=nvim

# cd
alias ..="cd .."
alias scripts='cd $SCRIPTS'

# Workflow
alias dot='cd $GHREPOS/dotfiles'
alias repos='cd $REPOS'
alias lab="cd $LAB"
alias homelab="cd $HOMELAB"
alias ghrepos='cd $GHREPOS'
alias c="clear"
alias d="cd $DEVFOLDER"

# ls
alias ls='ls --color=auto'
alias ll='ls -la'
alias la='ls -lathr'

# finds all files recursively and sorts by last modification, ignore hidden files
alias ld='find . -type f -not -path "*/\.*" -exec ls -lrt {} +'

alias sv='sudoedit'
alias t='tmux'
alias e='exit'
alias syu='sudo pacman -Syu'

# ~~~~~~~~~~~~ GIT ~~~~~~~~~~~~~~
alias gp='git push -f'
alias gc='git commit -m'
alias gs='git status'
alias ga='git add .'
alias gpull='git pull'
alias lg='lazygit'

# vim & second brain
alias in="cd \$ZETTELKASTEN/Inbox/"
alias zk="cd \$ZETTELKASTEN"

# terraform
alias tf='terraform'
alias tp='terraform plan'

# kubectl
alias k='kubectl'
alias kgp='kubectl get pods'
alias kc='kubectx'
alias kn='kubens'

# flux
source <(flux completion bash)
alias fgk='flux get kustomizations'

# completions
# source <(talosctl completion bash)
# source <(kubectl-cnp completion bash)
# source <(cilium completion bash)
# source <(devpod completion bash)

# fzf aliases
# use fp to do a fzf search and preview the files
alias fp="fzf --preview 'bat --style=numbers --color=always --line-range :500 {}'"
# search for a file with fzf and open it in vim
alias vf='v $(fp)'

# Only needed for npm install on WSL
#export NVM_DIR="$HOME/.config/nvm"
#[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"                   # This loads nvm
#[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion" # This loads nvm bash_completion

[ -f ~/.fzf.bash ] && source ~/.fzf.bash

### MANAGED BY RANCHER DESKTOP START (DO NOT EDIT)
export PATH="/Users/diogoguedes/.rd/bin:$PATH"
### MANAGED BY RANCHER DESKTOP END (DO NOT EDIT)

eval "$(starship init bash)"
eval "$(ssh-agent -s)"

source /usr/share/bash-completion/bash_completion
source <(kubectl completion bash)
complete -o default -F __start_kubectl k
