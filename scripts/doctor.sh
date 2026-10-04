#!/bin/sh
set -eu
profile=$1
repo=$2
platform=$3
config_home=${XDG_CONFIG_HOME:-"$HOME/.config"}
data_home=${XDG_DATA_HOME:-"$HOME/.local/share"}
failures=0
ok() { printf 'OK    %s\n' "$*"; }
missing() { printf 'FALLO %s\n' "$*"; failures=$((failures + 1)); }
check_link() {
    if [ -L "$2" ] && [ "$(readlink "$2")" = "$1" ] && [ -e "$2" ]; then
        ok "$2"
    else
        missing "Enlace esperado: $2 -> $1"
    fi
}
printf 'Diagnóstico del perfil %s (sin cambios)\n' "$profile"
if [ -f "$config_home/dotfiles/profile" ] && [ "$(cat "$config_home/dotfiles/profile")" = "$profile" ]; then
    ok "Perfil guardado: $profile"
else
    missing "El perfil guardado no es $profile"
fi
check_link "$repo/zshrc" "$HOME/.zshrc"
check_link "$repo/zshenv.$platform" "$HOME/.zshenv"
check_link "$repo/zprofile.$platform" "$HOME/.zprofile"
check_link "$repo/nvim-slim" "$config_home/nvim-slim"
if [ "$profile" = fat ]; then
    check_link "$repo/nvim" "$config_home/nvim"
    check_link "$repo/starship.toml" "$config_home/starship.toml"
else
    check_link "$repo/nvim-slim" "$config_home/nvim"
fi
check_link "$repo/bin/vslim" "$HOME/.local/bin/vslim"
check_link "$repo/tmux/tmux.conf" "$config_home/tmux/tmux.conf"
check_link "$repo/direnvrc" "$config_home/direnv/direnvrc"
check_link "$repo/ghostty" "$config_home/ghostty/config"
check_link "$repo/gitconfig.common" "$config_home/git/config"
commands='git zsh tmux nvim fzf fd rg direnv uv go vslim'
if [ "$profile" = fat ]; then
    commands="$commands starship zoxide node npm python3 tree-sitter cppcheck"
fi
for cmd in $commands; do
    if command -v "$cmd" >/dev/null 2>&1; then
        ok "$cmd: $(command -v "$cmd")"
    else
        missing "Comando ausente: $cmd"
    fi
done
if [ -f "$HOME/.oh-my-zsh/oh-my-zsh.sh" ]; then
    ok 'Oh My Zsh'
else
    missing 'Oh My Zsh ausente'
fi
if [ -f "$HOME/.local/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh" ]; then
    ok 'Resaltado de zsh'
else
    missing 'Resaltado de zsh ausente'
fi
# No ejecutar Go aquí: incluso `go version` puede escribir telemetría o
# seleccionar/descargar una toolchain del proyecto. Su presencia se comprueba arriba.
for cmd in uv tmux; do
    if command -v "$cmd" >/dev/null 2>&1; then
        case "$cmd" in
            uv) version=$(uv --version 2>&1) || { missing "No se puede ejecutar uv: $version"; continue; } ;;
            tmux) version=$(tmux -V 2>&1) || { missing "No se puede ejecutar tmux: $version"; continue; } ;;
        esac
        printf 'VERSIÓN %s\n' "$version"
        if [ "$cmd" = tmux ]; then
            tmux_version=${version#tmux }
            if ! printf '%s\n' "$tmux_version" | awk -F. '{exit !($1 > 3 || ($1 == 3 && $2+0 >= 3))}'; then
                missing 'Se requiere tmux >= 3.3'
            fi
        fi
    fi
done
plugin="$data_home/nvim-slim/site/pack/dotfiles/start/mini.nvim"
revision=$(cat "$repo/nvim-slim/mini.version")
if [ -d "$plugin/.git" ] && [ "$(git -C "$plugin" rev-parse HEAD 2>/dev/null || true)" = "$revision" ]; then
    ok "Mini fijado en $revision"
else
    missing 'Mini ausente o con una revisión distinta de mini.version'
fi
if command -v nvim >/dev/null 2>&1; then
    # NONE evita cargar configuraciones que puedan iniciar descargas.
    # -i NONE, -n y NVIM_LOG_FILE evitan escritura de estado durante el diagnóstico.
    if DOTFILES_REPO="$repo" DOTFILES_PROFILE="$profile" NVIM_APPNAME=nvim NVIM_LOG_FILE=/dev/null \
        nvim -u NONE -i NONE -n --headless -c 'lua dofile(vim.env.DOTFILES_REPO .. "/scripts/doctor.lua")' -c qa; then
        ok 'Versión y herramientas del editor'
    else
        missing 'Versión o herramientas del editor incompletas'
    fi
fi
if command -v infocmp >/dev/null 2>&1; then
    for terminal in tmux-256color "${TERM:-xterm-256color}"; do
        if infocmp "$terminal" >/dev/null 2>&1; then
            ok "terminfo: $terminal"
        else
            missing "terminfo ausente: $terminal"
        fi
    done
fi
current_shell=${SHELL:-desconocido}
case "$current_shell" in
    */zsh) ok "Shell de la sesión: $current_shell" ;;
    *) printf 'AVISO Shell de la sesión: %s; abre una sesión de zsh.\n' "$current_shell" ;;
esac
printf 'Diagnóstico terminado: %s fallo(s).\n' "$failures"
[ "$failures" -eq 0 ]
