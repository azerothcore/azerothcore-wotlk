#!/bin/bash

set -e

if [ "$TRAVIS_BUILD_ID" = "1" ]
then
  echo "import DB"
  bash ./acore.sh "db-assembler" "import-all"
fi
