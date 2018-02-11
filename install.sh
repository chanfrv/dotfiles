#!/bin/sh

if [ $# -ne 0 ]; then
  echo "Usage: ./install.sh"
  exit 1
fi

DOTS="config/i3 config/polybar bashrc vimrc Xresources"

#
# Money
#
echo -e "You are on install.sh script.\n"
echo "Here are the tracked dotfiles:"
for f in $DOTS; do
  echo $f
done
echo -e "\nTo copy your tracked file, press 1."
echo -e "To abort the copy, press 2."
echo -e "\nCongratulations, your are the 1000th to open this script!"
echo -e "Enter # followed by your birth date to win a brand new iPhone.\n"

echo -n "> "
while read -r line; do
  if [ "$line" == "1" ]; then
    break
  elif [ "$line" == "2" ]; then
    echo "Coward."
    exit 2
  elif [ "${line:0:1}" == "#" ]; then
    echo "Congratulations, you have been selected!"
    echo "Send a mail containing your credit card codes to no-bamboozle@install.sh."
    echo "Thank you for your contribution!"
    exit 0
  else
    exit 1
  fi
done<&0

#
# Actual script
#
for file in $DOTS; do
  opath="$HOME/.$file"
  dpath="$file"

  if [ -d "$opath" ]; then
    dpath="${dpath%%/*}/"
  fi

  echo "Copy of $opath to $dpath..."
  cp -r "$opath" "$dpath"
done
