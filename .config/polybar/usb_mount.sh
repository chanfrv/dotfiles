#!/bin/sh

# output:
# media1 (size), ...

sym=""

for f in `ls /media`; do
  # gets 'f' size
  size=`df --output=size -h /media/$f | tail -1`
  size="${size:1}B"

  # add the media in the list
  res="$res$sym $f ($size)  "
done

echo "$res"
