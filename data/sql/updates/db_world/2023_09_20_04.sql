-- DB update 2023_09_20_03 -> 2023_09_20_04

DELETE FROM `creature_text` WHERE `CreatureID` = 16833;
INSERT INTO `creature_text` (`CreatureID`, `GroupID`, `ID`, `Text`, `Type`, `Language`, `Probability`, `Emote`, `Duration`, `Sound`, `BroadcastTextId`, `TextRange`, `comment`) VALUES
(16833, 0, 0, 'No!  Not... Sedai!  The orcs must pay!', 12, 0, 100, 0, 0, 0, 13997, 0, 'Makuru // Makuru');

 -- Anchorite Obadei smart ai
SET @ENTRY := 16834;
DELETE FROM `smart_scripts` WHERE `source_type` = 0 AND `entryOrGuid` = @ENTRY;
UPDATE `creature_template` SET `AIName` = 'SmartAI', `ScriptName` = '' WHERE `entry` = @ENTRY;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES 
(@ENTRY, 0, 0, 0, 20, 0, 100, 0, 9423, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 10, 57906, 16833, 0, 0, 0, 0, 0, 'Anchorite Obadei - On Quest \'Return to Obadei\' Finished - Say Line 0');

DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId` = 22 AND `SourceEntry` = 16834 AND `SourceId` = 0;
