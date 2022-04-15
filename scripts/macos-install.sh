#!/bin/bash

output() {
  printf "$1"
}

all_done() {
  if [[ "$1" ]]; then
    printf "$1"
  else
    printf "✅\n"
  fi
}

brew_bundle() {
  output "Brew bundling...\n"

  brew bundle

  all_done "\n\n"
}

install_xcode_select() {
  output "Conditionally installing xcode-select..."

  (type xcode-select >&- && xpath=$( xcode-select --print-path ) &&
    test -d "${xpath}" && test -x "${xpath}") || xcode-select --install

  all_done
}

install_rdm() {
  output "Conditionally installing rdm..."

  if ! type rdm > /dev/null; then
    wget https://github.com/BlakeWilliams/remote-development-manager/releases/latest/download/rdm-darwin-arm64
    mv rdm-darwin-arm64 /opt/homebrew/bin/rdm
    chmod +x /opt/homebrew/bin/rdm
  fi

  all_done
}

install_dotfiles() {
  output "Installing dotfiles..."

  dotfiles=(
    aliases.zsh
    config
    gitconfig
    gnupg
    irbrc
    tmux.conf
    tmux.overmind.conf
    zprofile
    zshrc
  )

  for val in "${dotfiles[@]}"; do
    ln -snf $(pwd)/$val $HOME/.$val
  done

  all_done
}

install_npm_packages() {
  output "Conditionally installing npm packages..."

  npm_packages_needed=(
    bash-language-server
    eslint
    neovim
    pyright
    typescript-language-server
    vscode-langservers-extracted
    write-good
  )
  npm_packages_not_installed=()

  for pkg in "${npm_packages_needed[@]}"; do
    npm list --depth 1 --global $pkg >/dev/null 2>&1 || npm_packages_not_installed+=($pkg)
  done

  [ ${#npm_packages_not_installed[@]} -eq 0 ] || /opt/homebrew/bin/npm install -g "${npm_packages_not_installed[@]}"

  all_done
}

initialize_neovim() {
  output "Initializing neovim..."

  HEADLESS_NEOVIM=1 /opt/homebrew/bin/nvim --headless -c 'autocmd User PackerComplete quitall' -c 'PackerSync'

  all_done
}

initialize_tmux() {
  output "Initializing tmux..."

  tmux new -d '~/.tmux/plugins/tpm/scripts/install_plugins.sh'

  all_done
}

install_gh_extensions() {
  output "Conditionally installing gh extensions..."

  IFS=$'\n' installed_gh_extensions=($(gh extension list))
  wanted_gh_extensions=(
    mislav/gh-branch
    vilmibm/gh-user-status
  )
  for extension_to_install in "${wanted_gh_extensions[@]}"; do
    found=false

    for installed_extension in "${installed_gh_extensions[@]}"; do
      if [[ "$installed_extension" = *"$extension_to_install"* ]]; then
        found=true
      fi
    done

    if [[ $found == true ]]; then
      found=false
    else
      gh extensions install $extension_to_install
    fi
  done

  all_done
}

install_fzf() {
  output "Conditionally installing fzf..."

  command -v fzf >/dev/null 2>&1 || $(brew --prefix)/opt/fzf/install --all

  all_done
}

teardown() {
  output "Cleaning up..."

  IFS=$' \t\n'

  all_done
}

brew_bundle

install_dotfiles

install_xcode_select
install_rdm
install_npm_packages
install_gh_extensions
install_fzf

initialize_neovim
initialize_tmux

teardown
