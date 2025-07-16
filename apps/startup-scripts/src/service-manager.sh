#!/usr/bin/env bash

# AzerothCore Service Setup
# A unified interface for managing AzerothCore services with PM2 or systemd
# This script provides commands to create, update, delete, and manage server instances

# Script location
CURRENT_PATH="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

SCRIPT_DIR="$CURRENT_PATH"

ROOT_DIR="$(cd "$CURRENT_PATH/../../.." && pwd)"

# Configuration directory
CONFIG_DIR="${XDG_CONFIG_HOME:-$HOME/.config}/azerothcore/services"
REGISTRY_FILE="$CONFIG_DIR/service_registry.json"

# Colors for output
YELLOW='\033[1;33m'
GREEN='\033[0;32m'
RED='\033[0;31m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Create config directory if it doesn't exist
mkdir -p "$CONFIG_DIR"

# Initialize registry if it doesn't exist
if [ ! -f "$REGISTRY_FILE" ]; then
    echo "[]" > "$REGISTRY_FILE"
fi

# Check dependencies
check_dependencies() {
    command -v jq >/dev/null 2>&1 || { 
        echo -e "${RED}Error: jq is required but not installed. Please install jq package.${NC}"
        exit 1
    }
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
    echo "  $base_name start|stop|restart|status <service-name>"
    echo "  $base_name logs <service-name> [--follow]"
    echo "  $base_name attach <service-name>"
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
}

function register_service() {
    local service_name="$1"
    local provider="$2"
    local service_type="$3"
    local config_file="$CONFIG_DIR/$service_name.conf"
    
    # Add to registry
    local tmp_file=$(mktemp)
    jq --arg name "$service_name" \
       --arg provider "$provider" \
       --arg type "$service_type" \
       --arg config "$config_file" \
       '. += [{"name": $name, "provider": $provider, "type": $type, "config": $config}]' \
       "$REGISTRY_FILE" > "$tmp_file"
    mv "$tmp_file" "$REGISTRY_FILE"
    
    echo -e "${GREEN}Service $service_name registered successfully${NC}"
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
    
    local services=$(jq -c '.[]' "$REGISTRY_FILE")
    local tmp_file=$(mktemp)
    
    # Initialize with empty array
    echo "[]" > "$tmp_file"
    
    # Check each service in registry
    while read -r service_info; do
        if [ -n "$service_info" ]; then
            local name=$(echo "$service_info" | jq -r '.name')
            local provider=$(echo "$service_info" | jq -r '.provider')
            
            if validate_service_exists "$name" "$provider"; then
                # Service exists, add it to the new registry
                jq --argjson service "$service_info" '. += [$service]' "$tmp_file" > "$tmp_file.new"
                mv "$tmp_file.new" "$tmp_file"
            else
                echo -e "${YELLOW}Service '$name' no longer exists. Removing from registry.${NC}"
                # Don't add to new registry
            fi
        fi
    done <<< "$services"
    
    # Replace registry with synced version
    mv "$tmp_file" "$REGISTRY_FILE"
    echo -e "${GREEN}Registry synchronized.${NC}"
}

function unregister_service() {
    local service_name="$1"
    
    # Remove from registry
    local tmp_file=$(mktemp)
    jq --arg name "$service_name" '. | map(select(.name != $name))' "$REGISTRY_FILE" > "$tmp_file"
    mv "$tmp_file" "$REGISTRY_FILE"
    
    # Remove configuration file
    rm -f "$CONFIG_DIR/$service_name.conf"
    
    echo -e "${GREEN}Service $service_name unregistered${NC}"
}

function get_service_info() {
    local service_name="$1"
    jq --arg name "$service_name" '.[] | select(.name == $name)' "$REGISTRY_FILE"
}

# PM2 service management functions
function pm2_create_service() {
    local service_name="$1"
    local command="$2"
    local restart_policy="$3"
    shift 3
    
    check_pm2 || return 1
    
    # Parse additional PM2 options
    local max_memory=""
    local max_restarts=""
    local additional_args=""
    
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
                additional_args+=" $1"
                shift
                ;;
        esac
    done
    

    # Set stop exit codes based on restart policy
    local stop_exit_codes=""
    if [ "$restart_policy" = "always" ]; then
        # PM2 will restart on any exit code (including 0)
        stop_exit_codes=""
    else
        # PM2 will not restart on clean shutdown (exit code 0)
        stop_exit_codes=" --stop-exit-codes 0"
    fi
    # Build PM2 start command with AzerothCore environment variable
    local pm2_cmd="AC_LAUNCHED_BY_PM2=1 pm2 start '$command$additional_args' --name '$service_name'$stop_exit_codes"
    
    # Add memory limit if specified
    if [ -n "$max_memory" ]; then
        pm2_cmd+=" --max-memory-restart $max_memory"
    fi
    
    # Add max restarts if specified
    if [ -n "$max_restarts" ]; then
        pm2_cmd+=" --max-restarts $max_restarts"
    fi
    
    # Execute command
    echo -e "${YELLOW}Creating PM2 service: $service_name${NC}"
    
    if eval "$pm2_cmd"; then
        echo -e "${GREEN}PM2 service '$service_name' created successfully${NC}"
        pm2 save
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
        pm2 stop "$service_name" 2>/dev/null || true
        pm2 delete "$service_name" 2>/dev/null 
        
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
    else
        echo -e "${YELLOW}PM2 service '$service_name' not found or already removed${NC}"
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
    local systemd_type="--user"
    shift 3
    
    check_systemd || return 1
    
    # Parse systemd type
    while [[ $# -gt 0 ]]; do
        case "$1" in
            --system|--user)
                systemd_type="$1"
                shift
                ;;
            *)
                command+=" $1"
                shift
                ;;
        esac
    done
    
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
WorkingDirectory=$(realpath "$bin_path")
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
WorkingDirectory=$(realpath "$bin_path")
StandardOutput=journal+console
StandardError=journal+console

[Install]
WantedBy=default.target
EOF
    fi

    if [ "$systemd_type" = "--system" ]; then
        sed -i 's/WantedBy=default.target/WantedBy=multi-user.target/' "$service_file"
    fi
    
    # Reload systemd and enable service
    if [ "$systemd_type" = "--system" ]; then
        systemctl daemon-reload
        systemctl enable "$service_name.service"
    else
        systemctl --user daemon-reload
        systemctl --user enable "$service_name.service"
    fi
    
    echo -e "${GREEN}Systemd service '$service_name' created successfully${NC}"
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
    local bin_path="$BINPATH/bin" # get from config or environment
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
    
    # Build run-engine command
    local run_engine_cmd="$SCRIPT_DIR/run-engine start $server_binary_path --config $run_engine_config"
    
    # Create the actual service
    local service_creation_success=false
    if [ "$provider" = "pm2" ]; then
        if [ -n "$pm2_opts" ]; then
            if pm2_create_service "$service_name" "$run_engine_cmd" "$restart_policy" $pm2_opts; then
                service_creation_success=true
            fi
        else
            if pm2_create_service "$service_name" "$run_engine_cmd" "$restart_policy"; then
                service_creation_success=true
            fi
        fi
        
    elif [ "$provider" = "systemd" ]; then
        if systemd_create_service "$service_name" "$run_engine_cmd" "$restart_policy" "$systemd_type"; then
            service_creation_success=true
        fi
    fi
    
    # Check if service creation was successful
    if [ "$service_creation_success" = "true" ]; then
        # Register the service
        register_service "$service_name" "$provider" "$service_type"
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
    local config_file=$(echo "$service_info" | jq -r '.config')
    
    # Load current configuration
    source "$config_file"
    
    # Load current run-engine configuration
    if [ -f "$RUN_ENGINE_CONFIG_FILE" ]; then
        source "$RUN_ENGINE_CONFIG_FILE"
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
    local config_file=$(echo "$service_info" | jq -r '.config')
    
    # Load configuration to get run-engine config file
    if [ -f "$config_file" ]; then
        source "$config_file"
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
        # Remove run-engine configuration file
        if [ -n "$RUN_ENGINE_CONFIG_FILE" ] && [ -f "$RUN_ENGINE_CONFIG_FILE" ]; then
            rm -f "$RUN_ENGINE_CONFIG_FILE"
            echo -e "${GREEN}Removed run-engine config: $RUN_ENGINE_CONFIG_FILE${NC}"
        fi
        
        # Unregister service
        unregister_service "$service_name"
        echo -e "${GREEN}Service '$service_name' deleted successfully${NC}"
    else
        echo -e "${RED}Failed to remove service '$service_name' from $provider${NC}"
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
    local config_file=$(echo "$service_info" | jq -r '.config')
    
    # Load configuration to get run-engine config file
    source "$config_file"
    
    # Open run-engine configuration file in editor
    echo -e "${YELLOW}Editing run-engine configuration for: $service_name${NC}"
    echo -e "${BLUE}File: $RUN_ENGINE_CONFIG_FILE${NC}"
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
    local config_file=$(echo "$service_info" | jq -r '.config')
    
    # Load configuration to get run-engine config file
    if [ ! -f "$config_file" ]; then
        echo -e "${RED}Error: Service configuration file not found: $config_file${NC}"
        return 1
    fi
    
    source "$config_file"
    
    # Load run-engine configuration
    if [ ! -f "$RUN_ENGINE_CONFIG_FILE" ]; then
        echo -e "${RED}Error: Run-engine configuration file not found: $RUN_ENGINE_CONFIG_FILE${NC}"
        return 1
    fi
    
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
    local config_file=$(echo "$service_info" | jq -r '.config')
    
    source "$config_file"
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
        list_services "$2"
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
        if [ "$3" = "--follow" ]; then
            service_logs "$2" "true"
        else
            service_logs "$2" "false"
        fi
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
    help|--help|-h)
        print_help
        ;;
    *)
        echo -e "${RED}Error: Unknown command: $1${NC}"
        print_help
        exit 1
        ;;
esac
