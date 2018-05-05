#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

#
# aliases
#

# pacman
alias update="yes | sudo pacman -Syu"

# ls
alias ls='ls --color=auto'

# power
alias reboot='udiskie-umount -a && reboot'
alias poweroff='udiskie-umount -a && poweroff'

# git
alias git-list='git ls-tree -r master --name-only'
alias git-graph='git log --graph --oneline'
alias git-count='git shortlog -ens'

# wifi
alias conn='nmcli dev wifi con'

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
#------------#
#   HOW TO   #
#------------#
#- Init DB
alias psql-create="rm -rf $PGDATA/ && initdb --locale "$LANG" -E UTF8"
#- Launch server
alias psql-launch="postgres -D "$PGDATA" -k /tmp"
#- Connect
alias psql-con="psql -h localhost postgres"
#postgres=# ALTER ROLE login SUPERUSER;
#postgres=# CREATE DATABASE name OWNER login;
#postgres=# \q
#- Launch interactive shell
#psql -h localhost -d j4_tutorial
