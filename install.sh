#!/bin/bash

chmod +x *.sh *.py
cp ddir /usr/local/bin/
cp ddir2 /usr/local/bin/
rsync -urv --progress *.sh *.py /usr/local/bin/
rm /usr/local/bin/install.sh
