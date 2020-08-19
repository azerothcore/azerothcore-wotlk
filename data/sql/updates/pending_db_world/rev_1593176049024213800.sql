INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1593176049024213800');

DELETE FROM `smart_scripts` WHERE `entryorguid` IN (18341, 1834100, 1834101);
UPDATE `creature_template` SET `AIName` = '', `ScriptName` = 'boss_pandemonius' WHERE `entry` = 18341;
