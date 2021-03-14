INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1615647120285678400');

UPDATE `gameobject_template` SET `AIName` = 'SmartGameObjectAI' WHERE `entry` = 177524;

DELETE FROM `smart_scripts` WHERE (`source_type` = 1 AND `entryorguid` = 177524);
INSERT INTO `smart_scripts` VALUES
(177524, 1, 0, 0, 60, 0, 100, 0, 500, 500, 3500, 3500, 0, 75, 17775, 0, 0, 0, 0, 0, 18, 10, 0, 0, 0, 0, 0, 0, 0, 'Bubbling Fissure - On Update - Add Aura \'Air Bubbles\'');
