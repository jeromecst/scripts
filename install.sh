#!/bin/bash

rsync -urv --progress * /usr/local/bin/
rm /usr/local/bin/install.sh
chown $USER /usr/local/bin 
chmod 755 /usr/local/bin
