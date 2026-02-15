-- DB update 2026_02_03_01 -> 2026_02_04_00
--
DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = 20046);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(20046, 0, 0, 0, 0, 0, 100, 0, 1000, 3000, 5500, 7500, 0, 0, 11, 37110, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Astromancer Lord - In Combat - Cast \'Fire Blast\''),
(20046, 0, 1, 0, 0, 0, 100, 0, 4000, 8000, 15000, 17000, 0, 0, 11, 37289, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Astromancer Lord - In Combat - Cast \'Dragon\'s Breath\''),
(20046, 0, 2, 0, 0, 0, 100, 0, 15000, 16000, 15000, 24000, 0, 0, 11, 37109, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Astromancer Lord - In Combat - Cast \'Fireball Volley\''),
(20046, 0, 3, 0, 0, 0, 100, 1, 0, 1000, 0, 0, 0, 0, 11, 38732, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Astromancer Lord - In Combat - Cast \'Fire Shield\' (No Repeat)'),
(20046, 0, 4, 0, 0, 0, 100, 0, 9700, 19800, 10900, 23800, 0, 0, 11, 37122, 32, 0, 0, 0, 0, 6, 20, 1, 0, 37122, 0, 0, 0, 0, 'Astromancer Lord - In Combat - Cast \'Domination\'');
