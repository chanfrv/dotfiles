#!/bin/bash

# Handles the dotfiles by either updating the user configuration
# or by him updating the repository.
# Note that, as a user, you may need the repository's rights to
# update.

#
# Vars
#

script="$0"
tracked="bashrc config vimrc Xresources config/i3 config/polybar"

# Restore tracked tmp file from /tmp, or create it
tracked_tmp_file=$(find /tmp -name "dotfiles.*" 2> /dev/null | head -n 1)
if [ ! -f "$tracked_tmp_file" ]; then
  tracked_tmp_file=$(mktemp "/tmp/dotfiles.XXXXXX")
fi

# Options for pretty print
declare -A Options
Options+=(["-h, --help"]="Show this help")
Options+=(["-v, --version"]="Show the current version")

declare -A Commands
Commands+=(["h, help"]="Show the command list")
Commands+=(["i, install"]="Install the configuration on your machine")
Commands+=(["u, update"]="Update the repository dotfiles")
Commands+=(["t, tracked tcommand"]="More commands on the tracked files")
Commands+=(["e, exit"]="Exit the interactive shell")

declare -A TCommands
TCommands+=(["list"]="List tracked files")
TCommands+=(["add files.."]="Add files to the tracked files")
TCommands+=(["create files.."]="Clean the tracked files and add the files")
TCommands+=(["remove files.."]="Remove files from the tracked list")

# History
HISTCONTROL=ignoreboth
HISTFILE="$PWD/.dotfiles_history"
HISTTIMEFORMAT='%F %T '

#
# Functions
#

print()
{
  [[ -n "$1" ]] || return 1
  declare -n array="$1"

  max=0
  for comm in "${!array[@]}"; do
    [[ "$max" -lt "${#comm}" ]] && max=${#comm}
  done

  printf "%s:\n" "${!array}"

  for comm in "${!array[@]}"; do
    printf "\t%-${max}s  %s\n" "$comm" "${array[$comm]}"
  done

  printf "\n"
}

#
# Helpers
#

tracked_files()
{
  cat "$tracked_tmp_file"
}

clear_tracked_file()
{
  [[ -f "$tracked_tmp_file" ]] && rm "$tracked_tmp_file"
}

#
# Options
#

help()
{
  print Commands
  print TCommands

  printf "%s\n"   "You may notice that you are able to launch bash commands!"
  printf "%s\n"   "Don't get cocky each command run in a different subshell,"
  printf "%s\n\n" "but don't you worry I am working on it."
  printf "%s\n"   "If you have information on how to run an interactive"
  printf "%s\n"   "subshell, while keeping the environment all along,"
  printf "%s\n\n" "please contact victor.chanfrault@outlook.fr."
}

full_help()
{
  printf "%s\n%s\n\n" \
         "Usage: $script [options]" \
         "Launches an interactive shell to manage dotfiles."

  print Options

  help
}

version()
{
  printf "%s" "$script: Version "
  git describe --tags
}

try_help()
{
  printf "%s\n" "Try '$script --help' for more information"
}

unrecognized()
{
  printf "%s\n" "$script: Unrecognized option $1"
  try_help
  exit 1
}

#
# Tracked files
#

tracked_list()
{
  printf "%s\n" "Tracked files:"
  for file in $(tracked_files); do
    printf "\t%s\n" "$file"
  done
}

tracked_add()
{
  printf " %s" "$1" >> "$tracked_tmp_file"
}

tracked_create()
{
  args="$@"
  printf "%s" "$args" > "$tracked_tmp_file"
}

tracked_remove()
{
  for arg in "$@"; do
    tracked="$(echo $tracked | sed "s/$arg//g")"
  done

  tracked_create "$tracked"
}

tracked_try_help()
{
  printf "%s\n" "Try 'help' for more information"
}

tracked_missing()
{
  printf "%s\n" "$script tracked: Missing argument"
  tracked_try_help
}

tracked_unrecognized()
{
  printf "%s\n" "$script tracked: Unrecognised option $1"
  _tracked_try_help
}

tracked()
{
  case "$1" in
    "list")   tracked_list                  ;;
    "add")    shift && tracked_add "$@"     ;;
    "create") shift && tracked_create "$@"  ;;
    "remove") shift && tracked_remove "$@"  ;;
    "")       tracked_missing               ;;
    *)        tracked_unrecognized "$1"     ;;
  esac
}

#
# Commands
#

copy_file()
{
  if [ -f "$1" ] && [ -f "$2" ] && [ $(diff "$1" "$2" > /dev/null) ]; then
    printf "%s\n" "Copying '$1' to '$2' ..."

    if [ -d "$1" ]; then
      cp -r "$1" "$2"
    else
      dir="$(dirname $2)"
      [[ ! -d "$dir" ]] && mkdir -p "$dir"
      cp "$1" "$2"
    fi
    return 0
  else
    printf "%s\n" "'$1' and '$2' are identical"
    return 1
  fi
}

poll()
{
  for file in $(tracked_files); do
    home_file="$HOME/.$file"
    if [ -f "$home_file" ] && [ -z $(diff "$home_file" "$file") ]; then
      printf "%s %s" "Local file $home_file differs from the version from the" \
        "repository. Update? (y/n) "

      read -e line

      case "$line" in
        "y"|"Y"|"yes"|"Yes")
          copy_file "$file" "$home_file"
          ;;
        "n"|"N"|"no"|"No"|"nonononono")
          continue
          ;;
        *)
          printf "%s" "Yes or no? "
          poll
          ;;
      esac
    fi
  done
}

install()
{
  poll
}

update()
{
  diff=""

  for file in $(tracked_files); do
    [[ -f "$HOME/.$file" ]] && copy_file "$HOME/.$file" "$file"
  done
}

quit()
{
  printf "%s\n" "Is it 'quit' or 'exit'? Or is it 'bye'... Annoying, eh?"
}

commands()
{
  if [ "$#" -gt 0 ]; then
    case "$1" in
      "h"|"help")    help                       ;;
      "i"|"install") install                    ;;
      "u"|"update")  update                     ;;
      "t"|"tracked") shift && tracked $@        ;;
      "e"|"exit")    exit 0                     ;;
      "q"|"quit")    quit                       ;;
      "")            return 0                   ;;
      *)             bash -c "$@"               ;;
#      *)             unrecognized_command "$1"  ;;
    esac
  fi
}

#
# Program entry point
#

for file in $tracked; do
  tracked_add "$file"
done

if [ "$#" -gt 0 ]; then
  case "$1" in
    "-h"|"--help")    full_help                       ;;
    "-v"|"--version") version                         ;;
    "-c"|"--command") shift && commands "$@"; exit 0  ;;
    *)                unrecognized "$1"               ;;
  esac
else
  printf "%s\n\t%s\n\t%s\n\t%s\n\n"                      \
    "$0 (2019)"                                          \
    "Welcome to the most unnecessary script ever."       \
    "Please do not underestimate boredom."               \
    "Feel free to use the command 'help' to get started."

  set -o history

  while true; do
    read -p "dotfiles> " -e line

    case $line in
      "^[[A")        history-search-backward  ;;
      "^[[B")        history-search-forward   ;;
    esac

    history -s "$line"

    commands $line
  done
fi
