INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1636434085380352700');

UPDATE `creature_template` SET `ScriptName` = 'boss_quartermaster_zigris', `AIName` = '' WHERE `entry` = 9736;
DELETE FROM `smart_scripts` WHERE `source_type` = 0 AND `entryorguid` = 9736;
