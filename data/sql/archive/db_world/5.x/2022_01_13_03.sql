-- DB update 2022_01_13_02 -> 2022_01_13_03
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2022_01_13_02';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2022_01_13_02 2022_01_13_03 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1642085410673517853'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1642085410673517853');

UPDATE `acore_string` SET `content_default`="Player selected NPC\nDB GUID: %u, current GUID: %u.\nCurrent Entry: %u of (%u, %u).\nChance of First Entry: %f percent.\nDisplayID: %u (Native: %u).\nFaction: %u.\nnpcFlags: %u." WHERE `entry`=539;
UPDATE `acore_string` SET `locale_frFR`='PNJ sélectionné par le joueur\nGUID en base: %u, GUID actuel: %u.\nEntry actuel: %u de (%u, %u).\nProbabilité de spawn de la première Entry: %f pour cent.\nDisplayID: %u (Natif: %u).\nFaction: %u.\nnpcFlags: %u.' WHERE  `entry`=539;
UPDATE `acore_string` SET `locale_deDE`='Vom Spieler gewählter NPC\nDB GUID: %u, aktuelle GUID: %u.\nAktueller Entry: %u von (%u, %u).\nChance auf ersten Entry: %f Prozent.\nDisplayID: %u (Ursprünglich: %u).\nFraktion: %u.\nnpcFlags: %u.' WHERE  `entry`=539;
UPDATE `acore_string` SET `locale_zhCN`='当前选择NPC属性\nDB GUID: %u,目前 GUID: %u.\n阵营: %u 的  (%u, %u).\n第一次进入的机会：%f 百分率.\n外观ID: %u (Native: %u).\n编号: %u.\nNPC标识: %u.' WHERE  `entry`=539;


--
-- END UPDATING QUERIES
--
UPDATE version_db_world SET date = '2022_01_13_03' WHERE sql_rev = '1642085410673517853';
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
