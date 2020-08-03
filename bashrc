#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# Don't put duplicate lines or lines starting with space in the history.
HISTCONTROL=ignoreboth
HISTSIZE=10000
HISTFILESIZE=20000

# Append to the history file, don't overwrite it
shopt -s histappend

# Check windows size after each command
shopt -s checkwinsize

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# ** match all files and zero or more dirs and subdirs
shopt -s globstar

# color support
alias ls='ls --color=auto'
alias dir='dir --color=auto'
alias vdir='vdir --color=auto'
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'

export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

alias ll='ls -l'
alias la='ls -A'
alias l='ls -CF'
alias lla='ls -lA'
alias cd..='cd ..'
alias echo='echo -e'
alias mkdir='mkdir -p'

# editor
export EDITOR=vim
export VISUAL=vim

alias vimrc="$EDITOR ~/.vimrc"
alias bashrc="$EDITOR ~/.bashrc"

# clipboard
clipboard()
{
    case "$1" in
        'c'|'copy')		wl-copy ;;
        'p'|'paste')	wl-paste ;;
        'clear')	    wl-copy -c ;;
        *)				echo "cliboard copy|paste|clear" ;;
    esac
}
alias cb='clipboard'

# Git
alias git-list='git ls-tree -r master --name-only'
alias git-graph='git log --graph --oneline'
alias git-count='git shortlog -ens'

gitc()
{
    if [ -z "$1" ]; then
        printf "Usage: %s user/repo\n" "${FUNCNAME[0]}"
    else
        git clone "git@github.com:/$1 --recurse-submodules -j$(nproc)"
    fi
}



# pdf
pdf() { evince "$@" & }

#image
image() { eog "$@" & }

# PS1
__ps1_user="\[\e[96m\]\u\[\e[0m\]"
__ps1_root="\[\e[91m\]\u\[\e[0m\]"
__ps1_host="\[\e[92m\]\h\[\e[0m\]"
__ps1_pwd="\W"
#__ps1_err="\[\e[91m\]\$?\[\e[0m\]"

if [ "$EUID" -eq 0 ]; then
    export PS1="${__ps1_root}@${__ps1_host} ${__ps1_pwd}> "
else
    export PS1="${__ps1_user}@${__ps1_host} ${__ps1_pwd}> "
fi

[[ -z "SSH_CONNECTION" ]] && export PS1="(ssh) $PS1"
