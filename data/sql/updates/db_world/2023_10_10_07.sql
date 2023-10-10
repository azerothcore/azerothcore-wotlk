-- DB update 2023_10_10_06 -> 2023_10_10_07
-- Change from 150 minutes to 5
UPDATE `event_scripts` SET `datalong2` = 300000 WHERE `id` = 3084 AND `command` = 10;

DELETE FROM `conditions` WHERE (`SourceTypeOrReferenceId` = 17) AND (`SourceGroup` = 0) AND (`SourceEntry` = 12283);
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `ErrorType`, `ErrorTextId`, `ScriptName`, `Comment`) VALUES
(17, 0, 12283, 0, 0, 29, 0, 8392, 20, 0, 1, 0, 0, '', 'Allow using Standard Issue Flare Gun only if no Pilot Xiggs Fuselighter is within 20 yards.');

-- Pilot Xiggs Fuselighter
UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 8392;

DELETE FROM `smart_scripts` WHERE (`entryorguid` = 8392) AND (`source_type` = 0);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(8392, 0, 0, 0, 54, 0, 100, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Pilot Xiggs Fuselighter - On Just Summoned - Say Line 0');

DELETE FROM `creature_text` WHERE `CreatureID`=8392;
INSERT INTO `creature_text` (`CreatureID`, `GroupID`, `ID`, `Text`, `Type`, `Language`, `Probability`, `Emote`, `Duration`, `Sound`, `BroadcastTextId`, `TextRange`, `comment`) VALUES
(8392, 0, 1, 'Been waitin\' for ya, $n. Glad to see you\'ve come through. Do you have the shipment?', 12, 7, 100, 3, 0, 0, 4406, 0, 'Pilot Xiggs Fuselighter - Greet on summon');
