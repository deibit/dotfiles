# ~/.zshrc

export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="robbyrussell"

plugins=(zsh-completions zsh-syntax-highlighting docker fzf ssh git docker docker-compose)

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

# ls alias
alias l="ls -lh"
alias la="ls -A"
alias ll="ls -lhA"

# cmds alias
alias c="clear"
alias brewup='brew update && brew upgrade && brew cleanup'

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

# bun completions
[ -s "/Users/davidgarcia/.bun/_bun" ] && source "/Users/davidgarcia/.bun/_bun"

# bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"

# codex completions
eval "$(codex completion zsh)"
