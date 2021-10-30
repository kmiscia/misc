export PATH="$HOME/.rbenv/bin:$PATH"
eval "$(rbenv init -)"

export CLICOLOR=1
export TERM=xterm-256color

export LSCOLORS=GxFxCxDxBxegedabagaced

alias showFiles='defaults write com.apple.finder AppleShowAllFiles YES; killall Finder /System/Library/CoreServices/Finder.app'
alias hideFiles='defaults write com.apple.finder AppleShowAllFiles NO; killall Finder /System/Library/CoreServices/Finder.app'
alias killpuma="pkill -9 -f 'puma'"

# up 'n' folders
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias .....='cd ../../../..'

function parse_git_branch() {
    git branch 2> /dev/null | sed -n -e 's/^\* \(.*\)/[\1]/p'
}

COLOR_DEF=$'\e[0m'
COLOR_USR=$'\e[38;5;243m'
COLOR_DIR=$'\e[38;5;197m'
COLOR_GIT=$'\e[38;5;39m'
setopt PROMPT_SUBST
export PROMPT='${COLOR_DIR}%~ ${COLOR_GIT}$(parse_git_branch)${COLOR_DEF} $ '

ssh-add /Users/kmiscia/.ssh/id_rsa > /dev/null 2>&1

zstyle ':completion:*:*:git:*' script ~/.zsh/git-completion.bash
fpath=(~/.zsh $fpath)
autoload -Uz compinit && compinit

export PATH=/usr/local/sbin:$PATH

alias be='bundle exec'
alias hb='cd ~/workspace/houwzer-backend'
alias hbp='cd ~/workspace/houwzer-backend-production'
alias hf='cd ~/workspace/houwzer-frontend'
alias hfp='cd ~/workspace/houwzer-frontend-production'
alias pull-production-db-to-dev='~/Documents/houwzer/shell_scripts/pull_production_db_into_development.sh'
alias pull-production-db-to-production='~/Documents/houwzer/shell_scripts/pull_production_db_into_production.sh'

export TEST_ENV_NUMBER=6

export EDITOR="code -w"

export NVM_DIR="$HOME/.nvm"
  [ -s "/opt/homebrew/opt/nvm/nvm.sh" ] && . "/opt/homebrew/opt/nvm/nvm.sh"  # This loads nvm
  [ -s "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm" ] && . "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm"  # This loads nvm bash_completion
