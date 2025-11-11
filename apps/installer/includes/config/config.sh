#!/usr/bin/env bash

CURRENT_PATH=$( cd "$(dirname "${BASH_SOURCE[0]}")" || exit ; pwd )

# shellcheck source=../../../bash_shared/includes.sh
source "$CURRENT_PATH/../../../bash_shared/includes.sh"
# shellcheck source=../includes.sh
source "$CURRENT_PATH/../includes.sh"
# shellcheck source=../../../bash_shared/menu_system.sh
source "$AC_PATH_APPS/bash_shared/menu_system.sh"

function acore_dash_configShowValue() {
    if [ $# -ne 1 ]; then
        echo "Usage: show <VAR_NAME>"
        return 1
    fi

    local varName="$1"
    local varValue="${!varName}"
    if [ -z "$varValue" ]; then
        echo "$varName is not set."
    else
        echo "$varName=$varValue"
    fi
}

function acore_dash_configLoad() {
    acore_common_loadConfig
    echo "Configuration loaded into the current shell session."
}

# Configuration management menu definition
# Format: "key|short|description"
config_menu_items=(
    "show|s|Show configuration variable value"
    "load|l|Load configurations variables within the current shell session"
    "help|h|Show detailed help"
    "quit|q|Close this menu"
)

# Menu command handler for configuration operations
function handle_config_command() {
    local key="$1"
    shift
    
    case "$key" in
        "show")
            acore_dash_configShowValue "$@"
            ;;
        "load")
            acore_dash_configLoad
            ;;
    esac
}

function acore_dash_config() {
    menu_run_with_items "CONFIG MANAGER" handle_config_command -- "${config_menu_items[@]}" -- "$@"
    return $?
}

