-- DB update 2021_12_31_00 -> 2021_12_31_01
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2021_12_31_00';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2021_12_31_00 2021_12_31_01 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1640896254599408944'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1640896254599408944');

-- This fixes: https://github.com/azerothcore/azerothcore-wotlk/issues/6780

-- Condition for source Gossip menu condition type Quest state
DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId`=14 AND `SourceGroup`=7376 AND `SourceEntry`=8826 AND `SourceId`=0;
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `ErrorType`, `ErrorTextId`, `ScriptName`, `Comment`) VALUES
(14, 7376, 8826, 0, 0, 47, 0, 9451, 64, 0, 0, 0, 0, '', 'Show gossip menu 7376 text id 8826 if quest Call of Earth is rewarded');

-- Condition for source Gossip menu condition type Class
DELETE FROM `gossip_menu` WHERE `MenuID`=7376 AND `TextID`=8824;
INSERT INTO `gossip_menu` (`MenuID`,`TextID`) VALUES (7376,8824);
DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId`=14 AND `SourceGroup`=7376 AND `SourceEntry`=8824 AND `SourceId`=0;
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `ErrorType`, `ErrorTextId`, `ScriptName`, `Comment`) VALUES
(14, 7376, 8824, 0, 0, 15, 0, 64, 0, 0, 1, 0, 0, '', 'Show gossip menu 7376 text id 8824 if player is not a shaman.');

-- Condition for source Gossip menu condition type Class
DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId`=14 AND `SourceGroup`=7376 AND `SourceEntry`=8827 AND `SourceId`=0;
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `ErrorType`, `ErrorTextId`, `ScriptName`, `Comment`) VALUES
(14, 7376, 8827, 0, 0, 15, 0, 64, 0, 0, 0, 0, 0, '', 'Show gossip menu 7376 text id 8827 if player is a Shaman.'),
(14, 7376, 8827, 0, 0, 47, 0, 9451, 64, 0, 1, 0, 0, '', 'Show gossip menu 7376 text id 8827 if quest Call of Earth is not rewarded.');

--
-- END UPDATING QUERIES
--
UPDATE version_db_world SET date = '2021_12_31_01' WHERE sql_rev = '1640896254599408944';
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
