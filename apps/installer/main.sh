#!/usr/bin/env bash

CURRENT_PATH="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

source "$CURRENT_PATH/includes/includes.sh"

cmdopt=$1

while true
do
echo "=====     INSTALLER SCRIPT     ====="
PS3='Please enter your choice: '
options=(
    "First Installation" "Configure OS dep" "Update Repository" "Reset & Clean Repository"
    "Compile" "Clean & Compile" "Assemble & Import DB" "Module Search" "Module Install" "Module Update" "Module Remove"
    "Sub Menu >> Compiler" "Sub Menu >> DB Assembler"
    "Quit"
    )

function _switch() {
    case $1 in
        "First Installation")
            inst_allInOne
            ;;
        "Configure OS dep")
            inst_configureOS
            ;;
        "Update Repository")
            inst_updateRepo
            ;;
        "Reset & Clean Repository")
            inst_resetRepo
            ;;
        "Compile")
            inst_compile
            ;;
        "Clean & Compile")
            inst_cleanCompile
            ;;
        "Assemble & Import DB")
            inst_assembleDb
            ;;
        "Module Search")
            inst_module_search $2
            ;;
        "Module Install")
            inst_module_install $2
            ;;
        "Module Update")
            inst_module_update $2
            ;;
        "Module Remove")
            inst_module_remove $2
            ;;
        "Sub Menu >> Compiler")
            bash "$AC_PATH_BIN/compiler/compiler.sh"
            ;;
        "Sub Menu >> DB Assembler")
            bash "$AC_PATH_BIN/db_assembler/db_assembler.sh"
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
