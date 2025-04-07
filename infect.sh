#!/bin/sh

GREEN="\033[1;32m"
BLUE="\033[1;34m"
RED="\033[1;31m"
RESET="\033[0m"

CHECK="✅"
LINK="🔗"
FOLDER="📁"
INFO="ℹ️"

if [ -z "$XDG_CONFIG_HOME" ]; then
  XDG_CONFIG_HOME="$HOME/.config"
  echo "${INFO} ${BLUE}XDG_CONFIG_HOME no estaba definido. Usando por defecto: $XDG_CONFIG_HOME${RESET}"
fi

for i in lazygit wezterm eza tmux direnv; do
  d="$XDG_CONFIG_HOME/$i"
  echo "${FOLDER} ${GREEN}Creando directorio:${RESET} $d"
  mkdir -p "$d"
done

echo "${INFO} ${BLUE}Creando enlaces simbólicos...${RESET}"
ln -sfn ./tmux.conf "$HOME/.tmux.conf" && echo "$LINK $HOME/.tmux.conf $CHECK"
ln -sfn ./zshrc "$HOME/.zshrc" && echo "$LINK $HOME/.zshrc $CHECK"
ln -sfn ./zprofile "$HOME/.zprofile" && echo "$LINK $HOME/.zprofile $CHECK"
ln -sfn ./nvim "$XDG_CONFIG_HOME/nvim" && echo "$LINK $XDG_CONFIG_HOME/nvim $CHECK"
ln -sfn ./gitconfig "$HOME/.gitconfig" && echo "$LINK $HOME/.gitconfig $CHECK"
ln -sfn ./lazygit.yml "$XDG_CONFIG_HOME/lazygit/config.yml" && echo "$LINK $XDG_CONFIG_HOME/lazygit/config.yml $CHECK"
ln -sfn ./direnvrc "$XDG_CONFIG_HOME/direnv/direnvrc" && echo "$LINK $XDG_CONFIG_HOME/direnv/direnvrc $CHECK"

echo "${GREEN}🎉 Todo listo.${RESET}"
