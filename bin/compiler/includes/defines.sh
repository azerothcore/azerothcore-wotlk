#!/bin/bash

# you can choose build type from cmd argument
if [ ! -z $1 ]
then
    CCTYPE=$1
    CCTYPE=${CCTYPE^} # capitalize first letter if it's not yet
fi

BUILDPATH=$BINPATH

INSTALL_PATH=$(readlink -f "$BINPATH/../")

[ $CCTYPE == "Debug" ] && BUILDPATH="$BUILDPATH/debug/build/" ||  BUILDPATH="$BUILDPATH/release/build/"

[ $CCTYPE == "Debug" ] && BINPATH="$BINPATH/debug" || BINPATH="$BINPATH/release"
