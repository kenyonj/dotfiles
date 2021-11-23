#!/bin/bash

exec > >(tee -i $HOME/dotfiles_install.log)
exec 2>&1
set -x

# remove existing init scripts
rm -f $HOME/.zshrc
rm -f $HOME/.gitconfig

PACKAGES_NEEDED="\
  tmux \
  grc \
  ripgrep \
  shellcheck \
  zsh-autosuggestions \
  fuse \
  npm \
  fzf \
  fasd \
  ruby-dev \
  silversearcher-ag \
  bat \
  libfuse2"

if ! dpkg -s ${PACKAGES_NEEDED} > /dev/null 2>&1; then
  if [ ! -d "/var/lib/apt/lists" ] || [ "$(ls /var/lib/apt/lists/ | wc -l)" = "0" ]; then
    sudo apt-get update --fix-missing
  fi

  sudo apt-get -y -q install ${PACKAGES_NEEDED} --fix-missing
fi
  
# install latest stable node
npm cache clean -f
npm install -g n
node_version=`node --version`
ln -s "/workspaces/github/vendor/node/node-$node_version-linux-x64/lib/node_modules/n/bin/n" /usr/local/bin/n
n stable

# install latest neovim
sudo modprobe fuse
sudo groupadd fuse
sudo usermod -a -G fuse "$(whoami)"
# wget https://github.com/neovim/neovim/releases/download/v0.5.1/nvim.appimage
wget https://github.com/github/copilot.vim/releases/download/neovim-nightlies/appimage.zip
unzip appimage.zip
sudo chmod u+x nvim.appimage
sudo mv nvim.appimage /usr/local/bin/nvim

ln -s $(pwd)/gitconfig $HOME/.gitconfig
ln -s $(pwd)/zprofile $HOME/.zprofile
ln -s $(pwd)/tmux.conf $HOME/.tmux.conf
ln -s $(pwd)/tmux.overmind.conf $HOME/.tmux.overmind.conf
ln -s $(pwd)/aliases.zsh $HOME/.aliases.zsh
ln -s $(pwd)/zshrc $HOME/.zshrc
ln -s $(pwd)/irbrc $HOME/.irbrc
ln -s $(pwd)/config/nvim $HOME/.config/nvim

gem install neovim
/usr/local/bin/npm install -g neovim
pip3 install --user neovim
go get -u github.com/arl/gitmux

nvim +'PlugInstall --sync' +qa

gh extensions install mislav/gh-branch
gh extensions install vilmibm/gh-user-status

sudo chsh -s "$(which zsh)" "$(whoami)"
