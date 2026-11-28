-- DB update 2026_10_24_03 -> 2026_10_24_04
--
DELETE FROM `creature_text` WHERE `CreatureID` = 18718;
INSERT INTO `creature_text` (`CreatureID`, `GroupID`, `ID`, `Text`, `Type`, `Language`, `Probability`, `Emote`, `Duration`, `Sound`, `BroadcastTextId`, `TextRange`, `comment`) VALUES
(18718, 0, 0, 'You!  You don\'t belong here!', 12, 0, 100, 0, 0, 0, 15786, 0, 'Shadowy Hunter');

DELETE FROM `smart_scripts` WHERE `entryorguid` = 18718 AND `source_type` = 0;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(18718, 0, 0, 0, 0, 0, 100, 0, 4000, 7000, 4000, 7000, 0, 0, 11, 32915, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Shadowy Hunter - In Combat - Cast \'Raptor Strike\' (Phase 1) (No Repeat) (Dungeon)'),
(18718, 0, 1, 0, 0, 0, 100, 0, 2000, 5000, 8000, 13000, 0, 0, 11, 32908, 1, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Shadowy Hunter - In Combat - Cast \'Wing Clip\' (Phase 1) (No Repeat) (Dungeon)'),
(18718, 0, 2, 0, 4, 0, 100, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Shadowy Hunter - On Aggro - Say Line 0');
