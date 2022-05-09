# Enable completions
autoload -U compinit && compinit

# Enable regex moving
autoload -U zmv

# Style ZSH output
zstyle ':completion:*:descriptions' format '%U%B%F{red}%d%f%b%u'
zstyle ':completion:*:warnings' format '%BSorry, no matches for: %d%b'

# Case insensitive completion
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'

# Case insensitive globbing
setopt no_case_glob

# Expand parameters, commands and aritmatic in prompts
setopt prompt_subst

# Colorful prompt with Git and Subversion branch
autoload -U colors && colors

export PROMPT='%{$fg_bold[blue]%}%~%b%f %{$fg_bold[blue]%}# %b%f'
export RPROMPT=''

# more macOS/Bash-like word jumps
export WORDCHARS=""

if [[ -z "$CODESPACES" ]]; then
  eval "$(/opt/homebrew/bin/brew shellenv)"
  git config --global gpg.program "/.codespaces/bin/gh-gpgsign"
fi

eval "$(fasd --init auto)"
