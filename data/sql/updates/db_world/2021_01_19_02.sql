-- DB update 2021_01_19_01 -> 2021_01_19_02
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2021_01_19_01';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2021_01_19_01 2021_01_19_02 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1609354039936904092'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1609354039936904092');

DELETE FROM `conditions` WHERE (`SourceTypeOrReferenceId` = 22) AND (`SourceGroup` IN (1,2)) AND (`SourceEntry` = 6669) AND (`SourceId` = 0) AND (`ElseGroup` = 0) AND (`ConditionTypeOrReference` = 9) AND (`ConditionTarget` = 0) AND (`ConditionValue1` = 2078) AND (`ConditionValue2` = 0) AND (`ConditionValue3` = 0);
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `ErrorType`, `ErrorTextId`, `ScriptName`, `Comment`) VALUES
(22, 1, 6669, 0, 0, 9, 0, 2078, 0, 0, 1, 0, 0, '', 'The Threshwackonator 4000 - Default Gossip'),
(22, 2, 6669, 0, 0, 9, 0, 2078, 0, 0, 0, 0, 0, '', 'The Threshwackonator 4000 - Gossip when Quest ID: 2078 taken');

DELETE FROM `conditions` WHERE (`SourceTypeOrReferenceId` = 15) AND (`SourceGroup` = 21208) AND (`SourceEntry` = 0) AND (`SourceId` = 0) AND (`ElseGroup` = 0) AND (`ConditionTypeOrReference` = 9) AND (`ConditionTarget` = 0) AND (`ConditionValue1` = 2078) AND (`ConditionValue2` = 0) AND (`ConditionValue3` = 0);
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `ErrorType`, `ErrorTextId`, `ScriptName`, `Comment`) VALUES
(15, 21208, 0, 0, 0, 9, 0, 2078, 0, 0, 0, 0, 0, '', 'The Threshwackonator 4000 - Show gossip option only when Quest ID: 2078 taken.');

DELETE FROM `gossip_menu` WHERE (`MenuID` = 21208) AND (`TextID` IN (758));
INSERT INTO `gossip_menu` (`MenuID`, `TextID`) VALUES
(21208, 758);

DELETE FROM `gossip_menu_option` WHERE (`MenuID` = 21208) AND (`OptionID` IN (0));
INSERT INTO `gossip_menu_option` (`MenuID`, `OptionID`, `OptionIcon`, `OptionText`, `OptionBroadcastTextID`, `OptionType`, `OptionNpcFlag`, `ActionMenuID`, `ActionPoiID`, `BoxCoded`, `BoxMoney`, `BoxText`, `BoxBroadcastTextID`, `VerifiedBuild`) VALUES
(21208, 0, 0, 'Turn the key to start the machine.', 2703, 1, 1, 0, 0, 0, 0, '', 0, 0);

UPDATE `creature_template` SET `gossip_menu_id` = 0, `unit_flags` = 512, `AIName` = 'SmartAI', `ScriptName` = '' WHERE `entry` = 6669;

DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = 6669);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(6669, 0, 0, 0, 64, 0, 100, 0, 0, 0, 0, 0, 0, 98, 21208, 718, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'The Threshwackonator 4100 - On Gossip Hello - Send Gossip'),
(6669, 0, 1, 0, 64, 0, 100, 0, 0, 0, 0, 0, 0, 98, 21208, 758, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'The Threshwackonator 4100 - On Gossip Hello - Send Gossip'),
(6669, 0, 2, 3, 62, 0, 100, 0, 21208, 0, 0, 0, 0, 64, 1, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'The Threshwackonator 4100 - On Gossip Option 0 Selected - Store Targetlist'),
(6669, 0, 3, 4, 61, 0, 100, 0, 21208, 0, 0, 0, 0, 80, 666900, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'The Threshwackonator 4100 - On Gossip Option 0 Selected - Run Script'),
(6669, 0, 4, 0, 61, 0, 100, 0, 21208, 0, 0, 0, 0, 22, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'The Threshwackonator 4100 - On Gossip Option 0 Selected - Set Event Phase 1'),
(6669, 0, 5, 6, 75, 1, 100, 1, 36625, 0, 10, 0, 0, 29, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'The Threshwackonator 4100 - On Distance To Creature - Stop Follow  (Phase 1) (No Repeat)'),
(6669, 0, 6, 7, 61, 1, 100, 1, 36625, 0, 10, 0, 0, 80, 666901, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'The Threshwackonator 4100 - On Distance To Creature - Run Script (Phase 1) (No Repeat)'),
(6669, 0, 7, 8, 61, 1, 100, 1, 36625, 0, 10, 0, 0, 101, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'The Threshwackonator 4100 - On Distance To Creature - Set Home Position (Phase 1) (No Repeat)'),
(6669, 0, 8, 0, 61, 1, 100, 1, 36625, 0, 10, 0, 0, 22, 2, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'The Threshwackonator 4100 - On Distance To Creature - Set Event Phase 2 (Phase 1) (No Repeat)'),
(6669, 0, 9, 10, 1, 2, 100, 0, 30000, 30000, 30000, 30000, 0, 101, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'The Threshwackonator 4100 - Out of Combat - Set Home Position (Phase 2)'),
(6669, 0, 10, 11, 61, 2, 100, 0, 30000, 30000, 30000, 30000, 0, 82, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'The Threshwackonator 4100 - Out of Combat - Add Npc Flags Gossip (Phase 2)'),
(6669, 0, 11, 12, 61, 2, 100, 0, 30000, 30000, 30000, 30000, 0, 2, 35, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'The Threshwackonator 4100 - Out of Combat - Set Faction 35 (Phase 2)'),
(6669, 0, 12, 13, 61, 2, 100, 0, 30000, 30000, 30000, 30000, 0, 24, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'The Threshwackonator 4100 - Out of Combat - Evade (Phase 2)'),
(6669, 0, 13, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 22, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'The Threshwackonator 4100 - Out of Combat - Set Event Phase 0 (Phase 2)');

DELETE FROM `smart_scripts` WHERE (`source_type` = 9 AND `entryorguid` IN (666900, 666901));
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(666900, 9, 0, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 72, 0, 0, 0, 0, 0, 0, 12, 1, 0, 0, 0, 0, 0, 0, 0, 'The Threshwackonator 4100 - Actionlist - Close Gossip'),
(666900, 9, 1, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 83, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'The Threshwackonator 4100 - Actionlist - Remove Npc Flags Gossip'),
(666900, 9, 2, 0, 0, 0, 100, 0, 500, 500, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'The Threshwackonator 4100 - Actionlist - Say Line 0'),
(666900, 9, 3, 0, 0, 0, 100, 0, 1000, 1000, 0, 0, 0, 29, 2, 0, 0, 0, 0, 0, 12, 1, 0, 0, 0, 0, 0, 0, 0, 'The Threshwackonator 4100 - Actionlist - Start Follow [unsupported target type]'),
(666901, 9, 0, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 10, 36625, 6667, 0, 0, 0, 0, 0, 0, 'The Threshwackonator 4100 - Actionlist - Say Line 0'),
(666901, 9, 1, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 2, 14, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'The Threshwackonator 4100 - Actionlist - Set Faction 14'),
(666901, 9, 2, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 49, 0, 0, 0, 0, 0, 0, 12, 1, 0, 0, 0, 0, 0, 0, 0, 'The Threshwackonator 4100 - Actionlist - Start Attacking');


--
-- END UPDATING QUERIES
--
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
