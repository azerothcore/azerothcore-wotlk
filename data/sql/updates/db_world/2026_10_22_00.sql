-- DB update 2026_10_21_02 -> 2026_10_22_00
DELETE FROM `smart_scripts` WHERE `entryorguid` IN (1051, 1052, 1053, 1054, 6523) AND `source_type` = 0;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(1051, 0, 0, 0, 4, 0, 15, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Dark Iron Dwarf - On Aggro - Say Line 0 (No Repeat)'),
(1051, 0, 1, 0, 0, 0, 100, 512, 2000, 8300, 18000, 34200, 0, 0, 11, 7891, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Dark Iron Dwarf - In Combat - Cast \'Gift of Ragnaros\' (No Repeat)'),
(1051, 0, 2, 0, 2, 0, 100, 1, 0, 15, 0, 0, 0, 0, 25, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Dark Iron Dwarf - Between 0-15% Health - Flee For Assist (No Repeat)'),
(1052, 0, 0, 0, 0, 0, 100, 512, 2100, 7300, 18000, 26000, 0, 0, 11, 7891, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Dark Iron Saboteur - In Combat - Cast \'Gift of Ragnaros\' (No Repeat)'),
(1052, 0, 1, 0, 2, 0, 100, 1, 0, 15, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Dark Iron Saboteur - Between 0-15% Health - Say Line 0 (No Repeat)'),
(1052, 0, 2, 0, 2, 0, 100, 1, 0, 15, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Dark Iron Saboteur - Between 0-15% Health - Say Line 1 (No Repeat)'),
(1052, 0, 3, 0, 2, 0, 100, 1, 0, 15, 0, 0, 0, 0, 11, 3204, 1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Dark Iron Saboteur - Between 0-15% Health - Cast \'Sapper Explode\' (No Repeat)'),
(1053, 0, 0, 0, 4, 0, 15, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Dark Iron Tunneler - On Aggro - Say Line 0 (No Repeat)'),
(1053, 0, 1, 0, 0, 0, 100, 0, 500, 1000, 1300, 5000, 0, 0, 11, 7164, 33, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Dark Iron Tunneler - In Combat - Cast \'Defensive Stance\' (No Repeat)'),
(1053, 0, 2, 0, 0, 0, 100, 512, 2000, 8500, 18000, 22000, 0, 0, 11, 7891, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Dark Iron Tunneler - In Combat - Cast \'Gift of Ragnaros\' (No Repeat)'),
(1053, 0, 3, 0, 0, 0, 100, 0, 3100, 12400, 8900, 15900, 0, 0, 11, 11971, 1, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Dark Iron Tunneler - In Combat - Cast \'Sunder Armor\' (No Repeat)'),
(1053, 0, 4, 0, 2, 0, 100, 1, 0, 15, 0, 0, 0, 0, 25, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Dark Iron Tunneler - Between 0-15% Health - Flee For Assist (No Repeat)'),
(1054, 0, 0, 0, 4, 0, 15, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Dark Iron Demolitionist - On Aggro - Say Line 0'),
(1054, 0, 1, 0, 0, 0, 100, 0, 0, 0, 3600, 3800, 0, 0, 11, 8858, 64, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Dark Iron Demolitionist - In Combat CMC - Cast \'Bomb\''),
(1054, 0, 2, 0, 0, 0, 100, 512, 1200, 8300, 8200, 20100, 0, 0, 11, 7891, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Dark Iron Demolitionist - In Combat - Cast \'Gift of Ragnaros\''),
(1054, 0, 3, 0, 2, 0, 100, 1, 0, 15, 0, 0, 0, 0, 25, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Dark Iron Demolitionist - Between 0-15% Health - Flee For Assist (No Repeat)'),
(6523, 0, 0, 0, 4, 0, 15, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Dark Iron Rifleman - On Aggro - Say Line 0 (No Repeat)'),
(6523, 0, 1, 0, 0, 0, 100, 0, 0, 0, 2300, 5000, 0, 0, 11, 6660, 64, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Dark Iron Rifleman - In Combat CMC - Cast \'Shoot\''),
(6523, 0, 2, 0, 0, 0, 100, 512, 16100, 16100, 20100, 32200, 0, 0, 11, 7891, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Dark Iron Rifleman - In Combat - Cast \'Gift of Ragnaros\''),
(6523, 0, 3, 0, 2, 0, 100, 1, 0, 15, 0, 0, 0, 0, 25, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Dark Iron Rifleman - Between 0-15% Health - Flee For Assist (No Repeat)');
