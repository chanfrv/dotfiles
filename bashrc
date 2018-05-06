#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

#
# aliases
#

alias update="yes | sudo pacman -Syu"

alias ls='ls --color=auto'

alias reboot='udiskie-umount -a && reboot'
alias poweroff='udiskie-umount -a && poweroff'

alias git-list='git ls-tree -r master --name-only'
alias git-graph='git log --graph --oneline'
alias git-count='git shortlog -ens'

alias conn='nmcli dev wifi con'

alias i3lock='i3lock -ti ~/Pictures/wmap.png'

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

# java
export JAVA_HOME=/usr/lib/jvm/default
export PATH=$PATH:/opt/gradle/gradle-4.6/bin:$HOME/pycharm-2018.1.2/bin

# postgreSQL
export PGDATA="$HOME/postgres_data"

alias psql-create="rm -rf $PGDATA/ && initdb --locale "$LANG" -E UTF8"
alias psql-launch="postgres -D "$PGDATA" -k /tmp"
alias psql-con="psql -h localhost postgres"
