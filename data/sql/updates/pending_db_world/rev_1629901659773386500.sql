INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1629901659773386500');

ALTER TABLE `character_spell_cooldown` ADD COLUMN `category` MEDIUMINT UNSIGNED DEFAULT 0 NOT NULL AFTER `spell`; 
ALTER TABLE `pet_spell_cooldown` ADD COLUMN `category` MEDIUMINT UNSIGNED DEFAULT 0 NOT NULL AFTER `spell`; 
