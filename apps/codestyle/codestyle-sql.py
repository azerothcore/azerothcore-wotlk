import io
import os
import sys
import re
import glob

# Get the pending directory of the project
base_dir = os.getcwd()
pattern = os.path.join(base_dir, 'data/sql/updates/pending_db_*')
src_directory = glob.glob(pattern)

# Global variables
error_handler = False
results = {
    "Multiple blank lines check": "Passed",
    "Trailing whitespace check": "Passed",
    "SQL codestyle check": "Passed",
    "Missing semicolon check": "Passed"
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

# Main function to parse all the files of the project
def parsing_file(files: list) -> None:
    print("Starting AzerothCore SQL Codestyle check...")
    print(" ")
    print("Please read the SQL Standards for AzerothCore:")
    print("https://www.azerothcore.org/wiki/sql-standards")
    print(" ")

    # Iterate over all files
    for file_path in files:
        try:
            with open(file_path, 'r', encoding='utf-8') as file:
                multiple_blank_lines_check(file, file_path)
                trailing_whitespace_check(file, file_path)
                sql_check(file, file_path)
                semicolon_check(file, file_path)
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
def trailing_whitespace_check(file: io, file_path: str) -> None:
    global error_handler, results
    file.seek(0)  # Reset file pointer to the beginning
    check_failed = False
    # Parse all the file
    for line_number, line in enumerate(file, start = 1):
        if line.endswith(' \n'):
            print(f"Trailing whitespace found: {file_path} at line {line_number}")
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
                f"DON'T EDIT broadcast_text TABLE UNLESS YOU KNOW WHAT YOU ARE DOING!\nThis error can safely be ignored if the changes are approved to be sniffed: {file_path} at line {line_number}")
            check_failed = True
        if [match for match in [';;'] if match in line]:
            print(
                f"Double semicolon (;;) found in {file_path} at line {line_number}")
            check_failed = True
        if re.match(r"\t", line):
            print(
                f"Tab found! Replace it to 4 spaces: {file_path} at line {line_number}")
            check_failed = True

        last_line = line[-1].strip()
        if last_line:
            print(
                f"The last line is not a newline. Please add a newline: {file_path}")
            check_failed = True

    # Handle the script error and update the result output
    if check_failed:
        error_handler = True
        results["SQL codestyle check"] = "Failed"

def semicolon_check(file: io, file_path: str) -> None:
    global error_handler, results
    file.seek(0)  # Reset file pointer to the beginning
    check_failed = False
    sql_keywords = ["SELECT", "INSERT", "UPDATE", "DELETE"]
    query_open = False

    lines = file.readlines()
    total_lines = len(lines)

    for line_number, line in enumerate(lines, start=1):
        stripped_line = line.rstrip()  # Remove trailing whitespace including newline

        # Check if one keyword is in the line
        if not query_open and any(keyword in stripped_line for keyword in sql_keywords):
            query_open = True

        if query_open:
            if stripped_line == '':
                print(f"Missing semicolon in {file_path} at line {line_number - 1}")
                check_failed = True
                query_open = False
            elif line_number == total_lines:
                if not stripped_line.endswith(';'):
                    print(f"Missing semicolon in {file_path} at the last line {line_number}")
                    check_failed = True
                    query_open = False
            elif stripped_line.endswith(';'):
                query_open = False

    if check_failed:
        error_handler = True
        results["Missing semicolon check"] = "Failed"

# Collect all files from matching directories
all_files = collect_files_from_directories(src_directory)

# Main function
parsing_file(all_files)
