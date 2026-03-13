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
    previous_line = ""

    # Parse all the file
    for line_number, line in enumerate(file, start = 1):
        if line.strip().startswith("--"):
            continue
        if "INSERT" in line and "DELETE" not in previous_line:
            print(f"❌ No DELETE keyword found before the INSERT in {file_path} at line {line_number}\nIf this error is intended, please notify a maintainer")
            check_failed = True
        previous_line = line
        match = re.match(r"DELETE FROM\s+`([^`]+)`", line, re.IGNORECASE)
        if match:
            table_name = match.group(1)
            if table_name in not_delete:
                print(
                    f"❌ Entries from {table_name} should not be deleted! {file_path} at line {line_number}\nIf this error is intended, please notify a maintainer")
                check_failed = True

    # Handle the script error and update the result output
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

        # Skip empty lines (unless inside values block)
        if not stripped_line and not inside_values_block:
            continue

        # Remove inline comments after SQL
        stripped_line = stripped_line.split('--', 1)[0].strip()

        if stripped_line.upper().startswith("SET") and not stripped_line.endswith(";"):
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
        if line.strip().startswith('--'):
            continue

        # Sanitize single- and doublequotes to prevent false positives
        sanitized_line = quote_pattern.sub('', line)
        # Strip inline comments (safe to do after removing quoted strings)
        sanitized_line = re.sub(r'--.*$', '', sanitized_line)
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

# Collect all files from matching directories
all_files = collect_files_from_directories(src_directory) + collect_files_from_directories(base_directory) + collect_files_from_directories(archive_directory)

# Main function
parsing_file(all_files)
