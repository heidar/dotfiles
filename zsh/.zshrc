# 1. Editor & keymap
export EDITOR=nvim
bindkey -v

alias ls='eza -alh --group-directories-first'
alias cat='bat --paging=always'
alias du='dust'
alias ps='procs'
alias ffind='fd'

# 2. rbenv – Ruby version manager
if command -v rbenv >/dev/null 2>&1; then
  eval "$(rbenv init - zsh)"
fi

# 3. History (lean, timestamped, deduped)
HISTSIZE=200000
SAVEHIST=$HISTSIZE
setopt INC_APPEND_HISTORY_TIME HIST_IGNORE_ALL_DUPS HIST_REDUCE_BLANKS HIST_VERIFY HIST_IGNORE_SPACE SHARE_HISTORY  # timestamps, deduplication, blanks, verify, space‑ignore, cross‑session

# 4. Antidote plugin manager and core plugins
source "${ZDOTDIR:-$HOME}/.antidote/antidote.zsh"
antidote load   # reads ~/.zsh_plugins.txt (see below)

# 5. Completion system
autoload -Uz compinit
compinit -C               # skip recompiles when possible
_comp_options+=(globdots) # include dot-files in <Tab> matches
zstyle ':completion:*' menu select
zstyle ':completion::complete:*' gain-privileges 1
bindkey '^F' autosuggest-accept

# 6. Load Starship
eval "$(starship init zsh)" 
