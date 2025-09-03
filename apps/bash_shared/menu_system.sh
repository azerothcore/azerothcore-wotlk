#!/usr/bin/env bash

# =============================================================================
# AzerothCore Menu System Library
# =============================================================================
# This library provides a unified menu system for AzerothCore scripts.
# It supports ordered menu definitions, short commands, numeric selection,
# and proper argument handling.
#
# Features:
# - Single source of truth for menu definitions
# - Automatic ID assignment (1, 2, 3...)
# - Short command aliases (c, i, q, etc.)
# - Interactive mode: numbers + long/short commands
# - Direct mode: only long/short commands (no numbers)
# - Proper argument forwarding
#
# Usage:
#   source "path/to/menu_system.sh"
#   menu_items=("command|short|description" ...)
#   menu_run "Menu Title" callback_function "${menu_items[@]}" "$@"
# =============================================================================

# Global arrays for menu state (will be populated by menu_define)
declare -a _MENU_KEYS=()
declare -a _MENU_SHORTS=()
declare -a _MENU_OPTIONS=()

# Parse menu items and populate global arrays
# Usage: menu_define array_elements...
function menu_define() {
    # Clear previous state
    _MENU_KEYS=()
    _MENU_SHORTS=()
    _MENU_OPTIONS=()
    
    # Parse each menu item: "key|short|description"
    local item key short desc
    for item in "$@"; do
        IFS='|' read -r key short desc <<< "$item"
        _MENU_KEYS+=("$key")
        _MENU_SHORTS+=("$short")
        _MENU_OPTIONS+=("$key ($short): $desc")
    done
}

# Display menu with numbered options
# Usage: menu_display "Menu Title"
function menu_display() {
    local title="$1"
    
    echo "==== $title ===="
    for idx in "${!_MENU_OPTIONS[@]}"; do
        local num=$((idx + 1))
        printf "%2d) %s\n" "$num" "${_MENU_OPTIONS[$idx]}"
    done
    echo ""
}

# Find menu index by user input (number, long command, or short command)
# Returns: index (0-based) or -1 if not found
# Usage: index=$(menu_find_index "user_input")
function menu_find_index() {
    local user_input="$1"
    
    # Try numeric selection first
    if [[ "$user_input" =~ ^[0-9]+$ ]]; then
        local num=$((user_input - 1))
        if [[ $num -ge 0 && $num -lt ${#_MENU_KEYS[@]} ]]; then
            echo "$num"
            return 0
        fi
    fi
    
    # Try long command name
    local idx
    for idx in "${!_MENU_KEYS[@]}"; do
        if [[ "$user_input" == "${_MENU_KEYS[$idx]}" ]]; then
            echo "$idx"
            return 0
        fi
    done
    
    # Try short command
    for idx in "${!_MENU_SHORTS[@]}"; do
        if [[ "$user_input" == "${_MENU_SHORTS[$idx]}" ]]; then
            echo "$idx"
            return 0
        fi
    done
    
    echo "-1"
    return 1
}

# Handle direct execution (command line arguments)
# Disables numeric selection to prevent confusion with command arguments
# Usage: menu_direct_execute callback_function "$@"
function menu_direct_execute() {
    local callback="$1"
    shift
    local user_input="$1"
    shift
    
    # Handle help requests directly
    if [[ "$user_input" == "--help" || "$user_input" == "help" || "$user_input" == "-h" ]]; then
        echo "Available commands:"
        printf '%s\n' "${_MENU_OPTIONS[@]}"
        return 0
    fi
    
    # Disable numeric selection in direct mode
    if [[ "$user_input" =~ ^[0-9]+$ ]]; then
        echo "Invalid option. Numeric selection is not allowed when passing arguments."
        echo "Use command name or short alias instead."
        return 1
    fi
    
    # Find command and execute
    local idx
    idx=$(menu_find_index "$user_input")
    if [[ $idx -ge 0 ]]; then
        "$callback" "${_MENU_KEYS[$idx]}" "$@"
        return $?
    else
        echo "Invalid option. Use --help to see available commands." >&2
        return 1
    fi
}

# Handle interactive menu selection
# Usage: menu_interactive callback_function "Menu Title"
function menu_interactive() {
    local callback="$1"
    local title="$2"
    
    while true; do
        menu_display "$title"
        read -r -p "Please enter your choice: " REPLY
        
        # Handle help request
        if [[ "$REPLY" == "--help" || "$REPLY" == "help" || "$REPLY" == "h" ]]; then
            echo "Available commands:"
            printf '%s\n' "${_MENU_OPTIONS[@]}"
            echo ""
            continue
        fi
        
        # Find and execute command
        local idx
        idx=$(menu_find_index "$REPLY")
        if [[ $idx -ge 0 ]]; then
            "$callback" "${_MENU_KEYS[$idx]}"
        else
            echo "Invalid option. Please try again or use 'help' for available commands." >&2
            echo ""
        fi
    done
}

# Main menu runner function
# Usage: menu_run "Menu Title" callback_function menu_item1 menu_item2 ... "$@"
function menu_run() {
    local title="$1"
    local callback="$2"
    shift 2
    
    # Extract menu items (all arguments until we find command line args)
    local menu_items=()
    local found_args=false
    
    # Separate menu items from command line arguments
    while [[ $# -gt 0 ]]; do
        if [[ "$1" =~ \| ]]; then
            # This looks like a menu item (contains pipe)
            menu_items+=("$1")
            shift
        else
            # This is a command line argument
            found_args=true
            break
        fi
    done
    
    # Define menu from collected items
    menu_define "${menu_items[@]}"
    
    # Handle direct execution if arguments provided
    if [[ $found_args == true ]]; then
        menu_direct_execute "$callback" "$@"
        return $?
    fi
    
    # Run interactive menu
    menu_interactive "$callback" "$title"
}

# Utility function to show available commands (for --help)
# Usage: menu_show_help
function menu_show_help() {
    echo "Available commands:"
    printf '%s\n' "${_MENU_OPTIONS[@]}"
}

# Utility function to get command key by index
# Usage: key=$(menu_get_key index)
function menu_get_key() {
    local idx="$1"
    if [[ $idx -ge 0 && $idx -lt ${#_MENU_KEYS[@]} ]]; then
        echo "${_MENU_KEYS[$idx]}"
    fi
}

# Utility function to get all command keys
# Usage: keys=($(menu_get_all_keys))
function menu_get_all_keys() {
    printf '%s\n' "${_MENU_KEYS[@]}"
}
