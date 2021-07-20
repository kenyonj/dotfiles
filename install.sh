#!/bin/bash

exec > >(tee -i $HOME/dotfiles_install.log)
exec 2>&1
set -x

chsh -s $(which zsh)

# remove existing init scripts
rm -f $HOME/.zshrc
rm -f $HOME/.gitconfig

apt-get install -y \
  exa grc ripgrep shellcheck zsh-autosuggestions \
  fuse npm fzf fasd ruby-dev
  
# install latest stable node
npm cache clean -f
npm install -g n
node_version=`node --version`
ln -s "/workspaces/github/vendor/node/node-$node_version-linux-x64/lib/node_modules/n/bin/n" /usr/local/bin/n
n stable

# install latest neovim
wget https://github.com/neovim/neovim/releases/download/nightly/nvim.appimage
chmod u+x nvim.appimage
mv nvim.appimage /usr/local/bin/nvim

ln -s $(pwd)/gitconfig $HOME/.gitconfig
ln -s $(pwd)/zprofile $HOME/.zprofile
ln -s $(pwd)/tmux.conf $HOME/.tmux.conf
ln -s $(pwd)/tmux.overmind.conf $HOME/.tmux.overmind.conf
ln -s $(pwd)/aliases.zsh $HOME/.aliases.zsh
ln -s $(pwd)/zshrc $HOME/.zshrc
ln -s $(pwd)/irbrc $HOME/.irbrc
ln -s $(pwd)/config/nvim $HOME/.config/nvim

gem install neovim
npm install -g neovim
pip3 install --user neovim
go get -u github.com/arl/gitmux

nvim +'PlugInstall --sync' +qa
