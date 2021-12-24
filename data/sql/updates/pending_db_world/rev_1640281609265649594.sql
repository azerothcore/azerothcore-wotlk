INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1640281609265649594');

-- High Warlord Whirlaxis is not skinnable fix. Never was skinnable. Flags Corrected.
UPDATE `creature_template` SET `unit_flags`=0, `skinloot`=0 WHERE  `entry`=15204;
