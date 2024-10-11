-- DB update 2022_10_15_08 -> 2022_10_15_09
-- Durotar Food Crate Water Barrel Gameobject Overhaul

/* Remove existing Water Barrels 3658--some of these may be correct, but we have all the spawns now so this will be easier */
DELETE FROM `gameobject` WHERE `guid` IN (12551, 12397, 12395, 12351, 12391, 12498, 12550, 12393);
/* Remove existing Food Crates 3719 as well */
DELETE FROM `gameobject` WHERE `guid` IN (12553, 12549, 12502, 12501, 12350, 12346, 12602, 12505, 12392);
SET @GAMEOBJECTBLOCK :=44477; -- There is a large free block of gameobject guids starting there that fits all 122 objects
DELETE FROM `gameobject` WHERE `guid` BETWEEN @GAMEOBJECTBLOCK+0 AND @GAMEOBJECTBLOCK+121;
INSERT INTO `gameobject` (`guid`, `id`, `map`, `zoneId`, `areaId`, `spawnMask`, `phaseMask`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`, `ScriptName`, `VerifiedBuild`) VALUES
-- Durotar Food Water GO Pool I Kolkar Crag
(@GAMEOBJECTBLOCK+0, 3658, 1, 0, 0, 1, 1, -1045.77, -4608.98, 25.831, 0.0349062, 0, 0, 0.0174522, 0.999848, 420, 255, 1, '', 0), -- .go xyz -1045.77 -4608.98
(@GAMEOBJECTBLOCK+1, 3719, 1, 0, 0, 1, 1, -1045.77, -4608.98, 25.831, 0.0349062, 0, 0, 0.0174522, 0.999848, 420, 255, 1, '', 0), -- .go xyz -1045.77 -4608.98
(@GAMEOBJECTBLOCK+2, 3658, 1, 0, 0, 1, 1, -912.076, -4474.18, 29.7029, 0.0349062, 0, 0, 0.0174522, 0.999848, 420, 255, 1, '', 0), -- .go xyz -912.076 -4474.18
(@GAMEOBJECTBLOCK+3, 3719, 1, 0, 0, 1, 1, -912.076, -4474.18, 29.7029, 0.0349062, 0, 0, 0.0174522, 0.999848, 420, 255, 1, '', 0), -- .go xyz -912.076 -4474.18
(@GAMEOBJECTBLOCK+4, 3658, 1, 0, 0, 1, 1, -970.388, -4401.15, 29.264133, 3.735006, 0, 0, -0.956305, 0.292372, 420, 255, 1, "", 0), -- .go xyz -970.388 -4401.15
(@GAMEOBJECTBLOCK+5, 3719, 1, 0, 0, 1, 1, -970.388, -4401.15, 29.264133, 3.735006, 0, 0, -0.956305, 0.292372, 420, 255, 1, "", 0), -- .go xyz -970.388 -4401.15
-- Durotar Food Water GO Pool II x4 Echo Isles
(@GAMEOBJECTBLOCK+6, 3658, 1, 0, 0, 1, 1, -1336.29, -5200.97, -0.091026, 5.60251, 0, 0, -0.333807, 0.942641, 420, 255, 1, '', 0), -- .go xyz -1336.29 -5200.97
(@GAMEOBJECTBLOCK+7, 3719, 1, 0, 0, 1, 1, -1336.29, -5200.97, -0.091026, 5.60251, 0, 0, -0.333807, 0.942641, 420, 255, 1, '', 0), -- .go xyz -1336.29 -5200.97
(@GAMEOBJECTBLOCK+8, 3658, 1, 0, 0, 1, 1, -968.305, -5199.9, 0.064211, 0.366518, 0, 0, 0.182235, 0.983255, 420, 255, 1, '', 0), -- .go xyz -968.305 -5199.9
(@GAMEOBJECTBLOCK+9, 3719, 1, 0, 0, 1, 1, -968.305, -5199.9, 0.064211, 0.366518, 0, 0, 0.182235, 0.983255, 420, 255, 1, '', 0), -- .go xyz -968.305 -5199.9
(@GAMEOBJECTBLOCK+10, 3658, 1, 0, 0, 1, 1, -758.5, -5366.35, -0.032768, 4.2237, 0, 0, -0.857167, 0.515038, 420, 255, 1, '', 0), -- .go xyz -758.5 -5366.35
(@GAMEOBJECTBLOCK+11, 3719, 1, 0, 0, 1, 1, -758.5, -5366.35, -0.032768, 4.2237, 0, 0, -0.857167, 0.515038, 420, 255, 1, '', 0), -- .go xyz -758.5 -5366.35
(@GAMEOBJECTBLOCK+12, 3658, 1, 0, 0, 1, 1, -1004.27, -5600.04, -0.21399, 5.98648, 0, 0, -0.147809, 0.989016, 420, 255, 1, '', 0), -- .go xyz -1004.27 -5600.04
(@GAMEOBJECTBLOCK+13, 3719, 1, 0, 0, 1, 1, -1004.27, -5600.04, -0.21399, 5.98648, 0, 0, -0.147809, 0.989016, 420, 255, 1, '', 0), -- .go xyz -1004.27 -5600.04
(@GAMEOBJECTBLOCK+14, 3658, 1, 0, 0, 1, 1, -641.353, -5689.82, -0.171481, 5.2709, 0, 0, -0.484809, 0.87462, 420, 255, 1, '', 0), -- .go xyz -641.353 -5689.82
(@GAMEOBJECTBLOCK+15, 3719, 1, 0, 0, 1, 1, -641.353, -5689.82, -0.171481, 5.2709, 0, 0, -0.484809, 0.87462, 420, 255, 1, '', 0), -- .go xyz -641.353 -5689.82
(@GAMEOBJECTBLOCK+16, 3658, 1, 0, 0, 1, 1, -1166.98, -5145.53, -0.077441, 5.48033, 0, 0, -0.390731, 0.920505, 420, 255, 1, '', 0), -- .go xyz -1166.98 -5145.53
(@GAMEOBJECTBLOCK+17, 3719, 1, 0, 0, 1, 1, -1166.98, -5145.53, -0.077441, 5.48033, 0, 0, -0.390731, 0.920505, 420, 255, 1, '', 0), -- .go xyz -1166.98 -5145.53
(@GAMEOBJECTBLOCK+18, 3658, 1, 0, 0, 1, 1, -1245.5, -5619.57, -0.066979, 2.42601, 0, 0, 0.936672, 0.350207, 420, 255, 1, '', 0), -- .go xyz -1245.5 -5619.57
(@GAMEOBJECTBLOCK+19, 3719, 1, 0, 0, 1, 1, -1245.5, -5619.57, -0.066979, 2.42601, 0, 0, 0.936672, 0.350207, 420, 255, 1, '', 0), -- .go xyz -1245.5 -5619.57
(@GAMEOBJECTBLOCK+20, 3658, 1, 0, 0, 1, 1, -1404.75, -5116.98, -0.015283, 2.9845, 0, 0, 0.996917, 0.0784664, 420, 255, 1, '', 0), -- .go xyz -1404.75 -5116.98
(@GAMEOBJECTBLOCK+21, 3719, 1, 0, 0, 1, 1, -1404.75, -5116.98, -0.015283, 2.9845, 0, 0, 0.996917, 0.0784664, 420, 255, 1, '', 0), -- .go xyz -1404.75 -5116.98
(@GAMEOBJECTBLOCK+22, 3658, 1, 0, 0, 1, 1, -1123.15, -5575.75, 7.39658, 0.226892, 0, 0, 0.113203, 0.993572, 420, 255, 1, '', 0), -- .go xyz -1123.15 -5575.75
(@GAMEOBJECTBLOCK+23, 3719, 1, 0, 0, 1, 1, -1123.15, -5575.75, 7.39658, 0.226892, 0, 0, 0.113203, 0.993572, 420, 255, 1, '', 0), -- .go xyz -1123.15 -5575.75
(@GAMEOBJECTBLOCK+24, 3658, 1, 0, 0, 1, 1, -805.108, -5698.99, 0.052685, 5.68977, 0, 0, -0.292372, 0.956305, 420, 255, 1, '', 0), -- .go xyz -805.108 -5698.99
(@GAMEOBJECTBLOCK+25, 3719, 1, 0, 0, 1, 1, -805.108, -5698.99, 0.052685, 5.68977, 0, 0, -0.292372, 0.956305, 420, 255, 1, '', 0), -- .go xyz -805.108 -5698.99
(@GAMEOBJECTBLOCK+26, 3658, 1, 0, 0, 1, 1, -1241.68, -5507.15, 5.7288, 1.27409, 0, 0, 0.594822, 0.803857, 420, 255, 1, '', 0), -- .go xyz -1241.68 -5507.15
(@GAMEOBJECTBLOCK+27, 3719, 1, 0, 0, 1, 1, -1241.68, -5507.15, 5.7288, 1.27409, 0, 0, 0.594822, 0.803857, 420, 255, 1, '', 0), -- .go xyz -1241.68 -5507.15
(@GAMEOBJECTBLOCK+28, 3658, 1, 0, 0, 1, 1, -1295.43, -5368.52, -0.16403, 0.436332, 0, 0, 0.216439, 0.976296, 420, 255, 1, '', 0), -- .go xyz -1295.43 -5368.52
(@GAMEOBJECTBLOCK+29, 3719, 1, 0, 0, 1, 1, -1295.43, -5368.52, -0.16403, 0.436332, 0, 0, 0.216439, 0.976296, 420, 255, 1, '', 0), -- .go xyz -1295.43 -5368.52
(@GAMEOBJECTBLOCK+30, 3719, 1, 0, 0, 1, 1, -1550.397, -5221.865, -0.031495, 2.426008, 0, 0, 0.936672, 0.350207, 420, 255, 1, '', 0), -- .go xyz -1550.3973388671875 -5221.86474609375
(@GAMEOBJECTBLOCK+31, 3719, 1, 0, 0, 1, 1, -1550.397, -5221.865, -0.031495, 2.426008, 0, 0, 0.936672, 0.350207, 420, 255, 1, '', 0), -- .go xyz -1550.3973388671875 -5221.86474609375
(@GAMEOBJECTBLOCK+32, 3719, 1, 0, 0, 1, 1, -1642.232, -5284.792, -0.033276, 0.523598, 0, 0, 0.258819, 0.965926, 420, 255, 1, '', 0), -- .go xyz -1642.2322998046875 -5284.79248046875
(@GAMEOBJECTBLOCK+33, 3719, 1, 0, 0, 1, 1, -1642.232, -5284.792, -0.033276, 0.523598, 0, 0, 0.258819, 0.965926, 420, 255, 1, '', 0), -- .go xyz -1642.2322998046875 -5284.79248046875
-- Durotar Food Water GO Pool III Tiragaurd Keep
(@GAMEOBJECTBLOCK+34, 3658, 1, 0, 0, 1, 1, -174.109, -4986.14, 22.5386, 6.14356, 0, 0, -0.0697556, 0.997564, 420, 255, 1, '', 0), -- .go xyz -174.109 -4986.14
(@GAMEOBJECTBLOCK+35, 3719, 1, 0, 0, 1, 1, -174.109, -4986.14, 22.5386, 6.14356, 0, 0, -0.0697556, 0.997564, 420, 255, 1, '', 0), -- .go xyz -174.109 -4986.14
(@GAMEOBJECTBLOCK+36, 3658, 1, 0, 0, 1, 1, -236.963, -5121.01, 25.2436, 2.16421, 0, 0, 0.882947, 0.469473, 420, 255, 1, '', 0), -- .go xyz -236.963 -5121.01
(@GAMEOBJECTBLOCK+37, 3719, 1, 0, 0, 1, 1, -236.963, -5121.01, 25.2436, 2.16421, 0, 0, 0.882947, 0.469473, 420, 255, 1, '', 0), -- .go xyz -236.963 -5121.01
(@GAMEOBJECTBLOCK+38, 3658, 1, 0, 0, 1, 1, -153.696, -5023.12, 21.9477, 6.17847, 0, 0, -0.0523357, 0.99863, 420, 255, 1, '', 0), -- .go xyz -153.696 -5023.12
(@GAMEOBJECTBLOCK+39, 3719, 1, 0, 0, 1, 1, -153.696, -5023.12, 21.9477, 6.17847, 0, 0, -0.0523357, 0.99863, 420, 255, 1, '', 0), -- .go xyz -153.696 -5023.12
-- Durotar Food Water GO Pool IV x2 Coast
(@GAMEOBJECTBLOCK+40, 3658, 1, 0, 0, 1, 1, 390.932, -5124.09, -0.05675, 2.65289, 0, 0, 0.970295, 0.241925, 420, 255, 1, '', 0), -- .go xyz 390.932 -5124.09
(@GAMEOBJECTBLOCK+41, 3719, 1, 0, 0, 1, 1, 390.932, -5124.09, -0.05675, 2.65289, 0, 0, 0.970295, 0.241925, 420, 255, 1, '', 0), -- .go xyz 390.932 -5124.09
(@GAMEOBJECTBLOCK+42, 3658, 1, 0, 0, 1, 1, -515.953, -5243.47, 0.036085, 0.767944, 0, 0, 0.374606, 0.927184, 420, 255, 1, '', 0), -- .go xyz -515.953 -5243.47
(@GAMEOBJECTBLOCK+43, 3719, 1, 0, 0, 1, 1, -515.953, -5243.47, 0.036085, 0.767944, 0, 0, 0.374606, 0.927184, 420, 255, 1, '', 0), -- .go xyz -515.953 -5243.47
(@GAMEOBJECTBLOCK+44, 3658, 1, 0, 0, 1, 1, -639.43, -5185.13, 0.112274, 2.60054, 0, 0, 0.96363, 0.267241, 420, 255, 1, '', 0), -- .go xyz -639.43 -5185.13
(@GAMEOBJECTBLOCK+45, 3719, 1, 0, 0, 1, 1, -639.43, -5185.13, 0.112274, 2.60054, 0, 0, 0.96363, 0.267241, 420, 255, 1, '', 0), -- .go xyz -639.43 -5185.13
(@GAMEOBJECTBLOCK+46, 3658, 1, 0, 0, 1, 1, 1266.49, -5030.35, -0.039411, 0.802851, 0, 0, 0.390731, 0.920505, 420, 255, 1, '', 0), -- .go xyz 1266.49 -5030.35
(@GAMEOBJECTBLOCK+47, 3719, 1, 0, 0, 1, 1, 1266.49, -5030.35, -0.039411, 0.802851, 0, 0, 0.390731, 0.920505, 420, 255, 1, '', 0), -- .go xyz 1266.49 -5030.35
(@GAMEOBJECTBLOCK+48, 3658, 1, 0, 0, 1, 1, 933.269, -5104.26, -0.032131, 0.471238, 0, 0, 0.233445, 0.97237, 420, 255, 1, '', 0), -- .go xyz 933.269 -5104.26
(@GAMEOBJECTBLOCK+49, 3719, 1, 0, 0, 1, 1, 933.269, -5104.26, -0.032131, 0.471238, 0, 0, 0.233445, 0.97237, 420, 255, 1, '', 0), -- .go xyz 933.269 -5104.26
(@GAMEOBJECTBLOCK+50, 3658, 1, 0, 0, 1, 1, 730.074, -5079.44, -0.030667, 2.68781, 0, 0, 0.97437, 0.224951, 420, 255, 1, '', 0), -- .go xyz 730.074 -5079.44
(@GAMEOBJECTBLOCK+51, 3719, 1, 0, 0, 1, 1, 730.074, -5079.44, -0.030667, 2.68781, 0, 0, 0.97437, 0.224951, 420, 255, 1, '', 0), -- .go xyz 730.074 -5079.44
(@GAMEOBJECTBLOCK+52, 3658, 1, 0, 0, 1, 1, -366.615, -5211.02, -0.034382, 1.53589, 0, 0, 0.694658, 0.71934, 420, 255, 1, '', 0), -- .go xyz -366.615 -5211.02
(@GAMEOBJECTBLOCK+53, 3719, 1, 0, 0, 1, 1, -366.615, -5211.02, -0.034382, 1.53589, 0, 0, 0.694658, 0.71934, 420, 255, 1, '', 0), -- .go xyz -366.615 -5211.02
(@GAMEOBJECTBLOCK+54, 3658, 1, 0, 0, 1, 1, 204.816, -5146.84, -0.014512, 5.39307, 0, 0, -0.430511, 0.902586, 420, 255, 1, '', 0), -- .go xyz 204.816 -5146.84
(@GAMEOBJECTBLOCK+55, 3719, 1, 0, 0, 1, 1, 204.816, -5146.84, -0.014512, 5.39307, 0, 0, -0.430511, 0.902586, 420, 255, 1, '', 0), -- .go xyz 204.816 -5146.84
(@GAMEOBJECTBLOCK+56, 3658, 1, 0, 0, 1, 1, -103.63, -5201.51, -0.04023, 2.21657, 0, 0, 0.894934, 0.446199, 420, 255, 1, '', 0), -- .go xyz -103.63 -5201.51
(@GAMEOBJECTBLOCK+57, 3719, 1, 0, 0, 1, 1, -103.63, -5201.51, -0.04023, 2.21657, 0, 0, 0.894934, 0.446199, 420, 255, 1, '', 0), -- .go xyz -103.63 -5201.51
-- Durotar Food Water GO Pool V x3 Razor Hill (on longer timer)
(@GAMEOBJECTBLOCK+58, 3658, 1, 0, 0, 1, 1, 289.618, -4771.3, 11.769, 5.77704, 0, 0, -0.25038, 0.968148, 900, 255, 1, '', 0), -- .go xyz 289.618 -4771.3
(@GAMEOBJECTBLOCK+59, 3719, 1, 0, 0, 1, 1, 289.618, -4771.3, 11.769, 5.77704, 0, 0, -0.25038, 0.968148, 900, 255, 1, '', 0), -- .go xyz 289.618 -4771.3
(@GAMEOBJECTBLOCK+60, 3658, 1, 0, 0, 1, 1, 319.151, -4667.86, 16.0833, 0.767944, 0, 0, 0.374606, 0.927184, 900, 255, 1, '', 0), -- .go xyz 319.151 -4667.86
(@GAMEOBJECTBLOCK+61, 3719, 1, 0, 0, 1, 1, 319.151, -4667.86, 16.0833, 0.767944, 0, 0, 0.374606, 0.927184, 900, 255, 1, '', 0), -- .go xyz 319.151 -4667.86
(@GAMEOBJECTBLOCK+62, 3658, 1, 0, 0, 1, 1, 292.627, -4828.49, 10.5234, 0.855211, 0, 0, 0.414693, 0.909961, 900, 255, 1, '', 0), -- .go xyz 292.627 -4828.49
(@GAMEOBJECTBLOCK+63, 3719, 1, 0, 0, 1, 1, 292.627, -4828.49, 10.5234, 0.855211, 0, 0, 0.414693, 0.909961, 900, 255, 1, '', 0), -- .go xyz 292.627 -4828.49
(@GAMEOBJECTBLOCK+64, 3658, 1, 0, 0, 1, 1, 269.646, -4701.72, 11.6288, 1.39626, 0, 0, 0.642787, 0.766045, 900, 255, 1, '', 0), -- .go xyz 269.646 -4701.72
(@GAMEOBJECTBLOCK+65, 3719, 1, 0, 0, 1, 1, 269.646, -4701.72, 11.6288, 1.39626, 0, 0, 0.642787, 0.766045, 900, 255, 1, '', 0), -- .go xyz 269.646 -4701.72
(@GAMEOBJECTBLOCK+66, 3658, 1, 0, 0, 1, 1, 382.927, -4597.71, 54.7897, 0.610863, 0, 0, 0.300705, 0.953717, 900, 255, 1, '', 0), -- .go xyz 382.927 -4597.71
(@GAMEOBJECTBLOCK+67, 3719, 1, 0, 0, 1, 1, 382.927, -4597.71, 54.7897, 0.610863, 0, 0, 0.300705, 0.953717, 900, 255, 1, '', 0), -- .go xyz 382.927 -4597.71
(@GAMEOBJECTBLOCK+68, 3658, 1, 0, 0, 1, 1, 319.082, -4768.63, 11.9896, 1.72787, 0, 0, 0.760406, 0.649449, 900, 255, 1, '', 0), -- .go xyz 319.082 -4768.63
(@GAMEOBJECTBLOCK+69, 3719, 1, 0, 0, 1, 1, 319.082, -4768.63, 11.9896, 1.72787, 0, 0, 0.760406, 0.649449, 900, 255, 1, '', 0), -- .go xyz 319.082 -4768.63
(@GAMEOBJECTBLOCK+70, 3658, 1, 0, 0, 1, 1, 387.24, -4586.66, 76.1843, 0.680677, 0, 0, 0.333806, 0.942642, 900, 255, 1, '', 0), -- .go xyz 387.24 -4586.66
(@GAMEOBJECTBLOCK+71, 3719, 1, 0, 0, 1, 1, 387.24, -4586.66, 76.1843, 0.680677, 0, 0, 0.333806, 0.942642, 900, 255, 1, '', 0), -- .go xyz 387.24 -4586.66
(@GAMEOBJECTBLOCK+72, 3658, 1, 0, 0, 1, 1, 290.396, -4706.11, 12.8422, 4.5204, 0, 0, -0.771625, 0.636078, 900, 255, 1, '', 0), -- .go xyz 290.396 -4706.11
(@GAMEOBJECTBLOCK+73, 3719, 1, 0, 0, 1, 1, 290.396, -4706.11, 12.8422, 4.5204, 0, 0, -0.771625, 0.636078, 900, 255, 1, '', 0), -- .go xyz 290.396 -4706.11
(@GAMEOBJECTBLOCK+74, 3658, 1, 0, 0, 1, 1, 298.8803, -4663.1113, 16.77118, 4.4156833, 0, 0, -0.80385685, 0.5948228, 900, 255, 1, '', 0), -- .go xyz 290.396 -4706.11
(@GAMEOBJECTBLOCK+75, 3719, 1, 0, 0, 1, 1, 298.8803, -4663.1113, 16.77118, 4.4156833, 0, 0, -0.80385685, 0.5948228, 900, 255, 1, '', 0), -- .go xyz 290.396 -4706.11
(@GAMEOBJECTBLOCK+76, 3658, 1, 0, 0, 1, 1, 339.33615, -4700.809, 16.457773, 1.9198616, 0, 0, 0.8191519, 0.5735767, 900, 255, 1, '', 0), -- .go xyz 290.396 -4706.11
(@GAMEOBJECTBLOCK+77, 3719, 1, 0, 0, 1, 1, 339.33615, -4700.809, 16.457773, 1.9198616, 0, 0, 0.8191519, 0.5735767, 900, 255, 1, '', 0), -- .go xyz 290.396 -4706.11
(@GAMEOBJECTBLOCK+78, 3658, 1, 0, 0, 1, 1, 321.55337, -4768.1733, 11.671841, 3.385940, 0, 0, -0.99254608, 0.12186995, 900, 255, 1, '', 0), -- .go xyz 290.396 -4706.11
(@GAMEOBJECTBLOCK+79, 3719, 1, 0, 0, 1, 1, 321.55337, -4768.1733, 11.671841, 3.385940, 0, 0, -0.99254608, 0.12186995, 900, 255, 1, '', 0), -- .go xyz 290.396 -4706.11
-- Durotar Food Water GO Pool VI Path to Orgrimmar
(@GAMEOBJECTBLOCK+80, 3658, 1, 0, 0, 1, 1, 787.201, -4530.7, 5.7406, 1.78023, 0, 0, 0.777145, 0.629321, 420, 255, 1, '', 0), -- .go xyz 787.201 -4530.7
(@GAMEOBJECTBLOCK+81, 3719, 1, 0, 0, 1, 1, 787.201, -4530.7, 5.7406, 1.78023, 0, 0, 0.777145, 0.629321, 420, 255, 1, '', 0), -- .go xyz 787.201 -4530.7
(@GAMEOBJECTBLOCK+82, 3658, 1, 0, 0, 1, 1, 758.13, -4565.89, 1.62941, 3.42085, 0, 0, -0.990268, 0.139175, 420, 255, 1, '', 0), -- .go xy 758.13 -4565.8
(@GAMEOBJECTBLOCK+83, 3719, 1, 0, 0, 1, 1, 758.13, -4565.89, 1.62941, 3.42085, 0, 0, -0.990268, 0.139175, 420, 255, 1, '', 0), -- .go xy 758.13 -4565.8
(@GAMEOBJECTBLOCK+84, 3658, 1, 0, 0, 1, 1, 737.128, -4604.469, -3.308156, 5.550147, 0, 0, -0.358368, 0.933580, 420, 255, 1, '', 0),
(@GAMEOBJECTBLOCK+85, 3719, 1, 0, 0, 1, 1, 737.128, -4604.469, -3.308156, 5.550147, 0, 0, -0.358368, 0.933580, 420, 255, 1, '', 0),
-- Durotar Food Water GO Pool VII Dustwind Cave
(@GAMEOBJECTBLOCK+86, 3658, 1, 0, 0, 1, 1, 946.095, -4704.73, 23.0614, 3.00195, 0, 0, 0.997563, 0.0697661, 420, 255, 1, '', 0), -- .go xyz 946.095 -4704.73
(@GAMEOBJECTBLOCK+87, 3719, 1, 0, 0, 1, 1, 946.095, -4704.73, 23.0614, 3.00195, 0, 0, 0.997563, 0.0697661, 420, 255, 1, '', 0), -- .go xyz 946.095 -4704.73
(@GAMEOBJECTBLOCK+88, 3658, 1, 0, 0, 1, 1, 859.76, -4792.43, 36.3753, 3.10665, 0, 0, 0.999847, 0.0174693, 420, 255, 1, '', 0), -- .go xyz 859.76 -4792.43
(@GAMEOBJECTBLOCK+89, 3719, 1, 0, 0, 1, 1, 859.76, -4792.43, 36.3753, 3.10665, 0, 0, 0.999847, 0.0174693, 420, 255, 1, '', 0), -- .go xyz 859.76 -4792.43
(@GAMEOBJECTBLOCK+90, 3658, 1, 0, 0, 1, 1, 1102.29, -4951.8, 15.6024, 3.82227, 0, 0, -0.942641, 0.333808, 420, 255, 1, '', 0), -- .go xyz 1102.29 -4951.8
(@GAMEOBJECTBLOCK+91, 3719, 1, 0, 0, 1, 1, 1102.29, -4951.8, 15.6024, 3.82227, 0, 0, -0.942641, 0.333808, 420, 255, 1, '', 0), -- .go xyz 1102.29 -4951.8
-- Durotar Food Water GO Pool VIII Harpies East
(@GAMEOBJECTBLOCK+92, 3658, 1, 0, 0, 1, 1, 915.418, -4633.35, 18.9878, 1.41372, 0, 0, 0.649447, 0.760406, 420, 255, 1, '', 0), -- .go xyz 915.418 -4633.35
(@GAMEOBJECTBLOCK+93, 3719, 1, 0, 0, 1, 1, 915.418, -4633.35, 18.9878, 1.41372, 0, 0, 0.649447, 0.760406, 420, 255, 1, '', 0), -- .go xyz 915.418 -4633.35
(@GAMEOBJECTBLOCK+94, 3658, 1, 0, 0, 1, 1, 993.55, -4672.15, 26.9618, 5.86431, 0, 0, -0.207911, 0.978148, 420, 255, 1, '', 0), -- .go xyz 993.55 -4672.15
(@GAMEOBJECTBLOCK+95, 3719, 1, 0, 0, 1, 1, 993.55, -4672.15, 26.9618, 5.86431, 0, 0, -0.207911, 0.978148, 420, 255, 1, '', 0), -- .go xyz 993.55 -4672.15
(@GAMEOBJECTBLOCK+96, 3658, 1, 0, 0, 1, 1, 1143.52, -4695.76, 17.7529, 0.226892, 0, 0, 0.113203, 0.993572, 420, 255, 1, '', 0), -- .go xyz 1143.52 -4695.76
(@GAMEOBJECTBLOCK+97, 3719, 1, 0, 0, 1, 1, 1143.52, -4695.76, 17.7529, 0.226892, 0, 0, 0.113203, 0.993572, 420, 255, 1, '', 0), -- .go xyz 1143.52 -4695.76
-- Durotar Food Water GO Pool IX Harpies West
(@GAMEOBJECTBLOCK+98, 3658, 1, 0, 0, 1, 1, 665.216, -4540.14, 8.83067, 4.50295, 0, 0, -0.777145, 0.629321, 420, 255, 1, '', 0), -- .go xyz 665.216 -4540.14
(@GAMEOBJECTBLOCK+99, 3719, 1, 0, 0, 1, 1, 665.216, -4540.14, 8.83067, 4.50295, 0, 0, -0.777145, 0.629321, 420, 255, 1, '', 0), -- .go xyz 665.216 -4540.14
(@GAMEOBJECTBLOCK+100, 3658, 1, 0, 0, 1, 1, 627.12, -4443.5, 11.6634, 3.61284, 0, 0, -0.972369, 0.233448, 420, 255, 1, '', 0), -- .go xyz 627.12 -4443.5
(@GAMEOBJECTBLOCK+101, 3719, 1, 0, 0, 1, 1, 627.12, -4443.5, 11.6634, 3.61284, 0, 0, -0.972369, 0.233448, 420, 255, 1, '', 0), -- .go xyz 627.12 -4443.5
(@GAMEOBJECTBLOCK+102, 3658, 1, 0, 0, 1, 1, 771.55, -4460.79, 15.6685, 2.30383, 0, 0, 0.913545, 0.406738, 420, 255, 1, '', 0), -- .go xyz 771.55 -4460.79
(@GAMEOBJECTBLOCK+103, 3719, 1, 0, 0, 1, 1, 771.55, -4460.79, 15.6685, 2.30383, 0, 0, 0.913545, 0.406738, 420, 255, 1, '', 0), -- .go xyz 771.55 -4460.79
-- Durotar Food Water GO Pool X Orc Huts
(@GAMEOBJECTBLOCK+104, 3658, 1, 0, 0, 1, 1, 563.076, -4090.13, 15.6692, 1.16937, 0, 0, 0.551936, 0.833886, 420, 255, 1, '', 0), -- .go xyz 563.076 -4090.13
(@GAMEOBJECTBLOCK+105, 3719, 1, 0, 0, 1, 1, 563.076, -4090.13, 15.6692, 1.16937, 0, 0, 0.551936, 0.833886, 420, 255, 1, '', 0), -- .go xyz 563.076 -4090.13
(@GAMEOBJECTBLOCK+106, 3658, 1, 0, 0, 1, 1, 1269, -4178.72, 26.0548, 1.39626, 0, 0, 0.642787, 0.766045, 420, 255, 1, '', 0), -- .go xyz 1269 -4178.72
(@GAMEOBJECTBLOCK+107, 3719, 1, 0, 0, 1, 1, 1269, -4178.72, 26.0548, 1.39626, 0, 0, 0.642787, 0.766045, 420, 255, 1, '', 0), -- .go xyz 1269 -4178.72
(@GAMEOBJECTBLOCK+108, 3658, 1, 0, 0, 1, 1, 758.85, -4251.66, 18.3729, 1.8675, 0, 0, 0.803857, 0.594823, 420, 255, 1, '', 0), -- .go xyz 758.85 -4251.66
(@GAMEOBJECTBLOCK+109, 3719, 1, 0, 0, 1, 1, 758.85, -4251.66, 18.3729, 1.8675, 0, 0, 0.803857, 0.594823, 420, 255, 1, '', 0), -- .go xyz 758.85 -4251.66
-- Durotar Food Water GO Pool XI x2 Misc Durotar
(@GAMEOBJECTBLOCK+110, 3658, 1, 0, 0, 1, 1, 859.703, -4170.78, -14.1103, 4.50295, 0, 0, -0.777145, 0.629321, 420, 255, 1, '', 0), -- .go xyz 859.703 -4170.78
(@GAMEOBJECTBLOCK+111, 3719, 1, 0, 0, 1, 1, 859.703, -4170.78, -14.1103, 4.50295, 0, 0, -0.777145, 0.629321, 420, 255, 1, '', 0), -- .go xyz 859.703 -4170.78
(@GAMEOBJECTBLOCK+112, 3658, 1, 0, 0, 1, 1, -97.4073, -4045.79, 64.7427, 5.63741, 0, 0, -0.317305, 0.948324, 420, 255, 1, '', 0), -- .go xyz -97.4073 -4045.79
(@GAMEOBJECTBLOCK+113, 3719, 1, 0, 0, 1, 1, -97.4073, -4045.79, 64.7427, 5.63741, 0, 0, -0.317305, 0.948324, 420, 255, 1, '', 0), -- .go xyz -97.4073 -4045.79
(@GAMEOBJECTBLOCK+114, 3658, 1, 0, 0, 1, 1, 325.073, -3795.73, 26.4866, 0.90757, 0, 0, 0.438371, 0.898794, 420, 255, 1, '', 0), -- .go xyz 325.073 -3795.73
(@GAMEOBJECTBLOCK+115, 3719, 1, 0, 0, 1, 1, 325.073, -3795.73, 26.4866, 0.90757, 0, 0, 0.438371, 0.898794, 420, 255, 1, '', 0), -- .go xyz 325.073 -3795.73
(@GAMEOBJECTBLOCK+116, 3658, 1, 0, 0, 1, 1, 74.5528, -4218.84, 60.8336, 2.07694, 0, 0, 0.861629, 0.507539, 420, 255, 1, '', 0), -- .go xyz 74.5528 -4218.84
(@GAMEOBJECTBLOCK+117, 3719, 1, 0, 0, 1, 1, 74.5528, -4218.84, 60.8336, 2.07694, 0, 0, 0.861629, 0.507539, 420, 255, 1, '', 0), -- .go xyz 74.5528 -4218.84
(@GAMEOBJECTBLOCK+118, 3658, 1, 0, 0, 1, 1, 1001.38, -3919.05, 18.7792, 3.99681, 0, 0, -0.909961, 0.414694, 420, 255, 1, '', 0), -- .go xyz 1001.38 -3919.05
(@GAMEOBJECTBLOCK+119, 3719, 1, 0, 0, 1, 1, 1001.38, -3919.05, 18.7792, 3.99681, 0, 0, -0.909961, 0.414694, 420, 255, 1, '', 0), -- .go xyz 1001.38 -3919.05
(@GAMEOBJECTBLOCK+120, 3658, 1, 0, 0, 1, 1, 992.105, -4407.13, 14.5778, 3.33359, 0, 0, -0.995396, 0.0958512, 420, 255, 1, '', 0), -- .go xyz 992.105 -4407.13
(@GAMEOBJECTBLOCK+121, 3719, 1, 0, 0, 1, 1, 992.105, -4407.13, 14.5778, 3.33359, 0, 0, -0.995396, 0.0958512, 420, 255, 1, '', 0); -- .go xyz 992.105 -4407.13
-- Total 18 maximum active in Durotar

-- Some liberties were taken to make this work within the current system.  This may actually be blizzlike (except that some pools are mixed a little), or its possible gameobjects need multiple ids like creatures do.

SET @OBJECTPOOLS :=516;
DELETE FROM `pool_gameobject` WHERE `guid` BETWEEN @GAMEOBJECTBLOCK+0 AND @GAMEOBJECTBLOCK+121;
DELETE FROM `pool_template` WHERE `entry` BETWEEN @OBJECTPOOLS+0 AND @OBJECTPOOLS+17;

INSERT INTO `pool_template` (`entry`, `max_limit`, `description`) VALUES
(@OBJECTPOOLS+0, 1, 'Durotar Food Water GO Pool I Kolkar Crag');
INSERT INTO `pool_gameobject` (`guid`, `pool_entry`, `chance`, `description`) VALUES
(@GAMEOBJECTBLOCK+0, @OBJECTPOOLS+0, 22, 'Food Water Kolkar Crag 1/6'),
(@GAMEOBJECTBLOCK+1, @OBJECTPOOLS+0, 11, 'Food Water Kolkar Crag 2/6'),
(@GAMEOBJECTBLOCK+2, @OBJECTPOOLS+0, 22, 'Food Water Kolkar Crag 3/6'),
(@GAMEOBJECTBLOCK+3, @OBJECTPOOLS+0, 11, 'Food Water Kolkar Crag 4/6'),
(@GAMEOBJECTBLOCK+4, @OBJECTPOOLS+0, 22, 'Food Water Kolkar Crag 5/6'),
(@GAMEOBJECTBLOCK+5, @OBJECTPOOLS+0, 12, 'Food Water Kolkar Crag 6/6');

INSERT INTO `pool_template` (`entry`, `max_limit`, `description`) VALUES
(@OBJECTPOOLS+1, 1, 'Durotar Food Water GO Pool II 1/4 Echo Isles');
INSERT INTO `pool_gameobject` (`guid`, `pool_entry`, `chance`, `description`) VALUES
(@GAMEOBJECTBLOCK+6, @OBJECTPOOLS+1, 22, 'Food Water Echo Isles 1 1/6'),
(@GAMEOBJECTBLOCK+7, @OBJECTPOOLS+1, 11, 'Food Water Echo Isles 1 2/6'),
(@GAMEOBJECTBLOCK+8, @OBJECTPOOLS+1, 22, 'Food Water Echo Isles 1 3/6'),
(@GAMEOBJECTBLOCK+9, @OBJECTPOOLS+1, 11, 'Food Water Echo Isles 1 4/6'),
(@GAMEOBJECTBLOCK+10, @OBJECTPOOLS+1, 22, 'Food Water Echo Isles 1 5/6'),
(@GAMEOBJECTBLOCK+11, @OBJECTPOOLS+1, 12, 'Food Water Echo Isles 1 6/6');

INSERT INTO `pool_template` (`entry`, `max_limit`, `description`) VALUES
(@OBJECTPOOLS+2, 1, 'Durotar Food Water GO Pool II 2/4 Echo Isles');
INSERT INTO `pool_gameobject` (`guid`, `pool_entry`, `chance`, `description`) VALUES
(@GAMEOBJECTBLOCK+12, @OBJECTPOOLS+2, 22, 'Food Water Echo Isles 2 1/6'),
(@GAMEOBJECTBLOCK+13, @OBJECTPOOLS+2, 11, 'Food Water Echo Isles 2 2/6'),
(@GAMEOBJECTBLOCK+14, @OBJECTPOOLS+2, 22, 'Food Water Echo Isles 2 3/6'),
(@GAMEOBJECTBLOCK+15, @OBJECTPOOLS+2, 11, 'Food Water Echo Isles 2 4/6'),
(@GAMEOBJECTBLOCK+16, @OBJECTPOOLS+2, 22, 'Food Water Echo Isles 2 5/6'),
(@GAMEOBJECTBLOCK+17, @OBJECTPOOLS+2, 12, 'Food Water Echo Isles 2 6/6');

INSERT INTO `pool_template` (`entry`, `max_limit`, `description`) VALUES
(@OBJECTPOOLS+3, 1, 'Durotar Food Water GO Pool II 3/4 Echo Isles');
INSERT INTO `pool_gameobject` (`guid`, `pool_entry`, `chance`, `description`) VALUES
(@GAMEOBJECTBLOCK+18, @OBJECTPOOLS+3, 16.5, 'Food Water Echo Isles 3 1/8'),
(@GAMEOBJECTBLOCK+19, @OBJECTPOOLS+3, 8.5, 'Food Water Echo Isles 3 2/8'),
(@GAMEOBJECTBLOCK+20, @OBJECTPOOLS+3, 16.5, 'Food Water Echo Isles 3 3/8'),
(@GAMEOBJECTBLOCK+21, @OBJECTPOOLS+3, 8.5, 'Food Water Echo Isles 3 4/8'),
(@GAMEOBJECTBLOCK+22, @OBJECTPOOLS+3, 16.5, 'Food Water Echo Isles 3 5/8'),
(@GAMEOBJECTBLOCK+23, @OBJECTPOOLS+3, 8.5, 'Food Water Echo Isles 3 6/8'),
(@GAMEOBJECTBLOCK+24, @OBJECTPOOLS+3, 16.5, 'Food Water Echo Isles 3 7/8'),
(@GAMEOBJECTBLOCK+25, @OBJECTPOOLS+3, 8.5, 'Food Water Echo Isles 3 8/8');

INSERT INTO `pool_template` (`entry`, `max_limit`, `description`) VALUES
(@OBJECTPOOLS+4, 1, 'Durotar Food Water GO Pool II 4/4 Echo Isles');
INSERT INTO `pool_gameobject` (`guid`, `pool_entry`, `chance`, `description`) VALUES
(@GAMEOBJECTBLOCK+26, @OBJECTPOOLS+4, 16.5, 'Food Water Echo Isles 4 1/8'),
(@GAMEOBJECTBLOCK+27, @OBJECTPOOLS+4, 8.5, 'Food Water Echo Isles 4 2/8'),
(@GAMEOBJECTBLOCK+28, @OBJECTPOOLS+4, 16.5, 'Food Water Echo Isles 4 3/8'),
(@GAMEOBJECTBLOCK+29, @OBJECTPOOLS+4, 8.5, 'Food Water Echo Isles 4 4/8'),
(@GAMEOBJECTBLOCK+30, @OBJECTPOOLS+4, 16.5, 'Food Water Echo Isles 4 5/8'),
(@GAMEOBJECTBLOCK+31, @OBJECTPOOLS+4, 8.5, 'Food Water Echo Isles 4 6/8'),
(@GAMEOBJECTBLOCK+32, @OBJECTPOOLS+4, 16.5, 'Food Water Echo Isles 4 7/8'),
(@GAMEOBJECTBLOCK+33, @OBJECTPOOLS+4, 8.5, 'Food Water Echo Isles 4 8/8');

INSERT INTO `pool_template` (`entry`, `max_limit`, `description`) VALUES
(@OBJECTPOOLS+5, 1, 'Durotar Food Water GO Pool III Tiragaurd Keep');
INSERT INTO `pool_gameobject` (`guid`, `pool_entry`, `chance`, `description`) VALUES
(@GAMEOBJECTBLOCK+34, @OBJECTPOOLS+5, 22, 'Food Water Tiragaurd Keep 1/6'),
(@GAMEOBJECTBLOCK+35, @OBJECTPOOLS+5, 11, 'Food Water Tiragaurd Keep 2/6'),
(@GAMEOBJECTBLOCK+36, @OBJECTPOOLS+5, 22, 'Food Water Tiragaurd Keep 3/6'),
(@GAMEOBJECTBLOCK+37, @OBJECTPOOLS+5, 11, 'Food Water Tiragaurd Keep 4/6'),
(@GAMEOBJECTBLOCK+38, @OBJECTPOOLS+5, 22, 'Food Water Tiragaurd Keep 5/6'),
(@GAMEOBJECTBLOCK+39, @OBJECTPOOLS+5, 12, 'Food Water Tiragaurd Keep 6/6');

INSERT INTO `pool_template` (`entry`, `max_limit`, `description`) VALUES
(@OBJECTPOOLS+6, 1, 'Durotar Food Water GO Pool IV 1/2 Coast');
INSERT INTO `pool_gameobject` (`guid`, `pool_entry`, `chance`, `description`) VALUES
(@GAMEOBJECTBLOCK+40, @OBJECTPOOLS+6, 16.5, 'Food Water Coast 1 1/8'),
(@GAMEOBJECTBLOCK+41, @OBJECTPOOLS+6, 8.5, 'Food Water Coast 1 2/8'),
(@GAMEOBJECTBLOCK+42, @OBJECTPOOLS+6, 16.5, 'Food Water Coast 1 3/8'),
(@GAMEOBJECTBLOCK+43, @OBJECTPOOLS+6, 8.5, 'Food Water Coast 1 4/8'),
(@GAMEOBJECTBLOCK+44, @OBJECTPOOLS+6, 16.5, 'Food Water Coast 1 5/8'),
(@GAMEOBJECTBLOCK+45, @OBJECTPOOLS+6, 8.5, 'Food Water Coast 1 6/8'),
(@GAMEOBJECTBLOCK+46, @OBJECTPOOLS+6, 16.5, 'Food Water Coast 1 7/8'),
(@GAMEOBJECTBLOCK+47, @OBJECTPOOLS+6, 8.5, 'Food Water Coast 1 8/8');

INSERT INTO `pool_template` (`entry`, `max_limit`, `description`) VALUES
(@OBJECTPOOLS+7, 1, 'Durotar Food Water GO Pool IV 2/2 Coast');
INSERT INTO `pool_gameobject` (`guid`, `pool_entry`, `chance`, `description`) VALUES
(@GAMEOBJECTBLOCK+48, @OBJECTPOOLS+7, 13.2, 'Food Water Coast 2 1/10'),
(@GAMEOBJECTBLOCK+49, @OBJECTPOOLS+7, 6.8, 'Food Water Coast 2 2/10'),
(@GAMEOBJECTBLOCK+50, @OBJECTPOOLS+7, 13.2, 'Food Water Coast 2 3/10'),
(@GAMEOBJECTBLOCK+51, @OBJECTPOOLS+7, 6.8, 'Food Water Coast 2 4/10'),
(@GAMEOBJECTBLOCK+52, @OBJECTPOOLS+7, 13.2, 'Food Water Coast 2 5/10'),
(@GAMEOBJECTBLOCK+53, @OBJECTPOOLS+7, 6.8, 'Food Water Coast 2 6/10'),
(@GAMEOBJECTBLOCK+54, @OBJECTPOOLS+7, 13.2, 'Food Water Coast 2 7/10'),
(@GAMEOBJECTBLOCK+55, @OBJECTPOOLS+7, 6.8, 'Food Water Coast 2 8/10'),
(@GAMEOBJECTBLOCK+56, @OBJECTPOOLS+7, 13.2, 'Food Water Coast 2 9/10'),
(@GAMEOBJECTBLOCK+57, @OBJECTPOOLS+7, 6.8, 'Food Water Coast 2 10/10');

INSERT INTO `pool_template` (`entry`, `max_limit`, `description`) VALUES
(@OBJECTPOOLS+8, 1, 'Durotar Food Water GO Pool V 1/3 Razor Hill');
INSERT INTO `pool_gameobject` (`guid`, `pool_entry`, `chance`, `description`) VALUES
(@GAMEOBJECTBLOCK+58, @OBJECTPOOLS+8, 22, 'Food Water Razor Hill 1 1/6'),
(@GAMEOBJECTBLOCK+59, @OBJECTPOOLS+8, 11, 'Food Water Razor Hill 1 2/6'),
(@GAMEOBJECTBLOCK+60, @OBJECTPOOLS+8, 22, 'Food Water Razor Hill 1 3/6'),
(@GAMEOBJECTBLOCK+61, @OBJECTPOOLS+8, 11, 'Food Water Razor Hill 1 4/6'),
(@GAMEOBJECTBLOCK+62, @OBJECTPOOLS+8, 22, 'Food Water Razor Hill 1 5/6'),
(@GAMEOBJECTBLOCK+63, @OBJECTPOOLS+8, 12, 'Food Water Razor Hill 1 6/6');

INSERT INTO `pool_template` (`entry`, `max_limit`, `description`) VALUES
(@OBJECTPOOLS+9, 1, 'Durotar Food Water GO Pool V 2/3 Razor Hill');
INSERT INTO `pool_gameobject` (`guid`, `pool_entry`, `chance`, `description`) VALUES
(@GAMEOBJECTBLOCK+64, @OBJECTPOOLS+9, 16.5, 'Food Water Razor Hill 2 1/8'),
(@GAMEOBJECTBLOCK+65, @OBJECTPOOLS+9, 8.5, 'Food Water Razor Hill 2 2/8'),
(@GAMEOBJECTBLOCK+66, @OBJECTPOOLS+9, 16.5, 'Food Water Razor Hill 2 3/8'),
(@GAMEOBJECTBLOCK+67, @OBJECTPOOLS+9, 8.5, 'Food Water Razor Hill 2 4/8'),
(@GAMEOBJECTBLOCK+68, @OBJECTPOOLS+9, 16.5, 'Food Water Razor Hill 2 5/8'),
(@GAMEOBJECTBLOCK+69, @OBJECTPOOLS+9, 8.5, 'Food Water Razor Hill 2 6/8'),
(@GAMEOBJECTBLOCK+70, @OBJECTPOOLS+9, 16.5, 'Food Water Razor Hill 2 7/8'),
(@GAMEOBJECTBLOCK+71, @OBJECTPOOLS+9, 8.5, 'Food Water Razor Hill 2 8/8');

INSERT INTO `pool_template` (`entry`, `max_limit`, `description`) VALUES
(@OBJECTPOOLS+10, 1, 'Durotar Food Water GO Pool V 3/3 Razor Hill');
INSERT INTO `pool_gameobject` (`guid`, `pool_entry`, `chance`, `description`) VALUES
(@GAMEOBJECTBLOCK+72, @OBJECTPOOLS+10, 16.5, 'Food Water Razor Hill 3 1/8'),
(@GAMEOBJECTBLOCK+73, @OBJECTPOOLS+10, 8.5, 'Food Water Razor Hill 3 2/8'),
(@GAMEOBJECTBLOCK+74, @OBJECTPOOLS+10, 16.5, 'Food Water Razor Hill 3 3/8'),
(@GAMEOBJECTBLOCK+75, @OBJECTPOOLS+10, 8.5, 'Food Water Razor Hill 3 4/8'),
(@GAMEOBJECTBLOCK+76, @OBJECTPOOLS+10, 16.5, 'Food Water Razor Hill 3 5/8'),
(@GAMEOBJECTBLOCK+77, @OBJECTPOOLS+10, 8.5, 'Food Water Razor Hill 3 6/8'),
(@GAMEOBJECTBLOCK+78, @OBJECTPOOLS+10, 16.5, 'Food Water Razor Hill 3 7/8'),
(@GAMEOBJECTBLOCK+79, @OBJECTPOOLS+10, 8.5, 'Food Water Razor Hill 3 8/8');

INSERT INTO `pool_template` (`entry`, `max_limit`, `description`) VALUES
(@OBJECTPOOLS+11, 1, 'Durotar Food Water GO Pool VI Path to Orgrimmar');
INSERT INTO `pool_gameobject` (`guid`, `pool_entry`, `chance`, `description`) VALUES
(@GAMEOBJECTBLOCK+80, @OBJECTPOOLS+11, 22, 'Food Water Path to Org 1/6'),
(@GAMEOBJECTBLOCK+81, @OBJECTPOOLS+11, 11, 'Food Water Path to Org 2/6'),
(@GAMEOBJECTBLOCK+82, @OBJECTPOOLS+11, 22, 'Food Water Path to Org 3/6'),
(@GAMEOBJECTBLOCK+83, @OBJECTPOOLS+11, 11, 'Food Water Path to Org 4/6'),
(@GAMEOBJECTBLOCK+84, @OBJECTPOOLS+11, 22, 'Food Water Path to Org 5/6'),
(@GAMEOBJECTBLOCK+85, @OBJECTPOOLS+11, 12, 'Food Water Path to Org 6/6');

INSERT INTO `pool_template` (`entry`, `max_limit`, `description`) VALUES
(@OBJECTPOOLS+12, 1, 'Durotar Food Water GO Pool VII Dustwind Cave');
INSERT INTO `pool_gameobject` (`guid`, `pool_entry`, `chance`, `description`) VALUES
(@GAMEOBJECTBLOCK+86, @OBJECTPOOLS+12, 22, 'Food Water Dustwind Cave 1/6'),
(@GAMEOBJECTBLOCK+87, @OBJECTPOOLS+12, 11, 'Food Water Dustwind Cave 2/6'),
(@GAMEOBJECTBLOCK+88, @OBJECTPOOLS+12, 22, 'Food Water Dustwind Cave 3/6'),
(@GAMEOBJECTBLOCK+89, @OBJECTPOOLS+12, 11, 'Food Water Dustwind Cave 4/6'),
(@GAMEOBJECTBLOCK+90, @OBJECTPOOLS+12, 22, 'Food Water Dustwind Cave 5/6'),
(@GAMEOBJECTBLOCK+91, @OBJECTPOOLS+12, 12, 'Food Water Dustwind Cave 6/6');

INSERT INTO `pool_template` (`entry`, `max_limit`, `description`) VALUES
(@OBJECTPOOLS+13, 1, 'Durotar Food Water GO Pool VIII Harpies East');
INSERT INTO `pool_gameobject` (`guid`, `pool_entry`, `chance`, `description`) VALUES
(@GAMEOBJECTBLOCK+92, @OBJECTPOOLS+13, 22, 'Food Water Harpies East 1/6'),
(@GAMEOBJECTBLOCK+93, @OBJECTPOOLS+13, 11, 'Food Water Harpies East 2/6'),
(@GAMEOBJECTBLOCK+94, @OBJECTPOOLS+13, 22, 'Food Water Harpies East 3/6'),
(@GAMEOBJECTBLOCK+95, @OBJECTPOOLS+13, 11, 'Food Water Harpies East 4/6'),
(@GAMEOBJECTBLOCK+96, @OBJECTPOOLS+13, 22, 'Food Water Harpies East 5/6'),
(@GAMEOBJECTBLOCK+97, @OBJECTPOOLS+13, 12, 'Food Water Harpies East 6/6');

INSERT INTO `pool_template` (`entry`, `max_limit`, `description`) VALUES
(@OBJECTPOOLS+14, 1, 'Durotar Food Water GO Pool IX Harpies West');
INSERT INTO `pool_gameobject` (`guid`, `pool_entry`, `chance`, `description`) VALUES
(@GAMEOBJECTBLOCK+98, @OBJECTPOOLS+14, 22, 'Food Water Harpies West 1/6'),
(@GAMEOBJECTBLOCK+99, @OBJECTPOOLS+14, 11, 'Food Water Harpies West 2/6'),
(@GAMEOBJECTBLOCK+100, @OBJECTPOOLS+14, 22, 'Food Water Harpies West 3/6'),
(@GAMEOBJECTBLOCK+101, @OBJECTPOOLS+14, 11, 'Food Water Harpies West 4/6'),
(@GAMEOBJECTBLOCK+102, @OBJECTPOOLS+14, 22, 'Food Water Harpies West 5/6'),
(@GAMEOBJECTBLOCK+103, @OBJECTPOOLS+14, 12, 'Food Water Harpies West 6/6');

INSERT INTO `pool_template` (`entry`, `max_limit`, `description`) VALUES
(@OBJECTPOOLS+15, 1, 'Durotar Food Water GO Pool X Orc Huts');
INSERT INTO `pool_gameobject` (`guid`, `pool_entry`, `chance`, `description`) VALUES
(@GAMEOBJECTBLOCK+104, @OBJECTPOOLS+15, 22, 'Food Water Orc Huts 1/6'),
(@GAMEOBJECTBLOCK+105, @OBJECTPOOLS+15, 11, 'Food Water Orc Huts 2/6'),
(@GAMEOBJECTBLOCK+106, @OBJECTPOOLS+15, 22, 'Food Water Orc Huts 3/6'),
(@GAMEOBJECTBLOCK+107, @OBJECTPOOLS+15, 11, 'Food Water Orc Huts 4/6'),
(@GAMEOBJECTBLOCK+108, @OBJECTPOOLS+15, 22, 'Food Water Orc Huts 5/6'),
(@GAMEOBJECTBLOCK+109, @OBJECTPOOLS+15, 12, 'Food Water Orc Huts 6/6');

INSERT INTO `pool_template` (`entry`, `max_limit`, `description`) VALUES
(@OBJECTPOOLS+16, 1, 'Durotar Food Water GO Pool XI 1/2 Misc Durotar');
INSERT INTO `pool_gameobject` (`guid`, `pool_entry`, `chance`, `description`) VALUES
(@GAMEOBJECTBLOCK+110, @OBJECTPOOLS+16, 22, 'Food Water Misc Durotar 1 1/6'),
(@GAMEOBJECTBLOCK+111, @OBJECTPOOLS+16, 11, 'Food Water Misc Durotar 1 2/6'),
(@GAMEOBJECTBLOCK+112, @OBJECTPOOLS+16, 22, 'Food Water Misc Durotar 1 3/6'),
(@GAMEOBJECTBLOCK+113, @OBJECTPOOLS+16, 11, 'Food Water Misc Durotar 1 4/6'),
(@GAMEOBJECTBLOCK+114, @OBJECTPOOLS+16, 22, 'Food Water Misc Durotar 1 5/6'),
(@GAMEOBJECTBLOCK+115, @OBJECTPOOLS+16, 12, 'Food Water Misc Durotar 1 6/6');

INSERT INTO `pool_template` (`entry`, `max_limit`, `description`) VALUES
(@OBJECTPOOLS+17, 1, 'Durotar Food Water GO Pool XI 2/2 Misc Durotar');
INSERT INTO `pool_gameobject` (`guid`, `pool_entry`, `chance`, `description`) VALUES
(@GAMEOBJECTBLOCK+116, @OBJECTPOOLS+17, 22, 'Food Water Misc Durotar 2 1/6'),
(@GAMEOBJECTBLOCK+117, @OBJECTPOOLS+17, 11, 'Food Water Misc Durotar 2 2/6'),
(@GAMEOBJECTBLOCK+118, @OBJECTPOOLS+17, 22, 'Food Water Misc Durotar 2 3/6'),
(@GAMEOBJECTBLOCK+119, @OBJECTPOOLS+17, 11, 'Food Water Misc Durotar 2 4/6'),
(@GAMEOBJECTBLOCK+120, @OBJECTPOOLS+17, 22, 'Food Water Misc Durotar 2 5/6'),
(@GAMEOBJECTBLOCK+121, @OBJECTPOOLS+17, 12, 'Food Water Misc Durotar 2 6/6');
