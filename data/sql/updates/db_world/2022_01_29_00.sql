-- DB update 2022_01_28_03 -> 2022_01_29_00
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2022_01_28_03';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2022_01_28_03 2022_01_29_00 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1643408513033818500'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1643408513033818500');

DELETE FROM `gossip_menu_option` WHERE `MenuID` = 3801 AND `OptionID` = 1;
INSERT INTO `gossip_menu_option` (`MenuID`, `OptionID`, `OptionIcon`, `OptionText`, `OptionBroadcastTextID`, `OptionType`, `OptionNpcFlag`, `ActionMenuID`, `ActionPoiID`, `BoxCoded`, `BoxMoney`, `BoxText`, `BoxBroadcastTextID`, `VerifiedBuild`) VALUES
(3801, 1, 0, 'Myranda, do you have enough eyeballs to make another amulet? I have lost the old one.', 8324, 1, 3, 0, 0, 0, 0, '', 0, 0);

DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId` = 15 AND `SourceGroup` = 3801 AND `SourceEntry` = 1;
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `ErrorType`, `ErrorTextId`, `ScriptName`, `Comment`) VALUES
(15, 3801, 1, 0, 1, 8, 0, 6570, 0, 0, 0, 0, 0, '', 'Myranda the Hag - Show gossip option 1 if player has completed \'Emberstrife\''),
(15, 3801, 1, 0, 1, 2, 0, 16787, 1, 0, 1, 0, 0, '', 'Myranda the Hag - Show gossip option 1 if player doesn\'t have item \'16787\' in bag'),
(15, 3801, 1, 0, 1, 2, 0, 16787, 1, 1, 1, 0, 0, '', 'Myranda the Hag - Show gossip option 1 if player doesn\'t have item \'16787\' in bank');

DELETE FROM `smart_scripts` WHERE `entryorguid` = 11872 AND `source_type` = 0 AND `id` IN (2, 3);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(11872, 0, 2, 3, 62, 0, 100, 0, 3801, 1, 0, 0, 0, 72, 0, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Myranda the Hag - On Gossip Option 1 Selected - Close Gossip'),
(11872, 0, 3, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 11, 20693, 2, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Myranda the Hag - On Gossip Option 1 Selected - Cast \'Summon Lost Amulet\'');

--
-- END UPDATING QUERIES
--
UPDATE version_db_world SET date = '2022_01_29_00' WHERE sql_rev = '1643408513033818500';
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
