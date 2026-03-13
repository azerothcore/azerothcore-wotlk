-- DB update 2024_02_25_01 -> 2024_02_25_02
--
DELETE FROM `smart_scripts` WHERE `source_type` = 0 AND `entryorguid` BETWEEN 21268 AND 21274;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(21268, 0, 0, 0, 0, 0, 100, 0, 0, 0, 2000, 2000, 0, 0, 11, 36980, 64, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Netherstrand Longbow - In Combat - Cast Shot'),
(21268, 0, 1, 0, 0, 0, 100, 0, 4000, 8000, 12000, 15000, 0, 0, 11, 36979, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Netherstrand Longbow - In Combat - Cast Multi-Shot'),
(21268, 0, 2, 0, 6, 0, 100, 0, 0, 0, 0, 0, 0, 0, 223, 4, 0, 0, 0, 0, 0, 9, 19622, 0, 2000, 1, 0, 0, 0, 0, 'Netherstrand Longbow - On death - Do Action'),
(21269, 0, 0, 0, 0, 0, 100, 0, 4000, 8000, 12000, 15000, 0, 0, 11, 36981, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Devastation - In Combat - Cast Whirlwind'),
(21269, 0, 1, 0, 6, 0, 100, 0, 0, 0, 0, 0, 0, 0, 223, 4, 0, 0, 0, 0, 0, 9, 19622, 0, 2000, 1, 0, 0, 0, 0, 'Devastation - On death - Do Action'),
(21270, 0, 0, 0, 0, 0, 100, 0, 3000, 5000, 7000, 9000, 0, 0, 11, 36985, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Cosmic Infuser - In Combat - Cast Holy Nova'),
(21270, 0, 1, 0, 14, 0, 100, 0, 30000, 40, 10000, 10000, 0, 0, 11, 36983, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Cosmic Infuser - Friendly Missing HP - Cast Heal'),
(21270, 0, 2, 0, 6, 0, 100, 0, 0, 0, 0, 0, 0, 0, 223, 4, 0, 0, 0, 0, 0, 9, 19622, 0, 2000, 1, 0, 0, 0, 0, 'Cosmic Infuser - On death - Do Action'),
(21271, 0, 0, 0, 6, 0, 100, 0, 0, 0, 0, 0, 0, 0, 223, 4, 0, 0, 0, 0, 0, 9, 19622, 0, 2000, 1, 0, 0, 0, 0, 'Infinity Blades - On death - Do Action'),
(21272, 0, 0, 0, 0, 0, 100, 0, 3000, 5000, 6000, 8000, 0, 0, 11, 36991, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Warp Slicer - In Combat - Cast Rend'),
(21272, 0, 1, 0, 6, 0, 100, 0, 0, 0, 0, 0, 0, 0, 223, 4, 0, 0, 0, 0, 0, 9, 19622, 0, 2000, 1, 0, 0, 0, 0, 'Warp Slicer - On death - Do Action'),
(21273, 0, 0, 0, 105, 0, 100, 0, 10000, 10000, 10000, 10000, 0, 5, 11, 36988, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Phaseshift Bulwark - Victim Casting - Cast Shield Bash'),
(21273, 0, 1, 0, 6, 0, 100, 0, 0, 0, 0, 0, 0, 0, 223, 4, 0, 0, 0, 0, 0, 9, 19622, 0, 2000, 1, 0, 0, 0, 0, 'Phaseshift Bulwark - On death - Do Action'),
(21274, 0, 0, 0, 0, 0, 100, 0, 0, 0, 2200, 2200, 0, 0, 11, 36990, 64, 0, 0, 0, 0, 5, 50, 0, 0, 0, 0, 0, 0, 0, 'Staff of Disintegration - In Combat - Cast Frost Bolt'),
(21274, 0, 1, 0, 106, 0, 100, 0, 5000, 5000, 10000, 10000, 0, 10, 11, 36989, 0, 0, 0, 0, 0, 5, 10, 0, 0, 0, 0, 0, 0, 0, 'Staff of Disintegration - In Combat - Cast Frost Nova'),
(21274, 0, 2, 0, 6, 0, 100, 0, 0, 0, 0, 0, 0, 0, 223, 4, 0, 0, 0, 0, 0, 9, 19622, 0, 2000, 1, 0, 0, 0, 0, 'Staff of Disintegration - On death - Do Action');
