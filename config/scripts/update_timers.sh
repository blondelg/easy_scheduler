#!/bin/bash

#def settings
export HOME_TIMER=$HOME_ES/timers/
export HOME_SYSTEMD=/etc/systemd/system/

# desactivate existing timers, drop timers and services files from systemd directory
for filepath_timer in $HOME_TIMER*.timer;
do

  # set file names
  filename_timer=$(basename "$filepath_timer")
  filename_service="${filename_timer/timer/service}"

  # stop and disable timer
  sudo systemctl stop $filename_timer
  sudo systemctl disable $filename_timer
  echo $filename" stopped and disabled"

  # remove timer and service files from systemd directory
  sudo rm $HOME_SYSTEMD$filename_timer
  sudo rm $HOME_SYSTEMD$filename_service
  echo $filename_timer " and " $filename_service " have been deleted from " $HOME_SYSTEMD

done

# Copy new services and timers
sudo cp $HOME_TIMER*.service /etc/systemd/system
sudo cp $HOME_TIMER*.timer /etc/systemd/system

# Reload files
sudo systemctl daemon-reload

# activate them
for filepathname in $HOME_TIMER*.timer;
do
  filename=$(basename "$filepathname")

  TIMERS=$TIMERS$filename"\|"
  # start and enable timer
  sudo systemctl start $filename
  sudo systemctl enable $filename
  echo $filename" started and enabled"

done

TIMERS=" "$TIMERS

# display scheduled
systemctl list-timers --all | egrep $TIMERS
