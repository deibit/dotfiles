#!/bin/sh
# Descargas solo durante la instalación, nunca al abrir el editor.
set -eu
repo=$1
data_home=${XDG_DATA_HOME:-"$HOME/.local/share"}
plugin="$data_home/nvim-slim/site/pack/dotfiles/start/mini.nvim"
revision=$(cat "$repo/nvim-slim/mini.version")
mkdir -p "$(dirname "$plugin")"
if [ ! -e "$plugin" ]; then
    git clone --filter=blob:none https://github.com/nvim-mini/mini.nvim.git "$plugin"
fi
if [ ! -d "$plugin/.git" ]; then
    echo "Existe $plugin pero no es una instalación Git de Mini." >&2
    exit 1
fi
if [ -n "$(git -C "$plugin" status --porcelain)" ]; then
    echo "Mini tiene cambios locales en $plugin; consérvalos antes de reinstalar." >&2
    exit 1
fi
if ! git -C "$plugin" cat-file -e "$revision^{commit}" 2>/dev/null; then
    git -C "$plugin" fetch origin "$revision"
fi
git -C "$plugin" checkout --quiet --detach "$revision"
