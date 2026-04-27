#!/usr/bin/env bash

# AzerothCore Dashboard Script
#
# This script provides an interactive menu system for AzerothCore management
# using the unified menu system library.
#
# Usage:
#   ./acore.sh                    - Interactive mode with numeric and text selection
#   ./acore.sh <command> [args]   - Direct command execution (only text commands, no numbers)
#
# Interactive Mode:
#   - Select options by number (1, 2, 3...), command name (init, compiler, etc.),
#     or short alias (i, c, etc.)
#   - All selection methods work in interactive mode
#
# Direct Command Mode:
#   - Only command names and short aliases are accepted (e.g., './acore.sh compiler build', './acore.sh c build')
#   - Numeric selection is disabled to prevent confusion with command arguments
#   - Examples: './acore.sh init', './acore.sh compiler clean', './acore.sh module install mod-name'
#
# Menu System:
#   - Uses unified menu system from bash_shared/menu_system.sh
#   - Single source of truth for menu definitions
#   - Consistent behavior across all AzerothCore tools

CURRENT_PATH="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
source "$CURRENT_PATH/includes/includes.sh"
source "$AC_PATH_APPS/bash_shared/menu_system.sh"

# Menu: single ordered source of truth (no functions in strings)
# Format: "key|short|description"
menu_items=(
    "init|i|First Installation"
    "install-deps|d|Configure OS dep"
    "pull|u|Update Repository"
    "reset|r|Reset & Clean Repository"
    "setup-db|r|Install db only"
    "compiler|c|Run compiler tool"
    "module|m|Module manager (search/install/update/remove)"
    "client-data|gd|download client data from github repository (beta)"
    "run-worldserver|rw|execute a simple restarter for worldserver"
    "run-authserver|ra|execute a simple restarter for authserver"
    "test|t|Run test framework"
    "docker|dr|Run docker tools"
    "version|v|Show AzerothCore version"
    "service-manager|sm|Run service manager to run authserver and worldserver in background"
    "config|cf|Configuration manager"
    "quit|q|Exit from this menu"
)


# Menu command handler - called by menu system for each command
function handle_menu_command() {
    local key="$1"
    shift

    case "$key" in
        "init")
            inst_allInOne
            ;;
        "install-deps")
            inst_configureOS
            ;;
        "pull")
            inst_updateRepo
            ;;
        "reset")
            inst_resetRepo
            ;;
        "setup-db")
            inst_dbCreate
            ;;
        "compiler")
            bash "$AC_PATH_APPS/compiler/compiler.sh" "$@"
            ;;
        "module")
            bash "$AC_PATH_APPS/installer/includes/modules-manager/module-main.sh" "$@"
            ;;
        "client-data")
            inst_download_client_data
            ;;
        "run-worldserver")
            inst_simple_restarter worldserver
            ;;
        "run-authserver")
            inst_simple_restarter authserver
            ;;
        "test")
            bash "$AC_PATH_APPS/test-framework/test-main.sh" "$@"
            ;;
        "docker")
            DOCKER=1 bash "$AC_PATH_ROOT/apps/docker/docker-cmd.sh" "$@"
            exit
            ;;
        "version")
            printf "AzerothCore Rev. %s\n" "$ACORE_VERSION"
            exit
            ;;
        "service-manager")
            bash "$AC_PATH_APPS/startup-scripts/src/service-manager.sh" "$@"
            exit
            ;;
        "config")
            bash "$AC_PATH_APPS/installer/includes/config/config-main.sh" "$@"
            ;;
        "quit")
            echo "Goodbye!"
            exit
            ;;
        *)
            echo "Invalid option. Use --help to see available commands."
            return 1
            ;;
    esac
}

# Run the menu system
menu_run_with_items "ACORE DASHBOARD" handle_menu_command -- "${menu_items[@]}" -- "$@"
