INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1641837958335217980');

ALTER TABLE `creature`
    CHANGE COLUMN `id` `creature_id1` MEDIUMINT UNSIGNED NOT NULL DEFAULT 0 COMMENT 'Creature Identifier' AFTER `guid`,
    ADD COLUMN `creature_id2` MEDIUMINT UNSIGNED NOT NULL DEFAULT 0 COMMENT 'Creature Identifier' AFTER `creature_id1`,
    ADD COLUMN `chance_id1` FLOAT UNSIGNED NOT NULL DEFAULT 100 COMMENT 'Chance id1 spawns' AFTER `creature_id2`;
	