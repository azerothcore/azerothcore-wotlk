#!/bin/bash

. "defines.sh"

echo "Cleaning build files"

CWD=$(pwd)

cd $BUILDPATH

make -f Makefile clean
make clean
find -iname '*cmake*' -not -name CMakeLists.txt -exec rm -rf {} \+

cd $CWD

