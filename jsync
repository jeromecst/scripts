#!/bin/bash

rsync -arv --progress --delete -e ssh jserv@homelocal:/home/jserv/ /home/$USER/.jserv/ --files-from=/home/$USER/.config/jsync-rsync --exclude ".*/"
rsync -arv --progress --delete -e ssh jserv@home:/home/jserv/ /home/$USER/.jserv/ --files-from=/home/$USER/.config/jsync-rsync --exclude ".*/"
