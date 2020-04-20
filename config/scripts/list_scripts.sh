#!/bin/bash

#def settings
export HOME_SCRIPTS=$HOME_ES/scripts/

# activate them
echo
echo Scripts to be triggered | GREP_COLOR='01;35' egrep --color=always "Scripts to be triggered"
echo
echo Copy-paste the name of the script into the command prompt
echo "and press <ENTER> to trigger it"
echo
for filepathname in $HOME_SCRIPTS*.sh;
do
  filename=$(basename "$filepathname")
  echo $filename  | GREP_COLOR='01;36' egrep --color=always $filename"|"
done
echo
