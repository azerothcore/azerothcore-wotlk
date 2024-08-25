import os
import sys

# Get the src directory of the project
src_directory = os.path.join(os.path.abspath(os.path.dirname(__file__)), 'src')

error_handler = False

def parsing_file(directory):
    for root, _, files in os.walk(directory):
        for file in files:
            if not file.endswith('.ico'):
                file_path = os.path.join(root, file)
                file_name = file
                try:
                    with open(file_path, 'r', encoding='utf-8') as file:
                        multipleBlankLines_check(file, file_path)
                        trailing_whitespace_check(file, file_path)
                        getCounter_check(file, file_path)
                        #if file_name != 'Object.h':
                            #getTypeId_check(file, file_path)
                        if file_name != 'Unit.h':
                            npcFlagHelpers_check(file, file_path)
                except UnicodeDecodeError:
                    print(f"Could not decode file {file_path}")
                    sys.exit(1)
    if error_handler:
        print("Please fix the codestyle issues above.")
        sys.exit(1)
    elif not error_handler:
        print(f"All codestyle checks are passed. Everything is fine")

# Codestyle patterns checking for multiple blank lines
def multipleBlankLines_check(file, file_path):
    global error_handler
    file.seek(0)  # Reset file pointer to the beginning
    consecutive_blank_lines = 0
    for line_number, line in enumerate(file, start=1):
        if line.strip() == '':
            consecutive_blank_lines += 1
            if consecutive_blank_lines > 1:
                print(
                    f"Multiple blank lines found in {file_path} at line {line_number - 1}")
                error_handler = True
        else:
            consecutive_blank_lines = 0

# Codestyle patterns checking for whitespace at the end of the lines
def trailing_whitespace_check(file, file_path):
    global error_handler
    file.seek(0)  # Reset file pointer to the beginning
    for line_number, line in enumerate(file, start=1):
        if line.endswith(' \n'):
            print(
                f"Trailing whitespace found: {file_path} at line {line_number}")
            error_handler = True

# Codestyle patterns checking for ObjectGuid::GetCounter()
def getCounter_check(file, file_path):
    global error_handler
    file.seek(0) # Reset file pointer to the beginning
    for line_number, line in enumerate(file, start=1):
        if 'ObjectGuid::GetCounter()' in line:
            print(
                f"Please use ObjectGuid::ToString().c_str() instead ObjectGuid::GetCounter():"
                f" {file_path} at line {line_number}")
            error_handler = True

# Codestyle patterns checking for GetTypeId()
def getTypeId_check(file, file_path):
    global error_handler
    file.seek(0)  # Reset file pointer to the beginning
    for line_number, line in enumerate(file, start=1):
        if 'GetTypeId() == TYPEID_PLAYER' or 'GetTypeId() != TYPEID_PLAYER' in line:
            print(f"Please use IsPlayer() instead GetTypeId() == TYPEID_PLAYER:"
                  f" {file_path} at line {line_number}")
            error_handler = True
        if 'GetTypeId() == TYPEID_ITEM' or 'GetTypeId() != TYPEID_ITEM' in line:
            print(f"Please use IsItem() instead GetTypeId():"
                  f" {file_path} at line {line_number}")
            error_handler = True
        if 'GetTypeId() == TYPEID_GAMEOBJECT' or 'GetTypeId() != TYPEID_GAMEOBJECT' in line:
            print(f"Please use IsGameObject() instead GetTypeId():"
                  f" {file_path} at line {line_number}")
            error_handler = True
        if 'GetTypeId() == TYPEID_DYNOBJECT' or 'GetTypeId() != TYPEID_DYNOBJECT' in line:
            print(f"Please use IsDynamicObject() instead GetTypeId():"
                  f" {file_path} at line {line_number}")
            error_handler = True

# Codestyle patterns checking for NpcFlag helpers
def npcFlagHelpers_check(file, file_path):
    global error_handler
    file.seek(0)  # Reset file pointer to the beginning
    for line_number, line in enumerate(file, start=1):
        if 'GetUInt32Value(UNIT_NPC_FLAGS)' in line:
            print(
                f"Please use GetNpcFlags() instead GetUInt32Value(UNIT_NPC_FLAGS):"
                f" {file_path} at line {line_number}")
            error_handler = True
        if 'HasFlag(UNIT_NPC_FLAGS,' in line:
            print(
                f"Please use HasNpcFlag() instead HasFlag(UNIT_NPC_FLAGS, ...):"
                f" {file_path} at line {line_number}")
            error_handler = True
        if 'SetUInt32Value(UNIT_NPC_FLAGS,' in line:
            print(
                f"Please use ReplaceAllNpcFlags() instead SetUInt32Value(UNIT_NPC_FLAGS, ...):"
                f" {file_path} at line {line_number}")
            error_handler = True
        if 'SetFlag(UNIT_NPC_FLAGS,' in line:
            print(
                f"Please use SetNpcFlag() instead SetFlag(UNIT_NPC_FLAGS, ...):"
                f" {file_path} at line {line_number}")
            error_handler = True
        if 'RemoveFlag(UNIT_NPC_FLAGS,' in line:
            print(
                f"Please use RemoveNpcFlag() instead RemoveFlag(UNIT_NPC_FLAGS, ...):"
                f" {file_path} at line {line_number}")
            error_handler = True

parsing_file(src_directory)
