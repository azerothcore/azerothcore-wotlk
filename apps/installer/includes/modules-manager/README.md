# AzerothCore Module Manager

This directory contains the module management system for AzerothCore, providing advanced functionality for installing, updating, and managing server modules.

## 🚀 Features

- **Advanced Syntax**: Support for `repo[:dirname][@branch[:commit]]` format
- **Cross-Format Recognition**: Intelligent matching across URLs, SSH, and simple names
- **Custom Directory Naming**: Prevent conflicts with custom directory names
- **Duplicate Prevention**: Smart detection and prevention of duplicate installations
- **Multi-Host Support**: GitHub, GitLab, and other Git hosts
- **Module Exclusion**: Support for excluding modules via environment variable
- **Interactive Menu System**: Easy-to-use menu interface for module management
- **Colored Output**: Enhanced terminal output with color support (respects NO_COLOR)
- **Flat Directory Structure**: Uses flat module installation (no owner subfolders)

## 📁 File Structure

```
modules-manager/
├── modules.sh              # Core module management functions
└── README.md               # This documentation file
```

## 🔧 Module Specification Syntax

The module manager supports flexible syntax for specifying modules:

### New Syntax Format
```bash
repo[:dirname][@branch[:commit]]
```

### Examples

| Specification | Description |
|---------------|-------------|
| `mod-transmog` | Simple module name, uses default branch and directory |
| `mod-transmog:my-custom-dir` | Custom directory name |
| `mod-transmog@develop` | Specific branch |
| `mod-transmog:custom@develop:abc123` | Custom directory, branch, and commit |
| `https://github.com/owner/repo.git@main` | Full URL with branch |
| `git@github.com:owner/repo.git:custom-dir` | SSH URL with custom directory |

## 🎯 Usage Examples

### Installing Modules

```bash
# Simple module installation
./acore.sh module install mod-transmog

# Install with custom directory name
./acore.sh module install mod-transmog:my-transmog-dir

# Install specific branch
./acore.sh module install mod-transmog@develop

# Install with full specification
./acore.sh module install mod-transmog:custom-dir@develop:abc123

# Install from URL
./acore.sh module install https://github.com/azerothcore/mod-transmog.git@main

# Install multiple modules
./acore.sh module install mod-transmog mod-ale:custom-eluna

# Install all modules from list
./acore.sh module install --all
```

### Updating Modules

```bash
# Update specific module
./acore.sh module update mod-transmog

# Update all modules
./acore.sh module update --all

# Update with branch specification
./acore.sh module update mod-transmog@develop
```

### Removing Modules

```bash
# Remove by simple name (cross-format recognition)
./acore.sh module remove mod-transmog

# Remove by URL (recognizes same module)
./acore.sh module remove https://github.com/azerothcore/mod-transmog.git

# Remove multiple modules
./acore.sh module remove mod-transmog mod-ale
```

### Searching Modules

```bash
# Search for modules
./acore.sh module search transmog

# Search with multiple terms
./acore.sh module search auction house

# Search with input prompt
./acore.sh module search
```

### Listing Installed Modules

```bash
# List all installed modules
./acore.sh module list
```

### Interactive Menu

```bash
# Start interactive menu system
./acore.sh module

# Menu options:
# s - Search for available modules
# i - Install one or more modules  
# u - Update installed modules
# r - Remove installed modules
# l - List installed modules
# h - Show detailed help
# q - Close this menu
```

## 🔍 Cross-Format Recognition

The system intelligently recognizes the same module across different specification formats:

```bash
# These all refer to the same module:
mod-transmog
azerothcore/mod-transmog
https://github.com/azerothcore/mod-transmog.git
git@github.com:azerothcore/mod-transmog.git
```

This allows:
- Installing with one format and removing with another
- Preventing duplicates regardless of specification format
- Consistent module tracking across different input methods

## 🛡️ Conflict Prevention

The system prevents common conflicts:

### Directory Conflicts
```bash
# If 'mod-transmog' directory already exists:
$ ./acore.sh module install mod-transmog:mod-transmog
Possible solutions:
  1. Use a different directory name: mod-transmog:my-custom-name
  2. Remove the existing directory first
  3. Use the update command if this is the same module
```

### Duplicate Module Prevention
The system uses intelligent owner/name matching to prevent installing the same module multiple times, even when specified in different formats.

## 🚫 Module Exclusion

You can exclude modules from installation using the `MODULES_EXCLUDE_LIST` environment variable:

```bash
# Exclude specific modules (space-separated)
export MODULES_EXCLUDE_LIST="mod-test-module azerothcore/mod-dev-only"
./acore.sh module install --all  # Will skip excluded modules

# Supports cross-format matching
export MODULES_EXCLUDE_LIST="https://github.com/azerothcore/mod-transmog.git"
./acore.sh module install mod-transmog  # Will be skipped as excluded
```

The exclusion system:
- Uses the same cross-format recognition as other module operations
- Works with all installation methods (`install`, `install --all`)
- Provides clear feedback when modules are skipped
- Supports URLs, owner/name format, and simple names

## 🎨 Color Support

The module manager provides enhanced terminal output with colors:

- **Info**: Cyan text for informational messages
- **Success**: Green text for successful operations
- **Warning**: Yellow text for warnings
- **Error**: Red text for errors
- **Headers**: Bold cyan text for section headers

Color support is automatically disabled when:
- Output is not to a terminal (piped/redirected)
- `NO_COLOR` environment variable is set
- Terminal doesn't support colors

You can force color output with:
```bash
export FORCE_COLOR=1
```

## 🔄 Integration

### Including in Scripts
```bash
# Source the module functions
source "$AC_PATH_INSTALLER/includes/modules-manager/modules.sh"

# Use module functions
inst_module_install "mod-transmog:custom-dir@develop"
```

### Testing
The module system is tested through the main installer test suite:
```bash
./apps/installer/test/test_module_commands.bats
```

## 📋 Module List Format

Modules are tracked in `conf/modules.list` with the format:
```
# Comments start with #
repo_reference branch commit

# Examples:
azerothcore/mod-transmog master abc123def456
https://github.com/custom/mod-custom.git develop def456abc789
mod-ale:custom-eluna-dir main 789abc123def
```

The list maintains:
- **Alphabetical ordering** by normalized owner/name for consistency
- **Original format preservation** of how modules were specified
- **Automatic deduplication** across different specification formats
- **Custom directory tracking** when specified

## 🔧 Configuration

### Environment Variables

| Variable | Description | Default |
|----------|-------------|---------|
| `MODULES_LIST_FILE` | Override default modules list path | `$AC_PATH_ROOT/conf/modules.list` |
| `MODULES_EXCLUDE_LIST` | Space-separated list of modules to exclude | - |
| `J_PATH_MODULES` | Modules installation directory | `$AC_PATH_ROOT/modules` |
| `AC_PATH_ROOT` | AzerothCore root path | - |
| `NO_COLOR` | Disable colored output | - |
| `FORCE_COLOR` | Force colored output even when not TTY | - |

### Default Paths
- **Modules list**: `$AC_PATH_ROOT/conf/modules.list`
- **Installation directory**: `$J_PATH_MODULES` (flat structure, no owner subfolders)

## 🏗️ Architecture

### Core Functions

| Function | Purpose |
|----------|---------|
| `inst_module()` | Main dispatcher and interactive menu |
| `inst_parse_module_spec()` | Parse advanced module syntax |
| `inst_extract_owner_name()` | Normalize modules for cross-format recognition |
| `inst_mod_list_*()` | Module list management (read/write/update) |
| `inst_module_*()` | Module operations (install/update/remove/search) |

### Key Features

- **Flat Directory Structure**: All modules install directly under `modules/` without owner subdirectories
- **Smart Conflict Detection**: Prevents directory name conflicts with helpful suggestions
- **Cross-Platform Compatibility**: Works on Linux, macOS, and Windows (Git Bash)
- **Version Compatibility**: Checks `acore-module.json` for AzerothCore version compatibility
- **Git Integration**: Uses Joiner system for Git repository management

### Debug Mode

For debugging module operations, you can examine the generated commands:
```bash
# Check what Joiner commands would be executed
tail -f /tmp/joiner_called.txt  # In test environments
```

## 🤝 Contributing

When modifying the module manager:

1. **Maintain backwards compatibility** with existing module list format
2. **Update tests** in `test_module_commands.bats` for new functionality
3. **Update this documentation** for any new features or changes
4. **Test cross-format recognition** thoroughly across all supported formats
5. **Ensure helpful error messages** for common user mistakes
6. **Test exclusion functionality** with various module specification formats
7. **Verify color output** works correctly in different terminal environments

### Testing Guidelines

```bash
# Run all module-related tests
cd apps/installer
bats test/test_module_commands.bats

# Test with different environments
NO_COLOR=1 ./acore.sh module list
FORCE_COLOR=1 ./acore.sh module help
```
