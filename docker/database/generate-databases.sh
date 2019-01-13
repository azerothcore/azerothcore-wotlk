# TODO: remove this line after we fully support mysql 5.7
mysql -u root -p$MYSQL_ROOT_PASSWORD -e "SET GLOBAL sql_mode = '';"


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
mysql -u root -p$MYSQL_ROOT_PASSWORD acore_auth < /sql/auth_update.sql

echo "Importing characters updates..."
mysql -u root -p$MYSQL_ROOT_PASSWORD acore_characters < /sql/characters_update.sql

echo "Importing world updates..."
mysql -u root -p$MYSQL_ROOT_PASSWORD acore_world < /sql/world_update.sql


echo "Importing auth custom (if any)..."
mysql -u root -p$MYSQL_ROOT_PASSWORD acore_auth < /sql/auth_custom.sql

echo "Importing characters custom (if any)..."
mysql -u root -p$MYSQL_ROOT_PASSWORD acore_characters < /sql/characters_custom.sql

echo "Importing world custom (if any)..."
mysql -u root -p$MYSQL_ROOT_PASSWORD acore_world < /sql/world_custom.sql


echo "Done!"
