#!/usr/bin/env bash

unamestr=`uname`
if [[ "$unamestr" == 'Darwin' ]]; then
   SRCPATH=$(greadlink -f "../../")
else
   SRCPATH=$(readlink -f "../../")
fi

source $SRCPATH"/bin/bash_shared/includes.sh"

if [ -f "./config.sh"  ]; then
    source "./config.sh" # should overwrite previous
fi

function assemble() {
    # to lowercase
    database=${1,,}
    start_sql=$2
    with_base=$3
    with_updates=$4
    with_custom=$5

    uc=${database^^}

    name="DB_"$uc"_PATHS"
    v="$name[@]"
    base=("${!v}")

    name="DB_"$uc"_UPDATE_PATHS"
    v="$name[@]"
    updates=("${!v}")

    name='DB_'$uc'_CUSTOM_PATHS'
    v="$name[@]"
    custom=("${!v}")


    suffix_base="_base"
    suffix_upd="_update"
    suffix_custom="_custom"

    curTime=`date +%Y_%m_%d_%H_%M_%S`

    if [ $with_base = true ]; then
        echo "" > $OUTPUT_FOLDER$database$suffix_base".sql"


        if [ ! ${#base[@]} -eq 0 ]; then
            echo "Generating $OUTPUT_FOLDER$database$suffix_base ..."

            for d in "${base[@]}"
            do
                echo "Searching on $d ..."
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
    fi

    if [ $with_updates = true ]; then
        updFile=$OUTPUT_FOLDER$database$suffix_upd".sql"

        echo "" > $updFile

        if [ ! ${#updates[@]} -eq 0 ]; then
            echo "Generating $OUTPUT_FOLDER$database$suffix_upd ..."

            for d in "${updates[@]}"
            do
                echo "Searching on $d ..."
                if [ ! -z $d ]; then
                    for entry in "$d"/*.sql "$d"/**/*.sql
                    do
                        if [[ ! -e $entry ]]; then
                            continue
                        fi

                        echo "-- $file" >> $updFile
                        cat "$entry" >> $updFile
                    done
                fi
            done
        fi
    fi

    if [ $with_custom = true ]; then
        custFile=$OUTPUT_FOLDER$database$suffix_custom".sql"

        echo "" > $custFile

        if [ ! ${#custom[@]} -eq 0 ]; then
            echo "Generating $OUTPUT_FOLDER$database$suffix_custom ..."

            for d in "${custom[@]}"
            do
                echo "Searching on $d ..."
                if [ ! -z $d ]; then
                    for entry in "$d"/*.sql "$d"/**/*.sql
                    do
                        if [[ ! -e $entry ]]; then
                            continue
                        fi

                        echo "-- $file" >> $custFile
                        cat "$entry" >> $custFile
                    done
                fi
            done
        fi
    fi
}

function run() {
    echo "===== STARTING ASSEMBLY PROCESS ====="

        mkdir -p "$OUTPUT_FOLDER"

        for db in ${DATABASES[@]}
        do
            assemble "$db" $version".sql" $1 $2 $3
        done

    echo "=====           DONE            ====="
}

function db_backup() {
    echo "backing up $1"

    database=${1,,}

    uc=${database^^}

    name="DB_"$uc"_CONF"
    confs=${!name}

    name="DB_"$uc"_NAME"
    dbname=${!name}

    eval $confs;

    export MYSQL_PWD=$MYSQL_PASS

    now=`date +%s`

    "$DB_MYSQL_DUMP_EXEC" --opt --user="$MYSQL_USER" --host="$MYSQL_HOST" "$dbname" > "${BACKUP_FOLDER}${database}_backup_${now}.sql" && echo "done"
}

function db_import() {
    echo "importing $1 - $2"

    database=${1,,}
    type=$2

    uc=${database^^}

    name="DB_"$uc"_CONF"
    confs=${!name}

    name="DB_"$uc"_NAME"
    dbname=${!name}

    eval $confs;

    export MYSQL_PWD=$MYSQL_PASS

    "$DB_MYSQL_EXEC" -h "$MYSQL_HOST" -u "$MYSQL_USER" "$dbname" < "${OUTPUT_FOLDER}${database}_${type}.sql"
}

function import () {
    run $1 $2 $2


    with_base=$1
    with_updates=$2
    with_custom=$3

    #
    # BACKUP
    #

    if [ $BACKUP_ENABLE = true ]; then
        echo "===== STARTING BACKUP PROCESS ====="
        mkdir -p "$BACKUP_FOLDER"

        for db in ${DATABASES[@]}
        do
            db_backup "$db"
        done
        echo "=====           DONE            ====="
    fi

    echo "===== STARTING IMPORTING PROCESS ====="
    #
    # IMPORT
    #
    if [ $with_base = true ]; then
        for db in ${DATABASES[@]}
        do
            db_import "$db" "base"
        done
    fi 

    if [ $with_updates = true ]; then
        for db in ${DATABASES[@]}
        do
            db_import "$db" "update"
        done
    fi 

    if [ $with_custom = true ]; then
        for db in ${DATABASES[@]}
        do
            db_import "$db" "custom"
        done
    fi 

    echo "=====           DONE            ====="
}

while true
do
echo "=====     DB ASSEMBLER MENU     ====="
PS3='Please enter your choice: '
options=(
    "Assemble ALL" "Assemble only bases" "Assemble only updates" "Assemble only customs"
    "Quit"
    "Assemble & import ALL" "Assemble & import only bases" "Assemble & import only updates" "Assemble & import only customs" 
    )
select opt in "${options[@]}"
do
    case $opt in
        "Assemble ALL")
            run true true true
            break
            ;;
        "Assemble only bases")
            run true false false
            break
            ;;
        "Assemble only updates")
            run false true false
            break
            ;;
        "Assemble only customs")
            run false false true
            break
            ;;
        "Assemble & import ALL")
            import true true true
            break
            ;;
        "Assemble & import only bases")
            import true false false
            break
            ;;
        "Assemble & import only updates")
            import false true false
            break
            ;;
        "Assemble & import only customs")
            import false false true
            break
            ;;
        "Quit")
            break
            ;;
        *) echo invalid option;;
    esac
done
done
