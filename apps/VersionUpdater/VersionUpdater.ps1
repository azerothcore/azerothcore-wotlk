# Get the directory to acore.json
$scriptDirectory = $PSScriptRoot
$relativePath = "..\.."
$combinedPath = Join-Path -Path $scriptDirectory -ChildPath $relativePath
$fullPath = Resolve-Path -Path $combinedPath
$jsonFilePath = "$fullPath\acore.json"
# Get the directory for SQL update
$relativePathDbWorldUpdate = "..\..\data\sql\updates\db_world"
$combinedPathDbWorldUpdate = Join-Path -Path $scriptDirectory -ChildPath $relativePathDbWorldUpdate
$fullPathDbWorldUpdate = Resolve-Path -Path $combinedPathDbWorldUpdate

Write-Host " ___                     _    _      ___                "
Write-Host "/   \ ___ ___  _ _  ___ | |_ | |_   / __| ___  _ _  ___ "
Write-Host "| - ||_ // -_)| '_|/ _ \|  _||   \ | (__ / _ \| '_|/ -_)"
Write-Host "|_|_|/__|\___||_|  \___/ \__||_||_| \___|\___/|_|  \___|"
Write-Host "AzerothCore 3.3.5a  -  www.azerothcore.org"
Write-Host ""
Write-Host "Welcome to the AzerothCore Version Updater for database squashes!"
Write-Host ""
Write-Host "You have configured:"
Write-Host "acore.json Path: '$jsonFilePath'"
Write-Host "World SQL Updates path: '$fullPathDbWorldUpdate'"
Write-Host ""
Write-Host "Make sure you read the entire process before you continue."
Write-Host "https://github.com/azerothcore/azerothcore-wotlk/blob/master/data/sql/base/database-squash.md"
Write-Host "https://github.com/azerothcore/azerothcore-wotlk/blob/master/apps/VersionUpdater/versionupdater.md"
Write-Host ""

# Check if the user wants to continue using the tool
do {
    $confirmation = Read-Host "Do you want to continue using the tool? (Y/N)"
    
    if ($confirmation -eq 'Y' -or $confirmation -eq 'y') {
        # Continue the script
        Write-Host "AzerothCore Version Updater starts."
        Write-Host ""
        $continue = $true
    }
    elseif ($confirmation -eq 'N' -or $confirmation -eq 'n') {
        # Exit the script
        Write-Host "Exiting the AzerothCore Version Updater."
        exit
    }
    else {
        Write-Host "Invalid input. Please enter Y or N."
        $continue = $null
    }
} while ($continue -eq $null)

# Read the JSON file and convert it to a PowerShell object
$jsonContent = Get-Content -Path $jsonFilePath | ConvertFrom-Json

# Get the current version
$currentVersion = $jsonContent.version

# Match version components (major.minor.patch and optional suffix like -dev or -alpha)
if ($currentVersion -match '(\d+)\.(\d+)\.(\d+)(-.*)?') {
    $major = $matches[1]
    $minor = $matches[2]
    $patch = $matches[3]
    $suffix = $matches[4]

    # Increment the major version
    $major = [int]$major + 1

    # Reset minor and patch version to 0 (if incrementing major)
    $minor = 0
    $patch = 0

    # Reassemble the version with the suffix if it exists
    $newVersion = "$major.$minor.$patch$suffix"
    
    # Update the version in the JSON object
    $jsonContent.version = $newVersion
} else {
    Write-Host "Unknown error in $jsonFilePath. Exiting."
    exit
}

# Convert the updated object back to JSON format
$newJsonContent = $jsonContent | ConvertTo-Json -Depth 3

# Write the updated content back to the file
$newJsonContent | Set-Content -Path $jsonFilePath

Write-Host "acore.json version updated to $newVersion"

# Create the SQL Version update file.
# Get today's date in the format YYYY_MM_DD
$today = Get-Date -Format "yyyy_MM_dd"

# Get the list of files in the directory that match the pattern "YYYY_MM_DD_versionNumber.sql"
$existingFiles = Get-ChildItem -Path $fullPathDbWorldUpdate -Filter "$today*_*.sql"

# If no files exist for today, start with version number 00
if ($existingFiles.Count -eq 0) {
    [int]$newVersionNumber = 0
} else {
    # Extract the version number from the existing files (e.g., YYYY_MM_DD_versionNumber.sql)
    $maxVersionNumber = $existingFiles | ForEach-Object {
        if ($_ -match "$today_(\d{2})\.sql") {
            [int]$matches[1]
        }
    } | Measure-Object -Maximum | Select-Object -ExpandProperty Maximum

    # Increment the version number by 1
    [int]$newVersionNumber = $maxVersionNumber + 1
}

# Format the new version number as a two-digit number (e.g., 01, 02, etc.)
$formattedVersionNumber = $newVersionNumber.ToString("D2")

# Define the new filename using the date and incremented version number
$newFileName = "$today" + "_$formattedVersionNumber.sql"
$newFilePath = Join-Path -Path $fullPathDbWorldUpdate -ChildPath $newFileName

# Define the SQL content to write to the file
$tableName = '`version`'
$db_version = '`db_version`'
$db_version_content = "'ACDB 335.$major-dev'"
$cache_id = '`cache_id`'
$sqlContent = "UPDATE $tableName SET $db_version=$db_version_content, $cache_id=$major LIMIT 1;"

# Write the content to the new SQL file
$sqlContent | Set-Content -Path $newFilePath

Write-Host "SQL file created: $newFilePath"
Write-Host "SQL content: $sqlContent"

Write-Host ""
Write-Host "Version Updater completed."
Write-Host "Have a nice day :)"
