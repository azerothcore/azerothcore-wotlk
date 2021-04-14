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


echo "Creating Realm One DBs..."
mysql -u root -p$MYSQL_ROOT_PASSWORD -e "CREATE DATABASE acore_realm_one_characters"
mysql -u root -p$MYSQL_ROOT_PASSWORD -e "CREATE DATABASE acore_realm_one_world"


echo "Importing Realm One characters base..."
mysql -u root -p$MYSQL_ROOT_PASSWORD acore_realm_one_characters < /sql/characters_base.sql

echo "Importing Realm One world base..."
mysql -u root -p$MYSQL_ROOT_PASSWORD acore_realm_one_world < /sql/world_base.sql


echo "Importing Realm One characters updates..."
mysql -u root -p$MYSQL_ROOT_PASSWORD acore_realm_one_characters < /sql/characters_updates.sql

echo "Importing Realm One world updates..."
mysql -u root -p$MYSQL_ROOT_PASSWORD acore_realm_one_world < /sql/world_updates.sql


echo "Importing Realm One characters custom (if any)..."
mysql -u root -p$MYSQL_ROOT_PASSWORD acore_realm_one_characters < /sql/characters_custom.sql

echo "Importing Realm One world custom (if any)..."
mysql -u root -p$MYSQL_ROOT_PASSWORD acore_realm_one_world < /sql/world_custom.sql

echo "Importing Realm One entry into realmlist..."
mysql -u root -p$MYSQL_ROOT_PASSWORD -e 'INSERT IGNORE INTO acore_auth.realmlist (id, name, address, localAddress, localSubnetMask, port, icon, flag, timezone, allowedSecurityLevel, population, gamebuild) VALUES (2, "Realm One", "127.0.0.1", "127.0.0.1", "255.255.255.0", 8086, 1, 0, 1, 0, 0, 12340)'


# echo "Creating Realm Two DBs..."
# mysql -u root -p$MYSQL_ROOT_PASSWORD -e "CREATE DATABASE acore_realm_two_characters"
# mysql -u root -p$MYSQL_ROOT_PASSWORD -e "CREATE DATABASE acore_realm_two_world"


# echo "Importing Realm Two characters base..."
# mysql -u root -p$MYSQL_ROOT_PASSWORD acore_realm_two_characters < /sql/characters_base.sql

# echo "Importing Realm Two world base..."
# mysql -u root -p$MYSQL_ROOT_PASSWORD acore_realm_two_world < /sql/world_base.sql


# echo "Importing Realm Two characters updates..."
# mysql -u root -p$MYSQL_ROOT_PASSWORD acore_realm_two_characters < /sql/characters_updates.sql

# echo "Importing Realm Two world updates..."
# mysql -u root -p$MYSQL_ROOT_PASSWORD acore_realm_two_world < /sql/world_updates.sql


# echo "Importing Realm Two characters custom (if any)..."
# mysql -u root -p$MYSQL_ROOT_PASSWORD acore_realm_two_characters < /sql/characters_custom.sql

# echo "Importing Realm Two world custom (if any)..."
# mysql -u root -p$MYSQL_ROOT_PASSWORD acore_realm_two_world < /sql/world_custom.sql

# echo "Importing Realm Two entry into realmlist..."
# mysql -u root -p$MYSQL_ROOT_PASSWORD -e 'INSERT IGNORE INTO acore_auth.realmlist (id, name, address, localAddress, localSubnetMask, port, icon, flag, timezone, allowedSecurityLevel, population, gamebuild) VALUES (3, "Realm Two", "127.0.0.1", "127.0.0.1", "255.255.255.0", 8087, 6, 0, 1, 0, 0, 12340)'


echo "Done!"
