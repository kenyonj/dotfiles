#!/bin/bash

exec > >(tee -i "$HOME/dotfiles_install.log")
exec 2>&1
set -x

generate_post_data() {
cat <<EOF
{
  "state": "$1",
  "codespace_name": "$CODESPACE_NAME"
}
EOF
}

if [[ -n "$HOMEASSISTANT_WEBHOOK_URL" ]]; then
  curl -X POST \
    -H "Content-Type: application/json" \
    -d "$(generate_post_data 'started')" \
    "$HOMEASSISTANT_WEBHOOK_URL"
fi

# remove existing init scripts
rm -f "$HOME/.zshrc"
rm -f "$HOME/.gitconfig"

packages_needed=(
  bat
  exuberant-ctags
  fasd
  fuse
  fzf
  grc
  kmod
  libfuse2
  pip
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

# install node and n node version manager
rm -rf /usr/local/.nodenv/shims/node
rm -rf /usr/local/.nodenv/shims/npm
curl -L https://bit.ly/n-install | bash -s -- -y

# install latest neovim
curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim.appimage
sudo chmod u+x nvim.appimage
sudo mv nvim.appimage /usr/local/bin/nvim

dotfiles=(
  aliases.zsh
  config/github-copilot
  config/nvim
  gitconfig
  gitconfig.codespaces
  irbrc
  tmux.conf
  tmux.overmind.conf
  zprofile
  zshrc
)
for val in "${dotfiles[@]}"; do
  ln -snf "$(pwd)/$val" "$HOME/.$val"
done

sudo gem install neovim rubocop
pip3 install --user neovim

npm_packages_needed=(
  bash-language-server
  eslint
  neovim
  prettier
  pyright
  typescript-language-server
  vscode-langservers-extracted
  write-good
)
sudo /usr/local/bin/npm install -g "${npm_packages_needed[@]}"

HEADLESS_NEOVIM=1 /usr/local/bin/nvim --headless -c 'autocmd User PackerComplete quitall' -c 'PackerSync'

# tmux new -d # open a detached session to install TPM
# tmux new -d "$HOME/.tmux/plugins/tpm/scripts/install_plugins.sh" # open another detached session and install plugins

# gh extensions install mislav/gh-branch
# gh extensions install vilmibm/gh-user-status

# install Remote Development Manager https://github.com/BlakeWilliams/remote-development-manager
wget https://github.com/BlakeWilliams/remote-development-manager/releases/latest/download/rdm-linux-amd64
sudo mv rdm-linux-amd64 /usr/local/bin/rdm
sudo chmod +x /usr/local/bin/rdm

sudo chsh -s "$(which zsh)" "$(whoami)"

# send pushover notification that dotfiles setup has completed
if [[ -n "$PUSHOVER_API_TOKEN" && -n "$PUSHOVER_USER_KEY" ]]; then
  curl -s \
    --form-string "token=$PUSHOVER_API_TOKEN" \
    --form-string "user=$PUSHOVER_USER_KEY" \
    --form-string "message=Dotfiles installation complete for codespace: $CODESPACE_NAME!" \
    https://api.pushover.net/1/messages.json
fi

# send webhook to personal home assistant instance
if [[ -n "$HOMEASSISTANT_WEBHOOK_URL" ]]; then
  curl -X POST \
    -H "Content-Type: application/json" \
    -d "$(generate_post_data 'completed')" \
    "$HOMEASSISTANT_WEBHOOK_URL"
fi
