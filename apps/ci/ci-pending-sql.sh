#!/usr/bin/env bash

CURRENT_PATH="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

source "$CURRENT_PATH/../bash_shared/includes.sh"

UPDATES_PATH="$AC_PATH_ROOT/data/sql/updates/"

COMMIT_HASH=

function import() {
    db=$1
    folder="db_"$db
    pendingPath="$AC_PATH_ROOT/data/sql/updates/pending_$folder"
    updPath="$UPDATES_PATH/$folder"
    archivedPath="$AC_PATH_ROOT/data/sql/archive/$folder/6.x"

    latestUpd=$(ls -1 $updPath/ | tail -n 1)

    if [ -z $latestUpd ]; then
        latestUpd=$(ls -1 $archivedPath/ | tail -n 1)
        echo "> Last update file for db $db is missing! Using archived file" $latestUpd
    fi

    dateToday=$(date +%Y_%m_%d)
    counter=0

    dateLast=$latestUpd
    tmp=${dateLast#*_*_*_}
    oldCnt=${tmp%.sql}
    oldDate=${dateLast%_$tmp}

    if [ "$oldDate" = "$dateToday" ]; then
        ((counter=10#$oldCnt+1)) # 10 # is needed to explictly add to a base 10 number
    fi;

    for entry in "$pendingPath"/*.sql
    do
        if [[ -e $entry ]]; then
            oldVer=$oldDate"_"$oldCnt

            cnt=$(printf -v counter "%02d" $counter ; echo $counter)

            newVer=$dateToday"_"$cnt

            newFile="$updPath/"$dateToday"_"$cnt".sql"

            oldFile=$(basename "$entry")
            prefix=${oldFile%_*.sql}
            suffix=${oldFile#rev_}
            rev=${suffix%.sql}

            isRev=0
            if [[ $prefix = "rev" && $rev =~ ^-?[0-9]+$ ]]; then
                isRev=1
            fi

            echo "-- DB update $oldVer -> $newVer" > "$newFile";

            cat $entry >> "$newFile";

            currentHash="$(git log --diff-filter=A "$entry" | grep "^commit " | sed -e 's/commit //')"

            if [[ "$COMMIT_HASH" != *"$currentHash"* ]]
            then
              COMMIT_HASH="$COMMIT_HASH $currentHash"
            fi

            rm $entry;

            oldDate=$dateToday
            oldCnt=$cnt

            ((counter+=1))
        fi
    done

}

import "world"
import "characters"
import "auth"

echo "Done."
