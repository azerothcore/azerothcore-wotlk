#!/usr/bin/env bash

unamestr=$(uname)
echo "OS: $unamestr"
if [[ "$unamestr" == 'Darwin' ]]; then
   rev=$(gdate +%s%N );
else
   rev=$(date +%s%N );
fi

CUR_PATH="$( cd "$( dirname "${BASH_SOURCE[0]}" )/" && pwd )";

filename=changes_"$rev".md

echo "Insert your changelog here

### How to upgrade

Add instructions on how to adapt the code to the new changes

" > "$CUR_PATH/$filename" && echo "File created: $filename";
