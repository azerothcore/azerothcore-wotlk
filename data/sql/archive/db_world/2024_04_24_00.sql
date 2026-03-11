-- DB update 2024_04_21_05 -> 2024_04_24_00
DELETE FROM `conditions` WHERE (`SourceTypeOrReferenceId` = 13) AND (`SourceEntry` IN (8596));
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `Comment`) VALUES 
(13, 1, 8596, 0, 0, 23, 0, 1519, 0, 0, 0, 'Potential target of the spell in area  (1519)'),
(13, 1, 8596, 0, 0, 31, 0, 3, 6173, 39538, 0, 'Potential target of the spell is creature, entry is Gazin Tenorm (6173) and guid is 39538');

-- Duthorian Rall smart ai
SET @ENTRY := 6171;
UPDATE `creature_template` SET `AIName` = 'SmartAI', `ScriptName` = '' WHERE `entry` = @ENTRY;
DELETE FROM `smart_scripts` WHERE `source_type` = 0 AND `entryOrGuid` = @ENTRY;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES 
(@ENTRY, 0, 0, 0, 25, 0, 100, 0, 0, 0, 0, 0, 22, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'On reset - Set event phase to phase 1'),
(@ENTRY, 0, 1, 2, 19, 1, 100, 0, 1781, 0, 0, 0, 23, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'On player accepted quest The Tome of Divinity (1781) - Increase phase by 1'),
(@ENTRY, 0, 2, 0, 61, 0, 100, 0, 0, 0, 0, 0, 86, 8596, 0, 10, 37571, 5489, 0, 10, 39538, 6173, 0, 0, 0, 0, 0, 'On player accepted quest The Tome of Divinity (1781) - Creature Brother Joshua (5489) with guid 37571 (fetching): Cast spell  Heal Visual (8596) at Creature Gazin Tenorm (6173) with guid 39538 (fetching)'),
(@ENTRY, 0, 3, 0, 38, 0, 100, 0, 0, 1, 0, 0, 22, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'On data[0] set to 1 - Set event phase to phase 1');

DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId` = 22 AND `SourceEntry` = 6171 AND `SourceId` = 0;

-- Gazin Tenorm smart ai
SET @ENTRY := 6173;
UPDATE `creature_template` SET `AIName` = 'SmartAI', `ScriptName` = '' WHERE `entry` = @ENTRY;
DELETE FROM `smart_scripts` WHERE `source_type` = 0 AND `entryOrGuid` = @ENTRY;
DELETE FROM `smart_scripts` WHERE `source_type` = 9 AND `entryOrGuid` IN (@ENTRY * 100);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES 
(@ENTRY, 0, 0, 0, 8, 0, 100, 0, 8596, 0, 0, 0, 80, 617300, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'On spell  Heal Visual (8596) hit - Self: Start timed action list id #Gazin Tenorm #0 (617300) (update out of combat) // -inline'),
(@ENTRY * 100, 9, 0, 0, 0, 0, 100, 0, 1000, 1000, 0, 0, 66, 0, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 'Gazin Tenorm - Look at Last action invoker'),
(@ENTRY * 100, 9, 1, 0, 0, 0, 100, 0, 2000, 2000, 0, 0, 90, 8, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Gazin Tenorm - Set stand state to KNEEL'),
(@ENTRY * 100, 9, 2, 0, 0, 0, 100, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Gazin Tenorm - Self: Talk 0 to invoker'),
(@ENTRY * 100, 9, 3, 0, 0, 0, 100, 0, 2500, 2500, 0, 0, 91, 8, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Gazin Tenorm - Remove stand state KNEEL'),
(@ENTRY * 100, 9, 4, 0, 0, 0, 100, 0, 2500, 2500, 0, 0, 66, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Gazin Tenorm - Set orientation to home position orientation'),
(@ENTRY * 100, 9, 5, 0, 0, 0, 100, 0, 0, 0, 0, 0, 45, 0, 1, 0, 0, 0, 0, 10, 39536, 6171, 0, 0, 0, 0, 0, 'After 0 seconds - Creature Duthorian Rall (6171) with guid 39536 (fetching): Set creature data #0 to 1');

DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId` = 22 AND `SourceEntry` = 6173 AND `SourceId` = 0;

DELETE FROM `creature_text` WHERE `CreatureID` = 6173;
INSERT INTO `creature_text` (`CreatureID`, `GroupID`, `ID`, `Text`, `Type`, `Language`, `Probability`, `Emote`, `Duration`, `Sound`, `BroadcastTextId`, `TextRange`, `comment`) VALUES
-- Language is 6
(6173, 0, 0, 'Thanks to you, $n.', 12, 6, 100, 0, 0, 0, 2284, 0, 'Gazin Tenorm');
