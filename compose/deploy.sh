#!/bin/sh

SCRIPT_DIR="$( cd "$( dirname "$0" )" >/dev/null && pwd )"

echo "${SCRIPT_DIR}"

REPO=${SCRIPT_DIR}
DEPLOY="${HOME}/wm"  # Note: The folder name 'wm' becomes prefix for the docker containers

mkdir -p ${DEPLOY}/conf/nginx/
mkdir -p ${DEPLOY}/conf/mysql/

cp ${REPO}/docker-compose.yml ${DEPLOY}/

cp ${REPO}/nginx/nginx.conf ${DEPLOY}/conf/nginx/
cp ${REPO}/mysql/my.cnf ${DEPLOY}/conf/mysql/

pwdf="/root/.digitalocean_password"
if [ -e  "${pwdf}" ];
then
    . "${pwdf}"       # will define root_mysql 
    export root_mysql # used in docker-compose.yml
else
    echo "$0: File not found: ${pwdf}"
    exit 1
fi


(cd ${DEPLOY} ; docker-compose up -d --force-recreate )

export root_mysql=""
