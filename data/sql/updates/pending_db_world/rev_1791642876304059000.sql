--
-- The Light of Dawn: aggro auras as seen in sniffs (53624 Scourge Aggro Aura, 53627 Hero Aggro Aura)
UPDATE `creature_template_addon` SET `auras` = '' WHERE `entry` IN (29176, 29177, 29178, 29179, 29180, 29181, 29182);
UPDATE `creature_template_addon` SET `auras` = '53627' WHERE `entry` IN (29199, 29200, 29204);
UPDATE `creature_template_addon` SET `auras` = '53624 53627' WHERE `entry` = 29190;

-- Sniffed points where replacements of dead troops appear. The script only reads this group, it never summons it
DELETE FROM `creature_summon_groups` WHERE `summonerId` = 29173 AND `summonerType` = 0 AND `groupId` = 31;
INSERT INTO `creature_summon_groups` (`summonerId`, `summonerType`, `groupId`, `entry`, `position_x`, `position_y`, `position_z`, `orientation`, `summonType`, `summonTime`, `Comment`) VALUES
(29173, 0, 31, 29219, 2295.026, -5276.9087, 81.89136, 5.6374, 6, 3000, 'Highlord Darion Mograine - Volatile Ghoul replacement point'),
(29173, 0, 31, 29219, 2285.7795, -5272.699, 81.9777, 0.7679, 6, 3000, 'Highlord Darion Mograine - Volatile Ghoul replacement point'),
(29173, 0, 31, 29219, 2313.3982, -5276.181, 82.15338, 4.9393, 6, 3000, 'Highlord Darion Mograine - Volatile Ghoul replacement point'),
(29173, 0, 31, 29219, 2301.9246, -5262.53, 82.50509, 2.6005, 6, 3000, 'Highlord Darion Mograine - Volatile Ghoul replacement point'),
(29173, 0, 31, 29219, 2296.253, -5285.7734, 82.03949, 3.927, 6, 3000, 'Highlord Darion Mograine - Volatile Ghoul replacement point'),
(29173, 0, 31, 29219, 2293.0913, -5259.2905, 82.16296, 6.0563, 6, 3000, 'Highlord Darion Mograine - Volatile Ghoul replacement point'),
(29173, 0, 31, 29219, 2276.103, -5270.715, 81.68881, 2.3213, 6, 3000, 'Highlord Darion Mograine - Volatile Ghoul replacement point'),
(29173, 0, 31, 29219, 2258.3098, -5289.0654, 82.09905, 5.8294, 6, 3000, 'Highlord Darion Mograine - Volatile Ghoul replacement point'),
(29173, 0, 31, 29219, 2270.9946, -5281.1245, 82.10622, 4.1539, 6, 3000, 'Highlord Darion Mograine - Volatile Ghoul replacement point'),
(29173, 0, 31, 29219, 2262.448, -5298.4688, 82.25065, 0.6283, 6, 3000, 'Highlord Darion Mograine - Volatile Ghoul replacement point'),
(29173, 0, 31, 29219, 2250.3083, -5274.0923, 80.93935, 1.7802, 6, 3000, 'Highlord Darion Mograine - Volatile Ghoul replacement point'),
(29173, 0, 31, 29219, 2267.464, -5259.4253, 78.83966, 5.4105, 6, 3000, 'Highlord Darion Mograine - Volatile Ghoul replacement point'),
(29173, 0, 31, 29219, 2234.6572, -5292.572, 81.91735, 0.6458, 6, 3000, 'Highlord Darion Mograine - Volatile Ghoul replacement point'),
(29173, 0, 31, 29219, 2275.9646, -5249.3726, 77.764206, 0.6981, 6, 3000, 'Highlord Darion Mograine - Volatile Ghoul replacement point'),
(29173, 0, 31, 29219, 2282.4753, -5304.75, 86.22796, 1.885, 6, 3000, 'Highlord Darion Mograine - Volatile Ghoul replacement point'),
(29173, 0, 31, 29219, 2264.122, -5272.6987, 81.41122, 5.2709, 6, 3000, 'Highlord Darion Mograine - Volatile Ghoul replacement point'),
(29173, 0, 31, 29219, 2286.576, -5250.5767, 80.99425, 2.9845, 6, 3000, 'Highlord Darion Mograine - Volatile Ghoul replacement point'),
(29173, 0, 31, 29219, 2240.8242, -5284.474, 81.58487, 2.5133, 6, 3000, 'Highlord Darion Mograine - Volatile Ghoul replacement point'),
(29173, 0, 31, 29219, 2272.1106, -5304.416, 84.923996, 1.6232, 6, 3000, 'Highlord Darion Mograine - Volatile Ghoul replacement point'),
(29173, 0, 31, 29219, 2310.2856, -5295.1416, 82.0796, 0.733, 6, 3000, 'Highlord Darion Mograine - Volatile Ghoul replacement point'),
(29173, 0, 31, 29219, 2295.9817, -5302.4907, 82.0796, 1.5533, 6, 3000, 'Highlord Darion Mograine - Volatile Ghoul replacement point'),
(29173, 0, 31, 29219, 2247.7031, -5305.8784, 82.25065, 5.7072, 6, 3000, 'Highlord Darion Mograine - Volatile Ghoul replacement point'),
(29173, 0, 31, 29219, 2245.9927, -5320.12, 82.25065, 6.1087, 6, 3000, 'Highlord Darion Mograine - Volatile Ghoul replacement point'),
(29173, 0, 31, 29219, 2272.4219, -5322.0767, 88.022125, 5.5676, 6, 3000, 'Highlord Darion Mograine - Volatile Ghoul replacement point'),
(29173, 0, 31, 29206, 2307.5142, -5284.0845, 81.9736, 0.6458, 6, 3000, 'Highlord Darion Mograine - Warrior of the Frozen Wastes replacement point'),
(29173, 0, 31, 29206, 2283.6094, -5296.7085, 84.63256, 2.9671, 6, 3000, 'Highlord Darion Mograine - Warrior of the Frozen Wastes replacement point'),
(29173, 0, 31, 29206, 2242.149, -5248.215, 75.534256, 2.8798, 6, 3000, 'Highlord Darion Mograine - Warrior of the Frozen Wastes replacement point'),
(29173, 0, 31, 29206, 2258.887, -5267.227, 79.57617, 6.0563, 6, 3000, 'Highlord Darion Mograine - Warrior of the Frozen Wastes replacement point'),
(29173, 0, 31, 29206, 2298.3862, -5244.812, 84.400024, 0.6109, 6, 3000, 'Highlord Darion Mograine - Warrior of the Frozen Wastes replacement point'),
(29173, 0, 31, 29206, 2283.707, -5259.194, 81.04208, 2.2864, 6, 3000, 'Highlord Darion Mograine - Warrior of the Frozen Wastes replacement point'),
(29173, 0, 31, 29190, 2270.1936, -5185.3076, 81.111244, 5.4105, 6, 3000, 'Highlord Darion Mograine - Flesh Behemoth replacement point'),
(29173, 0, 31, 29190, 2213.0322, -5278.545, 83.55096, 3.3859, 6, 3000, 'Highlord Darion Mograine - Flesh Behemoth replacement point'),
(29173, 0, 31, 29190, 2244.0369, -5338.109, 85.05786, 0.2967, 6, 3000, 'Highlord Darion Mograine - Flesh Behemoth replacement point'),
(29173, 0, 31, 29190, 2210.0312, -5311.03, 89.637794, 3.4907, 6, 3000, 'Highlord Darion Mograine - Flesh Behemoth replacement point'),
(29173, 0, 31, 29174, 2261.1572, -5275.127, 81.77896, 0.1745, 6, 3000, 'Highlord Darion Mograine - Defender of the Light replacement point'),
(29173, 0, 31, 29174, 2271.9434, -5266.6606, 80.90213, 6.2308, 6, 3000, 'Highlord Darion Mograine - Defender of the Light replacement point'),
(29173, 0, 31, 29174, 2290.819, -5267.065, 81.941925, 0.3665, 6, 3000, 'Highlord Darion Mograine - Defender of the Light replacement point'),
(29173, 0, 31, 29174, 2285.566, -5264.0024, 81.67405, 0.2618, 6, 3000, 'Highlord Darion Mograine - Defender of the Light replacement point'),
(29173, 0, 31, 29174, 2266.339, -5270.7095, 81.132164, 0.0698, 6, 3000, 'Highlord Darion Mograine - Defender of the Light replacement point'),
(29173, 0, 31, 29174, 2249.9502, -5287.7188, 82.65626, 0.4014, 6, 3000, 'Highlord Darion Mograine - Defender of the Light replacement point'),
(29173, 0, 31, 29174, 2247.0242, -5291.072, 82.668, 0.5061, 6, 3000, 'Highlord Darion Mograine - Defender of the Light replacement point'),
(29173, 0, 31, 29174, 2296.0364, -5271.6216, 81.92523, 0.5585, 6, 3000, 'Highlord Darion Mograine - Defender of the Light replacement point'),
(29173, 0, 31, 29174, 2257.4792, -5279.241, 82.29593, 0.2793, 6, 3000, 'Highlord Darion Mograine - Defender of the Light replacement point'),
(29173, 0, 31, 29174, 2253.1357, -5283.868, 82.568855, 0.3665, 6, 3000, 'Highlord Darion Mograine - Defender of the Light replacement point'),
(29173, 0, 31, 29174, 2300.4114, -5275.801, 81.85671, 0.7505, 6, 3000, 'Highlord Darion Mograine - Defender of the Light replacement point'),
(29173, 0, 31, 29174, 2305.068, -5280.101, 81.86087, 0.9425, 6, 3000, 'Highlord Darion Mograine - Defender of the Light replacement point'),
(29173, 0, 31, 29174, 2307.005, -5285.1777, 82.06482, 1.0821, 6, 3000, 'Highlord Darion Mograine - Defender of the Light replacement point'),
(29173, 0, 31, 29174, 2278.5945, -5264.2026, 81.12022, 6.1959, 6, 3000, 'Highlord Darion Mograine - Defender of the Light replacement point');

-- 291730: Highlord Darion Mograine's sniffed march to the chapel
-- 291731: sniffed points the opening Scourge wave runs to. Not a route, the script picks one node per unit
-- 291732: sniffed march of the Flesh Behemoth summoned at 2453.18, -5183.31
-- 291733, 291734: the two sniffed marches of the Flesh Behemoth summoned at 2435.99, -5097.61.
-- Points 2 to 4 of both only have a sniffed x and y, their z is an estimate the script corrects with a ground lookup
-- 291735: points the troops fight at. Not a route, the script picks one node. Point 1 is the middle of the battle
-- 291736: places the NPCs walk to in the outro. Not a route, the script reads each point by its number:
-- 1 Orbaz flees, 2 Koltira, 3 Thassarian, 4 Darion, 5 Alexandros, 6 Darion (ghost), 7 Tirion, 8 Lich King, 9 and 10 Tirion
DELETE FROM `waypoint_data` WHERE `id` IN (291730, 291731, 291732, 291733, 291734, 291735, 291736);
INSERT INTO `waypoint_data` (`id`, `point`, `position_x`, `position_y`, `position_z`, `orientation`, `velocity`, `delay`, `smoothTransition`, `move_type`, `action`, `action_chance`, `wpguid`) VALUES
(291730, 1, 2430.2861, -5166.55, 80.86428, NULL, 0, 0, 0, 1, 0, 100, 0),
(291730, 2, 2409.7349, -5180.9673, 78.170746, NULL, 0, 0, 0, 1, 0, 100, 0),
(291730, 3, 2388.6926, -5191.797, 74.011154, NULL, 0, 0, 0, 1, 0, 100, 0),
(291730, 4, 2371.6829, -5206.2803, 76.64493, NULL, 0, 0, 0, 1, 0, 100, 0),
(291730, 5, 2358.5476, -5218.236, 82.25828, NULL, 0, 0, 0, 1, 0, 100, 0),
(291730, 6, 2344.3154, -5232.941, 85.427414, NULL, 0, 0, 0, 1, 0, 100, 0),
(291730, 7, 2332.4934, -5247.6587, 84.57063, NULL, 0, 0, 0, 1, 0, 100, 0),
(291730, 8, 2311.1836, -5264.96, 82.660675, NULL, 0, 0, 0, 1, 0, 100, 0),
(291730, 9, 2280.8638, -5280.935, 82.38957, NULL, 0, 0, 0, 1, 0, 100, 0),
(291731, 1, 2308.37, -5295.09, 82.03, NULL, 0, 0, 0, 1, 0, 100, 0),
(291731, 2, 2265.38, -5271.80, 81.29, NULL, 0, 0, 0, 1, 0, 100, 0),
(291731, 3, 2314.73, -5272.57, 82.26, NULL, 0, 0, 0, 1, 0, 100, 0),
(291731, 4, 2307.02, -5277.61, 81.93, NULL, 0, 0, 0, 1, 0, 100, 0),
(291731, 5, 2292.83, -5279.81, 81.95, NULL, 0, 0, 0, 1, 0, 100, 0),
(291731, 6, 2292.99, -5253.11, 82.72, NULL, 0, 0, 0, 1, 0, 100, 0),
(291731, 7, 2283.77, -5307.46, 86.91, NULL, 0, 0, 0, 1, 0, 100, 0),
(291731, 8, 2279.99, -5290.94, 83.55, NULL, 0, 0, 0, 1, 0, 100, 0),
(291732, 1, 2408.2864, -5176.787, 79.74065, NULL, 0, 0, 0, 1, 0, 100, 0),
(291732, 2, 2354.3633, -5207.5884, 79.04297, NULL, 0, 0, 0, 1, 0, 100, 0),
(291732, 3, 2299.7175, -5247.5063, 84.34213, NULL, 0, 0, 0, 1, 0, 100, 0),
(291732, 4, 2300.2935, -5285.48, 81.90275, NULL, 0, 0, 0, 1, 0, 100, 0),
(291733, 1, 2378.0305, -5102.99, 78.343155, NULL, 0, 0, 0, 1, 0, 100, 0),
(291733, 2, 2377.97, -5138.15, 82.0, NULL, 0, 0, 0, 1, 0, 100, 0),
(291733, 3, 2362.46, -5200.23, 77.0, NULL, 0, 0, 0, 1, 0, 100, 0),
(291733, 4, 2306.52, -5217.37, 80.0, NULL, 0, 0, 0, 1, 0, 100, 0),
(291733, 5, 2236.011, -5204.351, 74.76431, NULL, 0, 0, 0, 1, 0, 100, 0),
(291733, 6, 2221.5903, -5241.5303, 78.16467, NULL, 0, 0, 0, 1, 0, 100, 0),
(291733, 7, 2246.648, -5279.3325, 81.53281, NULL, 0, 0, 0, 1, 0, 100, 0),
(291734, 1, 2378.0305, -5102.99, 78.343155, NULL, 0, 0, 0, 1, 0, 100, 0),
(291734, 2, 2375.70, -5171.65, 78.0, NULL, 0, 0, 0, 1, 0, 100, 0),
(291734, 3, 2326.33, -5203.15, 80.0, NULL, 0, 0, 0, 1, 0, 100, 0),
(291734, 4, 2281.33, -5211.55, 80.0, NULL, 0, 0, 0, 1, 0, 100, 0),
(291734, 5, 2236.011, -5204.351, 74.76431, NULL, 0, 0, 0, 1, 0, 100, 0),
(291734, 6, 2221.5903, -5241.5303, 78.16467, NULL, 0, 0, 0, 1, 0, 100, 0),
(291734, 7, 2246.648, -5279.3325, 81.53281, NULL, 0, 0, 0, 1, 0, 100, 0),
(291735, 1, 2280.40, -5276.56, 82.11, 4.8, 0, 0, 0, 1, 0, 100, 0),
(291735, 2, 2279.68, -5256.75, 79.79, 4.8, 0, 0, 0, 1, 0, 100, 0),
(291735, 3, 2256.43, -5281.3, 82.29, 5.0, 0, 0, 0, 1, 0, 100, 0),
(291735, 4, 2251.87, -5304.08, 82.17, 4.8, 0, 0, 0, 1, 0, 100, 0),
(291735, 5, 2244.88, -5256.03, 74.88, 5.8, 0, 0, 0, 1, 0, 100, 0),
(291735, 6, 2294.29, -5281.35, 81.91, 4.8, 0, 0, 0, 1, 0, 100, 0),
(291735, 7, 2314.2, -5268.1, 82.43, 3.6, 0, 0, 0, 1, 0, 100, 0),
(291735, 8, 2289.72, -5299.65, 83.49, 3.2, 0, 0, 0, 1, 0, 100, 0),
(291735, 9, 2274.02, -5303.58, 85.05, 1.4, 0, 0, 0, 1, 0, 100, 0),
(291735, 10, 2258.42, -5307.72, 81.98, 0.1, 0, 0, 0, 1, 0, 100, 0),
(291736, 1, 2169.1, -5227.1, 82.59, 5.7, 0, 0, 0, 1, 0, 100, 0),
(291736, 2, 2289.259, -5280.355, 86.112, NULL, 0, 0, 0, 1, 0, 100, 0),
(291736, 3, 2273.289, -5273.675, 86.701, NULL, 0, 0, 0, 1, 0, 100, 0),
(291736, 4, 2280.81, -5284.09, 86.608, NULL, 0, 0, 0, 1, 0, 100, 0),
(291736, 5, 2281.156, -5259.934, 80.647, NULL, 0, 0, 0, 1, 0, 100, 0),
(291736, 6, 2281.093, -5263.013, 81.125, NULL, 0, 0, 0, 1, 0, 100, 0),
(291736, 7, 2283.896, -5287.914, 83.066, NULL, 0, 0, 0, 1, 0, 100, 0),
(291736, 8, 2280.687, -5262.276, 81.082634, NULL, 0, 0, 0, 1, 0, 100, 0),
(291736, 9, 2264.27, -5267.29, 80.16, NULL, 0, 0, 0, 1, 0, 100, 0),
(291736, 10, 2270.99, -5278.00, 81.89, NULL, 0, 0, 0, 1, 0, 100, 0);

-- Defenders of the Light that surround the Scourge leaders in the outro
DELETE FROM `creature_summon_groups` WHERE `summonerId` = 29173 AND `summonerType` = 0 AND `groupId` = 32;
INSERT INTO `creature_summon_groups` (`summonerId`, `summonerType`, `groupId`, `entry`, `position_x`, `position_y`, `position_z`, `orientation`, `summonType`, `summonTime`, `Comment`) VALUES
(29173, 0, 32, 29174, 2276.66, -5273.60, 81.86, 5.14, 5, 0, 'Highlord Darion Mograine - Defender of the Light (outro)'),
(29173, 0, 32, 29174, 2272.11, -5279.08, 82.01, 5.69, 5, 0, 'Highlord Darion Mograine - Defender of the Light (outro)'),
(29173, 0, 32, 29174, 2285.11, -5276.73, 82.08, 4.23, 5, 0, 'Highlord Darion Mograine - Defender of the Light (outro)'),
(29173, 0, 32, 29174, 2290.06, -5286.41, 82.51, 3.16, 5, 0, 'Highlord Darion Mograine - Defender of the Light (outro)');

-- Holy Lightning that strikes when Highlord Tirion Fordring arrives
DELETE FROM `gameobject_summon_groups` WHERE `summonerId` = 29175 AND `summonerType` = 0 AND `groupId` = 0;
INSERT INTO `gameobject_summon_groups` (`summonerId`, `summonerType`, `groupId`, `entry`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `respawnTime`, `Comment`) VALUES
(29175, 0, 0, 191301, 2254.84, -5298.75, 82.168, 1.134, 0, 0, 0.537102, 0.843517, 20, 'Highlord Tirion Fordring - Holy Lightning'),
(29175, 0, 0, 191301, 2296.24, -5296.44, 81.9964, 5.3398, 0, 0, 0.454395, -0.8908, 20, 'Highlord Tirion Fordring - Holy Lightning'),
(29175, 0, 0, 191301, 2314.29, -5261.78, 83.1349, 3.05822, 0, 0, 0.999131, 0.0416735, 20, 'Highlord Tirion Fordring - Holy Lightning'),
(29175, 0, 0, 191301, 2278.43, -5270.14, 81.7247, 0.70988, 0, 0, 0.347534, 0.937667, 20, 'Highlord Tirion Fordring - Holy Lightning');

-- Outro NPCs, one per group so the script can summon each at its own time
DELETE FROM `creature_summon_groups` WHERE `summonerId` = 29173 AND `summonerType` = 0 AND `groupId` IN (33, 34, 35, 36);
INSERT INTO `creature_summon_groups` (`summonerId`, `summonerType`, `groupId`, `entry`, `position_x`, `position_y`, `position_z`, `orientation`, `summonType`, `summonTime`, `Comment`) VALUES
(29173, 0, 33, 29175, 2165.711, -5266.1235, 95.5025, 0.13962634, 2, 600000, 'Highlord Darion Mograine - Highlord Tirion Fordring (outro)'),
(29173, 0, 34, 29227, 2281.198, -5257.397, 80.224, 4.66, 2, 300000, 'Highlord Darion Mograine - Highlord Alexandros Mograine (outro)'),
(29173, 0, 35, 29228, 2281.294, -5281.895, 82.445, 1.35, 2, 300000, 'Highlord Darion Mograine - Darion Mograine (outro)'),
(29173, 0, 36, 29183, 2280.304, -5257.205, 80.09781, 4.6251, 2, 300000, 'Highlord Darion Mograine - The Lich King (outro)');
