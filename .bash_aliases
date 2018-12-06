##################
# git
alias gdi='git diff --color'
alias gitall='for b in master prod rc; do git checkout $b; git pull; done'

gr() {
    RESULT=`git diff`
    if [ -z "$RESULT" ]; then
        git pull
    else
        git stash
        git pull
        git stash pop
    fi
}

###################
# Docker
alias dc='docker-compose'

###################
# FS navigation
cd() {
    if [ ! "$1" ]; then
        cd ~
    else
        pushd "$@" 2>&1>/dev/null
    fi
}

back() {
    if [ ! "$1" ]; then
        back 1
    elif (( $1 > 0 )); then
        popd 2>&1>/dev/null
        back $(($1 - 1))
    fi
}

up() {
    if [ ! "$1" ]; then
        up 1
    elif (( $1 > 0 )); then
        up $(($1 - 1)) "../$2"
    else
        cd "./$2"
    fi
}

###################
# fabric tab-complete
_fab()
{
    local cur
    COMPREPLY=()
    # Variable to hold the current word
    cur="${COMP_WORDS[COMP_CWORD]}"

    # Build a list of the available tasks using the command 'fab -l'
    local tags=$(fab -l 2>/dev/null | grep "^ " | awk '{print $1;}')

    # Generate possible matches and store them in the
    # array variable COMPREPLY
    COMPREPLY=($(compgen -W "${tags}" $cur))
}

# Assign the auto-completion function _fab for our command fab.
complete -F _fab fab
