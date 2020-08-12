#!/bin/bash

set -e -x

pkill worldserver || true
pkill authserver || true

cd build

cmake ../ \
	-DCMAKE_BUILD_TYPE=Debug \
	-DCMAKE_INSTALL_PREFIX=/home/$USER/wow_server \
	-DCONF_DIR=/home/$USER/wow_server \
	-DTOOLS=1 \
	/

make -j $(nproc) install