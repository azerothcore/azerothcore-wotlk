New routines around handling database squashes since https://github.com/azerothcore/azerothcore-wotlk/pull/18197

> [!CAUTION]
> These steps are only for project maintainers who intend to update base files.

We ONLY squash into BASE files. We never move files.
ARCHIVE dir is UNUSED.
All update files ALWAYS exist in the updates dir.

as the `updates` table in base files always will contain the entries from the updates dir they will never be run again on a clean setup. 

How to do the squash.

> [!IMPORTANT]
> A squash needs to be done on a clean database. Drop all tables in Auth, Characters and World.

1. Update the acore.json file. Increment version by one
2. Create a new file in the updates/db_world/ dir, the file should be incremented containing

> [!NOTE]
> It should NOT be placed as a pending update and should only be done on world db. This is because we want the updated DB version to follow into the base files

```sql
UPDATE `version` SET `db_version`='ACDB 335.11-dev', `cache_id`=11 LIMIT 1;
```
> [!NOTE]
> Remember to increment the db_version and cache_id the same as acore.json

4. Drop all your databases, and run Worldserver to populate a clean database.
5. Export the databases using i.e HeidiSQL

> [!IMPORTANT]
> Set the following values
> Tables -> DROP + CREATE
> Data -> Delete + insert (truncate existing data)
> Max INSERT size -> 1024
> This is so that no unexpected issues occur.

6. Move the exported table files into the base directory to update the existing files.
7. Make a PR
