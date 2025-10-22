#!/usr/bin/env bash

 # shellcheck source-path=SCRIPTDIR
CURRENT_PATH="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

# shellcheck source=../bash_shared/includes.sh
source "$CURRENT_PATH/../bash_shared/includes.sh"
# shellcheck source=../bash_shared/menu_system.sh
source "$AC_PATH_APPS/bash_shared/menu_system.sh"

# Menu: single ordered source of truth (no functions in strings)
# Format: "key|short|description"
menu_items=(
    "bash|b|Run Bash tests"
    "core|c|Run AzerothCore tests"
    "quit|q|Exit from this menu"
)


# Menu command handler - called by menu system for each command
function handle_menu_command() {
    local key="$1"
    shift

    case "$key" in
        "bash")
            bash "$CURRENT_PATH/run-bash-tests.sh" "${@:-"--all"}"
            ;;
        "core")
            # shellcheck source=./run-core-tests.sh
            bash "$CURRENT_PATH/run-core-tests.sh" "$@"
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
menu_run_with_items "TEST FRAMEWORK" handle_menu_command -- "${menu_items[@]}" -- "$@"
