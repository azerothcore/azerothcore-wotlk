INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1615103299173233870');

-- Kolkar Drudge and Kolkar Outrunner spell resistances

UPDATE `creature_template` SET `resistance2`=0, `resistance5`=0 WHERE `entry` IN (3119,3120);
