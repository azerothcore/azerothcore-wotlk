INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1633884280859489900');

-- gandling
UPDATE `creature_template` SET `AIName` = '', `ScriptName` = 'boss_darkmaster_gandling' WHERE `entry` = 1853;

-- risen guardians
UPDATE `creature_template` SET `AIName` = '' WHERE `entry` = 11598;
DELETE FROM `smart_scripts` WHERE (`entryorguid` = 11598) AND (`source_type` = 0);

-- gates
DELETE FROM `smart_scripts` WHERE `entryorguid` IN (177371, 177372, 177373, 177375, 177376, 177377) AND (`source_type` = 1);
UPDATE `gameobject_template` SET `AIName` = '' WHERE `entry` IN (177371, 177372, 177373, 177375, 177376, 177377);
