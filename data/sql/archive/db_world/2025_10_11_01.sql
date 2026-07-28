-- DB update 2025_10_11_00 -> 2025_10_11_01

-- Add Waypoint
DELETE FROM `waypoints` WHERE (`entry` IN (2300200));
INSERT INTO `waypoints` (`entry`, `pointid`, `position_x`, `position_y`, `position_z`, `orientation`, `point_comment`) VALUES
(2300200, 1, 3691.97, -3962.41, 35.9118, NULL, 'Rizzle Sprysprocket escape'),
(2300200, 2, 3675.02, -3960.49, 35.9118, NULL, 'Rizzle Sprysprocket escape'),
(2300200, 3, 3653.19, -3958.33, 33.9118, NULL, 'Rizzle Sprysprocket escape'),
(2300200, 4, 3621.12, -3958.51, 29.9118, NULL, 'Rizzle Sprysprocket escape'),
(2300200, 5, 3604.86, -3963, 29.9118, NULL, 'Rizzle Sprysprocket escape'),
(2300200, 6, 3569.94, -3970.25, 29.9118, NULL, 'Rizzle Sprysprocket escape'),
(2300200, 7, 3541.03, -3975.64, 29.9118, NULL, 'Rizzle Sprysprocket escape'),
(2300200, 8, 3510.84, -3978.71, 29.9118, NULL, 'Rizzle Sprysprocket escape'),
(2300200, 9, 3472.7,  -3997.07, 29.9118, NULL, 'Rizzle Sprysprocket escape'),
(2300200, 10, 3439.15, -4014.55, 29.9118, NULL, 'Rizzle Sprysprocket escape'),
(2300200, 11, 3412.8, -4025.87, 29.9118, NULL, 'Rizzle Sprysprocket escape'),
(2300200, 12, 3384.95, -4038.04, 29.9118, NULL, 'Rizzle Sprysprocket escape'),
(2300200, 13, 3346.77, -4052.93, 29.9118, NULL, 'Rizzle Sprysprocket escape'),
(2300200, 14, 3299.56, -4071.59, 29.9118, NULL, 'Rizzle Sprysprocket escape'),
(2300200, 15, 3261.22, -4080.38, 30.9118, NULL, 'Rizzle Sprysprocket escape'),
(2300200, 16, 3220.68, -4083.09, 31.9118, NULL, 'Rizzle Sprysprocket escape'),
(2300200, 17, 3187.11, -4070.45, 33.9118, NULL, 'Rizzle Sprysprocket escape'),
(2300200, 18, 3162.78, -4062.75, 33.9118, NULL, 'Rizzle Sprysprocket escape'),
(2300200, 19, 3136.09, -4050.32, 33.9118, NULL, 'Rizzle Sprysprocket escape'),
(2300200, 20, 3119.47, -4044.51, 36.0363, NULL, 'Rizzle Sprysprocket escape'),
(2300200, 21, 3098.95, -4019.8,  33.9118, NULL, 'Rizzle Sprysprocket escape'),
(2300200, 22, 3073.07, -4011.42, 33.9118, NULL, 'Rizzle Sprysprocket escape'),
(2300200, 23, 3051.71, -3993.37, 33.9118, NULL, 'Rizzle Sprysprocket escape'),
(2300200, 24, 3027.52, -3978.6,  33.9118, NULL, 'Rizzle Sprysprocket escape'),
(2300200, 25, 3003.78, -3960.14, 33.9118, NULL, 'Rizzle Sprysprocket escape'),
(2300200, 26, 2977.99, -3941.98, 31.9118, NULL, 'Rizzle Sprysprocket escape'),
(2300200, 27, 2964.57, -3932.07, 30.9118, NULL, 'Rizzle Sprysprocket escape'),
(2300200, 28, 2947.9,  -3921.31, 29.9118, NULL, 'Rizzle Sprysprocket escape'),
(2300200, 29, 2924.91, -3910.8,  29.9118, NULL, 'Rizzle Sprysprocket escape'),
(2300200, 30, 2903.04, -3896.42, 29.9118, NULL, 'Rizzle Sprysprocket escape'),
(2300200, 31, 2884.75, -3874.03, 29.9118, NULL, 'Rizzle Sprysprocket escape'),
(2300200, 32, 2868.19, -3851.48, 29.9118, NULL, 'Rizzle Sprysprocket escape'),
(2300200, 33, 2854.62, -3819.72, 29.9118, NULL, 'Rizzle Sprysprocket escape'),
(2300200, 34, 2825.53, -3790.4,  29.9118, NULL, 'Rizzle Sprysprocket escape'),
(2300200, 35, 2804.31, -3773.05, 29.9118, NULL, 'Rizzle Sprysprocket escape'),
(2300200, 36, 2769.78, -3763.57, 29.9118, NULL, 'Rizzle Sprysprocket escape'),
(2300200, 37, 2727.23, -3745.92, 30.9118, NULL, 'Rizzle Sprysprocket escape'),
(2300200, 38, 2680.12, -3737.49, 30.9118, NULL, 'Rizzle Sprysprocket escape'),
(2300200, 39, 2647.62, -3739.94, 30.9118, NULL, 'Rizzle Sprysprocket escape'),
(2300200, 40, 2616.6, -3745.75, 30.9118, NULL, 'Rizzle Sprysprocket escape'),
(2300200, 41, 2589.38, -3731.97, 30.9118, NULL, 'Rizzle Sprysprocket escape'),
(2300200, 42, 2562.94, -3722.35, 31.9118, NULL, 'Rizzle Sprysprocket escape'),
(2300200, 43, 2521.05, -3716.6,  31.9118, NULL, 'Rizzle Sprysprocket escape'),
(2300200, 44, 2485.26, -3706.67, 31.9118, NULL, 'Rizzle Sprysprocket escape'),
(2300200, 45, 2458.93, -3696.67, 31.9118, NULL, 'Rizzle Sprysprocket escape'),
(2300200, 46, 2432, -3692.03, 31.9118, NULL, 'Rizzle Sprysprocket escape'),
(2300200, 47, 2399.59, -3681.97, 31.9118, NULL, 'Rizzle Sprysprocket escape'),
(2300200, 48, 2357.75, -3666.6,  31.9118, NULL, 'Rizzle Sprysprocket escape'),
(2300200, 49, 2311.99, -3656.88, 31.9118, NULL, 'Rizzle Sprysprocket escape'),
(2300200, 50, 2263.41, -3649.55, 31.9118, NULL, 'Rizzle Sprysprocket escape'),
(2300200, 51, 2209.05, -3641.76, 31.9118, NULL, 'Rizzle Sprysprocket escape'),
(2300200, 52, 2164.83, -3637.64, 31.9118, NULL, 'Rizzle Sprysprocket escape'),
(2300200, 53, 2122.42, -3639, 31.9118, NULL, 'Rizzle Sprysprocket escape'),
(2300200, 54, 2075.73, -3643.59, 31.9118, NULL, 'Rizzle Sprysprocket escape'),
(2300200, 55, 2033.59, -3649.52, 31.9118, NULL, 'Rizzle Sprysprocket escape'),
(2300200, 56, 1985.22, -3662.99, 31.9118, NULL, 'Rizzle Sprysprocket escape'),
(2300200, 57, 1927.09, -3679.56, 33.9118, NULL, 'Rizzle Sprysprocket escape'),
(2300200, 58, 1873.57, -3695.32, 33.9118, NULL, 'Rizzle Sprysprocket escape');

-- Set General SmartAI, Add Gossip ID, ScriptName, NpcFlag.
UPDATE `creature_template` SET `npcflag` = `npcflag` |1, `gossip_menu_id` = 21893, `ScriptName` = '', `AIName` = 'SmartAI' WHERE `entry` = 23002;

-- Add SmartAI
DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = 23002);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(23002, 0, 0, 1, 54, 0, 100, 0, 0, 0, 0, 0, 0, 0, 83, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Rizzle Sprysprocket - On Just Summoned - Remove Npc Flags Gossip'),
(23002, 0, 1, 2, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 64, 12, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Rizzle Sprysprocket - On Just Summoned - Store Targetlist'),
(23002, 0, 2, 3, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 11, 39865, 2, 0, 1, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Rizzle Sprysprocket - On Just Summoned - Cast \'Rizzle`s Blackjack\''),
(23002, 0, 3, 4, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Rizzle Sprysprocket - On Just Summoned - Say Line 0'),
(23002, 0, 4, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 80, 2300200, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Rizzle Sprysprocket - On Just Summoned - Run Script'),
(23002, 0, 5, 6, 60, 1, 100, 0, 15000, 20000, 25000, 30000, 0, 0, 11, 40525, 2, 0, 0, 0, 0, 12, 12, 0, 0, 0, 0, 0, 0, 0, 'Rizzle Sprysprocket - On Update - Cast \'Rizzle`s Frost Grenade\' (Phase 1)'),
(23002, 0, 6, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 12, 12, 0, 0, 0, 0, 0, 0, 0, 'Rizzle Sprysprocket - On Update - Say Line 1 (Phase 1)'),
(23002, 0, 7, 8, 101, 1, 100, 0, 1, 10, 1000, 1000, 1000, 0, 55, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Rizzle Sprysprocket - On 1 or More Players in Range - Stop Waypoint (Phase 1)'),
(23002, 0, 8, 9, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 28, 39912, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Rizzle Sprysprocket - On 1 or More Players in Range - Remove Aura \'Periodic Depth Charge Release\' (Phase 1)'),
(23002, 0, 9, 10, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 1, 2, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Rizzle Sprysprocket - On 1 or More Players in Range - Say Line 2 (Phase 1)'),
(23002, 0, 10, 11, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 82, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Rizzle Sprysprocket - On 1 or More Players in Range - Add Npc Flags Gossip (Phase 1)'),
(23002, 0, 11, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 22, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Rizzle Sprysprocket - On 1 or More Players in Range - Set Event Phase 0 (Phase 1)'),
(23002, 0, 12, 13, 62, 0, 100, 0, 21893, 0, 0, 0, 0, 0, 11, 39886, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Rizzle Sprysprocket - On Gossip Option 0 Selected - Cast \'Give Southfury Moonstone\''),
(23002, 0, 13, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 41, 3000, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Rizzle Sprysprocket - On Gossip Option 0 Selected - Despawn In 3000 ms'),
(23002, 0, 14, 0, 58, 0, 100, 0, 58, 2300200, 0, 0, 0, 0, 41, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Rizzle Sprysprocket - On Path 2300200 Finished - Despawn Instant');

-- Set Action List
DELETE FROM `smart_scripts` WHERE (`source_type` = 9 AND `entryorguid` = 2300200);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(2300200, 9, 0, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 11, 23025, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Rizzle Sprysprocket - Actionlist - Cast \'Blink Cooldown Reduction\''),
(2300200, 9, 1, 0, 0, 0, 100, 0, 2000, 2000, 0, 0, 0, 0, 1, 3, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Rizzle Sprysprocket - Actionlist - Say Line 3'),
(2300200, 9, 2, 0, 0, 0, 100, 0, 500, 500, 0, 0, 0, 0, 11, 39871, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Rizzle Sprysprocket - Actionlist - Cast \'Rizzle`s Escape\''),
(2300200, 9, 3, 0, 0, 0, 100, 0, 1000, 1000, 0, 0, 0, 0, 11, 39912, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Rizzle Sprysprocket - Actionlist - Cast \'Periodic Depth Charge Release\''),
(2300200, 9, 4, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 22, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Rizzle Sprysprocket - Actionlist - Set Event Phase 1'),
(2300200, 9, 5, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 53, 1, 2300200, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Rizzle Sprysprocket - Actionlist - Start Waypoint Path 2300200');

-- Set Conditions
DELETE FROM `conditions` WHERE (`SourceTypeOrReferenceId` IN (15, 22)) AND (`SourceGroup` IN (8, 21893)) AND (`SourceEntry` IN (0, 23002)) AND (`SourceId` = 0) AND (`ElseGroup` = 0) AND (`ConditionTypeOrReference` = 47) AND (`ConditionTarget` = 0) AND (`ConditionValue1` = 10994) AND (`ConditionValue2` = 8) AND (`ConditionValue3` = 0);
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `ErrorType`, `ErrorTextId`, `ScriptName`, `Comment`) VALUES
(15, 21893, 0, 0, 0, 47, 0, 10994, 8, 0, 0, 0, 0, '', 'Gossip displayed only if player has Chasing the Moonstone incomplete'),
(22, 8, 23002, 0, 0, 47, 0, 10994, 8, 0, 0, 0, 0, '', 'Event occurs only if player has Chasing the Moonstone incomplete.');

-- Set SmartAI (Rizzle's Depth Charge)
UPDATE `creature_template` SET `AIName` = 'SmartAI', `ScriptName` = '' WHERE `entry` = 23025;

DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = 23025);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(23025, 0, 0, 1, 54, 0, 100, 0, 0, 0, 0, 0, 0, 0, 207, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Rizzle\'s Depth Charge - On Just Summoned - Set hover 1'),
(23025, 0, 1, 2, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 61, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Rizzle\'s Depth Charge - On Just Summoned - Set Swim On'),
(23025, 0, 2, 3, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 18, 33554432, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Rizzle\'s Depth Charge - On Just Summoned - Set Flags Not Selectable'),
(23025, 0, 3, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 8, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Rizzle\'s Depth Charge - On Just Summoned - Set Reactstate Passive'),
(23025, 0, 4, 5, 101, 0, 100, 0, 1, 5, 1000, 1000, 1000, 0, 11, 38576, 2, 0, 0, 0, 0, 21, 5, 0, 0, 0, 0, 0, 0, 0, 'Rizzle\'s Depth Charge - On 1 or More Players in Range - Cast \'Knockback\''),
(23025, 0, 5, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 41, 1000, 0, 1, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Rizzle\'s Depth Charge - On 1 or More Players in Range - Despawn In 1000 ms');
