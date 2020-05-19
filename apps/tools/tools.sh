#!/usr/bin/env bash

set -e

CURRENT_PATH="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

source "$CURRENT_PATH/../bash_shared/includes.sh"

function run_option() {
    re='^[0-9]+$'
    if [[ $1 =~ $re ]] && test "${tools_functions[$1-1]+'test'}"; then
        ${tools_functions[$1-1]}
    elif [ -n "$(type -t tools_$1)" ] && [ "$(type -t tools_$1)" = function ]; then
        fun="tools_$1"
        $fun
    else
        echo "invalid option, use --help option for the commands list"
    fi
}

function tools_coverity_scan {
    source "$CURRENT_PATH/coverity.sh"
}

function tools_quit() {
    exit 0
}

tools_options=(
    "coverity_scan: Compile and send the build to coverity"
    "quit: Close this menu")
tools_functions=(
    "tools_coverity_scan"
    "tools_quit")

PS3='[ Please enter your choice ]: '

function _switch() {
    _reply="$1"
    _opt="$2"

    case $_reply in
        ""|"--help")
            echo "Available commands:"
            printf '%s\n' "${tools_options[@]}"
            ;;
        *)
            run_option $_reply $_opt
        ;;
    esac
}


while true
do
    # run option directly if specified in argument
    [ ! -z $1 ] && _switch $@
    [ ! -z $1 ] && exit 0

    select opt in "${tools_options[@]}"
    do
        echo "==== ACORE TOOLS ===="
        _switch $REPLY
        break;
    done
done
