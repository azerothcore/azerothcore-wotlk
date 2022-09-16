#!/bin/bash

set -e

sudo systemctl start mysql
./acore.sh "db-assembler" "import-all"
  
if [ -s modules/mod-premium/sql/example_item_9017.sql ]
then
  echo "Import custom module item..."
  # if the premium module is available insert the example item or else the worldserver dry run will fail
  mysql -uroot -proot acore_world < modules/mod-premium/sql/example_item_9017.sql
  echo "Done!"
fi
