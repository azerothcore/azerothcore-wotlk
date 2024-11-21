-- DB update 2024_08_27_04 -> 2024_08_27_05
-- Warlord Zim'bo smart ai
SET @ENTRY := 26544;
UPDATE `creature_template` SET `AIName` = 'SmartAI', `ScriptName` = '' WHERE `entry` = @ENTRY;
DELETE FROM `smart_scripts` WHERE `source_type` = 0 AND `entryOrGuid` = @ENTRY;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(@ENTRY, 0, 0, 0, 4, 0, 100, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'On aggro - Self: Talk 0 to invoker'),
(@ENTRY, 0, 1, 0, 8, 0, 100, 1, 0, 0, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'On any spell hit - Self: Talk 1 to invoker'),
(@ENTRY, 0, 2, 0, 2, 0, 100, 1, 0, 80, 0, 0, 0, 0, 1, 2, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Warlord Zim\'bo - Between 0-80% Health - Say Line 2 (No Repeat)'),
(@ENTRY, 0, 3, 0, 2, 0, 100, 1, 0, 60, 0, 0, 0, 0, 1, 3, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Warlord Zim\'bo - Between 0-60% Health - Say Line 3 (No Repeat)'),
(@ENTRY, 0, 4, 0, 6, 0, 100, 0, 0, 0, 0, 0, 0, 0, 1, 4, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'On death - Self: Talk 4 to invoker'),
(@ENTRY, 0, 5, 0, 0, 0, 100, 0, 30000, 30000, 30000, 30000, 0, 0, 11, 3551, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Warlord Zim\'bo - In Combat - Cast \'Skull Crack\''),
(@ENTRY, 0, 6, 0, 0, 0, 100, 0, 2000, 4000, 2000, 4000, 0, 0, 11, 52283, 32, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Warlord Zim\'bo - In Combat - Cast \'Warlord Roar\''),
(@ENTRY, 0, 7, 0, 5, 0, 100, 0, 0, 0, 1, 0, 0, 0, 1, 5, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Warlord Zim\'bo - On Killed Unit - Say Line 5');

DELETE FROM `creature_text` WHERE `CreatureID` = 26544;
INSERT INTO `creature_text` (`CreatureID`, `GroupID`, `ID`, `Text`, `Type`, `Language`, `Probability`, `Emote`, `Duration`, `Sound`, `BroadcastTextId`, `TextRange`, `comment`) VALUES
(26544, 0, 0, 'For Drak\'Tharon!', 12, 0, 100, 0, 0, 0, 27331, 0, 'Warlord Zim\'bo'),
(26544, 1, 0, 'Zim\'bo must live to slay our betrayer!', 12, 0, 100, 0, 0, 0, 27332, 0, 'Warlord Zim\'bo'),
(26544, 2, 0, 'Zim\'bo cannot be stopped! Da keep must be liberated!', 12, 0, 100, 0, 0, 0, 27333, 0, 'Warlord Zim\'bo'),
(26544, 3, 0, 'You be dyin\' along with all dese scourge!', 12, 0, 100, 0, 0, 0, 27334, 0, 'Warlord Zim\'bo'),
(26544, 4, 0, 'Betrayed by one of our own we were. Disgraced....', 12, 0, 100, 0, 0, 0, 27335, 0, 'Warlord Zim\'bo'),
(26544, 5, 0, 'Ah, more essence to capture...', 12, 0, 100, 0, 0, 0, 27336, 0, 'Warlord Zim\'bo');
