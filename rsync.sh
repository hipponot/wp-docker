#!/bin/sh
rsync -rv -e ssh --delete --relative ./compose root@45.55.127.212:/root/

