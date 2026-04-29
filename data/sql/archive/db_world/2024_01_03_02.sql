-- DB update 2024_01_03_01 -> 2024_01_03_02
--
DELETE FROM `smart_scripts` WHERE `entryorguid` = 18670 AND `source_type` = 0;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(18670, 0, 0, 0, 0, 0, 100, 0, 2000, 4000, 30000, 35000, 0, 0, 11, 32918, 1, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Ironjaw - In Combat - Cast \'Chilling Howl\''),
(18670, 0, 1, 0, 0, 0, 100, 0, 4000, 6000, 4000, 6000, 0, 0, 11, 32919, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Ironjaw - In Combat - Cast \'Snarl\''),
(18670, 0, 2, 0, 0, 0, 100, 0, 8000, 11000, 9000, 11000, 0, 0, 11, 32962, 1, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Ironjaw - In Combat - Cast \'Iron Bite\''),
(18670, 0, 3, 0, 11, 0, 100, 0, 0, 0, 0, 0, 0, 0, 53, 0, 1867000, 1, 0, 0, 2, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Ironjaw - Respawn - Start waypoint movement');

DELETE FROM `creature` WHERE `guid` = 66940 and `id1` = 18670;
INSERT INTO `creature` (`guid`, `id1`, `id2`, `id3`, `map`, `zoneId`, `areaId`, `spawnMask`, `phaseMask`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `wander_distance`, `currentwaypoint`, `curhealth`, `curmana`, `MovementType`, `npcflag`, `unit_flags`, `dynamicflags`, `ScriptName`, `VerifiedBuild`, `CreateObject`, `Comment`) VALUES
(66940, 18670, 0, 0, 530, 0, 0, 1, 1, 0, -2255.6384, 3470.4573, -23.312017, 1.83568, 300, 0, 0, 5715, 0, 0, 0, 0, 0, '', 0, 0, NULL);

DELETE FROM `waypoints` WHERE `entry` = 1867000;
INSERT INTO `waypoints` (`entry`, `pointid`, `position_x`, `position_y`, `position_z`, `orientation`, `delay`, `point_comment`) VALUES
(1867000, 1, -2254.9797, 3456.6707, -22.450056, NULL, 0, 'Ironjaw'),
(1867000, 2, -2260.0933, 3436.6528, -19.26712, NULL, 0, 'Ironjaw'),
(1867000, 3, -2269.3323, 3417.3464, -18.036856, NULL, 0, 'Ironjaw'),
(1867000, 4, -2261.3965, 3401.6484, -19.311249, NULL, 0, 'Ironjaw'),
(1867000, 5, -2241.924, 3399.447, -20.934261, NULL, 0, 'Ironjaw'),
(1867000, 6, -2223.0876, 3399.6868, -22.344685, NULL, 0, 'Ironjaw'),
(1867000, 7, -2212.784, 3398.4434, -25.655071, NULL, 0, 'Ironjaw'),
(1867000, 8, -2203.8513, 3393.8677, -29.047827, NULL, 0, 'Ironjaw'),
(1867000, 9, -2193.1848, 3385.0598, -31.713863, NULL, 0, 'Ironjaw'),
(1867000, 10, -2187.9397, 3375.0015, -31.811998, NULL, 0, 'Ironjaw'),
(1867000, 11, -2188.9473, 3363.0488, -31.13889, NULL, 0, 'Ironjaw'),
(1867000, 12, -2190.2373, 3350.6533, -31.041891, NULL, 0, 'Ironjaw'),
(1867000, 13, -2188.941, 3363.031, -31.168343, NULL, 0, 'Ironjaw'),
(1867000, 14, -2187.9397, 3375.0015, -31.811998, NULL, 0, 'Ironjaw'),
(1867000, 15, -2193.1848, 3385.0598, -31.713863, NULL, 0, 'Ironjaw'),
(1867000, 16, -2203.8513, 3393.8677, -29.047827, NULL, 0, 'Ironjaw'),
(1867000, 17, -2223.0876, 3399.6868, -22.344685, NULL, 0, 'Ironjaw'),
(1867000, 18, -2241.924, 3399.447, -20.934261, NULL, 0, 'Ironjaw'),
(1867000, 19, -2261.3965, 3401.6484, -19.311249, NULL, 0, 'Ironjaw'),
(1867000, 20, -2269.3323, 3417.3464, -18.036856, NULL, 0, 'Ironjaw'),
(1867000, 21, -2260.0933, 3436.6528, -19.26712, NULL, 0, 'Ironjaw'),
(1867000, 22, -2254.9797, 3456.6707, -22.450056, NULL, 0, 'Ironjaw'),
(1867000, 23, -2255.6384, 3470.4573, -23.312017, NULL, 0, 'Ironjaw'),
(1867000, 24, -2264.9858, 3485.0881, -24.062012, NULL, 0, 'Ironjaw'),
(1867000, 25, -2261.0608, 3496.8245, -23.882532, NULL, 0, 'Ironjaw'),
(1867000, 26, -2254.7573, 3518.5947, -25.678585, NULL, 0, 'Ironjaw'),
(1867000, 27, -2256.2546, 3543.88, -22.95422, NULL, 0, 'Ironjaw'),
(1867000, 28, -2260.6467, 3560.1096, -16.475277, NULL, 0, 'Ironjaw'),
(1867000, 29, -2264.5212, 3586.5452, -18.401897, NULL, 0, 'Ironjaw'),
(1867000, 30, -2273.019, 3609.3972, -15.251651, NULL, 0, 'Ironjaw'),
(1867000, 31, -2271.3945, 3641.3662, -9.791668, NULL, 0, 'Ironjaw'),
(1867000, 32, -2273.019, 3609.3972, -15.251651, NULL, 0, 'Ironjaw'),
(1867000, 33, -2264.5212, 3586.5452, -18.401897, NULL, 0, 'Ironjaw'),
(1867000, 34, -2260.6467, 3560.1096, -16.475277, NULL, 0, 'Ironjaw'),
(1867000, 35, -2256.2546, 3543.88, -22.95422, NULL, 0, 'Ironjaw'),
(1867000, 36, -2254.7573, 3518.5947, -25.678585, NULL, 0, 'Ironjaw'),
(1867000, 37, -2261.0608, 3496.8245, -23.882532, NULL, 0, 'Ironjaw'),
(1867000, 38, -2264.9858, 3485.0881, -24.062012, NULL, 0, 'Ironjaw'),
(1867000, 39, -2255.6384, 3470.4573, -23.312017, NULL, 0, 'Ironjaw');
