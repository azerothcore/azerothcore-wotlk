INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1596654830964670000');

INSERT INTO `smart_scripts` VALUES
	(2949, 0, 0, 0, 4, 0, 30, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Palemane Tanner - On Aggro - Say Line 0'),
	(2949, 0, 1, 0, 0, 0, 100, 0, 0, 0, 2400, 3800, 0, 11, 9739, 64, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Palemane Tanner - In Combat - Cast \'Wrath\''),
	(2949, 0, 2, 0, 2, 0, 100, 1, 0, 15, 0, 0, 0, 25, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Palemane Tanner - Between 0-15% Health - Flee For Assist'),
	(2950, 0, 0, 0, 4, 0, 30, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Palemane Skinner - On Aggro - Say Line 0'),
	(2950, 0, 1, 0, 2, 0, 100, 0, 16, 40, 20000, 30000, 0, 11, 774, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Palemane Skinner - Between 16-40% Health - Cast \'Rejuvenation\''),
	(2950, 0, 2, 0, 2, 0, 100, 1, 0, 15, 0, 0, 0, 25, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Palemane Skinner - Between 0-15% Health - Flee For Assist'),
	(2951, 0, 0, 0, 4, 0, 30, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Palemane Poacher - On Aggro - Say Line 0'),
	(2951, 0, 1, 0, 0, 0, 100, 0, 0, 0, 2300, 3900, 0, 11, 6660, 64, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Palemane Poacher - In Combat - Cast \'Shoot\''),
	(2951, 0, 2, 0, 0, 0, 100, 0, 0, 0, 7000, 13000, 0, 11, 1516, 1, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Palemane Poacher - In Combat - Cast \'Quick Shot\''),
	(2951, 0, 3, 0, 2, 0, 100, 1, 0, 15, 0, 0, 0, 25, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Palemane Poacher - Between 0-15% Health - Flee For Assist');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` IN (2949, 2950, 2951);
