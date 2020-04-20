#!/bin/bash

#def settings
export HOME_VENV=/home/geoffroy/Documents/1_projets_persos/18_easy_scheduler/easy_scheduler/config/venv/
export SCRIPT_PATH=$HOME_ES/config/scripts/

#activate virtual environment
source $HOME_VENV"bin/activate"

# launch python script
python $SCRIPT_PATH"upcoming.py"
echo
