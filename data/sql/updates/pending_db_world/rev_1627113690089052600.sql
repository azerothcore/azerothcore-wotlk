INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1627113690089052600');

ALTER TABLE `creature_template` ADD COLUMN `ExperienceModifier` FLOAT NOT NULL DEFAULT 1 AFTER `ArmorModifier`;