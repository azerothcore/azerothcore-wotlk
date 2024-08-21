import os

# Get the src directory of the project
src_directory = os.path.join(os.path.abspath(os.path.dirname(__file__)), 'src')

# Need to exclude .ico files from the search
exclude_extensions = ['.ico']

# Parse files in the src directory
def parse_files_in_src_directory(directory, exclude_extensions, exclude_files, patterns):
    for root, _, files in os.walk(directory):
        for file in files:
            if not any(file.endswith(ext) for ext in exclude_extensions) and file not in exclude_files:
                file_path = os.path.join(root, file)
                # List all patterns functions below
                check_patterns_in_file(file_path, patterns)

# Codestyle patterns checking
def check_patterns_in_file(file_path, patterns):
    try:
        with open(file_path, 'r', encoding='utf-8') as file:
            for line_number, line in enumerate(file, start=1):
                for pattern in patterns:
                    if pattern in line:
                        print(f"Pattern '{pattern}' found in {file_path} at line {line_number}")
                        break
    except UnicodeDecodeError:
        print(f"Could not decode file {file_path}")

# Define specific files to exclude if you necessary
exclude_files = ['npc_stave_of_ancients.cpp', 'npcs_special.cpp']

# Define patterns to check
patterns = ['GetTypeId()', 'IsPlayer()']

parse_files_in_src_directory(src_directory, exclude_extensions, exclude_files, patterns)
