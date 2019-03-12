#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# Don't put duplicate lines or lines starting with space in the history.
HISTCONTROL=ignoreboth
HISTSIZE=1000
HISTFILESIZE=2000

# Append to the history file, don't overwrite it
shopt -s histappend

# Check windows size after each command
shopt -s checkwinsize

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

# Git
alias git-list='git ls-tree -r master --name-only'
alias git-graph='git log --graph --oneline'
alias git-count='git shortlog -ens'

alias i3lock='i3lock -ti ~/Pictures/wmap.png'

# PS1
ps1_b="\[\e[36m\]"
ps1_g="\[\e[32m\]"
ps1_r="\[\e[31m\]"
ps1_0="\[\e[0m\]"
export PS1="[${ps1_b}\u${ps1_0}@${ps1_g}\h${ps1_0} \W]${ps1_r}\$?${ps1_0}$ "

# editor
export EDITOR=vim

# jetbrains
export JAVA_HOME=/usr/lib/jvm/default
export PATH=$PATH:/opt/gradle/gradle-4.6/bin

# postgreSQL
export PGDATA="$HOME/postgres_data"
export PGDIR="/tmp"

alias psql-create="rm -rf "$PGDATA/" && initdb --locale "$LANG" -E UTF8"
alias psql-con="psql -h localhost postgres"
alias psql-launch="postgres -D "$PGDATA" -k "$PGDIR""
