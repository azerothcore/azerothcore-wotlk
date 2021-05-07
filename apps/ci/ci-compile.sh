#!/bin/bash

set -e

echo "compile core"
export AC_CCACHE=true
./acore.sh "compiler" "all"

