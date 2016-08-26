#!/usr/bin/env bash

CURRENT_PATH="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

source "$CURRENT_PATH/../bash_shared/includes.sh"



UPDATES_PATH="$AC_PATH_ROOT/data/sql/updates/"

function import() {
    folder="db_"$1
    pendingPath="$AC_PATH_ROOT/data/sql/updates/pending_$folder"
    updPath="$UPDATES_PATH/$folder"

    latestUpd=`ls $updPath/ -1 | tail -n 1`

    if [ -z $latestUpd ]; then
        echo "FIRST UPDATE FILE MISSING!! DID YOU ARCHIVED IT?";
        exit;
    fi

    dateToday=`date +%Y_%m_%d`
    counter=0

    dateLast=$latestUpd
    tmp=${dateLast#*_*_*_}
    oldCnt=${tmp%.sql}
    oldDate=${dateLast%_$tmp}

    if [ "$oldDate" = "$dateToday" ]; then
        ((counter=$oldCnt+1))
    fi;

    for entry in "$pendingPath"/*.sql
    do
        if [[ -e $entry ]]; then
            startTransaction="START TRANSACTION;";
            updHeader="ALTER TABLE db_version CHANGE COLUMN "$latestUpd" "$dateToday"_"$counter" bit;";
            endTransaction="COMMIT;";

            cnt=$(printf -v counter "%02d" $counter ; echo $counter)
            newFile="$updPath/"$dateToday"_"$cnt".sql"

            echo "$startTransaction" > "$newFile"
            echo "$updHeader" >> "$newFile"
            echo "--" >> "$newFile"
            echo "--" >> "$newFile"

            cat $entry >> "$newFile"
            echo "$endTransaction" >> "$newFile"

            rm $entry

            ((counter+=1))
        fi
    done

}

import "world"
import "characters"
import "auth"
