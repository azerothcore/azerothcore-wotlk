# Version 1
# Based and modified from: https://github.com/Brian-Aldridge/update_module_confs 
#
# This file is part of the AzerothCore Project. See AUTHORS file for Copyright information
#
# This program is free software; you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation; either version 2 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful, but WITHOUT
# ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
# FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for
# more details.
#
# You should have received a copy of the GNU General Public License along
# with this program. If not, see <http://www.gnu.org/licenses/>.
#
# Original code portions licensed under MIT License by Brian Aldridge (https://github.com/BoiseComputer)
# Original project: https://github.com/Brian-Aldridge/update_module_confs

VERSION = "1"

import os
import shutil
import argparse
import sys
from datetime import datetime

def find_modules(folder):
    dist_files = []
    try:
        files = os.listdir(folder)
    except (OSError, IOError) as e:
        print(f"[ERROR] Could not list directory '{folder}': {e}")
        return []
    for file in files:
        if file.endswith('.conf.dist'):
            dist_files.append(file)
    return sorted(dist_files)

def prompt_module_selection(dist_files):
    print("Found the following modules:")
    for idx, fname in enumerate(dist_files, 1):
        print(f"  {idx}. {fname}")
    nums = input("Enter numbers of modules to update (comma-separated): ").strip()
    raw_inputs = [x.strip() for x in nums.split(",") if x.strip()]
    indices = []
    invalid = []
    for x in raw_inputs:
        if not x.isdigit():
            invalid.append(f"'{x}' (not a number)")
            continue
        idx = int(x)
        if 0 < idx <= len(dist_files):
            indices.append(idx-1)
        else:
            invalid.append(f"'{x}' (out of range, must be 1-{len(dist_files)})")
    if invalid:
        print("Invalid input:")
        for msg in invalid:
            print(f"  {msg}")
    if not indices:
        print("No valid module numbers were entered.")
        return []
    selected = [dist_files[i] for i in indices]
    return selected

def backup_file(filepath):
    timestamp = datetime.now().strftime("d%d_m%m_y%Y_%Hh_%Mm_%Ss")
    bakpath = f"{filepath}({timestamp}).bak"
    try:
        shutil.copy2(filepath, bakpath)
        print(f"  Backup created: {bakpath}")
    except (OSError, IOError) as e:
        print(f"[ERROR] Failed to create backup '{bakpath}': {e}")
        return False
    return True

def parse_conf(filepath):
    # Returns a dict of key: (line, [preceding_comments])
    try:
        with open(filepath, encoding="utf-8") as f:
            lines = f.readlines()
    except (OSError, IOError) as e:
        print(f"[ERROR] Failed to read config file '{filepath}': {e}")
        return None
    conf = {}
    comments = []
    for line in lines:
        stripped = line.strip()
        if not stripped or stripped.startswith("#"):
            comments.append(line)
            continue
        if stripped.startswith("[") and stripped.endswith("]"):
            # Ignore [headers of configs]
            comments.clear()
            continue
        if stripped.count("=") == 1:
            key, value = [s.strip() for s in stripped.split("=", 1)]
            if '#' in value:
                value = value.split('#', 1)[0].rstrip()
            if key:
                conf[key] = (f"{key} = {value}\n", comments.copy())
                comments.clear()
            continue
    return conf

def find_missing_keys(dist_conf, user_conf):
    missing = {}
    for key, (line, comments) in dist_conf.items():
        if key not in user_conf:
            missing[key] = (line, comments)
    return missing

def update_conf(dist_path, conf_path, skip_prompts=False):
    if not os.path.exists(conf_path):
        print(f"  User config {conf_path} does not exist, skipping.")
        return False
    dist_conf = parse_conf(dist_path)
    user_conf = parse_conf(conf_path)
    missing = find_missing_keys(dist_conf, user_conf)
    if not missing:
        print("  No new config options to add.")
        return False
    updated = False
    lines_to_add = []
    for key, (line, comments) in missing.items():
        if skip_prompts:
            lines_to_add.append((comments, line, key))
        else:
            print("\n" + "".join(comments if comments else []) + line, end="")
            add = input(f"  Add {key} to config? (y/n): ").strip().lower()
            if add in ("", "y", "yes"):
                lines_to_add.append((comments, line, key))
            else:
                print(f"    Skipped {key}.")
    if lines_to_add:
        backup_file(conf_path)
        # Write using system's default line ending to avoid mixing CRLF and LF in the config file
        newline = os.linesep.encode('utf-8')
        with open(conf_path, "ab") as f:
            for comments, line, key in lines_to_add:
                if comments:
                    for c in comments:
                        f.write(c.rstrip('\r\n').encode('utf-8') + newline)
                f.write(line.rstrip('\r\n').encode('utf-8') + newline)
                print(f"    Added {key}.")
        updated = True
    return updated

def update_server_config(config_name, config_dir, skip_prompts=False):
    dist_path = os.path.join(config_dir, f"{config_name}.conf.dist")
    conf_path = os.path.join(config_dir, f"{config_name}.conf")
    
    if not os.path.exists(dist_path):
        print(f"  Distribution config {dist_path} does not exist, skipping.")
        return False
    
    print(f"\nProcessing {config_name}.conf ...")
    return update_conf(dist_path, conf_path, skip_prompts)

def update_modules(config_dir, selected_only=False, skip_prompts=False):
    modules_dir = os.path.join(config_dir, "modules")
    if not os.path.exists(modules_dir):
        print(f"  Modules directory {modules_dir} does not exist, skipping.")
        return
    
    dist_files = find_modules(modules_dir)
    if not dist_files:
        print("  No .conf.dist files found in modules folder.")
        return
    
    if selected_only:
        selected = prompt_module_selection(dist_files)
        if not selected:
            print("  No modules selected.")
            return
    else:
        selected = dist_files
    
    for dist_fname in selected:
        module = dist_fname[:-5]  # Removes ".dist"
        conf_fname = module  # e.g., mod_x.conf
        dist_path = os.path.join(modules_dir, dist_fname)
        conf_path = os.path.join(modules_dir, conf_fname)
        print(f"\nProcessing {conf_fname} ...")
        update_conf(dist_path, conf_path, skip_prompts)

def show_main_menu():
    print(f"\nAzerothCore Config Updater/Merger (v. {VERSION})")
    print("--------------------------")
    print("1 - Update Auth Config")
    print("2 - Update World Config")
    print("3 - Update Auth and World Configs")
    print("4 - Update All Modules Configs")
    print("5 - Update Modules (Selection) Configs")
    print("0 - Quit")
    return input("Select an option: ").strip()

def parse_args():
    parser = argparse.ArgumentParser(description='AzerothCore Config Updater/Merger')
    parser.add_argument('config_dir', nargs='?', default='.', 
                      help='Path to configs directory (default: current directory)')
    parser.add_argument('target', nargs='?',
                      choices=['auth', 'world', 'both', 'modules', 'modules-select'],
                      help='What to update: auth, world, both, modules, modules-select')
    parser.add_argument('-y', '--yes', action='store_true',
                      help='Automatically answer yes to all prompts')
    parser.add_argument('--version', action='version', version=f'%(prog)s {VERSION}')
    return parser.parse_args()

def main():
    args = parse_args()
    
    # If no target specified, run interactive mode
    if args.target is None:
        print(f"AzerothCore Config Updater/Merger (v. {VERSION})")
        print("==========================")
        config_dir = input("Enter the path to your configs folder (Default / Empty will use the folder where this script is located): ").strip()
        if not config_dir:
            config_dir = "."
        
        if not os.path.isdir(config_dir):
            print("Provided path is not a valid directory.")
            return
        
        while True:
            choice = show_main_menu()
            
            if choice == "1":
                update_server_config("authserver", config_dir)
            elif choice == "2":
                update_server_config("worldserver", config_dir)
            elif choice == "3":
                update_server_config("authserver", config_dir)
                update_server_config("worldserver", config_dir)
            elif choice == "4":
                update_modules(config_dir, selected_only=False)
            elif choice == "5":
                update_modules(config_dir, selected_only=True)
            elif choice == "0":
                print("Goodbye!")
                break
            else:
                print("Invalid selection. Please try again.")
    else:
        # CLI mode
        config_dir = args.config_dir
        
        if not os.path.isdir(config_dir):
            print(f"Error: Directory '{config_dir}' does not exist.")
            sys.exit(1)
        
        print(f"AzerothCore Config Updater/Merger (v. {VERSION}) - CLI Mode")
        print(f"Config directory: {os.path.abspath(config_dir)}")
        print(f"Target: {args.target}")
        if args.yes:
            print("Skip prompts: Yes")
        
        if args.target == 'auth':
            update_server_config("authserver", config_dir, args.yes)
        elif args.target == 'world':
            update_server_config("worldserver", config_dir, args.yes)
        elif args.target == 'both':
            update_server_config("authserver", config_dir, args.yes)
            update_server_config("worldserver", config_dir, args.yes)
        elif args.target == 'modules':
            update_modules(config_dir, selected_only=False, skip_prompts=args.yes)
        elif args.target == 'modules-select':
            if args.yes:
                print("Warning: --yes flag ignored for modules-select (requires interactive selection)")
            update_modules(config_dir, selected_only=True, skip_prompts=False)

if __name__ == "__main__":
    main()
