INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1598238244990167657');

UPDATE `creature_template` SET `faction` = 21 WHERE `entry` = 14688;
DELETE FROM `smart_scripts` WHERE `entryorguid` = 14688;
INSERT INTO `smart_scripts` VALUES
	(14688, 0, 0, 0, 0, 0, 80, 0, 0, 0, 10000, 20000, 0, 11, 61162, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Prince Sandoval - In Combat - Cast \'Engulfing Strike\''),
	(14688, 0, 1, 0, 0, 0, 80, 0, 15000, 20000, 30000, 30000, 0, 11, 61163, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Prince Sandoval - In Combat - Cast \'Fire Nova\''),
	(14688, 0, 2, 0, 0, 0, 100, 0, 30000, 30000, 30000, 30000, 0, 11, 61144, 1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Prince Sandoval - In Combat - Cast \'Fire Shield\''),
	(14688, 0, 3, 4, 0, 0, 100, 0, 31100, 31100, 30000, 30000, 0, 11, 61145, 1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Prince Sandoval - In Combat - Cast \'Ember Shower\''),
	(14688, 0, 4, 5, 61, 0, 100, 1, 0, 0, 0, 0, 0, 21, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Prince Sandoval - In Combat - Disable Combat Movement'),
	(14688, 0, 5, 6, 61, 0, 100, 0, 0, 0, 0, 0, 0, 18, 131077, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Prince Sandoval - In Combat - Set Flags Server Controlled & Disable Movement & Pacified'),
	(14688, 0, 6, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 103, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Prince Sandoval - In Combat - Set Rooted On'),
	(14688, 0, 7, 8, 0, 0, 100, 0, 45100, 45100, 30000, 30000, 0, 19, 131077, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Prince Sandoval - In Combat - Remove Flags Server Controlled & Disable Movement & Pacified'),
	(14688, 0, 8, 9, 61, 0, 100, 0, 0, 0, 0, 0, 0, 21, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Prince Sandoval - In Combat - Enable Combat Movement'),
	(14688, 0, 9, 10, 61, 0, 100, 0, 0, 0, 0, 0, 0, 28, 61144, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Prince Sandoval - In Combat - Remove Aura \'Fire Shield\''),
	(14688, 0, 10, 11, 61, 0, 100, 0, 0, 0, 0, 0, 0, 28, 61145, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Prince Sandoval - In Combat - Remove Aura \'Ember Shower\''),
	(14688, 0, 11, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 103, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Prince Sandoval - In Combat - Set Rooted Off'),
	(14688, 0, 12, 0, 54, 0, 100, 1, 0, 0, 0, 0, 0, 80, 1468800, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Prince Sandoval - On Just Summoned - Run Script'),
	(14688, 0, 13, 0, 54, 0, 100, 1, 0, 0, 0, 0, 0, 11, 4335, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Prince Sandoval - On Just Summoned - Cast \'Spawn Smoke (scale x2.00)\''),
	(14688, 0, 14, 0, 54, 0, 100, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Prince Sandoval - On Just Summoned - Say Line 0'),
	(14688, 0, 15, 0, 1, 0, 100, 1, 14000, 14000, 0, 0, 0, 49, 0, 0, 0, 0, 0, 0, 21, 100, 0, 0, 0, 0, 0, 0, 0, 'Prince Sandoval - Out of Combat - Start Attacking'),
	(14688, 0, 16, 0, 5, 0, 100, 1, 0, 0, 0, 0, 0, 45, 20, 20, 0, 0, 0, 0, 11, 31135, 100, 0, 0, 0, 0, 0, 0, 'Prince Sandoval - On Killed Unit - Set Data 20 20'),
	(14688, 0, 17, 0, 6, 0, 100, 1, 0, 0, 1, 0, 0, 45, 6, 6, 0, 0, 0, 0, 11, 31135, 100, 0, 0, 0, 0, 0, 0, 'Prince Sandoval - On Just Died - Set Data 6 6'),
	(14688, 0, 18, 0, 1, 0, 100, 1, 30000, 30000, 0, 0, 0, 45, 19, 19, 0, 0, 0, 0, 11, 31135, 100, 0, 0, 0, 0, 0, 0, 'Prince Sandoval - Out of Combat - Set Data 19 19'),
	(14688, 0, 19, 20, 1, 0, 100, 1, 0, 0, 0, 0, 0, 19, 131077, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Prince Sandoval - Out of Combat - Remove Flags Server Controlled & Disable Movement & Pacified'),
	(14688, 0, 20, 21, 61, 0, 100, 0, 0, 0, 0, 0, 0, 28, 61144, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Prince Sandoval - Out of Combat - Remove Aura \'Fire Shield\''),
	(14688, 0, 21, 22, 61, 0, 100, 0, 0, 0, 0, 0, 0, 28, 61145, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Prince Sandoval - Out of Combat - Remove Aura \'Ember Shower\''),
	(14688, 0, 22, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 103, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Prince Sandoval - Out of Combat - Set Rooted Off');
