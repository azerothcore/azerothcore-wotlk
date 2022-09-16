-- DB update 2021_06_24_01 -> 2021_06_24_02
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2021_06_24_01';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2021_06_24_01 2021_06_24_02 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1623924645868172900'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1623924645868172900');

SET @GOSSIP_MENU = 6573;
SET @TEXT_QUEST_INCOMPLETE = 7788;
SET @TEXT_QUEST_COMPLETE = 7821;
SET @QUEST_COMPLETING_THE_DELIVERY = 8350;

DELETE FROM `gossip_menu` WHERE (`MenuID` = @GOSSIP_MENU) AND (`TextID` IN (@TEXT_QUEST_INCOMPLETE));
INSERT INTO `gossip_menu` (`MenuID`, `TextID`) VALUES
(@GOSSIP_MENU, @TEXT_QUEST_INCOMPLETE);

DELETE FROM `conditions` WHERE (`SourceTypeOrReferenceId` = 14) AND (`SourceGroup` = @GOSSIP_MENU) AND (`SourceEntry` = @TEXT_QUEST_INCOMPLETE) AND (`SourceId` = 0) AND (`ElseGroup` = 0) AND (`ConditionTypeOrReference` = 8) AND (`ConditionTarget` = 0) AND (`ConditionValue1` = @QUEST_COMPLETING_THE_DELIVERY) AND (`ConditionValue2` = 0) AND (`ConditionValue3` = 0);
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `ErrorType`, `ErrorTextId`, `ScriptName`, `Comment`) VALUES
(14, @GOSSIP_MENU, @TEXT_QUEST_INCOMPLETE, 0, 0, 8, 0, @QUEST_COMPLETING_THE_DELIVERY, 0, 0, 1, 0, 0, '', 'Display npc text on gossip menu if quest \'Completing the delivery\' is incomplete');

DELETE FROM `conditions` WHERE (`SourceTypeOrReferenceId` = 14) AND (`SourceGroup` = @GOSSIP_MENU) AND (`SourceEntry` = @TEXT_QUEST_COMPLETE) AND (`SourceId` = 0) AND (`ElseGroup` = 0) AND (`ConditionTypeOrReference` = 8) AND (`ConditionTarget` = 0) AND (`ConditionValue1` = @QUEST_COMPLETING_THE_DELIVERY) AND (`ConditionValue2` = 0) AND (`ConditionValue3` = 0);
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `ErrorType`, `ErrorTextId`, `ScriptName`, `Comment`) VALUES
(14, @GOSSIP_MENU, @TEXT_QUEST_COMPLETE, 0, 0, 8, 0, @QUEST_COMPLETING_THE_DELIVERY, 0, 0, 0, 0, 0, '', 'Display this gossip menu text when quest \'Completing the delivery\' was rewarded.');

--
-- END UPDATING QUERIES
--
UPDATE version_db_world SET date = '2021_06_24_02' WHERE sql_rev = '1623924645868172900';
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
