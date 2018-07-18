#!/bin/sh

docker run --detach \
     --name woot-math-wordpress \
     --link web-content-mysql:mysql \
     -p 80:80 \
     wordpress
