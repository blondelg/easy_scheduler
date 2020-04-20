#!/bin/bash

# Detailled list
for filepath in $HOME_ES/timers/*.timer;
do
  filename=$(basename $filepath)
  TIMERS=$TIMERS$filename"|"
  echo
  eval systemctl status $filename | GREP_COLOR='01;92' egrep --color=always "active \(waiting\)|" | GREP_COLOR='01;92' egrep --color=always "active \(running\)|" | GREP_COLOR='01;31' egrep --color=always "inactive \(dead\)|" | GREP_COLOR='01;33' egrep --color=always "● "$filename" |"
  echo
  eval systemctl status ${filename/.timer/.service} | GREP_COLOR='01;92' egrep --color=always "active \(waiting\) |"| GREP_COLOR='01;92' egrep --color=always "active \(running\)|"  | GREP_COLOR='01;31' egrep --color=always "inactive \(dead\)|" | GREP_COLOR='01;33' egrep --color=always "● "${filename/.timer/.service}" |"
  echo
done


TIMERS=" '"$TIMERS"'"

# display scheduled
echo ● Upcomming jobs: | GREP_COLOR='01;33' egrep --color=always "● Upcomming jobs:|"
echo "NEXT                          LEFT          LAST                          PASSED       UNIT                         ACTIVATES"
for filepath in $HOME_ES/timers/*.timer;
do
  filename=$(basename $filepath)
  systemctl list-timers --all |grep $filename | GREP_COLOR='01;31' egrep --color=always $filename
done
