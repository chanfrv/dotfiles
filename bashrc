#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

#
# aliases
#

# ls
alias ls='ls --color=auto'

# power
alias reboot='udiskie-umount -a && reboot'
alias poweroff='udiskie-umount -a && poweroff'

# git
alias git-list='git ls-tree -r master --name-only'
alias git-graph='git log --graph --oneline'
alias git-count='git shortlog -ens'

#
# exports
#

# PS1
ps1_b="\[\e[36m\]"
ps1_g="\[\e[32m\]"
ps1_r="\[\e[31m\]"
ps1_0="\[\e[0m\]"
export PS1="[${ps1_b}\u${ps1_0}@${ps1_g}\h${ps1_0} \W]${ps1_r}\$?${ps1_0}$ "

# editor
export EDITOR=vim
