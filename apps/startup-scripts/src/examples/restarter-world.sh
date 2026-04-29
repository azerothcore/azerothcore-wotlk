#!/usr/bin/env bash

# AzerothCore World Server Restarter Example
# This example shows how to use the run-engine with restart functionality for worldserver

PATH_RUNENGINE="./"
CONFIG_FILE="./conf-world.sh"

# Method 1: Using configuration file (recommended)
if [ -f "$CONFIG_FILE" ]; then
    echo "Starting worldserver with restart loop using config file: $CONFIG_FILE"
    "$PATH_RUNENGINE/run-engine" restart "$SERVERBIN" --config "$CONFIG_FILE"
else
    echo "Error: Configuration file not found: $CONFIG_FILE"
    echo "Please create $CONFIG_FILE by copying and modifying conf.sh.dist"
    echo "Make sure to set: export SERVERBIN=\"worldserver\""
    echo ""
    echo "Alternative: Start with binary path directly"
    echo "Example: $PATH_RUNENGINE/run-engine restart /path/to/bin/worldserver"
    echo "Example: $PATH_RUNENGINE/run-engine restart worldserver  # if in PATH"
    exit 1
fi

# Method 2: Direct binary path (full path)
# Uncomment the line below to start with full binary path
#
# "$PATH_RUNENGINE/run-engine" restart /home/user/azerothcore/bin/worldserver --server-config /path/to/worldserver.conf

# Method 3: Binary name only (system PATH)
# Uncomment the line below if worldserver is in your system PATH
#
# "$PATH_RUNENGINE/run-engine" restart worldserver --server-config /path/to/worldserver.conf

# Method 4: With session manager (tmux/screen)
# Uncomment the line below to use tmux session
#
# "$PATH_RUNENGINE/run-engine" restart worldserver --session-manager tmux --server-config /path/to/worldserver.conf

# Method 5: Environment variables only
# Uncomment the lines below for environment variable configuration
#
# export RUN_ENGINE_BINPATH="/path/to/your/bin"
# export RUN_ENGINE_SERVERBIN="worldserver"
# export RUN_ENGINE_CONFIG="/path/to/worldserver.conf"
# "$PATH_RUNENGINE/run-engine" restart worldserver


