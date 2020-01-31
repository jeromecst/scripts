#!/bin/bash

chmod +x *.sh *.py
rsync -urv --progress --delete *.sh *.py /usr/local/bin/
