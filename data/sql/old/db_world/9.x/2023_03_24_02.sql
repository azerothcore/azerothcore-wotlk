-- DB update 2023_03_24_01 -> 2023_03_24_02
-- Thule Ravenclaw - remove ranged movement
DELETE FROM `smart_scripts` WHERE `source_type` = 0 AND `entryorguid` = 1947;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(1947, 0, 0, 0, 0, 0, 85, 0, 5000, 5000, 20000, 30000, 0, 11, 7655, 0, 0, 0, 0, 0, 5, 0, 0, 0, 0, 0, 0, 0, 0, 'Thule Ravenclaw - In Combat - Cast \'Hex of Ravenclaw\''),
(1947, 0, 1, 0, 0, 0, 85, 0, 1000, 1000, 7000, 12000, 0, 11, 20800, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Thule Ravenclaw - In Combat - Cast \'Immolate\''),
(1947, 0, 2, 0, 1, 0, 100, 1, 0, 0, 1000, 1000, 0, 11, 11939, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Thule Ravenclaw - Out of Combat - Cast \'Summon Imp\''),
(1947, 0, 3, 0, 4, 0, 85, 1, 0, 0, 0, 0, 0, 11, 13787, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Thule Ravenclaw - On Aggro - Cast \'Demon Armor\'');
