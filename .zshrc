# history file location
HISTFILE="$HOME/.zsh_history"
# number of history items to keep in memory
HISTSIZE=1000000
# number of items to keep in history file
SAVEHIST=$HISTSIZE
# treat the '!' character specially during expansion
setopt BANG_HIST
# write the history file in the ":start:elapsed;command" format
setopt EXTENDED_HISTORY
# write to the history file immediately, not when the shell exits
setopt INC_APPEND_HISTORY
# share history between all sessions
setopt SHARE_HISTORY
# expire duplicate entries first when trimming history
setopt HIST_EXPIRE_DUPS_FIRST
# don't record an entry that was just recorded again
setopt HIST_IGNORE_DUPS
# delete old recorded entry if new entry is a duplicate
setopt HIST_IGNORE_ALL_DUPS
# do not display a line previously found
setopt HIST_FIND_NO_DUPS
# don't record an entry starting with a space
setopt HIST_IGNORE_SPACE
# don't write duplicate entries in the history file
setopt HIST_SAVE_NO_DUPS
# remove superfluous blanks before recording entry
setopt HIST_REDUCE_BLANKS
# don't execute immediately upon history expansion
setopt HIST_VERIFY
# beep when accessing nonexistent history
setopt HIST_BEEP

# use newer libressl instead of system
export PATH="/usr/local/opt/libressl/bin:$PATH"
# use newer curl instead of system
export PATH="/usr/local/opt/curl/bin:$PATH"
# add vscode to path
export PATH="$PATH:/Applications/Visual Studio Code.app/Contents/Resources/app/bin"

# set the editor to neovim
EDITOR="nvim"

# make ls output colorful
alias ls="ls -G"
# manage dotfiles with git
alias dotfiles='/usr/local/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'

# go paths
export GOPATH=$HOME/go
export PATH=$PATH:$GOPATH/bin

# added by zinit's installer
if [[ ! -f $HOME/.zinit/bin/zinit.zsh ]]; then
    print -P "%F{33}▓▒░ %F{220}Installing %F{33}DHARMA%F{220} Initiative Plugin Manager (%F{33}zdharma/zinit%F{220})…%f"
    command mkdir -p "$HOME/.zinit" && command chmod g-rwX "$HOME/.zinit"
    command git clone https://github.com/zdharma/zinit "$HOME/.zinit/bin" && \
        print -P "%F{33}▓▒░ %F{34}Installation successful.%f%b" || \
        print -P "%F{160}▓▒░ The clone has failed.%f%b"
fi

source "$HOME/.zinit/bin/zinit.zsh"
autoload -Uz _zinit
(( ${+_comps} )) && _comps[zinit]=_zinit

# load a few important annexes, without turbo
# (this is currently required for annexes)
zinit light-mode for \
    zinit-zsh/z-a-rust \
    zinit-zsh/z-a-as-monitor \
    zinit-zsh/z-a-patch-dl \
    zinit-zsh/z-a-bin-gem-node

# end of zinit's installer chunk

# minimalistic prompt
zinit ice compile'(pure|async).zsh' pick'async.zsh' src'pure.zsh'
zinit light sindresorhus/pure
# better reverse history search
zinit light zdharma/history-search-multi-word
# reminder to use aliases when possible
zinit light djui/alias-tips
# add color to man pages
zinit snippet OMZP::colored-man-pages
# auto start ssh-agent
zinit snippet OMZP::ssh-agent
# load ssh keys
zstyle :omz:plugins:ssh-agent identities id_rsa id_rsa_moj
# load nvm when it is used rather than on startup
export NVM_LAZY_LOAD=true
# manage and load nvm
zinit light lukechilds/zsh-nvm
# load rbenv
zinit snippet OMZP::rbenv
# needed to download all files in the git plugin below
zinit ice svn
# git aliases
zinit snippet PZT::modules/git
# forget completions provided up to this moment
zinit cdclear -q
# rails aliases
zinit snippet OMZP::rails
# open-pr shortcut
zinit light caarlos0-graveyard/zsh-open-pr

# auto completions
autoload -Uz compinit
compinit -i
# use menu style to pick completions
zstyle ':completion:*' menu select

# load these plugins last
zinit wait lucid for \
 atinit"ZINIT[COMPINIT_OPTS]=-C; zicompinit; zicdreplay" \
    zdharma/fast-syntax-highlighting \
 blockf \
    zsh-users/zsh-completions \
 atload"!_zsh_autosuggest_start" \
    zsh-users/zsh-autosuggestions

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
