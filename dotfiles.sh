#!/bin/sh

# Handles the dotfiles by either updating the user configuration
# or by him updating the repository.
# Note that, as a user, you may need the repository's rights to
# update.
#
# Author: victor chanfrault <victor.chanfrault@outlook.fr>

script="$0"
tracked="bashrc $(echo config/i3/*) $(echo config/polybar/*) vimrc Xresources"

# Shows a nice help
help()
{
  echo "Usage: $script [options] [command]"
  echo
  echo "Options:"
  echo "\t-h, --help      Show this help"
  echo "\t-v, --version   Show the current version"
  echo
  echo "Commands:"
  echo "\tinstall         Install the configuration on your machine"
  echo "\tupdate          Update the repository dotfiles"
  echo
  exit 0
}

# Shows last git tag
version()
{
  echo -n "$script version "
  git describe --tags
  exit 0
}

# Used in install()
copy_files()
{
  read line

  case "$line" in
    "y"|"Y"|"yes"|"Yes")
      for arg in "$tracked"; do
        dir="$(dirname $arg)"
        [[ -d "$dir" ]] && mkdir -p "$dir"

        echo "Copying $arg to ~/.$arg ..."
        cp "$arg" "~/.$arg"
      done
      ;;
    "n"|"N"|"no"|"No")
      echo "Exiting ..."
      exit 0
      ;;
    *)
      echo -n "Yes or no? "
      copy_files
      ;;
  esac

  echo "Done. Enjoy!"
  exit 0
}

# Copy files from here to the ~/ directory
install()
{
  echo -n "You are about to overwrite your current configuration files, are you sure? (Y/n) "
  copy_files
}

# Copy files in the repository, then commit them.
update()
{
  diff=""

  for arg in "$tracked"; do
    if [ $(diff "~/.$arg" "$arg" > /dev/null) -ne 0 ]; then
      echo "Copying ~/.$arg to $arg ..."
      cp "~/.$arg" "$arg"

      git add "$arg"
      diff="$diff $arg"
    fi
  done

  echo "Files changed:"
  for arg in $diff; do
    echo \t"$arg"
  done
  echo "Commiting ..."
  git commit -m "$USER: updated files $diff"
  echo "You push this mess."
  exit 0
}

# "try ..." text
try_help()
{
  echo "Try '$script --help'. Get some help goddammit"
  exit 1
}

# Missing operand
missing()
{
  echo "Missing operand"
  try_help
}

# Unrecognised option
unrecognized()
{
  echo "Unrecognized option $1"
  try_help
}

#
# Program entry point
#
if [ "$#" -eq 0 ]; then
  missing
fi

for arg in "$@"; do
  case "$arg" in
    "-h"|"--help")    help              ;;
    "-v"|"--version") version           ;;
    "install")        install           ;;
    "update")         update            ;;
    *)                unrecognized "$1" ;;
  esac
done
