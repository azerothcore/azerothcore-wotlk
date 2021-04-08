INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1617867794413109600');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE (`entry` IN (2951, 3382));

DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = 2951);
INSERT INTO `smart_scripts` VALUES
(2951, 0, 0, 0, 4, 0, 100, 0, 0, 0, 0, 0, 0, 11, 1516, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Palemane Poacher - On Aggro - Cast \'Quick Shot\''),
(2951, 0, 1, 0, 0, 0, 100, 0, 1500, 1500, 3500, 3500, 0, 11, 6660, 64, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Palemane Poacher - In Combat - Cast \'Shoot\'');

DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = 3382);
INSERT INTO `smart_scripts` VALUES
(3382, 0, 0, 0, 0, 0, 100, 0, 100, 100, 3500, 3500, 0, 11, 6660, 64, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Southsea Cannoneer - In Combat - Cast \'Shoot\'');
