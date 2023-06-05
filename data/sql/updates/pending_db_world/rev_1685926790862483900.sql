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


-- Fix Spell Range - Item Lucky Rocket Cluster 21744 - Spell Triggered 26522 from the Spell Trigger 26521 --
DELETE FROM `spell_dbc` WHERE (`ID` = 26522);
INSERT INTO `spell_dbc` VALUES
(26522, 0, 0, 0, 256, 0, 0, 256, 0, 2097152, 0, 0, 0, 0, 0, 0, 64, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 101, 0, 0, 0, 0, 30, 0, 0, 0, 0, 0, 5, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 0, 0, 6, 0, 0, 1, 0, 0, 0, 0, 0, 249, 0, 0, 0, 0, 0, 22, 0, 0, 8, 0, 0, 9, 0, 0, 34, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 7458, 0, 1828, 0, 0, 'Lunar Fortune', '', '', '', '', '', '', '', '', '0', '0', '0', '0', '0', '0', '0', 16712190, '', '', '', '', '', '', '', '', '', '0', '0', '0', '0', '0', '0', '0', 16712190, 'The Luck of the Moon!  +$s1 Health.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '0', '0', '0', '0', '0', '0', '0', 16712190, 'The Luck of the Moon!  +$s1 Health.', '', '', '', '', '', '', '', '', '0', '0', '0', '0', '0', '0', '0', 16712190, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 1, 1, 1, 0, 0);
