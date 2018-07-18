#!/bin/sh

docker run --detach \
     --name woot-math-wordpress \
     --network=dock_net \
     --env="WORDPRESS_DB_HOST=web-content-mysql:3306"
     -p 80:80 \
     wordpress
