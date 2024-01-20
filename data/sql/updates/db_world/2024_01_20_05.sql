--
UPDATE `version` SET `db_version`='ACDB 335.11-dev', `cache_id`=11 LIMIT 1;

-- Remove all old updates as they are archived and stored in /sql/old/ dir.
UPDATE `updates` SET `state`='ARCHIVED' WHERE `state`='RELEASED';
DELETE FROM `updates` WHERE `state`='ARCHIVED';
