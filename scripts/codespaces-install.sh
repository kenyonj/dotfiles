#!/bin/bash

exec > >(tee -i $HOME/dotfiles_install.log)
exec 2>&1
set -x

if [[ -n "$HOMEASSISTANT_WEBHOOK_URL" ]]
  curl -X POST -d \
    -H "Content-Type: application/json" 
    '{ "state": "started", "codespace_name": "$CODESPACE_NAME" }' \
    $HOMEASSISTANT_WEBHOOK_URL
fi

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
  sudo apt-get -y -q install "${packages_needed[@]}" --fix-missing
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
wget https://github.com/neovim/neovim/releases/download/nightly/nvim.appimage
sudo chmod u+x nvim.appimage
sudo mv nvim.appimage /usr/local/bin/nvim

dotfiles=(
  aliases.zsh
  config/github-copilot
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

sudo gem install neovim rubocop
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

HEADLESS_NEOVIM=1 /usr/local/bin/nvim --headless -c 'autocmd User PackerComplete quitall' -c 'PackerSync'
tmux new -d # open a detached session to install TPM
tmux new -d '~/.tmux/plugins/tpm/scripts/install_plugins.sh' # open another detached session and install plugins

gh extensions install mislav/gh-branch
gh extensions install vilmibm/gh-user-status

# install Remote Development Manager https://github.com/BlakeWilliams/remote-development-manager
wget https://github.com/BlakeWilliams/remote-development-manager/releases/latest/download/rdm-linux-amd64
mv rdm-linux-amd64 /usr/local/bin/rdm
chmod +x /usr/local/bin/rdm

sudo chsh -s "$(which zsh)" "$(whoami)"

# send pushover notification that dotfiles setup has completed
if [[ -n "$PUSHOVER_API_TOKEN" && -n "$PUSHOVER_USER_KEY" ]]
  curl -s \
    --form-string "token=$PUSHOVER_API_TOKEN" \
    --form-string "user=$PUSHOVER_USER_KEY" \
    --form-string "message=Dotfiles installation complete for codespace: $CODESPACE_NAME!" \
    https://api.pushover.net/1/messages.json
fi
  
# send webhook to personal home assistant instance
if [[ -n "$HOMEASSISTANT_WEBHOOK_URL" ]]
  curl -X POST -d \
    -H "Content-Type: application/json" 
    '{ "state": "complete", "codespace_name": "$CODESPACE_NAME" }' \
    $HOMEASSISTANT_WEBHOOK_URL
fi
