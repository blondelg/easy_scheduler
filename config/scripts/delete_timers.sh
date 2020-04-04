#!/bin/bash

#def settings
export HOME_TIMER=../../timers/
export HOME_SYSTEMD=/etc/systemd/system/

# desactivate existing timers, drop timers and services files from systemd directory
for filepath_timer in $HOME_SYSTEMD*.timer;
do
  filename_timer=$(basename "$filepath_timer")
  filepath_service="${filepath_timer/timer/service}"
  filename_service=$(basename "$filepath_service")
  echo $filepath_timer
  echo $filename_timer
  echo $filepath_service
  echo $filename_service
  sudo systemctl stop $filename_timer
  sudo systemctl disable $filename_timer
  echo $filename" stopped and disabled"
  sudo rm $filepath_timer
  sudo rm $filepath_service
  echo $filepath_timer " and " $filepath_service " have been deleted from systemd folder"
done
