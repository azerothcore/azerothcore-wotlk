#!/bin/bash

set -e

if [ "$TRAVIS_BUILD_ID" = "1" ]
then
  echo "import DB"
  bash ./acore.sh "db-assembler" "import-all"
  
  if [ -s modules/mod-premium/sql/example_item_9017.sql ]
  then
    # if the premium module is available insert the example item or else the worldserver dry run will fail
    mysql -u root world_$DB_RND_NAME <modules/mod-premium/sql/example_item_9017.sql
  fi
fi
