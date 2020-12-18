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

# aliases
source ~/.bash_aliases
