function dbasm_isNotEmpty() {
    dbname=$1
    conf=$2

    eval $confs;
    export MYSQL_PWD=$MYSQL_PASS

    RESULT=`"$DB_MYSQL_EXEC"  -h "$MYSQL_HOST" -u "$MYSQL_USER" --skip-column-names -e "SELECT COUNT(DISTINCT table_name) FROM information_schema.columns WHERE table_schema = '${dbname}'"`
    if (( $RESULT > 0 )); then
        true
    else
        false
    fi
}

function dbasm_dbExists() {
    dbname=$1
    conf=$2

    eval $confs;
    export MYSQL_PWD=$MYSQL_PASS

    RESULT=`"$DB_MYSQL_EXEC"  -h "$MYSQL_HOST" -u "$MYSQL_USER" --skip-column-names -e "SHOW DATABASES LIKE '${dbname}'"`
    if [ "$RESULT" == "${dbname}" ]; then
        true
    else
        false
    fi
}

function dbasm_createDB() {
    database=${1,,}

    uc=${database^^}

    name="DB_"$uc"_CONF"
    confs=${!name}

    name="DB_"$uc"_NAME"
    dbname=${!name}

    eval $confs;

    export MYSQL_PWD=$MYSQL_PASS

    if dbasm_dbExists $dbname "$confs"; then
        echo "$dbname database exists"
    else 
        "$DB_MYSQL_EXEC"  -h "$MYSQL_HOST" -u "$MYSQL_USER" -e "GRANT USAGE ON * . * TO 'acore'@'${MYSQL_HOST}' IDENTIFIED BY 'acore' WITH MAX_QUERIES_PER_HOUR 0 MAX_CONNECTIONS_PER_HOUR 0 MAX_UPDATES_PER_HOUR 0 ;"
        "$DB_MYSQL_EXEC"  -h "$MYSQL_HOST" -u "$MYSQL_USER" -e "CREATE DATABASE \`${dbname}\`"
        "$DB_MYSQL_EXEC"  -h "$MYSQL_HOST" -u "$MYSQL_USER" -e "GRANT ALL PRIVILEGES ON \`${dbname}\` . * TO 'acore'@'${MYSQL_HOST}' WITH GRANT OPTION;"
    fi
}

function dbasm_assemble() {
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

function dbasm_run() {
    echo "===== STARTING ASSEMBLY PROCESS ====="

        mkdir -p "$OUTPUT_FOLDER"

        for db in ${DATABASES[@]}
        do
            dbasm_assemble "$db" $version".sql" $1 $2 $3
        done

    echo "=====           DONE            ====="
}

function dbasm_db_backup() {
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

function dbasm_db_import() {
    database=${1,,}
    type=$2

    uc=${database^^}

    name="DB_"$uc"_CONF"
    confs=${!name}

    name="DB_"$uc"_NAME"
    dbname=${!name}

    if [[ $type = "base" && $DB_SKIP_BASE_IMPORT_IF_EXISTS = true ]]; then
        if dbasm_isNotEmpty $dbname "$confs"; then
            echo "$dbname is not empty, base importing skipped"
            return
        fi
    fi

    echo "importing $1 - $2 ..."

    eval $confs;

    export MYSQL_PWD=$MYSQL_PASS

    "$DB_MYSQL_EXEC" -h "$MYSQL_HOST" -u "$MYSQL_USER" "$dbname" < "${OUTPUT_FOLDER}${database}_${type}.sql"
}

function dbasm_import() {
    dbasm_run $1 $2 $3

    with_base=$1
    with_updates=$2
    with_custom=$3

    echo "=====       CHECKING DBs        ====="
    for db in ${DATABASES[@]}
    do
        dbasm_createDB "$db"
    done
    echo "=====           DONE            ====="

    #
    # BACKUP
    #

    if [ $BACKUP_ENABLE = true ]; then
        echo "===== STARTING BACKUP PROCESS   ====="
        mkdir -p "$BACKUP_FOLDER"

        for db in ${DATABASES[@]}
        do
            dbasm_db_backup "$db"
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
            dbasm_db_import "$db" "base"
        done
    fi 

    if [ $with_updates = true ]; then
        for db in ${DATABASES[@]}
        do
            dbasm_db_import "$db" "update"
        done
    fi 

    if [ $with_custom = true ]; then
        for db in ${DATABASES[@]}
        do
            dbasm_db_import "$db" "custom"
        done
    fi 

    echo "=====           DONE            ====="
}
