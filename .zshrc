HISTSIZE=10000000
SAVEHIST=10000000
HISTFILE=~/.zsh_history
EDITOR="nvim"

setopt BANG_HIST              # Treat the '!' character specially during expansion.
setopt EXTENDED_HISTORY       # Write the history file in the ":start:elapsed;command" format.
setopt INC_APPEND_HISTORY     # Write to the history file immediately, not when the shell exits.
setopt SHARE_HISTORY          # Share history between all sessions.
setopt HIST_EXPIRE_DUPS_FIRST # Expire duplicate entries first when trimming history.
setopt HIST_IGNORE_DUPS       # Don't record an entry that was just recorded again.
setopt HIST_IGNORE_ALL_DUPS   # Delete old recorded entry if new entry is a duplicate.
setopt HIST_FIND_NO_DUPS      # Do not display a line previously found.
setopt HIST_IGNORE_SPACE      # Don't record an entry starting with a space.
setopt HIST_SAVE_NO_DUPS      # Don't write duplicate entries in the history file.
setopt HIST_REDUCE_BLANKS     # Remove superfluous blanks before recording entry.
setopt HIST_VERIFY            # Don't execute immediately upon history expansion.
setopt HIST_BEEP              # Beep when accessing nonexistent history.

export ZPLUG_HOME=/usr/local/opt/zplug
source $ZPLUG_HOME/init.zsh

zplug mafredri/zsh-async
zplug chrissicool/zsh-256color
zplug sindresorhus/pure, use:pure.zsh, as:theme
zplug zsh-users/zsh-syntax-highlighting
zplug zsh-users/zsh-completions
zplug djui/alias-tips
zplug sparsick/ansible-zsh
zplug ael-code/zsh-colored-man-pages
zplug unixorn/git-extra-commands
zplug modules/git, from:prezto
zplug caarlos0/zsh-open-pr
zplug zdharma/history-search-multi-word
zplug plugins/ssh-agent, from:oh-my-zsh
zplug plugins/bundler, from:oh-my-zsh
zplug plugins/ruby, from:oh-my-zsh
zplug plugins/rails, from:oh-my-zsh
zplug akarzim/zsh-docker-aliases
zplug tmuxinator/tmuxinator, use: completion/tmuxinator.zsh
zplug plugins/tmuxinator, from:oh-my-zsh

zplug load

autoload -Uz compinit
compinit
zstyle ':completion:*' menu select

alias vim=nvim
alias vi=nvim
alias v=nvim
alias dotfiles='/usr/local/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'
alias tx='tmuxinator'
alias txx'tmuxinator stop'

source /usr/local/share/chruby/chruby.sh
source /usr/local/share/chruby/auto.sh
chruby ruby-2.6.1

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
export FZF_DEFAULT_COMMAND='ag --nocolor --ignore node_modules -g ""'

# Load nvm
export NVM_DIR="$HOME/.nvm"
[ -s "/usr/local/opt/nvm/nvm.sh" ] && . "/usr/local/opt/nvm/nvm.sh"
[ -s "/usr/local/opt/nvm/etc/bash_completion" ] && . "/usr/local/opt/nvm/etc/bash_completion"
