#!/bin/sh

# docker network create --driver bridge dock_net

docker run -p 81:80 -p 443:443 \
    --name nginx \
    --network=dock_net \
    -v /root/var/www:/var/www \
    -v /root/wp-docker/nginx/wp-docker-nginx-conf.d:/etc/nginx/conf.d \
    -v /root/ssl:/etc/ssl:ro \
    -d nginx

