INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1621105426491747047');

-- Remove id=1: Silvermane Stalker - On Reset - Cast Faded (6408) at 100% chance (No Repeat)
DELETE FROM `smart_scripts` WHERE `entryorguid`=2926 AND `id`=1;

-- The `creature_template` table does already have the updated (black) modelid (9562),
-- but the `creature` table (spawns) does not. Change modelid: 11418 --> 9562 
UPDATE `creature` SET `modelid`=9562 WHERE `id`=2926;
