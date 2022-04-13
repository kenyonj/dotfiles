Justin Kenyon's dotfiles
===============


What's in it?
-------------
Here is a sampling. For a complete list of features, please review the source.

### [git](http://git-scm.com/) configuration:
  - `g` : `git`
  - `amend` : `git commit --amend`
  - `amendne` : `git commit --amend --no-edit`
  - `ga` : `git add`
  - `gs` : `git status -s`
  - `gall` : `git add -A`
  - `gap` : `git add -p`
  - `gb` : `git branch`
  - `gba` : `git branch -a`
  - `gbrn` : `git branch -m`
  - `gc` : `git commit`
  - `gcl` : `git clone`
  - `hc` : `hub clone`
  - `gcm` : `git commit -m`
  - `gco` : `git checkout`
  - `gcp` : `git cherry-pick`
  - `gd` : `git diff`
  - `gf` : `git fetch`
  - `gl` : `git log -10 --pretty=colored`
  - `gm` : `git merge`
  - `gnb` : `git checkout -b`
  - `gp` : `git push -u`
  - `gpf!` : `git push --force-with-lease`
  - `gpr` : `hub pull-request`
  - `gr` : `git rebase`
  - `gra!` : `git rebase --abort`
  - `grc!` : `git rebase --continue`
  - `gri` : `git rebase -i`
  - `gs` : `git status -s`
  - `standup` : `git standup`
  - `gcb!` : `git branch -d \`git branch --merged | grep -v "^*" | grep -v "main" | tr -d "\n"\``

### [zsh](http://zsh.sourceforge.net/FAQ/zshfaq01.html) configuration and aliases:
  * `..`: moves up 1 directory, alias of `cd ..`
  * `...`: moves up 2 directories, alias of `cd ../..`
  * `j <part of directory name>`: uses [fasd](https://github.com/clvv/fasd) to
    jump to previously visited directories (stored in `~/.fasd`). For example,
    if I execute `j local` it will `cd` into my `dotfiles-local` directory
    because it is the most recent directory I visited that matches my argument
    of `local`.

### [tmux](http://tmux.sourceforge.net/) configuration:
  * Uses `CTRL-a` for the command key
  * All of the following command keys need to be preceeded by entering command
    mode:
    - `r`: reloads the `~/.tmux.conf` config file
    - `^T`: vertical split, 25%
    - `^U`: horizontal split, 30%
    - `c`: new window in current session
    - `|`: splits the current pane horizontally, 50%
    - `-`: splits the current pane vertically, 50%
    - `^A`: cycles the cursor through the visable panes
    - `+`: zooms in and out of current pane
    - `^C`: clears the buffer in the current pane

### [neovim](http://neovim.io/) configuration:
  * Leader key (`space-bar`) followed by:
    - `e[direction]`: open a netrw view in the direction (`h`,`j`,`k`,`l`)
    relative to the currently selected window.
    - `rc`: run the current test file in a tmux pane
    - `rn`: run the nearest to cursor test in a tmux pane
    - `rl`: run the last test in a tmux pane
    - `d`: insert a debugging statement (e.g. `binding.pry`) in a new line below the cursor position
    - `r`: toggle between `Relative Number` and normal line numbering
  * `gc`: comment/uncomment the current line or the visual selection
  * Aliased commands
    - `:W`: `:w`
    - `:Q`: `:q`
    - `:Wq`: `:wq`
    - `jj`: `ESC`
