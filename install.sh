#!/bin/bash

set -e -x

cd build


cmake ../ \
	-DCMAKE_INSTALL_PREFIX=/home/$USER/wow_server2 \
	-DCONF_DIR=/home/$USER/wow_server2 \
	/

make -j $(nproc) install
