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

# more on ls
alias ll='ls -l'
alias la='ls -A'
alias l='ls -CF'
alias lla='ls -lA'

# cd
alias cd..='cd ..'

# editor
export EDITOR=vim
export VISUAL=vim

# clipboard
alias cpy="wl-copy"
alias pst="wl-paste"
alias clr="wl-copy -c"

# Git
alias git-list='git ls-tree -r master --name-only'
alias git-graph='git log --graph --oneline'
alias git-count='git shortlog -ens'

# transmission
alias tms="transmission-remote"

# PS1
blue="\[\e[01;34m\]"
green="\[\e[01;32m\]"
red="\[\e[01;31m\]"
blank="\[\e[0m\]"

if [ "$EUID" -eq 0 ]; then
	# Running as root
	export PS1="${red}\u:${blue}\W ${red}\$?${blue}$ ${blank}"
else
	# Running as a user
	export PS1="${green}\u:${blue}\W ${red}\$?${blue}$ ${blank}"
fi

[[ -z "$SSH_CONNECTION" ]] || export PS1="\[\e[01m\](ssh) \[\e[0m\]$PS1"
