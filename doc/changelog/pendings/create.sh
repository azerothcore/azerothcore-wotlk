#!/usr/bin/env bash

unamestr=`uname`
if [[ "$unamestr" == 'Darwin' ]]; then
   date='gdate'
else
   date='date'
fi

CUR_PATH="$( cd "$( dirname "${BASH_SOURCE[0]}" )/" && pwd )";

rev=$( $date +%s%N );
filename=changes_"$rev".md

echo "Insert your changelog here

### How to upgrade

Add instructions on how to adapt the code to the new changes

" > "$CUR_PATH/$filename" && echo "File created: $filename";
