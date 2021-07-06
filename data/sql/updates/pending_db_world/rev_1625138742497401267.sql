INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1625138742497401267');

-- Siege Golem - set correct speed
UPDATE `creature_template` SET `speed_walk` = 1 WHERE `entry` = 2749;
