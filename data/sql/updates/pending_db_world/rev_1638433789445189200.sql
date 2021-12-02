INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1638433789445189200');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 3284;
DELETE FROM `smart_scripts` WHERE (`entryorguid` = 3284) AND (`source_type` = 0);
