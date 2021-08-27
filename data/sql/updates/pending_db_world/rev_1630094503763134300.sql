INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1630094503763134300');

ALTER TABLE `creature_loot_template` CHANGE `Reference` `Reference` MEDIUMINT DEFAULT 0 NOT NULL;
