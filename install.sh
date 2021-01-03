#!/bin/bash

sudo rsync -urv --progress * /usr/local/bin/
sudo rm /usr/local/bin/install.sh
sudo chown -R $USER /usr/local/bin 
chmod 755 -R /usr/local/bin
