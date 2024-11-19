-- DB update 2021_05_09_04 -> 2021_05_09_05
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2021_05_09_04';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2021_05_09_04 2021_05_09_05 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1620375361639873000'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1620375361639873000');

-- Remove quest mutual exclusivity
UPDATE `quest_template_addon` SET `ExclusiveGroup` = 0 WHERE (`ID` IN (990,10752));

-- Remove Cataclysm gossip for Sentinel Selarin
UPDATE `creature_template` SET `gossip_menu_id` = 0, `npcflag` = 2 WHERE (`entry` = 3694);
DELETE FROM `gossip_menu` WHERE `MenuID` = 10268 AND `TextID` = 14259;
DELETE FROM `npc_text` WHERE `id` = 14259;

--
-- END UPDATING QUERIES
--
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
