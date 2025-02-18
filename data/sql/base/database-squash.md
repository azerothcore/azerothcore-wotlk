New process around handling database squashes since https://github.com/azerothcore/azerothcore-wotlk/pull/18197

> [!CAUTION]
> These steps are only for project maintainers who intend to update base files.

How to do the squash.

> [!IMPORTANT]
> A squash needs to be done on a clean database. Drop all tables in Auth, Characters and World.

1. Update the acore.json and DB version by running VersionUpdater.ps1 (Located in ..\apps\VersionUpdater\)

> [!NOTE]
> Read the versionupdater.md file to use it properly.

2. Drop all your databases, and run Worldserver to populate a clean database.
3. Export the databases using the DatabaseExporter.ps1 (Located in ..\apps\DatabaseExporter\)

> [!NOTE]
> Read the databaseexporter.md file to use it properly.

6. Make a PR

> [!IMPORTANT]
> No DB PRs should be merged during this process!

> [!NOTE]
> During the DB squash procedure, we do NOT move files.
> The archive dir is NO longer used as part of the DB squash procedure, 
> but simply as a place where to move update files when they get too many
> as the `updates` table in base files always will contain the entries from the updates dir they will never be run again on a clean setup.
