INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1629826555036082700');

ALTER TABLE `creature_loot_template` CHANGE `Reference` `Reference` MEDIUMINT DEFAULT 0 NOT NULL;
ALTER TABLE `disenchant_loot_template` CHANGE `Reference` `Reference` MEDIUMINT DEFAULT 0 NOT NULL;
ALTER TABLE `fishing_loot_template` CHANGE `Reference` `Reference` MEDIUMINT DEFAULT 0 NOT NULL;
ALTER TABLE `gameobject_loot_template` CHANGE `Reference` `Reference` MEDIUMINT DEFAULT 0 NOT NULL;
ALTER TABLE `item_loot_template` CHANGE `Reference` `Reference` MEDIUMINT DEFAULT 0 NOT NULL;
ALTER TABLE `mail_loot_template` CHANGE `Reference` `Reference` MEDIUMINT DEFAULT 0 NOT NULL;
ALTER TABLE `milling_loot_template` CHANGE `Reference` `Reference` MEDIUMINT DEFAULT 0 NOT NULL;
ALTER TABLE `pickpocketing_loot_template` CHANGE `Reference` `Reference` MEDIUMINT DEFAULT 0 NOT NULL;
ALTER TABLE `prospecting_loot_template` CHANGE `Reference` `Reference` MEDIUMINT DEFAULT 0 NOT NULL;
ALTER TABLE `reference_loot_template` CHANGE `Reference` `Reference` MEDIUMINT DEFAULT 0 NOT NULL;
ALTER TABLE `skinning_loot_template` CHANGE `Reference` `Reference` MEDIUMINT DEFAULT 0 NOT NULL;
ALTER TABLE `spell_loot_template` CHANGE `Reference` `Reference` MEDIUMINT DEFAULT 0 NOT NULL;
