alias ae="nvim ~/.aliases.zsh"
alias ar="source ~/.aliases.zsh; echo 'aliases reloaded!'"

alias ..="cd .."

alias zr="source ~/.zshrc; echo 'zshrc reloaded!'"

alias b="bundle"
alias be="bundle exec"

alias mkdir="mkdir -p"
alias migrate="rake db:migrate db:rollback && rake db:migrate"
alias drop="rake db:drop && rake db:create && rake db:migrate"

alias nodeplz="npm cache clear && npm install"
alias fucknode="rm -rf node_modules"
alias omgnode="fucknode && nodeplz"
alias nbin='PATH=$(npm bin):$PATH nocorrect'

alias r="echo not this time"
alias fucking="pkill -9 -f"

alias dc="docker-compose"
alias dm="docker-machine"

export EDITOR=nvim
export VISUAL=nvim

alias vim=nvim

# FASD jump to recently used items
alias a="fasd -a" # any
alias s="fasd -s" # show / search / select
alias d="fasd -d" # directory
alias f="fasd -f" # file
alias j="fasd_cd -d" # cd, same functionality as j in autojump
alias v="f -e nvim" # quick opening files with neovim

alias c="bin/console"

# git
alias g="git"
alias amend="git commit --amend"
alias amendne="git commit --amend --no-edit"
alias ga="git add"
alias gs="git status -s"
alias gall="git add -A"
alias gap="git add -p"
alias gb="git branch"
alias gba="git branch -a"
alias gbrn="git branch -m"
alias gc="git commit"
alias gcl="git clone"
alias hc="hub clone"
alias gcm="git commit -m"
alias gco="git checkout"
alias gcp="git cherry-pick"
alias gd="git diff"
alias gf="git fetch"
alias gl="git log -10 --pretty=colored"
alias gm="git merge"
alias gnb="git checkout -b"
alias gp="git push -u"
alias gpf!="git push --force-with-lease"
alias gpr="hub pull-request"
alias gr="git rebase"
alias gra!="git rebase --abort"
alias grc!="git rebase --continue"
alias gri="git rebase -i"
alias gs="git status -s"
alias standup="git standup"
alias gcb!='git branch -d `git branch --merged | grep -v "^*" | grep -v "main" | tr -d "\n"`'

# tmux
alias tmux="tmux new-session -A -s main"

alias taf!="TEST_ALL_FEATURES=1 fc -e : -1"

# aliases for codespaces
if [[ -n "$CODESPACES" ]]
then
  alias pbcopy="rdm copy"
  alias open="rdm open"
  alias xdg-open="rdm open"
fi
