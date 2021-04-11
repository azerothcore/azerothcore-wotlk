INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1617772431626528000');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 3939;

DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = 3939);
INSERT INTO `smart_scripts` VALUES
(3939, 0, 0, 0, 0, 0, 100, 0, 3000, 7000, 6000, 9000, 0, 11, 17255, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Razormane Wolf - In Combat - Cast \'Bite\''),
(3939, 0, 1, 0, 0, 0, 100, 0, 5000, 10000, 22000, 25000, 0, 11, 24604, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Razormane Wolf - In Combat - Cast \'Furious Howl\''),
(3939, 0, 2, 0, 1, 0, 100, 0, 100, 100, 60000, 60000, 0, 8, 2, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Razormane Wolf - Out of Combat - Set Reactstate Aggressive'),
(3939, 0, 3, 4, 74, 0, 100, 0, 1, 99, 0, 0, 0, 49, 0, 0, 0, 0, 0, 0, 19, 3265, 5, 0, 0, 0, 0, 0, 0, 'Razormane Wolf - On Friendly Between 1-99% Health - Start Attacking'),
(3939, 0, 4, 0, 61, 0, 100, 0, 1, 99, 0, 0, 0, 49, 0, 0, 0, 0, 0, 0, 18, 33, 0, 0, 0, 0, 0, 0, 0, 'Razormane Wolf - On Friendly Between 1-99% Health - Start Attacking');
