-- DB update 2021_10_17_07 -> 2021_10_18_00
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2021_10_17_07';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2021_10_17_07 2021_10_18_00 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1634171161160075400'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1634171161160075400');

DELETE FROM `gossip_menu_option` WHERE `MenuID` = 840 AND `OptionID` = 3;
INSERT INTO `gossip_menu_option` (`MenuID`, `OptionID`, `OptionIcon`, `OptionText`, `OptionBroadcastTextID`, `OptionType`, `OptionNpcFlag`, `ActionMenuID`, `BoxCoded`, `BoxMoney`, `BoxText`, `BoxBroadcastTextID`, `VerifiedBuild`) VALUES
(840, 3, 0, 'I have destroyed my Azsharite weaponry! I need your assistance in defeating the triad of power.', 5260, 1, 3, 0, 0, 0, '', 0, 0);

-- Conditions to offer another Fel Salve
DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId` = 15 AND `SourceGroup` = 840 AND `SourceEntry` = 3;
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `ErrorType`, `ErrorTextId`, `ScriptName`, `Comment`) VALUES
(15, 840, 3, 0, 0, 47, 0, 3627, 8, 0, 0, 0, 0, '', 'Show gossip option if quest \'Uniting the Shattered Amulet\' in progress'),
(15, 840, 3, 0, 0, 2, 0, 11582, 1, 1, 1, 0, 0, '', 'Show gossip option if player does not have item \'Fel Salve\''),
(15, 840, 3, 0, 0, 2, 0, 10696, 1, 1, 1, 0, 0, '', 'Show gossip option if player does not have item \'Enchanted Azsharite Sword\''),
(15, 840, 3, 0, 0, 2, 0, 10697, 1, 1, 1, 0, 0, '', 'Show gossip option if player does not have item \'Enchanted Azsharite Dagger\''),
(15, 840, 3, 0, 0, 2, 0, 10698, 1, 1, 1, 0, 0, '', 'Show gossip option if player does not have item \'Enchanted Azsharite Felbane Staff\'');

-- Fallen Hero of the Horde
DELETE FROM `smart_scripts` WHERE (`entryorguid` = 7572) AND (`source_type` = 0) AND (`id` IN (5, 6));
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(7572, 0, 5, 6, 62, 0, 100, 0, 840, 3, 0, 0, 0, 11, 15247, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Fallen Hero of the Horde - On Gossip Option 3 Selected - Invoker Cast \'Conjure Fel Salve\''),
(7572, 0, 6, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 72, 0, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Fallen Hero of the Horde - On Gossip Option 3 Selected - Close Gossip');

--
-- END UPDATING QUERIES
--
UPDATE version_db_world SET date = '2021_10_18_00' WHERE sql_rev = '1634171161160075400';
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
