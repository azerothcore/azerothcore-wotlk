-- DB update 2025_12_20_03 -> 2025_12_20_04
-- Adjusted timers for "Fel Handler"
DELETE FROM `smart_scripts` WHERE `entryorguid` = 19190 AND `source_type` = 0 AND `id` = 0;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(19190, 0, 0, 0, 0, 0, 100, 0, 6250, 12500, 8000, 17500, 0, 0, 11, 32736, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Fel Handler - In Combat - Cast \'Mortal Strike\'');

-- Adjusted timers for "Netherhound"
DELETE FROM `smart_scripts` WHERE `entryorguid` = 16950 AND `source_type` = 0 AND `id` = 0;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(16950, 0, 0, 0, 0, 0, 100, 0, 3500, 8000, 9000, 15000, 0, 0, 11, 11981, 256, 0, 0, 0, 0, 5, 30, 0, 1, 0, 0, 0, 0, 0, 'Netherhound - In Combat - Cast \'Mana Burn\'');
