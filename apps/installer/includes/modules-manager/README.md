# AzerothCore Module Manager

This directory contains the module management system for AzerothCore, providing advanced functionality for installing, updating, and managing server modules.

## 🚀 Features

- **Advanced Syntax**: Support for `repo[:dirname][@branch[:commit]]` format
- **Cross-Format Recognition**: Intelligent matching across URLs, SSH, and simple names
- **Custom Directory Naming**: Prevent conflicts with custom directory names
- **Duplicate Prevention**: Smart detection and prevention of duplicate installations
- **Multi-Host Support**: GitHub, GitLab, and other Git hosts

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
./acore.sh module install mod-transmog mod-eluna:custom-eluna

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
./acore.sh module remove mod-transmog mod-eluna
```

### Searching Modules

```bash
# Search for modules
./acore.sh module search transmog

# Search with multiple terms
./acore.sh module search auction house

# Show all available modules
./acore.sh module search
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
Error: Directory 'mod-transmog' already exists.
Possible solutions:
  1. Use a different directory name: mod-transmog:my-custom-name
  2. Remove the existing directory first
  3. Use the update command if this is the same module
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
mod-eluna:custom-eluna-dir main 789abc123def
```
## 🔧 Configuration

### Environment Variables
- `MODULES_LIST_FILE`: Override default modules list path
- `J_PATH_MODULES`: Modules installation directory
- `AC_PATH_ROOT`: AzerothCore root path

### Default Paths
- Modules list: `$AC_PATH_ROOT/conf/modules.list`

## 🤝 Contributing

When modifying the module manager:

1. Maintain backwards compatibility
2. Update tests in `test_module_commands.bats`
3. Update this documentation
4. Test cross-format recognition thoroughly
5. Ensure helpful error messages


