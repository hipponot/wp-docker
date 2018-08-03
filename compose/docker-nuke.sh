
docker kill $(docker ps -q) # kill any running containers
docker rm $(docker ps -a -q) # remove all containers
docker volume remove $(docker volume ls -q) # remove all volumes

