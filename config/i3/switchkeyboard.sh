#!/bin/sh

if [ "$#" -ne 0 ]; then
  exit 1
fi

setxkbmap -query | grep us

if [ "$?" -eq 0 ]; then
  setxkbmap fr
else
  setxkbmap us
fi
