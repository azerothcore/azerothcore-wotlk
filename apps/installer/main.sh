#!/usr/bin/env bash

INSTALLER_PATH="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

source "$INSTALLER_PATH/includes/includes.sh"

PS3='[Please enter your choice]: '
options=(
    "init (i): First Installation"
    "install-deps (d): Configure OS dep"
    "pull (u): Update Repository"
    "reset (r): Reset & Clean Repository"
    "compiler (c): Run compiler tool"
    "db-assembler (a): Run db assembler tool"
    "module (m): Module installer dashboard"
    "client-data: (gd): download client data from github repository (beta)"   # 11
    "run-worldserver (rw): execute a simple restarter for worldserver"
    "run-authserver (ra): execute a simple restarter for authserver"
    "docker (dr): Run docker tools"
    "quit: Exit from this menu"
    )

function _switch() {
    _reply="$1"
    _opt="$2"

    case $_reply in
        ""|"i"|"init")
            inst_allInOne
            ;;
        ""|"d"|"install-deps")
            inst_configureOS
            ;;
        ""|"u"|"pull")
            inst_updateRepo
            ;;
        ""|"r"|"reset")
            inst_resetRepo
            ;;
        ""|"c"|"compiler")
            bash "$AC_PATH_APPS/compiler/compiler.sh" $_opt
            ;;
        ""|"a"|"db-assembler")
            bash "$AC_PATH_APPS/db_assembler/db_assembler.sh" $_opt
            ;;
        ""|"m"|"module")
            denoRunFile "$INSTALLER_PATH/module.ts" "${@:2}"
            exit
            ;;
        ""|"gd"|"client-data")
            inst_download_client_data
            ;;
        ""|"rw"|"run-worldserver")
            inst_simple_restarter worldserver
            ;;
        ""|"ra"|"run-authserver")
            inst_simple_restarter authserver
            ;;
        ""|"dr"|"docker")
            DOCKER=1 denoRunFile "$AC_PATH_APPS/docker/docker-cmd.ts" "${@:2}"
            exit
            ;;
        ""|"q"|"quit")
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
