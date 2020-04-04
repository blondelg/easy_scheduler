#!/bin/bash

#def settings
export HOME_VENV=../venv/

#activate virtual environment
source $HOME_VENV"bin/activate"

# launch python script
python "upcoming.py"
echo
