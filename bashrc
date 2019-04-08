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

# ----------------
#     ALIASES
# ----------------
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

# Git
alias git-list='git ls-tree -r master --name-only'
alias git-graph='git log --graph --oneline'
alias git-count='git shortlog -ens'

# editor
export EDITOR=vim

# visudo(8)
export VISUAL=vim

# jetbrains
export JAVA_HOME=/usr/lib/jvm/default
export PATH=$PATH:/opt/gradle/gradle-4.6/bin

# postgreSQL
export PGDATA="$HOME/postgres_data"
export PGDIR='/tmp'

alias psql-clean="[[ -d $PGDATA ]] && rm -rf $PGDATA"
alias psql-init="psql-clean && initdb --locale $LANG -E UTF8"
alias psql-server="postgres -D $PGDATA -k $PGDIR"
alias psql-conn="psql -h localhost postgres"

# ----------------
#       PS1
# ----------------
blue="\[\e[01;34m\]"
green="\[\e[01;32m\]"
red="\[\e[01;31m\]"
blank="\[\e[0m\]"

if [ "$EUID" -eq 0 ]; then
  # Running as root
  export PS1="${red}\u${green}@\h:${blue}\W ${red}\$?${blue}$ ${blank}"
else
  # Running as a user
  export PS1="${green}\u@\h:${blue}\W ${red}\$?${blue}$ ${blank}"
fi

[[ -z "$SSH_CONNECTION" ]] || export PS1="\[\e[01m\](ssh) \[\e[0m\]$PS1"

# ----------------
#    FUNCTIONS
# ----------------
# Easy extract
extract () {
  if [ -f $1 ] ; then
    case $1 in
      *.tar.bz2)   tar xvjf $1    ;;
      *.tar.gz)    tar xvzf $1    ;;
      *.bz2)       bunzip2 $1     ;;
      *.rar)       rar x $1       ;;
      *.gz)        gunzip $1      ;;
      *.tar)       tar xvf $1     ;;
      *.tbz2)      tar xvjf $1    ;;
      *.tgz)       tar xvzf $1    ;;
      *.zip)       unzip $1       ;;
      *.Z)         uncompress $1  ;;
      *.7z)        7z x $1        ;;
      *)           echo "cannot extract '$1'..." ;;
    esac
  else
    echo "'$1' is not a valid file!"
  fi
}

# Git statistics
git-stats()
{
  if [[ ! -z $(git rev-parse --is-inside-work-tree 2> /dev/null) ]]; then
    git log --numstat | awk '
    function printStats(author) {
      printf "\033[4m%s:\n\033[0m", author

      printf "  [+] insertions: %d  (%.0f%%)\n",
      more[author], (more[author] / more["total"] * 100)

      printf "  [-] deletions: %d  (%.0f%%)\n",
      less[author], (less[author] / less["total"] * 100)

      printf "  files: %d  (%.0f%%)\n",
      file[author], (file[author] / file["total"] * 100)

      printf "  commits: %d  (%.0f%%)\n",
      commits[author], (commits[author] / commits["total"] * 100)
    }

    /^Author:/ {
    author           = $2 " " $3
    commits[author]  += 1
    commits["total"] += 1
    }

    /^[0-9]/ {
    more[author] += $1
    less[author] += $2
    file[author] += 1

    more["total"] += $1
    less["total"] += $2
    file["total"] += 1
    }

    END {
      for (author in commits) {
        if (author != "total") {
          printStats(author)
        }
      }
      printStats("total")
    }'
  else
    echo 'git stats: not in a git repository.'
  fi
}
