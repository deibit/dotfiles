#!/bin/sh

# Colores
GREEN="\033[1;32m"
BLUE="\033[1;34m"
RED="\033[1;31m"
RESET="\033[0m"

# Emojis
CHECK="✅"
LINK="🔗"
FOLDER="📁"
INFO="ℹ️"

# Establecer XDG_CONFIG_HOME si no está definido
if [ -z "$XDG_CONFIG_HOME" ]; then
  XDG_CONFIG_HOME="$HOME/.config"
  echo "${INFO} ${BLUE}XDG_CONFIG_HOME no estaba definido. Usando por defecto: $XDG_CONFIG_HOME${RESET}"
fi

# Ruta absoluta del directorio donde está este script
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"

# Crear directorios
for i in lazygit wezterm eza tmux direnv; do
  d="$XDG_CONFIG_HOME/$i"
  echo "${FOLDER} ${GREEN}Creando directorio:${RESET} $d"
  mkdir -p "$d"
done

# Crear enlaces simbólicos con rutas absolutas
echo "${INFO} ${BLUE}Creando enlaces simbólicos...${RESET}"
ln -sfn "$SCRIPT_DIR/tmux.conf" "$HOME/.tmux.conf" && echo "$LINK $HOME/.tmux.conf $CHECK"
ln -sfn "$SCRIPT_DIR/zshrc" "$HOME/.zshrc" && echo "$LINK $HOME/.zshrc $CHECK"
ln -sfn "$SCRIPT_DIR/zprofile" "$HOME/.zprofile" && echo "$LINK $HOME/.zprofile $CHECK"
ln -sfn "$SCRIPT_DIR/nvim" "$XDG_CONFIG_HOME/nvim" && echo "$LINK $XDG_CONFIG_HOME/nvim $CHECK"
ln -sfn "$SCRIPT_DIR/gitconfig" "$HOME/.gitconfig" && echo "$LINK $HOME/.gitconfig $CHECK"
ln -sfn "$SCRIPT_DIR/lazygit.yml" "$XDG_CONFIG_HOME/lazygit/config.yml" && echo "$LINK $XDG_CONFIG_HOME/lazygit/config.yml $CHECK"
ln -sfn "$SCRIPT_DIR/direnvrc" "$XDG_CONFIG_HOME/direnv/direnvrc" && echo "$LINK $XDG_CONFIG_HOME/direnv/direnvrc $CHECK"

echo "${GREEN}🎉 Todo listo.${RESET}"
