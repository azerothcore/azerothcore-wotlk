# absolute root path of your azerothcore repository
# It should not be modified if you don't really know what you're doing
SRCPATH="$AC_PATH_ROOT"

# absolute path where build files must be stored
BUILDPATH="$AC_PATH_ROOT/var/build/obj"

# absolute path where azerothcore will be installed
# NOTE: on linux the binaries are stored in a subfolder (/bin)
# of the $BINPATH
BINPATH="$AC_PATH_ROOT/env/dist"

# bash fills it by default with your os type. No need to change it.
# Change it if you really know what you're doing.
# OSTYPE=""

# When using linux, our installer automatically get information about your distro
# using lsb_release. If your distro is not supported but it's based on ubuntu or debian,
# please change it to one of these values.
# OSDISTRO="ubuntu"

# absolute path where config. files must be stored
# default: the system will use binpath by default
# CONFDIR="$AC_PATH_ROOT/env/dist/etc/"

# absolute path where maps and client data will be downloaded
# by the AC dashboard
# default: the system will use binpath by default
# DATAPATH="$BINPATH/bin"

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
# specify compilation type:
# * Release: high optimization level, no debug info, code or asserts.
# * Debug: No optimization, asserts enabled, [custom debug (output) code enabled],
#    debug info included in executable (so you can step through the code with a
#    debugger and have address to source-file:line-number translation).
# * RelWithDebInfo: optimized, *with* debug info, but no debug (output) code or asserts.
# * MinSizeRel: same as Release but optimizing for size rather than speed.
CTYPE=${CTYPE:-Release}
# compile scripts
CSCRIPTS=${CSCRIPTS:-ON}
# compile unit tests
CBUILD_TESTING=OFF
# compile server
CSERVERS=ON
# compile tools
CTOOLS=OFF
# use precompiled headers ( fatest compilation but not optimized if you change headers often )
CSCRIPTPCH=ON
CCOREPCH=ON
# enable/disable extra logs
CEXTRA_LOGS=0

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

DBASM_WAIT_TIMEOUT=${DBASM_WAIT_TIMEOUT:-1}
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
