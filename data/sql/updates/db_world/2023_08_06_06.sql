-- DB update 2023_08_06_05 -> 2023_08_06_06
-- Verog the Dervish
DELETE FROM `smart_scripts` WHERE `entryorguid` = 3395 AND `source_type` = 0;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(3395, 0, 0, 0, 1, 0, 100, 1, 4000, 4000, 0, 0, 0, 53, 0, 3395, 0, 0, 300000, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Verog the Dervish - Out of Combat - Start Waypoint Movement (No Repeat)'),
(3395, 0, 1, 0, 40, 0, 100, 1, 3, 3395, 0, 0, 0, 66, 0, 0, 0, 0, 0, 0, 8, 0, 0, 0, 0, 0, 0, 0, 0, 'Verog the Dervish - On WP reached - Set Orientation (No Repeat)'),
(3395, 0, 2, 0, 11, 0, 100, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Verog the Dervish - On Respawn - Say Line 0 (No Repeat)');

-- wp data (sniffed only final orientation is wrong)
DELETE FROM `waypoints` WHERE `entry` = 3395;
INSERT INTO `waypoints` (`entry`, `pointid`, `position_x`, `position_y`, `position_z`, `orientation`, `delay`, `point_comment`) VALUES
(3395, 1, -1209.9082, -2731.1567, 105.875336, NULL, 0, 'Verog the Dervish'),
(3395, 2, -1209.5896, -2736.3755, 103.212364, NULL, 0, 'Verog the Dervish'),
(3395, 3, -1209.0471, -2739.1501, 102.66668, NULL, 0, 'Verog the Dervish');

-- summons (sniffed position)
DELETE FROM `smart_scripts` WHERE `entryorguid` IN (3274, 3275, 3397) AND `source_type` = 0;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(3274, 0, 0, 0, 4, 0, 100, 0, 0, 0, 0, 0, 0, 11, 9128, 32, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Kolkar Pack Runner - On Aggro - Cast \'Battle Shout\' (No Repeat)'),
(3274, 0, 1, 2, 6, 0, 3, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Kolkar Pack Runner - On Just Died - Say Line 0'),
(3274, 0, 2, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 12, 3395, 4, 300000, 0, 0, 0, 8, 0, 0, 0, 0, -1210.5857, -2725.839, 106.782524, 4.956735134124755859, 'Kolkar Pack Runner - On Just Died - Summon Creature \'Verog the Dervish\''),(3275, 0, 0, 0, 0, 0, 80, 0, 12000, 12000, 7000, 7000, 0, 11, 11976, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Kolkar Marauder - In Combat - Cast \'Strike\''),
(3275, 0, 1, 2, 6, 0, 3, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Kolkar Marauder - On Just Died - Say Line 0'),
(3275, 0, 2, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 12, 3395, 4, 300000, 0, 0, 0, 8, 0, 0, 0, 0, -1210.5857, -2725.839, 106.782524, 4.956735134124755859, 'Kolkar Marauder - On Just Died - Summon Creature \'Verog the Dervish\''),
(3397, 0, 0, 0, 0, 0, 100, 0, 35000, 35000, 10000, 10000, 0, 11, 6742, 32, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Kolkar Bloodcharger - In Combat - Cast \'Bloodlust\' (No Repeat)'),
(3397, 0, 1, 0, 0, 0, 100, 0, 20000, 20000, 5000, 5000, 0, 11, 172, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Kolkar Bloodcharger - In Combat - Cast \'Corruption\' (No Repeat)'),
(3397, 0, 2, 3, 6, 0, 3, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Kolkar Bloodcharger - On Just Died - Say Line 0'),
(3397, 0, 3, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 12, 3395, 4, 300000, 0, 0, 0, 8, 0, 0, 0, 0, -1210.5857, -2725.839, 106.782524, 4.956735134124755859, 'Kolkar Bloodcharger - On Just Died - Summon Creature \'Verog the Dervish\'');
