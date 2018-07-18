#!/bin/sh

# docker network create --driver bridge dock_net

docker run -p 81:80 -p 443:443 \
    --name nginx \
    --network=bridge \
    -v /root/var/www:/var/www \
    -v /root/nginx/wp-docker-nginx-conf.d:/etc/nginx/conf.d \
    -v /root/ssl:/etc/ssl:ro \
    -d nginx

# docker network connect bridge nginx
# docker network connect bridge woot-math-wordpress
