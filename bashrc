# [ -f ~/.fzf.bash ] && source ~/.fzf.bash
export FZF_DEFAULT_COMMAND='fd -t f --color=never'


alias cls="clear"
alias ..="cd .."
alias ...="cd ../.."
alias cpd='cd $(fd .git$ -t d -H ~/workspace | sed -e "s/.git//g" | fzf --height 45% --reverse)'

alias v="nvim"
alias vd="nvim ~/tools/todo/todo.todo"
alias vpd='cpd && nvim'

alias gs="git status"
alias gbd="git checkout master && git branch | grep -v master | xargs git branch -D"
alias gp="git push"
alias gpl="git pull --all"
alias gb="git checkout -b"
gc() {
    git checkout $(git --no-pager branch -a | fzf --height 45% --reverse)
}

alias cow="fortune | cowsay"
cow
