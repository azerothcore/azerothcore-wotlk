#!/usr/bin/env bash

CUR_PATH="$( cd "$( dirname "${BASH_SOURCE[0]}" )/" && pwd )";

rev=$( date +%s%N );

echo "INSERT INTO version_db_characters(\`sql_rev\`) VALUES ('"$rev"');" > "$CUR_PATH/rev_"$rev".sql" && echo "File created";
