# ~/.zshrc

export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="robbyrussell"

plugins=(zsh-autosuggestions zsh-completions zsh-syntax-highlighting docker fzf)

# FZF
export FZF_DEFAULT_COMMAND='fd --type f --hidden --follow --exclude .git --exclude .ccls-cache'
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# Oh My Zsh
source $ZSH/oh-my-zsh.sh

# rm alias
# If you want the non-confirmation version just invoque as: /bin/rm ...
alias rm="rm -I"

# cd alias
alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."

# ls alias
alias l="ls -lh"
alias la="ls -A"
alias ll="ls -lhA"

# cmds alias
alias c="clear"
alias t="tree -L 2"
alias k9="kill -9"
alias top10mem="ps aux --sort=-%mem | head -n 10"
alias top10cpu="ps aux --sort=-%cpu | head -n 10"
alias brewup='brew update && brew upgrade && brew cleanup'

# Git alias
alias gc="git commit -m"
alias gca="git commit -a -m"
alias gp="git push origin HEAD"
alias gpu="git pull origin"
alias gst="git status"
alias glog="git log --graph ..."

# Docker alias
alias dco="docker compose"
alias dps="docker ps"
alias dpa="docker ps -a"
alias dl="docker ps -l -q"
alias dx="docker exec -it"

# Misc alias
alias vim="nvim"
alias z="zoxide"
alias superenv='export $(cat .env)'

# Bindings
bindkey "^[^[[D" backward-word
bindkey "^[^[[C" forward-word

# Starship prompt
eval "$(starship init zsh)"

# uv
eval "$(uv generate-shell-completion zsh)"

# direnv
eval "$(direnv hook zsh)"

# zoxide
eval "$(zoxide init zsh)"

# precmd fix
precmd_functions+=(_fix_cursor)

# Added by LM Studio CLI (lms)
export PATH="$PATH:/Users/davidgarcia/.cache/lm-studio/bin"
# End of LM Studio CLI section

# for completions (as rustup)
fpath=("$HOME/.zfunc" $fpath)
autoload -Uz compinit
compinit
