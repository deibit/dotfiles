# ~/.zshrc

export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="robbyrussell"

plugins=(zsh-autosuggestions zsh-completions zsh-syntax-highlighting docker fzf)

# FZF
export FZF_DEFAULT_COMMAND='fd --type f --hidden --follow --exclude .git --exclude .ccls-cache'
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# Oh My Zsh
source $ZSH/oh-my-zsh.sh

# Alias
alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."
alias .....="cd ../../../.."
alias ......="cd ../../../../.."
alias gc="git commit -m"
alias gca="git commit -a -m"
alias gp="git push origin HEAD"
alias gpu="git pull origin"
alias gst="git status"
alias glog="git log --graph ..."
alias vim="nvim"
alias z="zoxide"
alias superenv='export $(cat .env)'

# Bindings
bindkey "^[^[[D" backward-word
bindkey "^[^[[C" forward-word

# Starship prompt
eval "$(starship init zsh)"

# uv completions
eval "$(uv generate-shell-completion zsh)"
eval "$(uvx --generate-shell-completion zsh)"

# direnv
eval "$(direnv hook zsh)"

# zoxide
eval "$(zoxide init zsh)"

# precmd fix
precmd_functions+=(_fix_cursor)
