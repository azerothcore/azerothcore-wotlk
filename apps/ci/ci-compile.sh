#!/bin/bash

set -e

echo "compile core"
export CCACHE_CPP2=true
export CCACHE_MAXSIZE='500MB'
ccache -s
./acore.sh "compiler" "all"
ccache -s
