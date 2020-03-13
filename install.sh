#!/bin/bash

set -e -x

cd build

pkill worldserver
pkill authserver

cmake ../ \
	-DCMAKE_INSTALL_PREFIX=/home/$USER/wow_server2 \
	-DCONF_DIR=/home/$USER/wow_server2 \
	/

make -j $(nproc) install
