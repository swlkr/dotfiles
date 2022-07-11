# Load version control information
autoload -Uz vcs_info
autoload -U colors && colors
autoload -Uz compinit && compinit
precmd() { vcs_info }

# Format the vcs_info_msg_0_ variable
zstyle ':vcs_info:git:*' formats '(%b)'

# Set up the prompt (with git branch name)
setopt PROMPT_SUBST
PROMPT='%{$fg[blue]%}%~ %{$fg[green]%}${vcs_info_msg_0_} %{$reset_color%}\$ '

alias p='cd ~/Projects'
alias reload='source ~/.zprofile'
alias hist='history | fzf'
alias top='htop'
alias gst='git status'
alias gs='git status'
alias recent='git for-each-ref --sort=-committerdate refs/heads/'
alias uuid="uuidgen | tr -d '\n'"
alias be="bundle exec"

HISTFILESIZE=1000000
HISTSIZE=1000000
HISTCONTROL=ignoreboth
HISTIGNORE='ls:bg:fg:history:gst:hist'
HISTTIMEFORMAT='%F %T '
PROMPT_COMMAND='history -a'

export PATH="$(pwd)/bin/docker:$PATH"
export PATH="/Users/sean/go/bin:$PATH"

mkfile() {
  mkdir -p $( dirname "$1") && touch "$1"
}
