# AzerothCore Config Merger

This directory contains configuration file merger tools to help update your AzerothCore server and module configurations with new options from distribution files.

**Available Options:** PHP and Python versions (**Python recommended for new users**)

## Purpose

The config merger tools help you update your existing configuration files (`.conf`) to include new options that have been added to the distribution files (`.conf.dist`). Distribution files always contain the most recent configuration changes and new options, while your personal config files may be missing these updates. These tools will:

- Compare your existing config files with the latest distribution files
- Show you new configuration options that are missing from your files  
- Allow you to selectively add new options to your configs
- Create automatic backups before making any changes
- Support authserver.conf, worldserver.conf, and all module configs

## Available Versions

### PHP Version

**Requirements:**
- PHP 5.6 or higher
- **Requires a web server** (Apache, Nginx, IIS, etc.) to function
- No additional libraries required (uses built-in PHP functions only)

**Features:**
- Web-based interface
- Configuration file parsing and merging
- Browser-accessible configuration management

**Usage:**
- Deploy to web server with PHP support (can be local - XAMPP, WAMP, or built-in PHP server)
- Access via web browser
- Follow web interface instructions

### Python Version (Recommended)

**Requirements:**
- Python 3.6 or higher
- No additional setup required beyond installing Python
- No additional libraries required (uses built-in modules only)

**Features:**
- Interactive menu-driven interface
- Support for server configs (authserver.conf, worldserver.conf)
- Support for module configs with bulk or selective updates
- Automatic backup creation with timestamps
- Cross-platform compatibility (Windows, Linux, macOS, and others)
- Can be run via command line or by double-clicking the .py file

**Usage:**
```bash
# Via command line
cd /path/to/configs
python config_merger.py

# Or double-click config_merger.py to open in terminal
```

## Installation

When building AzerothCore with the `TOOL_CONFIG_MERGER` CMake option enabled, **only the Python version** will be automatically copied to your configs directory during the build process. The PHP version must be manually deployed to a web server.

## Support

Both versions provide the same core functionality for merging configuration files. Choose the version that best fits your environment and preferences. Python is recommended for most users due to its simplicity and no web server requirement.