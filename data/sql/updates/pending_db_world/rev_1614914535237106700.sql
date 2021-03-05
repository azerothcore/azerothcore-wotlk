INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1614914535237106700');

UPDATE `gameobject_template` SET `AIName` = 'SmartGameObjectAI' WHERE `entry` = 3737;

DELETE FROM `smart_scripts` WHERE (`source_type` = 1 AND `entryorguid` = 3737);
INSERT INTO `smart_scripts` VALUES
(3737, 1, 0, 0, 60, 0, 100, 0, 500, 500, 3500, 3500, 0, 75, 17775, 0, 0, 0, 0, 0, 18, 10, 0, 0, 0, 0, 0, 0, 0, 'Bubbling Fissure - On Update - Add Aura \'Air Bubbles\'');
