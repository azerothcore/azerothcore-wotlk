CUR_PATH="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

CTYPE=Debug

# first check if it's defined in env, otherwise use the default
CSCRIPTS=${ENABLE_SCRIPTS:-1}

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
