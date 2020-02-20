#!/bin/bash

chmod +x *.sh *.py
cp ddir.sh /usr/local/bin/ddir
rsync -urv --progress --delete *.sh *.py /usr/local/bin/
