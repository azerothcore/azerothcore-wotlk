INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1629826555036082700');

ALTER TABLE `creature_loot_template` CHANGE `Reference` `Reference` MEDIUMINT DEFAULT 0 NOT NULL;
ALTER TABLE `prospecting_loot_template` CHANGE `Reference` `Reference` MEDIUMINT DEFAULT 0 NOT NULL;
