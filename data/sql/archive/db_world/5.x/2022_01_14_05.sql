-- DB update 2022_01_14_04 -> 2022_01_14_05
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2022_01_14_04';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2022_01_14_04 2022_01_14_05 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1642127807584111320'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

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

--
-- END UPDATING QUERIES
--
UPDATE version_db_world SET date = '2022_01_14_05' WHERE sql_rev = '1642127807584111320';
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
