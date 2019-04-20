INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1554842995091120500');

UPDATE `creature_template` SET `ScriptName`='chromatic_elite_guard', `AIName`='' WHERE  `entry`= 10814;
DELETE FROM `smart_scripts` WHERE  `entryorguid`= 10814;
