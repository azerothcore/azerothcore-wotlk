#!/usr/bin/env bash

CURRENT_PATH="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

source "$CURRENT_PATH/includes/includes.sh"

function all() {
    clean
    configure
    build
}

function run_option() {
    if test "${comp_functions[$1-1]+'test'}"; then
        ${comp_functions[$1-1]}
    else
        echo "invalid option"
    fi        
}

comp_options=("Clean" "Configure" "Build" "All")
comp_functions=("clean" "configure" "build" "all")

runHooks "ON_AFTER_OPTIONS" #you can create your custom options

# push exit after custom options
comp_options+=('Exit')
comp_functions+=('exit 0')

# run option directly if specified in argument
[ ! -z $1 ] && run_option $1 && exit 0

PS3='[ Please enter your choice ]: '
select opt in "${comp_options[@]}"
do
    case $opt in
        'Exit')
            break
            ;;
        *) 
            run_option $REPLY
        ;;
    esac
done
