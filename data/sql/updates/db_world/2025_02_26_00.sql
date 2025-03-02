-- DB update 2025_02_25_00 -> 2025_02_26_00

-- New sniffed waypoints for Vindicators
DELETE FROM `waypoint_data` WHERE `id` IN (483970);
INSERT INTO `waypoint_data` (`id`, `point`, `position_x`, `position_y`, `position_z`, `orientation`, `delay`, `move_type`, `action`, `action_chance`, `wpguid`) VALUES
(483970, 1, 1646.2877, 1094.1549, 44.342278, NULL, 0, 0, 0, 100, 0),
(483970, 2, 1662.9437, 1095.1677, 47.942604, NULL, 0, 0, 0, 100, 0),
(483970, 3, 1680.2102, 1095.8654, 51.137077, NULL, 0, 0, 0, 100, 0),
(483970, 4, 1689.7664, 1096.0767, 52.755, NULL, 0, 0, 0, 100, 0),
(483970, 5, 1706.0358, 1095.9752, 52.82473, NULL, 0, 0, 0, 100, 0),
(483970, 6, 1722.817, 1095.9159, 52.768322, NULL, 0, 0, 0, 100, 0),
(483970, 7, 1737.7158, 1094.9585, 50.68262, NULL, 0, 0, 0, 100, 0),
(483970, 8, 1758.9626, 1094.3884, 46.612896, NULL, 0, 0, 0, 100, 0),
(483970, 9, 1776.1573, 1091.3165, 42.720085, NULL, 0, 0, 0, 100, 0),
(483970, 10, 1795.4512, 1079.2858, 37.95213, NULL, 0, 0, 0, 100, 0),
(483970, 11, 1802.0015, 1065.321, 36.409225, NULL, 0, 0, 0, 100, 0),
(483970, 12, 1803.2385, 1049.7919, 35.760597, NULL, 0, 0, 0, 100, 0),
(483970, 13, 1802.0015, 1065.321, 36.409225, NULL, 0, 0, 0, 100, 0),
(483970, 14, 1795.4512, 1079.2858, 37.95213, NULL, 0, 0, 0, 100, 0),
(483970, 15, 1776.1573, 1091.3165, 42.720085, NULL, 0, 0, 0, 100, 0),
(483970, 16, 1758.9626, 1094.3884, 46.612896, NULL, 0, 0, 0, 100, 0),
(483970, 17, 1737.7158, 1094.9585, 50.68262, NULL, 0, 0, 0, 100, 0),
(483970, 18, 1722.817, 1095.9159, 52.768322, NULL, 0, 0, 0, 100, 0),
(483970, 19, 1706.0358, 1095.9752, 52.82473, NULL, 0, 0, 0, 100, 0),
(483970, 20, 1689.7664, 1096.0767, 52.755, NULL, 0, 0, 0, 100, 0),
(483970, 21, 1680.2102, 1095.8654, 51.137077, NULL, 0, 0, 0, 100, 0),
(483970, 22, 1662.9437, 1095.1677, 47.942604, NULL, 0, 0, 0, 100, 0),
(483970, 23, 1646.2877, 1094.1549, 44.342278, NULL, 0, 0, 0, 100, 0),
(483970, 24, 1636.6041, 1093.0988, 41.88343, NULL, 0, 0, 0, 100, 0),
(483970, 25, 1623.0975, 1084.906, 38.59068, NULL, 0, 0, 0, 100, 0),
(483970, 26, 1612.5037, 1069.7399, 36.53206, NULL, 0, 0, 0, 100, 0),
(483970, 27, 1611.1992, 1059.485, 35.985447, NULL, 0, 0, 0, 100, 0),
(483970, 28, 1611.3134, 1049.9519, 35.64077, NULL, 0, 0, 0, 100, 0),
(483970, 29, 1611.1992, 1059.485, 35.985447, NULL, 0, 0, 0, 100, 0),
(483970, 30, 1612.5037, 1069.7399, 36.53206, NULL, 0, 0, 0, 100, 0),
(483970, 31, 1623.0975, 1084.906, 38.59068, NULL, 0, 0, 0, 100, 0),
(483970, 32, 1636.6041, 1093.0988, 41.88343, NULL, 0, 0, 0, 100, 0),
(483970, 33, 1646.2877, 1094.1549, 44.342278, NULL, 0, 0, 0, 100, 0);

DELETE FROM `waypoint_data` WHERE `id` IN (483960);
INSERT INTO `waypoint_data` (`id`, `point`, `position_x`, `position_y`, `position_z`, `orientation`, `delay`, `move_type`, `action`, `action_chance`, `wpguid`) VALUES
(483960, 1, 1774.8724, 836.3321, 36.32849, NULL, 0, 0, 0, 100, 0),
(483960, 2, 1768.3956, 836.36, 35.32849, NULL, 0, 0, 0, 100, 0),
(483960, 3, 1752.8463, 836.4012, 33.92224, NULL, 0, 0, 0, 100, 0),
(483960, 4, 1733.8491, 836.57697, 33.922237, NULL, 0, 0, 0, 100, 0),
(483960, 5, 1714.5634, 836.6511, 35.54724, NULL, 0, 0, 0, 100, 0),
(483960, 6, 1694.0593, 837.08527, 35.55463, NULL, 0, 0, 0, 100, 0),
(483960, 7, 1658.3192, 838.1326, 33.92224, NULL, 0, 0, 0, 100, 0),
(483960, 8, 1637.4122, 838.4397, 35.469112, NULL, 0, 0, 0, 100, 0),
(483960, 9, 1624.4858, 840.2041, 36.062862, NULL, 0, 0, 0, 100, 0),
(483960, 10, 1617.1686, 849.7756, 36.062843, NULL, 0, 0, 0, 100, 0),
(483960, 11, 1610.0963, 858.7788, 36.062855, NULL, 0, 0, 0, 100, 0),
(483960, 12, 1607.2747, 866.5177, 36.328487, NULL, 0, 0, 0, 100, 0),
(483960, 13, 1606.8698, 884.1786, 35.56981, NULL, 0, 0, 0, 100, 0),
(483960, 14, 1606.9554, 907.58167, 35.56875, NULL, 0, 0, 0, 100, 0),
(483960, 15, 1607.6558, 933.41797, 35.567177, NULL, 0, 0, 0, 100, 0),
(483960, 16, 1608.352, 957.584, 35.565678, NULL, 0, 0, 0, 100, 0),
(483960, 17, 1608.94, 987.12415, 35.573025, NULL, 0, 0, 0, 100, 0),
(483960, 18, 1608.352, 957.584, 35.565678, NULL, 0, 0, 0, 100, 0),
(483960, 19, 1607.6558, 933.41797, 35.567177, NULL, 0, 0, 0, 100, 0),
(483960, 20, 1606.9554, 907.58167, 35.56875, NULL, 0, 0, 0, 100, 0),
(483960, 21, 1606.8698, 884.1786, 35.56981, NULL, 0, 0, 0, 100, 0),
(483960, 22, 1607.2747, 866.5177, 36.328487, NULL, 0, 0, 0, 100, 0),
(483960, 23, 1610.0963, 858.7788, 36.062855, NULL, 0, 0, 0, 100, 0),
(483960, 24, 1617.1686, 849.7756, 36.062843, NULL, 0, 0, 0, 100, 0),
(483960, 25, 1624.4858, 840.2041, 36.062862, NULL, 0, 0, 0, 100, 0),
(483960, 26, 1637.4122, 838.4397, 35.469112, NULL, 0, 0, 0, 100, 0),
(483960, 27, 1658.3192, 838.1326, 33.92224, NULL, 0, 0, 0, 100, 0),
(483960, 28, 1694.0593, 837.08527, 35.55463, NULL, 0, 0, 0, 100, 0),
(483960, 29, 1714.5634, 836.6511, 35.54724, NULL, 0, 0, 0, 100, 0),
(483960, 30, 1733.8491, 836.57697, 33.922237, NULL, 0, 0, 0, 100, 0),
(483960, 31, 1752.8463, 836.4012, 33.92224, NULL, 0, 0, 0, 100, 0),
(483960, 32, 1768.3956, 836.36, 35.32849, NULL, 0, 0, 0, 100, 0),
(483960, 33, 1774.8724, 836.3321, 36.32849, NULL, 0, 0, 0, 100, 0);

DELETE FROM `waypoint_data` WHERE `id` IN (481940);
INSERT INTO `waypoint_data` (`id`, `point`, `position_x`, `position_y`, `position_z`, `orientation`, `delay`, `move_type`, `action`, `action_chance`, `wpguid`) VALUES
(481940, 1, 1662.921, 1031.9761, 15.985676, NULL, 0, 0, 0, 100, 0),
(481940, 2, 1671.6886, 1044.9114, 15.985804, NULL, 0, 0, 0, 100, 0),
(481940, 3, 1688.9246, 1056.0344, 15.985803, NULL, 0, 0, 0, 100, 0),
(481940, 4, 1698.7399, 1058.056, 18.015984, NULL, 0, 0, 0, 100, 0),
(481940, 5, 1712.9889, 1058.221, 18.015984, NULL, 0, 0, 0, 100, 0),
(481940, 6, 1732.618, 1055.4069, 15.985794, NULL, 0, 0, 0, 100, 0),
(481940, 7, 1743.3898, 1041.8229, 15.985684, NULL, 0, 0, 0, 100, 0),
(481940, 8, 1756.496, 1019.7752, 15.985794, NULL, 0, 0, 0, 100, 0),
(481940, 9, 1776.5123, 986.125, 15.98579, NULL, 0, 0, 0, 100, 0),
(481940, 10, 1756.496, 1019.7752, 15.985794, NULL, 0, 0, 0, 100, 0),
(481940, 11, 1743.3898, 1041.8229, 15.985684, NULL, 0, 0, 0, 100, 0),
(481940, 12, 1732.618, 1055.4069, 15.985794, NULL, 0, 0, 0, 100, 0),
(481940, 13, 1712.9889, 1058.221, 18.015984, NULL, 0, 0, 0, 100, 0),
(481940, 14, 1698.7399, 1058.056, 18.015984, NULL, 0, 0, 0, 100, 0),
(481940, 15, 1688.9246, 1056.0344, 15.985803, NULL, 0, 0, 0, 100, 0),
(481940, 16, 1671.6886, 1044.9114, 15.985804, NULL, 0, 0, 0, 100, 0),
(481940, 17, 1662.921, 1031.9761, 15.985676, NULL, 0, 0, 0, 100, 0),
(481940, 18, 1657.1139, 1022.9647, 15.985677, NULL, 0, 0, 0, 100, 0),
(481940, 19, 1651.9424, 1013.9453, 15.9857855, NULL, 0, 0, 0, 100, 0),
(481940, 20, 1647.3245, 996.7984, 15.986502, NULL, 0, 0, 0, 100, 0),
(481940, 21, 1646.149, 978.1148, 15.986507, NULL, 0, 0, 0, 100, 0),
(481940, 22, 1646.2843, 964.768, 15.979303, NULL, 0, 0, 0, 100, 0),
(481940, 23, 1646.149, 978.1148, 15.986507, NULL, 0, 0, 0, 100, 0),
(481940, 24, 1647.3245, 996.7984, 15.986502, NULL, 0, 0, 0, 100, 0),
(481940, 25, 1651.9424, 1013.9453, 15.9857855, NULL, 0, 0, 0, 100, 0),
(481940, 26, 1657.1139, 1022.9647, 15.985677, NULL, 0, 0, 0, 100, 0);

-- Delete useless waypoints
DELETE FROM `waypoint_data` WHERE `id` IN (483980, 483590, 483930, 483950, 483730, 530260, 481610, 483920, 481950);

-- Delete Creature_addon for Arch mage, Dusk and Dawn Priests
DELETE FROM `creature_addon` WHERE (`guid` IN (48398, 48359, 48393, 48395, 48373, 53026, 48161, 48392, 48195));

-- Update Movement Type
UPDATE `creature` SET `MovementType` = 0 WHERE (`guid` IN (48398, 48359, 48393, 48395, 48373, 53026, 48161, 48392, 48195));

-- Add formations
DELETE FROM `creature_formations` WHERE `leaderGUID` = 48194;
INSERT INTO `creature_formations` (`leaderGUID`, `memberGUID`, `dist`, `angle`, `groupAI`, `point_1`, `point_2`) VALUES
(48194, 48194, 0, 0, 515, 0, 0),
(48194, 48393, 2, 90, 515, 0, 0),
(48194, 48359, 2, 180, 515, 0, 0),
(48194, 48398, 2, 270, 515, 0, 0);

DELETE FROM `creature_formations` WHERE `leaderGUID` = 48396;
INSERT INTO `creature_formations` (`leaderGUID`, `memberGUID`, `dist`, `angle`, `groupAI`, `point_1`, `point_2`) VALUES
(48396, 48396, 0, 0, 515, 0, 0),
(48396, 48395, 2, 90, 515, 0, 0),
(48396, 48373, 2, 180, 515, 0, 0),
(48396, 53026, 2, 270, 515, 0, 0);

DELETE FROM `creature_formations` WHERE `leaderGUID` = 48397;
INSERT INTO `creature_formations` (`leaderGUID`, `memberGUID`, `dist`, `angle`, `groupAI`, `point_1`, `point_2`) VALUES
(48397, 48397, 0, 0, 515, 0, 0),
(48397, 48195, 2, 90, 515, 0, 0),
(48397, 48392, 2, 180, 515, 0, 0),
(48397, 48161, 2, 270, 515, 0, 0);

-- Remove SmartAI row 2 (or 3) from general AIs
DELETE FROM `smart_scripts` WHERE (`entryorguid` IN (25369, 25367)) AND (`source_type` = 0) AND (`id` IN (2));
DELETE FROM `smart_scripts` WHERE (`entryorguid` IN (25363, 25370, 25371)) AND (`source_type` = 0) AND (`id` IN (3));

-- Add don't override sai
UPDATE `creature_template` SET `flags_extra` = `flags_extra`|134217728 WHERE (`entry` IN (25369, 25363, 25370, 25367, 25371));

-- Add Comments
UPDATE `creature` SET `Comment` = "has guid specific SAI" WHERE (`id1` = 25369) AND (`guid` IN (42573, 42574, 42582, 42586, 42587, 42591, 42592));
UPDATE `creature` SET `Comment` = "has guid specific SAI" WHERE (`id1` = 25363) AND (`guid` IN (54820, 54817, 54825, 54824));
UPDATE `creature` SET `Comment` = "has guid specific SAI" WHERE (`id1` = 25370) AND (`guid` IN (42647, 42656, 42657, 42640));
UPDATE `creature` SET `Comment` = "has guid specific SAI" WHERE (`id1` = 25367) AND (`guid` IN (54832, 54834, 54835, 54829));
UPDATE `creature` SET `Comment` = "has guid specific SAI" WHERE (`id1` = 25371) AND (`guid` IN (43439, 42894, 43654, 42660, 42659));

-- Add row 2 in GuidAI
DELETE FROM `smart_scripts` WHERE (`entryorguid` IN (-42573, -42574, -42582, -42586, -42587, -42591, -42592, -54832, -54834, -54835, -54829)) AND (`source_type` = 0) AND (`id` IN (2));
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(-42573, 0, 2, 0, 1, 0, 100, 0, 0, 0, 15000, 45000, 0, 0, 11, 46319, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Sunblade Vindicator - Out of Combat - Cast \'Felblood Channel\''),
(-42574, 0, 2, 0, 1, 0, 100, 0, 0, 0, 15000, 45000, 0, 0, 11, 46319, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Sunblade Vindicator - Out of Combat - Cast \'Felblood Channel\''),
(-42582, 0, 2, 0, 1, 0, 100, 0, 0, 0, 15000, 45000, 0, 0, 11, 46319, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Sunblade Vindicator - Out of Combat - Cast \'Felblood Channel\''),
(-42586, 0, 2, 0, 1, 0, 100, 0, 0, 0, 15000, 45000, 0, 0, 11, 46319, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Sunblade Vindicator - Out of Combat - Cast \'Felblood Channel\''),
(-42587, 0, 2, 0, 1, 0, 100, 0, 0, 0, 15000, 45000, 0, 0, 11, 46319, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Sunblade Vindicator - Out of Combat - Cast \'Felblood Channel\''),
(-42591, 0, 2, 0, 1, 0, 100, 0, 0, 0, 15000, 45000, 0, 0, 11, 46319, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Sunblade Vindicator - Out of Combat - Cast \'Felblood Channel\''),
(-42592, 0, 2, 0, 1, 0, 100, 0, 0, 0, 15000, 45000, 0, 0, 11, 46319, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Sunblade Vindicator - Out of Combat - Cast \'Felblood Channel\''),
(-54832, 0, 2, 0, 1, 0, 100, 0, 0, 0, 15000, 45000, 0, 0, 11, 46319, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Sunblade Arch Mage - Out of Combat - Cast \'Felblood Channel\''),
(-54834, 0, 2, 0, 1, 0, 100, 0, 0, 0, 15000, 45000, 0, 0, 11, 46319, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Sunblade Arch Mage - Out of Combat - Cast \'Felblood Channel\''),
(-54835, 0, 2, 0, 1, 0, 100, 0, 0, 0, 15000, 45000, 0, 0, 11, 46319, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Sunblade Arch Mage - Out of Combat - Cast \'Felblood Channel\''),
(-54829, 0, 2, 0, 1, 0, 100, 0, 0, 0, 15000, 45000, 0, 0, 11, 46319, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Sunblade Arch Mage - Out of Combat - Cast \'Felblood Channel\'');

DELETE FROM `smart_scripts` WHERE (`entryorguid` IN (-54820, -54817, -54825, -54824, -42647, -42656, -42657, -42640, -43439, -42894, -43654, -42660, -42659)) AND (`source_type` = 0) AND (`id` IN (3));
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(-54820, 0, 3, 0, 1, 0, 100, 0, 0, 0, 15000, 45000, 0, 0, 11, 46319, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Sunblade Cabalist - Out of Combat - Cast \'Felblood Channel\''),
(-54817, 0, 3, 0, 1, 0, 100, 0, 0, 0, 15000, 45000, 0, 0, 11, 46319, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Sunblade Cabalist - Out of Combat - Cast \'Felblood Channel\''),
(-54825, 0, 3, 0, 1, 0, 100, 0, 0, 0, 15000, 45000, 0, 0, 11, 46319, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Sunblade Cabalist - Out of Combat - Cast \'Felblood Channel\''),
(-54824, 0, 3, 0, 1, 0, 100, 0, 0, 0, 15000, 45000, 0, 0, 11, 46319, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Sunblade Cabalist - Out of Combat - Cast \'Felblood Channel\''),
(-42647, 0, 3, 0, 1, 0, 100, 0, 0, 0, 15000, 45000, 0, 0, 11, 46319, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Sunblade Dusk Priest - Out of Combat - Cast \'Felblood Channel\''),
(-42656, 0, 3, 0, 1, 0, 100, 0, 0, 0, 15000, 45000, 0, 0, 11, 46319, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Sunblade Dusk Priest - Out of Combat - Cast \'Felblood Channel\''),
(-42657, 0, 3, 0, 1, 0, 100, 0, 0, 0, 15000, 45000, 0, 0, 11, 46319, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Sunblade Dusk Priest - Out of Combat - Cast \'Felblood Channel\''),
(-42640, 0, 3, 0, 1, 0, 100, 0, 0, 0, 15000, 45000, 0, 0, 11, 46319, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Sunblade Dusk Priest - Out of Combat - Cast \'Felblood Channel\''),
(-43439, 0, 3, 0, 1, 0, 100, 0, 0, 0, 15000, 45000, 0, 0, 11, 46319, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Sunblade Dawn Priest - Out of Combat - Cast \'Felblood Channel\''),
(-42894, 0, 3, 0, 1, 0, 100, 0, 0, 0, 15000, 45000, 0, 0, 11, 46319, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Sunblade Dawn Priest - Out of Combat - Cast \'Felblood Channel\''),
(-43654, 0, 3, 0, 1, 0, 100, 0, 0, 0, 15000, 45000, 0, 0, 11, 46319, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Sunblade Dawn Priest - Out of Combat - Cast \'Felblood Channel\''),
(-42660, 0, 3, 0, 1, 0, 100, 0, 0, 0, 15000, 45000, 0, 0, 11, 46319, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Sunblade Dawn Priest - Out of Combat - Cast \'Felblood Channel\''),
(-42659, 0, 3, 0, 1, 0, 100, 0, 0, 0, 15000, 45000, 0, 0, 11, 46319, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Sunblade Dawn Priest - Out of Combat - Cast \'Felblood Channel\'');
