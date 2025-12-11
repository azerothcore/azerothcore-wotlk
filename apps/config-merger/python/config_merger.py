# Version 1
# Based and modified from: https://github.com/Brian-Aldridge/update_module_confs 


VERSION = "1"

import os
import shutil
from datetime import datetime

def find_modules(folder):
    dist_files = []
    for file in os.listdir(folder):
        if file.endswith('.conf.dist'):
            dist_files.append(file)
    return sorted(dist_files)

def prompt_module_selection(dist_files):
    print("Found the following modules:")
    for idx, fname in enumerate(dist_files, 1):
        print(f"  {idx}. {fname}")
    nums = input("Enter numbers of modules to update (comma-separated): ").strip()
    indices = [int(x)-1 for x in nums.split(",") if x.strip().isdigit() and 0 < int(x) <= len(dist_files)]
    selected = [dist_files[i] for i in indices]
    return selected

def backup_file(filepath):
    timestamp = datetime.now().strftime("d%d m%m y%Y %Hh %Mm %Ss")
    bakpath = f"{filepath}({timestamp}).bak"
    shutil.copy2(filepath, bakpath)
    print(f"  Backup created: {bakpath}")

def parse_conf(filepath):
    # Returns a dict of key: (line, [preceding_comments])
    with open(filepath, encoding="utf-8") as f:
        lines = f.readlines()
    conf = {}
    comments = []
    for line in lines:
        stripped = line.strip()
        if not stripped or stripped.startswith("#"):
            comments.append(line)
            continue
        if "=" in stripped:
            key = stripped.split("=")[0].strip()
            conf[key] = (line, comments.copy())
            comments.clear()
    return conf

def find_missing_keys(dist_conf, user_conf):
    missing = {}
    for key, (line, comments) in dist_conf.items():
        if key not in user_conf:
            missing[key] = (line, comments)
    return missing

def update_conf(dist_path, conf_path):
    if not os.path.exists(conf_path):
        print(f"  User config {conf_path} does not exist, skipping.")
        return False
    dist_conf = parse_conf(dist_path)
    user_conf = parse_conf(conf_path)
    missing = find_missing_keys(dist_conf, user_conf)
    if not missing:
        print("  No new config options to add.")
        return False
    backup_file(conf_path)  # Only make a backup if changes are needed!
    updated = False
    with open(conf_path, "a", encoding="utf-8") as f:
        for key, (line, comments) in missing.items():
            print("\n" + "".join(comments if comments else []) + line, end="")
            add = input(f"  Add {key} to config? (y/n): ").strip().lower()
            if add in ("", "y", "yes"):
                if comments:
                    f.writelines(comments)
                f.write(line)
                print(f"    Added {key}.")
                updated = True
            else:
                print(f"    Skipped {key}.")
    return updated

def update_server_config(config_name, config_dir):
    dist_path = os.path.join(config_dir, f"{config_name}.conf.dist")
    conf_path = os.path.join(config_dir, f"{config_name}.conf")
    
    if not os.path.exists(dist_path):
        print(f"  Distribution config {dist_path} does not exist, skipping.")
        return False
    
    print(f"\nProcessing {config_name}.conf ...")
    return update_conf(dist_path, conf_path)

def update_modules(config_dir, selected_only=False):
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
        update_conf(dist_path, conf_path)

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

def main():
    print(f"AzerothCore Config Updater/Merger (v. {VERSION})")
    print("==========================")
    config_dir = input("Enter the path to your configs folder (default: .) which means current folder: ").strip()
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

if __name__ == "__main__":
    main()
