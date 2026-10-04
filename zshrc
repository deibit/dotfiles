# Oh My Zsh gestiona las funciones de zsh; Starship dibuja el prompt.
export ZSH="$HOME/.oh-my-zsh"
DOTFILES_PROFILE=fat
[[ -r "$XDG_CONFIG_HOME/dotfiles/profile" ]] &&
    IFS= read -r DOTFILES_PROFILE < "$XDG_CONFIG_HOME/dotfiles/profile"
[[ "$DOTFILES_PROFILE" == slim ]] || DOTFILES_PROFILE=fat
ZSH_THEME=''
[[ "$DOTFILES_PROFILE" == slim ]] && ZSH_THEME='robbyrussell'
plugins=(git)

fpath=("$HOME/.zfunc" $fpath)
if [[ -f "$ZSH/oh-my-zsh.sh" ]]; then
    source "$ZSH/oh-my-zsh.sh"
else
    autoload -Uz compinit
    compinit -i
fi

export FZF_DEFAULT_COMMAND='fd --type f --hidden --follow --exclude .git --exclude .ccls-cache'
if (( $+commands[fzf] )); then
    if fzf --zsh >/dev/null 2>&1; then
        eval "$(fzf --zsh)"
    elif [[ -f /usr/share/doc/fzf/examples/key-bindings.zsh ]]; then
        source /usr/share/doc/fzf/examples/key-bindings.zsh
    fi
fi

alias rm='rm -I'
alias ..='cd ..'
alias l='ls -lh'
alias la='ls -A'
alias ll='ls -lhA'
alias c='clear'
alias vim='nvim'
(( $+commands[brew] )) && alias brewup='brew update && brew upgrade && brew cleanup'

bindkey '^[^[[D' backward-word
bindkey '^[^[[C' forward-word

[[ "$DOTFILES_PROFILE" == fat ]] && (( $+commands[starship] )) && eval "$(starship init zsh)"
(( $+commands[direnv] )) && eval "$(direnv hook zsh)"
[[ "$DOTFILES_PROFILE" == fat ]] && (( $+commands[zoxide] )) && eval "$(zoxide init zsh)"

# La sintaxis se carga al final para que sus widgets no se sobrescriban.
[[ -f "$HOME/.local/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh" ]] &&
    source "$HOME/.local/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"

# Ajustes privados de esta máquina.
[[ -f "$HOME/.zshrc.local" ]] && source "$HOME/.zshrc.local"
