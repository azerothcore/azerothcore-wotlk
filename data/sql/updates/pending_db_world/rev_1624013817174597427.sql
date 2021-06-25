INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1624013817174597427');

-- Slow Baron Charr down to reasonable speed
UPDATE `creature_template` SET `speed_walk` = 1 WHERE `entry` = 14461;
