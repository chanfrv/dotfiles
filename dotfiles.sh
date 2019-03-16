#!/bin/sh

script="$0"
tracked="bashrc $(echo config/i3/*) $(echo config/polybar/*) vimrc Xresources"

help()
{
  echo "Usage: $script [options] [command]"
  echo
  echo "Options:"
  echo "\t-h, --help      Show this help"
  echo
  echo "Commands:"
  echo "\tinstall         Install the configuration on your machine"
  echo "\tupdate          Update the repository dotfiles"
  echo
  exit 0
}

version()
{
  echo -n "$script version "
  git describe --tags
  exit 0
}

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

install()
{
  echo -n "You are about to overwrite your current configuration files, are you sure? (Y/n) "
  copy_files
}

update()
{
  diff=""

  for arg in "$tracked"; do
    if [ $(diff "~/.$arg" "$arg" > /dev/null) -ne 0 ]; then
      echo "Copying ~/.$arg to $arg ..."
      cp "~/.$arg" "$arg"

      git add "$arg"
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

unrecognized()
{
  echo "Unrecognized option $1, try: $script -h. Get some help goddammit"
  exit 1
}

if [ "$#" -eq 0 ]; then
  help
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
