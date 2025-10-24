#!/usr/bin/env bash

# =============================================================================
# AzerothCore Module Manager Functions
# =============================================================================
# This file contains all functions related to module management in AzerothCore.
# It provides capabilities for installing, updating, removing, and searching
# modules with support for advanced syntax and intelligent cross-format matching.
#
# Main Features:
# - Advanced syntax: repo[:dirname][@branch[:commit]]
# - Legacy compatibility: repo:branch:commit
# - Cross-format module recognition (URLs, SSH, simple names)
# - Custom directory naming to prevent conflicts
# - Intelligent duplicate prevention
# - Interactive menu system for easy management
#
# Usage:
#   source "path/to/modules.sh"
#   inst_module_install "mod-transmog:my-custom-dir@develop:abc123"
#   inst_module                    # Interactive menu
#   inst_module search "transmog"  # Direct command
#
# =============================================================================
CURRENT_PATH=$( cd "$(dirname "${BASH_SOURCE[0]}")" || exit ; pwd )

source "$CURRENT_PATH/../../../bash_shared/includes.sh"
source "$CURRENT_PATH/../includes.sh"
source "$AC_PATH_APPS/bash_shared/menu_system.sh"

# -----------------------------------------------------------------------------
# Color support (disabled when not a TTY or NO_COLOR is set)
# -----------------------------------------------------------------------------
if [ -t 1 ] && [ -z "${NO_COLOR:-}" ]; then
    if command -v tput >/dev/null 2>&1; then
        _ac_cols=$(tput colors 2>/dev/null || echo 0)
    else
        _ac_cols=0
    fi
else
    _ac_cols=0
fi

if [ "${FORCE_COLOR:-}" != "" ] || [ "${_ac_cols}" -ge 8 ]; then
    C_RESET='\033[0m'
    C_BOLD='\033[1m'
    C_DIM='\033[2m'
    C_RED='\033[31m'
    C_GREEN='\033[32m'
    C_YELLOW='\033[33m'
    C_BLUE='\033[34m'
    C_MAGENTA='\033[35m'
    C_CYAN='\033[36m'
else
    C_RESET=''
    C_BOLD=''
    C_DIM=''
    C_RED=''
    C_GREEN=''
    C_YELLOW=''
    C_BLUE=''
    C_CYAN=''
fi

# Simple helpers for consistent colored output
function print_info()    { printf "%b\n" "${C_CYAN}$*${C_RESET}"; }
function print_warn()    { printf "%b\n" "${C_YELLOW}$*${C_RESET}"; }
function print_error()   { printf "%b\n" "${C_RED}$*${C_RESET}"; }
function print_success() { printf "%b\n" "${C_GREEN}$*${C_RESET}"; }
function print_skip()    { printf "%b\n" "${C_BLUE}$*${C_RESET}"; }
function print_header()  { printf "%b\n" "${C_BOLD}${C_CYAN}$*${C_RESET}"; }

# Module management menu definition
# Format: "key|short|description"
module_menu_items=(
    "search|s|Search for available modules"
    "install|i|Install one or more modules"
    "update|u|Update installed modules"
    "remove|r|Remove installed modules"
    "list|l|List installed modules"
    "help|h|Show detailed help"
    "quit|q|Close this menu"
)

# Menu command handler for module operations
function handle_module_command() {
    local key="$1"
    shift
    
    case "$key" in
        "search")
            inst_module_search "$@"
            ;;
        "install")
            inst_module_install "$@"
            ;;
        "update")
            inst_module_update "$@"
            ;;
        "remove")
            inst_module_remove "$@"
            ;;
        "list")
            inst_module_list "$@"
            ;;
        "help")
            inst_module_help
            ;;
        "quit")
            print_info "Exiting module manager..."
            return 0
            ;;
        *)
            print_error "Invalid option. Use 'help' to see available commands."
            return 1
            ;;
    esac
}

# Show detailed module help
function inst_module_help() {
    print_header "AzerothCore Module Manager Help"
    echo "==============================="
    echo ""
    echo "Usage:"
    echo "  ./acore.sh module                    # Interactive menu"
    echo "  ./acore.sh module search   [terms...]"
    echo "  ./acore.sh module install  [--all | modules...]"
    echo "  ./acore.sh module update   [--discard-changes] [--all | modules...]"
    echo "  ./acore.sh module remove   [modules...]"
    echo "  ./acore.sh module list              # List installed modules"
    echo ""
    echo "Options:"
    echo "  --discard-changes  Reset module repositories to a clean state before updating"
    echo ""
    echo "Module Specification Syntax:"
    echo "  name                    # Simple name (e.g., mod-transmog)"
    echo "  owner/name              # GitHub repository"
    echo "  name:branch             # Specific branch"
    echo "  name:branch:commit      # Specific commit"
    echo "  name:dirname@branch     # Custom directory name"
    echo "  https://github.com/...  # Full URL"
    echo ""
    echo "Examples:"
    echo "  ./acore.sh module install mod-transmog"
    echo "  ./acore.sh module install azerothcore/mod-transmog:develop"
    echo "  ./acore.sh module update --all"
    echo "  ./acore.sh module remove mod-transmog"
    echo ""
}

# List installed modules
function inst_module_list() {
    print_header "Installed Modules"
    echo "=================="
    local count=0
    while read -r repo_ref branch commit; do
        [[ -z "$repo_ref" ]] && continue
        count=$((count + 1))
        printf "  %s. %b (%s)%b\n" "$count" "${C_GREEN}${repo_ref}" "${branch}" "${C_RESET}"
        if [[ "$commit" != "-" ]]; then
            printf "      %bCommit:%b %s\n" "${C_DIM}" "${C_RESET}" "$commit"
        fi
    done < <(inst_mod_list_read)
    
    if [[ $count -eq 0 ]]; then
        print_warn "  No modules installed."
    fi
    echo ""
}

# Dispatcher for the unified `module` command.
# Usage: ./acore.sh module <search|install|update|remove> [args...]
#        ./acore.sh module                    # Interactive menu
function inst_module() {
    menu_run_with_items "MODULE MANAGER" handle_module_command -- "${module_menu_items[@]}" -- "$@"
    return $?
}

# =============================================================================
# Module Specification Parsing
# =============================================================================

# Parse a module spec with advanced syntax:
# - New syntax: repo[:dirname][@branch[:commit]]
#
# Examples:
#   "mod-transmog" -> uses default branch, directory name = mod-transmog
#   "mod-transmog:custom-dir" -> uses default branch, directory name = custom-dir
#   "mod-transmog@develop" -> uses develop branch, directory name = mod-transmog
#   "mod-transmog:custom-dir@develop:abc123" -> custom directory, develop branch, specific commit
#
# Output: "repo_ref owner name branch commit url dirname"
function inst_parse_module_spec() {
    local spec="$1"
    
    local dirname="" branch="" commit="" repo_part=""
    
    # Parse the new syntax: repo[:dirname][@branch[:commit]]
    
    # First, check if this is a URL (contains :// or starts with git@)
    local is_url=0
    if [[ "$spec" =~ :// ]] || [[ "$spec" =~ ^git@ ]]; then
        is_url=1
    fi
    
    # Parse directory and branch differently for URLs vs simple names
    local repo_with_branch="$spec"
    if [[ $is_url -eq 1 ]]; then
        # For URLs, look for :dirname pattern, but be careful about ports
        # Strategy: only match :dirname if it's clearly after the repository path
        
        # Look for :dirname patterns at the end, but not if it looks like a port
        if [[ "$spec" =~ ^(.*\.git):([^@/:]+)(@.*)?$ ]]; then
            # Repo ending with .git:dirname
            repo_with_branch="${BASH_REMATCH[1]}${BASH_REMATCH[3]}"
            dirname="${BASH_REMATCH[2]}"
        elif [[ "$spec" =~ ^(.*://[^/]+/[^:]*[^0-9]):([^@/:]+)(@.*)?$ ]]; then
            # URL with path ending in non-digit:dirname (avoid matching ports)
            repo_with_branch="${BASH_REMATCH[1]}${BASH_REMATCH[3]}"
            dirname="${BASH_REMATCH[2]}"
        fi
        # If no custom dirname found, repo_with_branch remains the original spec
    else
        # For simple names, use the original logic
        if [[ "$spec" =~ ^([^@:]+):([^@:]+)(@.*)?$ ]]; then
            repo_with_branch="${BASH_REMATCH[1]}${BASH_REMATCH[3]}"
            dirname="${BASH_REMATCH[2]}"
        fi
    fi
    
    # Now parse branch and commit from the repo part
    # Be careful not to confuse URL @ with branch @
    if [[ "$repo_with_branch" =~ :// ]]; then
        # For URLs, look for @ after the authority part
        if [[ "$repo_with_branch" =~ ^[^/]*//[^/]+/.*@([^:]+)(:(.+))?$ ]]; then
            # @ found in path part - treat as branch
            repo_part="${repo_with_branch%@*}"
            branch="${BASH_REMATCH[1]}"
            commit="${BASH_REMATCH[3]:-}"
        elif [[ "$repo_with_branch" =~ ^([^@]*@[^/]+/.*)@([^:]+)(:(.+))?$ ]]; then
            # @ found after URL authority @ - treat as branch
            repo_part="${BASH_REMATCH[1]}"
            branch="${BASH_REMATCH[2]}"
            commit="${BASH_REMATCH[4]:-}"
        else
            repo_part="$repo_with_branch"
        fi
    elif [[ "$repo_with_branch" =~ ^git@ ]]; then
        # Git SSH format - look for @ after the initial git@host: part
        if [[ "$repo_with_branch" =~ ^git@[^:]+:.*@([^:]+)(:(.+))?$ ]]; then
            repo_part="${repo_with_branch%@*}"
            branch="${BASH_REMATCH[1]}"
            commit="${BASH_REMATCH[3]:-}"
        else
            repo_part="$repo_with_branch"
        fi
    else
        # Non-URL format - use original logic
        if [[ "$repo_with_branch" =~ ^([^@]+)@([^:]+)(:(.+))?$ ]]; then
            repo_part="${BASH_REMATCH[1]}"
            branch="${BASH_REMATCH[2]}"
            commit="${BASH_REMATCH[4]:-}"
        else
            repo_part="$repo_with_branch"
        fi
    fi
    
    # Normalize repo reference and extract owner/name.
    local repo_ref owner name url owner_repo
    repo_ref="$repo_part"

    # If repo_ref is a URL, extract owner/name from path when possible
    if [[ "$repo_ref" =~ :// ]] || [[ "$repo_ref" =~ ^git@ ]]; then
        # Handle various URL formats
        local path_part=""
        if [[ "$repo_ref" =~ ^https?://[^/]+:?[0-9]*/(.+)$ ]]; then
            # HTTPS URL (with or without port)
            path_part="${BASH_REMATCH[1]}"
        elif [[ "$repo_ref" =~ ^ssh://.*@[^/]+:?[0-9]*/(.+)$ ]]; then
            # SSH URL with user@host:port/path format
            path_part="${BASH_REMATCH[1]}"
        elif [[ "$repo_ref" =~ ^ssh://[^@/]+:?[0-9]*/(.+)$ ]]; then
            # SSH URL with host:port/path format (no user@)
            path_part="${BASH_REMATCH[1]}"
        elif [[ "$repo_ref" =~ ^git@[^:]+:(.+)$ ]]; then
            # Git SSH format (git@host:path)
            path_part="${BASH_REMATCH[1]}"
        fi
        
        # Extract owner/name from path
        if [[ -n "$path_part" ]]; then
            # Remove .git suffix and any :dirname suffix
            path_part="${path_part%.git}"
            path_part="${path_part%:*}"
            
            if [[ "$path_part" == *"/"* ]]; then
                owner="$(echo "$path_part" | awk -F'/' '{print $(NF-1)}')"
                name="$(echo "$path_part" | awk -F'/' '{print $NF}')"
            else
                owner="unknown"
                name="$path_part"
            fi
        else
            owner="unknown"
            name="unknown"
        fi
    else
        owner_repo="$repo_ref"
        if [[ "$owner_repo" == *"/"* ]]; then
            owner="$(echo "$owner_repo" | cut -d'/' -f1)"
            name="$(echo "$owner_repo" | cut -d'/' -f2)"
        else
            owner="azerothcore"
            name="$owner_repo"
            repo_ref="$owner/$name"
        fi
    fi

    # Build URL only if repo_ref is not already a URL
    if [[ "$repo_ref" =~ :// ]] || [[ "$repo_ref" =~ ^git@ ]]; then
        url="$repo_ref"
    else
        url="https://github.com/${repo_ref}"
    fi

    # Use custom dirname if provided, otherwise default to module name
    if [ -z "$dirname" ]; then
        dirname="$name"
    fi

    echo "$repo_ref" "$owner" "$name" "${branch:--}" "${commit:--}" "$url" "$dirname"
}

# =============================================================================
# Cross-Format Module Recognition
# =============================================================================

# Extract owner/name from any repository reference for intelligent matching.
# This enables recognizing the same module regardless of specification format.
#
# Supported formats:
# - GitHub HTTPS: https://github.com/owner/name.git
# - GitHub SSH: git@github.com:owner/name.git
# - GitLab HTTPS: https://gitlab.com/owner/name.git
# - Owner/name: owner/name
# - Simple name: mod-name (assumes azerothcore namespace)
#
# Returns: "owner/name" format for consistent comparison
function inst_extract_owner_name {
    local repo_ref="$1"
    
    # For URLs, don't remove dirname suffix since : is part of the URL
    local base_ref="$repo_ref"
    if [[ ! "$repo_ref" =~ :// ]] && [[ ! "$repo_ref" =~ ^git@ ]]; then
        # Only remove dirname suffix for non-URL formats
        base_ref="${repo_ref%%:*}"
    fi
    
    # Handle various URL formats with possible ports
    if [[ "$base_ref" =~ ^https?://[^/]+:?[0-9]*/([^/]+)/([^/?]+) ]]; then
        # HTTPS URL format (with or without port) - matches github.com, gitlab.com, custom hosts
        local owner="${BASH_REMATCH[1]}"
        local name="${BASH_REMATCH[2]}"
        name="${name%:*}"    # Remove any :dirname suffix first
        name="${name%.git}"  # Then remove .git suffix if present
        echo "$owner/$name"
    elif [[ "$base_ref" =~ ^ssh://[^/]+:?[0-9]*/([^/]+)/([^/?]+) ]]; then
        # SSH URL format (with or without port)
        local owner="${BASH_REMATCH[1]}"
        local name="${BASH_REMATCH[2]}"
        name="${name%:*}"    # Remove any :dirname suffix first
        name="${name%.git}"  # Then remove .git suffix if present
        echo "$owner/$name"
    elif [[ "$base_ref" =~ ^git@[^:]+:([^/]+)/([^/?]+) ]]; then
        # Git SSH format (git@host:owner/repo)
        local owner="${BASH_REMATCH[1]}"
        local name="${BASH_REMATCH[2]}"
        name="${name%:*}"    # Remove any :dirname suffix first
        name="${name%.git}"  # Then remove .git suffix if present
        echo "$owner/$name"
    elif [[ "$base_ref" =~ ^[^/]+/[^/]+$ ]]; then
        # Format: owner/name (check after URL patterns)
        echo "$base_ref"
    elif [[ "$base_ref" =~ ^(mod-|module-)?([a-zA-Z0-9-]+)$ ]]; then
        # Simple module name, assume azerothcore namespace
        local modname="${BASH_REMATCH[2]}"
        if [[ "$base_ref" == mod-* ]]; then
            modname="$base_ref"
        else
            modname="mod-$modname"
        fi
        echo "azerothcore/$modname"
    else
        # Unknown format, return as-is
        echo "$base_ref"
    fi
}

# =============================================================================
# Module List Management
# =============================================================================

# Returns path to modules list file (configurable via MODULES_LIST_FILE).
function inst_modules_list_path() {
    local path="${MODULES_LIST_FILE:-"$AC_PATH_ROOT/conf/modules.list"}"
    echo "$path"
}

# Ensure the modules list file exists and its directory is created.
function inst_mod_list_ensure() {
    local file
    file="$(inst_modules_list_path)"
    mkdir -p "$(dirname "$file")"
    [ -f "$file" ] || touch "$file"
}

# Read modules list into stdout as triplets: "name branch commit"
# Skips comments (# ...) and blank lines.
function inst_mod_list_read() {
    local file
    file="$(inst_modules_list_path)"
    [ -f "$file" ] || return 0
    # shellcheck disable=SC2013
    while IFS= read -r line; do
        [[ -z "$line" || "$line" =~ ^[[:space:]]*# ]] && continue
        echo "$line"
    done < "$file"
}

# Check whether a module spec matches the exclusion list.
# - Reads space/newline separated items from env var MODULES_EXCLUDE_LIST
# - Supports cross-format matching via inst_extract_owner_name
# Returns 0 if excluded, 1 otherwise.
function inst_mod_is_excluded() {
    local spec="$1"
    local target_owner_name
    target_owner_name=$(inst_extract_owner_name "$spec")

    # No exclusions configured
    if [[ -z "${MODULES_EXCLUDE_LIST:-}" ]]; then
        return 1
    fi

    # Split on default IFS (space, tab, newline)
    local items=()
    # Use mapfile to split MODULES_EXCLUDE_LIST on newlines; fallback to space if no newlines
    if [[ "${MODULES_EXCLUDE_LIST}" == *$'\n'* ]]; then
        mapfile -t items <<< "${MODULES_EXCLUDE_LIST}"
    else
        read -r -a items <<< "${MODULES_EXCLUDE_LIST}"
    fi

    local it it_owner
    for it in "${items[@]}"; do
        [[ -z "$it" ]] && continue
        it_owner=$(inst_extract_owner_name "$it")
        if [[ "$it_owner" == "$target_owner_name" ]]; then
            return 0
        fi
    done
    return 1
}

# Add or update an entry in the list: repo_ref branch commit
# Removes any existing entries with the same owner/name to avoid duplicates
function inst_mod_list_upsert() {
    local repo_ref="$1"; shift
    local branch="$1"; shift
    local commit="$1"; shift
    local target_owner_name
    target_owner_name=$(inst_extract_owner_name "$repo_ref")
    
    inst_mod_list_ensure
    local file tmp tmp_uns tmp_sorted
    file="$(inst_modules_list_path)"
    tmp="${file}.tmp"
    tmp_uns="${file}.unsorted"
    tmp_sorted="${file}.sorted"

    # Build a list without existing duplicates
    : > "$tmp_uns"
    while read -r existing_ref existing_branch existing_commit; do
        [[ -z "$existing_ref" ]] && continue
        local existing_owner_name
        existing_owner_name=$(inst_extract_owner_name "$existing_ref")
        if [[ "$existing_owner_name" != "$target_owner_name" ]]; then
            echo "$existing_ref $existing_branch $existing_commit" >> "$tmp_uns"
        fi
    done < <(inst_mod_list_read)
    # Add/replace the new entry (preserving original repo_ref format)
    echo "$repo_ref $branch $commit" >> "$tmp_uns"

    # Create key-prefixed lines to sort by normalized owner/name
    : > "$tmp"
    while read -r r b c; do
        [[ -z "$r" ]] && continue
        local k
        k=$(inst_extract_owner_name "$r")
        printf "%s\t%s %s %s\n" "$k" "$r" "$b" "$c" >> "$tmp"
    done < "$tmp_uns"

    # Stable sort by key and strip the key
    LC_ALL=C sort -t $'\t' -k1,1 -s "$tmp" | cut -f2- > "$tmp_sorted" && mv "$tmp_sorted" "$file"
    rm -f "$tmp" "$tmp_uns" "$tmp_sorted" 2>/dev/null || true
}

# Remove an entry from the list by matching owner/name.
# This allows removing modules regardless of how they were specified (URL vs owner/name)
function inst_mod_list_remove() {
    local repo_ref="$1"
    local target_owner_name
    target_owner_name=$(inst_extract_owner_name "$repo_ref")
    
    local file
    file="$(inst_modules_list_path)"
    [ -f "$file" ] || return 0
    
    local tmp_uns="${file}.unsorted"
    local tmp="${file}.tmp"
    local tmp_sorted="${file}.sorted"

    # Keep only lines where owner/name doesn't match
    : > "$tmp_uns"
    while read -r existing_ref existing_branch existing_commit; do
        [[ -z "$existing_ref" ]] && continue
        local existing_owner_name
        existing_owner_name=$(inst_extract_owner_name "$existing_ref")
        if [[ "$existing_owner_name" != "$target_owner_name" ]]; then
            echo "$existing_ref $existing_branch $existing_commit" >> "$tmp_uns"
        fi
    done < <(inst_mod_list_read)

    # Key-prefix and sort for deterministic alphabetical order
    : > "$tmp"
    while read -r r b c; do
        [[ -z "$r" ]] && continue
        local k
        k=$(inst_extract_owner_name "$r")
        printf "%s\t%s %s %s\n" "$k" "$r" "$b" "$c" >> "$tmp"
    done < "$tmp_uns"

    LC_ALL=C sort -t $'\t' -k1,1 -s "$tmp" | cut -f2- > "$tmp_sorted" && mv "$tmp_sorted" "$file"
    rm -f "$tmp" "$tmp_uns" "$tmp_sorted" 2>/dev/null || true
}

# Check if a module is already installed by comparing owner/name
# Returns the existing repo_ref if found, empty if not found
function inst_mod_is_installed() {
    local spec="$1"
    local target_owner_name
    target_owner_name=$(inst_extract_owner_name "$spec")
    
    # Use a different approach: read into a variable first, then process
    local modules_content
    modules_content=$(inst_mod_list_read)
    
    # Process each line
    while IFS= read -r line; do
        [[ -z "$line" ]] && continue
        read -r repo_ref branch commit <<< "$line"
        local existing_owner_name
        existing_owner_name=$(inst_extract_owner_name "$repo_ref")
        if [[ "$existing_owner_name" == "$target_owner_name" ]]; then
            echo "$repo_ref"  # Return the existing entry
            return 0
        fi
    done <<< "$modules_content"
    
    return 1
}

# Discard local changes from a module repository to guarantee a clean update.
function inst_module_reset_repo() {
    local repo_ref="$1"
    local dirname="$2"
    local repo_path="$J_PATH_MODULES/$dirname"

    if [ ! -d "$repo_path" ]; then
        print_error "[$repo_ref] Cannot discard changes; path not found ($repo_path)."
        return 1
    fi

    if [ ! -d "$repo_path/.git" ]; then
        print_error "[$repo_ref] Cannot discard changes; $repo_path is not a git repository."
        return 1
    fi

    print_warn "[$repo_ref] Discarding local changes (--discard-changes)."

    if ! git -C "$repo_path" reset --hard >/dev/null 2>&1; then
        print_error "[$repo_ref] Failed to reset repository at $repo_path."
        return 1
    fi

    if ! git -C "$repo_path" clean -fd >/dev/null 2>&1; then
        print_error "[$repo_ref] Failed to remove untracked files from $repo_path."
        return 1
    fi

    return 0
}

# =============================================================================
# Conflict Detection and Validation
# =============================================================================

# Check for module directory conflicts with helpful error messages
function inst_check_module_conflict {
    local dirname="$1"
    local repo_ref="$2"
    
    if [ -d "$J_PATH_MODULES/$dirname" ]; then
            print_error "Error: Directory '$dirname' already exists."
            print_warn "Possible solutions:"
            echo "  1. Use a different directory name: $repo_ref:my-custom-name"
            echo "  2. Remove the existing directory first"
            echo "  3. Use the update command if this is the same module"
            return 1
    fi
    return 0
}

# =============================================================================
# Module Operations
# =============================================================================

# Get version and branch information from acore-module.json
function inst_getVersionBranch() {
    local res="master"
    local v="not-defined"
    local MODULE_MAJOR=0
    local MODULE_MINOR=0
    local MODULE_PATCH=0
    local MODULE_SPECIAL=0;
    local ACV_MAJOR=0
    local ACV_MINOR=0
    local ACV_PATCH=0
    local ACV_SPECIAL=0;
    local curldata=$(curl -f --silent -H 'Cache-Control: no-cache' "$1" || echo "{}")
    local parsed=$(echo "$curldata" | "$AC_PATH_DEPS/jsonpath/JSONPath.sh" -b '$.compatibility.*.[version,branch]')

    semverParseInto "$ACORE_VERSION" ACV_MAJOR ACV_MINOR ACV_PATCH ACV_SPECIAL

    if [[ ! -z "$parsed" ]]; then
        readarray -t vers < <(echo "$parsed")
        local idx
        res="none"
        # since we've the pair version,branch alternated in not associative and one-dimensional
        # array, we've to simulate the association with length/2 trick
        for idx in $(seq 0 $((${#vers[*]}/2-1))); do
            semverParseInto "${vers[idx*2]}" MODULE_MAJOR MODULE_MINOR MODULE_PATCH MODULE_SPECIAL
            if [[ $MODULE_MAJOR -eq $ACV_MAJOR && $MODULE_MINOR -le $ACV_MINOR ]]; then
                res="${vers[idx*2+1]}"
                v="${vers[idx*2]}"
            fi
        done
    fi

    echo "$v" "$res"
}

# Search for modules in the AzerothCore repository
function inst_module_search {
    # Accept 0..N search terms; if none provided, prompt the user.
    local terms=("$@")
    if [ ${#terms[@]} -eq 0 ]; then
        echo "Type what to search (blank for full list)"
        read -p "Insert name(s): " _line
        if [ -n "$_line" ]; then
            read -r -a terms <<< "$_line"
        fi
    fi

    local CATALOG_URL="https://www.azerothcore.org/data/catalogue.json"

    print_header "Searching ${terms[*]}..."
    echo ""

    # Build candidate list from catalogue (full_name = owner/repo)
    local MODS=()
    if command -v jq >/dev/null 2>&1; then
        mapfile -t MODS < <(curl --silent -L "$CATALOG_URL" \
            | jq -r '
                [ .. | objects
                  | select(.full_name and .topics)
                  | select(.topics | index("azerothcore-module"))
                ]
                | unique_by(.full_name)
                | sort_by(.stargazers_count // 0) | reverse
                | .[].full_name
            ')
    else
        # Fallback without jq: best-effort extraction of owner/repo
        mapfile -t MODS < <(curl --silent -L "$CATALOG_URL" \
            | grep -oE '\"full_name\"\\s*:\\s*\"[^\"/[:space:]]+/[^\"[:space:]]+\"' \
            | sed -E 's/.*\"full_name\"\\s*:\\s*\"([^\"]+)\".*/\\1/' \
            | sort -u)
    fi

    # Local AND filter on user terms (case-insensitive) against full_name
    if (( ${#terms[@]} > 0 )); then
        local filtered=()
        local item
        for item in "${MODS[@]}"; do
            local keep=1
            local lower="${item,,}"
            local t
            for t in "${terms[@]}"; do
                [ -z "$t" ] && continue
                if [[ "$lower" != *"${t,,}"* ]]; then
                    keep=0; break
                fi
            done
            (( keep )) && filtered+=("$item")
        done
        MODS=("${filtered[@]}")
    fi

    if (( ${#MODS[@]} == 0 )); then
        echo "No results."
        echo ""
        return 0
    fi

    local idx=0
    while (( ${#MODS[@]} > idx )); do
        local mod_full="${MODS[idx++]}"     # owner/repo
        local mod="${mod_full##*/}"         # repo name only for display
        read v b < <(inst_getVersionBranch "https://raw.githubusercontent.com/${mod_full}/master/acore-module.json")

        if [[ "$b" != "none" ]]; then
            printf "%b -> %b (tested with AC version: %s)%b\n" "" "${C_GREEN}${mod}${C_RESET}" "$v" ""
        else
            printf "%b -> %b %b(NOTE: The module latest tested AC revision is Unknown)%b\n" "" "${C_GREEN}${mod}${C_RESET}" "${C_YELLOW}" "${C_RESET}"
        fi
    done

    echo ""
    echo ""
}


# Install one or more modules with advanced syntax support
function inst_module_install {
    # Support multiple modules and the --all flag; prompt if none specified.
    local args=("$@")
    local use_all=false
    if [ ${#args[@]} -gt 0 ] && { [ "${args[0]}" = "--all" ] || [ "${args[0]}" = "-a" ]; }; then
        use_all=true
        shift || true
    fi

    local modules=("$@")

    print_header "Installing modules: ${modules[*]}"

    if $use_all; then
        # Install all modules from the list (respecting recorded branch and commit).
        inst_mod_list_ensure
        local line repo_ref branch commit url owner modname dirname

        # First pass: detect duplicate target directories (flat structure)
        declare -A _seen _first
        local dup_error=0
        while read -r repo_ref branch commit; do
            [ -z "$repo_ref" ] && continue
            # Skip excluded modules when checking duplicates
            if inst_mod_is_excluded "$repo_ref"; then
                continue
            fi
            parsed_output=$(inst_parse_module_spec "$repo_ref")
            IFS=' ' read -r _ owner modname _ _ url dirname <<< "$parsed_output"
            # dirname defaults to repo name; flat install path uses dirname only
            if [[ -n "${_seen[$dirname]:-}" ]]; then
                print_error "Error: duplicate module target directory '$dirname' detected in modules.list:"
                echo " - ${_first[$dirname]}"
                echo " - ${repo_ref}"
                print_warn "Use a custom folder name to disambiguate, e.g.: ${repo_ref}:$dirname-alt"
                dup_error=1
            else
                _seen[$dirname]=1
                _first[$dirname]="$repo_ref"
            fi
        done < <(inst_mod_list_read)
        if [[ "$dup_error" -ne 0 ]]; then
            return 1
        fi

        # Second pass: install in flat modules directory (no owner subfolders)
        while read -r repo_ref branch commit; do
            [ -z "$repo_ref" ] && continue
            # Skip excluded entries during installation
            if inst_mod_is_excluded "$repo_ref"; then
                print_warn "[$repo_ref] Excluded by MODULES_EXCLUDE_LIST (skipping)."
                continue
            fi
            parsed_output=$(inst_parse_module_spec "$repo_ref")
            IFS=' ' read -r _ owner modname _ _ url dirname <<< "$parsed_output"

            if [ -d "$J_PATH_MODULES/$dirname" ]; then
                print_skip "[$repo_ref] Already installed (skipping)."
                continue
            fi

            if Joiner:add_repo "$url" "$dirname" "$branch" ""; then
                # Checkout the recorded commit if present
                if [ -n "$commit" ]; then
                    git -C "$J_PATH_MODULES/$dirname" fetch --all --quiet || true
                    if git -C "$J_PATH_MODULES/$dirname" rev-parse --verify "$commit" >/dev/null 2>&1; then
                        git -C "$J_PATH_MODULES/$dirname" checkout --quiet "$commit"
                    fi
                fi
                local curCommit
                curCommit=$(git -C "$J_PATH_MODULES/$dirname" rev-parse HEAD 2>/dev/null || echo "")
                inst_mod_list_upsert "$repo_ref" "$branch" "$curCommit"
                print_success "[$repo_ref] Installed."
            else
                print_error "[$repo_ref] Install failed."
                exit 1;
            fi
        done < <(inst_mod_list_read)
    else
        # Install specified modules; prompt if none specified.
        if [ ${#modules[@]} -eq 0 ]; then
            echo "Type the name(s) of the module(s) to install"
            read -p "Insert name(s): " _line
            read -r -a modules <<< "$_line"
        fi

    local spec name override_branch override_commit v b def curCommit existing_repo_ref dirname
        for spec in "${modules[@]}"; do
            [ -z "$spec" ] && continue
            
            # Check if module is already installed (by owner/name matching)
            existing_repo_ref=$(inst_mod_is_installed "$spec" || true)
            if [ -n "$existing_repo_ref" ]; then
                print_skip "[$spec] Already installed as [$existing_repo_ref] (skipping)."
                continue
            fi
            
            parsed_output=$(inst_parse_module_spec "$spec")
            IFS=' ' read -r repo_ref owner modname override_branch override_commit url dirname <<< "$parsed_output"
            [ -z "$repo_ref" ] && continue

            # Check for directory conflicts with custom directory names
            if ! inst_check_module_conflict "$dirname" "$repo_ref"; then
                continue
            fi

            # override_branch takes precedence; otherwise consult acore-module.json on azerothcore unless repo_ref contains owner or URL
            if [ -n "$override_branch" ] && [ "$override_branch" != "-" ]; then
                b="$override_branch"
            else
                # For GitHub repositories, use raw.githubusercontent.com to check acore-module.json
                if [[ "$url" =~ github.com ]] || [[ "$repo_ref" =~ ^[^/]+/[^/]+$ ]]; then
                    read v b < <(inst_getVersionBranch "https://raw.githubusercontent.com/${owner}/${modname}/master/acore-module.json")
                else
                    # Unknown host: try the repository URL as-is (may fail)
                    read v b < <(inst_getVersionBranch "${url}/master/acore-module.json")
                fi
                if [[ "$v" == "none" || "$v" == "not-defined" || "$b" == "none" ]]; then
                    def="$(inst_get_default_branch "$repo_ref")"
                    print_warn "Warning: $repo_ref has no compatible acore-module.json; installing from branch '$def' (latest commit)."
                    b="$def"
                fi
            fi

            # Use flat directory structure with custom directory name
            if [ -d "$J_PATH_MODULES/$dirname" ]; then
                print_skip "[$repo_ref] Already installed (skipping)."
                curCommit=$(git -C "$J_PATH_MODULES/$dirname" rev-parse HEAD 2>/dev/null || echo "")
                inst_mod_list_upsert "$repo_ref" "$b" "$curCommit"
                continue
            fi

            if Joiner:add_repo "$url" "$dirname" "$b" ""; then
                # If a commit was provided, try to checkout it
                if [ -n "$override_commit" ] && [ "$override_commit" != "-" ]; then
                    git -C "$J_PATH_MODULES/$dirname" fetch --all --quiet || true
                    if git -C "$J_PATH_MODULES/$dirname" rev-parse --verify "$override_commit" >/dev/null 2>&1; then
                        git -C "$J_PATH_MODULES/$dirname" checkout --quiet "$override_commit"
                    else
                        print_warn "[$repo_ref] provided commit '$override_commit' not found; staying on branch '$b' HEAD."
                    fi
                fi
                curCommit=$(git -C "$J_PATH_MODULES/$dirname" rev-parse HEAD 2>/dev/null || echo "")
                inst_mod_list_upsert "$repo_ref" "$b" "$curCommit"
                print_success "[$repo_ref] Installed in '$dirname'. Please re-run compiling and db assembly."
            else
                print_error "[$repo_ref] Install failed or module not found"
                exit 1;
            fi
        done
    fi

    echo ""
    echo ""
}

# Update one or more modules
function inst_module_update {
    local modules=()
    local use_all=false
    local discard_changes=false
    local had_errors=0

    while [[ $# -gt 0 ]]; do
        case "$1" in
            --help|-h)
                inst_module_help
                return 0
                ;;
            --all|-a)
                use_all=true
                ;;
            --discard-changes|--reset|-r)
                discard_changes=true
                ;;
            --)
                shift || true
                while [[ $# -gt 0 ]]; do
                    modules+=("$1")
                    shift || true
                done
                break
                ;;
            *)
                modules+=("$1")
                ;;
        esac
        shift || true
    done

    if $use_all; then
        local repo_ref branch commit owner modname url dirname newCommit
        local parsed_output
        while read -r repo_ref branch commit; do
            [ -z "$repo_ref" ] && continue
            if inst_mod_is_excluded "$repo_ref"; then
                print_warn "[$repo_ref] Excluded by MODULES_EXCLUDE_LIST (skipping)."
                continue
            fi

            parsed_output=$(inst_parse_module_spec "$repo_ref")
            IFS=' ' read -r _ owner modname _ _ url dirname <<< "$parsed_output"

            dirname="${dirname:-$modname}"
            if [ ! -d "$J_PATH_MODULES/$dirname/" ]; then
                print_skip "[$repo_ref] Not installed locally, skipping."
                continue
            fi

            if $discard_changes; then
                if ! inst_module_reset_repo "$repo_ref" "$dirname"; then
                    had_errors=1
                    continue
                fi
            fi

            if Joiner:upd_repo "$url" "$dirname" "$branch" ""; then
                newCommit=$(git -C "$J_PATH_MODULES/$dirname" rev-parse HEAD 2>/dev/null || echo "")
                inst_mod_list_upsert "$repo_ref" "$branch" "$newCommit"
                print_success "[$repo_ref] Updated to latest commit on '$branch'."
            else
                print_error "[$repo_ref] Cannot update"
                had_errors=1
            fi
        done < <(inst_mod_list_read)
    else
        if [ ${#modules[@]} -eq 0 ]; then
            echo "Type the name(s) of the module(s) to update"
            read -p "Insert name(s): " _line
            read -r -a modules <<< "$_line"
        fi

        local spec repo_ref override_branch override_commit owner modname url dirname v b branch def newCommit
        local parsed_output
        for spec in "${modules[@]}"; do
            [ -z "$spec" ] && continue
            parsed_output=$(inst_parse_module_spec "$spec")
            IFS=' ' read -r repo_ref owner modname override_branch override_commit url dirname <<< "$parsed_output"

            dirname="${dirname:-$modname}"
            if [ -d "$J_PATH_MODULES/$dirname/" ]; then
                b=""
                if [ -n "$override_branch" ] && [ "$override_branch" != "-" ]; then
                    b="$override_branch"
                else
                    if [[ "$url" =~ github.com ]]; then
                        read v b < <(inst_getVersionBranch "https://raw.githubusercontent.com/${owner}/${modname}/master/acore-module.json")
                    else
                        read v b < <(inst_getVersionBranch "${url}/master/acore-module.json")
                    fi
                    if [[ "$v" == "none" || "$v" == "not-defined" || "$b" == "none" ]]; then
                        if branch=$(git -C "$J_PATH_MODULES/$dirname" rev-parse --abbrev-ref HEAD 2>/dev/null); then
                            print_warn "Warning: $repo_ref has no compatible acore-module.json; updating current branch '$branch'."
                            b="$branch"
                        else
                            def="$(inst_get_default_branch "$repo_ref")"
                            print_warn "Warning: $repo_ref has no compatible acore-module.json and no git branch detected; updating default branch '$def'."
                            b="$def"
                        fi
                    fi
                fi

                if $discard_changes; then
                    if ! inst_module_reset_repo "$repo_ref" "$dirname"; then
                        had_errors=1
                        continue
                    fi
                fi

                if Joiner:upd_repo "$url" "$dirname" "$b" ""; then
                    newCommit=$(git -C "$J_PATH_MODULES/$dirname" rev-parse HEAD 2>/dev/null || echo "")
                    inst_mod_list_upsert "$repo_ref" "$b" "$newCommit"
                    print_success "[$repo_ref] Done, please re-run compiling and db assembly"
                else
                    print_error "[$repo_ref] Cannot update"
                    had_errors=1
                fi
            else
                print_error "[$repo_ref] Cannot update! Path doesn't exist ($J_PATH_MODULES/$dirname/)"
                had_errors=1
            fi
        done
    fi

    echo ""
    echo ""

    if [ "$had_errors" -ne 0 ]; then
        return 1
    fi
    return 0
}

# Remove one or more modules
function inst_module_remove {
    # Support multiple modules; prompt if none specified.
    local modules=("$@")
    if [ ${#modules[@]} -eq 0 ]; then
        echo "Type the name(s) of the module(s) to remove"
        read -p "Insert name(s): " _line
        read -r -a modules <<< "$_line"
    fi

    local spec repo_ref owner modname url override_branch override_commit dirname
    for spec in "${modules[@]}"; do
        [ -z "$spec" ] && continue
        parsed_output=$(inst_parse_module_spec "$spec")
        IFS=' ' read -r repo_ref owner modname override_branch override_commit url dirname <<< "$parsed_output"
        [ -z "$repo_ref" ] && continue
        
        dirname="${dirname:-$modname}"
        if Joiner:remove "$dirname" ""; then
            inst_mod_list_remove "$repo_ref"
            print_success "[$repo_ref] Done, please re-run compiling"
        else
            print_error "[$repo_ref] Cannot remove"
        fi
    done

    echo ""
    echo ""
}
