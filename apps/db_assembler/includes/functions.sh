# globals
PROMPT_USER=""
PROMPT_PASS=""

# use in a subshell
function dbasm_resetExitCode() {
	exit 0
}

function dbasm_mysqlExec() {
	confs=$1
	command=$2
	options=$3

	eval $confs

	if [[ ! -z "${PROMPT_USER// }" ]]; then
		MYSQL_USER=$PROMPT_USER
		MYSQL_PASS=$PROMPT_PASS
	fi

	export MYSQL_PWD=$MYSQL_PASS

	retval=$("$DB_MYSQL_EXEC"  -h "$MYSQL_HOST" -u "$MYSQL_USER" $options -e "$command")
	if [[ $? -ne 0 ]]; then
		err=$("$DB_MYSQL_EXEC"  -h "$MYSQL_HOST" -u "$MYSQL_USER" $options -e "$command" 2>&1 )
		if [[ "$err" == *"Access denied"* ]]; then
			read -p "Insert mysql user:" PROMPT_USER
			read -p "Insert mysql pass:" -s PROMPT_PASS
			export MYSQL_PWD=$PROMPT_PASS

            retval=$("$DB_MYSQL_EXEC"  -h "$MYSQL_HOST" -u "$PROMPT_USER" $options -e "$command")
            if [[ $? -ne 0 ]]; then
                err=$("$DB_MYSQL_EXEC"  -h "$MYSQL_HOST" -u "$PROMPT_USER" $options -e "$command" 2>&1 )
                # it happens on new mysql 5.7 installations
                # since mysql_native_password is explicit now
                if [[ "$err" == *"Access denied"* ]]; then
                    echo "Setting mysql_native_password and  for  $PROMPT_USER ..."
                    sudo -h "$MYSQL_HOST" "$DB_MYSQL_EXEC" -e "UPDATE mysql.user SET authentication_string=PASSWORD('${PROMPT_PASS}'), plugin='mysql_native_password' WHERE User='${PROMPT_USER}'; FLUSH PRIVILEGES;"
                fi
            fi

            # create configured account if not exists
            "$DB_MYSQL_EXEC"  -h "$MYSQL_HOST" -u "$PROMPT_USER" $options -e "CREATE USER '${MYSQL_USER}'@'${MYSQL_HOST}' IDENTIFIED BY '${MYSQL_PASS}' WITH MAX_QUERIES_PER_HOUR 0 MAX_CONNECTIONS_PER_HOUR 0 MAX_UPDATES_PER_HOUR 0;"
            "$DB_MYSQL_EXEC"  -h "$MYSQL_HOST" -u "$PROMPT_USER" $options -e "GRANT CREATE ON *.* TO '${MYSQL_USER}'@'${MYSQL_HOST}'  WITH GRANT OPTION;"
            for db in ${DATABASES[@]}
            do
                local _uc=${db^^}
                local _name="DB_"$_uc"_CONF"
                local _confs=${!_name}

                local _name="DB_"$_uc"_NAME"
                local _dbname=${!_name}

                eval $_confs
                echo "Grant permissions for ${MYSQL_USER}'@'${MYSQL_HOST} to ${_dbname}"
                "$DB_MYSQL_EXEC"  -h "$MYSQL_HOST" -u "$PROMPT_USER" $options -e "GRANT ALL PRIVILEGES ON ${_dbname}.* TO '${MYSQL_USER}'@'${MYSQL_HOST}'  WITH GRANT OPTION;"
            done
		else
			exit
		fi
	fi
}

function dbasm_isNotEmpty() {
    dbname=$1
    conf=$2

    dbasm_mysqlExec "$conf" "SELECT COUNT(DISTINCT table_name) FROM information_schema.columns WHERE table_schema = '${dbname}'" "--skip-column-names"
    if (( $retval > 0 )); then
        true
    else
        false
    fi
}

function dbasm_dbExists() {
    dbname=$1
    conf=$2

    dbasm_mysqlExec "$conf" "SHOW DATABASES LIKE '${dbname}'" "--skip-column-names"
    if [ "$retval" == "${dbname}" ]; then
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

    eval $confs

    CONF_USER=$MYSQL_USER
    CONF_PASS=$MYSQL_PASS

    if dbasm_dbExists $dbname "$confs"; then
        echo "$dbname database exists"
    else
		echo "Creating DB ${dbname} ..."
        dbasm_mysqlExec "$confs" "CREATE DATABASE \`${dbname}\`" ""
        dbasm_mysqlExec "$confs" "GRANT ALL PRIVILEGES ON \`${dbname}\`.* TO '${CONF_USER}'@'${MYSQL_HOST}' WITH GRANT OPTION;"
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

    name="DB_"$uc"_UPDATES_PATHS"
    v="$name[@]"
    updates=("${!v}")

    name='DB_'$uc'_CUSTOM_PATHS'
    v="$name[@]"
    custom=("${!v}")


    suffix_base="_base"
    suffix_upd="_updates"
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

	if [[ ! -z "${PROMPT_USER// }" ]]; then
		MYSQL_USER=$PROMPT_USER
		MYSQL_PASS=$PROMPT_PASS
	fi

    export MYSQL_PWD=$MYSQL_PASS

    now=`date +%s`

	"$DB_MYSQL_DUMP_EXEC" --opt --user="$MYSQL_USER" --host="$MYSQL_HOST" "$dbname" > "${BACKUP_FOLDER}${database}_backup_${now}.sql" && echo "done"
	if [[ $? -ne 0 ]]; then
		err=$("$DB_MYSQL_DUMP_EXEC" --opt --user="$MYSQL_USER" --host="$MYSQL_HOST" "$dbname" 2>&1 )
		if [[ "$err" == *"Access denied"* ]]; then
			read -p "Insert mysql user:" PROMPT_USER
			read -p "Insert mysql pass:" -s PROMPT_PASS
			export MYSQL_PWD=$PROMPT_PASS

			"$DB_MYSQL_DUMP_EXEC" --opt --user="$PROMPT_USER" --host="$MYSQL_HOST" "$dbname" > "${BACKUP_FOLDER}${database}_backup_${now}.sql" && echo "done"
		else
			exit
		fi
	fi
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
	else
	    echo "$dbname seems empty"
        fi
    fi

    echo "importing $1 - $2 ..."

    eval $confs;

	if [[ ! -z "${PROMPT_USER// }" ]]; then
		MYSQL_USER=$PROMPT_USER
		MYSQL_PASS=$PROMPT_PASS
	fi

    export MYSQL_PWD=$MYSQL_PASS


    # TODO: remove this line after we squash our DB updates
    "$DB_MYSQL_EXEC" -h "$MYSQL_HOST" -u "$MYSQL_USER" -e "SET GLOBAL max_allowed_packet=128*1024*1024;"

	"$DB_MYSQL_EXEC" -h "$MYSQL_HOST" -u "$MYSQL_USER" --default-character-set=utf8 "$dbname" < "${OUTPUT_FOLDER}${database}_${type}.sql"

	if [[ $? -ne 0 ]]; then
		err=$("$DB_MYSQL_EXEC" -h "$MYSQL_HOST" -u "$MYSQL_USER" "$dbname" 2>&1 )
		if [[ "$err" == *"Access denied"* ]]; then
			read -p "Insert mysql user:" PROMPT_USER
			read -p "Insert mysql pass:" -s PROMPT_PASS
			export MYSQL_PWD=$PROMPT_PASS

			"$DB_MYSQL_EXEC" -h "$MYSQL_HOST" -u "$PROMPT_USER" "$dbname" < "${OUTPUT_FOLDER}${database}_${type}.sql"
		else
			exit
		fi
	fi
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
            dbasm_db_import "$db" "updates"
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
