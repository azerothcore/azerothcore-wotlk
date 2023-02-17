-- DB update 2023_02_17_02 -> 2023_02_17_03
--
DELETE FROM `creature` WHERE `guid`=151928 AND `id1`=18683;
INSERT INTO `creature` (`guid`, `id1`, `map`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `MovementType`) VALUES (151928, 18683, 530, -2797.86, 8371.15, -39.4439, 0.959005, 43200, 2);

DELETE FROM `creature_addon` WHERE (`guid` IN (151928));
INSERT INTO `creature_addon` (`guid`, `path_id`, `mount`, `bytes1`, `bytes2`, `emote`, `visibilityDistanceType`, `auras`) VALUES
(151928, 1519280, 0, 0, 0, 0, 0, '');

DELETE FROM `waypoint_data` WHERE `id` IN (1519280);
INSERT INTO `waypoint_data` (`id`, `point`, `position_x`, `position_y`, `position_z`) VALUES
(1519280, 1, -2797.86, 8371.15, -39.4439),
(1519280, 2, -2769.38, 8427.4, -41.0358),
(1519280, 3, -2745.51, 8451.7, -40.1339),
(1519280, 4, -2719.87, 8475.16, -42.5082),
(1519280, 5, -2646.94, 8516.83, -39.1658),
(1519280, 6, -2569.01, 8520.52, -37.3603),
(1519280, 7, -2537.85, 8512.96, -36.0247),
(1519280, 8, -2521.09, 8506.78, -37.2972),
(1519280, 9, -2433.52, 8462.14, -37.8204),
(1519280, 10, -2395.54, 8415.53, -39.621),
(1519280, 11, -2370.48, 8347.7, -40.1679),
(1519280, 12, -2365.48, 8273.46, -40.3955),
(1519280, 13, -2385.62, 8211.39, -41.404),
(1519280, 14, -2418.92, 8163, -42.0625),
(1519280, 15, -2427.3, 8154, -40.4315),
(1519280, 16, -2436.93, 8143.79, -42.2831),
(1519280, 17, -2533.66, 8092.81, -46.0847),
(1519280, 18, -2620.56, 8092.64, -48.379),
(1519280, 19, -2635.2, 8097.11, -45.711),
(1519280, 20, -2652.55, 8102.41, -47.9662),
(1519280, 21, -2730.78, 8141.86, -48.1224),
(1519280, 22, -2782.87, 8205.79, -47.5376),
(1519280, 23, -2791.14, 8241.92, -45.1802),
(1519280, 24, -2794.04, 8254.55, -46.6515),
(1519280, 25, -2804.39, 8345.89, -40.7947),
(1519280, 26, -2798.9, 8367.5, -39.5606);

DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = 18683);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(18683, 0, 0 , 0, 25, 0, 100, 0, 0, 0, 0, 0, 0, 22, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Voidhunter Yar - On Reset - Set Event Phase 0'),
(18683, 0, 1 , 2, 4, 0, 100, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Voidhunter Yar - On Aggro - Say Line 0'),
(18683, 0, 2 , 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 22, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Voidhunter Yar - On Aggro - Set Event Phase 1'),
(18683, 0, 3 , 4, 8, 1, 100, 0, 0, 2, 0, 0, 0, 11, 34336, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Voidhunter Yar - On Spellhit \'Holy\' - Cast \'Damage Reduction: Holy\' (Phase 1)'),
(18683, 0, 4 , 5, 61, 1, 100, 0, 0, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Voidhunter Yar - On Spellhit \'Holy\' - Say Line 1 (Phase 1)'),
(18683, 0, 5 , 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 22, 2, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Voidhunter Yar - On Spellhit \'Holy\' - Set Event Phase 2 (Phase 1)'),

(18683, 0, 6 , 7, 8, 1, 100, 0, 0, 4, 0, 0, 0, 11, 34333, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Voidhunter Yar - On Spellhit \'Fire\' - Cast \'Damage Reduction: Fire\' (Phase 1)'),
(18683, 0, 7 , 8, 61, 1, 100, 0, 0, 0, 0, 0, 0, 1, 2, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Voidhunter Yar - On Spellhit \'Fire\' - Say Line 2 (Phase 1)'),
(18683, 0, 8 , 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 22, 3, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Voidhunter Yar - On Spellhit \'Fire\' - Set Event Phase 3 (Phase 1)'),

(18683, 0, 9 , 10, 8, 1, 100, 0, 0, 8, 0, 0, 0, 11, 34335, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Voidhunter Yar - On Spellhit \'Nature\' - Cast \'Damage Reduction: Nature\' (Phase 1)'),
(18683, 0, 10, 11, 61, 1, 100, 0, 0, 0, 0, 0, 0, 1, 3, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Voidhunter Yar - On Spellhit \'Nature\' - Say Line 3 (Phase 1)'),
(18683, 0, 11, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 22, 4, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Voidhunter Yar - On Spellhit \'Nature\' - Set Event Phase 4 (Phase 1)'),

(18683, 0, 12, 13, 8, 1, 100, 0, 0, 16, 0, 0, 0, 11, 34334, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Voidhunter Yar - On Spellhit \'Frost\' - Cast \'Damage Reduction: Frost\' (Phase 1)'),
(18683, 0, 13, 14, 61, 1, 100, 0, 0, 0, 0, 0, 0, 1, 4, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Voidhunter Yar - On Spellhit \'Frost\' - Say Line 4 (Phase 1)'),
(18683, 0, 14, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 22, 5, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Voidhunter Yar - On Spellhit \'Frost\' - Set Event Phase 5 (Phase 1)'),

(18683, 0, 15, 16, 8, 1, 100, 0, 0, 32, 0, 0, 0, 11, 34338, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Voidhunter Yar - On Spellhit \'Shadow\' - Cast \'Damage Reduction: Shadow\' (Phase 1)'),
(18683, 0, 16, 17, 61, 1, 100, 0, 0, 0, 0, 0, 0, 1, 5, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Voidhunter Yar - On Spellhit \'Shadow\' - Say Line 5 (Phase 1)'),
(18683, 0, 17, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 22, 6, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Voidhunter Yar - On Spellhit \'Shadow\' - Set Event Phase 6 (Phase 1)'),

(18683, 0, 18, 19, 8, 1, 100, 0, 0, 64, 0, 0, 0, 11, 34331, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Voidhunter Yar - On Spellhit \'Arcane\' - Cast \'Damage Reduction: Arcane\' (Phase 1)'),
(18683, 0, 19, 20, 61, 1, 100, 0, 0, 0, 0, 0, 0, 1, 6, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Voidhunter Yar - On Spellhit \'Arcane\' - Say Line 6 (Phase 1)'),
(18683, 0, 20, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 22, 7, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Voidhunter Yar - On Spellhit \'Arcane\' - Set Event Phase 7 (Phase 1)'),

(18683, 0, 21, 0, 9, 0, 100, 0, 0, 30, 14300, 28200, 0, 11, 38051, 64, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Voidhunter Yar - Within 0-30 Range - Cast \'Fel Shackles\''),
(18683, 0, 22, 0, 0, 33, 100, 0, 0, 1000, 3000, 3500, 0, 11, 12471, 64, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Voidhunter Yar - In Combat - Cast \'Shadow Bolt\' (Phases 1 & 6)'),
(18683, 0, 23, 0, 0, 2, 100, 0, 0, 1000, 2500, 3000, 0, 11, 15498, 64, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Voidhunter Yar - In Combat - Cast \'Holy Smite\' (Phase 2)'),
(18683, 0, 24, 0, 0, 4, 100, 0, 0, 1000, 3000, 3500, 0, 11, 14034, 64, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Voidhunter Yar - In Combat - Cast \'Fireball\' (Phase 3)'),
(18683, 0, 25, 0, 0, 8, 100, 0, 0, 1000, 3000, 3500, 0, 11, 12167, 64, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Voidhunter Yar - In Combat - Cast \'Lightning Bolt\' (Phase 4)'),
(18683, 0, 26, 0, 0, 16, 100, 0, 0, 1000, 3000, 3500, 0, 11, 15497, 64, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Voidhunter Yar - In Combat - Cast \'Frostbolt\' (Phase 5)'),
(18683, 0, 27, 0, 0, 64, 100, 0, 0, 1000, 1000, 1500, 0, 11, 38204, 64, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Voidhunter Yar - In Combat - Cast \'Arcane Bolt\' (Phase 7)');

DELETE FROM `smart_scripts` WHERE (`source_type` = 9 AND `entryorguid` BETWEEN 1868300 AND 1868302);

DELETE FROM `creature_text` WHERE `CreatureID`=18683;
INSERT INTO `creature_text` (`CreatureID`, `BroadcastTextId`, `GroupID`, `ID`, `Text`, `Type`, `comment`) VALUES
(18683, 19908, 0, 0, 'In the void, no one can hear you scream!', 12, 'Voidhunter Yar'),
(18683, 17110, 1, 0, '%s absorbs the holy energy of the attack.', 16, 'Voidhunter Yar'),
(18683, 17105, 2, 0, '%s absorbs the fire energy of the attack.', 16, 'Voidhunter Yar'),
(18683, 17107, 3, 0, '%s absorbs the nature energy of the attack.', 16, 'Voidhunter Yar'),
(18683, 17106, 4, 0, '%s absorbs the frost energy of the attack.', 16, 'Voidhunter Yar'),
(18683, 17108, 5, 0, '%s absorbs the shadow energy of the attack.', 16, 'Voidhunter Yar'),
(18683, 17109, 6, 0, '%s absorbs the arcane energy of the attack.', 16, 'Voidhunter Yar');
