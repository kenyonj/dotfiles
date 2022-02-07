#!/bin/bash

exec > >(tee -i $HOME/dotfiles_install.log)
exec 2>&1
set -x

# remove existing init scripts
rm -f $HOME/.zshrc
rm -f $HOME/.gitconfig

packages_needed=(
  bat
  exuberant-ctags
  fasd
  fuse
  fzf
  grc
  libfuse2
  npm
  rubocop
  ruby-dev
  shellcheck
  silversearcher-ag
  tmux
  zsh-autosuggestions
)

if ! dpkg -s "${packages_needed[@]}" > /dev/null 2>&1; then
  sudo apt-get update --fix-missing
  sudo apt-get -y -q install ${packages_needed} --fix-missing
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
wget https://github.com/github/copilot.vim/releases/download/neovim-nightlies/appimage.zip
unzip appimage.zip
sudo chmod u+x nvim.appimage
sudo mv nvim.appimage /usr/local/bin/nvim

dotfiles=(
  aliases.zsh
  config/nvim
  gitconfig
  irbrc
  tmux.conf
  tmux.overmind.conf
  zprofile
  zshrc
)
 
for val in "${dotfiles[@]}"; do
  ln -snf $(pwd)/$val $HOME/.$val
done

sudo gem install neovim solargraph rubocop
pip3 install --user neovim
go get -u github.com/arl/gitmux

npm_packages_needed=(
  bash-language-server
  eslint
  neovim
  pyright
  typescript-language-server
  vscode-langservers-extracted
  write-good
)
/usr/local/bin/npm install -g "${npm_packages_needed[@]}"

/usr/local/bin/nvim -c PackerSync -c 'sleep 5' -c qa --headless

gh extensions install mislav/gh-branch
gh extensions install vilmibm/gh-user-status

sudo chsh -s "$(which zsh)" "$(whoami)"
