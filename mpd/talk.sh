#!/bin/sh
while read line;do
  echo $line | festival --tts --batch
done
