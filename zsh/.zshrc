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
export BAT_THEME=ansi
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
source "$(brew --prefix)/opt/antidote/share/antidote/antidote.zsh"
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
# fzf (fuzzy finder — ctrl+r history, ctrl+t file picker, alt+c cd)
##############################
if defaults read -g AppleInterfaceStyle 2>/dev/null | grep -q Dark; then
  # Catppuccin Mocha
  _fzf_colors="--color=bg+:#313244,bg:#1e1e2e,spinner:#f5e0dc,hl:#f38ba8,fg:#cdd6f4,header:#f38ba8,info:#cba6f7,pointer:#f5e0dc,marker:#b4befe,fg+:#cdd6f4,prompt:#cba6f7,hl+:#f38ba8,border:#585b70"
else
  # Catppuccin Latte
  _fzf_colors="--color=bg+:#ccd0da,bg:#eff1f5,spinner:#dc8a78,hl:#d20f39,fg:#4c4f69,header:#d20f39,info:#8839ef,pointer:#dc8a78,marker:#7287fd,fg+:#4c4f69,prompt:#8839ef,hl+:#d20f39,border:#acb0be"
fi
export FZF_DEFAULT_OPTS="$_fzf_colors --layout=reverse --border=rounded --height=40% --prompt='❯ ' --pointer='▸' --marker='✓' --info=inline"
unset _fzf_colors
eval "$(fzf --zsh)"

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

# Added by LM Studio CLI (lms)
export PATH="$PATH:/Users/heidar/.lmstudio/bin"
# End of LM Studio CLI section

