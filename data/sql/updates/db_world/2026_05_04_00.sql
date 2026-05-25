-- DB update 2026_05_03_01 -> 2026_05_04_00

-- Delete old waypoint & add two new ones.
DELETE FROM `script_waypoint` WHERE `entry` = 29602;
DELETE FROM `waypoint_data` WHERE (`id` IN (2960200, 2960201));
INSERT INTO `waypoint_data` (`id`,  `point`, `position_x`, `position_y`, `position_z`, `orientation`, `delay`, `move_type`, `action`, `action_chance`, `wpguid`) VALUES
(2960200, 1, 7079.6978, -2033.1096, 764.22363, NULL, 0, 1, 0, 100, 0),
(2960200, 2, 7068.746, -2081.6372, 758.46783, NULL, 0, 1, 0, 100, 0),
(2960200, 3, 7065.993, -2130.804, 756.0072, NULL, 0, 1, 0, 100, 0),
(2960200, 4, 7088.311, -2173.4739, 759.40454, NULL, 0, 1, 0, 100, 0),
(2960200, 5, 7124.069, -2207.86, 758.34875, NULL, 0, 1, 0, 100, 0),
(2960200, 6, 7152.243, -2248.376, 759.6332, NULL, 0, 1, 0, 100, 0),
(2960200, 7, 7196.3516, -2265.1384, 756.818, NULL, 0, 1, 0, 100, 0),
(2960200, 8, 7234.0127, -2297.4749, 752.40814, NULL, 0, 1, 0, 100, 0),
(2960200, 9, 7255.4043, -2341.076, 751.73083, NULL, 0, 1, 0, 100, 0),
(2960200, 10, 7297.8813, -2368.0906, 751.5218, NULL, 0, 1, 0, 100, 0),
(2960200, 11, 7304.3057, -2416.3677, 752.8529, NULL, 0, 1, 0, 100, 0),
(2960200, 12, 7320.8213, -2463.647, 750.73145, NULL, 0, 1, 0, 100, 0),
(2960200, 13, 7362.9956, -2490.5044, 749.8022, NULL, 0, 1, 0, 100, 0),
(2960200, 14, 7409.4863, -2475.0657, 751.87994, NULL, 0, 1, 0, 100, 0),
(2960200, 15, 7422.454, -2427.5562, 752.46826, NULL, 0, 1, 0, 100, 0),
(2960200, 16, 7407.2866, -2380.3416, 753.04663, NULL, 0, 1, 0, 100, 0),
(2960200, 17, 7407.848, -2331.121, 757.12366, NULL, 0, 1, 0, 100, 0),
(2960200, 18, 7366.268, -2303.2979, 756.10443, NULL, 0, 1, 0, 100, 0),
(2960200, 19, 7318.561, -2301.5312, 754.4625, NULL, 0, 1, 0, 100, 0),
(2960200, 20, 7280.9966, -2270.3918, 756.3627, NULL, 0, 1, 0, 100, 0),
(2960200, 21, 7237.944, -2246.7197, 756.31384, NULL, 0, 1, 0, 100, 0),
(2960200, 22, 7193.8286, -2231.046, 757.79626, NULL, 0, 1, 0, 100, 0),
(2960200, 23, 7159.3477, -2195.3066, 760.58264, NULL, 0, 1, 0, 100, 0),
(2960200, 24, 7122.389, -2164.836, 760.4839, NULL, 0, 1, 0, 100, 0),
(2960200, 25, 7112.4834, -2116.8887, 759.7804, NULL, 0, 1, 0, 100, 0),
(2960200, 26, 7116.9863, -2071.1887, 766.2056, NULL, 0, 1, 0, 100, 0),
(2960200, 27, 7117.6025, -2040.7129, 767.7893, NULL, 0, 1, 0, 100, 0),
(2960200, 28, 7107.0435, -2011.1892, 770.1438, NULL, 0, 1, 0, 100, 0),
(2960200, 29, 7103.9424, -1985.653, 771.0793, NULL, 0, 1, 0, 100, 0),
(2960200, 30, 7079.7, -1966.68, 769.305, NULL, 0, 1, 0, 100, 0),
(2960200, 31, 7087.928, -1931.9026, 773.7549, NULL, 0, 1, 0, 100, 0),
(2960201, 1, 7081.8774, -2012.0011, 766.2301, NULL, 0, 1, 0, 100, 0),
(2960201, 2, 7104.026, -2056.3606, 765.3837, NULL, 0, 1, 0, 100, 0),
(2960201, 3, 7104.528, -2105.8418, 760.49347, NULL, 0, 1, 0, 100, 0),
(2960201, 4, 7116.4165, -2153.7432, 759.7369, NULL, 0, 1, 0, 100, 0),
(2960201, 5, 7147.767, -2190.783, 759.2086, NULL, 0, 1, 0, 100, 0),
(2960201, 6, 7189.606, -2217.285, 759.46906, NULL, 0, 1, 0, 100, 0),
(2960201, 7, 7231.661, -2238.2708, 757.4844, NULL, 0, 1, 0, 100, 0),
(2960201, 8, 7272.987, -2260.4424, 756.20917, NULL, 0, 1, 0, 100, 0),
(2960201, 9, 7310.389, -2289.4739, 754.7779, NULL, 0, 1, 0, 100, 0),
(2960201, 10, 7355.282, -2303.5774, 755.6713, NULL, 0, 1, 0, 100, 0),
(2960201, 11, 7401.5444, -2318.8916, 757.8036, NULL, 0, 1, 0, 100, 0),
(2960201, 12, 7413.0244, -2353.2883, 755.66315, NULL, 0, 1, 0, 100, 0),
(2960201, 13, 7386.935, -2394.2864, 749.2125, NULL, 0, 1, 0, 100, 0),
(2960201, 14, 7343.7847, -2418.5652, 749.6803, NULL, 0, 1, 0, 100, 0),
(2960201, 15, 7300.632, -2393.1646, 751.9034, NULL, 0, 1, 0, 100, 0),
(2960201, 16, 7281.886, -2347.135, 749.444, NULL, 0, 1, 0, 100, 0),
(2960201, 17, 7268.9087, -2299.5518, 752.52783, NULL, 0, 1, 0, 100, 0),
(2960201, 18, 7227.1978, -2271.2617, 755.354, NULL, 0, 1, 0, 100, 0),
(2960201, 19, 7181.099, -2253.8003, 757.4965, NULL, 0, 1, 0, 100, 0),
(2960201, 20, 7136.719, -2232.0361, 758.35034, NULL, 0, 1, 0, 100, 0),
(2960201, 21, 7103.6987, -2195.238, 759.33044, NULL, 0, 1, 0, 100, 0),
(2960201, 22, 7072.1104, -2157.011, 759.6482, NULL, 0, 1, 0, 100, 0),
(2960201, 23, 7059.117, -2109.4075, 755.57043, NULL, 0, 1, 0, 100, 0),
(2960201, 24, 7069.828, -2068.9705, 759.4906, NULL, 0, 1, 0, 100, 0),
(2960201, 25, 7092.831, -2042.584, 766.1361, NULL, 0, 1, 0, 100, 0),
(2960201, 26, 7107.4473, -2013.8727, 769.5967, NULL, 0, 1, 0, 100, 0),
(2960201, 27, 7102.1475, -1985.027, 770.659, NULL, 0, 1, 0, 100, 0),
(2960201, 28, 7079.7, -1966.68, 769.305, NULL, 0, 1, 0, 100, 0),
(2960201, 29, 7087.928, -1931.9026, 773.7549, NULL, 0, 1, 0, 100, 0);

-- Set SmartAI
UPDATE `creature_template` SET `AIName` = 'SmartAI', `ScriptName` = '' WHERE (`entry` = 29602);

DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = 29602);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(29602, 0, 0, 1, 27, 0, 100, 512, 0, 0, 0, 0, 0, 0, 8, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Icefang - On Passenger Boarded - Set Reactstate Passive'),
(29602, 0, 1, 2, 61, 0, 100, 512, 0, 0, 0, 0, 0, 0, 117, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Icefang - On Passenger Boarded - Disable Evade'),
(29602, 0, 2, 0, 61, 0, 100, 512, 0, 0, 0, 0, 0, 0, 233, 2960200, 2960201, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Icefang - On Passenger Boarded - Start Random Path 2960200-2960201'),
(29602, 0, 3, 0, 28, 0, 100, 512, 0, 0, 0, 0, 0, 0, 41, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Icefang - On Passenger Removed - Despawn Instant'),
(29602, 0, 4, 0, 109, 0, 100, 512, 0, 0, 0, 0, 0, 0, 41, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Icefang - On Any Path Finished - Despawn Instant');

-- Delete Old Condition (Icefang spellclick requires the Going Bearback quest to not be rewarded)
DELETE FROM `conditions` WHERE (`SourceTypeOrReferenceId` = 18) AND (`SourceGroup` = 29598) AND (`SourceEntry` = 54768) AND (`SourceId` = 0) AND (`ElseGroup` = 0) AND (`ConditionTypeOrReference` = 8) AND (`ConditionTarget` = 0) AND (`ConditionValue1` = 12856) AND (`ConditionValue2` = 0) AND (`ConditionValue3` = 0);

-- Add new Condition.
DELETE FROM `conditions` WHERE (`SourceTypeOrReferenceId` = 18) AND (`SourceGroup` = 29598) AND (`SourceEntry` = 54768) AND (`SourceId` = 0) AND (`ElseGroup` = 0) AND (`ConditionTypeOrReference` = 9) AND (`ConditionTarget` = 0) AND (`ConditionValue1` = 12851) AND (`ConditionValue2` = 0) AND (`ConditionValue3` = 0);
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `ErrorType`, `ErrorTextId`, `ScriptName`, `Comment`) VALUES
(18, 29598, 54768, 0, 0, 9, 0, 12851, 0, 0, 0, 0, 0, '', 'Icefang spellclick require Going Bearback quest taken');
