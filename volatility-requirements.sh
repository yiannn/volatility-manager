#!/bin/bash

#ask user to be root
[ "$(whoami)" != "root" ] && exec sudo -- "$0" "$@"

wget https://bootstrap.pypa.io/pip/2.7/get-pip.py

sudo python2 get-pip.py
pip2 install --upgrade setuptools
sudo apt-get install python-dev -y

sudo apt-get --purge autoremove python3-pip -y
sudo apt install python3-pip -y
