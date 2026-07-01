#!/usr/bin/env bash

set -euo pipefail

if ! brew list zsh >/dev/null 2>&1; then
    echo "Installing zsh..."
    brew install zsh
fi

BREW_ZSH="$(brew --prefix)/bin/zsh"

if ! grep -qx "$BREW_ZSH" /etc/shells; then
    echo "Registering $BREW_ZSH in /etc/shells..."
    echo "$BREW_ZSH" | sudo tee -a /etc/shells >/dev/null
fi

CURRENT_SHELL="$(dscl . -read "/Users/$USER" UserShell | awk '{print $2}')"

if [ "$CURRENT_SHELL" != "$BREW_ZSH" ]; then
    echo "Changing login shell to $BREW_ZSH..."
    chsh -s "$BREW_ZSH"
fi
