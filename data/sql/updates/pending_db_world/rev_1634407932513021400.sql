INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1634407932513021400');

UPDATE `creature_template` SET `AIName` = '', `ScriptName` = 'boss_baroness_anastari' WHERE `entry` = 10436;
DELETE FROM `smart_scripts` WHERE `entryorguid` = 10436 AND `source_type` = 0;
