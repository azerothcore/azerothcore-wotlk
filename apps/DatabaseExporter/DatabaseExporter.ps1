########################################################################################
# SETTINGS                                                                             #
########################################################################################
$mysql_host = "127.0.0.1"
$mysql_user = "export"
$mysql_password = "export"
$mysql_database_auth = "acore_auth"
$mysql_database_characters = "acore_characters"
$mysql_database_world = "acore_world"
########################################################################################
# SETTINGS END                                                                         #
########################################################################################

# Set MySQL password as temporary env var
$env:MYSQL_PWD = $mysql_password

# Get the directory to sql\base directory
$scriptDirectory = $PSScriptRoot
$relativePath = "..\..\data\sql\base"
$combinedPath = Join-Path -Path $scriptDirectory -ChildPath $relativePath
$fullPath = Resolve-Path -Path $combinedPath

# Define the output directory (using database name)
$output_directory_auth = "$fullPath\db_auth"
$output_directory_characters = "$fullPath\db_characters"
$output_directory_world = "$fullPath\db_world"

Write-Host " ___                     _    _      ___                "
Write-Host "/   \ ___ ___  _ _  ___ | |_ | |_   / __| ___  _ _  ___ "
Write-Host "| - ||_ // -_)| '_|/ _ \|  _||   \ | (__ / _ \| '_|/ -_)"
Write-Host "|_|_|/__|\___||_|  \___/ \__||_||_| \___|\___/|_|  \___|"
Write-Host "AzerothCore 3.3.5a  -  www.azerothcore.org"
Write-Host ""
Write-Host "Welcome to the AzerothCore Database Exporter for database squashes!"
Write-Host ""
Write-Host "You have configured:"
Write-Host "Database Auth: '$mysql_database_auth'"
Write-Host "Database Characters: '$mysql_database_characters'"
Write-Host "Database World: '$mysql_database_world'"
Write-Host "Output Dir Auth: '$output_directory_auth'"
Write-Host "Output Dir Characters: '$output_directory_characters'"
Write-Host "Output Dir World: '$output_directory_world'"
Write-Host ""
Write-Host "Make sure you read the entire process before you continue."
Write-Host "https://github.com/azerothcore/azerothcore-wotlk/blob/master/data/sql/base/database-squash.md"
Write-Host "https://github.com/azerothcore/azerothcore-wotlk/blob/master/apps/DatabaseExporter/databaseexporter.md"
Write-Host ""

# Check if the user wants to continue using the tool
do {
    $confirmation = Read-Host "Do you want to continue using the tool? (Y/N)"
    
    if ($confirmation -eq 'Y' -or $confirmation -eq 'y') {
        # Continue the script
        Write-Host "AzerothCore Database Exporter starts."
        $continue = $true
    }
    elseif ($confirmation -eq 'N' -or $confirmation -eq 'n') {
        # Exit the script
        Write-Host "Exiting the AzerothCore Database Exporter."
        exit
    }
    else {
        Write-Host "Invalid input. Please enter Y or N."
        $continue = $null
    }
} while ($continue -eq $null)

# Remove the output directory if it exist
if (Test-Path $output_directory_auth) {
    Remove-Item -Path $output_directory_auth -Recurse -Force
    Write-Host "Deleted directory $output_directory_auth"
}
if (Test-Path $output_directory_characters) {
    Remove-Item -Path $output_directory_characters -Recurse -Force
    Write-Host "Deleted directory $output_directory_characters"
}
if (Test-Path $output_directory_world) {
    Remove-Item -Path $output_directory_world -Recurse -Force
    Write-Host "Deleted directory $output_directory_world"
}

# Create the output directory if it doesn't exist
if (-not (Test-Path -Path $output_directory_auth)) {
    New-Item -ItemType Directory -Force -Path $output_directory_auth
    Write-Host "Created directory $output_directory_auth"
}
if (-not (Test-Path -Path $output_directory_characters)) {
    New-Item -ItemType Directory -Force -Path $output_directory_characters
    Write-Host "Created directory $output_directory_characters"
}
if (-not (Test-Path -Path $output_directory_world)) {
    New-Item -ItemType Directory -Force -Path $output_directory_world
    Write-Host "Created directory $output_directory_world"
}

# Fix for dumping TIMESTAMP data
$timezone = "+01:00"
$mysqlCommand = "SET time_zone = '$timezone';"
$mysqlExec = "mysql -h $mysql_host -u $mysql_user -p$mysql_password -e `"$mysqlCommand`""
Invoke-Expression -Command $mysqlExec

# PS script uses non-utf-8 encoding by default
# https://stackoverflow.com/a/58438716
# Save the current encoding and switch to UTF-8.
$prev = [Console]::OutputEncoding
[Console]::OutputEncoding = [System.Text.UTF8Encoding]::new()

Write-Host ""
Write-Host "#########################################################"
Write-Host "EXPORT AUTH DATABASE START"
Write-Host "#########################################################"
Write-Host ""
Write-Host "Please enter your password for user '$mysql_user'"

# Export Auth Database
# Connect to MySQL and get all the tables
$tables_auth = mysql -h $mysql_host -u $mysql_user -D $mysql_database_auth -e "SHOW TABLES;" | Select-Object -Skip 1
# Iterate through each table and export both the structure and contents into the same SQL file
foreach ($table in $tables_auth) {
    # Define the output file path for this table
    $output_file = "$output_directory_auth\$table.sql"

    # Clear the content of the output file if it exists, or create a new one
    if (Test-Path $output_file) {
        Clear-Content -Path $output_file
    }

    # Export the table structure (CREATE TABLE) and table data (INSERT) to the SQL file
    $create_table_command = "mysqldump -h $mysql_host -u $mysql_user --skip-tz-utc $mysql_database_auth $table"
    $create_table_output = Invoke-Expression -Command $create_table_command
    # write file with utf-8 encoding
    # https://stackoverflow.com/a/32951824
    [IO.File]::WriteAllLines($output_file, $create_table_output)

    # Format the INSERT values to be on seperate lines.
    $content = Get-Content -Raw $output_file
    $formattedContent = $content -replace 'VALUES \(', "VALUES`r`n("
    $formattedContent = $formattedContent -replace '\),', "),`r`n"
    $formattedContent | Set-Content $output_file

    Write-Host "Exported structure and data for table $table to $output_file"
}

Write-Host ""
Write-Host "#########################################################"
Write-Host "EXPORT AUTH DATABASE END"
Write-Host "#########################################################"
Write-Host ""
Write-Host "#########################################################"
Write-Host "EXPORT CHARACTERS DATABASE START"
Write-Host "#########################################################"
Write-Host ""
Write-Host "Please enter your password for user '$mysql_user'"

# Export Characters Database
# Connect to MySQL and get all the tables
$tables_characters = mysql -h $mysql_host -u $mysql_user -D $mysql_database_characters -e "SHOW TABLES;" | Select-Object -Skip 1
# Iterate through each table and export both the structure and contents into the same SQL file
foreach ($table in $tables_characters) {
    # Define the output file path for this table
    $output_file = "$output_directory_characters\$table.sql"

    # Clear the content of the output file if it exists, or create a new one
    if (Test-Path $output_file) {
        Clear-Content -Path $output_file
    }

    # Export the table structure (CREATE TABLE) and table data (INSERT) to the SQL file
    $create_table_command = "mysqldump -h $mysql_host -u $mysql_user --skip-tz-utc $mysql_database_characters $table"
    $create_table_output = Invoke-Expression -Command $create_table_command
    # write file with utf-8 encoding
    # https://stackoverflow.com/a/32951824
    [IO.File]::WriteAllLines($output_file, $create_table_output)

    # Format the INSERT values to be on seperate lines.
    $content = Get-Content -Raw $output_file
    $formattedContent = $content -replace 'VALUES \(', "VALUES`r`n("
    $formattedContent = $formattedContent -replace '\),', "),`r`n"
    $formattedContent | Set-Content $output_file

    Write-Host "Exported structure and data for table $table to $output_file"
}

Write-Host ""
Write-Host "#########################################################"
Write-Host "EXPORT CHARACTERS DATABASE END"
Write-Host "#########################################################"
Write-Host ""
Write-Host "#########################################################"
Write-Host "EXPORT WORLD DATABASE START"
Write-Host "#########################################################"
Write-Host ""
Write-Host "Please enter your password for user '$mysql_user'"

# Export World Database
# Connect to MySQL and get all the tables
$tables_world = mysql -h $mysql_host -u $mysql_user -D $mysql_database_world -e "SHOW TABLES;" | Select-Object -Skip 1
# Iterate through each table and export both the structure and contents into the same SQL file
foreach ($table in $tables_world) {
    # Define the output file path for this table
    $output_file = "$output_directory_world\$table.sql"

    # Clear the content of the output file if it exists, or create a new one
    if (Test-Path $output_file) {
        Clear-Content -Path $output_file
    }

    # Export the table structure (CREATE TABLE) and table data (INSERT) to the SQL file
    $create_table_command = "mysqldump -h $mysql_host -u $mysql_user --skip-tz-utc $mysql_database_world $table"
    $create_table_output = Invoke-Expression -Command $create_table_command
    # write file with utf-8 encoding
    # https://stackoverflow.com/a/32951824
    [IO.File]::WriteAllLines($output_file, $create_table_output)

    # Format the INSERT values to be on seperate lines.
    $content = Get-Content -Raw $output_file
    $formattedContent = $content -replace 'VALUES \(', "VALUES`r`n("
    $formattedContent = $formattedContent -replace '\),', "),`r`n"
    $formattedContent | Set-Content $output_file

    Write-Host "Exported structure and data for table $table to $output_file"
}

Write-Host ""
Write-Host "#########################################################"
Write-Host "EXPORT WORLD DATABASE END"
Write-Host "#########################################################"
Write-Host ""
Write-Host "Database Exporter completed."
Write-Host "Have a nice day :)"

# Restore the previous encoding.
[Console]::OutputEncoding = $prev
