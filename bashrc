export FZF_DEFAULT_COMMAND='fd -t f --color=never'
export EDITOR='nvim'

alias cls="clear"
alias ..="cd .."
alias ...="cd ../.."
alias cpd='cd $(fd .git$ -t d -H ~/workspace | sed -e "s/.git\\///g" | fzf --height 45% --reverse)'

alias lf="yazi"
alias v="nvim"
alias vim="nvim"
alias vi="nvim"
alias vc="cd ~/.config/nvim/ && nvim"
alias vd="cd ~/dotfiles/ && nvim"
alias vpd='cpd && nvim'
alias cdgd='cd ~/Downloads/'

alias lgs="lazygit"
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

alias veracrypt='/Applications/VeraCrypt.app/Contents/MacOS/VeraCrypt --text'
alias vopen='veracrypt --mount ~/vault.vc ~/vault-open --keyfiles=\"\" --pim 0'
alias vclose='veracrypt --dismount ~/vault-open'
alias lock='veracrypt --dismount --all'
# alias lock='veracrypt --dismount --all && pmset displaysleepnow'
#
# mkdir -p ~/vault-open

# veracrypt --create ~/vault.vc \
#   --size 100G \
#   --encryption AES \
#   --hash SHA-512 \
#   --volume-type normal \
#   --filesystem exfat \
#   --pim 0 \
#   --keyfiles="" \
#   --random-source /dev/urandom \
#   --dynamic

# veracrypt --create ~/vault/personal-vault.vc \
#   --size 100G \
#   --encryption AES \
#   --hash SHA-512 \
#   --volume-type normal \
#   --filesystem exfat \
#   --pim 0 \
#   --keyfiles="" \
#   --random-source /dev/urandom \
#   --dynamic


export PATH="$PATH:$HOME/dotfiles/scripts"
