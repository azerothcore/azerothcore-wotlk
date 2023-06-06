-- Fix GambeObjects 180772 - 180869 - 180874 (Cluster Launcher) --
UPDATE `gameobject_template` SET `AIName` = 'SmartGameObjectAI' WHERE `entry` = 180772;

DELETE FROM `smart_scripts` WHERE (`source_type` = 1 AND `entryorguid` = 180772);
INSERT INTO `smart_scripts` VALUES
(180772, 1, 0, 0, 8, 0, 100, 0, 26521, 0, 0, 0, 0, 11, 26522, 2, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Cluster Launcher - On Spellhit \'Lucky Lunar Rocket\' - Cast \'Lunar Fortune\'');


UPDATE `gameobject_template` SET `AIName` = 'SmartGameObjectAI' WHERE `entry` = 180869;

DELETE FROM `smart_scripts` WHERE (`source_type` = 1 AND `entryorguid` = 180869);
INSERT INTO `smart_scripts` VALUES
(180869, 1, 0, 0, 8, 0, 100, 0, 26521, 0, 0, 0, 0, 11, 26522, 2, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Cluster Launcher - On Spellhit \'Lucky Lunar Rocket\' - Cast \'Lunar Fortune\'');

UPDATE `gameobject_template` SET `AIName` = 'SmartGameObjectAI' WHERE `entry` = 180874;

DELETE FROM `smart_scripts` WHERE (`source_type` = 1 AND `entryorguid` = 180874);
INSERT INTO `smart_scripts` VALUES
(180874, 1, 0, 0, 8, 0, 100, 0, 26521, 0, 0, 0, 0, 11, 26522, 2, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Cluster Launcher - On Spellhit \'Lucky Lunar Rocket\' - Cast \'Lunar Fortune\'');
