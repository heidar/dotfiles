### Added by Zinit's installer
if [[ ! -f $HOME/.local/share/zinit/zinit.git/zinit.zsh ]]; then
    print -P "%F{33} %F{220}Installing %F{33}ZDHARMA-CONTINUUM%F{220} Initiative Plugin Manager (%F{33}zdharma-continuum/zinit%F{220})…%f"
    command mkdir -p "$HOME/.local/share/zinit" && command chmod g-rwX "$HOME/.local/share/zinit"
    command git clone https://github.com/zdharma-continuum/zinit "$HOME/.local/share/zinit/zinit.git" && \
        print -P "%F{33} %F{34}Installation successful.%f%b" || \
        print -P "%F{160} The clone has failed.%f%b"
fi

source "$HOME/.local/share/zinit/zinit.git/zinit.zsh"
autoload -Uz _zinit
(( ${+_comps} )) && _comps[zinit]=_zinit

# Load a few important annexes, without Turbo
# (this is currently required for annexes)
zinit light-mode for \
    zdharma-continuum/zinit-annex-as-monitor \
    zdharma-continuum/zinit-annex-bin-gem-node \
    zdharma-continuum/zinit-annex-patch-dl \
    zdharma-continuum/zinit-annex-rust

### End of Zinit's installer chunk

# use neovim
export EDITOR=nvim
alias v=nvim
alias vim=nvim

# vi mode
bindkey -v
zinit light jeffreytse/zsh-vi-mode

# syntax highlighting
zinit light zdharma-continuum/fast-syntax-highlighting
zstyle :plugin:history-search-multi-word reset-prompt-protect 1

# colors
alias ls="ls --color"
zinit snippet OMZP::colored-man-pages

# history settings
export HISTFILE=~/.histfile
export HISTSIZE=1000000   # the number of items for the internal history list
export SAVEHIST=1000000   # maximum number of items for the history file
setopt HIST_IGNORE_ALL_DUPS  # do not put duplicated command into history list
setopt HIST_SAVE_NO_DUPS  # do not save duplicated command
setopt HIST_REDUCE_BLANKS  # remove unnecessary blanks
setopt HIST_VERIFY # don't execute immediately upon history expansion
setopt HIST_IGNORE_SPACE # don't record an entry starting with a space
setopt INC_APPEND_HISTORY_TIME  # append command to history file immediately
setopt EXTENDED_HISTORY  # record command start time
setopt SHARE_HISTORY # share history between all sessions
zinit light zdharma-continuum/history-search-multi-word

# auto start ssh-agent
zinit snippet OMZP::ssh-agent

# open github pull requests
zinit light caarlos0-graveyard/zsh-open-pr

# git aliases
zinit snippet https://github.com/sorin-ionescu/prezto/blob/master/modules/git/alias.zsh

# manage dotfiles with git
alias dotfiles='git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'

# forget completions provided up to this moment
zinit cdclear -q

# autocomplete
autoload -Uz compinit
compinit
zstyle ':completion:*' menu select
zstyle ':completion::complete:*' gain-privileges 1

# load these plugins last
zinit wait lucid for \
 atinit"ZINIT[COMPINIT_OPTS]=-C; zicompinit; zicdreplay" \
    zdharma-continuum/fast-syntax-highlighting \
 blockf \
    zsh-users/zsh-completions \
 atload"!_zsh_autosuggest_start" \
    zsh-users/zsh-autosuggestions

# load prompt
eval "$(starship init zsh)"
