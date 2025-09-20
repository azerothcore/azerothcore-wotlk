#!/usr/bin/env bash

set -e

CURRENT_PATH="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

source "$CURRENT_PATH/includes/includes.sh"
source "$AC_PATH_APPS/bash_shared/menu_system.sh"

# Menu definition using the new system
# Format: "key|short|description"
comp_menu_items=(
    "build|b|Configure and compile"
    "clean|cl|Clean build files"
    "configure|cfg|Run CMake"
    "compile|cmp|Compile only"
    "all|a|clean, configure and compile"
    "ccacheClean|cc|Clean ccache files, normally not needed"
    "ccacheShowStats|cs|show ccache statistics"
    "quit|q|Close this menu"
)

# Menu command handler - called by menu system for each command
function handle_compiler_command() {
    local key="$1"
    shift
    
    case "$key" in
        "build")
            comp_build
            ;;
        "clean")
            comp_clean
            ;;
        "configure")
            comp_configure
            ;;
        "compile")
            comp_compile
            ;;
        "all")
            comp_all
            ;;
        "ccacheClean")
            comp_ccacheClean
            ;;
        "ccacheShowStats")
            comp_ccacheShowStats
            ;;
        "quit")
            echo "Closing compiler menu..."
            return 0
            ;;
        *)
            echo "Invalid option. Use --help to see available commands."
            return 1
            ;;
    esac
}

# Hook support (preserved from original)
runHooks "ON_AFTER_OPTIONS" # you can create your custom options

# Run the menu system
menu_run_with_items "ACORE COMPILER" handle_compiler_command -- "${comp_menu_items[@]}" -- "$@"
