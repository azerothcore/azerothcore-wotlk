INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1627086373419613000');

UPDATE `creature_template` SET `speed_walk` = 1 WHERE `entry` IN (8300, 8301);
