#!/bin/bash

exec > >(tee -i $HOME/dotfiles_install.log)
exec 2>&1
set -x

# Always want to use ZSH as my default shell (e.g. for SSH)
if ! grep -q "root.*/bin/zsh" /etc/passwd
then
  chsh -s /bin/zsh root
fi

apt-get install -y \
  exa grc ripgrep shellcheck zsh-autosuggestions locate \
  fuse npm
  
# install latest stable node
npm cache clean -f
npm install -g n
node_version=`node --version`
ln -s "/workspaces/github/vendor/node/node-$node_version-linux-x64/lib/node_modules/n/bin/n" /usr/local/bin/n
n stable

# Setup the database for locate
updatedb

# install latest neovim
wget https://github.com/neovim/neovim/releases/download/nightly/nvim.appimage
chmod u+x nvim.appimage
mv nvim.appimage /usr/local/bin/nvim

git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

ln -s $(pwd)/tmux.conf $HOME/.tmux.conf
ln -s $(pwd)/vimrc $HOME/.vimrc
ln -s $(pwd)/vim $HOME/.vim
ln -s $(pwd)/emacs $HOME/.emacs
ln -s $(pwd)/screenrc $HOME/.screenrc

vim -Es -u $HOME/.vimrc -c "PlugInstall | qa"
