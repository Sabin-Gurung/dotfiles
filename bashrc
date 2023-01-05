export FZF_DEFAULT_COMMAND='fd -t f --color=never'

alias cls="clear"
alias ..="cd .."
alias ...="cd ../.."
alias cpd='cd $(fd .git$ -t d -H ~/workspace | sed -e "s/.git\\///g" | fzf --height 45% --reverse)'

alias v="nvim"
alias vc="cd ~/.config/nvim/ && nvim"
alias vd="cd ~/dotfiles/ && nvim"
alias vpd='cpd && nvim'

alias gs="git status"
alias gbd="git branch | grep -E -v 'master|main' | xargs git branch -D"
alias gp="git push"
alias gpl="git pull --all"
alias gb="git checkout -b"
gc() {
    git checkout $(git --no-pager branch -a | fzf --height 45% --reverse)
}

alias cow="fortune | cowsay"
