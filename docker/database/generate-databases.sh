# TODO: remove this line after we squash our DB updates
mysql -u root -p$MYSQL_ROOT_PASSWORD -e "SET GLOBAL max_allowed_packet=128*1024*1024;"

echo "Creating DBs..."
mysql -u root -p$MYSQL_ROOT_PASSWORD -e "CREATE DATABASE acore_auth"
mysql -u root -p$MYSQL_ROOT_PASSWORD -e "CREATE DATABASE acore_characters"
mysql -u root -p$MYSQL_ROOT_PASSWORD -e "CREATE DATABASE acore_world"


echo "Importing auth base..."
mysql -u root -p$MYSQL_ROOT_PASSWORD acore_auth < /sql/auth_base.sql

echo "Importing characters base..."
mysql -u root -p$MYSQL_ROOT_PASSWORD acore_characters < /sql/characters_base.sql

echo "Importing world base..."
mysql -u root -p$MYSQL_ROOT_PASSWORD acore_world < /sql/world_base.sql


echo "Importing auth updates..."
mysql -u root -p$MYSQL_ROOT_PASSWORD acore_auth < /sql/auth_updates.sql

echo "Importing characters updates..."
mysql -u root -p$MYSQL_ROOT_PASSWORD acore_characters < /sql/characters_updates.sql

echo "Importing world updates..."
mysql -u root -p$MYSQL_ROOT_PASSWORD acore_world < /sql/world_updates.sql


echo "Importing auth custom (if any)..."
mysql -u root -p$MYSQL_ROOT_PASSWORD acore_auth < /sql/auth_custom.sql

echo "Importing characters custom (if any)..."
mysql -u root -p$MYSQL_ROOT_PASSWORD acore_characters < /sql/characters_custom.sql

echo "Importing world custom (if any)..."
mysql -u root -p$MYSQL_ROOT_PASSWORD acore_world < /sql/world_custom.sql


echo "Done!"
