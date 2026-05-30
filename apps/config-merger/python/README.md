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
- **Automatic Backups** - If you choose a valid option and there are changes, a timestamped backup is created before any changes are made (e.g. `filename(d11_m12_y2025_14h_30m_45s).bak`)
- **Selective Updates** - Choose which new config options to add (y/n prompts)
- **Safe Operation** - Only creates backups and makes changes when new options are found

## How to Use

There are two ways to use this. You can either copy this file directly to your `/configs` folder, or enable `TOOL_CONFIG_MERGER` in CMake. Upon compiling your core, the file will be generated in the same location as your `/configs` folder.

### Interactive Mode (Default)

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

### Command Line Interface (CLI)

For automation and scripting, you can use CLI mode:

```bash
python config_merger.py [config_dir] [target] [options]
```

**Arguments:**
- `config_dir` (optional): Path to configs directory (default: current directory)
- `target` (optional): What to update:
  - `auth` - Update authserver.conf only
  - `world` - Update worldserver.conf only  
  - `both` - Update both server configs
  - `modules` - Update all module configs
  - `modules-select` - Interactive module selection

**Options:**
- `-y, --yes`: Skip prompts and auto-add all new config options (default: prompt for each option)
- `--version`: Show version information

**Examples:**
```bash
# Interactive mode (default)
python config_merger.py

# Update auth config with prompts
python config_merger.py . auth

# Update both configs automatically (no prompts)
python config_merger.py /path/to/configs both -y

# Update all modules with confirmation
python config_merger.py . modules
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
4. **Create backup** (before any changes are made) only if you choose a valid option and there are changes (format: `filename(d11_m12_y2025_14h_30m_45s).bak`)

## Example Session

```
Processing worldserver.conf ...
  Backup created: worldserver.conf(d11_m12_y2025_14h_30m_45s).bak

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

## License

This file is part of the AzerothCore Project. This program is free software; you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation; either version 2 of the License, or (at your option) any later version.

This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for more details.

You should have received a copy of the GNU General Public License along with this program. If not, see <http://www.gnu.org/licenses/>.

**Note:** Original code portions were licensed under the MIT License by Brian Aldridge (https://github.com/BoiseComputer)  
Original project: https://github.com/Brian-Aldridge/update_module_confs
