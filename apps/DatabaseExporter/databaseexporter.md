# The AzerothCore Database Exporter for Database Squashes

> [!CAUTION]
> These steps are only for project maintainers who intend to update base files.

## Manual setting updates

Update the settings in `DatabaseExporter.ps1` to reflect your setup by opening it with your preffered text editor.

> [!NOTE]
> Only update the settings within the SETTINGS block.

These are the default settings:
```ps
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
```

## Description of the tool

This tool updates the base files automatically. Hence, it must run from this directory.

This is how it works step-by-step:

1. Check that all paths look correct.
2. Accept to continue using the tool.
3. The tool will delete the `db_auth` `db_characters` `db_world` directories in `..\..\data\sql\base\`
4. The tool will create the `db_auth` `db_characters` `db_world` directories in `..\..\data\sql\base\`
5. The tool will export the `db_auth` table into `..\..\data\sql\base\db_auth\`
6. The tool will export the `db_characters` table into `..\..\data\sql\base\db_characters\`
7. The tool will export the `db_world` table into `..\..\data\sql\base\db_world\`

## Run the tool

> [!IMPORTANT]
> This tool CAN NOT be moved outside this directory. If you do it will create files in the wrong places.

1. Make sure you have MySQL installed on your system and that the mysqldump tool is accessible by your PATH system variable. If it is not set you will encounter errors.

    - Go into System Variables
    - Open the PATH variable
    - Add the path to your $\MySQL Server\bin\ - e.g. C:\Program Files\MySQL\MySQL Server 8.4\bin\

2. If you haven't run PowerShell scripts before, you'll need to adjust the execution policy.

    - Open PowerShell as an Administrator.
    - Run the following command to allow running scripts:
    ```ps
    Set-ExecutionPolicy RemoteSigned -Scope CurrentUser
    ```
    - This allows scripts to run on your system, but they need to be locally created or downloaded from trusted sources.

3. Open PowerShell (PS)

    - Press Win + X and select Windows PowerShell (Admin) / Terminal (Admin)

4. Navigate to the script

    - In PS, use the `cd` command to change the directory
    ```ps
    cd "C:\AzerothCore\apps\DatabaseExporter"
    ```

5. Run the script

    - In PS, run the script
    ```ps
    .\DatabaseExporter.ps1
    ```

6. Follow the instructions given by the tool.

7. Now refer back to the database-squash.md instructions. (Located in ..\..\data\sql\base\)

Completed :)
