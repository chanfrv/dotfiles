PROMPT='$(git_prompt_info)'
PROMPT+="%(!:%{$fg_bold[red]%}:%{$fg_bold[cyan]%})%n%{$reset_color%}"
PROMPT+="%{$fg_bold[white]%}:%{$reset_color%}"
PROMPT+="%{$fg_bold[green]%}%m%{$reset_color%} "
PROMPT+="%c> "

RPROMPT="%(?::%{$fg[red]%}%? ↵%{$reset_color%})"

ZSH_THEME_GIT_PROMPT_PREFIX="%{$fg_bold[cyan]%}(%{$fg[white]%}"
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$reset_color%} "
ZSH_THEME_GIT_PROMPT_DIRTY="%{$fg[cyan]%}) %{$fg[yellow]%}●"
ZSH_THEME_GIT_PROMPT_CLEAN="%{$fg[cyan]%}) %{$fg[green]%}●"
