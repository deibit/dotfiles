#!/bin/sh
set -eu

if [ "$(id -u)" -eq 0 ]; then
    echo 'Ejecuta el instalador como usuario normal; solo apt pedirá sudo.' >&2
    exit 1
fi

repo=$(CDPATH= cd -- "$(dirname -- "$0")" && pwd)
config_home=${XDG_CONFIG_HOME:-"$HOME/.config"}
bin_home="$HOME/.local/bin"
tmp=$(mktemp -d)
trap 'rm -rf "$tmp"' EXIT HUP INT TERM

log() { printf '%s\n' "==> $*"; }

link_file() {
    source=$1
    target=$2
    if [ ! -e "$source" ]; then
        echo "Falta el archivo del repositorio: $source" >&2
        exit 1
    fi
    mkdir -p "$(dirname "$target")"
    if [ -L "$target" ] && [ "$(readlink "$target")" = "$source" ]; then
        return
    fi
    if [ -e "$target" ] || [ -L "$target" ]; then
        backup="$target.backup.$(date +%Y%m%d%H%M%S)"
        while [ -e "$backup" ] || [ -L "$backup" ]; do backup="$backup.1"; done
        mv "$target" "$backup"
        log "Copia previa: $backup"
    fi
    ln -s "$source" "$target"
    log "Enlace: $target"
}

install_packages() {
    case "$(uname -s)" in
        Darwin)
            if [ -x /opt/homebrew/bin/brew ]; then
                eval "$(/opt/homebrew/bin/brew shellenv)"
            elif [ -x /usr/local/bin/brew ]; then
                eval "$(/usr/local/bin/brew shellenv)"
            fi
            if ! command -v brew >/dev/null 2>&1; then
                log 'Instalando Homebrew'
                curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh -o "$tmp/homebrew.sh"
                /bin/bash "$tmp/homebrew.sh"
                if [ -x /opt/homebrew/bin/brew ]; then
                    eval "$(/opt/homebrew/bin/brew shellenv)"
                elif [ -x /usr/local/bin/brew ]; then
                    eval "$(/usr/local/bin/brew shellenv)"
                fi
            fi
            set --
            for package in git zsh tmux neovim fzf fd ripgrep direnv starship uv zoxide node go python tree-sitter-cli cppcheck; do
                if ! brew list --versions "$package" >/dev/null 2>&1; then
                    set -- "$@" "$package"
                fi
            done
            if [ "$#" -gt 0 ]; then
                log 'Instalando herramientas ausentes con Homebrew'
                brew install "$@"
            fi
            if [ ! -x "$(brew --prefix)/bin/zsh" ]; then
                brew link zsh
            fi
            ;;
        Linux)
            if ! command -v apt-get >/dev/null 2>&1; then
                echo 'Por ahora Linux necesita apt-get.' >&2
                exit 1
            fi
            set --
            for package in ca-certificates curl git zsh tmux fzf ripgrep fd-find direnv nodejs python3 python3-venv ncurses-term unzip build-essential cppcheck; do
                if [ "$(dpkg-query -W -f='${Status}' "$package" 2>/dev/null || true)" != 'install ok installed' ]; then
                    set -- "$@" "$package"
                fi
            done
            if [ "$#" -gt 0 ]; then
                log 'Instalando herramientas ausentes con apt'
                sudo apt-get update
                sudo apt-get install -y "$@"
            fi
            # NodeSource incluye npm en nodejs; Ubuntu lo distribuye por separado.
            if ! command -v npm >/dev/null 2>&1; then
                log 'Instalando npm ausente con apt'
                sudo apt-get install -y npm
            fi
            mkdir -p "$bin_home"
            if ! command -v fd >/dev/null 2>&1; then
                link_file "$(command -v fdfind)" "$bin_home/fd"
            fi
            export PATH="$bin_home:$PATH"

            case "$(uname -m)" in
                x86_64|amd64) arch=x86_64 ;;
                aarch64|arm64) arch=arm64 ;;
                *) echo 'Neovim solo tiene archivo oficial para x86_64 y arm64 en este instalador.' >&2; exit 1 ;;
            esac
            if [ ! -x "$HOME/.local/opt/nvim/bin/nvim" ]; then
                log 'Instalando Neovim estable desde su archivo oficial'
                curl -fsSL "https://github.com/neovim/neovim/releases/latest/download/nvim-linux-$arch.tar.gz" -o "$tmp/nvim.tar.gz"
                tar -xzf "$tmp/nvim.tar.gz" -C "$tmp"
                mkdir -p "$HOME/.local/opt"
                if [ -e "$HOME/.local/opt/nvim" ]; then
                    backup="$HOME/.local/opt/nvim.backup.$(date +%Y%m%d%H%M%S)"
                    while [ -e "$backup" ]; do backup="$backup.1"; done
                    mv "$HOME/.local/opt/nvim" "$backup"
                    log "Copia previa: $backup"
                fi
                mv "$tmp/nvim-linux-$arch" "$HOME/.local/opt/nvim"
            fi
            link_file "$HOME/.local/opt/nvim/bin/nvim" "$bin_home/nvim"

            if [ ! -x "$HOME/.local/opt/go/bin/go" ]; then
                log 'Instalando Go estable desde su archivo oficial'
                go_version=$(curl -fsSL 'https://go.dev/VERSION?m=text' | sed -n '1p')
                case "$go_version" in go[0-9]*.[0-9]*) ;; *) echo 'No se pudo determinar la versión de Go.' >&2; exit 1 ;; esac
                case "$arch" in x86_64) go_arch=amd64 ;; arm64) go_arch=arm64 ;; esac
                curl -fsSL "https://go.dev/dl/$go_version.linux-$go_arch.tar.gz" -o "$tmp/go.tar.gz"
                tar -xzf "$tmp/go.tar.gz" -C "$tmp"
                mkdir -p "$HOME/.local/opt"
                if [ -e "$HOME/.local/opt/go" ]; then
                    backup="$HOME/.local/opt/go.backup.$(date +%Y%m%d%H%M%S)"
                    while [ -e "$backup" ]; do backup="$backup.1"; done
                    mv "$HOME/.local/opt/go" "$backup"
                    log "Copia previa: $backup"
                fi
                mv "$tmp/go" "$HOME/.local/opt/go"
            fi
            link_file "$HOME/.local/opt/go/bin/go" "$bin_home/go"
            export GOROOT="$HOME/.local/opt/go"

            if [ ! -x "$HOME/.local/opt/tree-sitter" ]; then
                case "$arch" in x86_64) tree_sitter_arch=x64 ;; arm64) tree_sitter_arch=arm64 ;; esac
                log 'Instalando tree-sitter CLI desde su archivo oficial'
                curl -fsSL "https://github.com/tree-sitter/tree-sitter/releases/latest/download/tree-sitter-cli-linux-$tree_sitter_arch.zip" -o "$tmp/tree-sitter.zip"
                unzip -q "$tmp/tree-sitter.zip" -d "$tmp/tree-sitter"
                install -m 755 "$tmp/tree-sitter/tree-sitter" "$HOME/.local/opt/tree-sitter"
            fi
            link_file "$HOME/.local/opt/tree-sitter" "$bin_home/tree-sitter"

            if ! command -v uv >/dev/null 2>&1; then
                log 'Instalando uv'
                curl -fsSL https://astral.sh/uv/install.sh -o "$tmp/uv.sh"
                UV_NO_MODIFY_PATH=1 sh "$tmp/uv.sh"
            fi
            if ! command -v starship >/dev/null 2>&1; then
                log 'Instalando Starship'
                curl -fsSL https://starship.rs/install.sh -o "$tmp/starship.sh"
                sh "$tmp/starship.sh" -y -b "$bin_home"
            fi
            if ! command -v zoxide >/dev/null 2>&1; then
                log 'Instalando zoxide'
                curl -fsSL https://raw.githubusercontent.com/ajeetdsouza/zoxide/main/install.sh -o "$tmp/zoxide.sh"
                sh "$tmp/zoxide.sh" --bin-dir "$bin_home"
            fi
            ;;
        *) echo 'Solo se admite macOS y Linux.' >&2; exit 1 ;;
    esac

    omz_dir="$HOME/.oh-my-zsh"
    if [ ! -f "$omz_dir/oh-my-zsh.sh" ]; then
        if [ -e "$omz_dir" ] || [ -L "$omz_dir" ]; then
            echo "Existe $omz_dir, pero no contiene Oh My Zsh. Revísalo antes de continuar." >&2
            exit 1
        fi
        log 'Instalando Oh My Zsh'
        git clone --depth 1 https://github.com/ohmyzsh/ohmyzsh.git "$omz_dir"
    fi

    syntax_dir="$HOME/.local/share/zsh-syntax-highlighting"
    if [ ! -d "$syntax_dir/.git" ]; then
        log 'Instalando resaltado de sintaxis de zsh'
        git clone --depth 1 https://github.com/zsh-users/zsh-syntax-highlighting.git "$syntax_dir"
    fi

    for cmd in git zsh tmux nvim fzf fd rg direnv starship uv zoxide node npm python3 go tree-sitter cppcheck; do
        if ! command -v "$cmd" >/dev/null 2>&1; then
            echo "La instalación terminó sin el comando esperado: $cmd" >&2
            exit 1
        fi
    done
}

case "${1:-}" in
    '') install_packages ;;
    --link-only) log 'Instalando solo los enlaces' ;;
    *) echo 'Uso: ./install.sh [--link-only]' >&2; exit 2 ;;
esac

case "$(uname -s)" in
    Darwin) platform=macos ;;
    Linux) platform=linux ;;
    *) echo 'Solo se admite macOS y Linux.' >&2; exit 1 ;;
esac

link_file "$repo/zshrc" "$HOME/.zshrc"
link_file "$repo/zshenv.$platform" "$HOME/.zshenv"
link_file "$repo/zprofile.$platform" "$HOME/.zprofile"
link_file "$repo/nvim" "$config_home/nvim"
link_file "$repo/tmux/tmux.conf" "$config_home/tmux/tmux.conf"
link_file "$repo/starship.toml" "$config_home/starship.toml"
link_file "$repo/direnvrc" "$config_home/direnv/direnvrc"
link_file "$repo/ghostty" "$config_home/ghostty/config"
link_file "$repo/gitconfig.common" "$config_home/git/config"

if [ "${1:-}" != --link-only ]; then
    log 'Preparando plugins, analizadores y herramientas de Neovim'
    DOTFILES_BOOTSTRAP=1 nvim --headless -c 'lua local ok, err = pcall(require("config.bootstrap").run); if not ok then vim.api.nvim_err_writeln(err); vim.cmd("cquit 1") end' -c qa
fi

if ! git config --global user.name >/dev/null 2>&1 || ! git config --global user.email >/dev/null 2>&1; then
    log 'Git: configura tu nombre y correo con git config --global user.name/user.email antes de crear commits.'
fi

if [ "${1:-}" != --link-only ] && [ "$(uname -s)" = Linux ]; then
    current_shell=$(getent passwd "$(id -un)" | cut -d: -f7)
    zsh_bin=$(command -v zsh)
    if ! grep -Fqx "$zsh_bin" /etc/shells; then
        log "Registrando $zsh_bin en /etc/shells"
        printf '%s\n' "$zsh_bin" | sudo tee -a /etc/shells >/dev/null
    fi
    case "$current_shell" in
        */zsh) ;;
        *)
            log "Activando zsh como shell de inicio: $zsh_bin"
            chsh -s "$zsh_bin"
            ;;
    esac
fi

if [ "${1:-}" != --link-only ] && [ "$(uname -s)" = Darwin ]; then
    brew_zsh="$(brew --prefix)/bin/zsh"
    if [ ! -x "$brew_zsh" ]; then
        echo "No se encontró la zsh de Homebrew: $brew_zsh" >&2
        exit 1
    fi
    if ! grep -Fqx "$brew_zsh" /etc/shells; then
        log "Registrando $brew_zsh en /etc/shells"
        printf '%s\n' "$brew_zsh" | sudo tee -a /etc/shells >/dev/null
    fi
    current_shell=$(id -P "$(id -un)" | awk -F: '{print $NF}')
    if [ "$current_shell" != "$brew_zsh" ]; then
        log "Activando zsh de Homebrew como shell de inicio: $brew_zsh"
        chsh -s "$brew_zsh"
    fi
fi

log 'Instalación terminada. Abre una nueva sesión de terminal.'
