# ==============================================================================
#  DIOGO GUEDES ZSH CONFIG
# ==============================================================================


# --- 2. Oh My Zsh Configuration ---
export ZSH="$HOME/.oh-my-zsh"

# OMZ Optimization settings (Disabling auto-checks for speed)
DISABLE_AUTO_UPDATE="true"
DISABLE_MAGIC_FUNCTIONS="true"
DISABLE_COMPFIX="true"

# Plugins allow you to extend Zsh functionality.
# Add wisely, as too many plugins slow down shell startup.
plugins=(
  wd                          # Warp directory -> jumps to shortcuts
  git                         # Git aliases and functions
  zsh-autosuggestions         # Suggests commands based on history (grey text)
  zsh-syntax-highlighting     # Green/Red highlighting for commands while typing
  # Recommendations for the future:
  # docker
  # kubectl
  # terraform
)

source $ZSH/oh-my-zsh.sh

# --- 3. Environment Variables & Custom Directories ---
export EDITOR="vim"
export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8

# Personal directory structure definition
export REPOS="$HOME/Repos"
export GITUSER="diogoguedes11"
export GHREPOS="$REPOS/github.com/$GITUSER"
export DOTFILES="$GHREPOS/dotfiles"
export LAB="$GHREPOS/lab"
export HOMELAB="$GHREPOS/homelab"
export SCRIPTS="$DOTFILES/scripts"
export DEVFOLDER="$REPOS/Development/"

# Go Lang Environment
export GOROOT=/usr/local/go
export GOPATH=$HOME/go
export PATH=$GOPATH/bin:$GOROOT/bin:$PATH

# NVM (Node Version Manager) initialization
# Note: NVM can slightly slow down shell startup.
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# --- 4. Aliases ---

# Workflow & Quick Navigation
alias ..='cd ..'
alias ...='cd ../..'
alias c="clear"
alias ls='ls --color=auto'
alias ll='ls -la'         # List all, long format
alias la='ls -lathr'      # List all, long format, sorted by time reversed

# Directory Shortcuts using variables defined above
alias dot='cd $DOTFILES'
alias repos='cd $REPOS'
alias lab="cd $LAB"
alias homelab="cd $HOMELAB"
alias ghrepos='cd $GHREPOS'
alias d="cd $DEVFOLDER"

# Git Shortcuts
alias g='git'
alias ga='git add .'
alias gc='git commit -m'
alias gcb='git checkout -b'
alias gp='git push origin'
alias gpl='git pull'
alias gs='git status'
# A better git log view
alias gitk='git log --graph --oneline --decorate --all'

# Terraform Shortcuts
alias tf='terraform'
alias tfa='terraform apply'
alias tfp='terraform plan'
alias tfi='terraform init'
alias tfd='terraform destroy'

# Kubernetes Shortcuts
alias k='kubectl'
alias kgp='kubectl get pods'
alias kgs='kubectl get services'
alias kgn='kubectl get nodes'
alias kd='kubectl describe'
# Requires 'kubectx' and 'kubens' tools installed
alias kc='kubectx'
alias kn='kubens'

# Google Cloud auth helper
alias gcloud-login='gcloud auth login && gcloud auth application-default login'

# Editor Shortcuts
alias v='vim'
alias code='code .' # Opens VS Code in the current directory

# --- 5. External Tools Initialization ---

# Direnv hook (loads environment variables upon entering a directory)
eval "$(direnv hook zsh)"

# FZF (Fuzzy Finder) bindings if installed
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# Kubernetes shell completion
source <(kubectl completion zsh)

# Google Cloud SDK paths and completion
if [ -f '/home/diogo/google-cloud-sdk/path.zsh.inc' ]; then . '/home/diogo/google-cloud-sdk/path.zsh.inc'; fi
if [ -f '/home/diogo/google-cloud-sdk/completion.zsh.inc' ]; then . '/home/diogo/google-cloud-sdk/completion.zsh.inc'; fi

# Anaconda/Miniconda Initialization block
# (Managed automatically by 'conda init')
# >>> conda initialize >>>
__conda_setup="$('/home/diogo/miniconda3/bin/conda' 'shell.bash' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/home/diogo/miniconda3/etc/profile.d/conda.sh" ]; then
        . "/home/diogo/miniconda3/etc/profile.d/conda.sh"
    else
        export PATH="/home/diogo/miniconda3/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<

# Starship Prompt Initialization
# Should be loaded near the end to capture previously set environments.
eval "$(starship init zsh)"

# Start ssh-agent and add key if not already loaded
if [ -z "$SSH_AUTH_SOCK" ] || ! ssh-add -l >/dev/null 2>&1; then
  eval "$(ssh-agent -s)" >/dev/null
  if [ -f "$HOME/.ssh/id_ed25519" ]; then
    ssh-add "$HOME/.ssh/id_ed25519" >/dev/null 2>&1
  fi
fi

# Ensure core system paths take precedence and remove duplicate PATH entries.
export PATH="/usr/local/bin:/usr/bin:$PATH"
typeset -U PATH
