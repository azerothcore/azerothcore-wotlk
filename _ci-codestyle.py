import os

# Get the src directory of the project
src_directory = os.path.join(os.path.abspath(os.path.dirname(__file__)), 'src')

# Codestyle patterns checking for GetTypeId()
def getTypeId_check(directory, exclude_files):
    for root, _, files in os.walk(directory):
        for file in files:
            if not file.endswith('.ico') and file not in exclude_files:
                file_path = os.path.join(root, file)
                try:
                    with open(file_path, 'r', encoding='utf-8') as file:
                        for line_number, line in enumerate(file, start=1):
                            if 'GetTypeId() == TYPEID_PLAYER' in line:
                                print(f"Player type ID found in {file_path} at line {line_number}")
                                print("Please use IsPlayer() instead GetTypeId() == TYPEID_PLAYER")
                            elif 'GetTypeId() == TYPEID_ITEM' in line:
                                print(f"Item type ID found in {file_path} at line {line_number}")
                                print("Please use IsItem() instead GetTypeId() == TYPEID_ITEM")
                            elif 'GetTypeId() == TYPEID_GAMEOBJECT' in line:
                                print(f"GameObject type ID found in {file_path} at line {line_number}")
                                print("Please use IsGameObject() instead GetTypeId() == TYPEID_GAMEOBJECT")
                            elif 'GetTypeId() == TYPEID_DYNOBJECT' in line:
                                print(f"DynObject type ID found in {file_path} at line {line_number}")
                                print("Please use IsDynamicObject() instead GetTypeId() == TYPEID_DYNOBJECT")
                except UnicodeDecodeError:
                    print(f"Could not decode file {file_path}")

# Codestyle patterns checking for multiple blank lines
def multipleBlankLines_check(directory, exclude_files):
    for root, _, files in os.walk(directory):
        for file in files:
            if not file.endswith('.ico') and file not in exclude_files:
                file_path = os.path.join(root, file)
                try:
                    with open(file_path, 'r', encoding='utf-8') as file:
                        consecutive_blank_lines = 0
                        for line_number, line in enumerate(file, start=1):
                            if line.strip() == '':
                                consecutive_blank_lines += 1
                            else:
                                if consecutive_blank_lines > 1:
                                    print(f"Multiple blank lines found in {file_path} at line {line_number}")
                                consecutive_blank_lines = 0
                except UnicodeDecodeError:
                    print(f"Could not decode file {file_path}")

# Codestyle patterns checking for whitespace at the end of the lines
def whiteSpaces_check(directory, exclude_files):
    for root, _, files in os.walk(directory):
        for file in files:
            if not file.endswith('.ico') and file not in exclude_files:
                file_path = os.path.join(root, file)
                try:
                    with open(file_path, 'r', encoding='utf-8') as file:
                        for line_number, line in enumerate(file, start=1):
                            if line.rstrip() != line:
                                print(f"Whitespace found in {file_path} at the end of the line:  {line_number}")
                except UnicodeDecodeError:
                    print(f"Could not decode file {file_path}")

# Codestyle patterns checking for ObjectGuid::GetCounter()
def getCounter_check(directory, exclude_files):
    for root, _, files in os.walk(directory):
        for file in files:
            if not file.endswith('.ico') and file not in exclude_files:
                file_path = os.path.join(root, file)
                try:
                    with open(file_path, 'r', encoding='utf-8') as file:
                        for line_number, line in enumerate(file, start=1):
                            if 'ObjectGuid::GetCounter()' in line:
                                print(f"ObjectGuid::GetCounter() found in {file_path} at line {line_number}")
                                print("Please use ObjectGuid::ToString().c_str() instead")
                except UnicodeDecodeError:
                    print(f"Could not decode file {file_path}")

# Calling checks
getTypeId_check(src_directory, ['Unit.h'])
whiteSpaces_check(src_directory, [])
getCounter_check(src_directory, [])
