# The AzerothCore Version Updater for Database Squashes

> [!CAUTION]
> These steps are only for project maintainers who intend to update base files.

## Description of the tool

This tool updates the version in DB and acore.json automatically. Hence, it must run from this directory.

This is how it works step-by-step:

1. Check that all paths look correct.
2. Accept to continue using the tool.
3. The tool will update the acore.json file and increment it by 1.
4. The tool will create a file with the proper UPDATE for world database in `..\..\data\sql\updates\db_world`.

## Run the tool

> [!IMPORTANT]
> This tool CAN NOT be moved outside this directory. If you do it will create files in the wrong places.

1. If you haven't run PowerShell scripts before, you'll need to adjust the execution policy.

    - Open PowerShell as an Administrator.
    - Run the following command to allow running scripts:
    ```ps
    Set-ExecutionPolicy RemoteSigned -Scope CurrentUser
    ```
    - This allows scripts to run on your system, but they need to be locally created or downloaded from trusted sources.

2. Open PowerShell (PS)

    - Press Win + X and select Windows PowerShell (Admin) / Terminal (Admin)

3. Navigate to the script

    - In PS, use the `cd` command to change the directory
    ```ps
    cd "C:\AzerothCore\apps\VersionUpdater"
    ```

4. Run the script

    - In PS, run the script
    ```ps
    .\VersionUpdater.ps1
    ```

5. Follow the instructions given by the tool.

6. Now refer back to the database-squash.md instructions. (Located in ..\..\data\sql\base\)

Completed :)
