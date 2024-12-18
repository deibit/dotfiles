REPO="$HOME/dotfiles"

ln -sfn "$REPO/tmux.conf" ~/.tmux.conf
ln -sfn "$REPO/zshrc" ~/.zshrc
ln -sfn "$REPO/zprofile" ~/.zprofile
ln -sfn "$REPO/nvim" ~/.config/nvim
ln -sfn "$REPO/gitconfig" ~/.gitconfig
ln -sfn "$REPO/p10k.zsh" ~/.p10k.zsh
ln -sfn "$REPO/alacritty.toml" ~/.config/alacritty/alacritty.toml

[ -d $HOME/.config/nvim ] || mkdir -p $HOME/.config/nvim

[ -d $HOME/.config/lazygit ] || mkdir -p $HOME/.config/lazygit
ln -sfn "$REPO/lazygit.yml" ~/.config/lazygit/config.yml

[ -d $HOME/.config/wezterm ] || mkdir -p $HOME/.config/wezterm
ln -sfn "$REPO/wezterm.lua" ~/.config/wezterm/wezterm.lua
