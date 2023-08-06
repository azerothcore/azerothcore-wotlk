#!/bin/bash
set -e

echo "Pending SQL check script:"
echo

# Updates shouldn't contain PROCEDURE or FUNCTION statements
find data/sql/updates/pending* -name "*.sql" -type f | while read -r file; do
    if sed "s/'.*'\(.*\)/\1/g" "$file" | grep -q -i -E "(PROCEDURE|FUNCTION)"; then
        echo "> PROCEDURE check - Failed"
        exit 1
    else
        echo "> PROCEDURE check - OK"
    fi
done

# We want to ensure the end of file has a semicolon and doesn't have extra
# newlines
find data/sql/updates/pending* -name "*.sql" -type f | while read -r file; do
    ERR_AT_EOF="$(sed 's/ --[^-'\''"]*$//' "$file" | tr -d '\n ' | tail -c 1)"
    if [[ "$ERR_AT_EOF" != ";"  ]]; then
        echo "Missing Semicolon (;) or multiple newlines at the end of the file."
        exit 1
    else
        echo "> Semicolon check - OK"
    fi
done

find data/sql/updates/pending* -name "*.sql" -type f | while read -r file; do
    if sed "s/'.*'\(.*\)/\1/g" "$file" | grep -q -i -E "broadcast_text"; then
        echo "> broadcast_text check - Failed"
        echo "    - DON'T EDIT broadcast_text TABLE UNLESS YOU KNOW WHAT YOU ARE DOING!"
        echo "    - This error can safely be ignored if the changes are approved to be sniffed."
        exit 1
    else
        echo "> broadcast_text check - OK"
    fi
done

echo
echo "Everything looks good"
