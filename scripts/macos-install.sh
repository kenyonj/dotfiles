#!/bin/bash

brew bundle

xcode-select --install

wget https://github.com/BlakeWilliams/remote-development-manager/releases/latest/download/rdm-darwin-arm64
mv rdm-darwin-arm64 /opt/homebrew/bin/rdm
chmod +x /opt/homebrew/bin/rdm

dotfiles=(
  aliases.zsh
  config
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

npm_packages_needed=(
  bash-language-server
  eslint
  neovim
  pyright
  typescript-language-server
  vscode-langservers-extracted
  write-good
)
/opt/homebrew/bin/npm install -g "${npm_packages_needed[@]}"

HEADLESS_NEOVIM=1 /opt/homebrew/bin/nvim --headless -c 'autocmd User PackerComplete quitall' -c 'PackerSync'
tmux new -d '~/.tmux/plugins/tpm/scripts/install_plugins.sh'

gh extensions install mislav/gh-branch
gh extensions install vilmibm/gh-user-status

$(brew --prefix)/opt/fzf/install --all
