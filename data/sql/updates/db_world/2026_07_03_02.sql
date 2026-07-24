-- DB update 2026_07_03_01 -> 2026_07_03_02

-- Set Waypoints for Faceless Horrors.
DELETE FROM `waypoint_data` WHERE (`id` IN (3377200, 3377201));
INSERT INTO `waypoint_data` (`id`,  `point`, `position_x`, `position_y`, `position_z`, `orientation`, `delay`, `move_type`, `action`, `action_chance`, `wpguid`) VALUES
(3377200, 1, 1886.188, 107.48373, 342.37335, NULL, 0, 0, 0, 100, 0),
(3377200, 2, 1886.7223, 120.5408, 342.3719, NULL, 0, 0, 0, 100, 0),
(3377200, 3, 1886.8156, 134.46463, 342.37085, NULL, 0, 0, 0, 100, 0),
(3377200, 4, 1888.1178, 143.8164, 342.37057, NULL, 0, 0, 0, 100, 0),
(3377200, 5, 1887.1298, 153.88455, 342.33286, NULL, 0, 0, 0, 100, 0),
(3377200, 6, 1888.1178, 143.8164, 342.37057, NULL, 0, 0, 0, 100, 0),
(3377200, 7, 1886.8156, 134.46463, 342.37085, NULL, 0, 0, 0, 100, 0),
(3377200, 8, 1886.7223, 120.5408, 342.3719, NULL, 0, 0, 0, 100, 0),
(3377200, 9, 1886.188, 107.48373, 342.37335, NULL, 0, 0, 0, 100, 0),
(3377200, 10, 1885.7902, 91.22374, 342.37567, NULL, 0, 0, 0, 100, 0),
(3377201, 1, 1823.2712, 91.90994, 342.36737, NULL, 0, 0, 0, 100, 0),
(3377201, 2, 1823.6024, 104.29818, 342.36746, NULL, 0, 0, 0, 100, 0),
(3377201, 3, 1823.3774, 114.79731, 342.36743, NULL, 0, 0, 0, 100, 0),
(3377201, 4, 1822.0591, 124.32639, 342.36743, NULL, 0, 0, 0, 100, 0),
(3377201, 5, 1820.3103, 134.21745, 342.36743, NULL, 0, 0, 0, 100, 0),
(3377201, 6, 1819.5613, 143.90105, 341.98083, NULL, 0, 0, 0, 100, 0),
(3377201, 7, 1811.4867, 156.7908, 342.3759, NULL, 0, 0, 0, 100, 0),
(3377201, 8, 1819.5613, 143.90105, 341.98083, NULL, 0, 0, 0, 100, 0),
(3377201, 9, 1820.3005, 134.3439, 342.34927, NULL, 0, 0, 0, 100, 0),
(3377201, 10, 1822.0591, 124.32639, 342.36743, NULL, 0, 0, 0, 100, 0),
(3377201, 11, 1823.3774, 114.79731, 342.36743, NULL, 0, 0, 0, 100, 0),
(3377201, 12, 1823.6024, 104.29818, 342.36746, NULL, 0, 0, 0, 100, 0),
(3377201, 13, 1823.2712, 91.90994, 342.36737, NULL, 0, 0, 0, 100, 0),
(3377201, 14, 1821.7439, 76.43424, 342.28693, NULL, 0, 0, 0, 100, 0);

-- Remove Enslaved Fire Elemental Spawn Points (They are summoned).
DELETE FROM `creature` WHERE `id` = 33838;

-- Set Twilight Shadowblade Spawn Mask to 10M (Changed with Twilight Slayer in 25M)
UPDATE `creature` SET `spawnMask` = 1 WHERE (`id` = 33824) AND (`guid` IN (137555));

-- Add New Spawn Points for 25M
DELETE FROM `creature` WHERE (`id` = 33818) AND (`guid` IN (137584, 137563, 137580));
INSERT INTO `creature` (`guid`, `id`, `map`, `zoneId`, `areaId`, `spawnMask`, `phaseMask`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `wander_distance`, `currentwaypoint`, `curhealth`, `curmana`, `MovementType`, `npcflag`, `unit_flags`, `dynamicflags`, `ScriptName`, `Comment`, `VerifiedBuild`) VALUES
(137584, 33818, 603, 0, 0, 2, 1, 1, 1890.6997, 114.88368, 342.4624, 3.865213, 604800, 0, 0, 337025, 16676, 0, 0, 0, 0, '', NULL, 0),
(137563, 33818, 603, 0, 0, 2, 1, 1, 1790.974, 117.00868, 342.46304, 5.760353, 604800, 0, 0, 337025, 33352, 0, 0, 0, 0, '', NULL, 0),
(137580, 33818, 603, 0, 0, 2, 1, 1, 1837.0955, 117.03646, 341.80624, 5.12695, 604800, 0, 0, 337025, 33352, 0, 0, 0, 0, '', NULL, 0);

DELETE FROM `creature` WHERE (`id` = 33819) AND (`guid` IN (137585));
INSERT INTO `creature` (`guid`, `id`, `map`, `zoneId`, `areaId`, `spawnMask`, `phaseMask`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `wander_distance`, `currentwaypoint`, `curhealth`, `curmana`, `MovementType`, `npcflag`, `unit_flags`, `dynamicflags`, `ScriptName`, `Comment`, `VerifiedBuild`) VALUES
(137585, 33819, 603, 0, 0, 2, 1, 1, 1886.5798, 122.2934, 342.46188, 4.02191, 604800, 0, 0, 337025, 16676, 0, 0, 0, 0, '', NULL, 0);

DELETE FROM `creature` WHERE (`id` = 33820) AND (`guid` IN (137565, 137583));
INSERT INTO `creature` (`guid`, `id`, `map`, `zoneId`, `areaId`, `spawnMask`, `phaseMask`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `wander_distance`, `currentwaypoint`, `curhealth`, `curmana`, `MovementType`, `npcflag`, `unit_flags`, `dynamicflags`, `ScriptName`, `Comment`, `VerifiedBuild`) VALUES
(137565, 33820, 603, 0, 0, 2, 1, 1, 1795.5156, 123.29862, 342.46118, 5.65139, 604800, 0, 0, 337025, 29183, 0, 0, 0, 0, '', NULL, 0),
(137583, 33820, 603, 0, 0, 2, 1, 1, 1836.4618, 126.34028, 341.73795, 5.060676, 604800, 0, 0, 337025, 29183, 0, 0, 0, 0, '', NULL, 0);

DELETE FROM `creature` WHERE (`id` = 33822) AND (`guid` IN (137587, 137562, 137564, 137582));
INSERT INTO `creature` (`guid`, `id`, `map`, `zoneId`, `areaId`, `spawnMask`, `phaseMask`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `wander_distance`, `currentwaypoint`, `curhealth`, `curmana`, `MovementType`, `npcflag`, `unit_flags`, `dynamicflags`, `ScriptName`, `Comment`, `VerifiedBuild`) VALUES
(137587, 33822, 603, 0, 0, 2, 1, 1, 1878.41, 120.502, 342.461, 4.13243, 604800, 0, 0, 471835, 0, 0, 0, 0, 0, '', NULL, 0),
(137562, 33822, 603, 0, 0, 2, 1, 1, 1904.4963, 136.01367, 412.3273, 4.660028, 604800, 0, 0, 471835, 0, 0, 0, 0, 0, '', NULL, 0),
(137564, 33822, 603, 0, 0, 2, 1, 1, 1783.4427, 118.73959, 342.4641, 5.789062, 604800, 0, 0, 471835, 0, 0, 0, 0, 0, '', NULL, 0),
(137582, 33822, 603, 0, 0, 2, 1, 1, 1850.5469, 118.33334, 341.93735, 4.772871, 604800, 0, 0, 471835, 0, 0, 0, 0, 0, '', NULL, 0);

DELETE FROM `creature` WHERE (`id` = 33823) AND (`guid` IN (137560, 137586));
INSERT INTO `creature` (`guid`, `id`, `map`, `zoneId`, `areaId`, `spawnMask`, `phaseMask`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `wander_distance`, `currentwaypoint`, `curhealth`, `curmana`, `MovementType`, `npcflag`, `unit_flags`, `dynamicflags`, `ScriptName`, `Comment`, `VerifiedBuild`) VALUES
(137560, 33823, 603, 0, 0, 2, 1, 1, 1895.8071, 127.51064, 412.32733, 4.886921, 604800, 0, 0, 471835, 0, 0, 0, 0, 0, '', NULL, 0),
(137586, 33823, 603, 0, 0, 2, 1, 1, 1890.151, 130.48264, 342.46286, 4.061835, 604800, 0, 0, 471835, 0, 0, 0, 0, 0, '', NULL, 0);

DELETE FROM `creature` WHERE (`id` = 33824) AND (`guid` IN (137561));
INSERT INTO `creature` (`guid`, `id`, `map`, `zoneId`, `areaId`, `spawnMask`, `phaseMask`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `wander_distance`, `currentwaypoint`, `curhealth`, `curmana`, `MovementType`, `npcflag`, `unit_flags`, `dynamicflags`, `ScriptName`, `Comment`, `VerifiedBuild`) VALUES
(137561, 33824, 603, 0, 0, 2, 1, 1, 1910.7513, 127.25326, 412.3273, 4.223696, 604800, 0, 0, 337025, 0, 0, 0, 0, 0, '', NULL, 0);

-- Set Extra Flag Don't Override SAI (including difficulty_entry_1)
UPDATE `creature_template` SET `flags_extra` = `flags_extra` |134217728 WHERE (`entry` IN (33818, 33819, 33820, 33822, 33823, 33824, 33827, 33828, 33829, 33830, 33831, 33832, 33772, 33773));

-- Update Twilight Pyromancer SAI.
UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 33820;

DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = 33820);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(33820, 0, 0, 0, 0, 0, 100, 0, 6000, 10000, 15000, 25000, 0, 0, 11, 64663, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Twilight Pyromancer - In Combat - Cast \'Arcane Burst\''),
(33820, 0, 1, 0, 0, 0, 100, 0, 1000, 2000, 3000, 3500, 0, 0, 11, 63789, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Twilight Pyromancer - In Combat - Cast \'Fireball\''),
(33820, 0, 2, 0, 0, 0, 100, 0, 5000, 10000, 15000, 20000, 0, 0, 11, 63775, 0, 0, 0, 0, 0, 6, 0, 0, 0, 0, 0, 0, 0, 0, 'Twilight Pyromancer - In Combat - Cast \'Flamestrike\''),
(33820, 0, 3, 0, 25, 0, 100, 0, 0, 0, 0, 0, 0, 0, 11, 63774, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Twilight Pyromancer - On Reset - Cast \'Summon Fire Elemental\'');

-- Set Personal SAIs.
DELETE FROM `smart_scripts` WHERE (`source_type` = 0) AND (`entryorguid` IN (-137551, -137553, -137582, -137587));
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(-137551, 0, 3, 0, 6, 0, 100, 0, 0, 0, 0, 0, 0, 0, 242, 1, 1, 0, 0, 0, 0, 10, 137566, 33772, 0, 0, 0, 0, 0, 0, 'Twilight Guardian - On Just Died - Increment Field 1 By 1'),
(-137587, 0, 3, 0, 6, 0, 100, 0, 0, 0, 0, 0, 0, 0, 242, 1, 1, 0, 0, 0, 0, 10, 137566, 33772, 0, 0, 0, 0, 0, 0, 'Twilight Guardian - On Just Died - Increment Field 1 By 1'),
(-137553, 0, 3, 0, 6, 0, 100, 0, 0, 0, 0, 0, 0, 0, 242, 1, 1, 0, 0, 0, 0, 10, 137568, 33772, 0, 0, 0, 0, 0, 0, 'Twilight Guardian - On Just Died - Increment Field 1 By 1'),
(-137582, 0, 3, 0, 6, 0, 100, 0, 0, 0, 0, 0, 0, 0, 242, 1, 1, 0, 0, 0, 0, 10, 137568, 33772, 0, 0, 0, 0, 0, 0, 'Twilight Guardian - On Just Died - Increment Field 1 By 1');

DELETE FROM `smart_scripts` WHERE (`source_type` = 0) AND (`entryorguid` IN (-137548, -137549, -137583));
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(-137548, 0, 4, 0, 6, 0, 100, 0, 0, 0, 0, 0, 0, 0, 242, 1, 1, 0, 0, 0, 0, 10, 137566, 33772, 0, 0, 0, 0, 0, 0, 'Twilight Pyromancer - On Just Died - Increment Field 1 By 1'),
(-137549, 0, 4, 0, 6, 0, 100, 0, 0, 0, 0, 0, 0, 0, 242, 1, 1, 0, 0, 0, 0, 10, 137568, 33772, 0, 0, 0, 0, 0, 0, 'Twilight Pyromancer - On Just Died - Increment Field 1 By 1'),
(-137583, 0, 4, 0, 6, 0, 100, 0, 0, 0, 0, 0, 0, 0, 242, 1, 1, 0, 0, 0, 0, 10, 137568, 33772, 0, 0, 0, 0, 0, 0, 'Twilight Pyromancer - On Just Died - Increment Field 1 By 1');

DELETE FROM `smart_scripts` WHERE (`source_type` = 0) AND (`entryorguid` IN (-137555));
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(-137555, 0, 2, 0, 6, 0, 100, 0, 0, 0, 0, 0, 0, 0, 242, 1, 1, 0, 0, 0, 0, 10, 137566, 33772, 0, 0, 0, 0, 0, 0, 'Twilight Shadowblade - On Just Died - Increment Field 1 By 1');

DELETE FROM `smart_scripts` WHERE (`source_type` = 0) AND (`entryorguid` IN (-137544, -137545, -137546, -137585));
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(-137544, 0, 4, 0, 6, 0, 100, 0, 0, 0, 0, 0, 0, 0, 242, 1, 1, 0, 0, 0, 0, 10, 137566, 33772, 0, 0, 0, 0, 0, 0, 'Twilight Frost Mage - On Just Died - Increment Field 1 By 1'),
(-137545, 0, 4, 0, 6, 0, 100, 0, 0, 0, 0, 0, 0, 0, 242, 1, 1, 0, 0, 0, 0, 10, 137568, 33772, 0, 0, 0, 0, 0, 0, 'Twilight Frost Mage - On Just Died - Increment Field 1 By 1'),
(-137546, 0, 4, 0, 6, 0, 100, 0, 0, 0, 0, 0, 0, 0, 242, 1, 1, 0, 0, 0, 0, 10, 137568, 33772, 0, 0, 0, 0, 0, 0, 'Twilight Frost Mage - On Just Died - Increment Field 1 By 1'),
(-137585, 0, 4, 0, 6, 0, 100, 0, 0, 0, 0, 0, 0, 0, 242, 1, 1, 0, 0, 0, 0, 10, 137566, 33772, 0, 0, 0, 0, 0, 0, 'Twilight Frost Mage - On Just Died - Increment Field 1 By 1');

DELETE FROM `smart_scripts` WHERE (`source_type` = 0) AND (`entryorguid` IN (-137539, -137541, -137584, -137580));
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(-137539, 0, 4, 0, 6, 0, 100, 0, 0, 0, 0, 0, 0, 0, 242, 1, 1, 0, 0, 0, 0, 10, 137566, 33772, 0, 0, 0, 0, 0, 0, 'Twilight Adherent - On Just Died - Increment Field 1 By 1'),
(-137541, 0, 4, 0, 6, 0, 100, 0, 0, 0, 0, 0, 0, 0, 242, 1, 1, 0, 0, 0, 0, 10, 137568, 33772, 0, 0, 0, 0, 0, 0, 'Twilight Adherent - On Just Died - Increment Field 1 By 1'),
(-137584, 0, 4, 0, 6, 0, 100, 0, 0, 0, 0, 0, 0, 0, 242, 1, 1, 0, 0, 0, 0, 10, 137566, 33772, 0, 0, 0, 0, 0, 0, 'Twilight Adherent - On Just Died - Increment Field 1 By 1'),
(-137580, 0, 4, 0, 6, 0, 100, 0, 0, 0, 0, 0, 0, 0, 242, 1, 1, 0, 0, 0, 0, 10, 137568, 33772, 0, 0, 0, 0, 0, 0, 'Twilight Adherent - On Just Died - Increment Field 1 By 1');

DELETE FROM `smart_scripts` WHERE (`source_type` = 0) AND (`entryorguid` IN (-137586));
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(-137586, 0, 2, 0, 6, 0, 100, 0, 0, 0, 0, 0, 0, 0, 242, 1, 1, 0, 0, 0, 0, 10, 137566, 33772, 0, 0, 0, 0, 0, 0, 'Twilight Slayer - On Just Died - Increment Field 1 By 1');

-- Set Personal SAI (Faceless Horrors).
DELETE FROM `smart_scripts` WHERE (`source_type` = 0) AND (`entryorguid` IN (-137566, -137568));
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(-137566, 0, 6, 0, 38, 0, 100, 2, 1, 5, 0, 0, 0, 0, 232, 3377200, 1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Faceless Horror - On Data Set 1 5 - Start Path 3377200 (Normal Dungeon)'),
(-137566, 0, 7, 0, 38, 0, 100, 4, 1, 8, 0, 0, 0, 0, 232, 3377200, 1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Faceless Horror - On Data Set 1 8 - Start Path 3377200 (Heroic Dungeon)'),
(-137568, 0, 6, 0, 38, 0, 100, 2, 1, 5, 0, 0, 0, 0, 232, 3377201, 1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Faceless Horror - On Data Set 1 5 - Start Path 3377201 (Normal Dungeon)'),
(-137568, 0, 7, 0, 38, 0, 100, 4, 1, 8, 0, 0, 0, 0, 232, 3377201, 1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Faceless Horror - On Data Set 1 8 - Start Path 3377201 (Heroic Dungeon)');
