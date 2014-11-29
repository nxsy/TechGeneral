#!/bin/sh

set -e
set -u
set -x

CONTENTDIR=$1
LASTHASH=""

git clone https://github.com/nxsy/TechGeneral.git /app
cd /app

while :; do
    THISHASH=`git show --pretty=oneline -s | awk '{print $1}'`

    if [ "${LASTHASH}" != "${THISHASH}" ]; then
        bash init.sh
        ./gibe2 --freeze .

        cp -a build/ /build-${THISHASH}
        ln -sf /build-${THISHASH} ${CONTENTDIR}
    fi

    sleep 60
    git fetch && git checkout origin/master
done
