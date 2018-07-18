#!/bin/sh

docker network create --driver bridge dock_net

docker network connect dock_net nginx-frontent
docker network connect dock_net woot-math-wordpress
docker network connect dock_net web-content-nginx
