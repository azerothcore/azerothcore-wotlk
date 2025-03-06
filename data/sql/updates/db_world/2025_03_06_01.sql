-- DB update 2025_03_06_00 -> 2025_03_06_01

-- Add Waypoints
DELETE FROM `waypoint_data` WHERE `id` IN (4423900);
INSERT INTO `waypoint_data` (`id`, `point`, `position_x`, `position_y`, `position_z`, `orientation`, `delay`, `move_type`, `action`, `action_chance`, `wpguid`) VALUES
(4423900, 1, 1635.8063, 575.30365, 85.0778, NULL, 0, 0, 0, 100, 0),
(4423900, 2, 1639.5123, 564.78186, 85.198586, NULL, 0, 0, 0, 100, 0),
(4423900, 3, 1650.0547, 555.85724, 85.20367, NULL, 0, 0, 0, 100, 0),
(4423900, 4, 1657.5857, 554.2899, 85.18, NULL, 0, 0, 0, 100, 0),
(4423900, 5, 1662.7603, 559.59985, 85.11729, NULL, 0, 0, 0, 100, 0),
(4423900, 6, 1664.86, 566.5109, 85.05131, NULL, 0, 0, 0, 100, 0),
(4423900, 7, 1655.7408, 569.426, 85.08148, NULL, 0, 0, 0, 100, 0),
(4423900, 8, 1646.7535, 573.262, 85.10842, NULL, 0, 0, 0, 100, 0),
(4423900, 9, 1639.7854, 581.71625, 85.07026, NULL, 0, 0, 0, 100, 0),
(4423900, 10, 1635.8188, 591.16565, 84.986694, NULL, 0, 0, 0, 100, 0),
(4423900, 11, 1623.7385, 598.2011, 84.98328, NULL, 0, 0, 0, 100, 0),
(4423900, 12, 1622.1783, 582.6476, 84.93455, NULL, 0, 0, 0, 100, 0);

DELETE FROM `waypoint_data` WHERE `id` IN (4417500);
INSERT INTO `waypoint_data` (`id`, `point`, `position_x`, `position_y`, `position_z`, `orientation`, `delay`, `move_type`, `action`, `action_chance`, `wpguid`) VALUES
(4417500, 1, 1598.2391, 607.8877, 85.17859, NULL, 0, 0, 0, 100, 0),
(4417500, 2, 1606.8851, 597.20966, 85.035416, NULL, 0, 0, 0, 100, 0),
(4417500, 3, 1626.3141, 598.7418, 84.977554, NULL, 0, 0, 0, 100, 0),
(4417500, 4, 1626.666, 609.6, 85.03905, NULL, 0, 0, 0, 100, 0),
(4417500, 5, 1619.9382, 614.392, 85.08983, NULL, 0, 0, 0, 100, 0),
(4417500, 6, 1616.4453, 624.93243, 85.0162, NULL, 0, 0, 0, 100, 0),
(4417500, 7, 1607.1102, 624.23157, 85.0806, NULL, 0, 0, 0, 100, 0),
(4417500, 8, 1600.872, 617.4745, 85.17309, NULL, 0, 0, 0, 100, 0);

DELETE FROM `waypoint_data` WHERE `id` IN (4437300);
INSERT INTO `waypoint_data` (`id`, `point`, `position_x`, `position_y`, `position_z`, `orientation`, `delay`, `move_type`, `action`, `action_chance`, `wpguid`) VALUES
(4437300, 1, 1574.3845, 568.83575, 50.581684, NULL, 0, 0, 0, 100, 0),
(4437300, 2, 1581.9055, 556.647, 50.56439, NULL, 0, 0, 0, 100, 0),
(4437300, 3, 1594.0778, 542.8933, 50.56443, NULL, 0, 0, 0, 100, 0),
(4437300, 4, 1606.6469, 532.18286, 50.562378, NULL, 0, 0, 0, 100, 0),
(4437300, 5, 1619.2439, 522.1746, 50.562378, NULL, 0, 0, 0, 100, 0),
(4437300, 6, 1628.4052, 510.94202, 50.56238, NULL, 0, 0, 0, 100, 0),
(4437300, 7, 1637.5718, 504.4476, 50.562378, NULL, 0, 0, 0, 100, 0),
(4437300, 8, 1645.4747, 505.8146, 50.56238, NULL, 0, 0, 0, 100, 0),
(4437300, 9, 1639.2903, 514.03033, 50.56238, NULL, 0, 0, 0, 100, 0),
(4437300, 10, 1623.4856, 525.23193, 50.562378, NULL, 0, 0, 0, 100, 0),
(4437300, 11, 1614.4045, 529.077, 50.562378, NULL, 0, 0, 0, 100, 0),
(4437300, 12, 1600.4586, 541.8103, 50.562866, NULL, 0, 0, 0, 100, 0),
(4437300, 13, 1591.9607, 552.0348, 50.564407, NULL, 0, 0, 0, 100, 0),
(4437300, 14, 1595.747, 562.1494, 50.561386, NULL, 0, 0, 0, 100, 0),
(4437300, 15, 1601.4442, 576.96, 50.58388, NULL, 0, 0, 0, 100, 0),
(4437300, 16, 1599.3601, 587.71423, 50.86386, NULL, 0, 0, 0, 100, 0),
(4437300, 17, 1598.5406, 593.38184, 50.63166, NULL, 0, 0, 0, 100, 0),
(4437300, 18, 1597.1101, 600.21423, 50.86386, NULL, 0, 0, 0, 100, 0),
(4437300, 19, 1596.6749, 601.2044, 50.645096, NULL, 0, 0, 0, 100, 0),
(4437300, 20, 1581.5574, 593.8716, 50.650696, NULL, 0, 0, 0, 100, 0),
(4437300, 21, 1572.9338, 582.4934, 50.615257, NULL, 0, 0, 0, 100, 0);

-- Remove Comment (Guid SmartAI must be removed)
UPDATE `creature` SET `Comment` = NULL WHERE (`guid` = 44268) AND (`id1` = 25484);

-- Remove SmartAI from Guid
DELETE FROM `smart_scripts` WHERE (`entryorguid` = -44268) AND (`source_type` = 0);

-- Remove Timed Action List
DELETE FROM `smart_scripts` WHERE (`entryorguid` = 2548400) AND (`source_type` = 9);

-- Remove Wrong Assassins
DELETE FROM `creature` WHERE (`id1` = 25484) AND (`guid` IN (44059, 44079, 44358, 44050, 44148, 44279));

-- Remove aura from Assassins
UPDATE `creature_template_addon` SET `auras` = '' WHERE (`entry` = 25484);

-- Delete assassin from Linked Respawn
DELETE FROM `linked_respawn` WHERE (`guid` IN (44050, 44148, 44279));

-- Shadowsword Vanquisher
DELETE FROM `creature` WHERE (`id1` = 25486) AND (`guid` IN (44059, 44079));
INSERT INTO `creature` (`guid`, `id1`, `id2`, `id3`, `map`, `zoneId`, `areaId`, `spawnMask`, `phaseMask`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `wander_distance`, `currentwaypoint`, `curhealth`, `curmana`, `MovementType`, `npcflag`, `unit_flags`, `dynamicflags`, `ScriptName`, `VerifiedBuild`) VALUES
(44059, 25486, 0, 0, 580, 0, 0, 1, 1, 1, 1793.9098, 593.62085, 50.79819, 5.51524, 604800, 0, 0, 227630, 0, 0, 0, 0, 0, '', 0),
(44079, 25486, 0, 0, 580, 0, 0, 1, 1, 1, 1812.6184, 586.0417, 50.798874, 5.51524, 604800, 0, 0, 227630, 0, 0, 0, 0, 0, '', 0);

-- Shadowsword Manafiend
DELETE FROM `creature` WHERE (`id1` = 25483) AND (`guid` IN (44358));
INSERT INTO `creature` (`guid`, `id1`, `id2`, `id3`, `map`, `zoneId`, `areaId`, `spawnMask`, `phaseMask`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `wander_distance`, `currentwaypoint`, `curhealth`, `curmana`, `MovementType`, `npcflag`, `unit_flags`, `dynamicflags`, `ScriptName`, `VerifiedBuild`) VALUES
(44358, 25483, 0, 0, 580, 0, 0, 1, 1, 1, 1817.5476, 593.4289, 50.8023, 4.04916, 604800, 0, 0, 227630, 30694, 0, 0, 0, 0, '', 0);

-- Shadowsword Assassins
UPDATE `creature` SET `position_x` = 1797.8773, `position_y` = 599.92163, `position_z` = 50.797134, `orientation` = 4.93928, `wander_distance` = 0, `MovementType` = 0 WHERE (`id1` = 25484) AND (`guid` IN (44268));
UPDATE `creature` SET `position_x` = 1767.5134, `position_y` = 567.4114, `position_z` = 85.28456, `orientation` = 2.53072, `wander_distance` = 0, `MovementType` = 0 WHERE (`id1` = 25484) AND (`guid` IN (44061));
UPDATE `creature` SET `position_x` = 1622.1783, `position_y` = 582.6476, `position_z` = 84.93455, `orientation` = 6.07799, `wander_distance` = 0, `MovementType` = 2 WHERE (`id1` = 25484) AND (`guid` IN (44239));
UPDATE `creature` SET `position_x` = 1600.872, `position_y` = 617.4745, `position_z` = 85.17309, `orientation` = 4.85612, `wander_distance` = 0, `MovementType` = 2 WHERE (`id1` = 25484) AND (`guid` IN (44175));
UPDATE `creature` SET `position_x` = 1572.9338, `position_y` = 582.4934, `position_z` = 50.615257, `orientation` = 4.9974, `wander_distance` = 0, `MovementType` = 2 WHERE (`id1` = 25484) AND (`guid` IN (44373));

DELETE FROM `creature_addon` WHERE (`guid` IN (44061, 44239, 44175, 44373));
INSERT INTO `creature_addon` (`guid`, `path_id`, `mount`, `bytes1`, `bytes2`, `emote`, `visibilityDistanceType`, `auras`) VALUES
(44061, 0, 0, 1, 0, 0, 0, NULL),
(44239, 4423900, 0, 0, 0, 0, 0, NULL),
(44175, 4417500, 0, 0, 0, 0, 0, NULL),
(44373, 4437300, 0, 0, 0, 0, 0, NULL);

-- Shadowsword Vanquisher (Comments)
UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 25486;

DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = 25486);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(25486, 0, 0, 0, 0, 0, 100, 0, 2000, 5000, 7000, 18000, 0, 0, 11, 46468, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Shadowsword Vanquisher - In Combat - Cast \'Cleave\''),
(25486, 0, 1, 0, 0, 0, 100, 0, 8000, 10000, 17000, 28000, 0, 0, 11, 46469, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Shadowsword Vanquisher - In Combat - Cast \'Melt Armor\'');

-- Shadowsword Manafiend (Comments)
UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 25483;

DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = 25483);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(25483, 0, 0, 0, 0, 0, 100, 0, 2000, 5000, 14000, 18000, 0, 0, 11, 46453, 256, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Shadowsword Manafiend - In Combat - Cast \'Drain Mana\''),
(25483, 0, 1, 0, 0, 0, 100, 0, 6000, 10000, 17000, 28000, 0, 0, 11, 46457, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Shadowsword Manafiend - In Combat - Cast \'Arcane Explosion\'');

-- Shadowsword Assassin (Update + Comments)
UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 25484;

DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = 25484);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(25484, 0, 0, 0, 25, 0, 100, 0, 0, 0, 0, 0, 0, 0, 11, 16380, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Shadowsword Assassin - On Reset - Cast \'Greater Invisibility\''),
(25484, 0, 1, 0, 1, 0, 100, 0, 2000, 2000, 2000, 2000, 0, 0, 49, 0, 0, 0, 0, 0, 0, 21, 15, 0, 0, 0, 0, 0, 0, 0, 'Shadowsword Assassin - Out of Combat - Start Attacking'),
(25484, 0, 2, 3, 0, 0, 100, 0, 12000, 15000, 24000, 28000, 0, 0, 11, 46463, 0, 0, 0, 0, 0, 5, 30, 0, 0, 0, 0, 0, 0, 0, 'Shadowsword Assassin - In Combat - Cast \'Shadowstep\''),
(25484, 0, 3, 0, 61, 0, 100, 512, 0, 0, 0, 0, 0, 0, 14, 0, 100, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Shadowsword Assassin - In Combat - Set All Threat 0-100'),
(25484, 0, 4, 0, 9, 0, 100, 0, 0, 0, 5000, 5000, 10, 35, 11, 46460, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Shadowsword Assassin - Within 10-35 Range - Cast \'Aimed Shot\''),
(25484, 0, 5, 0, 4, 0, 100, 0, 0, 0, 0, 0, 0, 0, 11, 46459, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Shadowsword Assassin - On Aggro - Cast \'Assassin`s Mark\'');

-- Setup Comment for a Vanquisher
UPDATE `creature` SET `Comment` = "has guid specific SAI" WHERE (`guid` = 44059) AND (`id1` = 25486);
UPDATE `creature` SET `Comment` = "has guid specific SAI" WHERE (`guid` = 44079) AND (`id1` = 25486);
UPDATE `creature` SET `Comment` = "has guid specific SAI" WHERE (`guid` = 44358) AND (`id1` = 25483);
UPDATE `creature` SET `Comment` = "has guid specific SAI" WHERE (`guid` = 44268) AND (`id1` = 25484);

-- Add Extra Flag for Vanquisters/Manafiend/Assassin (Don't Override SmartAI)
UPDATE `creature_template` SET `flags_extra` = `flags_extra` |134283264 WHERE (`entry` = 25486);
UPDATE `creature_template` SET `flags_extra` = `flags_extra` |134283264 WHERE (`entry` = 25484);
UPDATE `creature_template` SET `flags_extra` = `flags_extra` |134283264 WHERE (`entry` = 25483);

-- Add Specific SmartAI for two Vanquishers
DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = -44059);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(-44059, 0, 2, 3, 101, 0, 100, 257, 1, 60, 1000, 1000, 1000, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Shadowsword Vanquisher - On 1 or More Players in Range - Say Line 0 (No Repeat)'),
(-44059, 0, 3, 4, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 69, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 1782.49, 565.23, 56.4824, 0, 'Shadowsword Vanquisher - On 1 or More Players in Range - Move To Self (No Repeat)'),
(-44059, 0, 4, 5, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 201, 0, 0, 0, 0, 0, 0, 10, 44079, 25486, 0, 0, 1795.16, 559.262, 55.452, 0, 'Shadowsword Vanquisher - On 1 or More Players in Range - Move to pos target 0 (No Repeat)'),
(-44059, 0, 5, 6, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 201, 0, 0, 0, 0, 0, 0, 10, 44358, 25483, 0, 0, 1796.5, 565.146, 53.8325, 0, 'Shadowsword Vanquisher - On 1 or More Players in Range - Move to pos target 0 (No Repeat)'),
(-44059, 0, 6, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 201, 0, 0, 0, 0, 0, 0, 10, 44268, 25484, 0, 0, 1792.09, 568.5, 53.796, 0, 'Shadowsword Vanquisher - On 1 or More Players in Range - Move to pos target 0 (No Repeat)'),
(-44059, 0, 7, 0, 7, 0, 100, 0, 0, 0, 0, 0, 0, 0, 101, 0, 0, 0, 0, 0, 0, 8, 0, 0, 0, 0, 1782.49, 565.23, 56.4824, -2.29478, 'Shadowsword Vanquisher - On Evade - Set Home Position');

DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = -44079);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(-44079, 0, 2, 0, 7, 0, 100, 0, 0, 0, 0, 0, 0, 0, 101, 0, 0, 0, 0, 0, 0, 8, 0, 0, 0, 0, 1795.16, 559.262, 55.452, -1.89717, 'Shadowsword Vanquisher - On Evade - Set Home Position');

-- Add Specific SmartAI for a Manafiend
DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = -44358);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(-44358, 0, 2, 0, 7, 0, 100, 0, 0, 0, 0, 0, 0, 0, 101, 0, 0, 0, 0, 0, 0, 8, 0, 0, 0, 0, 1796.5, 565.146, 53.8325, -1.9621, 'Shadowsword Manafiend - On Evade - Set Home Position');

-- Add Specific SmartAI for an Assassin
DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = -44268);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(-44268, 0, 6, 0, 7, 0, 100, 0, 0, 0, 0, 0, 0, 0, 101, 0, 0, 0, 0, 0, 0, 8, 0, 0, 0, 0, 1792.09, 568.5, 53.796, -1.9703, 'Shadowsword Assassin - On Evade - Set Home Position');
