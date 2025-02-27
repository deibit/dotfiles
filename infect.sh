# FZF
if [[ "$OSTYPE" == "darwin"* ]]; then
  brew install fzf

# Asuming Linux
else
  git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
  ~/.fzf/install
fi

# Oh-my-zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

REPO="$HOME/dotfiles"

ln -sfn "$REPO/tmux.conf" ~/.tmux.conf
ln -sfn "$REPO/zshrc" ~/.zshrc
ln -sfn "$REPO/zprofile" ~/.zprofile
ln -sfn "$REPO/nvim" ~/.config/nvim
ln -sfn "$REPO/gitconfig" ~/.gitconfig

[ -d $HOME/.config/nvim ] || mkdir -p $HOME/.config/nvim

[ -d $HOME/.config/lazygit ] || mkdir -p $HOME/.config/lazygit
ln -sfn "$REPO/lazygit.yml" ~/.config/lazygit/config.yml

[ -d $HOME/.config/wezterm ] || mkdir -p $HOME/.config/wezterm
ln -sfn "$REPO/wezterm.lua" ~/.config/wezterm/wezterm.lua
