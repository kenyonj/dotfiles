Justin Kenyon's dotfiles
===============

How to install them?
--------------------

1. Run this command in your terminal:
```bash
curl -fsSL https://raw.githubusercontent.com/kenyonj/dotfiles/main/script/remote_install | bash
```

The setup script supports several options:
  - `-b`: Skip the Homebrew bundle step
  - `-m`: Skip the Mise step
  - `-e`: Exclude system customizations
  - `-f file`: Specify a Brewfile (default: `Brewfile`)
  - `-L level`: Set log level (`DEBUG`, `INFO`, `WARN`, `ERROR`)
  - `-h`: Show help

What's in it?
-------------
Here is a sampling. For a complete list of features, please review the source.

### [git](http://git-scm.com/) configuration:
  - `g`: `git status` (or `git <args>` when arguments are provided)
  - `amend`: `git commit --amend`
  - `amendne`: `git commit --amend --no-edit`
  - `ga`: `git add`
  - `gall`: `git add -A`
  - `gap`: `git add -p`
  - `gb`: `git branch`
  - `gba`: `git branch -a`
  - `gbrn`: `git branch -m`
  - `gc`: `git commit`
  - `gcl`: `git clone`
  - `gcm`: `git commit -m`
  - `gco`: `git checkout`
  - `gcp`: `git cherry-pick`
  - `gd`: `git diff`
  - `gf`: `git fetch`
  - `gl`: `git log -10 --abbrev-commit --branches`
  - `gm`: `git merge`
  - `gnb`: `git checkout -b`
  - `gp`: `git push -u`
  - `gpf!`: `git push --force-with-lease`
  - `gr`: `git rebase`
  - `gra!`: `git rebase --abort`
  - `grc!`: `git rebase --continue`
  - `gri`: `git rebase -i`
  - `gs`: `git status -s`
  - `standup`: `git standup`
  - `gcb!`: delete all merged branches (except `main`)
  - `mrwr`: `gh pr edit --add-label "Mark Ready When Ready"`
  - Git config sets `push.autoSetupRemote`, `pull.rebase`, `merge.ff = only`, `fetch.prune`, and `commit.verbose`

### [zsh](http://zsh.sourceforge.net/FAQ/zshfaq01.html) configuration and aliases:
  * Vi keybindings enabled (`bindkey -v`), with `jj` to enter vi command mode
  * `..`: moves up 1 directory, alias of `cd ..`
  * `j <part of directory name>`: uses [autojump](https://github.com/wting/autojump)
    to jump to previously visited directories
  * `vim`: aliased to `nvim`
  * `ls`: aliased to `eza` (if installed)
  * `b`: `bundle`, `be`: `bundle exec`
  * `dc`: `docker-compose`, `dm`: `docker-machine`
  * `migrate`: `rake db:migrate db:rollback && rake db:migrate`
  * `ae`: edit aliases, `ar`: reload aliases, `zr`: reload zshrc
  * Custom minimal prompt: `<directory> ❯` (magenta on success, red on error)
  * [fzf](https://github.com/junegunn/fzf) integration with ripgrep as default command
  * [mise](https://mise.jdx.dev/) for tool version management
  * [1Password](https://1password.com/) CLI integration for loading secrets

### [tmux](http://tmux.sourceforge.net/) configuration:
  * Uses `CTRL-a` for the prefix key
  * Vim-style pane navigation (`h`, `j`, `k`, `l`) and Alt-key pane navigation
  * [vim-tmux-navigator](https://github.com/christoomey/vim-tmux-navigator) plugin for seamless vim/tmux navigation
  * All of the following keys are preceded by the prefix key:
    - `r`: reloads the `~/.tmux.conf` config file
    - `^T`: horizontal split, 25%
    - `^U`: vertical split, 30%
    - `c`: new window in current path
    - `|`: vertical split in current path
    - `-`: horizontal split in current path
    - `a`: toggle status bar
    - `t`: popup shell (80% width/height)
    - `g`: popup [lazygit](https://github.com/jesseduffield/lazygit) (80% width/height)
  * Arrow keys resize panes
  * Vi copy-mode with `v` to select and `y`/`Enter` to copy (via `pbcopy`)
  * Mouse support enabled
  * 1-indexed windows, auto-renumbering
  * Codespaces-aware status bar styling

### Homebrew packages (via [Brewfile](Brewfile)):
  * CLI tools: `bat`, `fzf`, `gh`, `git`, `ripgrep`, `jq`, `tmux`, `neovim`, `lazygit`, `fd`, `tree`, `wget`, `mise`, `ollama`, `pandoc`, and more
  * Casks: Ghostty, Kitty, Raycast, 1Password, Arc, Firefox Developer Edition, Google Chrome, Slack, OrbStack, and more

### App configurations (via `config/`):
  * [Neovim](http://neovim.io/) (`config/nvim/`)
  * [Ghostty](https://ghostty.org/) (`config/ghostty/`)
  * [Kitty](https://sw.kovidgoyal.net/kitty/) (`config/kitty/`)
  * [Lazygit](https://github.com/jesseduffield/lazygit) (`config/lazygit/`)
  * [bat](https://github.com/sharkdp/bat) (`config/bat/`)
  * [Mise](https://mise.jdx.dev/) (`config/mise/`)
