INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1615207809116814300');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 3375;

DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = 3375);
INSERT INTO `smart_scripts` VALUES
(3375, 0, 0, 0, 0, 0, 100, 1, 100, 100, 1000, 1000, 0, 21, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Bael\'dun Foreman - In Combat - Enable Combat Movement (No Repeat)'),
(3375, 0, 1, 0, 0, 0, 100, 0, 1000, 2000, 3000, 4000, 0, 11, 6257, 64, 0, 0, 0, 0, 5, 0, 0, 0, 0, 0, 0, 0, 0, 'Bael\'dun Foreman - In Combat - Cast \'Torch Toss\'');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 5849;

DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = 5849);
INSERT INTO `smart_scripts` VALUES
(5849, 0, 0, 0, 0, 0, 80, 0, 12500, 12500, 10000, 10000, 0, 11, 6253, 64, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Digger Flameforge - In Combat - Cast \'Backhand\''),
(5849, 0, 1, 0, 0, 0, 100, 1, 100, 100, 1000, 1000, 0, 21, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Digger Flameforge - In Combat - Enable Combat Movement (No Repeat)'),
(5849, 0, 2, 0, 0, 0, 100, 0, 2000, 2000, 2000, 2000, 0, 11, 7978, 64, 0, 0, 0, 0, 5, 0, 0, 0, 0, 0, 0, 0, 0, 'Digger Flameforge - In Combat - Cast \'Throw Dynamite\'');
