#!/bin/sh

# docker network create --driver bridge dock_net

docker run --detach \
    --name nginx-frontend \
    --network=dock_net \
    -v /root/var-nginx-www:/var/www \
    -v /root/wp-docker/nginx/etc:/etc/nginx/ \
    -v /root/ssl:/etc/ssl:ro \
    -p 81:80 -p 443:443 \
    nginx


    # -v /root/var/www:/var/www \
