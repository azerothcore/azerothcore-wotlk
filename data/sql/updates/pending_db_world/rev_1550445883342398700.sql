INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1550445883342398700');

DELETE FROM `smart_scripts` WHERE `entryorguid` IN (33701,3370100);
UPDATE `creature_template` SET `AIName` = '' WHERE `entry` = 33701;
