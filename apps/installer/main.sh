#!/usr/bin/env bash

CURRENT_PATH="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

source "$CURRENT_PATH/includes/includes.sh"

PS3='[Please enter your choice]: '
options=(
    "init (i): First Installation"                  # 1
    "install-deps (d): Configure OS dep"            # 2
    "pull (u): Update Repository"                   # 3
    "reset (r): Reset & Clean Repository"           # 4
    "compiler (c): Run compiler tool"               # 5
    "module-search (ms): Module Search by keyword" # 6
    "module-install (mi): Module Install by name"  # 7
    "module-update (mu): Module Update by name"    # 8
    "module-remove: (mr): Module Remove by name"   # 9
    "client-data: (gd): download client data from github repository (beta)"   # 10
    "run-worldserver (rw): execute a simple restarter for worldserver" # 11
    "run-authserver (ra): execute a simple restarter for authserver" # 12
    "docker (dr): Run docker tools" # 13
    "quit: Exit from this menu"                     # 14
    )

function _switch() {
    _reply="$1"
    _opt="$2"

    case $_reply in
        ""|"i"|"init"|"1")
            inst_allInOne
            ;;
        ""|"d"|"install-deps"|"2")
            inst_configureOS
            ;;
        ""|"u"|"pull"|"3")
            inst_updateRepo
            ;;
        ""|"r"|"reset"|"4")
            inst_resetRepo
            ;;
        ""|"c"|"compiler"|"5")
            bash "$AC_PATH_APPS/compiler/compiler.sh" $_opt
            ;;
        ""|"ms"|"module-search"|"6")
            inst_module_search "$_opt"
            ;;
        ""|"mi"|"module-install"|"7")
            inst_module_install "$_opt"
            ;;
        ""|"mu"|"module-update"|"8")
            inst_module_update "$_opt"
            ;;
        ""|"mr"|"module-remove"|"9")
            inst_module_remove "$_opt"
            ;;
        ""|"gd"|"client-data"|"10")
            inst_download_client_data
            ;;
        ""|"rw"|"run-worldserver"|"11")
            inst_simple_restarter worldserver
            ;;
        ""|"ra"|"run-authserver"|"12")
            inst_simple_restarter authserver
            ;;
        ""|"dr"|"docker"|"13")
            DOCKER=1 bash "$AC_PATH_ROOT/apps/docker/docker-cmd.sh" "${@:2}"
            exit
            ;;
        ""|"v"|"version"|"14")
            # denoRunFile "$AC_PATH_APPS/installer/main.ts" "version"
            printf "AzerothCore Rev. %s\n" "$ACORE_VERSION"
            exit
            ;;
        ""|"quit"|"15")
            echo "Goodbye!"
            exit
            ;;
        ""|"--help")
            echo "Available commands:"
            printf '%s\n' "${options[@]}"
            ;;
        *) echo "invalid option, use --help option for the commands list";;
    esac
}

while true
do
    # run option directly if specified in argument
    [ ! -z $1 ] && _switch $@ # old method: "${options[$cmdopt-1]}"
    [ ! -z $1 ] && exit 0

    echo "==== ACORE DASHBOARD ===="
    select opt in "${options[@]}"
    do
        _switch $REPLY
        break
    done
done
