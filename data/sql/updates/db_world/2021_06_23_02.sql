-- DB update 2021_06_23_01 -> 2021_06_23_02
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2021_06_23_01';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2021_06_23_01 2021_06_23_02 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1623886496730734500'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1623886496730734500');

-- Added the NPC text for Arcanist Helion's gossip menu
DELETE FROM `npc_text` WHERE `ID` = 50030;
INSERT INTO `npc_text` VALUES (50030, 'Knowledge is power - TRUE power, my young friend. You\'ll be wise to acquire as much of it as you can, and pay proper heed to those who have already done so.\r\n\r\nBefore the razing of the Sunwell, we fooled ourselves into thinking we had neared the apex of our civilization. It took the Scourge to bring us to our knees... and in a way, back to reality.', 'Knowledge is power - TRUE power, my young friend. You\'ll be wise to acquire as much of it as you can, and pay proper heed to those who have already done so.\r\n\r\nBefore the razing of the Sunwell, we fooled ourselves into thinking we had neared the apex of our civilization. It took the Scourge to bring us to our knees... and in a way, back to reality.', 0, 0, 0, 0, 0, 0, 0, 0, 0, NULL, NULL, 0, 0, 0, 0, 0, 0, 0, 0, 0, NULL, NULL, 0, 0, 0, 0, 0, 0, 0, 0, 0, NULL, NULL, 0, 0, 0, 0, 0, 0, 0, 0, 0, NULL, NULL, 0, 0, 0, 0, 0, 0, 0, 0, 0, NULL, NULL, 0, 0, 0, 0, 0, 0, 0, 0, 0, NULL, NULL, 0, 0, 0, 0, 0, 0, 0, 0, 0, NULL, NULL, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1);

-- Created his gossip menu
DELETE FROM `gossip_menu` WHERE (`MenuID` = 12002);
INSERT INTO `gossip_menu` (`MenuID`, `TextID`) VALUES
(12002, 50030);

-- Updated his gossip menu on creature template
UPDATE `creature_template` SET `gossip_menu_id` = 12002 WHERE (`entry` = 15297);

--
-- END UPDATING QUERIES
--
UPDATE version_db_world SET date = '2021_06_23_02' WHERE sql_rev = '1623886496730734500';
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
