INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1615210246361880600');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 7235;

DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = 7235);
INSERT INTO `smart_scripts` VALUES
(7235, 0, 0, 0, 0, 0, 100, 0, 2000, 2000, 5000, 5000, 0, 11, 5177, 64, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Gnarlpine Mystic - In Combat - Cast \'Wrath\'');
