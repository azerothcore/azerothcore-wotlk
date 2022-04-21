-- DB update 2021_11_05_01 -> 2021_11_05_02
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2021_11_05_01';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2021_11_05_01 2021_11_05_02 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1635856510467222141'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1635856510467222141');

-- Fix gossip for Mathredis Firestar
UPDATE `creature_template` SET `gossip_menu_id`=2298, `ScriptName`='npc_maredis_firestar' WHERE `entry`=9836;

DELETE FROM `gossip_menu` WHERE `MenuID` IN (2298,2299,2300,2301,2302,2303);
INSERT INTO `gossip_menu` (`MenuID`,`TextID`) VALUES (2298,2993), (2299,2994),(2300,2995),(2301,2996),(2302,2997),(2303,2998);

DELETE FROM `gossip_menu_option` WHERE `MenuID` IN (2298,2299,2300,2301,2302,2303);
INSERT INTO `gossip_menu_option` (`MenuID`, `OptionID`, `OptionIcon`, `OptionText`, `OptionBroadcastTextID`, `OptionType`, `OptionNpcFlag`, `ActionMenuID`, `ActionPoiID`, `BoxCoded`, `BoxMoney`, `BoxText`, `BoxBroadcastTextID`, `VerifiedBuild`) VALUES
(2299, 0, 0, 'I present to you the Libram of Rumination.', 5291, 1, 1, 0, 0, 0, 0, '', 0, 0),
(2300, 0, 0, 'I present to you the Libram of Constitution.', 5416, 1, 1, 0, 0, 0, 0, '', 0, 0),
(2301, 0, 0, 'I present to you the Libram of Tenacity.', 5417, 1, 1, 0, 0, 0, 0, '', 0, 0),
(2302, 0, 0, 'I present to you the Libram of Resilience.', 5418, 1, 1, 0, 0, 0, 0, '', 0, 0),
(2303, 0, 0, 'I present to you the Libram of Voracity.', 5419, 1, 1, 0, 0, 0, 0, '', 0, 0);

-- Condition for source Quest available condition type Item
DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId`=19 AND `SourceGroup`=0 AND `SourceEntry`=4463 AND `SourceId`=0;
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `ErrorType`, `ErrorTextId`, `ScriptName`, `Comment`) VALUES
(19, 0, 4463, 0, 0, 2, 0, 11732, 1, 0, 0, 0, 0, '', 'Quest Libram of Rumination available if player has 1 of Libram of Rumination. Item cannot be in bank.');

-- Condition for source Quest available condition type Item
DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId`=19 AND `SourceGroup`=0 AND `SourceEntry`=4481 AND `SourceId`=0;
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `ErrorType`, `ErrorTextId`, `ScriptName`, `Comment`) VALUES
(19, 0, 4481, 0, 0, 2, 0, 11733, 1, 0, 0, 0, 0, '', 'Quest Libram of Constitution available if player has 1 of Libram of Constitution. Item cannot be in bank.'),
(19, 0, 4481, 0, 0, 2, 0, 11732, 1, 0, 1, 0, 0, '', 'Quest Libram of Constitution available if player does not have 1 of Libram of Rumination. Item cannot be in bank.');

-- Condition for source Quest available condition type Item
DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId`=19 AND `SourceGroup`=0 AND `SourceEntry`=4482 AND `SourceId`=0;
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `ErrorType`, `ErrorTextId`, `ScriptName`, `Comment`) VALUES
(19, 0, 4482, 0, 0, 2, 0, 11734, 1, 0, 0, 0, 0, '', 'Quest Libram of Tenacity available if player has 1 of Libram of Tenacity. Item cannot be in bank.'),
(19, 0, 4482, 0, 0, 2, 0, 11732, 1, 0, 1, 0, 0, '', 'Quest Libram of Tenacity available if player does not have 1 of Libram of Rumination. Item cannot be in bank.'),
(19, 0, 4482, 0, 0, 2, 0, 11733, 1, 0, 1, 0, 0, '', 'Quest Libram of Tenacity available if player does not have 1 of Libram of Constitution. Item cannot be in bank.');

-- Condition for source Quest available condition type Item
DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId`=19 AND `SourceGroup`=0 AND `SourceEntry`=4483 AND `SourceId`=0;
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `ErrorType`, `ErrorTextId`, `ScriptName`, `Comment`) VALUES
(19, 0, 4483, 0, 0, 2, 0, 11736, 1, 0, 0, 0, 0, '', 'Quest Libram of Resilience available if player has 1 of Libram of Resilience. Item cannot be in bank.'),
(19, 0, 4483, 0, 0, 2, 0, 11732, 1, 0, 1, 0, 0, '', 'Quest Libram of Resilience available if player does not have 1 of Libram of Rumination. Item cannot be in bank.'),
(19, 0, 4483, 0, 0, 2, 0, 11733, 1, 0, 1, 0, 0, '', 'Quest Libram of Resilience available if player does not have 1 of Libram of Constitution. Item cannot be in bank.'),
(19, 0, 4483, 0, 0, 2, 0, 11734, 1, 0, 1, 0, 0, '', 'Quest Libram of Resilience available if player does not have 1 of Libram of Tenacity. Item cannot be in bank.');

-- Condition for source Quest available condition type Item
DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId`=19 AND `SourceGroup`=0 AND `SourceEntry`=4484 AND `SourceId`=0;
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `ErrorType`, `ErrorTextId`, `ScriptName`, `Comment`) VALUES
(19, 0, 4484, 0, 0, 2, 0, 11737, 1, 0, 0, 0, 0, '', 'Quest Libram of Voracity available if player has 1 of Libram of Voracity. Item cannot be in bank.'),
(19, 0, 4484, 0, 0, 2, 0, 11732, 1, 0, 1, 0, 0, '', 'Quest Libram of Voracity available if player does not have 1 of Libram of Rumination. Item cannot be in bank.'),
(19, 0, 4484, 0, 0, 2, 0, 11733, 1, 0, 1, 0, 0, '', 'Quest Libram of Voracity available if player does not have 1 of Libram of Constitution. Item cannot be in bank.'),
(19, 0, 4484, 0, 0, 2, 0, 11734, 1, 0, 1, 0, 0, '', 'Quest Libram of Voracity available if player does not have 1 of Libram of Tenacity. Item cannot be in bank.'),
(19, 0, 4484, 0, 0, 2, 0, 11736, 1, 0, 1, 0, 0, '', 'Quest Libram of Voracity available if player does not have 1 of Libram of Resilience. Item cannot be in bank.');

--
-- END UPDATING QUERIES
--
UPDATE version_db_world SET date = '2021_11_05_02' WHERE sql_rev = '1635856510467222141';
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
