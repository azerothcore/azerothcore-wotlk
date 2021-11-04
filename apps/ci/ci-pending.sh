#!/bin/bash
set -e

echo "Pending SQL check script:"
echo

for i in `find data/sql/updates/pending* -name "*.sql" -type f`; do
    if $(cat "$i"|sed "s/'.*'\(.*\)/\1/g"|grep -q -i -E "(PROCEDURE|FUNCTION)"); then
        echo "> PROCEDURE check - Failed"
        exit 1
    else
        echo "> PROCEDURE check - OK"
    fi
done

for i in `find data/sql/updates/pending* -name "*.sql" -type f`; do
    if [[ $(cat "$i"|sed 's/ --[^--]*$//'|tr -d '\n'|tr -d " "|tail -c 1) != ";"  ]]; then
        echo "Missing Semicolon (;) or multiple newlines at the end of the file."
        exit 1
    else
        echo "> Semicolon check - OK"
    fi
done

for i in `find data/sql/updates/pending* -name "*.sql" -type f`; do
    if $(cat "$i"|sed "s/'.*'\(.*\)/\1/g"|grep -q -i -E "version_db_"); then
        echo "> version_db check - OK"
    else
        echo "> version_db check - Failed"
        exit 1
    fi
done

echo
echo "Everything looks good"
