CUR_PATH="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

source "$CUR_PATH/config-default.sh" # binded by docker-compose

CTYPE=Debug

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