-- DB update 2024_07_09_03 -> 2024_07_09_04
--
DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = 1181);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(1181, 0, 0, 0, 4, 0, 10, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Mo\'grosh Shaman - On Aggro - Say Line 0'),
(1181, 0, 1, 0, 0, 0, 100, 0, 0, 0, 3400, 5400, 0, 0, 11, 9532, 64, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Mo\'grosh Shaman - In Combat - Cast \'Lightning Bolt\''),
(1181, 0, 2, 0, 16, 0, 60, 0, 3229, 30, 8000, 13000, 1, 0, 11, 3229, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Mo\'grosh Shaman - On Friendly Unit Missing Buff \'Quick Bloodlust\' - Cast \'Quick Bloodlust\'');
