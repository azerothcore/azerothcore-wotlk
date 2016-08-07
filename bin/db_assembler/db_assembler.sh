#!/bin/bash

SRCPATH=$(readlink -f "../../")

source $SRCPATH"/bin/bash_shared/includes.sh"

if [ -f "./config.sh"  ]; then
    source "./config.sh" # should overwrite previous
fi

unamestr=`uname`
if [[ "$unamestr" == 'Darwin' ]]; then
    MD5_CMD="md5"
else
    MD5_CMD="md5sum"
fi

reg_file="$OUTPUT_FOLDER/.zzz_db_assembler_registry.sh"

declare -A registry

if [ -f "$reg_file" ]; then
    source "$reg_file"
fi

echo "===== STARTING PROCESS ====="


function assemble() {
    database=$1
    start_sql=$2

    var_base="DB_"$database"_PATHS"
    base=${!var_base}

    var_updates="DB_"$database"_UPDATE_PATHS"
    updates=${!var_updates}

    var_custom="DB_"$database"_CUSTOM_PATHS"
    custom=${!var_custom}


    suffix_base=""
    suffix_upd=""
    suffix_custom=""

    if (( $ALL_IN_ONE == 0 )); then
        suffix_base="_base"
    fi;

    echo "" > $OUTPUT_FOLDER$database$suffix_base".sql"


    if [ ! ${#base[@]} -eq 0 ]; then
        echo "Generating $OUTPUT_FOLDER$database$suffix_base ..."

        for d in "${base[@]}"
        do
            if [ ! -z $d ]; then
                for entry in "$d"/*.sql "$d"/**/*.sql
                do
                    if [[ -e $entry ]]; then
                        cat "$entry" >> $OUTPUT_FOLDER$database$suffix_base".sql"
                    fi
                done
            fi
        done
    fi

    if (( $ALL_IN_ONE == 0 )); then
        suffix_upd="_updates"

        echo "" > $OUTPUT_FOLDER$database$suffix_upd".sql"
    fi;

    if [ ! ${#updates[@]} -eq 0 ]; then
        echo "Generating $OUTPUT_FOLDER$database$suffix_upd ..."

        for d in "${updates[@]}"
        do
            if [ ! -z $d ]; then
                for entry in "$d"/*.sql "$d"/**/*.sql
                do
                    if [[ ! -e $entry ]]; then
                        continue
                    fi

                    file=$(basename "$entry")
                    hash=$($MD5_CMD "$entry")
                    hash="${hash%% *}" #remove file path
                    if [[ -z ${registry[$hash]} ]]; then
                        registry["$hash"]="$file"
                        echo "-- New update sql: "$file
                        cat "$entry" >> $OUTPUT_FOLDER$database$suffix_upd".sql"
                    fi
                done
            fi
        done
    fi

    if (( $ALL_IN_ONE == 0 )); then
        suffix_custom="_custom"

        echo "" > $OUTPUT_FOLDER$database$suffix_custom".sql"
    fi;



    if [ ! ${#custom[@]} -eq 0 ]; then
        echo "Generating $OUTPUT_FOLDER$database$suffix_custom ..."

        for d in "${custom[@]}"
        do
            if [ ! -z $d ]; then
                for entry in "$d"/*.sql "$d"/**/*.sql
                do
                    if [[ ! -e $entry ]]; then
                        continue
                    fi

                    file=$(basename "$entry")
                    hash=$($MD5_CMD "$entry")
                    hash="${hash%% *}" #remove file path
                    if [[ -z ${registry[$hash]} ]]; then
                        registry["$hash"]="$file"
                        echo "-- New custom sql: "$file
                        cat "$entry" >> $OUTPUT_FOLDER$database$suffix_custom".sql"
                    fi
                done
            fi
        done
    fi
}

mkdir -p $OUTPUT_FOLDER

for db in ${DATABASES[@]}
do
    assemble "$db" $version".sql"
done

echo "" > $reg_file

for i in "${!registry[@]}"
do
  echo "registry['"$i"']='"${registry[$i]}"'" >> "$reg_file"
done

echo "===== DONE ====="
