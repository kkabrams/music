#!/bin/bash
while true;do
  dd count="$1" bs=1 2>/dev/null
  NP="$(music-nowplaying 2>/dev/null)" # | cut -b1-255 | pad 255 2>/dev/null)"
  LEN=$(printf "%s" "${NP}" | wc -c | tr -cd '0-9')
  CHUNKS=$[$LEN / 16 + 2]
  HEXLEN=$(printf "%02x\n" $CHUNKS)
  PADDING=$[16 * $CHUNKS]
  printf "\x${HEXLEN}StreamTitle='%s';\n" "${NP}" | pad $PADDING _
done
