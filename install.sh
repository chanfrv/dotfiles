#!/bin/sh

#
# Usage
#
if [ $# -ne 0 ]; then
  echo "Usage: ./install.sh"
  exit 1
fi

#
# Tracked dotfiles
#
DOTS="config/i3 config/polybar bashrc vimrc Xresources"

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
    echo "Your files have been updated."
    echo "The default commit is \`dotfiles: update'"
    echo "Enter the commit or press enter to keep the default one."
    read line
    commit="dotfiles: update"
    if [ ! -z $line ]; then
      commit=$line
    fi
    git commit -m "$commit"

    exit 0
  fi

  echo "Nothing to commit, exiting."
  exit 0
}

add_files()
{
  echo "Enter the files separated with a space."

  echo -n "> "
  read line
  echo

  DOTS="$DOTS $line"

  main
}

coward()
{
  echo "Coward."
  exit 2
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
  echo -e "=== You are on install.sh script. ===\n"
  echo "Here are the tracked dotfiles:"
  for f in $DOTS; do
    echo $f
  done

  echo -e "\nTo definitively add tracked file, please add then in 'DOTS'"
  echo -e "directly by editing this script.\n"
  echo    "To copy your tracked file, press 1."
  echo    "To temporary add tracked files, press 2."
  echo -e "To abort the copy, press 3.\n"
  echo    "Congratulations, your are the 1000th to open this script!"
  echo -e "Enter # followed by your birth date to win a brand new iPhone.\n"

  echo -n "> "
  read line
  echo
  if [ "$line" == "1" ]; then
    copy
  elif [ "$line" == "2" ]; then
    add_files
  elif [ "$line" == "3" ]; then
    coward
  elif [ "${line:0:1}" == "#" ]; then
    you_have_been_bamboozled
  else
    exit 1
  fi
}

main
