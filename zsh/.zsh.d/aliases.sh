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
