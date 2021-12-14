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
  shellcheck \
  zsh-autosuggestions \
  fuse \
  npm \
  rubocop \
  fzf \
  fasd \
  ruby-dev \
  silversearcher-ag \
  bat \
  libfuse2"

if ! dpkg -s ${PACKAGES_NEEDED} > /dev/null 2>&1; then
  sudo apt-get update --fix-missing
  sudo apt-get -y -q install ${PACKAGES_NEEDED} --fix-missing
fi
  
# install latest stable node
npm cache clean -f
npm install -g n
node_version=`node --version`
sudo ln -s "/workspaces/github/vendor/node/node-$node_version-linux-x64/lib/node_modules/n/bin/n" /usr/local/bin/n
sudo n stable

# install latest neovim
sudo modprobe fuse
sudo groupadd fuse
sudo usermod -a -G fuse "$(whoami)"
# wget https://github.com/neovim/neovim/releases/download/v0.5.1/nvim.appimage
wget https://github.com/github/copilot.vim/releases/download/neovim-nightlies/appimage.zip
unzip appimage.zip
sudo chmod u+x nvim.appimage
sudo mv nvim.appimage /usr/local/bin/nvim

ln -snf $(pwd)/gitconfig $HOME/.gitconfig
ln -snf $(pwd)/zprofile $HOME/.zprofile
ln -snf $(pwd)/tmux.conf $HOME/.tmux.conf
ln -snf $(pwd)/tmux.overmind.conf $HOME/.tmux.overmind.conf
ln -snf $(pwd)/aliases.zsh $HOME/.aliases.zsh
ln -snf $(pwd)/zshrc $HOME/.zshrc
ln -snf $(pwd)/irbrc $HOME/.irbrc
ln -snf $(pwd)/config/nvim $HOME/.config/nvim

sudo gem install neovim solargraph
pip3 install --user neovim
go get -u github.com/arl/gitmux

NPM_PACKAGES_NEEDED="\
  neovim \
  bash-language-server \
  pyright \
  vscode-langservers-extracted \
  typescript-language-server \
  write-good \
  eslint"
/usr/local/bin/npm install -g ${NPM_PACKAGES_NEEDED}

/usr/local/bin/nvim -c PackerSync -c 'sleep 5' -c qa --headless

gh extensions install mislav/gh-branch
gh extensions install vilmibm/gh-user-status

sudo chsh -s "$(which zsh)" "$(whoami)"
