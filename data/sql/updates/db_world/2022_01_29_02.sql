-- DB update 2022_01_29_01 -> 2022_01_29_02
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2022_01_29_01';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2022_01_29_01 2022_01_29_02 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1642779550112004300'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1642779550112004300');

DELETE FROM `gossip_menu` WHERE `MenuID` in (4821, 4824, 4825, 4827) AND `TextID` in (5874, 5880, 5882, 5886);
INSERT INTO `gossip_menu` (`MenuID`, `TextID`) VALUES
(4821, 5874),
(4824, 5880),
(4825, 5882),
(4827, 5886);

DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId` = 14 and `SourceGroup` in (4821, 4822, 4824, 4825, 4827) and `ConditionTypeOrReference` = 15 and `SourceEntry` in (5873, 5874, 5875, 5876, 5879, 5880, 5881, 5882, 5885, 5886);
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `ErrorType`, `ErrorTextId`, `ScriptName`, `Comment`) VALUES
(14, 4821, 5873, 0, 0, 15, 0, 128, 0, 0, 1, 0, 0, '', 'Portal Trainer - Show gossip menu if player is not a mage'),
(14, 4821, 5874, 0, 0, 15, 0, 128, 0, 0, 0, 0, 0, '', 'Portal Trainer - Show gossip menu if player is a mage'),
(14, 4822, 5875, 0, 0, 15, 0, 128, 0, 0, 1, 0, 0, '', 'Portal Trainer - Show gossip menu if player is not a mage'),
(14, 4822, 5876, 0, 0, 15, 0, 128, 0, 0, 0, 0, 0, '', 'Portal Trainer - Show gossip menu if player is a mage'),
(14, 4824, 5879, 0, 0, 15, 0, 128, 0, 0, 1, 0, 0, '', 'Portal Trainer - Show gossip menu if player is not a mage'),
(14, 4824, 5880, 0, 0, 15, 0, 128, 0, 0, 0, 0, 0, '', 'Portal Trainer - Show gossip menu if player is a mage'),
(14, 4825, 5881, 0, 0, 15, 0, 128, 0, 0, 0, 0, 0, '', 'Portal Trainer - Show gossip menu if player is a mage'),
(14, 4825, 5882, 0, 0, 15, 0, 128, 0, 0, 1, 0, 0, '', 'Portal Trainer - Show gossip menu if player is not a mage'),
(14, 4827, 5885, 0, 0, 15, 0, 128, 0, 0, 1, 0, 0, '', 'Portal Trainer - Show gossip menu if player is not a mage'),
(14, 4827, 5886, 0, 0, 15, 0, 128, 0, 0, 0, 0, 0, '', 'Portal Trainer - Show gossip menu if player is a mage');

--
-- END UPDATING QUERIES
--
UPDATE version_db_world SET date = '2022_01_29_02' WHERE sql_rev = '1642779550112004300';
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
