# FZF
if [[ "$OSTYPE" == "darwin"* ]]; then
  echo "Brewing..."
  # brew install fzf tmux neovim zsh lazygit delta git wezterm starchip eza direnv uv

# Asuming Linux

#TODO: apt install <list_of_packages>
else
  git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
  ~/.fzf/install
fi

# Oh-my-zsh
# sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

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

echo "Done."
