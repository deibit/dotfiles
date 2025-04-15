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

# Detectar sistema operativo
OS="$(uname)"
case "$OS" in
Darwin)
  SUFFIX="macos"
  ;;
Linux)
  SUFFIX="linux"
  ;;
*)
  echo "${RED}❌ Sistema operativo no reconocido: $OS${RESET}"
  exit 1
  ;;
esac

# Crear directorios
for i in lazygit wezterm eza tmux direnv yazi; do
  d="$XDG_CONFIG_HOME/$i"
  echo "${FOLDER} ${GREEN}Creando directorio:${RESET} $d"
  mkdir -p "$d"
done

# Crear enlaces simbólicos fijos
echo "${INFO} ${BLUE}Creando enlaces simbólicos comunes...${RESET}"
ln -sfn "$SCRIPT_DIR/zshrc" "$HOME/.zshrc" && echo "$LINK $HOME/.zshrc $CHECK"
ln -sfn "$SCRIPT_DIR/tmux.conf" "$HOME/.tmux.conf" && echo "$LINK $HOME/.tmux.conf $CHECK"
ln -sfn "$SCRIPT_DIR/nvim" "$XDG_CONFIG_HOME/nvim" && echo "$LINK $XDG_CONFIG_HOME/nvim $CHECK"
ln -sfn "$SCRIPT_DIR/gitconfig" "$HOME/.gitconfig" && echo "$LINK $HOME/.gitconfig $CHECK"
ln -sfn "$SCRIPT_DIR/lazygit.yml" "$XDG_CONFIG_HOME/lazygit/config.yml" && echo "$LINK $XDG_CONFIG_HOME/lazygit/config.yml $CHECK"
ln -sfn "$SCRIPT_DIR/direnvrc" "$XDG_CONFIG_HOME/direnv/direnvrc" && echo "$LINK $XDG_CONFIG_HOME/direnv/direnvrc $CHECK"
ln -sfn "$SCRIPT_DIR/yazi/yazi.toml" "$XDG_CONFIG_HOME/yazi/yazi.toml" && echo "$LINK $XDG_CONFIG_HOME/yazi/yazi.toml $CHECK"
ln -sfn "$SCRIPT_DIR/yazi/init.lua" "$XDG_CONFIG_HOME/yazi/init.lua" && echo "$LINK $XDG_CONFIG_HOME/yazi/init.lua $CHECK"

# Crear enlaces simbólicos variables (zshenv, zprofile)
echo "${INFO} ${BLUE}Creando enlaces según el sistema: $SUFFIX...${RESET}"
for file in zshenv zprofile; do
  SOURCE="$SCRIPT_DIR/${file}.${SUFFIX}"
  TARGET="$HOME/.${file}"
  if [ -f "$SOURCE" ]; then
    ln -sfn "$SOURCE" "$TARGET" && echo "$LINK $TARGET → ${file}.${SUFFIX} $CHECK"
  else
    echo "${RED}⚠️  No se encontró $SOURCE. Omitido.${RESET}"
  fi
done

echo "${GREEN}🎉 Todo listo.${RESET}"
