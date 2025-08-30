#!/usr/bin/env bash

CURRENT_PATH="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

source "$CURRENT_PATH/includes/includes.sh"

PS3='[Please enter your choice]: '
options=(
    "init (i): First Installation"
    "install-deps (d): Configure OS dep"
    "pull (u): Update Repository"
    "reset (r): Reset & Clean Repository"
    "compiler (c): Run compiler tool"
    "module (m): Module manager (search/install/update/remove)"
    "module-install (mi): Module Install by name [DEPRECATED]"
    "module-update (mu): Module Update by name [DEPRECATED]"
    "module-remove: (mr): Module Remove by name [DEPRECATED]"
    "client-data: (gd): download client data from github repository (beta)"
    "run-worldserver (rw): execute a simple restarter for worldserver"
    "run-authserver (ra): execute a simple restarter for authserver"
    "docker (dr): Run docker tools"
    "version (v): Show AzerothCore version"
    "service-manager (sm): Run service manager to run authserver and worldserver in background"
    "quit (q): Exit from this menu"
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
        ""|"m"|"module")
            # Unified module command: supports subcommands search|install|update|remove
            inst_module "${@:2}"
            ;;
        ""|"ms"|"module-search")
            echo "[DEPRECATED] Use: ./acore.sh module search <terms...>"
            inst_module_search "${@:2}"
            ;;
        ""|"mi"|"module-install")
            echo "[DEPRECATED] Use: ./acore.sh module install <modules...>"
            inst_module_install "${@:2}"
            ;;
        ""|"mu"|"module-update")
            echo "[DEPRECATED] Use: ./acore.sh module update <modules...>"
            inst_module_update "${@:2}"
            ;;
        ""|"mr"|"module-remove")
            echo "[DEPRECATED] Use: ./acore.sh module remove <modules...>"
            inst_module_remove "${@:2}"
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
            DOCKER=1 bash "$AC_PATH_ROOT/apps/docker/docker-cmd.sh" "${@:2}"
            exit
            ;;
        ""|"v"|"version")
            # denoRunFile "$AC_PATH_APPS/installer/main.ts" "version"
            printf "AzerothCore Rev. %s\n" "$ACORE_VERSION"
            exit
            ;;
        ""|"sm"|"service-manager")
            bash "$AC_PATH_APPS/startup-scripts/src/service-manager.sh" "${@:2}"
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
    echo "opt: $opt"
done
