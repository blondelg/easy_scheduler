#!/bin/bash

# activate them
echo
for filepath in $HOME_ES/timers/*.timer;
do
  filename=$(basename $filepath)
  echo ● $filename  | GREP_COLOR='01;92' egrep --color=always "● "$filename"|"
  echo
  eval cat $filepath  | GREP_COLOR='01;33' egrep --color=always "OnCalendar|"
  echo
done
