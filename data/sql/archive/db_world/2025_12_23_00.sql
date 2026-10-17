-- DB update 2025_12_22_01 -> 2025_12_23_00
--
DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = 27639);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(27639, 0, 0, 0, 9, 0, 100, 2, 7500, 15000, 15000, 19000, 0, 0, 11, 50715, 0, 0, 0, 0, 0, 5, 40, 1, 0, 0, 0, 0, 0, 0, 'Ring-Lord Sorceress - In Combat - Cast \'Blizzard\' (Normal Dungeon)'),
(27639, 0, 1, 0, 9, 0, 100, 4, 7500, 15000, 15000, 19000, 0, 40, 11, 59278, 0, 0, 0, 0, 0, 5, 40, 1, 0, 0, 0, 0, 0, 0, 'Ring-Lord Sorceress - In Combat - Cast \'Blizzard\' (Heroic Dungeon)'),
(27639, 0, 2, 0, 0, 0, 100, 2, 9000, 12000, 15000, 18000, 0, 0, 11, 16102, 0, 0, 0, 0, 0, 5, 0, 0, 0, 0, 0, 0, 0, 0, 'Ring-Lord Sorceress - In Combat - Cast \'Flamestrike\' (Normal Dungeon)'),
(27639, 0, 3, 0, 0, 0, 100, 4, 9000, 12000, 15000, 18000, 0, 0, 11, 61402, 0, 0, 0, 0, 0, 5, 0, 0, 0, 0, 0, 0, 0, 0, 'Ring-Lord Sorceress - In Combat - Cast \'Flamestrike\' (Heroic Dungeon)'),
(27639, 0, 4, 0, 1, 0, 100, 0, 1000, 1000, 0, 0, 0, 0, 11, 51518, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Ring-Lord Sorceress - Out of Combat - Cast \'Nexus Energy Cosmetic\'');
