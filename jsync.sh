#!/bin/bash

rsync -arv --progress --delete -e ssh jserv@homelocal:/home/jserv/ /home/jerome/.jserv/ --files-from=/home/jerome/.config/jsync-rsync --exclude ".*/"
rsync -arv --progress --delete -e ssh jserv@home:/home/jserv/ /home/jerome/.jserv/ --files-from=/home/jerome/.config/jsync-rsync --exclude ".*/"
