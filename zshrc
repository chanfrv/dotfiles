#: Oh my Zsh {{{

# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="victor"

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in $ZSH/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to automatically update without prompting.
DISABLE_UPDATE_PROMPT="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS="true"

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

# Remove "Insecure completion-dependent directories detected" blablabla.
ZSH_DISABLE_COMPFIX="true"

# Would you like to use another custom folder than $ZSH/custom?
ZSH_CUSTOM="$ZSH/custom"

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(
    git
    zsh-autosuggestions
    zsh-completions
    zsh-syntax-highlighting
)

fpath=("$ZSH/custom/functions" $fpath)

source $ZSH/oh-my-zsh.sh

#: }}}

#: User configuration {{{

# GCC
export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

# editor
export EDITOR=nvim
export VISUAL=nvim

# history
HISTSIZE=10000
SAVEHIST=10000

# Aliases
alias ls='ls --color=tty -N'
alias l='ls -F'
alias la='ls -A'
alias lla='ls -lAh'

alias dfh='df -h'
alias duh='du -had 1'
alias dd='dd status=progress'

# reminders
alias installed='pacgraph -c'
alias vpn='wg-quick'
alias metadata='exiv2'
alias ascii='figlet'
alias nf='neofetch'
alias pt='powertop'
alias top='gtop'
alias ippub='curl ifconfig.co'
alias comp='docker-compose'
alias vim='nvim'

function pdf {
    evince "$@" &
}

function pdfmerge {
    if [ "$#" -lt 3 ]; then
        echo "Usage: $0 output.pdf input1.pdf input2.pdf..."
        return 1
    fi
    gs -dBATCH -dNOPAUSE -q -sDEVICE=pdfwrite -sOutputFile="$1" ${@:2}
}

function image {
    eog "$@" &
}

function whereis {
    [[ "$1" =~ "([0-9]{1,3}.?){4}$" ]] || return 1
    curl -s "ipwhois.app/json/$1" | python -m json.tool
}

#: }}}
