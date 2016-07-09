#!/bin/bash

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

for f in $DIR"/data/"*.dbc; do
    
    OPT=""
    FILE=$f".csv.def"

    if [ -f $FILE ]; then
        source $FILE
    fi

    echo "running wine $DIR/dbc_util/DBCUtil.exe $f -y $OPT"
    wine "$DIR/bin/DBCUtil/DBCUtil.exe" $f -y "$OPT"
done

read -p "Done"
