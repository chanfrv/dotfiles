#!/bin/sh

# name
#   usb.sh - prints the connected devices
#
# synopsis
#   ./usb.sh [directory]
#
# options
#   directory   where the devices are mounted, default is '/media'.
#               see https://wiki.archlinux.org/index.php/Udisks.

sym=""
dir="/media"

if [ $# -ne 0 ]; then
  dir="$1"
fi

for f in `ls $dir`; do
  # gets 'f' size
  size=`df --output=size -h $dir/$f | tail -1`
  size="${size:1}B"

  # add the media in the list
  res="$res$sym $f ($size)  "
done

echo "$res"
