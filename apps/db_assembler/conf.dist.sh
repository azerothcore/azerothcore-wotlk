##############################################
#
#  DB ASSEMBLER / EXPORTER CONFIGURATIONS
#
##############################################

#
# Comma separated list of databases
#
# You can add another element here if you need
# to support multiple databases
#

DBLIST=${DBLIST:-"AUTH,CHARACTERS,WORLD"}
# convert from comma separated list to an array.
# This is needed to support environment variables
readarray -td, DATABASES <<<"$DBLIST";

OUTPUT_FOLDER=${OUTPUT_FOLDER:-"$AC_PATH_ROOT/env/dist/sql/"}

DBASM_WAIT_TIMEOUT=${DBASM_WAIT_TIMEOUT:-5}
DBASM_WAIT_RETRIES=${DBASM_WAIT_RETRIES:-3}

####### BACKUP
# Set to true if you want to backup your azerothcore databases before importing the SQL with the db_assembler
# Do not forget to stop your database software (mysql) before doing so

BACKUP_ENABLE=false

BACKUP_FOLDER="$AC_PATH_ROOT/env/dist/sql/backup/"

#######

# FULL DB
DB_AUTH_PATHS=(
    "$SRCPATH/data/sql/base/db_auth/"
)

DB_CHARACTERS_PATHS=(
    "$SRCPATH/data/sql/base/db_characters"
)

DB_WORLD_PATHS=(
    "$SRCPATH/data/sql/base/db_world/"
)

# UPDATES
DB_AUTH_UPDATES_PATHS=(
    "$SRCPATH/data/sql/updates/db_auth/"
    "$SRCPATH/data/sql/updates/pending_db_auth/"
)

DB_CHARACTERS_UPDATES_PATHS=(
    "$SRCPATH/data/sql/updates/db_characters/"
    "$SRCPATH/data/sql/updates/pending_db_characters/"
)

DB_WORLD_UPDATES_PATHS=(
    "$SRCPATH/data/sql/updates/db_world/"
    "$SRCPATH/data/sql/updates/pending_db_world/"
)

# CUSTOM
DB_AUTH_CUSTOM_PATHS=(
    "$SRCPATH/data/sql/custom/db_auth/"
)

DB_CHARACTERS_CUSTOM_PATHS=(
    "$SRCPATH/data/sql/custom/db_characters/"
)

DB_WORLD_CUSTOM_PATHS=(
    "$SRCPATH/data/sql/custom/db_world/"
)

##############################################
#
#  DB EXPORTER/IMPORTER CONFIGURATIONS
#
##############################################

#
# Skip import of base sql files to avoid
# table dropping
#
DB_SKIP_BASE_IMPORT_IF_EXISTS=true

#
# Example:
#        "C:/Program Files/MySQL/MySQL Server 8.0/bin/mysql.exe"
#        "/usr/bin/mysql"
#        "mysql"
#

DB_MYSQL_EXEC="mysql"
DB_MYSQL_DUMP_EXEC="mysqldump"


DB_AUTH_CONF=${DB_AUTH_CONF:-"MYSQL_USER='acore'; \
                    MYSQL_PASS='acore'; \
                    MYSQL_HOST='localhost';\
                    MYSQL_PORT='3306';\
                    "}

DB_CHARACTERS_CONF=${DB_CHARACTERS_CONF:-"MYSQL_USER='acore'; \
                    MYSQL_PASS='acore'; \
                    MYSQL_HOST='localhost';\
                    MYSQL_PORT='3306';\
                    "}

DB_WORLD_CONF=${DB_WORLD_CONF:-"MYSQL_USER='acore'; \
                    MYSQL_PASS='acore'; \
                    MYSQL_HOST='localhost';\
                    MYSQL_PORT='3306';\
                    "}

DB_AUTH_NAME="acore_auth"

DB_CHARACTERS_NAME="acore_characters"

DB_WORLD_NAME="acore_world"
