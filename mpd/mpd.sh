#!/bin/sh
echo 'OK MPD 0.19'
while read line;do
  echo 'got: ' "$line" >&2
  if [ "$line" = "command_list_ok_begin" ];then
    > ./cache/command_list_output
    continue
  elif [ "$line" = "command_list_end" ];then
    cat ./cache/command_list_output
    rm ./cache/command_list_output
    echo list_OK
    continue
  fi
  if [ -f ./cache/command_list_output ];then
    ./$line >> ./cache/command_list_output
    echo list_OK >> ./cache/command_list_output
  else
    ./$line
    echo OK
  fi
done
#tail -f >&2
