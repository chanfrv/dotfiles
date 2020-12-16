#!/bin/zsh

#
# VICTOR ZSH PROMPT
#

# Colors
function zsh_theme_rst {
    echo "%{$reset_color%}"
}

function zsh_theme_c {
    echo "%{$fg[$1]%}"
}

function zsh_theme_cb {
    echo "%{$fg_bold[$1]%}"
}

# Info
function zsh_theme_username {
    echo "%(!:$(zsh_theme_cb red):$(zsh_theme_cb cyan))%n$(zsh_theme_rst)"
}

function zsh_theme_hostname {
    echo "$(zsh_theme_cb green)%m$(zsh_theme_rst)"
}

function zsh_theme_directory {
    echo "%c"
}

function zsh_theme_errcode {
    echo "%(?::$(zsh_theme_c red)%? ↵$(zsh_theme_rst))"
}

# Prompt
PROMPT='$(git_prompt_info)$(zsh_theme_username):$(zsh_theme_hostname) $(zsh_theme_directory)> '

# Right prompt
RPROMPT='$(zsh_theme_errcode)'

# Git prompt
ZSH_THEME_GIT_PROMPT_PREFIX="$(zsh_theme_c cyan)($(zsh_theme_rst)"
ZSH_THEME_GIT_PROMPT_SUFFIX="$(zsh_theme_rst) "
ZSH_THEME_GIT_PROMPT_DIRTY="$(zsh_theme_c cyan)) $(zsh_theme_c yellow)●"
ZSH_THEME_GIT_PROMPT_CLEAN="$(zsh_theme_c cyan)) $(zsh_theme_c green)●"
