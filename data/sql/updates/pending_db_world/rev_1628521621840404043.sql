INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1628521621840404043');

-- Delete skinning table 100008 from lvl 1 Serpentbloom Snake
UPDATE `creature_template` SET `skinloot` = 0 WHERE `entry` = 3680;

