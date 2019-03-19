#!/bin/bash

# Handles the dotfiles by either updating the user configuration
# or by him updating the repository.
# Note that, as a user, you may need the repository's rights to
# update.

#
# Vars
#

script="$0"
tracked="bashrc config vimrc Xresources"
template="dotfiles"
tracked_tmp_file=$(find /tmp -name "$template.*" 2> /dev/null | head -n 1)

if [ ! -f "$tracked_tmp_file" ]; then
  tracked_tmp_file=$(mktemp "/tmp/$template.XXXXXX")
fi

echo "$tracked_tmp_file"


#
# Helpers
#

tracked_files()
{
  cat "$tracked_tmp_file"
}

clear_tracked_file()
{
  if [ -f "$tracked_tmp_file" ]; then rm "$tracked_tmp_file"; fi
}

#
# Options
#

help()
{
  printf "%s\n"     "Commands:"
  printf "\t%s\n"   "help               Show the command list"
  printf "\t%s\n"   "install            Install the configuration on your machine"
  printf "\t%s\n"   "update             Update the repository dotfiles"
  printf "\t%s\n"   "tracked tcommands  More commands on the tracked files. See TCommands below"
  printf "\t%s\n\n" "exit               Exit the interactive shell"

  printf "%s\n"     "TCommands:"
  printf "\t%s\n"   "list               List tracked files"
  printf "\t%s\n"   "add files..        Add files to the tracked files"
  printf "\t%s\n"   "create files..     Clean the tracked files and add the files"
  printf "\t%s\n\n" "remove files..     Remove files from the tracked list"

  printf "%s\n"     "You may notice that you are able to launch bash commands!"
  printf "%s\n"     "Don't get cocky each command run in a different subshell,"
  printf "%s\n\n"   "but don't you worry I am working on it."
  printf "%s\n"     "If you have information on how to run an interactive"
  printf "%s\n"     "subshell, while keeping the environment all along,"
  printf "%s\n\n"   "please contact victor.chanfrault@outlook.fr."
}

full_help()
{
  printf "%s\n\n"   "Usage: $script [options]"

  printf "%s\n"     "Options:"
  printf "\t%s\n"   "-h, --help      Show this help"
  printf "\t%s\n\n" "-v, --version   Show the current version"

  help
}

version()
{
  printf "%s" "$script: Version "
  git describe --tags
}

_try_help()
{
  printf "%s\n" "Try '$script --help' for more information"
}

unrecognized()
{
  printf "%s\n" "$script: Unrecognized option $1"
  _try_help
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
  args="$@"
  printf " %s" "$args" >> "$tracked_tmp_file"
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

_tracked_try_help()
{
  printf "%s\n" "Try 'help' for more information"
}

tracked_missing()
{
  printf "%s\n" "$script tracked: Missing operand"
  _tracked_try_help
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
    "create") shift && tracked_create "$@"  ;; # TODO: fix
    "remove") shift && tracked_remove "$@"  ;;
    "")       tracked_missing               ;;
    *)        tracked_unrecognized "$1"     ;;
  esac
}

#
# Commands
#

_copy_file()
{
  if [ $(diff "$1" "$2" > /dev/null) ]; then
    printf "%s\n" "Copying $1 to $2 ..."

    if [ -d "$1" ]; then
      cp -r "$1" "$2"
    else
      dir="$(dirname $2)"
      [[ ! -d "$dir" ]] && mkdir -p "$dir"
      cp "$1" "$2"
    fi
    return 0
  else
    printf "%s\n" "$1 and $2 does not differ, skipping ..."
    return 1
  fi
}

_poll()
{
  read line

  case "$line" in
    "y"|"Y"|"yes"|"Yes")
      for file in $(tracked_files); do
        _copy_file "$file" "$HOME/.$file"
      done
      ;;
    "n"|"N"|"no"|"No"|"nonononono")
      printf "%s\n" "Exiting ..."
      exit 0
      ;;
    *)
      printf "%s" "Yes or no? "
      _poll
      ;;
  esac
}

install()
{
  printf "%s\n%s" "You are about to overwrite your current configuration files," \
                  "are you sure? (Y/n) "
  _poll
}

update()
{
  diff=""

  for file in $(tracked_files); do
    if [ $(_copy_file "$HOME/.$file" "$file") ]; then
      git add "$file"
      diff="$diff $file"
    fi
  done

  printf "%s\n" "Files changed:"
  for arg in $diff; do
    printf "\t%s\n" "$arg"
  done
  printf "%s\n" "Commiting ..."
  git commit -m "$USER: updated files $diff"
}

commands()
{
  if [ "$#" -gt 0 ]; then
    case "$1" in
      "h"|"help")       help                          ;;
      "i"|"install")    install                       ;;
      "u"|"update")     update                        ;;
      "t"|"tracked")    shift && tracked $@           ;;
      "e"|"exit")       exit 0                        ;;
      "")               return 0                      ;;
      *)                bash -c "$@"                  ;;
#      *)                unrecognized_command "$1"     ;;
    esac
  fi
}

#
# Program entry point
#

tracked_create "$tracked"

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

  while true; do
    printf "%s" "(dotfiles) $?$ " # TODO: printf "%s" "(dotfiles) $PS1"
    read line
    commands $line
  done
fi
