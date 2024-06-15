-- DB update 2022_02_11_01 -> 2022_02_11_02
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2022_02_11_01';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2022_02_11_01 2022_02_11_02 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1643834611045156900'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1643834611045156900');

SET @NPC_ENTRY := 239; /* Grimbooze Thunderbrew */
SET @GOSSIP_MENU_ID := 61028;
SET @NPC_TEXT_ID := 50034;

UPDATE `creature_template` SET `gossip_menu_id` = @GOSSIP_MENU_ID WHERE `entry` = @NPC_ENTRY;
UPDATE `creature_template` SET `npcflag` = `npcflag`|1|2 WHERE `entry` = @NPC_ENTRY;
DELETE FROM `npc_text` WHERE `ID` = @NPC_TEXT_ID;
INSERT INTO `npc_text` (`ID`, `text0_0`, `text0_1`, `BroadcastTextID0`)
VALUES (@NPC_TEXT_ID,
        'Adventure from lands far and near $bMeeting with folks both odd and queer $bBut if of me a question you ask $bYou must first complete a simple task!',
        'Adventure from lands far and near $bMeeting with folks both odd and queer $bBut if of me a question you ask $bYou must first complete a simple task!', 0);

DELETE FROM `gossip_menu` WHERE `MenuID` = @GOSSIP_MENU_ID AND `TextID` = @NPC_TEXT_ID;
INSERT INTO `gossip_menu` (`MenuID`, `TextID`) VALUES
(@GOSSIP_MENU_ID, @NPC_TEXT_ID);

--
-- END UPDATING QUERIES
--
UPDATE version_db_world SET date = '2022_02_11_02' WHERE sql_rev = '1643834611045156900';
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
