--
UPDATE `version` SET `core_version` = 'AzerothCore rev. f60fb6307dc6 2024-01-20 14:30:18 +0000 (master branch) (Win64, RelWithDebInfo, Static)', `core_revision` = 'f60fb6307dc6', `db_version`='ACDB 335.11-dev', `cache_id`=11 LIMIT 1;

-- Remove all old updates as they are archived and stored in /sql/old/ dir.
UPDATE `updates` SET `state`='ARCHIVED' WHERE `state`='RELEASED';
DELETE FROM `updates` WHERE `state`='ARCHIVED';
