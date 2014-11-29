#!/bin/bash

set -e
set -u
set -x

CONTENTDIR=$1
if [ -d ${CONTENTDIR} ]; then
    rm -rf ${CONTENTDIR}
fi
mkdir -p `dirname ${CONTENTDIR}`

cd /src
rm -rf .env
bash scripts/clean.sh
bash init.sh
./gibe2 --freeze .

THISHASH=hash-$RANDOM
cp -a build/ /build-${THISHASH}
ln -sf /build-${THISHASH} ${CONTENTDIR}

cp scripts/elastic-beanstalk/nginx.techgeneral /etc/nginx/sites-enabled
rm -f /etc/nginx/sites-enabled/default

/etc/init.d/nginx start

while :; do
    sleep 60
done
