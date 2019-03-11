#!/usr/bin/env bash

ROOTPATH="$( cd "$( dirname "${BASH_SOURCE[0]}" )/../../" && pwd )"

source $ROOTPATH"/apps/bash_shared/includes.sh"

if [ -f "./config.sh"  ]; then
    source "./config.sh" # should overwrite previous
fi

echo "This is a dev-only procedure to export the DB into the SQL base files. All base files will be overwritten."
read -p "Are you sure you want to continue (y/N)? " choice
case "$choice" in
  y|Y ) echo "Exporting the DB into the SQL base files...";;
  * ) return;;
esac

echo "===== STARTING PROCESS ====="


function export() {
    echo "Working on: "$1
    database=$1

    var_base_path="DB_"$database"_PATHS"
    base_path=${!var_base_path}
    
    base_conf="TPATH="$base_path";\
               CLEANFOLDER=1; \
               CHMODE=0; \
               TEXTDUMPS=0; \
               PARSEDUMP=1; \
               FULL=0; \
               DUMPOPTS='--skip-comments --skip-set-charset --routines --extended-insert --order-by-primary --single-transaction --quick'; \
               "
    
    var_base_conf="DB_"$database"_CONF"
    base_conf=$base_conf${!var_base_conf}
    
    var_base_name="DB_"$database"_NAME"
    base_name=${!var_base_name}


    bash $AC_PATH_DEPS"/drassil/mysql-tools/mysql-tools" dump "" $base_name "" "$base_conf"
}

for db in ${DATABASES[@]}
do
    export "$db"
done

echo "===== DONE ====="
