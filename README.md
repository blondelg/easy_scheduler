# easy_scheduler
Script scheduler and monitoring on Linux Ubuntu server

# Python Virtual Environment
A virtual environment is used  to run a particular script,
it could be also useful to implement python scripts.
To install it:
```console
python3 -m venv config/venv
source config/venv/bin/activate
pip install -r config/requirements.txt
```

# Update .bashrc to run commands
add the folling line at the end of the .bashrc file
```console
export PATH=$PATH:<PATH_TO>/easy_scheduler/config/scripts
```
