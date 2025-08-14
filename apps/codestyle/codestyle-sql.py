import io
import os
import sys
import re
import glob
import subprocess

base_dir = os.getcwd()

# Get the pending directory of the project
pattern = os.path.join(base_dir, 'data/sql/updates/pending_db_*')
src_directory = glob.glob(pattern)

# Get files from base dir
base_pattern = os.path.join(base_dir, 'data/sql/base/db_*')
base_directory = glob.glob(base_pattern)

# Get files from archive dir
archive_pattern = os.path.join(base_dir, 'data/sql/archive/db_*')
archive_directory = glob.glob(archive_pattern)

# Global variables
error_handler = False
results = {
    "Multiple blank lines check": "Passed",
    "Trailing whitespace check": "Passed",
    "SQL codestyle check": "Passed",
    "INSERT & DELETE safety usage check": "Passed",
    "Missing semicolon check": "Passed",
    "Backtick check": "Passed",
    "Directory check": "Passed",
    "Table engine check": "Passed"
}

# Collect all files in all directories
def collect_files_from_directories(directories: list) -> list:
    all_files = []
    for directory in directories:
        for root, _, files in os.walk(directory):
            for file in files:
                if not file.endswith('.sh'):  # Skip .sh files
                    all_files.append(os.path.join(root, file))
    return all_files

# Used to find changed or added files compared to master.
def get_changed_files() -> list:
    subprocess.run(["git", "fetch", "origin", "master"], check=True)
    result = subprocess.run(
        ["git", "diff", "--name-status", "origin/master"],
        stdout=subprocess.PIPE,
        stderr=subprocess.PIPE,
        text=True,
    )
    changed_files = []
    for line in result.stdout.strip().splitlines():
        if not line:
            continue
        status, path = line.split(maxsplit=1)
        if status in ("A", "M"):
            changed_files.append(path)
    return changed_files

# Main function to parse all the files of the project
def parsing_file(files: list) -> None:
    print("Starting AzerothCore SQL Codestyle check...")
    print(" ")
    print("Please read the SQL Standards for AzerothCore:")
    print("https://www.azerothcore.org/wiki/sql-standards")
    print(" ")

    # Iterate over all files in data/sql/updates/pending_db_*
    for file_path in files:
        if "base" not in file_path and "archive" not in file_path:
            try:
                with open(file_path, 'r', encoding='utf-8') as file:
                    multiple_blank_lines_check(file, file_path)
                    trailing_whitespace_check(file, file_path)
                    sql_check(file, file_path)
                    insert_delete_safety_check(file, file_path)
                    semicolon_check(file, file_path)
                    backtick_check(file, file_path)
                    non_innodb_engine_check(file, file_path)
                    sniffable_data_check(file, file_path)
            except UnicodeDecodeError:
                print(f"\n❌ Could not decode file {file_path}")
                sys.exit(1)

    # Make sure we only check changed or added files when we work with base/archive paths
    changed_files = get_changed_files()
    # Iterate over all file paths
    for file_path in changed_files:
        if "base" in file_path or "archive" in file_path:
            try:
                with open(file_path, "r", encoding="utf-8") as f:
                    directory_check(f, file_path)
            except UnicodeDecodeError:
                print(f"\n❌ Could not decode file {file_path}")
                sys.exit(1)

    # Output the results
    print("\n ")
    for check, result in results.items():
        print(f"{check} : {result}")
    if error_handler:
        print("\n ")
        print("\n❌ Please fix the codestyle issues above.")
        sys.exit(1)
    else:
        print("\n ")
        print(f"\n✅ Everything looks good")

# Codestyle patterns checking for multiple blank lines
def multiple_blank_lines_check(file: io, file_path: str) -> None:
    global error_handler, results
    file.seek(0)  # Reset file pointer to the beginning
    check_failed = False
    consecutive_blank_lines = 0
    # Parse all the file
    for line_number, line in enumerate(file, start = 1):
        if line.strip() == '':
            consecutive_blank_lines += 1
            if consecutive_blank_lines > 1:
                print(f"❌ Multiple blank lines found in {file_path} at line {line_number - 1}")
                check_failed = True
        else:
            consecutive_blank_lines = 0
    # Additional check for the end of the file
    if consecutive_blank_lines >= 1:
        print(f"❌ Multiple blank lines found at the end of: {file_path}")
        check_failed = True
    # Handle the script error and update the result output
    if check_failed:
        error_handler = True
        results["Multiple blank lines check"] = "Failed"

# Codestyle patterns checking for whitespace at the end of the lines
def trailing_whitespace_check(file: io, file_path: str) -> None:
    global error_handler, results
    file.seek(0)  # Reset file pointer to the beginning
    check_failed = False
    # Parse all the file
    for line_number, line in enumerate(file, start = 1):
        if line.endswith(' \n'):
            print(f"❌ Trailing whitespace found: {file_path} at line {line_number}")
            check_failed = True
    if check_failed:
        error_handler = True
        results["Trailing whitespace check"] = "Failed"

# Codestyle patterns checking for various codestyle issues
def sql_check(file: io, file_path: str) -> None:
    global error_handler, results
    file.seek(0)  # Reset file pointer to the beginning
    check_failed = False

    # Parse all the file
    for line_number, line in enumerate(file, start = 1):
        if [match for match in ['broadcast_text'] if match in line]:
            print(
                f"❌ DON'T EDIT broadcast_text TABLE UNLESS YOU KNOW WHAT YOU ARE DOING!\nThis error can safely be ignored if the changes are approved to be sniffed: {file_path} at line {line_number}")
            check_failed = True
        if "EntryOrGuid" in line:
            print(
                f"❌ Please use entryorguid syntax instead of EntryOrGuid in {file_path} at line {line_number}\nWe recommend to use keira to have the right syntax in auto-query generation")
            check_failed = True
        if [match for match in [';;'] if match in line]:
            print(
                f"❌ Double semicolon (;;) found in {file_path} at line {line_number}")
            check_failed = True
        if re.match(r"\t", line):
            print(
                f"❌ Tab found! Replace it to 4 spaces: {file_path} at line {line_number}")
            check_failed = True

        last_line = line[-1].strip()
        if last_line:
            print(
                f"❌ The last line is not a newline. Please add a newline: {file_path}")
            check_failed = True

    # Handle the script error and update the result output
    if check_failed:
        error_handler = True
        results["SQL codestyle check"] = "Failed"

def insert_delete_safety_check(file: io, file_path: str) -> None:
    global error_handler, results
    file.seek(0)  # Reset file pointer to the beginning
    not_delete = ["creature_template", "gameobject_template", "item_template", "quest_template"]
    check_failed = False
    delete_lines = {}
    lines = file.readlines()

    # Parse all the file
    line_num = 0
    while line_num < len(lines):
        line = lines[line_num]
        stripped = line.strip()
        if stripped.startswith("--") or not stripped:
            line_num += 1
            continue

        if "DELETE" in stripped.upper() and "FROM" in stripped.upper():
            if not re.match(r"DELETE FROM `([^`]+)`", stripped, re.IGNORECASE):
                print(f"❌ Invalid DELETE syntax (must have exactly one space between DELETE and FROM) {file_path} at line {line_num + 1}")
                check_failed = True
                line_num += 1
                continue

        match = re.match(r"DELETE FROM `([^`]+)`", stripped, re.IGNORECASE)
        if match:
            table_name = match.group(1)
            if table_name in not_delete:
                print(
                    f"❌ Entries from {table_name} should not be deleted! {file_path} at line {line_num + 1}\nIf this error is intended, please notify a maintainer")
                check_failed = True
            start = line_num
            while line_num < len(lines) and ";" not in lines[line_num]:
                line_num += 1
            end = line_num
            delete_lines.setdefault(table_name, []).append(end + 1)
        line_num += 1

    for line_number, line in enumerate(lines, start=1):
        if line.strip().startswith('--'):
            continue

        stripped = line.strip() 

        if "INSERT" in stripped.upper() and "INTO" in stripped.upper():
            if not re.match(r"INSERT INTO `([^`]+)`", stripped, re.IGNORECASE):
                print(f"❌ Invalid INSERT syntax (must have exactly one space between INSERT and INTO) {file_path} at line {line_number}")
                check_failed = True
                continue

        insert_match = re.match(r"INSERT INTO `?([^`\s]+)`?", line.strip(), re.IGNORECASE)
        if insert_match:
            table = insert_match.group(1)
            deletes = delete_lines.get(table)
            if not deletes:
                print(f"❌ No DELETE keyword found before the INSERT in {file_path} at line {line_number}\nIf this error is intended, please notify a maintainer")
                check_failed = True
            else:
                valid = False
                for del_line in deletes:
                    if del_line >= line_number:
                        continue
                    prev_line = line_number - 1
                    while prev_line > del_line:
                        if lines[prev_line - 1].strip() and not lines[prev_line - 1].strip().startswith("--"):
                            break
                        prev_line -= 1
                    if prev_line == del_line:
                        valid = True
                        break
                if not valid:
                    print(f"❌ DELETE for `{table}` query must be directly above the INSERT  (case of multipe lines) in {file_path} at line {line_number}")
                    check_failed = True

    if check_failed:
        error_handler = True
        results["INSERT & DELETE safety usage check"] = "Failed"

def semicolon_check(file: io, file_path: str) -> None:
    global error_handler, results

    file.seek(0)  # Reset file pointer to the start
    check_failed = False

    query_open = False
    in_block_comment = False
    inside_values_block = False

    lines = file.readlines()
    total_lines = len(lines)

    set_open = False  # Track if currently inside a SET statement

    def get_next_non_blank_line(start):
        """ Get the next non-blank, non-comment line starting from `start` """
        for idx in range(start, total_lines):
            next_line = lines[idx].strip()
            if next_line and not next_line.startswith('--') and not next_line.startswith('/*'):
                return next_line
        return None

    for line_number, line in enumerate(lines, start=1):
        stripped_line = line.strip()

        # Skip single-line comments
        if stripped_line.startswith('--'):
            continue

        # Handle block comments
        if in_block_comment:
            if '*/' in stripped_line:
                in_block_comment = False
                stripped_line = stripped_line.split('*/', 1)[1].strip()
            else:
                continue
        else:
            if '/*' in stripped_line:
                query_open = False  # Reset query state at start of block comment
                in_block_comment = True
                stripped_line = stripped_line.split('/*', 1)[0].strip()

        # Skip empty lines (unless inside values block or inside SET block)
        if not stripped_line and not inside_values_block and not set_open:
            continue

        # Remove inline comments after SQL
        stripped_line = stripped_line.split('--', 1)[0].strip()

        # Detect start of multi-line SET statement
        if stripped_line.upper().startswith("SET"):
            set_open = True

        # If inside a SET statement, check if it ends with a semicolon
        if set_open:
            if stripped_line.endswith(';'):
                set_open = False  # SET statement closed properly
            elif line_number == total_lines:
                # End of file but SET not closed properly
                print(f"❌ Missing semicolon in {file_path} at line {line_number}")
                check_failed = True

        # Detect query start
        if not query_open and any(keyword in stripped_line.upper() for keyword in ["SELECT", "INSERT", "UPDATE", "DELETE", "REPLACE"]):
            query_open = True

        # Detect start of multi-line VALUES block
        if any(kw in stripped_line.upper() for kw in ["INSERT", "REPLACE"]) and "VALUES" in stripped_line.upper():
            inside_values_block = True
            query_open = True  # Ensure query is marked open too

        if inside_values_block:
            if not stripped_line:
                continue  # Allow blank lines inside VALUES block

            if stripped_line.startswith('('):
                # Get next non-blank line to detect if we're at the last row
                next_line = get_next_non_blank_line(line_number)

                if next_line and next_line.startswith('('):
                    # Expect comma if another row follows
                    if not stripped_line.endswith(','):
                        print(f"❌ Missing comma in {file_path} at line {line_number}")
                        check_failed = True
                else:
                    # Expect semicolon if this is the final row
                    if not stripped_line.endswith(';'):
                        print(f"❌ Missing semicolon in {file_path} at line {line_number}")
                        check_failed = True
                        inside_values_block = False
                        query_open = False
                    else:
                        inside_values_block = False  # Close block if semicolon was found

        elif query_open and not inside_values_block:
            # Normal query handling (outside multi-row VALUES block)
            if line_number == total_lines and not stripped_line.endswith(';'):
                print(f"❌ Missing semicolon in {file_path} at the last line {line_number}")
                check_failed = True
                query_open = False
            elif stripped_line.endswith(';'):
                query_open = False

    if check_failed:
        error_handler = True
        results["Missing semicolon check"] = "Failed"

def backtick_check(file: io, file_path: str) -> None:
    global error_handler, results
    file.seek(0)
    check_failed = False

    # Find SQL clauses
    pattern = re.compile(
        r'\b(SELECT|FROM|JOIN|WHERE|GROUP BY|ORDER BY|DELETE FROM|UPDATE|INSERT INTO|SET|REPLACE|REPLACE INTO)\s+(.*?)(?=;$|(?=\b(?:WHERE|SET|VALUES)\b)|$)',  
        re.IGNORECASE | re.DOTALL
    )

    # Make sure to ignore values enclosed in single- and doublequotes
    quote_pattern = re.compile(r"'(?:\\'|[^'])*'|\"(?:\\\"|[^\"])*\"")

    for line_number, line in enumerate(file, start=1):
        # Ignore comments
        if line.startswith('--'):
            continue

        # Sanitize single- and doublequotes to prevent false positives
        sanitized_line = quote_pattern.sub('', line).split('--')[0]
        matches = pattern.findall(sanitized_line)
        
        for clause, content in matches:
            # Find all words and exclude @variables
            words = re.findall(r'\b(?<!@)([a-zA-Z_][a-zA-Z0-9_]*)\b', content)

            for word in words:
                # Skip MySQL keywords
                if word.upper() in {"SELECT", "FROM", "JOIN", "WHERE", "GROUP", "BY", "ORDER",
                                    "DELETE", "UPDATE", "INSERT", "INTO", "SET", "VALUES", "AND",
                                    "IN", "OR", "REPLACE", "NOT", "BETWEEN",
                                    "DISTINCT", "HAVING", "LIMIT", "OFFSET", "AS", "ON", "INNER",
                                    "LEFT", "RIGHT", "FULL", "OUTER", "CROSS", "NATURAL",
                                    "EXISTS", "LIKE", "IS", "NULL", "UNION", "ALL", "ASC", "DESC",
                                    "CASE", "WHEN", "THEN", "ELSE", "END", "CREATE", "TABLE",
                                    "ALTER", "DROP", "DATABASE", "INDEX", "VIEW", "TRIGGER",
                                    "PROCEDURE", "FUNCTION", "PRIMARY", "KEY", "FOREIGN", "REFERENCES",
                                    "CONSTRAINT", "DEFAULT", "AUTO_INCREMENT", "UNIQUE", "CHECK",
                                    "SHOW", "DESCRIBE", "EXPLAIN", "USE", "GRANT", "REVOKE",
                                    "BEGIN", "COMMIT", "ROLLBACK", "SAVEPOINT", "LOCK", "UNLOCK",
                                    "WITH", "RECURSIVE", "COLUMN", "ENGINE", "CHARSET", "COLLATE",
                                    "IF", "ELSEIF", "LOOP", "WHILE", "DO", "HANDLER", "LEAVE",
                                    "ITERATE", "DECLARE", "CURSOR", "FETCH", "OPEN", "CLOSE"}:
                    continue

                # Make sure the word is enclosed in backticks
                if not re.search(rf'`{re.escape(word)}`', content):
                    print(f"❌ Missing backticks around ({word}). {file_path} at line {line_number}")
                    check_failed = True

    if check_failed:
        error_handler = True
        results["Backtick check"] = "Failed"

def directory_check(file: io, file_path: str) -> None:
    global error_handler, results
    file.seek(0)
    check_failed = False

    # Normalize path and split into parts
    normalized_path = os.path.normpath(file_path)  # handles / and \
    path_parts = normalized_path.split(os.sep)

    # Fail if '/base/' is part of the path
    if "base" in path_parts:
        print(f"❗ {file_path} is changed/added in the base directory.\nIf this is intended, please notify a maintainer.")
        check_failed = True

    # Fail if '/archive/' is part of the path
    if "archive" in path_parts:
        print(f"❗ {file_path} is changed/added in the archive directory.\nIf this is intended, please notify a maintainer.")
        check_failed = True

    if check_failed:
        error_handler = True
        results["Directory check"] = "Failed"

def non_innodb_engine_check(file: io, file_path: str) -> None:
    global error_handler, results
    file.seek(0)
    check_failed = False

    engine_pattern = re.compile(r'ENGINE\s*=\s*([a-zA-Z0-9_]+)', re.IGNORECASE)

    for line_number, line in enumerate(file, start=1):
        match = engine_pattern.search(line)
        if match:
            engine = match.group(1).lower()
            if engine != "innodb":
                print(f"❌ Non-InnoDB engine found: '{engine}' in {file_path} at line {line_number}")
                check_failed = True

    if check_failed:
        error_handler = True
        results["Table engine check"] = "Failed"    

def sniffable_data_check(file: io, file_path: str) -> None:
    global results
    file.seek(0)
    
    # Define sniffable tables and their columns
    # Based https://www.azerothcore.org/wiki/sniffing-and-parsing#fields-that-are-sniffed
    # Commit: https://github.com/azerothcore/wiki/blob/f81a452bb97bdf36ebf73bf75d62618bb2643f37/docs/sniffing-and-parsing.md
    # Tables are seperated by a newline/space below
    sniffable_data = {
        "achievement": ["Description", "Title", "Reward", "ID", "InstanceID", "Faction", "Supercedes", "Category", "MinimumCriteria", "Points", "Flags", "UiOrder", "IconFileID", "RewardItemID", "CriteriaTree", "SharesCriteria", "CovenantID", "VerifiedBuild"],
        
        "broadcast_text": ["Text", "Text1", "ID", "LanguageID", "ConditionID", "EmotesID", "Flags", "ChatBubbleDurationMs", "SoundEntriesID1", "SoundEntriesID2", "EmoteID1", "EmoteID2", "EmoteID3", "EmoteDelay1", "EmoteDelay2", "EmoteDelay3", "VerifiedBuild"],
        
        "cfg_regions": ["ID", "Tag", "RegionID", "Raidorigin", "RegionGroupMask", "ChallengeOrigin", "VerifiedBuild"],
        
        "creature": ["guid", "id", "map", "zoneId", "areaId", "spawnDifficulties", "PhaseId", "PhaseGroup", "modelid", "equipment_id", "position_x", "position_y", "position_z", "orientation", "spawntimesecs", "spawndist", "currentwaypoint", "curhealth", "curmana", "MovementType", "npcflag", "unit_flags", "dynamicflags", "VerifiedBuild"],
        
        "creature_addon": ["guid", "path_id", "mount", "bytes1", "bytes2", "emote", "aiAnimKit", "movementAnimKit", "meleeAnimKit", "auras"],
        
        "creature_equip_template": ["CreatureID", "ID", "ItemID1", "AppearanceModID1", "ItemVisual1", "ItemID2", "AppearanceModID2", "ItemVisual2", "ItemID3", "AppearanceModID3", "ItemVisual3"],
        
        "creature_model_info": ["DisplayID", "BoundingRadius", "CombatReach", "DisplayID_Other_Gender", "VerifiedBuild"],
        
        "creature_template": ["entry", "gossip_menu_id", "minlevel", "maxlevel", "faction", "npcflag", "speed_walk", "speed_run", "BaseAttackTime", "RangeAttackTime", "unit_flags", "unit_flags2", "unit_flags3", "dynamicflags", "VehicleId", "HoverHeight", "KillCredit1", "KillCredit2", "name", "femaleName", "subname", "TitleAlt", "IconName", "HealthScalingExpansion", "RequiredExpansion", "VignetteID", "unit_class", "WidgetSetID", "WidgetSetUnitConditionID", "rank", "family", "type", "type_flags", "type_flags2", "HealthModifier", "ManaModifier", "RacialLeader", "movementId", "CreatureDifficultyID", "VerifiedBuild"],
        
        "creature_template_addon": ["entry", "path_id", "mount", "bytes1", "bytes2", "emote", "aiAnimKit", "movementAnimKit", "meleeAnimKit", "auras"],
        
        "creature_template_model": ["CreatureID", "Idx", "CreatureDisplayID", "DisplayScale", "Probability", "VerifiedBuild"],
        
        "creature_template_scaling": ["Entry", "DifficultyID", "LevelScalingDeltaMin", "LevelScalingDeltaMax", "ContentTuningID", "VerifiedBuild"],
        
        "creature_text": ["CreatureID", "GroupID", "ID", "Text", "Type", "Language", "Probability", "Emote", "Duration", "Sound", "BroadcastTextId", "comment"],
        
        "creature_trainer": ["CreatureId", "TrainerId", "MenuID", "OptionIndex"],
        
        "criteria_tree": ["ID", "Description", "Parent", "Amount", "Operator", "CriteriaID", "OrderIndex", "Flags", "VerifiedBuild"],
        
        "currency_types": ["ID", "Name", "Description", "CategoryID", "InventoryIconFileID", "SpellWeight", "SpellCategory", "MaxQty", "MaxEarnablePerWeek", "Quality", "FactionID", "ItemGroupSoundsID", "XpQuestDifficulty", "AwardConditionID", "MaxQtyWorldStateID", "Flags1", "Flags2", "VerifiedBuild"],
        
        "curve": ["ID", "Type", "Flags", "VerifiedBuild"],
        
        "curve_point": ["ID", "PosX", "PosY", "PosPreSquishX", "PosPreSquishY", "CurveID", "OrderIndex", "VerifiedBuild"],
        
        "dungeon_encounter": ["Name", "ID", "MapID", "DifficultyID", "OrderIndex", "CompleteWorldStateID", "Bit", "CreatureDisplayID", "Flags", "SpellIconFileID", "Faction", "VerifiedBuild"],
        
        "gameobject": ["guid", "id", "map", "zoneId", "areaId", "spawnDifficulties", "PhaseId", "PhaseGroup", "position_x", "position_y", "position_z", "orientation", "rotation0", "rotation1", "rotation2", "rotation3", "spawntimesecs", "animprogress", "state", "VerifiedBuild"],
        
        "gameobject_addon": ["guid", "parent_rotation0", "parent_rotation1", "parent_rotation2", "parent_rotation3", "WorldEffectID", "AIAnimKitID"],
        
        "gameobject_questitem": ["GameObjectEntry", "Idx", "ItemId", "VerifiedBuild"],
        
        "gameobject_template": ["entry", "type", "displayId", "name", "IconName", "castBarCaption", "unk1", "size", "Data0", "Data1", "Data2", "Data3", "Data4", "Data5", "Data6", "Data7", "Data8", "Data9", "Data10", "Data11", "Data12", "Data13", "Data14", "Data15", "Data16", "Data17", "Data18", "Data19", "Data20", "Data21", "Data22", "Data23", "Data24", "Data25", "Data26", "Data27", "Data28", "Data29", "Data30", "Data31", "Data32", "Data33", "ContentTuningId", "VerifiedBuild"],
        
        "gameobject_template_addon": ["entry", "faction", "flags", "WorldEffectID", "AIAnimKitID"],
        
        "gossip_menu": ["MenuId", "TextId", "VerifiedBuild"],
        
        "gossip_menu_option": ["MenuId", "OptionIndex", "OptionIcon", "OptionText", "OptionBroadcastTextId", "VerifiedBuild"],
        
        "gossip_menu_option_action": ["MenuId", "OptionIndex", "ActionMenuId", "ActionPoiId"],
        
        "hotfix_blob": ["TableHash", "RecordId", "locale", "Blob", "VerifiedBuild"],
        
        "hotfix_data": ["Id", "TableHash", "RecordId", "Status", "VerifiedBuild"],
        
        "hotfix_optional_data": ["TableHash", "RecordId", "locale", "Key", "Data", "VerifiedBuild"],
        
        "item": ["ID", "ClassID", "SubclassID", "Material", "InventoryType", "SheatheType", "SoundOverrideSubclassID", "IconFileDataID", "ItemGroupSoundsID", "ModifiedCraftingReagentItemID", "VerifiedBuild"],
        
        "item_spec_override": ["ID", "SpecID", "ItemID", "VerifiedBuild"],
        
        "item_search_name": ["ID", "AllowableRace", "Display", "OverallQualityID", "ExpansionID", "MinFactionID", "MinReputation", "AllowableClass", "RequiredLevel", "RequiredSkill", "RequiredSkillRank", "RequiredAbility", "ItemLevel", "Flags1", "Flags2", "Flags3", "Flags4", "VerifiedBuild"],
        
        "item_sparse": ["ID", "AllowableRace", "Description", "Display3", "Display2", "Display1", "Display", "ExpansionID", "DmgVariance", "LimitCategory", "DurationInInventory", "QualityModifier", "BagFamily", "ItemRange", "StatPercentageOfSocket1", "StatPercentageOfSocket2", "StatPercentageOfSocket3", "StatPercentageOfSocket4", "StatPercentageOfSocket5", "StatPercentageOfSocket6", "StatPercentageOfSocket7", "StatPercentageOfSocket8", "StatPercentageOfSocket9", "StatPercentageOfSocket10", "StatPercentEditor1", "StatPercentEditor2", "StatPercentEditor3", "StatPercentEditor4", "StatPercentEditor5", "StatPercentEditor6", "StatPercentEditor7", "StatPercentEditor8", "StatPercentEditor9", "StatPercentEditor10", "Stackable", "MaxCount", "RequiredAbility", "SellPrice", "BuyPrice", "VendorStackCount", "PriceVariance", "PriceRandomValue", "Flags1", "Flags2", "Flags3", "Flags4", "FactionRelated", "ModifiedCraftingReagentItemID", "ContentTuningID", "PlayerLevelToItemLevelCurveID", "ItemNameDescriptionID", "RequiredTransmogHoliday", "RequiredHoliday", "GemProperties", "SocketMatchEnchantmentId", "TotemCategoryID", "InstanceBound", "ZoneBound1", "ZoneBound2", "ItemSet", "LockID", "StartQuestID", "PageID", "ItemDelay", "MinFactionID", "RequiredSkillRank", "RequiredSkill", "ItemLevel", "AllowableClass", "ArtifactID", "SpellWeight", "SpellWeightCategory", "SocketType1", "SocketType2", "SocketType3", "SheatheType", "Material", "PageMaterialID", "LanguageID", "Bonding", "DamageDamageType", "StatModifierBonusStat1", "StatModifierBonusStat2", "StatModifierBonusStat3", "StatModifierBonusStat4", "StatModifierBonusStat5", "StatModifierBonusStat6", "StatModifierBonusStat7", "StatModifierBonusStat8", "StatModifierBonusStat9", "StatModifierBonusStat10", "ContainerSlots", "MinReputation", "RequiredPVPMedal", "RequiredPVPRank", "RequiredLevel", "InventoryType", "OverallQualityID", "VerifiedBuild"],
        "item_bonus_tree_node": ["ID", "ItemContext", "ChildItemBonusTreeID", "ChildItemBonusListID", "ChildItemLevelSelectorID", "ItemBonusListGroupID", "ParentItemBonusTreeNodeID", "ParentItemBonusTreeID", "VerifiedBuild"],
        
        "item_level_selector": ["ID", "MinItemLevel", "ItemLevelSelectorQualitySetID", "AzeriteUnlockMappingSet", "VerifiedBuild"],
        
        "item_modified_appearance": ["ID", "ItemID", "ItemAppearanceModifierID", "ItemAppearanceID", "OrderIndex", "TransmogSourceTypeEnum", "VerifiedBuild"],
        
        "mount": ["Name", "SourceText", "Description", "ID", "MountTypeID", "Flags", "SourceTypeEnum", "SourceSpellID", "PlayerConditionID", "MountFlyRideHeight", "UiModelSceneID", "MountSpecialRiderAnimKitID", "MountSpecialSpellVisualKitID", "VerifiedBuild"],
        
        "npc_spellclick_spells": ["npc_entry", "spell_id", "cast_flags", "user_type"],
        
        "npc_text": ["ID", "Probability0", "Probability1", "Probability2", "Probability3", "Probability4", "Probability5", "Probability6", "Probability7", "BroadcastTextId0", "BroadcastTextId1", "BroadcastTextId2", "BroadcastTextId3", "BroadcastTextId4", "BroadcastTextId5", "BroadcastTextId6", "BroadcastTextId7", "VerifiedBuild"],
        
        "npc_vendor": ["entry", "slot", "item", "maxcount", "ExtendedCost", "type", "PlayerConditionID", "IgnoreFiltering", "VerifiedBuild"],
        
        "object_names": ["ObjectType", "Id", "Name"],
        
        "page_text": ["ID", "Text", "NextPageID", "PlayerConditionID", "Flags", "VerifiedBuild"],
        
        "player_condition": ["ID", "RaceMask", "FailureDescription", "ClassMask", "SkillLogic", "LanguageID", "MinLanguage", "MaxLanguage", "MaxFactionID", "MaxReputation", "ReputationLogic", "CurrentPvpFaction", "PvpMedal", "PrevQuestLogic", "CurrQuestLogic", "CurrentCompletedQuestLogic", "SpellLogic", "ItemLogic", "ItemFlags", "AuraSpellLogic", "WorldStateExpressionID", "WeatherID", "PartyStatus", "LifetimeMaxPVPRank", "AchievementLogic", "Gender", "NativeGender", "AreaLogic", "LfgLogic", "CurrencyLogic", "QuestKillID", "QuestKillLogic", "MinExpansionLevel", "MaxExpansionLevel", "MinAvgItemLevel", "MaxAvgItemLevel", "MinAvgEquippedItemLevel", "MaxAvgEquippedItemLevel", "PhaseUseFlags", "PhaseID", "PhaseGroupID", "Flags", "ChrSpecializationIndex", "ChrSpecializationRole", "ModifierTreeID", "PowerType", "PowerTypeComp", "PowerTypeValue", "WeaponSubclassMask", "MaxGuildLevel", "MinGuildLevel", "MaxExpansionTier", "MinExpansionTier", "MinPVPRank", "MaxPVPRank", "ContentTuningID", "CovenantID", "SkillID1", "SkillID2", "SkillID3", "SkillID4", "MinSkill1", "MinSkill2", "MinSkill3", "MinSkill4", "MaxSkill1", "MaxSkill2", "MaxSkill3", "MaxSkill4", "MinFactionID1", "MinFactionID2", "MinFactionID3", "MinReputation1", "MinReputation2", "MinReputation3", "PrevQuestID1", "PrevQuestID2", "PrevQuestID3", "PrevQuestID4", "CurrQuestID1", "CurrQuestID2", "CurrQuestID3", "CurrQuestID4", "CurrentCompletedQuestID1", "CurrentCompletedQuestID2", "CurrentCompletedQuestID3", "CurrentCompletedQuestID4", "SpellID1", "SpellID2", "SpellID3", "SpellID4", "ItemID1", "ItemID2", "ItemID3", "ItemID4", "ItemCount1", "ItemCount2", "ItemCount3", "ItemCount4", "Explored1", "Explored2", "Time1", "Time2", "AuraSpellID1", "AuraSpellID2", "AuraSpellID3", "AuraSpellID4", "AuraStacks1", "AuraStacks2", "AuraStacks3", "AuraStacks4", "Achievement1", "Achievement2", "Achievement3", "Achievement4", "AreaID1", "AreaID2", "AreaID3", "AreaID4", "LfgStatus1", "LfgStatus2", "LfgStatus3", "LfgStatus4", "LfgCompare1", "LfgCompare2", "LfgCompare3", "LfgCompare4", "LfgValue1", "LfgValue2", "LfgValue3", "LfgValue4", "CurrencyID1", "CurrencyID2", "CurrencyID3", "CurrencyID4", "CurrencyCount1", "CurrencyCount2", "CurrencyCount3", "CurrencyCount4", "QuestKillMonster1", "QuestKillMonster2", "QuestKillMonster3", "QuestKillMonster4", "QuestKillMonster5", "QuestKillMonster6", "MovementFlags1", "MovementFlags2", "VerifiedBuild"],
        
        "playerchoice": ["ChoiceId", "UiTextureKitId", "SoundKitId", "Question", "HideWarboardHeader", "KeepOpenAfterChoice", "VerifiedBuild"],
        
        "playerchoice_response": ["ChoiceId", "ResponseId", "ResponseIdentifier", "Index", "ChoiceArtFileId", "Flags", "WidgetSetId", "UiTextureAtlasElementID", "SoundKitId", "GroupId", "Header", "Subheader", "ButtonTooltip", "Answer", "Description", "Confirmation", "RewardQuestID", "UiTextureKitID", "VerifiedBuild"],
        
        "playercreateinfo": ["race", "class", "map", "zone", "position_x", "position_y", "position_z", "orientation"],
        
        "points_of_interest": ["ID", "PositionX", "PositionY", "PositionZ", "Icon", "Flags", "Importance", "Name", "VerifiedBuild"],
        
        "quest_details": ["ID", "Emote1", "Emote2", "Emote3", "Emote4", "EmoteDelay1", "EmoteDelay2", "EmoteDelay3", "EmoteDelay4", "VerifiedBuild"],
        
        "quest_greeting": ["ID", "Type", "GreetEmoteType", "GreetEmoteDelay", "Greeting", "VerifiedBuild"],
        
        "quest_objectives": ["ID", "QuestID", "Type", "Order", "StorageIndex", "ObjectID", "Amount", "Flags", "Flags2", "ProgressBarWeight", "Description", "VerifiedBuild"],
        
        "quest_offer_reward": ["ID", "Emote1", "Emote2", "Emote3", "Emote4", "EmoteDelay1", "EmoteDelay2", "EmoteDelay3", "EmoteDelay4", "RewardText", "VerifiedBuild"],
        
        "quest_poi": ["QuestID", "BlobIndex", "Idx1", "ObjectiveIndex", "QuestObjectiveID", "QuestObjectID", "MapID", "UiMapID", "Priority", "Flags", "WorldEffectID", "PlayerConditionID", "NavigationPlayerConditionID", "SpawnTrackingID", "AlwaysAllowMergingBlobs", "VerifiedBuild"],
        
        "quest_poi_points": ["QuestID", "Idx1", "Idx2", "X", "Y", "Z", "VerifiedBuild"],
        
        "quest_request_items": ["ID", "EmoteOnComplete", "EmoteOnIncomplete", "EmoteOnCompleteDelay", "EmoteOnIncompleteDelay", "CompletionText", "VerifiedBuild"],
        
        "quest_template": ["ID", "QuestType", "QuestPackageID", "ContentTuningID", "QuestSortID", "QuestInfoID", "SuggestedGroupNum", "RewardNextQuest", "RewardXPDifficulty", "RewardXPMultiplier", "RewardMoney", "RewardMoneyDifficulty", "RewardMoneyMultiplier", "RewardBonusMoney", "RewardSpell", "RewardHonor", "RewardKillHonor", "StartItem", "RewardArtifactXPDifficulty", "RewardArtifactXPMultiplier", "RewardArtifactCategoryID", "Flags", "FlagsEx", "FlagsEx2", "RewardSkillLineID", "RewardNumSkillUps", "PortraitGiver", "PortraitGiverMount", "PortraitGiverModelSceneID", "PortraitTurnIn", "RewardItem1", "RewardItem2", "RewardItem3", "RewardItem4", "RewardAmount1", "RewardAmount2", "RewardAmount3", "RewardAmount4", "ItemDrop1", "ItemDrop2", "ItemDrop3", "ItemDrop4", "ItemDropQuantity1", "ItemDropQuantity2", "ItemDropQuantity3", "ItemDropQuantity4", "RewardChoiceItemID1", "RewardChoiceItemID2", "RewardChoiceItemID3", "RewardChoiceItemID4", "RewardChoiceItemID5", "RewardChoiceItemID6", "RewardChoiceItemQuantity1", "RewardChoiceItemQuantity2", "RewardChoiceItemQuantity3", "RewardChoiceItemQuantity4", "RewardChoiceItemQuantity5", "RewardChoiceItemQuantity6", "RewardChoiceItemDisplayID1", "RewardChoiceItemDisplayID2", "RewardChoiceItemDisplayID3", "RewardChoiceItemDisplayID4", "RewardChoiceItemDisplayID5", "RewardChoiceItemDisplayID6", "POIContinent", "POIx", "POIy", "POIPriority", "RewardTitle", "RewardArenaPoints", "RewardFactionID1", "RewardFactionID2", "RewardFactionID3", "RewardFactionID4", "RewardFactionID5", "RewardFactionValue1", "RewardFactionValue2", "RewardFactionValue3", "RewardFactionValue4", "RewardFactionValue5", "RewardFactionCapIn1", "RewardFactionCapIn2", "RewardFactionCapIn3", "RewardFactionCapIn4", "RewardFactionCapIn5", "RewardFactionOverride1", "RewardFactionOverride2", "RewardFactionOverride3", "RewardFactionOverride4", "RewardFactionOverride5", "RewardFactionFlags", "AreaGroupID", "TimeAllowed", "AllowableRaces", "TreasurePickerID", "Expansion", "ManagedWorldStateID", "QuestSessionBonus", "LogTitle", "LogDescription", "QuestDescription", "AreaDescription", "QuestCompletionLog", "RewardCurrencyID1", "RewardCurrencyID2", "RewardCurrencyID3", "RewardCurrencyID4", "RewardCurrencyQty1", "RewardCurrencyQty2", "RewardCurrencyQty3", "RewardCurrencyQty4", "PortraitGiverText", "PortraitGiverName", "PortraitTurnInText", "PortraitTurnInName", "AcceptedSoundKitID", "CompleteSoundKitID", "VerifiedBuild"],
        
        "quest_v2": ["ID", "UniqueBitFlag", "VerifiedBuild"],
        
        "quest_visual_effect": ["ID", "Index", "VisualEffect", "VerifiedBuild"],
        
        "sniff_data": ["Build", "SniffName", "ObjectType", "Id", "Data"],
        
        "spell_aura_options": ["ID", "DifficultyID", "CumulativeAura", "ProcCategoryRecovery", "ProcChance", "ProcCharges", "SpellProcsPerMinuteID", "ProcTypeMask1", "ProcTypeMask2", "SpellID", "VerifiedBuild"],
        
        "spell_aura_restrictions": ["ID", "DifficultyID", "CasterAuraState", "TargetAuraState", "ExcludeCasterAuraState", "ExcludeTargetAuraState", "CasterAuraSpell", "TargetAuraSpell", "ExcludeCasterAuraSpell", "ExcludeTargetAuraSpell", "SpellID", "VerifiedBuild"],
        
        "spell_categories": ["ID", "DifficultyID", "Category", "DefenseType", "DispelType", "Mechanic", "PreventionType", "StartRecoveryCategory", "ChargeCategory", "SpellID", "VerifiedBuild"],
        
        "spell_cooldowns": ["ID", "DifficultyID", "CategoryRecoveryTime", "RecoveryTime", "StartRecoveryTime", "SpellID", "VerifiedBuild"],
        
        "spell_effect": ["ID", "EffectAura", "DifficultyID", "EffectIndex", "Effect", "EffectAmplitude", "EffectAttributes", "EffectAuraPeriod", "EffectBonusCoefficient", "EffectChainAmplitude", "EffectChainTargets", "EffectItemType", "EffectMechanic", "EffectPointsPerResource", "EffectPosFacing", "EffectRealPointsPerLevel", "EffectTriggerSpell", "BonusCoefficientFromAP", "PvpMultiplier", "Coefficient", "Variance", "ResourceCoefficient", "GroupSizeBasePointsCoefficient", "EffectBasePoints", "ScalingClass", "EffectMiscValue1", "EffectMiscValue2", "EffectRadiusIndex1", "EffectRadiusIndex2", "EffectSpellClassMask1", "EffectSpellClassMask2", "EffectSpellClassMask3", "EffectSpellClassMask4", "ImplicitTarget1", "ImplicitTarget2", "SpellID", "VerifiedBuild"],
        
        "spell_name": ["ID", "Name", "VerifiedBuild"],
        
        "spell_misc": ["ID", "Attributes1", "Attributes2", "Attributes3", "Attributes4", "Attributes5", "Attributes6", "Attributes7", "Attributes8", "Attributes9", "Attributes10", "Attributes11", "Attributes12", "Attributes13", "Attributes14", "Attributes15", "DifficultyID", "CastingTimeIndex", "DurationIndex", "RangeIndex", "SchoolMask", "Speed", "LaunchDelay", "MinDuration", "SpellIconFileDataID", "ActiveIconFileDataID", "ContentTuningID", "ShowFutureSpellPlayerConditionID", "SpellVisualScript", "ActiveSpellVisualScript", "SpellID", "VerifiedBuild"],
        
        "spell_target_restrictions": ["ID", "DifficultyID", "ConeDegrees", "MaxTargets", "MaxTargetLevel", "TargetCreatureType", "Targets", "Width", "SpellID", "VerifiedBuild"],
        
        "summon_properties": ["ID", "Control", "Faction", "Title", "Slot", "Flags", "VerifiedBuild"],
        
        "tact_key": ["ID", "Key1", "Key2", "Key3", "Key4", "Key5", "Key6", "Key7", "Key8", "Key9", "Key10", "Key11", "Key12", "Key13", "Key14", "Key15", "Key16", "VerifiedBuild"],
        
        "toy": ["SourceText", "ID", "ItemID", "Flags", "SourceTypeEnum", "VerifiedBuild"],
        
        "trainer": ["Id", "Type", "Greeting", "VerifiedBuild"],
        
        "trainer_spell": ["TrainerId", "SpellId", "MoneyCost", "ReqSkillLine", "ReqSkillRank", "ReqAbility1", "ReqAbility2", "ReqAbility3", "ReqLevel", "VerifiedBuild"],
        
        "vehicle_template_accessory": ["entry", "accessory_entry", "seat_id", "minion", "description", "summontype", "summontimer"],
        
        "weather_update": ["map_id", "zone_id", "weather_state", "grade", "unk"]
    }
    
    for line_number, line in enumerate(file, start=1):
        # skip/ignore comments
        if line.strip().startswith('--'):
            continue
            
        # For UPDATEs
        update_match = re.match(r'UPDATE\s+`?([^`\s]+)`?\s+SET\s+(.*?)(?:\s+WHERE|$)', line.strip(), re.IGNORECASE)
        if update_match:
            table_name = update_match.group(1)
            set_clause = update_match.group(2)
            
            if table_name in sniffable_data:
                # Extract columns being updated
                column_updates = re.findall(r'`?([^`\s=]+)`?\s*=', set_clause)
                sniffable_columns = []
                
                for column in column_updates:
                    if column in sniffable_data[table_name]:
                        sniffable_columns.append(column)
                
                if sniffable_columns:
                    columns_str = ", ".join(sniffable_columns)
                    print(f"❗ Column(s) {columns_str} from `{table_name}` are being changed, these values are sniffable. {file_path} at line {line_number}")
        
        # For INSERTs
        insert_match = re.match(r'INSERT\s+INTO\s+`?([^`\s]+)`?\s*\(\s*([^)]+)\s*\)', line.strip(), re.IGNORECASE)
        if insert_match:
            table_name = insert_match.group(1)
            columns_str = insert_match.group(2)
            
            if table_name in sniffable_data:
                # Extract column names
                columns = [col.strip().strip('`') for col in columns_str.split(',')]
                sniffable_columns = []
                
                for column in columns:
                    if column in sniffable_data[table_name]:
                        sniffable_columns.append(column)
                
                if sniffable_columns:
                    columns_str = ", ".join(sniffable_columns)
                    print(f"❗ Column(s) {columns_str} from `{table_name}` are being inserted, these values are sniffable. {file_path} at line {line_number}")

# Collect all files from matching directories
all_files = collect_files_from_directories(src_directory) + collect_files_from_directories(base_directory) + collect_files_from_directories(archive_directory)

# Main function
parsing_file(all_files)
