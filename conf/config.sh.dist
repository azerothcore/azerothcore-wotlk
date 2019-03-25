# absolute root path of your azerothcore repository
# It should not be modified if you don't really know what you're doing
SRCPATH="$AC_PATH_ROOT"

# absolute path where build files must be stored
BUILDPATH="$AC_PATH_ROOT/var/build/obj"

# absolute path where binary files must be stored
BINPATH="$AC_PATH_ROOT/env/dist"

# absolute path where config. files must be stored
# default: the system will use binpath by default
# CONFDIR="$AC_PATH_ROOT/env/dist/etc/"

##############################################
#
#  COMPILER_CONFIGURATIONS
#
##############################################


# Set preferred compilers.
# To use gcc (not suggested) instead of clang change in:
#  CCOMPILERC="/usr/bin/gcc"
#  CCOMPILERCXX="/usr/bin/g++"
#
CCOMPILERC="/usr/bin/clang"
CCOMPILERCXX="/usr/bin/clang++"


# how many thread must be used for compilation ( leave zero to use all available )
MTHREADS=0
# enable/disable warnings during compilation
CWARNINGS=ON
# enable/disable some debug informations ( it's not a debug compilation )
CDEBUG=OFF
# specify compilation type
CTYPE=Release
# compile scripts
CSCRIPTS=ON
# compile server
CSERVERS=ON
# compile tools
CTOOLS=OFF
# use precompiled headers ( fatest compilation but not optimized if you change headers often )
CSCRIPTPCH=ON
CCOREPCH=ON

# Skip specific modules from compilation (cmake reconfigure needed)
# use semicolon ; to separate modules
CDISABLED_AC_MODULES=""

# you can add your custom definitions here ( -D )
# example:  CCUSTOMOPTIONS=" -DWITH_PERFTOOLS=ON -DENABLE_EXTRA_LOGS=ON"
#
CCUSTOMOPTIONS=""


##############################################
#
#  DB ASSEMBLER / EXPORTER CONFIGURATIONS
#
##############################################

#
# Basically you don't have to edit it
# but if you have another database you can add it here
# and create relative confiugurations below
#
DATABASES=(
	"AUTH"
	"CHARACTERS"
	"WORLD"
)

OUTPUT_FOLDER="$AC_PATH_ROOT/env/dist/sql/"

####### BACKUP
# Set to true if you want to backup your azerothcore databases before importing the SQL with the db_assembler
# Do not forget to stop your database software (mysql) before doing so

BACKUP_ENABLE=false

BACKUP_FOLDER="$AC_PATH_ROOT/env/dist/sql/backup/"

#######

# FULL DB
DB_AUTH_PATHS=(
    $SRCPATH"/data/sql/base/db_auth/"
)

DB_CHARACTERS_PATHS=(
    $SRCPATH"/data/sql/base/db_characters"
)

DB_WORLD_PATHS=(
    $SRCPATH"/data/sql/base/db_world/"
)

# UPDATES
DB_AUTH_UPDATES_PATHS=(
    $SRCPATH"/data/sql/updates/db_auth/"
    $SRCPATH"/data/sql/updates/pending_db_auth/"
)

DB_CHARACTERS_UPDATES_PATHS=(
    $SRCPATH"/data/sql/updates/db_characters/"
    $SRCPATH"/data/sql/updates/pending_db_characters/"
)

DB_WORLD_UPDATES_PATHS=(
    $SRCPATH"/data/sql/updates/db_world/"
    $SRCPATH"/data/sql/updates/pending_db_world/"
)

# CUSTOM
DB_AUTH_CUSTOM_PATHS=(
    $SRCPATH"/data/sql/custom/db_auth/"
)

DB_CHARACTERS_CUSTOM_PATHS=(
    $SRCPATH"/data/sql/custom/db_characters/"
)

DB_WORLD_CUSTOM_PATHS=(
    $SRCPATH"/data/sql/custom/db_world/"
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
#        "C:/Program Files/MySQL/MySQL Server 5.6/bin/mysql.exe"
#        "/usr/bin/mysql"
#        "mysql"
#

DB_MYSQL_EXEC="mysql"
DB_MYSQL_DUMP_EXEC="mysqldump"


DB_AUTH_CONF="MYSQL_USER='acore'; \
                    MYSQL_PASS='acore'; \
                    MYSQL_HOST='127.0.0.1';\
                    "

DB_CHARACTERS_CONF="MYSQL_USER='acore'; \
                    MYSQL_PASS='acore'; \
                    MYSQL_HOST='127.0.0.1';\
                    "

DB_WORLD_CONF="MYSQL_USER='acore'; \
                    MYSQL_PASS='acore'; \
                    MYSQL_HOST='127.0.0.1';\
                    "

DB_AUTH_NAME="acore_auth"

DB_CHARACTERS_NAME="acore_characters"

DB_WORLD_NAME="acore_world"
