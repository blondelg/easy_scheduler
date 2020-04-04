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
  # stop timer
  sudo systemctl stop $filename_timer
  # disable timer
  sudo systemctl disable $filename_timer
  echo $filename" stopped and disabled"
  # remove timer file
  sudo rm $filepath_timer
  # remove service file
  sudo rm $filepath_service
  echo $filepath_timer " and " $filepath_service " have been deleted from systemd folder"
done

# Copy new services
sudo cp $HOME_TIMER*.service /etc/systemd/system
# Copy new timers
sudo cp $HOME_TIMER*.timer /etc/systemd/system

# Reload files
sudo systemctl daemon-reload

# activate them
for filepathname in $HOME_TIMER*.timer;
do
  filename=$(basename "$filepathname")

  TIMERS=$TIMERS$filename"\|"
  # start timer
  sudo systemctl start $filename
  # enable new timer
  sudo systemctl enable $filename
  echo $filename" started and enabled"
   if [[ $filename == *"onedrive"* ]]; then
     sudo systemctl enable onedrive_sync.service &
     sudo systemctl start onedrive_sync.service &
   fi
done

# TIMERS=" '"$TIMERS"onedrive'"

# display scheduled
systemctl list-timers --all | egrep $TIMERS
