import os
import sys

# Get the src directory of the project
src_directory = os.path.join(os.getcwd(), 'src')

# Global variables
error_handler = False
results = {
    "Multiple blank lines check": "Passed",
    "Trailing whitespace check": "Passed",
    "GetCounter() check": "Passed",
    "GetTypeId() check": "Passed",
    "NpcFlagHelpers check": "Passed"
}

# Main function to parse all the files of the project
def parsing_file(directory):
    for root, _, files in os.walk(directory):
        for file in files:
            if not file.endswith('.ico'):                                   # Skip .ico files that cannot be read
                file_path = os.path.join(root, file)
                file_name = file
                try:
                    with open(file_path, 'r', encoding='utf-8') as file:
                        multipleBlankLines_check(file, file_path)
                        trailing_whitespace_check(file, file_path)
                        getCounter_check(file, file_path)
                        if file_name != 'Object.h':
                            getTypeId_check(file, file_path)
                        if file_name != 'Unit.h':
                            npcFlagHelpers_check(file, file_path)
                except UnicodeDecodeError:
                    print(f"\nCould not decode file {file_path}")
                    sys.exit(1)
    # Output the results
    print("")
    for check, result in results.items():
        print(f"{check} : {result}")
    if error_handler:
        print("\nPlease fix the codestyle issues above.")
        sys.exit(1)
    else:
        print(f"\nEverything looks good")

# Codestyle patterns checking for multiple blank lines
def multipleBlankLines_check(file, file_path):
    global error_handler, results
    file.seek(0)  # Reset file pointer to the beginning
    check_failed = False
    consecutive_blank_lines = 0
    # Parse all the file
    for line_number, line in enumerate(file, start = 1):
        if line.strip() == '':
            consecutive_blank_lines += 1
            if consecutive_blank_lines > 1:
                print(f"Multiple blank lines found in {file_path} at line {line_number - 1}")
                check_failed = True
        else:
            consecutive_blank_lines = 0
    # Additional check for the end of the file
    if consecutive_blank_lines >= 1:
        print(f"Multiple blank lines found at the end of: {file_path}")
        check_failed = True
    # Handle the script error and update the result output
    if check_failed:
        error_handler = True
        results["Multiple blank lines check"] = "Failed"

# Codestyle patterns checking for whitespace at the end of the lines
def trailing_whitespace_check(file, file_path):
    global error_handler, results
    file.seek(0)  # Reset file pointer to the beginning
    # Parse all the file
    for line_number, line in enumerate(file, start = 1):
        if line.endswith(' \n'):
            print(f"Trailing whitespace found: {file_path} at line {line_number}")
            if not error_handler:
                error_handler = True
                results["Trailing whitespace check"] = "Failed"

# Codestyle patterns checking for ObjectGuid::GetCounter()
def getCounter_check(file, file_path):
    global error_handler
    file.seek(0) # Reset file pointer to the beginning
    # Parse all the file
    for line_number, line in enumerate(file, start = 1):
        if 'ObjectGuid::GetCounter()' in line:
            print(f"Please use ObjectGuid::ToString().c_str() instead ObjectGuid::GetCounter(): {file_path} at line {line_number}")
            if not error_handler:
                error_handler = True
                results["GetCounter() check"] = "Failed"

# Codestyle patterns checking for GetTypeId()
# Unused for now. Need to fix all usage in the core before adding the check to the github workflow
def getTypeId_check(file, file_path):
    global error_handler, results
    file.seek(0)  # Reset file pointer to the beginning
    check_failed = False
    # Parse all the file
    for line_number, line in enumerate(file, start = 1):
        if 'GetTypeId() == TYPEID_PLAYER' in line:
            print(f"Please use IsPlayer() instead GetTypeId(): {file_path} at line {line_number}")
            check_failed = True
        if 'GetTypeId() == TYPEID_ITEM' in line:
            print(f"Please use IsItem() instead GetTypeId(): {file_path} at line {line_number}")
            check_failed = True
        if 'GetTypeId() == TYPEID_GAMEOBJECT' in line:
            print(f"Please use IsGameObject() instead GetTypeId(): {file_path} at line {line_number}")
            check_failed = True
        if 'GetTypeId() == TYPEID_DYNOBJECT' in line:
            print(f"Please use IsDynamicObject() instead GetTypeId(): {file_path} at line {line_number}")
            check_failed = True
    # Handle the script error and update the result output
    if check_failed:
        error_handler = True
        results["GetTypeId() check"] = "Failed"

# Codestyle patterns checking for NpcFlag helpers
def npcFlagHelpers_check(file, file_path):
    global error_handler, results
    file.seek(0)  # Reset file pointer to the beginning
    check_failed = False
    # Parse all the file
    for line_number, line in enumerate(file, start = 1):
        if 'GetUInt32Value(UNIT_NPC_FLAGS)' in line:
            print(
                f"Please use GetNpcFlags() instead GetUInt32Value(UNIT_NPC_FLAGS): {file_path} at line {line_number}")
            check_failed = True
        if 'HasFlag(UNIT_NPC_FLAGS,' in line:
            print(
                f"Please use HasNpcFlag() instead HasFlag(UNIT_NPC_FLAGS, ...): {file_path} at line {line_number}")
            check_failed = True
        if 'SetUInt32Value(UNIT_NPC_FLAGS,' in line:
            print(
                f"Please use ReplaceAllNpcFlags() instead SetUInt32Value(UNIT_NPC_FLAGS, ...): {file_path} at line {line_number}")
            check_failed = True
        if 'SetFlag(UNIT_NPC_FLAGS,' in line:
            print(
                f"Please use SetNpcFlag() instead SetFlag(UNIT_NPC_FLAGS, ...): {file_path} at line {line_number}")
            check_failed = True
        if 'RemoveFlag(UNIT_NPC_FLAGS,' in line:
            print(
                f"Please use RemoveNpcFlag() instead RemoveFlag(UNIT_NPC_FLAGS, ...): {file_path} at line {line_number}")
    # Handle the script error and update the result output
    if check_failed:
        error_handler = True
        results["NpcFlagHelpers check"] = "Failed"

# Main function
parsing_file(src_directory)
