#!/bin/bash

set -e
set -u

case $# in
0) pkg="-e git+https://github.com/nxsy/gibe2.git#egg=Gibe2" ;;
*) pkg="$1" ;;
esac


cd `dirname $0`
if [ ! -d .env ]; then
    python scripts/virtualenv.py --no-site-packages --distribute .env
fi
if [ ! -e activate ]; then
    ln -s .env/bin/activate activate
fi

# activate plays fast and loose with variables
set +u
source activate
set -u

pip install ${pkg}

if [ ! -e gibe2 ]; then
    ln -s .env/bin/gibe2 gibe2
fi
