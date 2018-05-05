#!/bin/sh

#
# Usage
#
if [ $# -ne 0 ]; then
  echo "Usage: $0"
  exit 1
fi

#
# Tracked dotfiles
#
DOTS="config/i3 config/polybar bashrc vimrc Xresources /usr/local/bin/git-stats"

#
# Actual script
#
copy()
{
  for file in $DOTS; do
    opath="$HOME/.$file"
    dpath="$file"

    if [ -d "$opath" ]; then
      dpath="${dpath%%/*}/"
    fi

    echo "Copy of $opath to $dpath..."
    cp -r "$opath" "$dpath"
  done

  git diff --exit-code
  if [ $? -ne 0 ]; then
    git add *
    commit="dotfiles: update"
    echo -e "Enter the commit or left empty to send \`$commit'.\n"
    echo -n "> "
    read line
    echo
    if [ ! -z "$line" ]; then
      commit=$line
    fi
    git commit -m "$commit"
    git push
    exit 0
  fi

  echo "Nothing to commit, exiting."
  exit 0
}

add_files()
{
  echo -e "Enter the files separated with a space.\n"
  echo -n "> "
  read line
  echo

  DOTS="$DOTS $line"

  main
}

coward()
{
  echo "Coward."
  exit 28
}

#
# Money
#
you_have_been_bamboozled()
{
  echo "Congratulations, you have been selected!"
  echo "Send a mail containing your credit card codes to no-bamboozle@install.sh."
  echo "Thank you for your contribution!"
  exit 0
}

main()
{
  echo -e "=== Welcome to install.sh script. This is not a scam. ===\n"

  echo "Here are the tracked dotfiles:"
  for f in $DOTS; do
    echo "- $f"
  done

  echo -e "\nTo definitively add tracked file, please add them in 'DOTS'"
  echo -e "directly by editing this script.\n"
  echo    "To copy your tracked file, press 1."
  echo    "To temporary add tracked files, press 2."
  echo -e "To abort the copy, press 3.\n"
  echo    "Congratulations, your are the 1000th to open this script!"
  echo -e "Enter # followed by your birth date to win a brand new iPhone.\n"

  echo -n "> "
  read line
  echo

  case $line in
  "1")
    copy
    ;;
  "2")
    add_files
    ;;
  "3")
    coward
    ;;
  "#"*)
    you_have_been_bamboozled
    ;;
  *)
    exit 1
    ;;
  esac
}

main
