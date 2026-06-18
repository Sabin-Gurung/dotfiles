# export FZF_DEFAULT_COMMAND='fd -t f --color=never'
export FZF_DEFAULT_COMMAND='fd -t f --follow'
export PATH="$PATH:$HOME/dotfiles/bin"
export EDITOR='nvim'

alias cls="clear"
alias ..="cd .."
alias ...="cd ../.."

alias cpd='cd $(ls -d $HOME/workspace/wallapop*/* $HOME/workspace/personal_code/* | \
sed "s|$HOME|~|g" | \
fzf | \
sed "s|~|$HOME|g"
)'

alias v="nvim"
alias vim="nvim"
alias vi="nvim"
alias vd="cd ~/dotfiles/ && nvim"
alias vpd='cpd && cde'
alias cdd='cd ~/Downloads/'
alias cdww='cd ~/workspace/wallapop_code/'
alias cdwp='cd ~/workspace/personal_code/'

alias lgs="lazygit"
alias lgd="lazydocker"
alias gs="git status"
alias gbd="git branch | grep -E -v 'master|main' | xargs git branch -D"
alias gp="git push"
alias gpl="git pull --all"
alias gb="git checkout -b"
gc() {
    git checkout $(git --no-pager branch -a | fzf --height 45% --reverse)
}

alias cow="fortune | cowsay"

alias dockx='docker stop $(docker ps -q)'
alias dockr='docker-compose restart'

# 7-zip
7zip() {
    7zz a "$1.7z" "${@:2}"
}
7zipmax() {
    7zz a -t7z -mx=9 -p -mhe=on "$1.7z" "${@:2}"
}
alias 7unzip='7zz x'
alias 7peek='7zz l'


alias vopen='vera mount'
alias vclose='vera unmount'
alias vlist='veracrypt --text --list'

repo() {
  tmp=$(mktemp)

  {
    gh repo list --limit 1000 --json nameWithOwner,url &
    gh repo list untitledev-np --limit 1000 --json nameWithOwner,url &
    # gh repo list Litto-devs-np --limit 1000 --json nameWithOwner,url &
    # gh repo list Nepikose --limit 1000 --json nameWithOwner,url &
    gh repo list Wallapop --limit 1000 --json nameWithOwner,url &
    wait
  } \
  | jq -s 'add | unique_by(.nameWithOwner)' \
  | jq -r '.[] | "\(.nameWithOwner)\t\(.url)"' \
  | fzf --with-nth=1 \
  | cut -f2 \
  | xargs git clone
}

