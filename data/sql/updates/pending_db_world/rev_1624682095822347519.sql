INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1624682095822347519');

-- Slows Gnarl Leafbrother to normal speed
UPDATE `creature_template` SET `speed_walk` = 1 WHERE `entry` = 5354;
