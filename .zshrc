# history configuration
HISTFILE="$HOME/.zsh_history"   # history file location
HISTSIZE=1000000                # number of history items to keep in memory
SAVEHIST=$HISTSIZE              # number of items to keep in history file
setopt BANG_HIST                # treat the '!' character specially during expansion
setopt EXTENDED_HISTORY         # write the history file in the ":start:elapsed;command" format
setopt INC_APPEND_HISTORY       # write to the history file immediately, not when the shell exits
setopt SHARE_HISTORY            # share history between all sessions
setopt HIST_EXPIRE_DUPS_FIRST   # expire duplicate entries first when trimming history
setopt HIST_IGNORE_DUPS         # don't record an entry that was just recorded again
setopt HIST_IGNORE_ALL_DUPS     # delete old recorded entry if new entry is a duplicate
setopt HIST_FIND_NO_DUPS        # do not display a line previously found
setopt HIST_IGNORE_SPACE        # don't record an entry starting with a space
setopt HIST_SAVE_NO_DUPS        # don't write duplicate entries in the history file
setopt HIST_REDUCE_BLANKS       # remove superfluous blanks before recording entry
setopt HIST_VERIFY              # don't execute immediately upon history expansion
setopt HIST_BEEP                # beep when accessing nonexistent history

# path modifications
export PATH="/usr/local/opt/libressl/bin:$PATH" # use newer libressl instead of system
export PATH="/usr/local/opt/curl/bin:$PATH"     # use newer curl instead of system

# env vars
EDITOR="nvim"    # set the editor to neovim

# aliases
alias ls="ls -G"                                                                 # make ls output colorful
alias dotfiles='/usr/local/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME' # manage dotfiles with git

### Added by Zinit's installer
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

# Load a few important annexes, without Turbo
# (this is currently required for annexes)
zinit light-mode for \
    zinit-zsh/z-a-rust \
    zinit-zsh/z-a-as-monitor \
    zinit-zsh/z-a-patch-dl \
    zinit-zsh/z-a-bin-gem-node

### End of Zinit's installer chunk

# zsh plugins
zinit ice compile'(pure|async).zsh' pick'async.zsh' src'pure.zsh'
zinit light sindresorhus/pure                              # minimalistic prompt
zinit light zdharma/history-search-multi-word              # better reverse history search
zinit light djui/alias-tips                                # reminder to use aliases when possible
zinit snippet OMZP::colored-man-pages                      # add color to man pages
zinit snippet OMZP::ssh-agent                              # auto start ssh-agent
zstyle :omz:plugins:ssh-agent identities id_rsa id_rsa_moj # load ssh keys
export NVM_LAZY_LOAD=true                                  # load nvm when it is used rather than on startup
zinit light lukechilds/zsh-nvm                             # manage and load nvm
zinit snippet OMZP::rbenv                                  # load rbenv

# auto completions
autoload -Uz compinit
compinit -i
zstyle ':completion:*' menu select # use menu style to pick completions

# load these plugins last
zinit wait lucid for \
 atinit"ZINIT[COMPINIT_OPTS]=-C; zicompinit; zicdreplay" \
    zdharma/fast-syntax-highlighting \
 blockf \
    zsh-users/zsh-completions \
 atload"!_zsh_autosuggest_start" \
    zsh-users/zsh-autosuggestions
