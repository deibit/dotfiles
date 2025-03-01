directories=(lazygit wezterm eza tmux direnv)

function makedirs() {
  for i in "${directories[@]}"; do
    d="$XDG_CONFIG_HOME/$i"
    echo "Making $d"
    mkdir $d
  done
}

makedirs

echo "Making links..."
ln -sfn ./tmux.conf $HOME/.tmux.conf
ln -sfn ./zshrc $HOME/.zshrc
ln -sfn ./zprofile $HOME/.zprofile
ln -sfn ./nvim $XDG_CONFIG_HOME/nvim
ln -sfn ./gitconfig $HOME/.gitconfig
ln -sfn ./lazygit.yml $XDG_CONFIG_HOME/lazygit/config.yml
ln -sfn ./lazygit.yml $XDG_CONFIG_HOME/lazygit/config.yml
ln -sfn ./direnvrc $XDG_CONFIG_HOME/direnv/direnvrc

echo "Done."
