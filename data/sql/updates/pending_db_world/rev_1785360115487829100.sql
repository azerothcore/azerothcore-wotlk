--
DELETE FROM `creature_template_addon` WHERE (`entry` = 24051);
INSERT INTO `creature_template_addon` (`entry`, `path_id`, `mount`, `bytes1`, `bytes2`, `emote`, `visibilityDistanceType`, `auras`) VALUES
(24051, 0, 0, 0, 1, 0, 0, '42865');

DELETE FROM `creature_template_addon` WHERE (`entry` = 24063);
INSERT INTO `creature_template_addon` (`entry`, `path_id`, `mount`, `bytes1`, `bytes2`, `emote`, `visibilityDistanceType`, `auras`) VALUES
(24063, 0, 0, 0, 0, 0, 0, '42865');

-- Empty equip_template to not throw errors
DELETE FROM `creature_equip_template` WHERE (`CreatureID` = 24063);
INSERT INTO `creature_equip_template` (`CreatureID`, `ID`, `ItemID1`, `ItemID2`, `ItemID3`, `VerifiedBuild`) VALUES
(24063, 1, 0, 0, 0, 68887);

UPDATE `creature_template` SET `lootid` = 0 WHERE (`entry` = 24063);
DELETE FROM `creature_loot_template` WHERE `Entry` = 24063;

UPDATE `creature_template` SET `flags_extra` = `flags_extra`|64|134217728, `detection_range` = 20 WHERE (`entry` IN (24051, 24063));

UPDATE `creature_template` SET `speed_walk` = 1, `speed_run` = 1.142857 WHERE (`entry` = 24063);

-- Delete old ones
DELETE FROM `creature` WHERE (`id` = 24063) AND (`guid` BETWEEN 120557 AND 120561);
DELETE FROM `creature` WHERE (`id` = 24051) AND (`guid` BETWEEN 118766 AND 118773);
DELETE FROM `creature_addon` WHERE (`guid` BETWEEN 120557 AND 120561);
DELETE FROM `creature_addon` WHERE (`guid` BETWEEN 118766 AND 118773);
DELETE FROM `waypoint_data` WHERE (`id` BETWEEN 1205570 AND 1205610);
DELETE FROM `waypoint_data` WHERE (`id` BETWEEN 1187660 AND 1187730);

SET @CGUID := 12804;

DELETE FROM `creature` WHERE `guid` BETWEEN @CGUID AND @CGUID+6 AND `id` = 24051;
INSERT INTO `creature` (`guid`, `id`, `map`, `zoneId`, `areaId`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `CreateObject`, `VerifiedBuild`) VALUES
(@CGUID+0, 24051, 571, 495, 3981, 1, 733.43774, -4872.8115, 5.9952602, 2.02116, 120, 1, 68887),
(@CGUID+1, 24051, 571, 495, 3981, 1, 811.02466, -4967.3896, 1.8235762, 0.0481025, 120, 1, 68887),
(@CGUID+2, 24051, 571, 495, 3981, 1, 798.0802, -4867.249, -0.5787722, 0.366519, 120, 1, 68887),
(@CGUID+3, 24051, 571, 495, 3981, 1, 780.9059, -4882.871, 0.5644784, 3.03564, 120, 1, 68887),
(@CGUID+4, 24051, 571, 495, 3981, 1, 783.75476, -4949.7236, 1.654979, 3.02413, 120, 1, 68887),
(@CGUID+5, 24051, 571, 495, 3981, 1, 794.9075, -4874.745, -0.62727714, 3.11962, 120, 1, 68887),
(@CGUID+6, 24051, 571, 495, 3981, 1, 803.7593, -4924.593, 0.1089665, 3.11962, 120, 1, 68887);

DELETE FROM `creature_multispawn` WHERE `spawnId` BETWEEN @CGUID+0 AND @CGUID+6 AND `entry` = 24063;
INSERT INTO `creature_multispawn` (`spawnId`, `entry`) VALUES
(@CGUID+0, 24063),
(@CGUID+1, 24063),
(@CGUID+2, 24063),
(@CGUID+3, 24063),
(@CGUID+4, 24063),
(@CGUID+5, 24063),
(@CGUID+6, 24063);

DELETE FROM `waypoint_data` WHERE `id` BETWEEN (@CGUID+0)*10 AND (@CGUID+6)*10;
INSERT INTO `waypoint_data` (`id`, `point`, `position_x`, `position_y`, `position_z`, `orientation`, `move_type`) VALUES
-- X: 733.43774 Y: -4872.8115 Z: 5.9952602
((@CGUID+0)*10, 1, 732.7387, -4884.812, 3.0737715, NULL, 1),
((@CGUID+0)*10, 2, 719.05145, -4894.5073, 6.2719183, NULL, 1),
((@CGUID+0)*10, 3, 697.83594, -4907.74, 6.1251554, NULL, 1),
-- X: 811.02466 Y: -4967.3896 Z: 1.8235762
((@CGUID+1)*10, 1, 744.038, -4960.3228, 2.330449, NULL, 1),
((@CGUID+1)*10, 2, 727.86505, -4985.579, 5.602709, NULL, 1),
((@CGUID+1)*10, 3, 722.78345, -4988.4126, 6.404078, NULL, 1),
-- X: 798.0802 Y: -4867.249 Z: -0.5787722
((@CGUID+2)*10, 1, 741.7717, -4904.015, 3.1975787, NULL, 1),
((@CGUID+2)*10, 2, 734.9463, -4927.025, 6.25686, NULL, 1),
((@CGUID+2)*10, 3, 719.4844, -4935.973, 6.7613916, NULL, 1),
-- X: 780.9059 Y: -4882.871 Z: 0.5644784
((@CGUID+3)*10, 1, 730.73535, -4893.994, 4.5011435, NULL, 1),
((@CGUID+3)*10, 2, 704.7542, -4905.6694, 7.276061, NULL, 1),
((@CGUID+3)*10, 3, 709.357, -4927.3623, 7.2387867, NULL, 1),
-- X: 783.75476 Y: -4949.7236 Z: 1.654979
((@CGUID+4)*10, 1, 728.9895, -4940.7905, 6.076869, NULL, 1),
((@CGUID+4)*10, 2, 715.9845, -4970.6724, 6.0854883, NULL, 1),
-- X: 794.9075 Y: -4874.745 Z: -0.62727714
((@CGUID+5)*10, 1, 738.62933, -4915.262, 5.2849817, NULL, 1),
((@CGUID+5)*10, 2, 731.65607, -4927.6084, 6.734372, NULL, 1),
((@CGUID+5)*10, 3, 712.5723, -4926.47, 7.523102, NULL, 1),
-- X: 803.7593 Y: -4924.593 Z: 0.1089665
((@CGUID+6)*10, 1, 739.2899, -4937.828, 5.6794043, NULL, 1),
((@CGUID+6)*10, 2, 719.42474, -4959.9834, 4.882431, NULL, 1);

DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = 24051);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(24051, 0, 0, 0, 9, 0, 100, 0, 5700, 11700, 5700, 11700, 8, 25, 11, 27577, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Dragonflayer Invader - Within 8-25 Range - Cast \'Intercept\''),
(24051, 0, 1, 0, 9, 0, 100, 0, 8700, 14700, 8700, 14700, 10, 25, 11, 42870, 0, 0, 0, 0, 0, 5, 0, 0, 0, 0, 0, 0, 0, 0, 'Dragonflayer Invader - Within 10-25 Range - Cast \'Throw Dragonflayer Harpoon\''),
(24051, 0, 2, 0, 4, 0, 10, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Dragonflayer Invader - On Aggro - Say Line'),
(24051, 0, 3, 0, 6, 0, 100, 0, 0, 0, 0, 0, 0, 0, 41, 5000, 1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Dragonflayer Invader - On Just Died - Despawn In 5000 ms'),
(24051, 0, 4, 0, 109, 0, 100, 0, 0, 0, 0, 0, 0, 0, 49, 0, 0, 0, 0, 0, 0, 19, 23739, 60, 0, 0, 0, 0, 0, 0, 'Dragonflayer Invader - On Path Finished - Start Attacking');

DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = 24063);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(24063, 0, 0, 0, 0, 0, 70, 0, 5000, 10000, 5000, 10000, 0, 0, 11, 7367, 32, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Dragonflayer Worg - In Combat - Cast \'Infected Bite\''),
(24063, 0, 1, 0, 6, 0, 100, 0, 0, 0, 0, 0, 0, 0, 41, 5000, 1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Dragonflayer Worg - On Just Died - Despawn In 5000 ms'),
(24063, 0, 2, 0, 109, 0, 100, 0, 0, 0, 0, 0, 0, 0, 49, 0, 0, 0, 0, 0, 0, 19, 23739, 60, 0, 0, 0, 0, 0, 0, 'Dragonflayer Worg - On Path Finished - Start Attacking');

DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` BETWEEN -(@CGUID+6) AND -(@CGUID+0));
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(-(@CGUID+0), 0, 1000, 0, 11, 0, 100, 0, 0, 0, 0, 0, 0, 0, 232, (@CGUID+0)*10, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Dragonflayer Invader - On Respawn - Start Path'),
(-(@CGUID+1), 0, 1000, 0, 11, 0, 100, 0, 0, 0, 0, 0, 0, 0, 232, (@CGUID+1)*10, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Dragonflayer Invader - On Respawn - Start Path'),
(-(@CGUID+2), 0, 1000, 0, 11, 0, 100, 0, 0, 0, 0, 0, 0, 0, 232, (@CGUID+2)*10, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Dragonflayer Invader - On Respawn - Start Path'),
(-(@CGUID+3), 0, 1000, 0, 11, 0, 100, 0, 0, 0, 0, 0, 0, 0, 232, (@CGUID+3)*10, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Dragonflayer Invader - On Respawn - Start Path'),
(-(@CGUID+4), 0, 1000, 0, 11, 0, 100, 0, 0, 0, 0, 0, 0, 0, 232, (@CGUID+4)*10, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Dragonflayer Invader - On Respawn - Start Path'),
(-(@CGUID+5), 0, 1000, 0, 11, 0, 100, 0, 0, 0, 0, 0, 0, 0, 232, (@CGUID+5)*10, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Dragonflayer Invader - On Respawn - Start Path'),
(-(@CGUID+6), 0, 1000, 0, 11, 0, 100, 0, 0, 0, 0, 0, 0, 0, 232, (@CGUID+6)*10, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Dragonflayer Invader - On Respawn - Start Path');
