#!/bin/zsh

#      o  _ _|_  _   ,_  
# |  |_| /   |  / \_/  | 
#  \/  |/\__/|_/\_/    |/

# Colors
function zsh_theme_rst {
    echo "%{$reset_color%}"
}

function zsh_theme_color {
    echo "%{$fg[$1]%}"
}

function zsh_theme_color_bold {
    echo "%{$fg_bold[$1]%}"
}


# Info
function zsh_theme_username {
    echo "%(!:$(zsh_theme_color_bold red):$(zsh_theme_color_bold cyan))%n$(zsh_theme_rst)"
}

function zsh_theme_hostname {
    echo "$(zsh_theme_color_bold green)%m$(zsh_theme_rst)"
}

function zsh_theme_directory {
    echo "%c"
}

function zsh_theme_errcode {
    echo "%(?::$(zsh_theme_color red)%? ↵$(zsh_theme_rst))"
}


# Prompt
PROMPT='$(git_prompt_info)$(zsh_theme_username):$(zsh_theme_hostname) $(zsh_theme_directory)> '

# Right prompt
RPROMPT='$(zsh_theme_errcode)'

# Git prompt
ZSH_THEME_GIT_PROMPT_PREFIX="$(zsh_theme_color cyan)($(zsh_theme_rst)"
ZSH_THEME_GIT_PROMPT_SUFFIX="$(zsh_theme_rst) "
ZSH_THEME_GIT_PROMPT_DIRTY="$(zsh_theme_color cyan)) $(zsh_theme_color yellow)●"
ZSH_THEME_GIT_PROMPT_CLEAN="$(zsh_theme_color cyan)) $(zsh_theme_color green)●"
