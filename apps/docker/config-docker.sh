CUR_PATH="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

DATAPATH="$BINPATH/data"

DB_AUTH_CONF="MYSQL_USER='root'; \
                    MYSQL_PASS='password'; \
                    MYSQL_HOST='ac-database';\
                    MYSQL_PORT='3306';\
                    "

DB_CHARACTERS_CONF="MYSQL_USER='root'; \
                    MYSQL_PASS='password'; \
                    MYSQL_HOST='ac-database';\
                    MYSQL_PORT='3306';\
                    "

DB_WORLD_CONF="MYSQL_USER='root'; \
                    MYSQL_PASS='password'; \
                    MYSQL_HOST='ac-database';\
                    MYSQL_PORT='3306';\
                    "

# allow the user to override configs
if [ -f  "$AC_PATH_CONF/config.sh" ]; then
    source "$AC_PATH_CONF/config.sh" # should overwrite previous
fi
