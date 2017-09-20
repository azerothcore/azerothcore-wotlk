#!/usr/bin/env bash

CURRENT_PATH="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

source "$CURRENT_PATH/includes/includes.sh"

cmdopt=$1

while true
do
echo "=====     DB ASSEMBLER MENU     ====="
PS3='Please enter your choice: '
options=(
    "Assemble ALL" "Assemble only bases" "Assemble only updates" "Assemble only customs"
    "Quit"
    "Assemble & import ALL" "Assemble & import only bases" "Assemble & import only updates" "Assemble & import only customs" 
    )

function _switch() {
    case $1 in
        "Assemble ALL")
            run true true true
            ;;
        "Assemble only bases")
            run true false false
            ;;
        "Assemble only updates")
            run false true false
            ;;
        "Assemble only customs")
            run false false true
            ;;
        "Assemble & import ALL")
            import true true true
            ;;
        "Assemble & import only bases")
            import true false false
            ;;
        "Assemble & import only updates")
            import false true false
            ;;
        "Assemble & import only customs")
            import false false true
            ;;
        "Quit")
            echo "Goodbye!"
            exit
            ;;
        *) echo invalid option;;
    esac
}

# run option directly if specified in argument
[ ! -z $1 ] && _switch "${options[$cmdopt-1]}" && exit 0

select opt in "${options[@]}"
do
    _switch "$opt"
    break
done
done
