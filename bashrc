#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# aliases
alias ls='ls --color=auto'
alias reboot='udiskie-umount -a && reboot'
alias poweroff='udiskie-umount -a && poweroff'

# exports
export PS1="[\e[36m\u\e[0m@\e[32m\h\e[0m \W]\e[31m\$?\e[0m$ "
export EDITOR=vim
export PAGER=most
