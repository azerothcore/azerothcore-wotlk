# AzerothCore Config Updater/Merger - Python Version

A command-line tool to update your AzerothCore configuration files with new options from distribution files.

> [!NOTE]  
> Based on and modified from [@BoiseComputer](https://github.com/BoiseComputer) (Brian Aldridge)'s [update_module_confs](https://github.com/Brian-Aldridge/update_module_confs) project to meet AzerothCore's needs

## Overview

This tool compares your existing configuration files (`.conf`) with the latest distribution files (`.conf.dist`) and helps you add new configuration options that may have been introduced in updates. It ensures your configs stay up-to-date while preserving your custom settings.

## Features

- **Interactive Menu System** - Easy-to-use numbered menu options
- **Server Config Support** - Update authserver.conf and worldserver.conf
- **Module Config Support** - Update all or selected module configurations
- **Automatic Backups** - Creates timestamped backups before making changes
- **Selective Updates** - Choose which new config options to add (y/n prompts)
- **Safe Operation** - Only creates backups and makes changes when new options are found

## How to Use

1. **Run the script** in your configs directory:
   ```bash
   python config_merger.py
   ```
   Or simply **double-click** the `config_merger.py` file to run it directly.

2. **Specify configs path** (or press Enter for current directory):
   ```
   Enter the path to your configs folder (default: .) which means current folder:
   ```

3. **Choose from the menu**:
   ```
   AzerothCore Config Updater/Merger (v. 1)
   --------------------------
   1 - Update Auth Config
   2 - Update World Config  
   3 - Update Auth and World Configs
   4 - Update All Modules Configs
   5 - Update Modules (Selection) Configs
   0 - Quit
   ```

## Menu Options Explained

- **Option 1**: Updates only `authserver.conf` from `authserver.conf.dist`
- **Option 2**: Updates only `worldserver.conf` from `worldserver.conf.dist`  
- **Option 3**: Updates both server config files
- **Option 4**: Automatically processes all module config files in the `modules/` folder
- **Option 5**: Shows you a list of available modules and lets you select specific ones to update
- **Option 0**: Exit the program

## Interactive Process

For each missing configuration option found, the tool will:

1. **Show you the option** with its comments and default value
2. **Ask for confirmation**: `Add [option_name] to config? (y/n):`
3. **Add or skip** based on your choice
4. **Create backup** automatically before making any changes (format: `filename(d11 m12 y2025 14h 30m 45s).bak`)

## Example Session

```
Processing worldserver.conf ...
  Backup created: worldserver.conf(d11 m12 y2025 14h 30m 45s).bak

# New feature for XP rates
XP.Rate = 1
  Add XP.Rate to config? (y/n): y
    Added XP.Rate.

# Database connection pool size  
Database.PoolSize = 5
  Add Database.PoolSize to config? (y/n): n
    Skipped Database.PoolSize.
```

## Requirements

- Python 3.6 or higher
- No additional libraries needed (uses built-in modules only)

## File Structure Expected

```
configs/
├── config_merger.py        (this script)
├── authserver.conf.dist
├── authserver.conf
├── worldserver.conf.dist
├── worldserver.conf
└── modules/
    ├── mod_example.conf.dist
    ├── mod_example.conf
    └── ...
```