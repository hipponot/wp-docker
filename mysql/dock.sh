#!/bin/sh

docker run --detach \
     --name=web-content-mysql \
     --env="MYSQL_ROOT_PASSWORD=`cat /root/.digitalocean_password | grep root_mysql | cut -f2 -d\\\"`" \
     mysql:5.7
