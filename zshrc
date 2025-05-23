# Add binstubs to path
export PATH=".git/safe/../../bin:$PATH"

# Some tools and languages don't have a reasonable XDG_CONFIG_HOME setup on
# macOS so we need to set it manually
export XDG_CONFIG_HOME="$HOME/.config"

autoload -Uz compinit compdef

# Load completions for brew and brew installed packages that provide completions
if type brew &>/dev/null
then
  FPATH="$(brew --prefix)/share/zsh/site-functions:${FPATH}"

  compinit
fi

# Load autocomplete
for dump in ~/.zcompdump(N.mh+24); do
  compinit
done

compinit -C

if [[ -f /usr/local/share/zsh/site-functions ]]; then
  # Load completion functions
  fpath=(/usr/local/share/zsh/site-functions $fpath)
fi

# Case insensitive
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'

# Load Colors
autoload -U colors
colors
export CLICOLOR=1

# Better less
export LESS="--status-column --ignore-case --LONG-PROMPT --HILITE-UNREAD --tabs=4 --window=-4 --RAW-CONTROL-CHARS"

export LESS_TERMCAP_mb=$'\E[1;31m'     # Set bold to red
export LESS_TERMCAP_md=$'\E[1;36m'     # Set blink to cyan
export LESS_TERMCAP_me=$'\E[0m'        # clear bold/blink
export LESS_TERMCAP_so=$'\E[1;34m'     # bold blue for highlighted text
export LESS_TERMCAP_se=$'\E[0m'        # clear reverse video
export LESS_TERMCAP_us=$'\E[4;32m'     # begin underline
export LESS_TERMCAP_ue=$'\E[0m'        # reset underline

# Show ls on dark backgrounds well
unset LSCOLORS
export LSCOLORS=gxfxcxdxbxegedabagacad
export LS_COLORS=$LSCOLORS

# Disable weird piping behavior
unsetopt multios

# Notify before prompt instead of directly on exit
unsetopt notify

# Set grep options
alias grep='grep --color=auto --ignore-case'

# Partial match highlighting
zstyle -e ':completion:*:default' list-colors \
  'reply=("${PREFIX:+=(#bi)($PREFIX:t)()*==34=34}:${(s.:.)LS_COLORS}")'

# Setup corrections to ignore case and correct me when I'm wrong
zstyle ':completion:*' menu completer _extensions _complete _approximate _files
zstyle ':completion:*' scroll true
zstyle ':completion:*:*:*:*:corrections' ignore-case true
zstyle ':completion:*:*:*:*:corrections' format '%F{yellow}Corrected command%f'
zstyle ':completion:*:warnings' format '%F{red}No matches found%f'

# Enable descriptions for completion
zstyle ':completion:*:descriptions' format '%B%d%b'

zstyle ':completion:*' use-cache yes
zstyle ':completion:*' verbose yes

# Enable shift-tab to go backwards
bindkey '^[[Z' reverse-menu-complete

setopt append_history         # Append, not replace
setopt inc_append_history     # Immediately append history
setopt always_to_end          # Always go to end of line on complete
setopt correct                # Correct typos
setopt hist_ignore_dups       # Do not show dupes in history
setopt hist_ignore_space      # Ignore commands starting with space
setopt prompt_subst           # Necessary for pretty prompts

# HISTORY!
HISTSIZE=10000
SAVEHIST=10000
HISTFILE=~/.history

# Vim like history search
autoload -U up-line-or-beginning-search
autoload -U down-line-or-beginning-search
zle -N up-line-or-beginning-search
zle -N down-line-or-beginning-search

# Use vi keybindings
bindkey -v

bindkey "^[[A" up-line-or-beginning-search # Up
bindkey "^[[B" down-line-or-beginning-search # Down
bindkey "$key[Up]" up-line-or-beginning-search # Up
bindkey "$key[Down]" down-line-or-beginning-search # Down

# Allow backspace after vi mode
bindkey '^?' backward-delete-char

# Beginning and End line shortcuts
bindkey "^a" beginning-of-line
bindkey "^e" end-of-line
bindkey "^k" kill-line

# use a quick `jj` keystroke to get into vim mode on the command line
bindkey "jj" vi-cmd-mode

# search history with control-r
bindkey "^R" history-incremental-search-backward

# Reset pane names in tmux to "" instead of "hostname"
if [[ -n "$TMUX" ]]; then
  echo -ne "\033]2;\033\\"
fi

# Load all files in ~/.zsh
for function in ~/.zsh/*.zsh; do
  source $function
done

export RIPGREP_CONFIG_PATH="$HOME/.ripgreprc"

# Report basic title
function precmd {
  local escaped_home=$(echo $HOME | sed -e 's|/|\\/|'g)
  local title=$(pwd | sed "s/^$escaped_home/~/")
  print -Pn "\e]0;$title\a"
}

# Export editor preference
export EDITOR=nvim
export VISUAL=nvim

if [[ "$TERM_PROGRAM" == "vscode" ]]; then
  export EDITOR=vim
  export VISUAL="code --wait"
fi

if [[ -z "$CODESPACES" ]]; then
  if [[ -f /opt/homebrew/etc/profile.d/autojump.sh ]]; then
    . /opt/homebrew/etc/profile.d/autojump.sh
  elif [[ -f /usr/local/etc/profile.d/autojump.sh ]]; then 
    . /usr/local/etc/profile.d/autojump.sh
  fi

  if [[ -f /opt/homebrew/bin/mise ]]; then
    eval "$(/opt/homebrew/bin/mise activate zsh)"
  elif [[ -f /usr/local/bin/mise ]]; then
    eval "$(/usr/local/bin/mise activate zsh)"
  fi

  [ -f ~/.local/bin/mise ] && eval "$(~/.local/bin/mise activate zsh)"

  # Trust mise versions, if there are any untrusted files
  if mise status | grep -q "untrusted"; then
    mise trust
  fi
else
  export PATH="/workspaces/github/vendor/node:$PATH"
  [ -f /usr/share/autojump/autojump.sh ] && . /usr/share/autojump/autojump.sh
fi

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

export SKIP_GH_PRE_PUSH_HOOKS
