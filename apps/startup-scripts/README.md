# AzerothCore Startup Scripts

A comprehensive suite of scripts for managing AzerothCore server instances with advanced session management, automatic restart capabilities, and production-ready service management.

## 📋 Table of Contents

- [Overview](#overview)
- [Components](#components)
- [Quick Start](#quick-start)
- [Configuration](#configuration)
- [Detailed Usage](#detailed-usage)
- [Multiple Realms Setup](#multiple-realms-setup)
- [Service Management](#service-management)
- [Troubleshooting](#troubleshooting)

## 🎯 Overview

The AzerothCore startup scripts provide multiple approaches to running server instances:

1. **Development/Testing**: Simple execution for debugging and development
2. **Production with Restarts**: Automatic restart on crashes with crash detection
3. **Background Services**: Production-ready service management with PM2 or systemd
4. **Session Management**: Interactive console access via tmux/screen

All scripts are integrated into the `acore.sh` dashboard for easy access.

### 📦 Automatic Deployment

**Important**: When you compile AzerothCore using the acore dashboard (`./acore.sh compiler build`), all startup scripts are automatically copied from `apps/startup-scripts/src/` to your `bin/` folder. This means:

- ✅ **Portable Deployment**: You can copy the entire `bin/` folder to different servers
- ✅ **Self-Contained**: All restart and service management tools travel with your binaries  
- ✅ **No Additional Setup**: Scripts work immediately after deployment
- ✅ **Production Ready**: Deploy to production servers without needing the full source code

This makes it easy to deploy your compiled binaries along with the management scripts to production environments where you may not have the full AzerothCore source code.

## 🔧 Components

### Core Scripts

- **`run-engine`**: Advanced script with session management and configuration priority
- **`simple-restarter`**: Wrapper around starter with restart functionality (legacy compatibility)
- **`starter`**: Basic binary execution with optional GDB support
- **`service-manager.sh`**: Production service management with PM2/systemd

### Configuration

- **`conf.sh.dist`**: Default configuration template
- **`conf.sh`**: User configuration (create from .dist)
- **`gdb.conf`**: GDB debugging configuration

### Examples

- **`restarter-auth.sh`**: Auth server restart example
- **`restarter-world.sh`**: World server restart example
- **`starter-auth.sh`**: Auth server basic start example
- **`starter-world.sh`**: World server basic start example

## 🚀 Quick Start

### 1. Basic Server Start (Development)

```bash
# Start authserver directly
./starter /path/to/bin authserver

# Start worldserver with config
./starter /path/to/bin worldserver "" /path/to/worldserver.conf
```

### 2. Start with Auto-Restart

```bash
# Using simple-restarter (legacy)
./simple-restarter /path/to/bin authserver

# Using run-engine (recommended)
./run-engine restart authserver --bin-path /path/to/bin
```

### 3. Production Service Management

```bash
# Create and start a service
./service-manager.sh create auth authserver --bin-path /path/to/bin

# List all services
./service-manager.sh list

# Stop a service
./service-manager.sh stop auth
```

### 4. Using acore.sh Dashboard

```bash
# Interactive dashboard
./acore.sh

# Direct commands
./acore.sh run-authserver    # Start authserver with restart
./acore.sh run-worldserver   # Start worldserver with restart
./acore.sh service-manager   # Access service manager
```

## ⚙️ Configuration

### Configuration Priority (Highest to Lowest)

1. **`conf.sh`** - User configuration file
2. **Command line arguments** - Runtime parameters
3. **Environment variables** - `RUN_ENGINE_*` variables
4. **`conf.sh.dist`** - Default configuration

### Creating Configuration

```bash
# Copy default configuration
cp scripts/conf.sh.dist scripts/conf.sh

# Edit your configuration
nano scripts/conf.sh
```

### Key Configuration Options

```bash
# Binary settings
export BINPATH="/path/to/azerothcore/bin"
export SERVERBIN="worldserver"  # or "authserver"
export CONFIG="/path/to/worldserver.conf"

# Session management
export SESSION_MANAGER="tmux"  # none|auto|tmux|screen
export SESSION_NAME="ac-world"

# Interactive mode control
export AC_DISABLE_INTERACTIVE="0"  # Set to 1 to disable interactive prompts (useful for non-interactive services)

# Debugging
export GDB_ENABLED="1"  # 0 or 1
export GDB="/path/to/gdb.conf"

# Logging
export LOGS_PATH="/path/to/logs"
export CRASHES_PATH="/path/to/crashes"
export LOG_PREFIX_NAME="realm1"
```

## 📖 Detailed Usage

### 1. Run Engine

The `run-engine` is the most advanced script with multiple operation modes:

#### Basic Execution
```bash
# Start server once
./run-engine start worldserver --bin-path /path/to/bin

# Start with configuration file
./run-engine start worldserver --config ./conf-world.sh

# Start with specific server config
./run-engine start worldserver --server-config /path/to/worldserver.conf
```

#### Restart Mode
```bash
# Automatic restart on crash
./run-engine restart worldserver --bin-path /path/to/bin

# Restart with session management
./run-engine restart worldserver --session-manager tmux
```

#### Session Management
```bash
# Start in tmux session
./run-engine start worldserver --session-manager tmux

# Attach to existing session
tmux attach-session -t worldserver

# Start in screen session
./run-engine start worldserver --session-manager screen

# Attach to screen session
screen -r worldserver
```

#### Configuration Options
```bash
./run-engine restart worldserver \
  --bin-path /path/to/bin \
  --server-config /path/to/worldserver.conf \
  --session-manager tmux \
  --gdb-enabled 1 \
  --logs-path /path/to/logs \
  --crashes-path /path/to/crashes
```

### 2. Simple Restarter

Legacy-compatible wrapper with restart functionality:

```bash
# Basic restart
./simple-restarter /path/to/bin worldserver

# With full parameters
./simple-restarter \
  /path/to/bin \
  worldserver \
  ./gdb.conf \
  /path/to/worldserver.conf \
  /path/to/system.log \
  /path/to/system.err \
  1 \
  /path/to/crashes
```

**Parameters:**
1. Binary path (required)
2. Binary name (required)
3. GDB configuration file (optional)
4. Server configuration file (optional)
5. System log file (optional)
6. System error file (optional)
7. GDB enabled flag (0/1, optional)
8. Crashes directory path (optional)

### 3. Starter

Basic execution script without restart functionality:

```bash
# Simple start
./starter /path/to/bin worldserver

# With GDB debugging
./starter /path/to/bin worldserver ./gdb.conf /path/to/worldserver.conf "" "" 1
```

### 4. Service Manager

Production-ready service management:

#### Creating Services
```bash
# Auto-detect provider (PM2 or systemd)
./service-manager.sh create auth authserver --bin-path /path/to/bin

# Force PM2
./service-manager.sh create world worldserver --provider pm2 --bin-path /path/to/bin

# Force systemd
./service-manager.sh create world worldserver --provider systemd --bin-path /path/to/bin

# Create service with restart policy
./service-manager.sh create world worldserver --bin-path /path/to/bin --restart-policy always
```

#### Restart Policies

Services support two restart policies:

- **`on-failure`** (default): Restart only on crashes or errors (exit code != 0, only works with PM2 or systemd without tmux/screen)
- **`always`**: Restart on any exit, including clean shutdown (exit code 0)

**Important**: When using `--restart-policy always`, the in-game command `server shutdown X` will behave like `server restart X` - the service will automatically restart after shutdown. Only the shutdown message differs from a restart message.

```bash
# Service that restarts only on crashes (default behavior)
./service-manager.sh create auth authserver --bin-path /path/to/bin --restart-policy on-failure

# Service that always restarts (even on manual shutdown)
./service-manager.sh create world worldserver --bin-path /path/to/bin --restart-policy always

# Update existing service restart policy
./service-manager.sh update worldserver --restart-policy always
```

#### Service Operations
```bash
# Start/stop services
./service-manager.sh start auth
./service-manager.sh stop world
./service-manager.sh restart auth

# View logs
./service-manager.sh logs world
./service-manager.sh logs world --follow

# Attach to console (interactive)
./service-manager.sh attach world

# List services
./service-manager.sh list
./service-manager.sh list pm2
./service-manager.sh list systemd

# Delete service
./service-manager.sh delete auth
```

#### Health and Console Commands

Use these commands to programmatically check service health and interact with the console (used by CI workflows):

```bash
# Check if service is currently running (exit 0 if running)
./service-manager.sh is-running world

# Print current uptime in seconds (fails if not running)
./service-manager.sh uptime-seconds world

# Wait until uptime >= 10s (optional timeout 240s)
./service-manager.sh wait-uptime world 10 240

# Send a console command (uses pm2 send or tmux/screen)
./service-manager.sh send world "server info"

# Show provider, configs and run-engine settings
./service-manager.sh show-config world
```

Notes:
- For `send`, PM2 provider uses `pm2 send` with the process ID; systemd provider requires a session manager (tmux/screen). If no attachable session is configured, the command fails.
- `wait-uptime` fails with a non-zero exit code if the service does not reach the requested uptime within the timeout window.

#### Service Configuration
```bash
# Update service settings
./service-manager.sh update world --session-manager screen --gdb-enabled 1

# Edit configuration
./service-manager.sh edit world

# Restore missing services from registry
./service-manager.sh restore
```

## 🌍 Multiple Realms Setup

### Method 1: Using Service Manager (Recommended)

```bash
# Create multiple world server instances with different restart policies
./service-manager.sh create world1 worldserver \
  --bin-path /path/to/bin \
  --server-config /path/to/worldserver-realm1.conf \
  --restart-policy on-failure

./service-manager.sh create world2 worldserver \
  --bin-path /path/to/bin \
  --server-config /path/to/worldserver-realm2.conf \
  --restart-policy always

# Single auth server for all realms (always restart for stability)
./service-manager.sh create auth authserver \
  --bin-path /path/to/bin \
  --server-config /path/to/authserver.conf \
  --restart-policy always
```

### Method 2: Using Run Engine with Different Configurations

Create separate configuration files for each realm:

**conf-realm1.sh:**
```bash
export BINPATH="/path/to/bin"
export SERVERBIN="worldserver"
export CONFIG="/path/to/worldserver-realm1.conf"
export SESSION_NAME="ac-realm1"
export LOG_PREFIX_NAME="realm1"
export LOGS_PATH="/path/to/logs/realm1"
```

**conf-realm2.sh:**
```bash
export BINPATH="/path/to/bin"
export SERVERBIN="worldserver"
export CONFIG="/path/to/worldserver-realm2.conf"
export SESSION_NAME="ac-realm2"
export LOG_PREFIX_NAME="realm2"
export LOGS_PATH="/path/to/logs/realm2"
```

Start each realm:
```bash
./run-engine restart worldserver --config ./conf-realm1.sh
./run-engine restart worldserver --config ./conf-realm2.sh
```

### Method 3: Using Examples with Custom Configurations

Copy and modify the example scripts:

```bash
# Copy examples
cp examples/restarter-world.sh restarter-realm1.sh
cp examples/restarter-world.sh restarter-realm2.sh

# Edit each script to point to different configuration files
# Then run:
./restarter-realm1.sh
./restarter-realm2.sh
```

## 🛠️ Service Management

### Service Registry and Persistence

The service manager includes a comprehensive registry system that tracks all created services and enables automatic restoration:

#### Service Registry Features

- **Automatic Tracking**: All services are automatically registered when created
- **Cross-Reboot Persistence**: PM2 services are configured with startup persistence
- **Service Restoration**: Missing services can be detected and restored from registry
- **Migration Support**: Legacy service configurations can be migrated to the new format

#### Using the Registry

```bash
# Check for missing services and restore them
./service-manager.sh restore

# List all registered services (includes status)
./service-manager.sh list

# Services are automatically added to registry on creation
./service-manager.sh create auth authserver --bin-path /path/to/bin
```

#### Custom Configuration Directories

You can customize where service configurations and PM2/systemd files are stored:

```bash
# Set custom directories
export AC_SERVICE_CONFIG_DIR="/path/to/your/project/services"

# Now all service operations will use these custom directories
./service-manager.sh create auth authserver --bin-path /path/to/bin
```

This is particularly useful for:
- **Version Control**: Keep service configurations in your project repository
- **Multiple Projects**: Separate service configurations per project
- **Team Collaboration**: Share service setups across development teams

#### Service Configuration Portability

The service manager automatically stores binary and configuration paths as relative paths when they are located under the `AC_SERVICE_CONFIG_DIR`, making service configurations portable across environments:

```bash
# Set up a portable project structure
export AC_SERVICE_CONFIG_DIR="/opt/myproject/services"
mkdir -p "$AC_SERVICE_CONFIG_DIR"/{bin,etc}

# Copy your binaries and configs
cp /path/to/compiled/authserver "$AC_SERVICE_CONFIG_DIR/bin/"
cp /path/to/authserver.conf "$AC_SERVICE_CONFIG_DIR/etc/"

# Create service - paths under AC_SERVICE_CONFIG_DIR will be stored as relative
./service-manager.sh create auth authserver \
  --bin-path "$AC_SERVICE_CONFIG_DIR/bin" \
  --server-config "$AC_SERVICE_CONFIG_DIR/etc/authserver.conf"

# Registry will contain relative paths like "bin/authserver" and "etc/authserver.conf"
# instead of absolute paths, making the entire directory portable
```

**Benefits:**
- **Environment Independence**: Move the entire services directory between machines
- **Container Friendly**: Perfect for Docker volumes and bind mounts
- **Backup/Restore**: Archive and restore complete service configurations
- **Development/Production Parity**: Same relative structure across environments

**How it works:**
- Paths under `AC_SERVICE_CONFIG_DIR` are automatically stored as relative paths
- Paths outside `AC_SERVICE_CONFIG_DIR` are stored as absolute paths for safety
- When services are restored or started, relative paths are resolved from `AC_SERVICE_CONFIG_DIR`
- If `AC_SERVICE_CONFIG_DIR` is not set, all paths are stored as absolute paths (traditional behavior)

#### Migration from Legacy Format

If you have existing services in the old format, use the migration script:

```bash
# Migrate existing registry to new format
./migrate-registry.sh

# The script will:
# - Detect old format automatically
# - Create a backup of the old registry
# - Convert to new format with proper tracking
# - Preserve all existing service information
```

### PM2 Services

When using PM2 as the service provider:

* [PM2 CLI Documentation](https://pm2.io/docs/runtime/reference/pm2-cli/)

**Automatic PM2 Persistence**: The service manager automatically configures PM2 for persistence across reboots by:
- Running `pm2 startup` to set up the startup script
- Running `pm2 save` after each service creation/modification
- This ensures your services automatically start when the system reboots

NOTE: pm2 cannot run tmux/screen sessions, but you can always use the `attach` command to connect to the service console because pm2 supports interactive mode.

### Environment Variables

The startup scripts recognize several environment variables for configuration and runtime behavior:

#### Configuration Directory Variables

- **`AC_SERVICE_CONFIG_DIR`**: Override the default configuration directory for services registry and configurations
  - Default: `${XDG_CONFIG_HOME:-$HOME/.config}/azerothcore/services`
  - Used for storing service registry and run-engine configurations

#### Service Detection Variables

- **`AC_LAUNCHED_BY_PM2`**: Set to `1` when launched by PM2 (automatically set by service-manager)
  - Disables the use of the `unbuffer` command for output capture
  - Enables non-interactive mode to prevent prompts
  - More robust than relying on PM2's internal variables
  
- **`AC_DISABLE_INTERACTIVE`**: Controls interactive mode (0=enabled, 1=disabled)
  - Automatically set based on execution context
  - Prevents AzerothCore from showing interactive prompts in service environments

#### Configuration Variables

- **`RUN_ENGINE_*`**: See [Configuration](#configuration) section for complete list
- **`SERVICE_MODE`**: Set to `true` to enable service-specific behavior
- **`SESSION_MANAGER`**: Override session manager choice (tmux, screen, none, auto)

### Systemd Services

When using systemd as the service provider:

```bash
# Systemd commands
systemctl --user status acore-auth     # Check status
systemctl --user logs acore-auth       # View logs
systemctl --user restart acore-auth    # Restart
systemctl --user enable acore-auth     # Enable auto-start

# For system services (requires sudo)
sudo systemctl status acore-auth
sudo systemctl enable acore-auth
```

**Enhanced systemd Integration:**
- **Automatic Service Type**: When using session managers (tmux/screen), services are automatically configured with `Type=forking` for proper daemon behavior
- **Smart ExecStop**: Services with session managers get automatic `ExecStop` commands to properly terminate tmux/screen sessions when stopping the service
- **Non-Interactive Mode**: Services without session managers automatically set `AC_DISABLE_INTERACTIVE=1` to prevent hanging on prompts

### Session Management in Services

Services can be configured with session managers for interactive access:

```bash
# Create service with tmux
./service-manager.sh create world worldserver \
  --bin-path /path/to/bin \
  --session-manager tmux

# Attach to the session
./service-manager.sh attach world
# or directly:
tmux attach-session -t worldserver
```

## 🎮 Integration with acore.sh Dashboard

The startup scripts are fully integrated into the AzerothCore dashboard:

### Direct Commands

```bash
# Run servers with simple restart (development/testing)
./acore.sh run-worldserver   # Option 11 or 'rw'
./acore.sh run-authserver    # Option 12 or 'ra'

# Access service manager (production)
./acore.sh service-manager   # Option 15 or 'sm'

# Examples:
./acore.sh rw               # Quick worldserver start
./acore.sh ra               # Quick authserver start
./acore.sh sm create auth authserver --bin-path /path/to/bin
```

### What Happens Behind the Scenes

- **run-worldserver/run-authserver**: Calls `simple-restarter` with appropriate binary
- **service-manager**: Provides full access to the service management interface
- Scripts automatically use the correct binary path from your build configuration

## 🐛 Troubleshooting

### Common Issues

#### 1. Binary Not Found
```bash
Error: Binary '/path/to/bin/worldserver' not found
```
**Solution**: Check binary path and ensure servers are compiled
```bash
# Check if binary exists
ls -la /path/to/bin/worldserver

# Compile if needed
./acore.sh compiler build
```

#### 2. Configuration File Issues
```bash
Error: Configuration file not found
```
**Solution**: Create configuration from template
```bash
cp scripts/conf.sh.dist scripts/conf.sh
# Edit conf.sh with correct paths
```

#### 3. Session Manager Not Available
```bash
Warning: tmux not found, falling back to direct execution
```
**Solution**: Install required session manager
```bash
# Ubuntu/Debian
sudo apt install tmux screen

# CentOS/RHEL
sudo yum install tmux screen
```

#### 4. Permission Issues (systemd)
```bash
Failed to create systemd service
```
**Solution**: Check user permissions or use --system flag
```bash
# For user services (no sudo required)
./service-manager.sh create auth authserver --bin-path /path/to/bin

# For system services (requires sudo)
./service-manager.sh create auth authserver --bin-path /path/to/bin --system
```

#### 5. PM2 Not Found
```bash
Error: PM2 is not installed
```
**Solution**: Install PM2
```bash
npm install -g pm2
# or
sudo npm install -g pm2
```

#### 7. Registry Out of Sync
```bash
# If the service registry shows services that don't actually exist
```
**Solution**: Use registry sync or restore
```bash
# Check and restore missing services (also cleans up orphaned entries)
./service-manager.sh restore

# If you have a very old registry format, migrate it
./migrate-registry.sh
```


