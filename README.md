# Codespaces Dotfiles Template

This repo is a starting point for using custom dotfiles (terminal / editor configuration) with GitHub Codespaces

## How to use this repo

In order to use this template, 

1. [create a new repo from this template](https://github.com/github/codespaces-dotfiles-template/generate). Make it public and name it `dotfiles`.
1. Edit the files that you want to customize in `tmux.conf`, `vimrc`, etc.
1. Push your changes to your `dotfiles` repo
1. Create a new codespace, and see your new dotfiles
1. 🍾

## What's in here?

Just some blank configuration files for popular Text User Interface (TUI) apps that folks may want to use for development in codespaces and a script to put them in the right place.

This supports the following tools:

* Tmux
* Screen
* Vim
* Emacs

## Vim Plugins

This repo uses the wonderful [Vim Plug](https://github.com/junegunn/vim-plug) tool to manage vim plugins. If you'd like to add plugins, simply add them between the opening and closing plug statements in the `vimrc` file.
