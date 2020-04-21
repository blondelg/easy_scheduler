# easy_scheduler
Script scheduler and monitoring on Linux Ubuntu server
Here is a set of scripts and commands that make script
scheduling and monitoring easier on Linux Ubuntu.

## Python Virtual Environment
A virtual environment is used  to run a particular script,
it could be also useful to implement python scripts.
To install it:
```console
python3 -m venv config/venv
source config/venv/bin/activate
pip install -r config/requirements.txt
```

## Update .bashrc to run commands
add the folling line at the end of the .bashrc file
```console
export PATH=$PATH:<PATH_TO>/easy_scheduler/config/scripts
export HOME_ES=<PATH_TO>/easy_scheduler
```

make new variables effectives
```console
source ~/.bashrc
```

## Setup first script
put the script example.sh to be automated here:
/scripts

update the corresponding timer and services files,
see:
/timers/example.timer
/timers/example.service

run the following command to implement the scheduling configuration:
```console
update_timers.sh
```

to get help on other commands, just type ? in the command prompt.
