-- DB update 2024_08_17_02 -> 2024_08_18_00
-- fix spells and timer of Aether Ray (22181)
DELETE FROM `smart_scripts` WHERE (`entryorguid` = 22181) AND (`source_type` = 0) AND (`id` IN (0, 2));
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(22181, 0, 0, 0, 0, 0, 100, 0, 5000, 15000, 20000, 20000, 0, 0, 11, 35333, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Aether Ray - In Combat - Cast \'Tail Swipe\''),
(22181, 0, 2, 0, 3, 0, 100, 0, 0, 75, 20000, 20000, 0, 0, 11, 17008, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Aether Ray - Between 0-75% Mana - Cast \'Mana Drain\'');
