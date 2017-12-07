#!/bin/sh

sym=""
dir="/media"

if [ $# -ne 0 ]; then
  dir="${1%/}"
fi

for f in `ls $dir`; do
  size=`df --output=avail -h $dir/$f | tail -1`
  size="${size:1}B"

  res="$res$sym $f ($size)  "
done

echo "${res%*  }"
