#!/usr/bin/env zsh

##############################
# 1️⃣ Editor
##############################
export EDITOR=zed

##############################
# 2️⃣ Modern CLI replacements (interactive only)
##############################
alias ls='eza -alh --group-directories-first'
alias cat='bat --paging=never'
alias cd='z'

##############################
# 3️⃣ History (lean, timestamped, deduped)
##############################
HISTSIZE=200000
SAVEHIST=$HISTSIZE
setopt INC_APPEND_HISTORY_TIME HIST_IGNORE_ALL_DUPS HIST_REDUCE_BLANKS HIST_VERIFY HIST_IGNORE_SPACE SHARE_HISTORY

##############################
# 4️⃣ Antidote plugin manager
##############################
source "${ZDOTDIR:-$HOME}/.antidote/antidote.zsh"
antidote load   # reads ~/.zsh_plugins.txt

##############################
# 5️⃣ Completion system
##############################
autoload -Uz compinit
compinit -C               # skip recompiles when possible
_comp_options+=(globdots) # include dot-files in <Tab> matches
zstyle ':completion:*' menu select
zstyle ':completion::complete:*' gain-privileges 1
bindkey '^F' autosuggest-accept

##############################
# 6️⃣ zoxide (smart cd)
##############################
eval "$(zoxide init zsh)"

##############################
# 7️⃣ mise (dev environment manager)
##############################
eval "$(mise activate zsh)"

##############################
# 8️⃣ Starship prompt
##############################
eval "$(starship init zsh)"
