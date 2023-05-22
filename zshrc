# check if this is a login shell
[ "$0" = "-zsh" ] && export LOGIN_ZSH=1

# run zprofile if this is not a login shell
[ -n "$LOGIN_ZSH" ] && source ~/.zprofile

if [[ -n "$CODESPACES" ]]
then
  gh config set browser "rdm open"
fi

source "$HOME/.aliases.zsh"

# History file
export HISTFILE=~/.zsh_history

# Don't show duplicate history entires
setopt hist_find_no_dups

# Remove unnecessary blanks from history
setopt hist_reduce_blanks

# Share history between instances
setopt share_history

# Don't hang up background jobs
setopt no_hup

# use emacs bindings even with vim as EDITOR
bindkey -e

# use a quick `jj` keystroke to get into vim mode on the command line
bindkey jj vi-cmd-mode

# fix backspace on Debian
[ -n "$LINUX" ] && bindkey "^?" backward-delete-char

# alternate mappings for Ctrl-U/V to search the history
bindkey "^u" history-beginning-search-backward
bindkey "^v" history-beginning-search-forward
export PATH="/usr/local/bin:$PATH"

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
export FZF_DEFAULT_COMMAND='ag -l --path-to-ignore ~/.ignore --nocolor --hidden -g ""'
export FZF_DEFAULT_OPTS='--color=16'
export OVERMIND_TMUX_CONFIG="$HOME/.tmux.overmind.conf"

if [[ -z "$CODESPACES" ]]
then
  source $HOMEBREW_PREFIX/opt/chruby/share/chruby/chruby.sh
  source $HOMEBREW_PREFIX/opt/chruby/share/chruby/auto.sh
  export PATH="$HOMEBREW_PREFIX/opt/libpq/bin:$PATH"
else
  export N_PREFIX="$HOME/n"; [[ :$PATH: == *":$N_PREFIX/bin:"* ]] || PATH+=":$N_PREFIX/bin"
fi
