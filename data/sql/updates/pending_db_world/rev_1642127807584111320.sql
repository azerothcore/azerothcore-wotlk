INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1642127807584111320');

ALTER TABLE `creature`
    CHANGE COLUMN `creature_id1` `id1` MEDIUMINT UNSIGNED NOT NULL DEFAULT 0 COMMENT 'Creature Identifier' AFTER `guid`,
    CHANGE COLUMN `creature_id2` `id2` MEDIUMINT UNSIGNED NOT NULL DEFAULT 0 COMMENT 'Creature Identifier' AFTER `id1`,
    ADD COLUMN `id3` MEDIUMINT UNSIGNED NOT NULL DEFAULT 0 COMMENT 'Creature Identifier' AFTER `id2`,
    DROP COLUMN `chance_id1`;

UPDATE `acore_string` SET `content_default`="Player selected NPC\nDB GUID: %u, current GUID: %u.\nCurrent Entry: %u of (%u, %u, %u).\nDisplayID: %u (Native: %u).\nFaction: %u.\nnpcFlags: %u." WHERE `entry`=539;
UPDATE `acore_string` SET `locale_frFR`='PNJ sélectionné par le joueur\nGUID en base: %u, GUID actuel: %u.\nEntry actuel: %u de (%u, %u, %u).\nDisplayID: %u (Natif: %u).\nFaction: %u.\nnpcFlags: %u.' WHERE  `entry`=539;
UPDATE `acore_string` SET `locale_deDE`='Vom Spieler gewählter NPC\nDB GUID: %u, aktuelle GUID: %u.\nAktueller Entry: %u von (%u, %u, %u).\nDisplayID: %u (Ursprünglich: %u).\nFraktion: %u.\nnpcFlags: %u.' WHERE  `entry`=539;
UPDATE `acore_string` SET `locale_zhCN`='当前选择NPC属性\nDB GUID: %u,目前 GUID: %u.\n阵营: %u 的  (%u, %u, %u).\n外观ID: %u (Native: %u).\n编号: %u.\nNPC标识: %u.' WHERE  `entry`=539;
