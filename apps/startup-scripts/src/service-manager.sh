#!/usr/bin/env bash

# AzerothCore Service Setup
# A unified interface for managing AzerothCore services with PM2 or systemd
# This script provides commands to create, update, delete, and manage server instances

set -euo pipefail  # Strict error handling

# Script location
CURRENT_PATH="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

SCRIPT_DIR="$CURRENT_PATH"

ROOT_DIR="$(cd "$CURRENT_PATH/../../.." && pwd)"

# Configuration directory (can be overridden with AC_SERVICE_CONFIG_DIR)
CONFIG_DIR="${AC_SERVICE_CONFIG_DIR:-${XDG_CONFIG_HOME:-$HOME/.config}/azerothcore/services}"
REGISTRY_FILE="$CONFIG_DIR/service_registry.json"
export AC_SERVICE_CONFIG_DIR="${AC_SERVICE_CONFIG_DIR:-$CONFIG_DIR}"

# Default values for variables that might be loaded from config files
# This prevents "unbound variable" errors when sourcing configuration files
RUN_ENGINE_CONFIG_FILE="${RUN_ENGINE_CONFIG_FILE:-}"
SESSION_MANAGER="${SESSION_MANAGER:-}"
SESSION_NAME="${SESSION_NAME:-}"
BINPATH="${BINPATH:-}"
SERVERBIN="${SERVERBIN:-}"
CONFIG="${CONFIG:-}"
RESTART_POLICY="${RESTART_POLICY:-}"
GDB_ENABLED="${GDB_ENABLED:-}"
SERVER_CONFIG="${SERVER_CONFIG:-}"

# Colors for output
readonly YELLOW='\033[1;33m'
readonly GREEN='\033[0;32m'
readonly RED='\033[0;31m'
readonly BLUE='\033[0;34m'
readonly NC='\033[0m' # No Color

# Create config directory if it doesn't exist
mkdir -p "$CONFIG_DIR"

# Initialize registry if it doesn't exist
if [ ! -f "$REGISTRY_FILE" ]; then
    echo "[]" > "$REGISTRY_FILE"
fi

# Path conversion utilities for portability
# When AC_SERVICE_CONFIG_DIR (hence CONFIG_DIR) is set, always store paths
# relative to it. Resolve relative paths back against CONFIG_DIR.
function make_path_relative() {
    local input="$1"

    # Pass through empty or non-absolute inputs
    if [ -z "$input" ] || [[ ! "$input" = /* ]]; then
        echo "$input"
        return
    fi

    # If AC_SERVICE_CONFIG_DIR is explicitly set, check if path is under it
    if [ -n "${AC_SERVICE_CONFIG_DIR:-}" ]; then
        local config_dir_abs
        config_dir_abs="$(realpath -m "$AC_SERVICE_CONFIG_DIR" 2>/dev/null || echo "$AC_SERVICE_CONFIG_DIR")"
        local rel_path=""

        if command -v realpath >/dev/null 2>&1; then
            rel_path="$(realpath --relative-to="$config_dir_abs" "$input" 2>/dev/null || true)"
            if [ -z "$rel_path" ]; then
                rel_path="$(realpath -m --relative-to="$config_dir_abs" "$input" 2>/dev/null || true)"
            fi
        fi

        if [ -z "$rel_path" ] && command -v python3 >/dev/null 2>&1; then
            rel_path="$(python3 -c 'import os,sys; print(os.path.relpath(sys.argv[1], sys.argv[2]))' "$input" "$config_dir_abs" 2>/dev/null || true)"
        fi

        if [ -n "$rel_path" ]; then
            echo "$rel_path"
            return
        fi
    fi

    # If not under AC_SERVICE_CONFIG_DIR or AC_SERVICE_CONFIG_DIR not set, return absolute path unchanged
    echo "$input"
}

function make_path_absolute() {
    local input="$1"

    # Already absolute
    if [[ "$input" = /* ]]; then
        echo "$input"
        return
    fi

    # Resolve relative paths against AC_SERVICE_CONFIG_DIR when explicitly set
    if [ -n "${AC_SERVICE_CONFIG_DIR:-}" ] && [ -n "$input" ]; then
        local config_dir_abs
        config_dir_abs="$(realpath "$AC_SERVICE_CONFIG_DIR" 2>/dev/null || echo "$AC_SERVICE_CONFIG_DIR")"
        # Join and normalize; do not require the target to exist
        realpath -m "$config_dir_abs/$input" 2>/dev/null || echo "$config_dir_abs/$input"
        return
    fi

    # Fallback: try to normalize relative to current directory
    realpath -m "$input" 2>/dev/null || echo "$input"
}

# Tokenize a shell command string without executing it. Supports basic quoting
# and escaping rules so paths with spaces remain intact.
# Serialize a command definition (binary + args) to JSON while converting paths
# to be relative to CONFIG_DIR when possible.
function serialize_exec_definition() {
    local command_path="$1"
    shift
    local -a args=("$@")
    local rel_command="$command_path"

    if [[ -n "$command_path" ]]; then
        rel_command="$(make_path_relative "$command_path")"
    fi

    local -a rel_args=()
    local arg
    for arg in "${args[@]}"; do
        if [[ "$arg" == /* ]]; then
            rel_args+=("$(make_path_relative "$arg")")
        else
            rel_args+=("$arg")
        fi
    done

    local args_json
    args_json=$(printf '%s\0' "${rel_args[@]}" | jq -R -s 'split("\u0000")[:-1]')

    jq -n --arg command "$rel_command" --argjson args "$args_json" '{command: $command, args: $args}'
}

# Combine command + args into a shell-safe string suitable for pm2/systemd
# ExecStart lines. Each token is bash-quoted to preserve spaces.
function render_exec_command() {
    local command_path="$1"
    shift
    local -a args=("$@")
    local parts=()
    local token

    parts+=("$(printf '%q' "$command_path")")
    for token in "${args[@]}"; do
        parts+=("$(printf '%q' "$token")")
    done

    (IFS=' '; printf '%s' "${parts[*]}")
}

# Check dependencies
check_dependencies() {
    command -v jq >/dev/null 2>&1 || { 
        echo -e "${RED}Error: jq is required but not installed. Please install jq package.${NC}"
        exit 1
    }
}

# Registry management functions
function add_service_to_registry() {
    local service_name="$1"
    local provider="$2"
    local service_type="$3"
    local bin_path="$4"
    local args="$5"
    local systemd_type="$6"
    local restart_policy="$7"
    local session_manager="$8"
    local gdb_enabled="$9"
    local pm2_opts="${10}"
    local server_config="${11}"
    local exec_definition="${12:-}" # JSON payload describing command + args

    # Convert paths to relative if possible for portability
    local relative_bin_path="$(make_path_relative "$bin_path")"
    
    # Convert server_config to relative if possible for portability  
    local relative_server_config=""
    if [ -n "$server_config" ] && [ "$server_config" != "null" ]; then
        relative_server_config="$(make_path_relative "$server_config")"
    else
        relative_server_config="$server_config"
    fi

    # Remove any existing entry with the same service name to avoid duplicates
    local tmp_file
    tmp_file=$(mktemp)
    jq --arg name "$service_name" 'map(select(.name != $name))' "$REGISTRY_FILE" > "$tmp_file" && mv "$tmp_file" "$REGISTRY_FILE"

    # Add the new entry to the registry
    tmp_file=$(mktemp)
    local exec_json_payload="null"
    if [ -n "$exec_definition" ]; then
        exec_json_payload="$exec_definition"
    fi
    jq --arg name "$service_name" \
       --arg provider "$provider" \
       --arg type "$service_type" \
       --arg bin_path "$relative_bin_path" \
       --arg args "$args" \
       --arg created "$(date -Iseconds)" \
       --arg systemd_type "$systemd_type" \
       --arg restart_policy "$restart_policy" \
       --arg session_manager "$session_manager" \
       --arg gdb_enabled "$gdb_enabled" \
       --arg pm2_opts "$pm2_opts" \
       --arg server_config "$relative_server_config" \
       --argjson exec "$exec_json_payload" \
       '. += [{"name": $name, "provider": $provider, "type": $type, "bin_path": $bin_path, "exec": $exec, "args": $args, "created": $created, "status": "active", "systemd_type": $systemd_type, "restart_policy": $restart_policy, "session_manager": $session_manager, "gdb_enabled": $gdb_enabled, "pm2_opts": $pm2_opts, "server_config": $server_config}]' \
       "$REGISTRY_FILE" > "$tmp_file" && mv "$tmp_file" "$REGISTRY_FILE"

    echo -e "${GREEN}Service '$service_name' added to registry${NC}"
}

function remove_service_from_registry() {
    local service_name="$1"
    
    if [ -f "$REGISTRY_FILE" ]; then
        local tmp_file
        tmp_file=$(mktemp)
        jq --arg name "$service_name" \
           'map(select(.name != $name))' \
           "$REGISTRY_FILE" > "$tmp_file" && mv "$tmp_file" "$REGISTRY_FILE"
        echo -e "${GREEN}Service '$service_name' removed from registry${NC}"
    fi
}

function restore_missing_services() {
    echo -e "${BLUE}Checking for missing services...${NC}"
    
    if [ ! -f "$REGISTRY_FILE" ] || [ ! -s "$REGISTRY_FILE" ]; then
        echo -e "${YELLOW}No services registry found or empty${NC}"
        return 0
    fi
    
    local missing_services=()
    local services_count
    services_count=$(jq length "$REGISTRY_FILE")
    
    if [ "$services_count" -eq 0 ]; then
        echo -e "${YELLOW}No services registered${NC}"
        return 0
    fi
    
    echo -e "${BLUE}Found $services_count registered services. Checking status...${NC}"
    
    # Check each service
    for i in $(seq 0 $((services_count-1))); do
        local service=$(jq -r ".[$i]" "$REGISTRY_FILE")
        local name=$(echo "$service" | jq -r '.name')
        local provider=$(echo "$service" | jq -r '.provider') 
        local service_type=$(echo "$service" | jq -r '.type')
        local bin_path_raw=$(echo "$service" | jq -r '.bin_path // "unknown"')
        local args=$(echo "$service" | jq -r '.args // ""')
        local status=$(echo "$service" | jq -r '.status // "active"')
        local systemd_type=$(echo "$service" | jq -r '.systemd_type // "--user"')
        local restart_policy=$(echo "$service" | jq -r '.restart_policy // "always"')
        local session_manager=$(echo "$service" | jq -r '.session_manager // "none"')
        local gdb_enabled=$(echo "$service" | jq -r '.gdb_enabled // "0"')
        local pm2_opts=$(echo "$service" | jq -r '.pm2_opts // ""')
        local server_config_raw=$(echo "$service" | jq -r '.server_config // ""')
        
        # Convert paths back to absolute for operation
        local bin_path="$(make_path_absolute "$bin_path_raw")"
        local server_config=""
        if [ -n "$server_config_raw" ] && [ "$server_config_raw" != "null" ] && [ "$server_config_raw" != "" ]; then
            server_config="$(make_path_absolute "$server_config_raw")"
        else
            server_config="$server_config_raw"
        fi
        
        local service_exists=false
        
        if [ "$provider" = "pm2" ]; then
            echo "Check if PM2 is installed..."
            check_pm2 || { echo -e "${RED}PM2 is not installed. Cannot check service status.${NC}"; exit 1; }

            if pm2 describe "$name" >/dev/null 2>&1; then
                service_exists=true
            fi
        elif [ "$provider" = "systemd" ]; then
            local user_unit="${XDG_CONFIG_HOME:-$HOME/.config}/systemd/user/$name.service"
            local system_unit="/etc/systemd/system/$name.service"
            if [ -f "$user_unit" ] || [ -f "$system_unit" ]; then
                # Unit file present, you can also check if it is active
                service_exists=true
            else
                # Unit file missing: service needs to be recreated!
                service_exists=false
            fi
        fi
        
        if [ "$service_exists" = false ]; then
            missing_services+=("$i")
            echo -e "${YELLOW}Missing service: $name ($provider)${NC}"
        else
            echo -e "${GREEN}✓ Service $name ($provider) exists${NC}"
        fi
    done
    
    # Handle missing services
    if [ ${#missing_services[@]} -eq 0 ]; then
        echo -e "${GREEN}All registered services are present${NC}"
        return 0
    fi
    
    echo -e "${YELLOW}Found ${#missing_services[@]} missing services${NC}"
    
    for index in "${missing_services[@]}"; do
        local service=$(jq -r ".[$index]" "$REGISTRY_FILE")
        local name=$(echo "$service" | jq -r '.name')
        local provider=$(echo "$service" | jq -r '.provider')
        local service_type=$(echo "$service" | jq -r '.type') 
        local systemd_type=$(echo "$service" | jq -r '.systemd_type // "--user"')
        local restart_policy=$(echo "$service" | jq -r '.restart_policy // "always"')
        local session_manager=$(echo "$service" | jq -r '.session_manager // "none"')
        local gdb_enabled=$(echo "$service" | jq -r '.gdb_enabled // "0"')
        local pm2_opts=$(echo "$service" | jq -r '.pm2_opts // ""')
        local status=$(echo "$service" | jq -r '.status // "active"')
        local service_resolved="$(get_service_info_resolved "$name")"
        local bin_path="$(echo "$service_resolved" | jq -r '.bin_path // "unknown"')"
        local server_config="$(echo "$service_resolved" | jq -r '.server_config // ""')"
        if [ "$server_config" = "null" ]; then
            server_config=""
        fi
        local exec_definition_raw="$(echo "$service" | jq -c '.exec // null')"
        local exec_command_abs="$(echo "$service_resolved" | jq -r '.exec.command // ""')"
        local -a exec_args_abs=()
        if [ -n "$exec_definition_raw" ] && [ "$exec_definition_raw" != "null" ]; then
            while IFS= read -r arg; do
                exec_args_abs+=("$arg")
            done < <(echo "$service_resolved" | jq -r '.exec.args[]?')
        fi
        local exec_command_string=""
        if [ -n "$exec_command_abs" ] && [ "$exec_command_abs" != "null" ]; then
            exec_command_string="$(render_exec_command "$exec_command_abs" "${exec_args_abs[@]}")"
        fi
        local server_binary_path_for_configs="$bin_path"
        local run_engine_config_path=""
        if [ ${#exec_args_abs[@]} -gt 0 ]; then
            if [ -n "${exec_args_abs[1]:-}" ] && [ "${exec_args_abs[1]}" != "null" ]; then
                server_binary_path_for_configs="${exec_args_abs[1]}"
            fi
            local arg_index
            for arg_index in "${!exec_args_abs[@]}"; do
                if [ "${exec_args_abs[$arg_index]}" = "--config" ]; then
                    local next_index=$((arg_index + 1))
                    if [ $next_index -lt ${#exec_args_abs[@]} ]; then
                        run_engine_config_path="${exec_args_abs[$next_index]}"
                    fi
                    break
                fi
            done
        fi
        if [ -n "$server_binary_path_for_configs" ] && [ "$server_binary_path_for_configs" != "unknown" ] && [ "$server_binary_path_for_configs" != "null" ]; then
            server_binary_path_for_configs="$(make_path_absolute "$server_binary_path_for_configs")"
        fi
        if [ -z "$run_engine_config_path" ] || [ "$run_engine_config_path" = "null" ]; then
            run_engine_config_path="$CONFIG_DIR/$name-run-engine.conf"
        else
            run_engine_config_path="$(make_path_absolute "$run_engine_config_path")"
        fi
        if [ -d "$run_engine_config_path" ]; then
            run_engine_config_path="$CONFIG_DIR/$name-run-engine.conf"
        fi
        if [[ "$run_engine_config_path" != /* ]]; then
            run_engine_config_path="$(make_path_absolute "$run_engine_config_path")"
        fi
        
        echo ""
        echo -e "${YELLOW}Service '$name' ($provider) is missing${NC}"
        echo "  Type: $service_type"
        echo "  Status: $status"
        
        if [ "$bin_path" = "unknown" ] || [ "$bin_path" = "null" ] || [ "$status" = "migrated" ]; then
            echo "  Binary: <needs manual configuration>"
            echo "  Exec: <needs manual configuration>"
            echo ""
            echo -e "${YELLOW}This service needs to be recreated manually:${NC}"
            echo "  $0 create $service_type $name --provider $provider --bin-path /path/to/your/bin"
        else
            echo "  Binary: $bin_path"
            if [ -n "$exec_command_string" ]; then
                echo "  Exec: $exec_command_string"
            else
                echo "  Exec: <unavailable>"
            fi
            if [ -n "$server_config" ]; then
                echo "  Server config: $server_config"
            fi
        fi
        echo ""
        
        read -p "Do you want to (r)ecreate, (d)elete from registry, or (s)kip? [r/d/s]: " choice
        
        case "$choice" in
            r|R|recreate)
                if [ "$bin_path" = "unknown" ] || [ "$status" = "migrated" ]; then
                    echo -e "${YELLOW}Please recreate manually with full create command${NC}"
                    read -p "Remove this entry from registry? [y/n]: " remove_entry
                    if [[ "$remove_entry" =~ ^[Yy]$ ]]; then
                        remove_service_from_registry "$name"
                    fi
                else
                    echo -e "${BLUE}Recreating service '$name'...${NC}"
                    if ! ensure_service_configs_restored "$name" "$service_type" "$provider" "$server_binary_path_for_configs" "$server_config" "$restart_policy" "$session_manager" "$gdb_enabled" "$systemd_type" "$pm2_opts" "$run_engine_config_path" "false"; then
                        echo -e "${YELLOW}Warning: Unable to restore configuration files for '$name'${NC}"
                    fi
                    if [ "$provider" = "pm2" ]; then
                        if [ -z "$exec_command_string" ] || [ "$exec_definition_raw" = "null" ]; then
                            echo -e "${RED}Cannot recreate PM2 service automatically: missing exec definition${NC}"
                        else
                            if [ -n "$pm2_opts" ]; then
                                pm2_create_service "$name" "$exec_command_string" "$restart_policy" "$bin_path" "$server_config" "$exec_definition_raw" $pm2_opts
                            else
                                pm2_create_service "$name" "$exec_command_string" "$restart_policy" "$bin_path" "$server_config" "$exec_definition_raw"
                            fi
                        fi
                    elif [ "$provider" = "systemd" ]; then
                        echo -e "${BLUE}Attempting to recreate systemd service '$name' automatically...${NC}"
                        if [ -z "$exec_command_string" ] || [ "$exec_definition_raw" = "null" ]; then
                            echo -e "${RED}Cannot recreate systemd service automatically: missing exec definition${NC}"
                        else
                            if systemd_create_service "$name" "$exec_command_string" "$restart_policy" "$bin_path" "$server_config" "$exec_definition_raw" "$systemd_type"; then
                                echo -e "${GREEN}Systemd service '$name' recreated successfully${NC}"
                            else
                                echo -e "${RED}Failed to recreate systemd service '$name'. Please recreate manually.${NC}"
                                echo "  $0 create $name $service_type --provider systemd --bin-path $bin_path"
                            fi
                        fi
                    fi
                fi
                ;;
            d|D|delete)
                echo -e "${BLUE}Removing '$name' from registry...${NC}"
                remove_service_from_registry "$name"
                ;;
            s|S|skip|*)
                echo -e "${BLUE}Skipping '$name'${NC}"
                ;;
        esac
    done
}

# Check if PM2 is installed
check_pm2() {
    if ! command -v pm2 >/dev/null 2>&1; then
        echo -e "${RED}Error: PM2 is not installed. Please install PM2 first:${NC}"
        echo "  npm install -g pm2"
        return 1
    fi
}

# Check if systemd is available
check_systemd() {
    if ! command -v systemctl >/dev/null 2>&1; then
        echo -e "${RED}Error: systemd is not available on this system${NC}"
        return 1
    fi
}

# Auto-detect provider based on system availability
auto_detect_provider() {
    if check_systemd 2>/dev/null; then
        echo "systemd"
    elif check_pm2 2>/dev/null; then
        echo "pm2"
    else
        echo -e "${RED}Error: Neither systemd nor PM2 is available on this system${NC}" >&2
        echo -e "${YELLOW}Please install PM2 (npm install -g pm2) or ensure systemd is available${NC}" >&2
        return 1
    fi
}

# Helper functions
function print_help() {

    local base_name="$(basename $0)"

    echo -e "${BLUE}AzerothCore Service Setup${NC}"
    echo "A unified interface for managing AzerothCore services with PM2 or systemd"
    echo ""
    echo "Usage:"
    echo "  $base_name create <service-type> <service-name> [options]"
    echo "  $base_name update <service-name> [options]"
    echo "  $base_name delete <service-name>"
    echo "  $base_name list [provider]"
    echo "  $base_name restore [--sync-only]"
    echo "  $base_name start|stop|restart|status <service-name>"
    echo "  $base_name logs <service-name> [--follow]"
    echo "  $base_name attach <service-name>"
    echo "  $base_name is-running <service-name>        # exit 0 if running, 1 otherwise"
    echo "  $base_name uptime-seconds <service-name>    # print uptime in seconds (fails if not running)"
    echo "  $base_name wait-uptime <service> <sec> [t]  # wait until uptime >= seconds (timeout t, default 120)"
    echo "  $base_name send <service-name> <command...>  # send console command to service"
    echo "  $base_name show-config <service-name>       # print current service + run-engine config"
    echo "  $base_name edit-config <service-name>"
    echo ""
    echo "Providers:"
    echo "  pm2      - Use PM2 process manager"
    echo "  systemd  - Use systemd service manager"
    echo "  auto     - Automatically choose systemd or fallback to pm2 (default)"
    echo ""
    echo "Service Types:"
    echo "  auth     - Authentication server"
    echo "  world    - World server (use different names for multiple realms)"
    echo ""
    echo "Options:"
    echo "  --provider <type>           - Service provider (pm2|systemd|auto, default: auto)"
    echo "  --bin-path <path>           - Path to the server binary directory"
    echo "  --server-config <path>      - Path to the server configuration file"
    echo "  --session-manager <type>    - Session manager (none|tmux|screen, default: none)"
    echo "                                Note: PM2 doesn't support tmux/screen, always uses 'none'"
    echo "  --gdb-enabled <0|1>         - Enable GDB debugging (default: 0)"
    echo "  --system                    - Create as system service (systemd only, requires sudo)"
    echo "  --user                      - Create as user service (systemd only, default)"
    echo "  --max-memory <value>        - Maximum memory limit (PM2 only)"
    echo "  --max-restarts <value>      - Maximum restart attempts (PM2 only)"
    echo "  --restart-policy <policy>   - Restart policy (on-failure|always, default: always)"
    echo "                                on-failure: restart only on crash/error (only works with PM2 or systemd without tmux/screen)"
    echo "                                always: restart on any exit (including 'server shutdown')"
    echo "  --no-start                  - Do not start the service after creation"
    echo ""
    echo "Examples:"
    echo "  # Create auth server (auto-detects provider)"
    echo "  $base_name create auth authserver --bin-path /home/user/azerothcore/bin"
    echo ""
    echo "  # Create PM2 auth server explicitly"
    echo "  $base_name create auth authserver --provider pm2 --bin-path /home/user/azerothcore/bin"
    echo ""
    echo "  # Create systemd world server with debugging enabled"
    echo "  $base_name create world worldserver-realm1 --provider systemd"
    echo "    --bin-path /home/user/azerothcore/bin"
    echo "    --server-config /home/user/azerothcore/etc/worldserver.conf"
    echo "    --gdb-enabled 1 --session-manager tmux"
    echo ""
    echo "  # Create service without starting it"
    echo "  $base_name create auth authserver --bin-path /home/user/azerothcore/bin --no-start"
    echo ""
    echo "  # Create service with always restart policy"
    echo "  $base_name create world worldserver --bin-path /home/user/azerothcore/bin --restart-policy always"
    echo ""
    echo "  # Update run-engine configuration"
    echo "  $base_name update worldserver-realm1 --session-manager screen --gdb-enabled 0"
    echo ""
    echo "  # Service management"
    echo "  $base_name start worldserver-realm1"
    echo "  $base_name logs worldserver-realm1 --follow"
    echo "  $base_name attach worldserver-realm1"
    echo "  $base_name list pm2"
    echo ""
    echo "  # Restore missing services from registry"
    echo "  $base_name restore"
    echo ""
    echo "  # Normalize registry paths to be relative to AC_SERVICE_CONFIG_DIR"
    echo "  $base_name registry-normalize"
    echo ""
    echo "Notes:"
    echo "  - Configuration editing modifies run-engine settings (GDB, session manager, etc.)"
    echo "  - Use --server-config for the actual server configuration file"
    echo "  - Services use run-engine in 'start' mode for single-shot execution"
    echo "  - Restart on crash is handled by PM2 or systemd, not by run-engine"
    echo "  - When restart-policy is 'always': 'server shutdown X' behaves like 'server restart X'"
    echo "    (only the in-game message differs, but the service will restart automatically)"
    echo "  - PM2 services always use session-manager 'none' and have built-in attach functionality"
    echo "  - attach command automatically detects the configured session manager and connects appropriately"
    echo "  - attach always provides interactive access to the server console"
    echo "  - Use 'logs' command to view service logs without interaction"
    echo "  - restore command first normalizes registry paths, syncs config files, and then recreates missing services"
    echo ""
    echo "Environment Variables:"
    echo "  AC_SERVICE_CONFIG_DIR   - Override default config directory for services registry"
    echo "                            When set, binary and configuration paths under this directory"
    echo "                            are stored as relative paths for improved portability."
    echo "                            Use '$base_name registry-normalize' to rewrite existing entries."
}



function validate_service_exists() {
    local service_name="$1"
    local provider="$2"
    
    if [ "$provider" = "pm2" ]; then
        # Check if service exists in PM2 using pm2 describe (most reliable)
        if pm2 describe "$service_name" >/dev/null 2>&1; then
            return 0  # Service exists
        else
            return 1  # Service doesn't exist
        fi
    elif [ "$provider" = "systemd" ]; then
        # Check if service exists in systemd
        local systemd_type="--user"
        if [ -f "/etc/systemd/system/$service_name.service" ]; then
            systemd_type="--system"
        fi
        
        if [ "$systemd_type" = "--system" ]; then
            if ! systemctl is-active "$service_name.service" >/dev/null 2>&1 && \
               ! systemctl is-enabled "$service_name.service" >/dev/null 2>&1 && \
               ! systemctl is-failed "$service_name.service" >/dev/null 2>&1; then
                return 1  # Service not found
            fi
        else
            if ! systemctl --user is-active "$service_name.service" >/dev/null 2>&1 && \
               ! systemctl --user is-enabled "$service_name.service" >/dev/null 2>&1 && \
               ! systemctl --user is-failed "$service_name.service" >/dev/null 2>&1; then
                return 1  # Service not found
            fi
        fi
    fi
    
    return 0  # Service exists
}

function sync_registry() {
    echo -e "${YELLOW}Syncing service registry with actual services...${NC}"
    
    if [ ! -f "$REGISTRY_FILE" ] || [ ! -s "$REGISTRY_FILE" ]; then
        echo -e "${YELLOW}No services registry found or empty${NC}"
        return 0
    fi
    
    local services_count=$(jq length "$REGISTRY_FILE")
    if [ "$services_count" -eq 0 ]; then
        echo -e "${YELLOW}No services registered${NC}"
        return 0
    fi
    
    local tmp_file=$(mktemp)
    echo "[]" > "$tmp_file"
    
    # Check each service in registry
    for i in $(seq 0 $((services_count-1))); do
        local service=$(jq -r ".[$i]" "$REGISTRY_FILE")
        local name=$(echo "$service" | jq -r '.name')
        local provider=$(echo "$service" | jq -r '.provider')
        
        if validate_service_exists "$name" "$provider"; then
            # Service exists, add it to the new registry
            jq --argjson service "$service" '. += [$service]' "$tmp_file" > "$tmp_file.new"
            mv "$tmp_file.new" "$tmp_file"
        else
            echo -e "${YELLOW}Service '$name' no longer exists. Removing from registry.${NC}"
            # Don't add to new registry
        fi
    done
    
    # Replace registry with synced version
    mv "$tmp_file" "$REGISTRY_FILE"
    echo -e "${GREEN}Registry synchronized.${NC}"
}



function get_service_info() {
    local service_name="$1"
    jq --arg name "$service_name" '.[] | select(.name == $name)' "$REGISTRY_FILE"
}

# Get service info with resolved paths (relative paths converted to absolute)
function get_service_info_resolved() {
    local service_name="$1"
    local service_info="$(get_service_info "$service_name")"
    
    if [ -z "$service_info" ] || [ "$service_info" = "null" ]; then
        echo ""
        return
    fi
    
    # Extract paths and convert them
    local bin_path_raw="$(echo "$service_info" | jq -r '.bin_path // ""')"
    local server_config_raw="$(echo "$service_info" | jq -r '.server_config // ""')"
    local exec_command_raw="$(echo "$service_info" | jq -r '.exec.command // ""')"
    local exec_args_raw_json="$(echo "$service_info" | jq -c '.exec.args // []')"
    
    local bin_path_resolved=""
    local server_config_resolved=""
    local exec_command_resolved=""
    local -a exec_args_resolved=()
    
    if [ -n "$bin_path_raw" ] && [ "$bin_path_raw" != "null" ] && [ "$bin_path_raw" != "" ]; then
        bin_path_resolved="$(make_path_absolute "$bin_path_raw")"
    else
        bin_path_resolved="$bin_path_raw"
    fi

    if [ -n "$exec_command_raw" ] && [ "$exec_command_raw" != "null" ]; then
        exec_command_resolved="$(make_path_absolute "$exec_command_raw")"
    else
        exec_command_resolved="$exec_command_raw"
    fi

    if [ -n "$exec_args_raw_json" ] && [ "$exec_args_raw_json" != "null" ]; then
        local prev_arg=""
        while IFS= read -r arg; do
            if [[ -z "$arg" ]]; then
                exec_args_resolved+=("$arg")
            elif [ "$prev_arg" = "--config" ]; then
                exec_args_resolved+=("$(make_path_absolute "$arg")")
            elif [[ "$arg" == /* ]]; then
                exec_args_resolved+=("$(make_path_absolute "$arg")")
            elif [[ "$arg" == */* && "$arg" != -* ]]; then
                exec_args_resolved+=("$(make_path_absolute "$arg")")
            else
                exec_args_resolved+=("$arg")
            fi
            prev_arg="$arg"
        done < <(echo "$exec_args_raw_json" | jq -r '.[]?')
    fi
    
    if [ -n "$server_config_raw" ] && [ "$server_config_raw" != "null" ] && [ "$server_config_raw" != "" ]; then
        server_config_resolved="$(make_path_absolute "$server_config_raw")"
    else
        server_config_resolved="$server_config_raw"
    fi

    local exec_args_resolved_json
    exec_args_resolved_json=$(printf '%s\0' "${exec_args_resolved[@]}" | jq -R -s 'split("\u0000")[:-1]')
    local exec_resolved_json
    exec_resolved_json=$(jq -n --arg command "${exec_command_resolved:-}" --argjson args "$exec_args_resolved_json" '{command: $command, args: $args}')
    
    # Return the service info with resolved paths
    echo "$service_info" | jq --arg bin_path "$bin_path_resolved" \
                              --arg server_config "$server_config_resolved" \
                              --argjson exec "$exec_resolved_json" \
                              '.bin_path = $bin_path | .exec = $exec | .server_config = $server_config'
}

function ensure_service_configs_restored() {
    local service_name="$1"
    local service_type="$2"
    local provider="$3"
    local server_binary_path="$4"
    local server_config_path="$5"
    local restart_policy="$6"
    local session_manager="$7"
    local gdb_enabled="$8"
    local systemd_type="$9"
    local pm2_opts="${10:-}"
    local run_engine_config_path="${11:-}"
    local force_rewrite="${12:-false}"

    if [ -z "$service_name" ]; then
        return 1
    fi

    if [ -z "$server_binary_path" ] || [ "$server_binary_path" = "null" ] || [ "$server_binary_path" = "unknown" ]; then
        return 0
    fi

    if [ "$server_config_path" = "null" ]; then
        server_config_path=""
    fi

    if [ -z "$restart_policy" ] || [ "$restart_policy" = "null" ]; then
        restart_policy="always"
    fi

    if [ -z "$session_manager" ] || [ "$session_manager" = "null" ]; then
        session_manager="none"
    fi

    if [ -z "$gdb_enabled" ] || [ "$gdb_enabled" = "null" ]; then
        gdb_enabled="0"
    fi

    if [ -z "$systemd_type" ] || [ "$systemd_type" = "null" ]; then
        systemd_type="--user"
    fi

    pm2_opts="${pm2_opts:-}"
    pm2_opts="${pm2_opts//$'\n'/ }"
    pm2_opts="${pm2_opts#"${pm2_opts%%[![:space:]]*}"}"
    pm2_opts="${pm2_opts%"${pm2_opts##*[![:space:]]}"}"

    if [ -z "$run_engine_config_path" ] || [ "$run_engine_config_path" = "null" ]; then
        run_engine_config_path="$CONFIG_DIR/$service_name-run-engine.conf"
    fi

    local service_conf_path="$CONFIG_DIR/$service_name.conf"
    local server_binary_dir
    local server_binary_name

    server_binary_dir="$(dirname "$server_binary_path")"
    server_binary_name="$(basename "$server_binary_path")"

    mkdir -p "$(dirname "$run_engine_config_path")"

    if [ "$force_rewrite" = "true" ] || [ ! -f "$run_engine_config_path" ]; then
        echo -e "${BLUE}Restoring run-engine config: $run_engine_config_path${NC}"
        cat > "$run_engine_config_path" << EOF
# run-engine configuration for service: $service_name
# Restored: $(date)

# Enable/disable GDB execution
export GDB_ENABLED=$gdb_enabled

# Session manager (none|auto|tmux|screen)
export SESSION_MANAGER="$session_manager"

# Restart policy (on-failure|always)
export RESTART_POLICY="$restart_policy"

# Service mode - indicates this is running under a service manager (systemd/pm2)
# When true, AC_DISABLE_INTERACTIVE will be set if no interactive session manager is used
export SERVICE_MODE="true"

# Session name for tmux/screen (optional)
export SESSION_NAME="${service_name}"

# Binary directory path
export BINPATH="$server_binary_dir"

# Server binary name
export SERVERBIN="$server_binary_name"

# Server configuration file path
export CONFIG="$server_config_path"

# Show console output for easier debugging
export WITH_CONSOLE=1
EOF
    fi

    if [ "$force_rewrite" = "true" ] || [ ! -f "$service_conf_path" ]; then
        echo -e "${BLUE}Restoring service metadata: $service_conf_path${NC}"
        cat > "$service_conf_path" << EOF
# AzerothCore service configuration for $service_name
# Restored: $(date)
# Provider: $provider
# Service Type: $service_type

# run-engine configuration file
RUN_ENGINE_CONFIG_FILE="$run_engine_config_path"

# Restart policy
RESTART_POLICY="$restart_policy"

# Provider-specific options
SYSTEMD_TYPE="$systemd_type"
PM2_OPTS="$pm2_opts"
EOF
    fi

    return 0
}

function sync_service_configs_from_registry() {
    echo -e "${BLUE}Syncing service configuration files from registry...${NC}"

    if [ ! -f "$REGISTRY_FILE" ] || [ ! -s "$REGISTRY_FILE" ]; then
        echo -e "${YELLOW}No services registry found or empty${NC}"
        return 0
    fi

    local services_count
    services_count=$(jq length "$REGISTRY_FILE")
    if [ "$services_count" -eq 0 ]; then
        echo -e "${YELLOW}No services registered${NC}"
        return 0
    fi

    local synced=0

    for i in $(seq 0 $((services_count - 1))); do
        local entry
        entry=$(jq -c ".[$i]" "$REGISTRY_FILE")
        [ -z "$entry" ] && continue

        local name
        name=$(echo "$entry" | jq -r '.name // empty')
        [ -z "$name" ] && continue

        local service_resolved
        service_resolved="$(get_service_info_resolved "$name")"
        [ -z "$service_resolved" ] && continue

        local service_type provider restart_policy session_manager gdb_enabled systemd_type pm2_opts
        service_type=$(echo "$entry" | jq -r '.type // ""')
        provider=$(echo "$entry" | jq -r '.provider // ""')
        restart_policy=$(echo "$entry" | jq -r '.restart_policy // "always"')
        session_manager=$(echo "$entry" | jq -r '.session_manager // "none"')
        gdb_enabled=$(echo "$entry" | jq -r '.gdb_enabled // "0"')
        systemd_type=$(echo "$entry" | jq -r '.systemd_type // "--user"')
        pm2_opts=$(echo "$entry" | jq -r '.pm2_opts // ""')

        local server_binary_path
        server_binary_path=$(echo "$service_resolved" | jq -r '.bin_path // ""')
        if [ -z "$server_binary_path" ] || [ "$server_binary_path" = "null" ] || [ "$server_binary_path" = "unknown" ]; then
            server_binary_path=""
        fi

        local server_config_path
        server_config_path=$(echo "$service_resolved" | jq -r '.server_config // ""')
        if [ -n "$server_config_path" ] && [ "$server_config_path" != "null" ]; then
            server_config_path="$(make_path_absolute "$server_config_path")"
        else
            server_config_path=""
        fi

        local exec_definition
        exec_definition=$(echo "$entry" | jq -c '.exec // null')
        local -a exec_args=()
        if [ -n "$exec_definition" ] && [ "$exec_definition" != "null" ]; then
            while IFS= read -r arg; do
                exec_args+=("$arg")
            done < <(echo "$exec_definition" | jq -r '.args[]?')
        fi

        if { [ -z "$server_binary_path" ] || [ "$server_binary_path" = "null" ]; } && [ ${#exec_args[@]} -ge 2 ]; then
            server_binary_path="$(make_path_absolute "${exec_args[1]}")"
        fi

        local run_engine_config_rel=""
        for idx in "${!exec_args[@]}"; do
            if [ "${exec_args[$idx]}" = "--config" ]; then
                local next_idx=$((idx + 1))
                if [ $next_idx -lt ${#exec_args[@]} ]; then
                    run_engine_config_rel="${exec_args[$next_idx]}"
                fi
                break
            fi
        done

        if [ -z "$run_engine_config_rel" ] || [ "$run_engine_config_rel" = "null" ]; then
            run_engine_config_rel="$name-run-engine.conf"
        fi

        local run_engine_config_path
        if [[ "$run_engine_config_rel" = /* ]]; then
            run_engine_config_path="$run_engine_config_rel"
        else
            run_engine_config_path="$CONFIG_DIR/$run_engine_config_rel"
        fi
        run_engine_config_path="$(realpath -m "$run_engine_config_path" 2>/dev/null || echo "$run_engine_config_path")"

        if [ -n "$server_binary_path" ]; then
            server_binary_path="$(make_path_absolute "$server_binary_path")"
        fi

        ensure_service_configs_restored "$name" "$service_type" "$provider" "$server_binary_path" "$server_config_path" "$restart_policy" "$session_manager" "$gdb_enabled" "$systemd_type" "$pm2_opts" "$run_engine_config_path" "true"
        synced=$((synced + 1))
    done

    if [ "$synced" -gt 0 ]; then
        echo -e "${GREEN}Synchronized $synced service configuration file(s)${NC}"
    else
        echo -e "${YELLOW}No service configuration files required synchronization${NC}"
    fi
}

# PM2 service management functions
function pm2_create_service() {
    local service_name="$1"
    local command_string="$2"
    local restart_policy="$3"
    local real_bin_path="$4"
    local server_config_path="$5"
    local exec_definition="$6"
    shift 6
    
    check_pm2 || return 1
    
    # Parse additional PM2 options
    local max_memory=""
    local max_restarts=""
    local -a extra_pm2_args=()
    
    while [[ $# -gt 0 ]]; do
        case "$1" in
            --max-memory)
                max_memory="$2"
                shift 2
                ;;
            --max-restarts)
                max_restarts="$2"
                shift 2
                ;;
            *)
                extra_pm2_args+=("$1")
                shift
                ;;
        esac
    done

    if [ -z "$exec_definition" ] || [ "$exec_definition" = "null" ]; then
        echo -e "${RED}Error: Missing exec definition for PM2 service '$service_name'${NC}"
        return 1
    fi

    local exec_command_rel
    exec_command_rel=$(echo "$exec_definition" | jq -r '.command // empty')
    if [ -z "$exec_command_rel" ] || [ "$exec_command_rel" = "null" ]; then
        echo -e "${RED}Error: Exec command not defined for service '$service_name'${NC}"
        return 1
    fi

    local exec_command_abs
    exec_command_abs="$(make_path_absolute "$exec_command_rel")"
    local -a exec_args_abs=()
    local prev_arg=""
    while IFS= read -r arg; do
        if [[ -z "$arg" ]]; then
            exec_args_abs+=("$arg")
        elif [ "$prev_arg" = "--config" ]; then
            exec_args_abs+=("$(make_path_absolute "$arg")")
        elif [[ "$arg" == /* ]]; then
            exec_args_abs+=("$(make_path_absolute "$arg")")
        elif [[ "$arg" == */* && "$arg" != -* ]]; then
            exec_args_abs+=("$(make_path_absolute "$arg")")
        else
            exec_args_abs+=("$arg")
        fi
        prev_arg="$arg"
    done < <(echo "$exec_definition" | jq -r '.args[]?')

    # Set stop exit codes based on restart policy
    local -a pm2_args=(start "$exec_command_abs" --interpreter none --name "$service_name")
    if [ "$restart_policy" = "always" ]; then
        # PM2 will restart on any exit code (including 0)
        :
    else
        # PM2 will not restart on clean shutdown (exit code 0)
        pm2_args+=("--stop-exit-codes" "0")
    fi
    
    # Add memory limit if specified
    if [ -n "$max_memory" ]; then
        pm2_args+=("--max-memory-restart" "$max_memory")
    fi
    
    # Add max restarts if specified
    if [ -n "$max_restarts" ]; then
        pm2_args+=("--max-restarts" "$max_restarts")
    fi

    if [ ${#extra_pm2_args[@]} -gt 0 ]; then
        pm2_args+=("${extra_pm2_args[@]}")
    fi

    if [ ${#exec_args_abs[@]} -gt 0 ]; then
        pm2_args+=("--")
        pm2_args+=("${exec_args_abs[@]}")
    fi
    
    # Execute command
    echo -e "${YELLOW}Creating PM2 service: $service_name${NC}"
    if [ -n "$command_string" ]; then
        echo "  Exec: $command_string"
    fi
    
    if AC_LAUNCHED_BY_PM2=1 pm2 "${pm2_args[@]}"; then
        echo -e "${GREEN}PM2 service '$service_name' created successfully${NC}"
        pm2 save
        
        # Setup PM2 startup for persistence across reboots
        echo -e "${BLUE}Configuring PM2 startup for persistence...${NC}"
        pm2 startup --auto >/dev/null 2>&1 || true
        
        # Add to registry (use real binary path instead of command for portability)
        local extra_args_serialized=""
        if [ ${#extra_pm2_args[@]} -gt 0 ]; then
            extra_args_serialized="$(printf '%s ' "${extra_pm2_args[@]}")"
            extra_args_serialized="${extra_args_serialized% }"
        fi
        add_service_to_registry "$service_name" "pm2" "executable" "$real_bin_path" "$extra_args_serialized" "" "$restart_policy" "none" "0" "$max_memory $max_restarts" "$server_config_path" "$exec_definition"

        return 0
    else
        echo -e "${RED}Failed to create PM2 service '$service_name'${NC}"
        return 1
    fi
}


function pm2_remove_service() {
    local service_name="$1"
    
    check_pm2 || return 1
    
    echo -e "${YELLOW}Stopping and removing PM2 service: $service_name${NC}"
    
    # Stop the service if it's running
    if pm2 describe "$service_name" >/dev/null 2>&1; then
        pm2 stop "$service_name" 2>&1 || true
        pm2 delete "$service_name" 2>&1 || true
        
        # Wait for PM2 to process the stop/delete command with timeout
        local timeout=10
        local elapsed=0
        while pm2 describe "$service_name" >/dev/null 2>&1; do
            if [ "$elapsed" -ge "$timeout" ]; then
                echo -e "${RED}Timeout reached while waiting for PM2 service '$service_name' to stop${NC}"
                return 1
            fi
            sleep 0.5
            elapsed=$((elapsed + 1))
        done

        # Verify the service was removed
        if pm2 describe "$service_name" >/dev/null 2>&1; then
            echo -e "${RED}Failed to remove PM2 service '$service_name'${NC}"
            return 1
        fi
        
        pm2 save
        echo -e "${GREEN}PM2 service '$service_name' stopped and removed${NC}"
        
        # Note: Registry removal is handled by the caller (delete_service)
        return 0
    else
        echo -e "${YELLOW}PM2 service '$service_name' not found${NC}"
        # Service not found in PM2 - let caller decide about registry
        return 0
    fi
    
    return 0
}

function pm2_service_action() {
    local action="$1"
    local service_name="$2"
    
    check_pm2 || return 1
    
    echo -e "${YELLOW}${action^} PM2 service: $service_name${NC}"
    pm2 "$action" "$service_name"
}

function pm2_service_logs() {
    local service_name="$1"
    local follow="$2"
    
    check_pm2 || return 1
    
    echo -e "${YELLOW}Showing PM2 logs for: $service_name${NC}"
    if [ "$follow" = "true" ]; then
        pm2 logs "$service_name" --lines 50
    else
        pm2 logs "$service_name" --lines 50 --nostream
    fi
}

# Systemd service management functions
function get_systemd_dir() {
    local type="$1"
    
    if [ "$type" = "--system" ]; then
        echo "/etc/systemd/system"
    else
        echo "${XDG_CONFIG_HOME:-$HOME/.config}/systemd/user"
    fi
}

function systemd_create_service() {
    local service_name="$1"
    local command="$2"
    local restart_policy="$3"
    local real_bin_path="$4"
    local server_config_path="$5"
    local exec_definition="$6"
    local systemd_type="--user"
    local bin_path=""
    local gdb_enabled="0"
    local server_config=""
    shift 6
    
    check_systemd || return 1
    
    # Parse systemd type and extract additional parameters
    while [[ $# -gt 0 ]]; do
        case "$1" in
            --system|--user)
                systemd_type="$1"
                shift
                ;;
            --bin-path)
                bin_path="$2"
                shift 2
                ;;
            --gdb-enabled)
                gdb_enabled="$2"
                shift 2
                ;;
            --server-config)
                server_config="$2"
                shift 2
                ;;
            *)
                command+=" $1"
                shift
                ;;
        esac
    done
    
    # If bin_path is not provided, try to extract from command
    if [ -z "$bin_path" ]; then
        # Try to extract bin path from run-engine command
        if [[ "$command" =~ run-engine[[:space:]]+start[[:space:]]+([^[:space:]]+) ]]; then
            local binary_path="${BASH_REMATCH[1]}"
            bin_path="$(dirname "$binary_path")"
        else
            # Fallback to current directory
            bin_path="$(pwd)"
        fi
    fi
    
    local systemd_dir=$(get_systemd_dir "$systemd_type")
    local service_file="$systemd_dir/$service_name.service"
    
    # Create systemd directory if it doesn't exist
    if [ "$systemd_type" = "--system" ]; then
        if [ "$EUID" -ne 0 ]; then
            echo -e "${RED}Error: System services require root privileges. Use sudo.${NC}"
            return 1
        fi
        mkdir -p "$systemd_dir"
    else
        mkdir -p "$systemd_dir"
    fi
    
    # Determine service type and ExecStop for systemd
    local service_type="simple"
    local exec_stop=""
    
    # Load the run-engine config to check the session manager
    local run_engine_config_path="$CONFIG_DIR/$service_name-run-engine.conf"
    local session_manager="none"
    local session_name="$service_name"

    if [ -f "$run_engine_config_path" ]; then
        # Read the session manager and name from the config file without sourcing it
        session_manager=$(grep -oP 'SESSION_MANAGER="\K[^"]+' "$run_engine_config_path" || echo "none")
        session_name=$(grep -oP 'SESSION_NAME="\K[^"]+' "$run_engine_config_path" || echo "$service_name")
    fi

    if [ "$session_manager" = "tmux" ] || [ "$session_manager" = "screen" ]; then
        service_type="forking"
    fi
    
    # Create service file
    echo -e "${YELLOW}Creating systemd service: $service_name${NC}"
    
    # Ensure bin_path is absolute
    if [[ ! "$bin_path" = /* ]]; then
        bin_path="$(realpath "$bin_path")"
    fi
    
    if [ "$systemd_type" = "--system" ]; then
        # System service template (with User directive)
        cat > "$service_file" << EOF
[Unit]
Description=AzerothCore $service_name
After=network.target

[Service]
Type=${service_type}
ExecStart=$command
Restart=$restart_policy
RestartSec=3
User=$(whoami)
Group=$(id -gn)
WorkingDirectory=$bin_path
StandardOutput=journal+console
StandardError=journal+console

[Install]
WantedBy=multi-user.target
EOF
    else
        # User service template (no User/Group directives)
        cat > "$service_file" << EOF
[Unit]
Description=AzerothCore $service_name
After=network.target

[Service]
Type=${service_type}
ExecStart=$command
Restart=$restart_policy
RestartSec=3
WorkingDirectory=$bin_path
StandardOutput=journal+console
StandardError=journal+console

[Install]
WantedBy=default.target
EOF
    fi
    
    # Reload systemd and enable service
    if [ "$systemd_type" = "--system" ]; then
        systemctl daemon-reload
        systemctl enable "$service_name.service"
    else
        systemctl --user daemon-reload
        systemctl --user enable "$service_name.service"
    fi
    
    echo -e "${GREEN}Systemd service '$service_name' created successfully with session manager '$session_manager'${NC}"
    
    # Add to registry
    add_service_to_registry "$service_name" "systemd" "service" "$real_bin_path" "" "$systemd_type" "$restart_policy" "$session_manager" "$gdb_enabled" "" "$server_config_path" "$exec_definition"
    
    return 0
}

function systemd_remove_service() {
    local service_name="$1"
    local systemd_type="--user"
    
    check_systemd || return 1
    
    # Try to determine if it's a system or user service
    if [ -f "/etc/systemd/system/$service_name.service" ]; then
        systemd_type="--system"
    fi
    
    local systemd_dir=$(get_systemd_dir "$systemd_type")
    local service_file="$systemd_dir/$service_name.service"
    
    echo -e "${YELLOW}Stopping and removing systemd service: $service_name (${systemd_type#--})${NC}"
    
    # Check if service file exists
    if [ ! -f "$service_file" ]; then
        echo -e "${YELLOW}Systemd service file '$service_file' not found or already removed${NC}"
        return 0
    fi
    
    # Stop and disable service
    local removal_failed=false
    if [ "$systemd_type" = "--system" ]; then
        if [ "$EUID" -ne 0 ]; then
            echo -e "${RED}Error: System services require root privileges. Use sudo.${NC}"
            return 1
        fi
        systemctl stop "$service_name.service" 2>/dev/null || true
        systemctl disable "$service_name.service" 2>/dev/null || true
        systemctl daemon-reload
        
        # Verify service is no longer active
        if systemctl is-active "$service_name.service" >/dev/null 2>&1; then
            echo -e "${RED}Warning: Failed to stop system service '$service_name'${NC}"
            removal_failed=true
        fi
    else
        systemctl --user stop "$service_name.service" 2>/dev/null || true
        systemctl --user disable "$service_name.service" 2>/dev/null || true
        systemctl --user daemon-reload
        
        # Verify service is no longer active
        if systemctl --user is-active "$service_name.service" >/dev/null 2>&1; then
            echo -e "${RED}Warning: Failed to stop user service '$service_name'${NC}"
            removal_failed=true
        fi
    fi
    
    # Remove service file
    if rm -f "$service_file"; then
        echo -e "${GREEN}Systemd service '$service_name' stopped and removed${NC}"
        if [ "$removal_failed" = "true" ]; then
            echo -e "${YELLOW}Note: Service may still be running but configuration was removed${NC}"
        fi
        
        # Note: Registry removal is handled by the caller (delete_service)
        return 0
    else
        echo -e "${RED}Failed to remove systemd service file '$service_file'${NC}"
        return 1
    fi
}

function systemd_service_action() {
    local action="$1"
    local service_name="$2"
    local systemd_type="--user"
    
    check_systemd || return 1
    
    # Try to determine if it's a system or user service
    if [ -f "/etc/systemd/system/$service_name.service" ]; then
        systemd_type="--system"
    fi
    
    echo -e "${YELLOW}${action^} systemd service: $service_name${NC}"

    # stop tmux or screen session if applicable && action is stop or restart
    if [[ "$action" == "stop" || "$action" == "restart" ]]; then
        local session_manager=$(grep -oP 'SESSION_MANAGER="\K[^"]+' "$CONFIG_DIR/$service_name-run-engine.conf" || echo "none")
        if [ "$session_manager" = "tmux" ]; then
            echo -e "${YELLOW}Stopping tmux session for service: $service_name${NC}"
            tmux kill-session -t "$service_name"
        elif [ "$session_manager" = "screen" ]; then
            echo -e "${YELLOW}Stopping screen session for service: $service_name${NC}"
            screen -S "$service_name" -X quit
        fi
    fi

    if [ "$systemd_type" = "--system" ]; then
        systemctl "$action" "$service_name.service"
    else
        systemctl --user "$action" "$service_name.service"
    fi
}

function systemd_service_logs() {
    local service_name="$1"
    local follow="$2"
    local systemd_type="--user"
    
    check_systemd || return 1
    
    # Try to determine if it's a system or user service
    if [ -f "/etc/systemd/system/$service_name.service" ]; then
        systemd_type="--system"
    fi
    
    echo -e "${YELLOW}Showing systemd logs for: $service_name${NC}"
    if [ "$follow" = "true" ]; then
        if [ "$systemd_type" = "--system" ]; then
            journalctl --unit="$service_name.service" -e -f
        else
            journalctl --user-unit="$service_name.service" -e -f
        fi
    else
        if [ "$systemd_type" = "--system" ]; then
            journalctl --unit="$service_name.service" -e --lines 50 --no-pager
        else
            journalctl --user-unit="$service_name.service" -e --lines 50 --no-pager
        fi
    fi
}

function create_service() {
    local service_type="$1"
    local service_name="$2"
    shift 2
    
    # Validate service type
    if [[ "$service_type" != "auth" && "$service_type" != "world" ]]; then
        echo -e "${RED}Error: Invalid service type. Use 'auth' or 'world'${NC}"
        return 1
    fi
    
    # Check if service already exists
    if [ -n "$(get_service_info "$service_name")" ]; then
        echo -e "${RED}Error: Service '$service_name' already exists${NC}"
        return 1
    fi
    
    # Default values for run-engine configuration
    local provider="auto"
    local bin_path="${BINPATH:-$ROOT_DIR/bin}" # get from config or environment
    local server_config=""
    local session_manager="none"
    local gdb_enabled="0"
    local restart_policy="always"
    local systemd_type="--user"
    local pm2_opts=""
    local auto_start="true"
    
    # Parse options
    while [[ $# -gt 0 ]]; do
        case "$1" in
            --provider)
                provider="$2"
                shift 2
                ;;
            --bin-path)
                bin_path="$2"
                shift 2
                ;;
            --server-config)
                server_config="$2"
                shift 2
                ;;
            --session-manager)
                session_manager="$2"
                shift 2
                ;;
            --gdb-enabled)
                gdb_enabled="$2"
                shift 2
                ;;
            --restart-policy)
                restart_policy="$2"
                shift 2
                ;;
            --system)
                systemd_type="--system"
                shift
                ;;
            --user)
                systemd_type="--user"
                shift
                ;;
            --max-memory|--max-restarts)
                pm2_opts="$pm2_opts $1 $2"
                shift 2
                ;;
            --no-start)
                auto_start="false"
                shift
                ;;
            *)
                echo -e "${RED}Error: Unknown option: $1${NC}"
                return 1
                ;;
        esac
    done
    
    # Auto-detect provider if set to auto
    if [ "$provider" = "auto" ]; then
        if ! provider=$(auto_detect_provider); then
            return 1
        fi
        echo -e "${BLUE}Auto-detected provider: $provider${NC}"
    fi
    
    # Validate provider
    if [[ "$provider" != "pm2" && "$provider" != "systemd" ]]; then
        echo -e "${RED}Error: Invalid provider. Use 'pm2', 'systemd', or 'auto'${NC}"
        return 1
    fi

    # Validate restart policy
    if [[ "$restart_policy" != "on-failure" && "$restart_policy" != "always" ]]; then
        echo -e "${RED}Error: Invalid restart policy. Use 'on-failure' or 'always'${NC}"
        return 1
    fi

    # PM2 specific validation and adjustments
    if [ "$provider" = "pm2" ]; then
        # PM2 doesn't support session managers (tmux/screen), force to none
        if [ "$session_manager" != "none" ]; then
            echo -e "${YELLOW}Warning: PM2 doesn't support session managers. Setting session-manager to 'none'${NC}"
            echo -e "${BLUE}PM2 has built-in attach functionality via: $0 attach $service_name${NC}"
            session_manager="none"
        fi
    fi
    
    # Determine server binary based on service type
    local server_bin="${service_type}server"
    local server_binary_path=$(realpath "$bin_path/$server_bin")
    local real_config_path=""
    if [ -n "$server_config" ]; then
        real_config_path=$(realpath "$server_config")
    fi

    # Check if binary exists
    if [ ! -f "$server_binary_path" ]; then
        echo -e "${RED}Error: Server binary not found: $server_binary_path, please check your --bin-path option ${NC}"
        return 1
    fi
    
    # Create run-engine configuration file for this service
    local run_engine_config="$CONFIG_DIR/$service_name-run-engine.conf"
    cat > "$run_engine_config" << EOF
# run-engine configuration for service: $service_name
# This file contains run-engine specific settings

# Enable/disable GDB execution
export GDB_ENABLED=$gdb_enabled

# Session manager (none|auto|tmux|screen)
export SESSION_MANAGER="$session_manager"

# Restart policy (on-failure|always)
export RESTART_POLICY="$restart_policy"

# Service mode - indicates this is running under a service manager (systemd/pm2)
# When true, AC_DISABLE_INTERACTIVE will be set if no interactive session manager is used
export SERVICE_MODE="true"

# Session name for tmux/screen (optional)
export SESSION_NAME="${service_name}"

# Binary directory path
export BINPATH="$bin_path"

# Server binary name
export SERVERBIN="$server_bin"

# Server configuration file path
export CONFIG="$real_config_path"

# Show console output for easier debugging
export WITH_CONSOLE=1
EOF
    
    # Create service configuration file for our registry
    cat > "$CONFIG_DIR/$service_name.conf" << EOF
# AzerothCore service configuration for $service_name
# Created: $(date)
# Provider: $provider
# Service Type: $service_type

# run-engine configuration file
RUN_ENGINE_CONFIG_FILE="$run_engine_config"

# Restart policy
RESTART_POLICY="$restart_policy"

# Provider-specific options
SYSTEMD_TYPE="$systemd_type"
PM2_OPTS="$pm2_opts"
EOF
    
    # Build run-engine command definition
    local run_engine_path="$SCRIPT_DIR/run-engine"
    local -a run_engine_args=("start" "$server_binary_path" "--config" "$run_engine_config")
    local run_engine_cmd
    run_engine_cmd="$(render_exec_command "$run_engine_path" "${run_engine_args[@]}")"
    local exec_definition
    exec_definition="$(serialize_exec_definition "$run_engine_path" "${run_engine_args[@]}")"
    
    # Create the actual service
    local service_creation_success=false
    if [ "$provider" = "pm2" ]; then
        if [ -n "$pm2_opts" ]; then
            if pm2_create_service "$service_name" "$run_engine_cmd" "$restart_policy" "$server_binary_path" "$server_config" "$exec_definition" $pm2_opts; then
                service_creation_success=true
            fi
        else
            if pm2_create_service "$service_name" "$run_engine_cmd" "$restart_policy" "$server_binary_path" "$server_config" "$exec_definition"; then
                service_creation_success=true
            fi
        fi
        
    elif [ "$provider" = "systemd" ]; then
        if systemd_create_service "$service_name" "$run_engine_cmd" "$restart_policy" "$server_binary_path" "$server_config" "$exec_definition" "$systemd_type"; then
            service_creation_success=true
        fi
    fi
    
    # Check if service creation was successful
    if [ "$service_creation_success" = "true" ]; then
        echo -e "${GREEN}Service '$service_name' created successfully${NC}"
        echo -e "${BLUE}Run-engine config: $run_engine_config${NC}"
        
        # Auto-start the service unless --no-start was specified
        if [ "$auto_start" = "true" ]; then
            echo -e "${YELLOW}Starting service '$service_name'...${NC}"
            if service_action "start" "$service_name"; then
                echo -e "${GREEN}Service '$service_name' started successfully${NC}"
            else
                echo -e "${YELLOW}Warning: Service '$service_name' was created but failed to start${NC}"
                echo -e "${BLUE}You can start it manually with: $0 start $service_name${NC}"
            fi
        else
            echo -e "${BLUE}Service created but not started (--no-start specified)${NC}"
            echo -e "${BLUE}Start it manually with: $0 start $service_name${NC}"
        fi
    else
        # Remove configuration files if service creation failed
        rm -f "$CONFIG_DIR/$service_name.conf"
        rm -f "$run_engine_config"
        echo -e "${RED}Failed to create service '$service_name'${NC}"
        return 1
    fi
}

function update_service() {
    local service_name="$1"
    shift
    
    # Check if service exists
    local service_info=$(get_service_info "$service_name")
    if [ -z "$service_info" ]; then
        echo -e "${RED}Error: Service '$service_name' not found${NC}"
        return 1
    fi
    
    # Extract service information
    local provider=$(echo "$service_info" | jq -r '.provider')
    local service_type=$(echo "$service_info" | jq -r '.type')
    local config_file="$CONFIG_DIR/$service_name.conf"
    
    # Load current configuration
    if [ ! -f "$config_file" ]; then
        echo -e "${RED}Error: Service configuration file not found: $config_file${NC}"
        return 1
    fi
    source "$config_file"
    
    # Load current run-engine configuration
    if [ -n "${RUN_ENGINE_CONFIG_FILE:-}" ] && [ -f "$RUN_ENGINE_CONFIG_FILE" ]; then
        source "$RUN_ENGINE_CONFIG_FILE"
    else
        echo -e "${YELLOW}Warning: Run-engine configuration file not found: ${RUN_ENGINE_CONFIG_FILE:-<unset>}${NC}"
    fi
    
    # Parse options to update
    local config_updated=false
    while [[ $# -gt 0 ]]; do
        case "$1" in
            --bin-path)
                export BINPATH="$2"
                config_updated=true
                shift 2
                ;;
            --server-config)
                export SERVER_CONFIG="$2"
                config_updated=true
                shift 2
                ;;
            --session-manager)
                export SESSION_MANAGER="$2"
                config_updated=true
                shift 2
                ;;
            --gdb-enabled)
                export GDB_ENABLED="$2"
                config_updated=true
                shift 2
                ;;
            --restart-policy)
                export RESTART_POLICY="$2"
                config_updated=true
                shift 2
                ;;
            --system)
                SYSTEMD_TYPE="--system"
                shift
                ;;
            --user)
                SYSTEMD_TYPE="--user"
                shift
                ;;
            --max-memory|--max-restarts)
                PM2_OPTS="$PM2_OPTS $1 $2"
                shift 2
                ;;
            *)
                echo -e "${RED}Error: Unknown option: $1${NC}"
                return 1
                ;;
        esac
    done
    
    # PM2 specific validation for session manager
    if [ "$provider" = "pm2" ] && [ -n "$SESSION_MANAGER" ] && [ "$SESSION_MANAGER" != "none" ]; then
        echo -e "${YELLOW}Warning: PM2 doesn't support session managers. Setting session-manager to 'none'${NC}"
        echo -e "${BLUE}PM2 has built-in attach functionality via: $0 attach $service_name${NC}"
        export SESSION_MANAGER="none"
        config_updated=true
    fi

    # Validate restart policy if provided
    if [ -n "$RESTART_POLICY" ] && [[ "$RESTART_POLICY" != "on-failure" && "$RESTART_POLICY" != "always" ]]; then
        echo -e "${RED}Error: Invalid restart policy. Use 'on-failure' or 'always'${NC}"
        return 1
    fi

    if [ "$config_updated" = "true" ]; then
        # Update run-engine configuration file
        cat > "$RUN_ENGINE_CONFIG_FILE" << EOF
# run-engine configuration for service: $service_name
# Updated: $(date)

# Enable/disable GDB execution
export GDB_ENABLED=${GDB_ENABLED:-0}

# Session manager (none|auto|tmux|screen)
export SESSION_MANAGER="${SESSION_MANAGER:-none}"

# Restart policy (on-failure|always)
export RESTART_POLICY="${RESTART_POLICY:-on-failure}"

# Service mode - indicates this is running under a service manager (systemd/pm2)
export SERVICE_MODE="true"

# Session name for tmux/screen
export SESSION_NAME="${service_name}"

# Binary directory path
export BINPATH="${BINPATH}"

# Server binary name
export SERVERBIN="${SERVERBIN}"

# Server configuration file path
export CONFIG="${SERVER_CONFIG}"
EOF
        
        echo -e "${GREEN}Run-engine configuration updated: $RUN_ENGINE_CONFIG_FILE${NC}"
        echo -e "${YELLOW}Note: Restart the service to apply changes${NC}"
    else
        echo -e "${YELLOW}No run-engine configuration changes made${NC}"
    fi
    
    # Update service configuration
    cat > "$config_file" << EOF
# AzerothCore service configuration for $service_name
# Updated: $(date)
# Provider: $provider
# Service Type: $service_type

# run-engine configuration file
RUN_ENGINE_CONFIG_FILE="$RUN_ENGINE_CONFIG_FILE"

# Restart policy
RESTART_POLICY="${RESTART_POLICY:-on-failure}"

# Provider-specific options
SYSTEMD_TYPE="$SYSTEMD_TYPE"
PM2_OPTS="$PM2_OPTS"
EOF
}

function delete_service() {
    local service_name="$1"
    
    # Check if service exists
    local service_info=$(get_service_info "$service_name")
    if [ -z "$service_info" ]; then
        echo -e "${RED}Error: Service '$service_name' not found${NC}"
        return 1
    fi
    
    # Extract provider and config
    local provider=$(echo "$service_info" | jq -r '.provider')
    local config_file="$CONFIG_DIR/$service_name.conf"
    
    # Load configuration to get run-engine config file
    if [ -f "$config_file" ]; then
        source "$config_file"
    else
        echo -e "${YELLOW}Warning: Service configuration file not found: $config_file${NC}"
    fi
    
    echo -e "${YELLOW}Deleting service '$service_name' (provider: $provider)...${NC}"
    
    # Stop and remove the service
    local removal_success=false
    if [ "$provider" = "pm2" ]; then
        if pm2_remove_service "$service_name"; then
            removal_success=true
        fi
    elif [ "$provider" = "systemd" ]; then
        if systemd_remove_service "$service_name"; then
            removal_success=true
        fi
    fi
    
    if [ "$removal_success" = "true" ]; then
        # Remove from registry only after successful service removal
        remove_service_from_registry "$service_name"
        
        # Remove run-engine configuration file
        if [ -n "${RUN_ENGINE_CONFIG_FILE:-}" ] && [ -f "$RUN_ENGINE_CONFIG_FILE" ]; then
            rm -f "$RUN_ENGINE_CONFIG_FILE"
            echo -e "${GREEN}Removed run-engine config: $RUN_ENGINE_CONFIG_FILE${NC}"
        fi
        
        # Remove configuration file
        rm -f "$config_file"
        
        echo -e "${GREEN}Service '$service_name' deleted successfully${NC}"
    else
        echo -e "${RED}Failed to remove service '$service_name' from $provider${NC}"
        echo -e "${YELLOW}Registry entry preserved. Service may need manual cleanup.${NC}"
        return 1
    fi
}

function list_services() {
    local provider_filter="$1"

        # Sync registry first
    sync_registry
    
    echo -e "${BLUE}AzerothCore Services${NC}"
    echo "====================="
    
    if [ "$(jq 'length' "$REGISTRY_FILE")" = "0" ]; then
        echo "No services registered"
        return
    fi
    
    # Show systemd services
    if [ -z "$provider_filter" ] || [ "$provider_filter" = "systemd" ]; then
        local systemd_services=$(jq -r '.[] | select(.provider == "systemd") | .name' "$REGISTRY_FILE" 2>/dev/null)
        if [ -n "$systemd_services" ] && command -v systemctl >/dev/null 2>&1; then
            echo -e "\n${YELLOW}Systemd User Services:${NC}"
            while read -r service_name; do
                if [ -n "$service_name" ]; then
                    systemctl --user status "$service_name.service" --no-pager -l || true
                    echo ""
                fi
            done <<< "$systemd_services"
            
            # Also check for system services
            local system_services=""
            while read -r service_name; do
                if [ -n "$service_name" ] && [ -f "/etc/systemd/system/$service_name.service" ]; then
                    system_services+="$service_name "
                fi
            done <<< "$systemd_services"
            
            if [ -n "$system_services" ]; then
                echo -e "${YELLOW}Systemd System Services:${NC}"
                for service_name in $system_services; do
                    systemctl status "$service_name.service" --no-pager -l || true
                    echo ""
                done
            fi
        fi
    fi

    # Show PM2 services
    if [ -z "$provider_filter" ] || [ "$provider_filter" = "pm2" ]; then
        local pm2_services=$(jq -r '.[] | select(.provider == "pm2") | .name' "$REGISTRY_FILE" 2>/dev/null)
        if [ -n "$pm2_services" ] && command -v pm2 >/dev/null 2>&1; then
            echo -e "\n${YELLOW}PM2 Services:${NC}"
            pm2 list
        fi
    fi
}

function service_action() {
    local action="$1"
    local service_name="$2"
    
    # Check if service exists
    local service_info=$(get_service_info "$service_name")
    if [ -z "$service_info" ]; then
        echo -e "${RED}Error: Service '$service_name' not found${NC}"
        return 1
    fi
    
    # Extract provider
    local provider=$(echo "$service_info" | jq -r '.provider')
    
    # Execute action
    if [ "$provider" = "pm2" ]; then
        pm2_service_action "$action" "$service_name"
    elif [ "$provider" = "systemd" ]; then
        systemd_service_action "$action" "$service_name"
    fi
}

function service_logs() {
    local service_name="$1"
    local follow="${2:-false}"
    
    # Check if service exists
    local service_info=$(get_service_info "$service_name")
    if [ -z "$service_info" ]; then
        echo -e "${RED}Error: Service '$service_name' not found${NC}"
        return 1
    fi
    
    # Extract provider
    local provider=$(echo "$service_info" | jq -r '.provider')
    
    # Show logs
    if [ "$provider" = "pm2" ]; then
        pm2_service_logs "$service_name" "$follow"
    elif [ "$provider" = "systemd" ]; then
        systemd_service_logs "$service_name" "$follow"
    fi
}

function edit_config() {
    local service_name="$1"
    
    # Check if service exists
    local service_info=$(get_service_info "$service_name")
    if [ -z "$service_info" ]; then
        echo -e "${RED}Error: Service '$service_name' not found${NC}"
        return 1
    fi
    
    # Get configuration file path
    local config_file="$CONFIG_DIR/$service_name.conf"
    
    # Load configuration to get run-engine config file
    source "$config_file"
    
    # Open run-engine configuration file in editor
    echo -e "${YELLOW}Editing run-engine configuration for: $service_name${NC}"
    echo -e "${BLUE}File: ${RUN_ENGINE_CONFIG_FILE:-<unset>}${NC}"
    if [ -z "${RUN_ENGINE_CONFIG_FILE:-}" ] || [ ! -f "$RUN_ENGINE_CONFIG_FILE" ]; then
        echo -e "${RED}Error: Run-engine configuration file not found: ${RUN_ENGINE_CONFIG_FILE:-<unset>}${NC}"
        return 1
    fi
    ${EDITOR:-nano} "$RUN_ENGINE_CONFIG_FILE"
    
    echo -e "${GREEN}Configuration updated. Run '$0 restart $service_name' to apply changes.${NC}"
}

function attach_to_service() {
    local service_name="$1"
    
    # Check if service exists
    local service_info=$(get_service_info "$service_name")
    if [ -z "$service_info" ]; then
        echo -e "${RED}Error: Service '$service_name' not found${NC}"
        return 1
    fi
    
    # Extract provider
    local provider=$(echo "$service_info" | jq -r '.provider')
    local config_file="$CONFIG_DIR/$service_name.conf"
    
    # Load configuration to get run-engine config file
    if [ ! -f "$config_file" ]; then
        echo -e "${RED}Error: Service configuration file not found: $config_file${NC}"
        return 1
    fi
    
    source "$config_file"
    
    # Load run-engine configuration
    if [ -z "${RUN_ENGINE_CONFIG_FILE:-}" ] || [ ! -f "$RUN_ENGINE_CONFIG_FILE" ]; then
        echo -e "${RED}Error: Run-engine configuration file not found: ${RUN_ENGINE_CONFIG_FILE:-<unset>}${NC}"
        return 1
    fi

    # Now safe to source
    source "$RUN_ENGINE_CONFIG_FILE"
    
    # Auto-detect session manager and attach accordingly
    if [ "$provider" = "pm2" ]; then
        # PM2 has built-in attach functionality
        attach_pm2_process "$service_name"
    else
        # For systemd, check session manager
        case "$SESSION_MANAGER" in
            "tmux")
                attach_tmux_session "$service_name" "$provider"
                ;;
            "screen")
                attach_screen_session "$service_name" "$provider"
                ;;
            "none"|"auto"|*)
                # No session manager - show helpful message for systemd
                attach_interactive_shell "$service_name" "$provider"
                ;;
        esac
    fi
}

#########################################
# Runtime helpers: status / send / show #
#########################################

function service_is_running() {
    local service_name="$1"

    local service_info=$(get_service_info "$service_name")
    if [ -z "$service_info" ]; then
        echo -e "${RED}Error: Service '$service_name' not found${NC}" >&2
        return 1
    fi

    local provider=$(echo "$service_info" | jq -r '.provider')

    if [ "$provider" = "pm2" ]; then
        # pm2 jlist -> JSON array with .name and .pm2_env.status
        if pm2 jlist | jq -e ".[] | select(.name==\"$service_name\" and .pm2_env.status==\"online\")" >/dev/null; then
            return 0
        else
            return 1
        fi
    elif [ "$provider" = "systemd" ]; then
        # Check user service first, then system
        if systemctl --user is-active --quiet "$service_name.service" 2>/dev/null; then
            return 0
        elif systemctl is-active --quiet "$service_name.service" 2>/dev/null; then
            return 0
        else
            return 1
        fi
    else
        return 1
    fi
}

function service_send_command() {
    local service_name="$1"; shift || true
    local cmd_str="$*"
    if [ -z "$service_name" ] || [ -z "$cmd_str" ]; then
        echo -e "${RED}Error: send requires <service-name> and <command>${NC}" >&2
        return 1
    fi

    local service_info=$(get_service_info "$service_name")
    if [ -z "$service_info" ]; then
        echo -e "${RED}Error: Service '$service_name' not found${NC}" >&2
        return 1
    fi

    local provider=$(echo "$service_info" | jq -r '.provider')
    local config_file="$CONFIG_DIR/$service_name.conf"

    if [ ! -f "$config_file" ]; then
        echo -e "${RED}Error: Service configuration file not found: $config_file${NC}" >&2
        return 1
    fi

    # Load run-engine config path
    # shellcheck source=/dev/null
    source "$config_file"
    if [ -z "${RUN_ENGINE_CONFIG_FILE:-}" ] || [ ! -f "$RUN_ENGINE_CONFIG_FILE" ]; then
        echo -e "${RED}Error: Run-engine configuration file not found for $service_name${NC}" >&2
        return 1
    fi

    # shellcheck source=/dev/null
    if ! source "$RUN_ENGINE_CONFIG_FILE"; then
        echo -e "${RED}Error: Failed to source run-engine configuration file: $RUN_ENGINE_CONFIG_FILE${NC}" >&2
        return 1
    fi

    local session_manager="${SESSION_MANAGER:-auto}"
    local session_name="${SESSION_NAME:-$service_name}"

    if [ "$provider" = "pm2" ]; then
        # Use pm2 send (requires pm2 >= 5)
        local pm2_id_json
        pm2_id_json=$(pm2 id "$service_name" 2>/dev/null || true)
        local numeric_id
        numeric_id=$(echo "$pm2_id_json" | jq -r '.[0] // empty')
        if [ -z "$numeric_id" ]; then
            echo -e "${RED}Error: PM2 process '$service_name' not found${NC}" >&2
            return 1
        fi
        echo -e "${YELLOW}Sending to PM2 process $service_name (ID: $numeric_id): $cmd_str${NC}"
        pm2 send "$numeric_id" "$cmd_str" ENTER
        return $?
    fi

    # systemd provider: need a session manager to interact with the console
    case "$session_manager" in
        tmux|auto)
            if command -v tmux >/dev/null 2>&1 && tmux has-session -t "$session_name" 2>/dev/null; then
                echo -e "${YELLOW}Sending to tmux session $session_name: $cmd_str${NC}"
                tmux send-keys -t "$session_name" "$cmd_str" C-m
                return $?
            elif [ "$session_manager" = "tmux" ]; then
                echo -e "${RED}Error: tmux session '$session_name' not available${NC}" >&2
                return 1
            fi
            ;;&
        screen|auto)
            if command -v screen >/dev/null 2>&1; then
                echo -e "${YELLOW}Sending to screen session $session_name: $cmd_str${NC}"
                screen -S "$session_name" -X stuff "$cmd_str\n"
                return $?
            elif [ "$session_manager" = "screen" ]; then
                echo -e "${RED}Error: screen not installed${NC}" >&2
                return 1
            fi
            ;;
        none|*)
            echo -e "${RED}Error: No session manager configured (SESSION_MANAGER=$session_manager). Cannot send command.${NC}" >&2
            return 1
            ;;
    esac

    echo -e "${RED}Error: Unable to find usable session (tmux/screen) to send command.${NC}" >&2
    return 1
}

function show_config() {
    local service_name="$1"
    if [ -z "$service_name" ]; then
        echo -e "${RED}Error: Service name required for show-config${NC}"
        return 1
    fi

    local service_info=$(get_service_info "$service_name")
    if [ -z "$service_info" ]; then
        echo -e "${RED}Error: Service '$service_name' not found${NC}"
        return 1
    fi

    local provider=$(echo "$service_info" | jq -r '.provider')
    local cfg_file="$CONFIG_DIR/$service_name.conf"
    echo -e "${BLUE}Service: $service_name${NC}"
    echo "Provider: $provider"
    echo "Config file: $cfg_file"
    if [ -f "$cfg_file" ]; then
        # shellcheck source=/dev/null
        source "$cfg_file"
        echo "RUN_ENGINE_CONFIG_FILE: ${RUN_ENGINE_CONFIG_FILE:-<none>}"
        if [ -n "${RUN_ENGINE_CONFIG_FILE:-}" ] && [ -f "$RUN_ENGINE_CONFIG_FILE" ]; then
            # shellcheck source=/dev/null
            source "$RUN_ENGINE_CONFIG_FILE"
            echo "Session manager: ${SESSION_MANAGER:-}"
            echo "Session name: ${SESSION_NAME:-}"
            echo "BINPATH: ${BINPATH:-}"
            echo "SERVERBIN: ${SERVERBIN:-}"
            echo "CONFIG: ${CONFIG:-}"
            echo "RESTART_POLICY: ${RESTART_POLICY:-}"
        fi
    else
        echo "Config file not found"
    fi
}

# Return uptime in seconds for a service (echo integer), non-zero exit if not running
function service_uptime_seconds() {
    local service_name="$1"
    local service_info=$(get_service_info "$service_name")
    if [ -z "$service_info" ]; then
        echo -e "${RED}Error: Service '$service_name' not found${NC}" >&2
        return 1
    fi

    local provider=$(echo "$service_info" | jq -r '.provider')

    if [ "$provider" = "pm2" ]; then
        check_pm2 || return 1
        local info_json
        info_json=$(pm2 jlist 2>/dev/null)
        local pm_uptime_ms
        pm_uptime_ms=$(echo "$info_json" | jq -r ".[] | select(.name==\"$service_name\").pm2_env.pm_uptime // empty")
        local status
        status=$(echo "$info_json" | jq -r ".[] | select(.name==\"$service_name\").pm2_env.status // empty")
        if [ -z "$pm_uptime_ms" ] || [ "$status" != "online" ]; then
            return 1
        fi
        # Current time in ms (fallback to seconds*1000 if %N unsupported)
        local now_ms
        if date +%s%N >/dev/null 2>&1; then
            now_ms=$(( $(date +%s%N) / 1000000 ))
        else
            now_ms=$(( $(date +%s) * 1000 ))
        fi
        local diff_ms=$(( now_ms - pm_uptime_ms ))
        [ "$diff_ms" -lt 0 ] && diff_ms=0
        echo $(( diff_ms / 1000 ))
        return 0
    elif [ "$provider" = "systemd" ]; then
        check_systemd || return 1
        local systemd_type="--user"
        [ -f "/etc/systemd/system/$service_name.service" ] && systemd_type="--system"

        # Get ActiveEnterTimestampMonotonic in usec and ActiveState
        local prop
        if [ "$systemd_type" = "--system" ]; then
            prop=$(systemctl show "$service_name.service" --property=ActiveEnterTimestampMonotonic,ActiveState 2>/dev/null)
        else
            prop=$(systemctl --user show "$service_name.service" --property=ActiveEnterTimestampMonotonic,ActiveState 2>/dev/null)
        fi
        local state
        state=$(echo "$prop" | awk -F= '/^ActiveState=/{print $2}')
        [ "$state" != "active" ] && return 1
        local enter_us
        enter_us=$(echo "$prop" | awk -F= '/^ActiveEnterTimestampMonotonic=/{print $2}')
        # Current monotonic time in seconds since boot
        local now_s
        now_s=$(cut -d' ' -f1 /proc/uptime)
        # Compute uptime = now_monotonic - enter_monotonic
        # enter_us may be empty on some systems; fallback to 0
        enter_us=${enter_us:-0}
        # Convert now_s to microseconds using awk for precision, then compute diff
        local diff_s
        diff_s=$(awk -v now="$now_s" -v enter="$enter_us" 'BEGIN{printf "%d", (now*1000000 - enter)/1000000}')
        [ "$diff_s" -lt 0 ] && diff_s=0
        echo "$diff_s"
        return 0
    fi

    return 1
}

# Wait until service has at least <min_seconds> uptime. Optional timeout seconds (default 120)
function wait_service_uptime() {
    local service_name="$1"
    local min_seconds="$2"
    local timeout="${3:-120}"
    local waited=0

    while [ "$waited" -le "$timeout" ]; do
        if secs=$(service_uptime_seconds "$service_name" 2>/dev/null); then
            if [ "$secs" -ge "$min_seconds" ]; then
                echo -e "${GREEN}Service '$service_name' has reached ${secs}s uptime (required: ${min_seconds}s)${NC}"
                return 0
            fi
        fi
        sleep 1
        waited=$((waited + 1))
    done
    # show service logs for debugging
    echo -e "${YELLOW}Service logs for '$service_name':${NC}"
    service_logs "$service_name" true
    echo -e "${RED}Timeout: $service_name did not reach ${min_seconds}s uptime within ${timeout}s${NC}" >&2
    return 1
}

function attach_pm2_process() {
    local service_name="$1"
    
    
    # First check if the service exists and get its ID
    local pm2_id=$(pm2 id "$service_name" 2>/dev/null)
    if [ -z "$pm2_id" ] || [ "$pm2_id" = "[]" ]; then
        echo -e "${RED}Error: PM2 process '$service_name' not found${NC}"
        return 1
    fi
    
    # Extract the numeric ID from the JSON response
    local numeric_id=$(echo "$pm2_id" | jq -r '.[0] // empty')
    if [ -z "$numeric_id" ]; then
        echo -e "${RED}Error: Could not determine PM2 process ID for '$service_name'${NC}"
        return 1
    fi
    
    echo -e "${YELLOW}Attaching to PM2 process: $service_name (ID: $numeric_id)${NC}"
    pm2 attach "$numeric_id"
}

function attach_interactive_shell() {
    local service_name="$1"
    local provider="$2"
    
    # For PM2, use PM2's attach functionality
    if [ "$provider" = "pm2" ]; then
        attach_pm2_process "$service_name"
        return $?
    fi
    
    # For systemd without session manager, show helpful message
    local service_info=$(get_service_info "$service_name")
    local config_file="$CONFIG_DIR/$service_name.conf"
    
    # Check if config file exists before sourcing
    if [ ! -f "$config_file" ]; then
        echo -e "${RED}Error: Service configuration file not found: $config_file${NC}"
        return 1
    fi
    
    source "$config_file"
    
    # Check if RUN_ENGINE_CONFIG_FILE exists before sourcing
    if [ -z "${RUN_ENGINE_CONFIG_FILE:-}" ] || [ ! -f "$RUN_ENGINE_CONFIG_FILE" ]; then
        echo -e "${RED}Error: Run-engine configuration file not found: ${RUN_ENGINE_CONFIG_FILE:-<unset>}${NC}"
        return 1
    fi
    
    source "$RUN_ENGINE_CONFIG_FILE"
    
    echo -e "${RED}Error: Cannot attach to systemd service '$service_name'${NC}"
    echo -e "${YELLOW}Interactive attachment for systemd requires a session manager (tmux or screen).${NC}"
    echo ""
    echo -e "${BLUE}Current session manager: $SESSION_MANAGER${NC}"
    echo ""
    echo -e "${YELLOW}To enable interactive attachment:${NC}"
    echo "  1. Update the service to use tmux or screen:"
    echo "     $0 update $service_name --session-manager tmux"
    echo "  2. Restart the service:"
    echo "     $0 restart $service_name"
    echo "  3. Then try attach again:"
    echo "     $0 attach $service_name"
    echo ""
    echo -e "${BLUE}Alternative: Use 'logs <service_name> --follow' to monitor the service:${NC}"
    echo "  $0 logs $service_name --follow"
    
    return 1
}

# Normalize existing registry entries to use relative paths for fields that
# represent filesystem paths (bin_path, server_config) and refresh exec command
# definitions to the new schema.
function normalize_registry_paths() {
    if [ ! -f "$REGISTRY_FILE" ]; then
        echo -e "${YELLOW}No registry file found at: $REGISTRY_FILE${NC}"
        return 0
    fi

    # Validate JSON
    if ! jq empty "$REGISTRY_FILE" >/dev/null 2>&1; then
        echo -e "${RED}Error: Invalid JSON in $REGISTRY_FILE${NC}"
        return 1
    fi

    local tmp_file
    tmp_file=$(mktemp)
    echo "[]" > "$tmp_file"

    local count=0
    while IFS= read -r entry; do
        [ -z "$entry" ] && continue

        # Extract raw values (empty if null or missing)
        local bin_path_raw server_config_raw
        bin_path_raw=$(echo "$entry" | jq -r '.bin_path // empty')
        server_config_raw=$(echo "$entry" | jq -r '.server_config // empty')

        # Compute normalized values
        local bin_path_new server_config_new
        if [ -n "$bin_path_raw" ]; then
            bin_path_new="$(make_path_relative "$bin_path_raw")"
        else
            bin_path_new=""
        fi
        if [ -n "$server_config_raw" ]; then
            server_config_new="$(make_path_relative "$server_config_raw")"
        else
            server_config_new=""
        fi

        local exec_command_raw
        exec_command_raw=$(echo "$entry" | jq -r '.exec.command // empty')
        local exec_args_array=()
        local exec_json_new="null"
        if [ -n "$exec_command_raw" ]; then
            while IFS= read -r arg; do
                exec_args_array+=("$arg")
            done < <(echo "$entry" | jq -r '.exec.args[]?')
            exec_json_new="$(serialize_exec_definition "$exec_command_raw" "${exec_args_array[@]}")"
        fi

        # Update entry (only override when non-empty; preserve nulls)
        local updated
        if [ "$exec_json_new" != "null" ]; then
            updated=$(echo "$entry" | jq \
                --arg bin "$bin_path_new" \
                --arg srv "$server_config_new" \
                --argjson exec "$exec_json_new" \
                '
                  (.bin_path)     |= (if $bin  != "" then $bin  else . end) |
                  (.server_config) |= (if $srv  != "" then $srv  else . end) |
                  (.exec)          =  $exec |
                  del(.real_bin_path)
                ')
        else
            updated=$(echo "$entry" | jq \
                --arg bin "$bin_path_new" \
                --arg srv "$server_config_new" \
                '
                  (.bin_path)     |= (if $bin  != "" then $bin  else . end) |
                  (.server_config) |= (if $srv  != "" then $srv  else . end) |
                  del(.real_bin_path)
                ')
        fi

        # Append to new array
        if ! jq --argjson e "$updated" '. += [$e]' "$tmp_file" > "$tmp_file.new"; then
            rm -f "$tmp_file" "$tmp_file.new"
            echo -e "${RED}Error: Failed updating registry${NC}"
            return 1
        fi
        mv "$tmp_file.new" "$tmp_file"
        count=$((count+1))
    done < <(jq -c '.[]?' "$REGISTRY_FILE")

    mv "$tmp_file" "$REGISTRY_FILE"
    echo -e "${GREEN}Normalized $count registry entrie(s) to relative paths${NC}"
}

function attach_tmux_session() {
    local service_name="$1"
    local provider="$2"
    
    # Check if tmux is available
    if ! command -v tmux >/dev/null 2>&1; then
        echo -e "${RED}Error: tmux is not installed${NC}"
        echo -e "${BLUE}Starting interactive session without tmux...${NC}"
        attach_interactive_shell "$service_name" "$provider"
        return
    fi
    
    # Try to attach to tmux session
    local tmux_session="$service_name"
    echo -e "${YELLOW}Attempting to attach to tmux session: $tmux_session${NC}"
    
    if tmux has-session -t "$tmux_session" 2>/dev/null; then
        echo -e "${GREEN}Attaching to tmux session...${NC}"
        tmux attach-session -t "$tmux_session"
    else
        echo -e "${RED}Error: tmux session '$tmux_session' not found${NC}"
        echo -e "${YELLOW}Available tmux sessions:${NC}"
        tmux list-sessions 2>/dev/null || echo "No active tmux sessions (is it stopped or restarting?)"
    fi
}

function attach_screen_session() {
    local service_name="$1"
    local provider="$2"
    
    # Check if screen is available
    if ! command -v screen >/dev/null 2>&1; then
        echo -e "${RED}Error: screen is not installed${NC}"
        echo -e "${BLUE}Starting interactive session without screen...${NC}"
        attach_interactive_shell "$service_name" "$provider"
        return
    fi
    
    # Try to attach to screen session
    local screen_session="$service_name"
    echo -e "${YELLOW}Attempting to attach to screen session: $screen_session${NC}"
    
    if screen -list | grep -q "$screen_session"; then
        echo -e "${GREEN}Attaching to screen session...${NC}"
        screen -r "$screen_session"
    else
        echo -e "${RED}Error: screen session '$screen_session' not found${NC}"
        echo -e "${YELLOW}Available screen sessions:${NC}"
        screen -list 2>/dev/null || echo "No active screen sessions (is it stopped or restarting?)"
    fi
}




# Main execution
# Only run the main logic if this script is executed directly (not sourced)
if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
    check_dependencies

    # Main command processing
    case "${1:-help}" in
    create)
        if [ $# -lt 3 ]; then
            echo -e "${RED}Error: Not enough arguments for create command${NC}"
            print_help
            exit 1
        fi
        create_service "$2" "$3" "${@:4}"
        ;;
    update)
        if [ $# -lt 2 ]; then
            echo -e "${RED}Error: Service name required for update command${NC}"
            print_help
            exit 1
        fi
        update_service "$2" "${@:3}"
        ;;
    delete)
        if [ $# -lt 2 ]; then
            echo -e "${RED}Error: Service name required for delete command${NC}"
            print_help
            exit 1
        fi
        delete_service "$2"
        ;;
    list)
        list_services "${2:-}"
        ;;
    restore)
        sync_only=false
        if [ $# -gt 1 ]; then
            for opt in "${@:2}"; do
                case "$opt" in
                    --sync-only)
                        sync_only=true
                        ;;
                    *)
                        echo -e "${RED}Error: Unknown option for restore command: $opt${NC}"
                        print_help
                        exit 1
                        ;;
                esac
            done
        fi
        normalize_registry_paths
        sync_service_configs_from_registry
        if [ "$sync_only" = "false" ]; then
            restore_missing_services
        fi
        ;;
    start|stop|restart|status)
        if [ $# -lt 2 ]; then
            echo -e "${RED}Error: Service name required for $1 command${NC}"
            print_help
            exit 1
        fi
        service_action "$1" "$2"
        ;;
    logs)
        if [ $# -lt 2 ]; then
            echo -e "${RED}Error: Service name required for logs command${NC}"
            print_help
            exit 1
        fi
        if [ "${3:-}" = "--follow" ]; then
            service_logs "$2" "true"
        else
            service_logs "$2" "false"
        fi
        ;;
    registry-normalize)
        normalize_registry_paths
        ;;
    edit-config)
        if [ $# -lt 2 ]; then
            echo -e "${RED}Error: Service name required for edit-config command${NC}"
            print_help
            exit 1
        fi
        edit_config "$2"
        ;;
    attach)
        if [ $# -lt 2 ]; then
            echo -e "${RED}Error: Service name required for attach command${NC}"
            print_help
            exit 1
        fi
        attach_to_service "$2"
        ;;
    uptime-seconds)
        if [ $# -lt 2 ]; then
            echo -e "${RED}Error: Service name required for uptime-seconds command${NC}"
            print_help
            exit 1
        fi
        service_uptime_seconds "$2"
        ;;
    wait-uptime)
        if [ $# -lt 3 ]; then
            echo -e "${RED}Error: Usage: $0 wait-uptime <service-name> <min-seconds> [timeout]${NC}"
            print_help
            exit 1
        fi
        wait_service_uptime "$2" "$3" "${4:-120}"
        ;;
    is-running)
        if [ $# -lt 2 ]; then
            echo -e "${RED}Error: Service name required for is-running command${NC}"
            print_help
            exit 1
        fi
        if service_is_running "$2"; then
            echo -e "${GREEN}Service '$2' is running${NC}"
            exit 0
        else
            echo -e "${YELLOW}Service '$2' is not running${NC}"
            exit 1
        fi
        ;;
    send)
        if [ $# -lt 3 ]; then
            echo -e "${RED}Error: Not enough arguments for send command${NC}"
            print_help
            exit 1
        fi
        service_send_command "$2" "${@:3}"
        ;;
    show-config)
        if [ $# -lt 2 ]; then
            echo -e "${RED}Error: Service name required for show-config command${NC}"
            print_help
            exit 1
        fi
        show_config "$2"
        ;;
    help|--help|-h)
        print_help
        ;;
    *)
        echo -e "${RED}Error: Unknown command: $1${NC}"
        print_help
        exit 1
        ;;
esac

fi  # End of main execution block
