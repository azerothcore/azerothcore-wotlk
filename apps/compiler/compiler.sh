#!/usr/bin/env bash

set -e

CURRENT_PATH="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

source "$CURRENT_PATH/includes/includes.sh"

function run_option() {
    re='^[0-9]+$'
    if [[ $1 =~ $re ]] && test "${comp_functions[$1-1]+'test'}"; then
        ${comp_functions[$1-1]}
    elif [ -n "$(type -t comp_$1)" ] && [ "$(type -t comp_$1)" = function ]; then
        fun="comp_$1"
        $fun
    else
        echo "invalid option, use --help option for the commands list"
    fi
}

function comp_quit() {
    exit 0
}

comp_options=(
    "build: Configure and compile"
    "clean: Clean build files"
    "configure: Run CMake"
    "compile: Compile only"
    "all: clean, configure and compile"
    "ccacheClean: Clean ccache files, normally not needed"
    "ccacheShowStats: show ccache statistics"
    "quit: Close this menu")
comp_functions=(
    "comp_build"
    "comp_clean"
    "comp_configure"
    "comp_compile"
    "comp_all"
    "comp_ccacheClean"
    "comp_ccacheShowStats"
    "comp_quit")

PS3='[ Please enter your choice ]: '

runHooks "ON_AFTER_OPTIONS" #you can create your custom options

function _switch() {
    _reply="$1"
    _opt="$2"

    case $_reply in
        ""|"--help")
            echo "Available commands:"
            printf '%s\n' "${options[@]}"
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

    select opt in "${comp_options[@]}"
    do
        echo "==== ACORE COMPILER ===="
        _switch $REPLY
        break;
    done
done
