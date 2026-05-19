alias ae="nvim ~/.zsh/aliases.zsh"
alias ar="source ~/.zsh/aliases.zsh; echo 'aliases reloaded!'"

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

alias fucking="pkill -9 -f"

alias dc="docker-compose"
alias dm="docker-machine"

export EDITOR=nvim
export VISUAL=nvim

alias vim=nvim

# git
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
alias gl="git log -10 --abbrev-commit --branches"
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
alias mrwr='gh pr edit --add-label "Mark Ready When Ready"'

if [[ -n "$TMUX" ]] then
  alias tmux &>/dev/null && unalias tmux
  alias clear="clear && tmux clear-history"
else
  alias tmux="tmux new-session -A -s main"
fi


alias taf!="TEST_ALL_FEATURES=1 fc -e : -1"

# aliases for codespaces
if [[ -n "$CODESPACES" ]]
then
  alias open="rdm open"
  alias xdg-open="rdm open"
fi

connect-codespace() {
  gh cs ssh --config > ~/.ssh/codespaces
  local hosts=($(awk '/^Host cs\./ {print $2}' ~/.ssh/codespaces))

  if [[ ${#hosts[@]} -eq 0 ]]; then
    echo "No codespaces found"
    return 1
  fi

  echo "Select a codespace:"
  local i=1
  for host in "${hosts[@]}"; do
    echo "  $i) $host"
    ((i++))
  done

  read "choice?> "
  if [[ "$choice" -ge 1 && "$choice" -le ${#hosts[@]} ]] 2>/dev/null; then
    ssh "${hosts[$choice]}"
  else
    echo "Invalid selection"
    return 1
  fi
}

alias gh-web-port-forward="gh cs ports forward 80:80"

gocoverstats() {
    local t=$(mktemp -t cover)
    go test $COVERFLAGS -coverprofile=$t $@ \
        && go tool cover -func=$t \
        && unlink $t
}

gocover() {
    local t=$(mktemp -t cover)
    go test -coverprofile=$t $@ \
        && go tool cover -html=$t \
        && unlink $t
}

if command -v eza > /dev/null 2>&1; then
  alias ls="eza"
fi

# gh slack: pull xoxc token + cookie from local Slack desktop client and export
# into the current shell. Required once per shell before running gh slack
# send/api/read. The MCP Slack server (mcp.slack.com) is read-only; this is
# the write path.
alias slack-auth='eval "$(gh slack auth -t github)"'
