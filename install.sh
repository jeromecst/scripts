#!/bin/bash

chown $USER /usr/local/bin 
chmod 755 *
rsync -urv --progress * /usr/local/bin/
rm /usr/local/bin/install.sh
