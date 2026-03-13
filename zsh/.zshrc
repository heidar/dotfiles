#!/usr/bin/env zsh

##############################
# PATH
##############################
export PATH="$HOME/.local/bin:$PATH"

##############################
# Editor
##############################
export EDITOR=nvim
export VISUAL="zed --wait"

##############################
# Modern CLI replacements (interactive only)
##############################
alias ls='eza -alh --group-directories-first'
alias tree='eza --tree'
alias cat='bat --paging=never'
alias cd='z'

##############################
# History (lean, timestamped, deduped)
##############################
HISTSIZE=200000
SAVEHIST=$HISTSIZE
setopt INC_APPEND_HISTORY_TIME HIST_IGNORE_ALL_DUPS HIST_REDUCE_BLANKS HIST_VERIFY HIST_IGNORE_SPACE SHARE_HISTORY

##############################
# Antidote plugin manager
##############################
source "${ZDOTDIR:-$HOME}/.antidote/antidote.zsh"
antidote load   # reads ~/.zsh_plugins.txt

##############################
# Completion system
##############################
autoload -Uz compinit
compinit -C               # skip recompiles when possible
_comp_options+=(globdots) # include dot-files in <Tab> matches
zstyle ':completion:*' menu select
zstyle ':completion::complete:*' gain-privileges 1
bindkey '^F' autosuggest-accept

##############################
# zoxide (smart cd)
##############################
eval "$(zoxide init zsh)"

##############################
# mise (dev environment manager)
##############################
eval "$(mise activate zsh)"

##############################
# direnv (per-project env vars)
##############################
eval "$(direnv hook zsh)"

##############################
# Starship prompt
##############################
eval "$(starship init zsh)"
