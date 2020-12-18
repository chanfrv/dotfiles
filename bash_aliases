#
# ~/.bash_aliases
#

# Path
export PATH="$PATH:/opt/GNAT/2020/bin"
export PATH="$PATH:/home/$USER/.config/Mbed Studio/mbed-studio-tools/python/bin"

# GCC
export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

# editor
export EDITOR=vim
export VISUAL=vim

# Aliases
alias sudo='sudo ' # make aliases usable by sudo
alias ls='ls --color=tty -N'
alias l='ls -F'
alias la='ls -A'
alias lla='ls -lAh'

alias df='df -h'
alias du='du -had 1'
alias dd='dd status=progress'
alias installed='find /var/lib/pacman/local/ \
    -mindepth 1 -maxdepth 1 -type d -printf "%TY-%Tm-%Td %TH:%TM %P\n" | sort'

# systemctl
alias sc-status='systemctl status'
alias sc-start='systemctl start'
alias sc-stop='systemctl stop'
alias sc-enable='systemctl enable'
alias sc-disable='systemctl disable'

# reminders
alias vpn='wg-quick'
alias format='mkfs.vfat'
alias metadata='exiv2'
alias ascii='figlet'
alias fetch='neofetch'

function pdf {
    evince "$@" &
}

function image {
    eog "$@" &
}
