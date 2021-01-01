INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1609431870979648000');
UPDATE `gameobject_template` SET `Data2` = 0, `AIName` = 'SmartGameObjectAI' WHERE `entry` = 181964;
DELETE FROM `event_scripts` WHERE `id` = 11027;
DELETE FROM `smart_scripts` WHERE `entryorguid` IN (181964, 17715, 1771500) AND `source_type` IN (0, 1, 9);
INSERT INTO `smart_scripts` VALUES
	(181964, 1, 0, 0, 70, 0, 100, 0, 2, 0, 0, 0, 0, 12, 17715, 4, 300000, 0, 0, 0, 8, 0, 0, 0, 0, -1896.13, -12861.1, 87.1412, 3.5412, 'Statue of Queen Azshara - On Gameobject State Change - Summon Creature \'Atoph the Bloodcursed\''),
	(17715, 0, 0, 0, 63, 0, 100, 0, 0, 0, 0, 0, 0, 80, 1771500, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Atoph the Bloodcursed - Just Summoned - Run Script'),
	(1771500, 9, 0, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Atoph the Bloodcursed - On Script - Say Line 0'),
	(1771500, 9, 1, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 69, 0, 0, 0, 0, 0, 0, 8, 0, 0, 0, 0, -1936.44, -12878.4, 85.7825, 3.5632, 'Atoph the Bloodcursed - On Script - Move To Pos'),
	(1771500, 9, 2, 0, 0, 0, 100, 0, 2000, 2000, 0, 0, 0, 50, 181965, 10, 0, 0, 0, 0, 8, 0, 0, 0, 0, -1943.62, -12878.9, 88.3187, 3.8366, 'Atoph the Bloodcursed - On Script - Summon Gameobject \'Statue Fire\''),
	(1771500, 9, 3, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 50, 181965, 10, 0, 0, 0, 0, 8, 0, 0, 0, 0, -1945.27, -12881.7, 91.1005, 3.73761, 'Atoph the Bloodcursed - On Script - Summon Gameobject \'Statue Fire\''),
	(1771500, 9, 4, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 50, 181965, 10, 0, 0, 0, 0, 8, 0, 0, 0, 0, -1944.73, -12887.7, 88.1748, 2.81869, 'Atoph the Bloodcursed - On Script - Summon Gameobject \'Statue Fire\''),
	(1771500, 9, 5, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 50, 181965, 10, 0, 0, 0, 0, 8, 0, 0, 0, 0, -1951.88, -12881.8, 88.8753, 0.304646, 'Atoph the Bloodcursed - On Script - Summon Gameobject \'Statue Fire\''),
	(1771500, 9, 6, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 50, 181965, 10, 0, 0, 0, 0, 8, 0, 0, 0, 0, -1944.95, -12882.5, 99.2512, 4.0282, 'Atoph the Bloodcursed - On Script - Summon Gameobject \'Statue Fire\'');
DELETE FROM `creature_text` WHERE `CreatureID` = 17715;
INSERT INTO `creature_text` VALUES
	(17715, 0, 0, 'Who dares defile the statue of our beloved?', 14, 0, 100, 0, 0, 0, 14366, 0, 'Atoph the Bloodcursed');
