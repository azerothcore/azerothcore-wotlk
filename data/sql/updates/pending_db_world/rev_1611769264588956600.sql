INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1611769264588956600');

ALTER TABLE `creature_template` ADD COLUMN `spell_school_immune_mask` int(3) unsigned NOT NULL DEFAULT '0' AFTER `mechanic_immune_mask`;
