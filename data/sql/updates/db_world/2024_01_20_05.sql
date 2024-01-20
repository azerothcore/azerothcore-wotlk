--
UPDATE `version` SET `db_version`='ACDB 335.11-dev', `cache_id`=11 LIMIT 1;

-- 1. First we need to delete the existing archived updates
-- 2. We move the old archives from /sql/archive/ to the /sql/old/ directory
-- 3. We move the /sql/updates/ files into /sql/archive/ directory
-- 4. We update the current RELEASED updates to ARCHIVED as they change directory

-- DELETE FROM `updates` WHERE `state`='ARCHIVED'; -- In the future the old version archive should be moved in the squash commit. This time it was done here ea93531bd546867e25979e183dcf1ab25c388605
UPDATE `updates` SET `state`='ARCHIVED' WHERE `state`='RELEASED';
