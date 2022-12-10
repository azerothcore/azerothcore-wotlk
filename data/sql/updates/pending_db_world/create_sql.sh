#!/usr/bin/env bash

unamestr=`uname`
if [[ "$unamestr" == 'Darwin' ]]; then
   date='gdate'
else
   date='date'
fi

CUR_PATH="$( cd "$( dirname "${BASH_SOURCE[0]}" )/" && pwd )";

rev=$( $date +%s%N );
filename=rev_"$rev".sql

echo "--" > "$CUR_PATH/$filename" && echo "File created: $filename";
