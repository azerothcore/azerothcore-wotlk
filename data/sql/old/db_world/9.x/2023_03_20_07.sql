-- DB update 2023_03_20_06 -> 2023_03_20_07
--
DELETE FROM `creature` WHERE `map`=552 AND `id1` IN (15384, 20864, 20865, 20866, 20867, 20868, 20869, 20870, 20873, 20875, 20879, 20880, 20881, 20882, 20883, 20885, 20886, 20896, 20897, 20898, 20900, 20901, 20902, 20904, 20978, 21303, 21304, 21436, 21437, 21438, 21439, 21440, 21702, 21962) AND `guid` IN (10997,79391,79394,79398,79405,79406,79433,79444,79445,79451,79452,79453,79454,79455,79456,79457,79458,79465,79466,79467,79468,79474,79477,79478,79479,79480,79481,79485,79486,79511,79513,79520,79532,79534,79542,79549,79553,79562,79563,79564,79565,79566,79567,79568,79569,79575,79576,79577,79578,79579,79582,79583,79584,79585,79586,86053,86054,86055,86056,86057,86058,213212,213213,213214,213215,213216,213217,213218,213219,213220,213221,213222,213223,213224);
DELETE FROM `creature_addon` WHERE `guid` IN (79433,79458,79477,79485,79569,79579,86053);
DELETE FROM `linked_respawn` WHERE `linkedGuid` IN (79391, 79451, 79398) AND `guid` IN (10997,79391,79394,79398,79405,79406,79433,79444,79445,79451,79452,79453,79454,79455,79456,79457,79458,79465,79466,79467,79468,79474,79477,79478,79479,79480,79481,79485,79486,79511,79513,79520,79532,79534,79542,79549,79553,79562,79563,79564,79565,79566,79567,79568,79569,79575,79576,79577,79578,79579,79582,79583,79584,79585,79586,86053,86054,86055,86056,86057,86058,213212,213213,213214,213215,213216,213217,213218,213219,213220,213221,213222,213223,213224,79392,79393,79395,79396,79397,79399,79400);
DELETE FROM `creature_formations` WHERE `leaderGUID` IN (79452,79454,79458,79485,79569) AND `memberGUID` IN (79444,79445,79452,79453,79454,79455,79456,79457,79458,79478,79479,79480,79485,79566,79567,79568,79569);

SET @CGUID := 138900;

DELETE FROM `creature` WHERE `map`=552 AND `id1` IN (15384, 20864, 20865, 20866, 20867, 20868, 20869, 20870, 20873, 20875, 20879, 20880, 20881, 20882, 20883, 20885, 20886, 20896, 20897, 20898, 20900, 20901, 20902, 20904, 20978, 21303, 21304, 21436, 21437, 21438, 21439, 21440, 21702, 21962) AND `guid` BETWEEN @CGUID AND @CGUID+97;
INSERT INTO `creature` (`guid`, `id1`, `id2`, `id3`, `map`, `zoneId`, `areaId`, `spawnMask`, `phaseMask`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `wander_distance`, `MovementType`, `VerifiedBuild`) VALUES
(@CGUID+0 , 15384, 0, 0, 552, 3848, 3848, 3, 1, 0, 466.582, -126.723, 43.1834, 3.7001, 86400, 0, 0, 48526),
(@CGUID+1 , 20864, 0, 0, 552, 3848, 3848, 3, 1, 0, 208.993, 6.98038, -7.38507, 4.14757, 86400, 3, 1, 48526),
(@CGUID+2 , 20864, 0, 0, 552, 3848, 3848, 3, 1, 0, 202.78, -41.4077, -10.0187, 5.84685, 86400, 0, 0, 48526),
(@CGUID+3 , 20865, 0, 0, 552, 3848, 3848, 3, 1, 0, 200.93, -116.517, -10.08, 3.51618, 86400, 0, 0, 48526),
(@CGUID+4 , 20865, 0, 0, 552, 3848, 3848, 3, 1, 0, 211.605, 22.3997, 48.2897, 6.27721, 86400, 0, 0, 48526),
(@CGUID+5 , 20865, 0, 0, 552, 3848, 3848, 3, 1, 0, 200.716, -60.7629, -10.0145, 0.159309, 86400, 0, 0, 48526),
(@CGUID+6 , 20865, 0, 0, 552, 3848, 3848, 3, 1, 0, 200.498, -118.427, -10.0377, 3.10863, 86400, 0, 0, 48526),
(@CGUID+7 , 20865, 0, 0, 552, 3848, 3848, 3, 1, 0, 224.424, -160.839, -10.059, 6.26747, 86400, 0, 0, 48526),
(@CGUID+8 , 20865, 0, 0, 552, 3848, 3848, 3, 1, 0, 202.519, -57.6077, -10.0842, 6.217, 86400, 0, 0, 48526),
(@CGUID+9 , 20865, 0, 0, 552, 3848, 3848, 3, 1, 0, 201.551, -36.3583, -10.0187, 4.85512, 86400, 0, 0, 48526),
(@CGUID+10, 20865, 0, 0, 552, 3848, 3848, 3, 1, 0, 284.425, 39.5287, 22.5245, 1.56625, 86400, 25, 1, 48526), -- Run ON
(@CGUID+11, 20865, 0, 0, 552, 3848, 3848, 3, 1, 0, 200.566, -55.4827, -10.0178, 6.0259, 86400, 0, 0, 48526),
(@CGUID+12, 20865, 0, 0, 552, 3848, 3848, 3, 1, 0, 203.982, -114.663, -10.0376, 3.58174, 86400, 0, 0, 48526),
(@CGUID+13, 20865, 0, 0, 552, 3848, 3848, 3, 1, 0, 203.65, -60.4947, -10.0155, 0.499034, 86400, 0, 0, 48526),
(@CGUID+14, 20865, 0, 0, 552, 3848, 3848, 3, 1, 0, 200.014, -115.796, -10.0399, 3.40614, 86400, 0, 0, 48526),
(@CGUID+15, 20865, 0, 0, 552, 3848, 3848, 3, 1, 0, 225.645, 146.931, 22.3816, 3.11106, 86400, 0, 0, 48526),
(@CGUID+16, 20865, 0, 0, 552, 3848, 3848, 3, 1, 0, 208.762, 11.0853, -7.38507, 5.43281, 86400, 0, 0, 48526),
(@CGUID+17, 20865, 0, 0, 552, 3848, 3848, 3, 1, 0, 198.804, -58.2479, -10.0106, 6.16678, 86400, 0, 0, 48526),
(@CGUID+18, 20865, 0, 0, 552, 3848, 3848, 3, 1, 0, 205.741, -44.8498, -10.0129, 3.5465, 86400, 0, 0, 48526),
(@CGUID+19, 20865, 0, 0, 552, 3848, 3848, 3, 1, 0, 201.692, -113.662, -10.0399, 3.59385, 86400, 0, 0, 48526),
(@CGUID+20, 20865, 0, 0, 552, 3848, 3848, 3, 1, 0, 212.919, 6.28938, -7.38507, 4.73786, 86400, 0, 0, 48526),
(@CGUID+21, 20865, 0, 0, 552, 3848, 3848, 3, 1, 0, 203.556, -117.874, -10.0371, 3.46516, 86400, 0, 0, 48526),
(@CGUID+22, 20865, 0, 0, 552, 3848, 3848, 3, 1, 0, 284.465, -5.35082, 22.5245, 2.31213, 86400, 27, 1, 48526), -- Run ON
(@CGUID+23, 20865, 0, 0, 552, 3848, 3848, 3, 1, 0, 203.914, -56.3795, -10.0144, 0.123065, 86400, 0, 0, 48526),
(@CGUID+24, 20865, 0, 0, 552, 3848, 3848, 3, 1, 0, 258.124, -151.125, -10.1104, 2.60235, 86400, 0, 0, 48526),
(@CGUID+25, 20866, 0, 0, 552, 3848, 3848, 3, 1, 0, 213.597, -151.353, -10.0397, 6.13628, 86400, 0, 0, 48526),
(@CGUID+26, 20866, 0, 0, 552, 3848, 3848, 3, 1, 0, 270.034, -144.989, -10.0953, 3.05795, 86400, 0, 0, 48526),
(@CGUID+27, 20867, 0, 0, 552, 3848, 3848, 3, 1, 0, 232.485, -138.726, -10.0292, 2.01374, 86400, 0, 0, 48526),
(@CGUID+28, 20867, 0, 0, 552, 3848, 3848, 3, 1, 0, 265.458, -183.927, -10.1049, 1.04301, 86400, 5, 1, 48526),
(@CGUID+29, 20868, 0, 0, 552, 3848, 3848, 3, 1, 0, 244.464, -156.903, -10.0211, 0.102379, 86400, 7.5, 1, 48526),
(@CGUID+30, 20868, 0, 0, 552, 3848, 3848, 3, 1, 0, 257.83, -125.837, -10.0399, 0.301955, 86400, 0, 0, 48526),
(@CGUID+31, 20869, 0, 0, 552, 3848, 3848, 3, 1, 0, 255.498, 158.914, 22.3619, 5.41052, 86400, 0, 0, 48526),
(@CGUID+32, 20869, 0, 0, 552, 3848, 3848, 3, 1, 0, 253.942, 131.881, 22.395, 0.767945, 86400, 0, 0, 48526),
(@CGUID+33, 20869, 0, 0, 552, 3848, 3848, 3, 1, 0, 264.287, -61.3211, 22.4534, 5.28835, 86400, 0, 0, 48526),
(@CGUID+34, 20869, 0, 0, 552, 3848, 3848, 3, 1, 0, 336.514, 27.4267, 48.426, 3.83972, 86400, 0, 0, 48526),
(@CGUID+35, 20869, 0, 0, 552, 3848, 3848, 3, 1, 0, 395.413, 18.1948, 48.296, 2.49582, 86400, 0, 0, 48526),
(@CGUID+36, 20870, 0, 0, 552, 3848, 3848, 3, 1, 0, 273.607, -122.98, -10.0399, 2.98738, 86400, 3, 1, 48526),
(@CGUID+37, 20873, 0, 0, 552, 3848, 3848, 3, 1, 0, 275.325, 37.1431, 22.5245, 5.29934, 86400, 0, 0, 48526),
(@CGUID+38, 20873, 0, 0, 552, 3848, 3848, 3, 1, 0, 291.263, 6.76101, 22.5245, 1.59431, 86400, 0, 0, 48526),
(@CGUID+39, 20875, 0, 0, 552, 3848, 3848, 3, 1, 0, 285.004, 23.033, 20.8982, 3.93757, 86400, 5, 1, 48526),
(@CGUID+40, 20875, 0, 0, 552, 3848, 3848, 3, 1, 0, 266.75, -17.8235, 22.5301, 1.74047, 86400, 0, 0, 48526),
(@CGUID+41, 20875, 0, 0, 552, 3848, 3848, 3, 1, 0, 298.612, 57.0632, 22.5251, 1.65806, 86400, 7, 1, 48526), -- Not confident if this is correct path
(@CGUID+42, 20879, 20880, 0, 552, 3848, 3848, 3, 1, 1, 305.736, 148.059, 24.8633, 3.97935, 86400, 0, 0, 48526),
(@CGUID+43, 20879, 20880, 0, 552, 3848, 3848, 3, 1, 1, 285.519, 146.155, 22.3118, 5.79449, 86400, 0, 0, 48526),
(@CGUID+44, 20879, 20880, 0, 552, 3848, 3848, 3, 1, 1, 301.797, 127.444, 22.3108, 1.309, 86400, 0, 0, 48526),
(@CGUID+45, 20881, 0, 0, 552, 3848, 3848, 3, 1, 1, 199.698, 143.018, 22.5007, 4.03355, 86400, 0, 0, 48526),
(@CGUID+46, 20881, 0, 0, 552, 3848, 3848, 3, 1, 1, 148.05, 146.994, 20.8982, 6.26573, 86400, 0, 0, 48526),
(@CGUID+47, 20882, 0, 0, 552, 3848, 3848, 3, 1, 0, 163.215, 165.66, 22.5245, 5.37561, 86400, 0, 0, 48526),
(@CGUID+48, 20882, 0, 0, 552, 3848, 3848, 3, 1, 0, 189.461, 147.73, 22.5148, 1.45315, 86400, 0, 0, 48526),
(@CGUID+49, 20883, 0, 0, 552, 3848, 3848, 3, 1, 0, 179.365, 152.537, 22.5245, 3.60076, 86400, 0, 0, 48526),
(@CGUID+50, 20885, 0, 0, 552, 3848, 3848, 3, 1, 0, 137.234, 128.506, 22.5245, 1.01229, 86400, 0, 0, 48526),
(@CGUID+51, 20886, 0, 0, 552, 3848, 3848, 3, 1, 1, 136.2, 168.31, 22.5245, 5.23599, 86400, 0, 0, 48526),
(@CGUID+52, 20896, 0, 0, 552, 3848, 3848, 3, 1, 1, 429.812, 12.0886, 48.2949, 5.20108, 86400, 0, 0, 48526),
(@CGUID+53, 20896, 0, 0, 552, 3848, 3848, 3, 1, 1, 442.455, -16.8151, 48.2128, 4.69741, 86400, 0, 0, 48526),
(@CGUID+54, 20896, 0, 0, 552, 3848, 3848, 3, 1, 1, 433.027, 6.10896, 48.2954, 2.87979, 86400, 0, 0, 48526),
(@CGUID+55, 20896, 0, 0, 552, 3848, 3848, 3, 1, 1, 443.965, -6.1839, 48.2128, 4.97249, 86400, 0, 0, 48526),
(@CGUID+56, 20897, 0, 0, 552, 3848, 3848, 3, 1, 1, 434.228, 9.77371, 48.2944, 3.57792, 86400, 0, 0, 48526),
(@CGUID+57, 20897, 0, 0, 552, 3848, 3848, 3, 1, 1, 440.773, -2.03931, 48.2128, 4.83059, 86400, 0, 0, 48526),
(@CGUID+58, 20898, 0, 0, 552, 3848, 3848, 3, 1, 0, 438.674, -138.424, 43.0828, 1.97497, 86400, 0, 0, 48526),
(@CGUID+59, 20898, 0, 0, 552, 3848, 3848, 3, 1, 0, 457.118, -137.569, 43.105, 5.92215, 86400, 5, 1, 48526),
(@CGUID+60, 20900, 0, 0, 552, 3848, 3848, 3, 1, 1, 432.257, -114.243, 43.1834, 1.13446, 86400, 0, 0, 48526),
(@CGUID+61, 20900, 0, 0, 552, 3848, 3848, 3, 1, 1, 429.592, -157.363, 43.077, 1.95317, 86400, 8.5, 1, 48526),
(@CGUID+62, 20901, 0, 0, 552, 3848, 3848, 3, 1, 1, 431.237, -72.8754, 48.4787, 0.174533, 86400, 0, 0, 48526),
(@CGUID+63, 20901, 0, 0, 552, 3848, 3848, 3, 1, 1, 460.864, -74.1793, 48.4787, 2.94961, 86400, 0, 0, 48526),
(@CGUID+64, 20902, 0, 0, 552, 3848, 3848, 3, 1, 0, 436.245, -76.3012, 48.4787, 1.74533, 86400, 0, 0, 48526),
(@CGUID+65, 20902, 0, 0, 552, 3848, 3848, 3, 1, 0, 457.611, -76.815, 48.4787, 1.09956, 86400, 0, 0, 48526),
(@CGUID+66, 20904, 0, 0, 552, 3848, 3848, 3, 1, 0, 445.803, -169.007, 43.6442, 4.7473, 86400, 0, 0, 48526),
(@CGUID+67, 20978, 0, 0, 552, 3848, 3848, 3, 1, 0, 117.75, 198.164, 22.5245, 3.735, 86400, 0, 0, 48526),
(@CGUID+68, 20978, 0, 0, 552, 3848, 3848, 3, 1, 0, 117.826, 198.081, 22.5245, 5.18363, 86400, 0, 0, 48526),
(@CGUID+69, 20978, 0, 0, 552, 3848, 3848, 3, 1, 0, 117.869, 198.278, 22.5245, 1.97222, 86400, 0, 0, 48526),
(@CGUID+70, 20978, 0, 0, 552, 3848, 3848, 3, 1, 0, 117.861, 198.068, 22.5245, 4.41568, 86400, 0, 0, 48526),
(@CGUID+71, 20978, 0, 0, 552, 3848, 3848, 3, 1, 0, 117.914, 198.068, 22.5245, 1.46608, 86400, 0, 0, 48526),
(@CGUID+72, 20978, 0, 0, 552, 3848, 3848, 3, 1, 0, 117.959, 198.308, 22.5245, 1.65806, 86400, 0, 0, 48526),
(@CGUID+73, 21303, 0, 0, 552, 3848, 3848, 3, 1, 1, 272.103, -59.0341, 22.4533, 0.506145, 86400, 0, 0, 48526),
(@CGUID+74, 21303, 0, 0, 552, 3848, 3848, 3, 1, 1, 206.342, -98.2784, -10.0262, 2.6529, 86400, 0, 0, 48526),
(@CGUID+75, 21303, 0, 0, 552, 3848, 3848, 3, 1, 1, 253.689, 139.868, 22.4121, 2.30383, 86400, 0, 0, 48526),
(@CGUID+76, 21303, 0, 0, 552, 3848, 3848, 3, 1, 1, 272.501, -40.1927, 22.509, 2.9147, 86400, 0, 0, 48526),
(@CGUID+77, 21303, 0, 0, 552, 3848, 3848, 3, 1, 1, 298.848, 151.748, 22.3105, 5.70723, 86400, 0, 0, 48526),
(@CGUID+78, 21303, 0, 0, 552, 3848, 3848, 3, 1, 1, 312.929, -7.19062, 22.5245, 4.03171, 86400, 0, 0, 48526),
(@CGUID+79, 21303, 0, 0, 552, 3848, 3848, 3, 1, 1, 276.173, -179.818, -10.0223, 1.43117, 86400, 0, 0, 48526),
(@CGUID+80, 21303, 0, 0, 552, 3848, 3848, 3, 1, 1, 311.119, -5.50369, 22.5245, 1.5708, 86400, 0, 0, 48526),
(@CGUID+81, 21303, 0, 0, 552, 3848, 3848, 3, 1, 1, 283.728, 130.245, 22.3065, 0.575959, 86400, 0, 0, 48526),
(@CGUID+82, 21303, 0, 0, 552, 3848, 3848, 3, 1, 1, 392.063, 24.8857, 48.296, 6.16101, 86400, 0, 0, 48526),
(@CGUID+83, 21303, 0, 0, 552, 3848, 3848, 3, 1, 1, 395.076, 27.5835, 48.296, 4.41568, 86400, 0, 0, 48526),
(@CGUID+84, 21304, 0, 0, 552, 3848, 3848, 3, 1, 1, 293.885, 70.9368, 22.5262, 1.55334, 86400, 0, 0, 48526),
(@CGUID+85, 21304, 0, 0, 552, 3848, 3848, 3, 1, 1, 257.344, 155.568, 22.3321, 4.71239, 86400, 0, 0, 48526),
(@CGUID+86, 21304, 0, 0, 552, 3848, 3848, 3, 1, 1, 226.184, -162.096, -10.0352, 0.349066, 86400, 0, 0, 48526),
(@CGUID+87, 21304, 0, 0, 552, 3848, 3848, 3, 1, 1, 291.632, 70.5809, 22.5269, 2.00713, 86400, 0, 0, 48526),
(@CGUID+88, 21304, 0, 0, 552, 3848, 3848, 3, 1, 1, 197.955, -86.8133, -10.0174, 5.8294, 86400, 0, 0, 48526),
(@CGUID+89, 21304, 0, 0, 552, 3848, 3848, 3, 1, 1, 253.951, 155.001, 22.3807, 4.93928, 86400, 0, 0, 48526),
(@CGUID+90, 21436, 0, 0, 552, 3848, 3848, 3, 1, 0, 478.326, -148.505, 55.2775, 2.54818, 86400, 0, 0, 48526),
(@CGUID+91, 21437, 0, 0, 552, 3848, 3848, 3, 1, 0, 413.292, -148.378, 54.8771, 0.296706, 86400, 0, 0, 48526),
(@CGUID+92, 21438, 0, 0, 552, 3848, 3848, 3, 1, 0, 420.179, -174.396, 54.8305, 0.0872665, 86400, 0, 0, 48526),
(@CGUID+93, 21439, 0, 0, 552, 3848, 3848, 3, 1, 0, 471.795, -174.58, 55.0008, 2.87979, 86400, 0, 0, 48526),
(@CGUID+94, 21440, 0, 0, 552, 3848, 3848, 3, 1, 0, 445.763, -191.639, 57.5766, 3.9619, 86400, 0, 0, 48526),
(@CGUID+95, 21702, 0, 0, 552, 3848, 3848, 3, 1, 1, 429.409, 7.09051, 48.2896, 1.23918, 86400, 0, 0, 48526),
(@CGUID+96, 21702, 0, 0, 552, 3848, 3848, 3, 1, 1, 444.836, -2.0454, 48.2128, 4.61222, 86400, 0, 0, 48526),
(@CGUID+97, 21962, 0, 0, 552, 3848, 3848, 3, 1, 0, 468.652, 12.2102, 49.3853, 1.29154, 86400, 0, 0, 48526);

-- Pathing for Protean Horror Entry: 20865
SET @NPC := @CGUID+8;
SET @PATH := @NPC * 10;
UPDATE `creature` SET `wander_distance`=0,`MovementType`=2,`position_x`=202.3496,`position_y`=-61.534344,`position_z`=-10.108492 WHERE `guid`=@NPC;
DELETE FROM `creature_addon` WHERE `guid`=@NPC;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes1`,`bytes2`,`emote`,`visibilityDistanceType`,`auras`) VALUES (@NPC,@PATH,0,0,1,0,0, '');
DELETE FROM `waypoint_data` WHERE `id`=@PATH;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`orientation`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
(@PATH,1,202.3496,-61.534344,-10.108492,NULL,0,0,0,100,0),
(@PATH,2,208.22867,-57.986126,-10.064104,NULL,0,0,0,100,0),
(@PATH,3,208.07149,-29.18059,-10.091507,NULL,0,0,0,100,0),
(@PATH,4,210.0403,-21.635162,-10.089756,NULL,0,0,0,100,0),
(@PATH,5,223.61438,-13.931542,-9.641647,NULL,0,0,0,100,0),
(@PATH,6,223.23763,3.027244,-7.9025264,NULL,0,0,0,100,0),
(@PATH,7,201.15181,21.944275,-8.097511,NULL,0,0,0,100,0),
(@PATH,8,183.84764,17.15893,-10.106732,NULL,0,0,0,100,0),
(@PATH,9,186.73946,2.564413,-10.102718,NULL,0,0,0,100,0),
(@PATH,10,197.93507,-17.824755,-10.097534,NULL,0,0,0,100,0),
(@PATH,11,197.42511,-56.04032,-10.106724,NULL,0,0,0,100,0);
-- 0x2042204500146040001E5D0005135613 .go xyz 202.3496 -61.534344 -10.108492

DELETE FROM `creature_formations` WHERE `leaderGUID` = @CGUID+8 AND `memberGUID` IN (@CGUID+8,@CGUID+23,@CGUID+11,@CGUID+17,@CGUID+5,@CGUID+13);
INSERT INTO `creature_formations` (`leaderGUID`, `memberGUID`, `dist`, `angle`, `groupAI`) VALUES
(@CGUID+8, @CGUID+8 , 0, 0, 3),
(@CGUID+8, @CGUID+23, 3, 0, 515),
(@CGUID+8, @CGUID+11, 3, 72, 515),
(@CGUID+8, @CGUID+17, 3, 144, 515),
(@CGUID+8, @CGUID+5 , 3, 216, 515),
(@CGUID+8, @CGUID+13, 3, 288, 515);

-- Pathing for Protean Horror Entry: 20865
SET @NPC := @CGUID+3;
SET @PATH := @NPC * 10;
UPDATE `creature` SET `wander_distance`=0,`MovementType`=2,`position_x`=202.52419,`position_y`=-114.3171,`position_z`=-10.123289 WHERE `guid`=@NPC;
DELETE FROM `creature_addon` WHERE `guid`=@NPC;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes1`,`bytes2`,`emote`,`visibilityDistanceType`,`auras`) VALUES (@NPC,@PATH,0,0,1,0,0, '');
DELETE FROM `waypoint_data` WHERE `id`=@PATH;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`orientation`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
(@PATH,1,202.52419,-114.3171,-10.123289,NULL,0,0,0,100,0),
(@PATH,2,195.13905,-118.79325,-10.12332,NULL,0,0,0,100,0),
(@PATH,3,195.03548,-145.50099,-10.116196,NULL,0,0,0,100,0),
(@PATH,4,212.1964,-157.94833,-10.113149,NULL,0,0,0,100,0),
(@PATH,5,231.8269,-157.86928,-10.112798,NULL,0,0,0,100,0),
(@PATH,6,235.90848,-164.12933,-10.106403,NULL,0,0,0,100,0),
(@PATH,7,235.05792,-181.03023,-10.108897,NULL,0,0,0,100,0),
(@PATH,8,223.98999,-186.03038,-10.10672,NULL,0,0,0,100,0),
(@PATH,9,230.39694,-194.16634,-10.107081,NULL,0,0,0,100,0),
(@PATH,10,259.7843,-195.02864,-10.10507,NULL,0,0,0,100,0),
(@PATH,11,272.83566,-175.49477,-10.104804,NULL,0,0,0,100,0),
(@PATH,12,278.45392,-153.14717,-10.1086855,NULL,0,0,0,100,0),
(@PATH,13,280.5827,-136.87622,-10.121723,NULL,0,0,0,100,0),
(@PATH,14,261.5679,-119.71741,-10.123237,NULL,0,0,0,100,0),
(@PATH,15,245.82552,-122.29325,-10.123243,NULL,0,0,0,100,0),
(@PATH,16,220.30566,-121.72503,-10.117749,NULL,0,0,0,100,0);
-- 0x2042204500146040001E5D0009135613 .go xyz 202.52419 -114.3171 -10.123289

DELETE FROM `creature_formations` WHERE `leaderGUID` = @CGUID+3 AND `memberGUID` IN (@CGUID+3,@CGUID+6,@CGUID+21,@CGUID+12,@CGUID+19,@CGUID+14);
INSERT INTO `creature_formations` (`leaderGUID`, `memberGUID`, `dist`, `angle`, `groupAI`) VALUES
(@CGUID+3, @CGUID+3 , 0, 0, 3),
(@CGUID+3, @CGUID+6 , 3, 0, 515),
(@CGUID+3, @CGUID+21, 3, 72, 515),
(@CGUID+3, @CGUID+12, 3, 144, 515),
(@CGUID+3, @CGUID+19, 3, 216, 515),
(@CGUID+3, @CGUID+14, 3, 288, 515);

-- Pathing for Protean Horror Entry: 20865
SET @NPC := @CGUID+15;
SET @PATH := @NPC * 10;
UPDATE `creature` SET `wander_distance`=0,`MovementType`=2,`position_x`=301.12772,`position_y`=67.612755,`position_z`=22.438244 WHERE `guid`=@NPC;
DELETE FROM `creature_addon` WHERE `guid`=@NPC;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes1`,`bytes2`,`emote`,`visibilityDistanceType`,`auras`) VALUES (@NPC,@PATH,0,0,1,0,0, '');
DELETE FROM `waypoint_data` WHERE `id`=@PATH;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`orientation`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
(@PATH,1,301.12772,67.612755,22.438244,NULL,0,1,0,100,0),
(@PATH,2,302.1253,107.05763,22.224653,NULL,0,1,0,100,0),
(@PATH,3,300.1723,132.34288,22.228413,NULL,0,1,0,100,0),
(@PATH,4,284.58438,144.91377,22.22117,NULL,0,1,0,100,0),
(@PATH,5,244.56267,147.19673,22.280977,NULL,0,1,0,100,0),
(@PATH,6,228.7991,147.2889,22.307953,NULL,0,1,0,100,0),
(@PATH,7,206.13211,147.52689,22.540571,NULL,0,1,0,100,0),
(@PATH,8,176.72488,163.51595,22.441147,NULL,0,1,0,100,0),
(@PATH,9,166.14273,146.77989,22.441147,NULL,0,1,0,100,0),
(@PATH,10,176.24336,130.70343,22.441147,NULL,0,1,0,100,0),
(@PATH,11,206.13625,147.05757,22.540552,NULL,0,1,0,100,0),
(@PATH,12,244.60933,146.82315,22.280828,NULL,0,1,0,100,0),
(@PATH,13,284.55133,144.52907,22.221207,NULL,0,1,0,100,0),
(@PATH,14,301.51114,107.04327,22.224653,NULL,0,1,0,100,0);
-- 0x2042204500146040001E5D000E135613 .go xyz 301.12772 67.612755 22.438244

-- Pathing for Protean Horror Entry: 20865
SET @NPC := @CGUID+04;
SET @PATH := @NPC * 10;
UPDATE `creature` SET `wander_distance`=0,`MovementType`=2,`position_x`=208.37445,`position_y`=22.330988,`position_z`=48.193367 WHERE `guid`=@NPC;
DELETE FROM `creature_addon` WHERE `guid`=@NPC;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes1`,`bytes2`,`emote`,`visibilityDistanceType`,`auras`) VALUES (@NPC,@PATH,0,0,1,0,0, '');
DELETE FROM `waypoint_data` WHERE `id`=@PATH;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`orientation`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
(@PATH,1,208.37445,22.330988,48.193367,NULL,0,1,0,100,0),
(@PATH,2,233.10588,22.271296,48.33915,NULL,0,1,0,100,0),
(@PATH,3,280.1431,22.352139,48.35042,NULL,0,1,0,100,0),
(@PATH,4,327.02222,22.415138,48.35042,NULL,0,1,0,100,0),
(@PATH,5,365.33887,22.197266,48.212696,NULL,0,1,0,100,0),
(@PATH,6,414.51904,22.458496,48.214485,NULL,0,1,0,100,0),
(@PATH,7,458.984,1.867482,48.221653,NULL,0,1,0,100,0),
(@PATH,8,468.03598,14.782437,49.484177,NULL,0,1,0,100,0),
(@PATH,9,459.82727,37.411278,50.84645,NULL,0,1,0,100,0),
(@PATH,10,434.82935,44.72688,49.352238,NULL,0,1,0,100,0),
(@PATH,11,414.516,22.780737,48.215786,NULL,0,1,0,100,0),
(@PATH,12,365.25113,22.579336,48.212696,NULL,0,1,0,100,0),
(@PATH,13,326.98926,22.717283,48.35042,NULL,0,1,0,100,0),
(@PATH,14,280.14618,22.75021,48.35042,NULL,0,1,0,100,0),
(@PATH,15,233.10696,22.53368,48.33978,NULL,0,1,0,100,0);
-- 0x2042204500146040001E5D000E935613 .go xyz 208.37445 22.330988 48.193367

-- Pathing for Soul Devourer Entry: 20866
SET @NPC := @CGUID+25;
SET @PATH := @NPC * 10;
UPDATE `creature` SET `wander_distance`=0,`MovementType`=2,`position_x`=208.53522,`position_y`=-152.27895,`position_z`=-10.112484 WHERE `guid`=@NPC;
DELETE FROM `creature_addon` WHERE `guid`=@NPC;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes1`,`bytes2`,`emote`,`visibilityDistanceType`,`auras`) VALUES (@NPC,@PATH,0,0,1,0,0, '');
DELETE FROM `waypoint_data` WHERE `id`=@PATH;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`orientation`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
(@PATH,1,208.53522,-152.27895,-10.112484,NULL,0,0,0,100,0),
(@PATH,2,221.87071,-152.57721,-10.11229,NULL,0,0,0,100,0),
(@PATH,3,237.18454,-152.618,-10.10515,NULL,0,0,0,100,0),
(@PATH,4,253.95305,-152.81169,-10.106597,NULL,0,0,0,100,0),
(@PATH,5,253.27829,-175.50299,-10.103562,NULL,0,0,0,100,0),
(@PATH,6,253.95305,-152.81169,-10.106597,NULL,0,0,0,100,0),
(@PATH,7,237.18454,-152.618,-10.10515,NULL,0,0,0,100,0),
(@PATH,8,221.87071,-152.57721,-10.11229,NULL,0,0,0,100,0);
-- 0x2042204500146080001E5D0000135613 .go xyz 208.53522 -152.27895 -10.112484

-- Pathing for Soul Devourer Entry: 20866
SET @NPC := @CGUID+26;
SET @PATH := @NPC * 10;
UPDATE `creature` SET `wander_distance`=0,`MovementType`=2,`position_x`=276.79434,`position_y`=-145.29054,`position_z`=-10.11652 WHERE `guid`=@NPC;
DELETE FROM `creature_addon` WHERE `guid`=@NPC;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes1`,`bytes2`,`emote`,`visibilityDistanceType`,`auras`) VALUES (@NPC,@PATH,0,0,1,0,0, '');
DELETE FROM `waypoint_data` WHERE `id`=@PATH;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`orientation`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
(@PATH,1,276.79434,-145.29054,-10.11652,NULL,0,0,0,100,0),
(@PATH,2,256.17062,-143.82663,-10.110913,NULL,0,0,0,100,0),
(@PATH,3,245.10881,-143.02563,-10.110268,NULL,0,0,0,100,0),
(@PATH,4,245.43143,-128.669,-10.117723,NULL,0,0,0,100,0),
(@PATH,5,207.70795,-129.07368,-10.109515,NULL,0,0,0,100,0),
(@PATH,6,207.70795,-129.07368,-10.109515,NULL,0,0,0,100,0),
(@PATH,7,245.43143,-128.669,-10.117723,NULL,0,0,0,100,0),
(@PATH,8,245.10881,-143.02563,-10.110268,NULL,0,0,0,100,0),
(@PATH,9,256.17062,-143.82663,-10.110913,NULL,0,0,0,100,0);
-- 0x2042204500146080001E5D0000935613 .go xyz 276.79434 -145.29054 -10.11652

-- Pathing for Skulking Witch Entry: 20882
SET @NPC := @CGUID+48;
SET @PATH := @NPC * 10;
UPDATE `creature` SET `wander_distance`=0,`MovementType`=2,`position_x`=124.99534,`position_y`=147.42181,`position_z`=22.441147 WHERE `guid`=@NPC;
DELETE FROM `creature_addon` WHERE `guid`=@NPC;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes1`,`bytes2`,`emote`,`visibilityDistanceType`,`auras`) VALUES (@NPC,@PATH,0,0,1,0,0, '16380');
DELETE FROM `waypoint_data` WHERE `id`=@PATH;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`orientation`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
(@PATH,1,124.99534,147.42181,22.441147,NULL,0,0,0,100,0),
(@PATH,2,155.76085,137.09187,20.814901,NULL,0,0,0,100,0),
(@PATH,3,172.89482,137.45894,22.441147,NULL,0,0,0,100,0),
(@PATH,4,190.26704,137.98639,22.441149,NULL,0,0,0,100,0),
(@PATH,5,190.19278,146.74756,22.441149,NULL,0,0,0,100,0),
(@PATH,6,190.34236,155.19014,22.44115,NULL,0,0,0,100,0),
(@PATH,7,172.85747,156.48407,22.441147,NULL,0,0,0,100,0),
(@PATH,8,156.17549,158.80054,20.814901,NULL,0,0,0,100,0);
-- 0x2042204500146480001E5D0000135613 .go xyz 124.99534 147.42181 22.441147

-- Pathing for Ethereum Slayer Entry: 20896
SET @NPC := @CGUID+53;
SET @PATH := @NPC * 10;
UPDATE `creature` SET `wander_distance`=0,`MovementType`=2,`position_x`=442.4002,`position_y`=-20.45843,`position_z`=48.212788 WHERE `guid`=@NPC;
DELETE FROM `creature_addon` WHERE `guid`=@NPC;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes1`,`bytes2`,`emote`,`visibilityDistanceType`,`auras`) VALUES (@NPC,@PATH,0,0,1,0,0, '');
DELETE FROM `waypoint_data` WHERE `id`=@PATH;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`orientation`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
(@PATH,1,442.4002,-20.45843,48.212788,NULL,0,0,0,100,0),
(@PATH,2,449.3031,-20.429773,48.238365,NULL,0,0,0,100,0),
(@PATH,3,449.4046,1.538476,48.219746,NULL,0,0,0,100,0),
(@PATH,4,463.29834,5.452207,48.305122,NULL,0,0,0,100,0),
(@PATH,5,466.79602,19.510277,49.99231,NULL,0,0,0,100,0),
(@PATH,6,460.21735,36.802353,50.84645,NULL,0,0,0,100,0),
(@PATH,7,439.6564,44.632866,49.722843,NULL,0,0,0,100,0),
(@PATH,8,427.544,41.33546,48.411602,NULL,0,0,0,100,0),
(@PATH,9,426.6427,32.553425,48.206783,NULL,0,0,0,100,0),
(@PATH,10,436.76343,19.38034,48.21401,NULL,0,0,0,100,0),
(@PATH,11,442.88638,11.988906,48.23025,NULL,0,0,0,100,0);
-- 0x2042204500146800001E5D0001135613 .go xyz 442.4002 -20.45843 48.212788

DELETE FROM `creature_formations` WHERE `leaderGUID` = @CGUID+53 AND `memberGUID` IN (@CGUID+53,@CGUID+55,@CGUID+96,@CGUID+57);
INSERT INTO `creature_formations` (`leaderGUID`, `memberGUID`, `dist`, `angle`, `groupAI`) VALUES
(@CGUID+53, @CGUID+53, 0, 0, 3),
(@CGUID+53, @CGUID+55, 3, 0, 515),
(@CGUID+53, @CGUID+96, 3, 120, 515),
(@CGUID+53, @CGUID+57, 3, 240, 515);

-- Pathing for Gargantuan Abyssal Entry: 20898
SET @NPC := @CGUID+58;
SET @PATH := @NPC * 10;
UPDATE `creature` SET `wander_distance`=0,`MovementType`=2,`position_x`=456.1953,`position_y`=-162.02287,`position_z`=43.097973 WHERE `guid`=@NPC;
DELETE FROM `creature_addon` WHERE `guid`=@NPC;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes1`,`bytes2`,`emote`,`visibilityDistanceType`,`auras`) VALUES (@NPC,@PATH,0,0,1,0,0, '');
DELETE FROM `waypoint_data` WHERE `id`=@PATH;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`orientation`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
(@PATH,1,456.1953,-162.02287,43.097973,NULL,0,0,0,100,0),
(@PATH,2,444.38632,-151.77869,43.037457,NULL,0,0,0,100,0),
(@PATH,3,437.77167,-136.3138,43.100117,NULL,0,0,0,100,0),
(@PATH,4,441.69543,-123.04215,43.10011,NULL,0,0,0,100,0),
(@PATH,5,445.06357,-105.65653,43.100105,NULL,0,0,0,100,0),
(@PATH,6,446.46475,-89.316284,43.100094,NULL,0,0,0,100,0),
(@PATH,7,446.41287,-65.38533,48.39542,NULL,0,0,0,100,0),
(@PATH,8,446.46475,-89.316284,43.100094,NULL,0,0,0,100,0),
(@PATH,9,445.06357,-105.65653,43.100105,NULL,0,0,0,100,0),
(@PATH,10,441.69543,-123.04215,43.10011,NULL,0,0,0,100,0),
(@PATH,11,437.77167,-136.3138,43.100117,NULL,0,0,0,100,0),
(@PATH,12,444.38632,-151.77869,43.037457,NULL,0,0,0,100,0);
-- 0x2042204500146880001E5D0000935613 .go xyz 456.1953 -162.02287 43.097973

/*
	Scripted Pathing
*/

DELETE FROM `waypoints` WHERE `point_comment` LIKE 'Protean Horror%' AND `entry` BETWEEN 2086500 AND 2086505;
INSERT INTO `waypoints` (`entry`, `pointid`, `position_x`, `position_y`, `position_z`, `orientation`, `point_comment`) VALUES
-- Pathing for Protean Horror Entry: 20865 GUID: +07
-- Randomly Selected at the end
(2086500,1,237.77904,-161.02078,-9.86023,NULL,'Protean Horror - Random Path 1'),
(2086500,2,236.75801,-193.39262,-10.107179,NULL,'Protean Horror - Random Path 1'),
(2086500,3,260.3886,-194.68185,-10.105082,NULL,'Protean Horror - Random Path 1'),
(2086500,4,268.60522,-158.09924,-10.105517,NULL,'Protean Horror - Random Path 1'),
(2086500,5,237.7268,-160.15494,-10.101749,NULL,'Protean Horror - Random Path 1'),
(2086500,6,220.80006,-160.14894,-10.113282,NULL,'Protean Horror - Random Path 1'),

(2086501,1,202.58867,-149.75804,-10.114253,NULL,'Protean Horror - Random Path 2'),
(2086501,2,202.54631,-119.9808,-10.119678,NULL,'Protean Horror - Random Path 2'),
(2086501,3,235.29565,-126.66605,-10.1168585,NULL,'Protean Horror - Random Path 2'),
(2086501,4,260.4425,-120.10798,-10.123238,NULL,'Protean Horror - Random Path 2'),
(2086501,5,261.34445,-148.69566,-10.109158,NULL,'Protean Horror - Random Path 2'),
(2086501,6,220.35661,-161.02452,-10.113402,NULL,'Protean Horror - Random Path 2'),

(2086502,1 ,228.45674,-182.32353,-0.4047474,NULL,'Protean Horror - Random Path 3'),
(2086502,2 ,242.84274,-189.01254,6.2220397,NULL,'Protean Horror - Random Path 3'),
(2086502,3 ,258.3724,-185.33528,13.020767,NULL,'Protean Horror - Random Path 3'),
(2086502,4 ,267.94284,-170.10384,20.863707,NULL,'Protean Horror - Random Path 3'),
(2086502,5 ,267.90543,-139.87071,22.630386,NULL,'Protean Horror - Random Path 3'),
(2086502,6 ,267.39816,-90.36618,22.497723,NULL,'Protean Horror - Random Path 3'),
(2086502,7 ,267.34595,-139.87727,22.635983,NULL,'Protean Horror - Random Path 3'),
(2086502,8 ,267.20602,-169.32367,21.112097,NULL,'Protean Horror - Random Path 3'),
(2086502,9 ,258.33258,-183.84918,13.519743,NULL,'Protean Horror - Random Path 3'),
(2086502,10,243.24022,-187.99068,6.286567,NULL,'Protean Horror - Random Path 3'),
(2086502,11,229.67354,-182.05469,-0.16981333,NULL,'Protean Horror - Random Path 3'),
(2086502,12,220.87141,-168.25581,-7.4928436,NULL,'Protean Horror - Random Path 3'),
(2086502,13,220.35635,-160.70712,-10.113361,NULL,'Protean Horror - Random Path 3'),
-- Pathing for Protean Horror Entry: 20865 GUID: +24
-- Randomly Selected at the end
(2086503,1,261.6127,-189.98672,-10.10487,NULL,'Protean Horror - Random Path 1'),
(2086503,2,227.53447,-192.88065,-10.105654,NULL,'Protean Horror - Random Path 1'),
(2086503,3,234.71745,-166.73166,-10.107577,NULL,'Protean Horror - Random Path 1'),
(2086503,4,273.68204,-161.13853,-10.110326,NULL,'Protean Horror - Random Path 1'),

(2086504,1,230.67825,-159.68645,-10.113051,NULL,'Protean Horror - Random Path 2'),
(2086504,2,230.01398,-122.99717,-10.118055,NULL,'Protean Horror - Random Path 2'),
(2086504,3,260.8361,-119.30777,-10.123237,NULL,'Protean Horror - Random Path 2'),
(2086504,4,274.492,-160.3677,-10.11127,NULL,'Protean Horror - Random Path 2'),

(2086505,1,246.39204,-144.1044,-10.109891,NULL,'Protean Horror - Random Path 3'),
(2086505,2,216.76047,-123.82127,-10.108683,NULL,'Protean Horror - Random Path 3'),
(2086505,3,202.98213,-110.55506,-10.123076,NULL,'Protean Horror - Random Path 3'),
(2086505,4,194.93211,-130.28767,-10.12011,NULL,'Protean Horror - Random Path 3'),
(2086505,5,194.4479,-140.82317,-10.118727,NULL,'Protean Horror - Random Path 3'),
(2086505,6,224.49347,-142.0825,-10.110895,NULL,'Protean Horror - Random Path 3'),
(2086505,7,253.40977,-160.71367,-10.1047535,NULL,'Protean Horror - Random Path 3'),
(2086505,8,274.55026,-161.28899,-10.110444,NULL,'Protean Horror - Random Path 3');

DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` IN (-(@CGUID+07), -(@CGUID+24)));
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(-(@CGUID+07), 0, 0, 0, 0, 0, 100, 0, 2000, 8000, 7000, 7000, 0, 11, 36612, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Protean Horror - In Combat - Cast \'Toothy Bite\''),
(-(@CGUID+07), 0, 1, 0, 8, 0, 50, 512, 36327, 0, 0, 0, 0, 51, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Protean Horror - On Spellhit \'Shoot Arcane Explosion Arrow\' - Kill Target'),
(-(@CGUID+07), 0, 1001, 0, 11, 0, 100, 512, 0, 0, 0, 0, 0, 87, 2086500, 2086501, 2086502, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Protean Horror - On Respawn - Run Random Script'),
(-(@CGUID+07), 0, 1002, 0, 58, 0, 100, 0, 0, 0, 0, 0, 0, 87, 2086500, 2086501, 2086502, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Protean Horror - On Waypoint Finished - Run Random Script'),

(-(@CGUID+24), 0, 0, 0, 0, 0, 100, 0, 2000, 8000, 7000, 7000, 0, 11, 36612, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Protean Horror - In Combat - Cast \'Toothy Bite\''),
(-(@CGUID+24), 0, 1, 0, 8, 0, 50, 512, 36327, 0, 0, 0, 0, 51, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Protean Horror - On Spellhit \'Shoot Arcane Explosion Arrow\' - Kill Target'),
(-(@CGUID+24), 0, 1001, 0, 11, 0, 100, 512, 0, 0, 0, 0, 0, 87, 2086503, 2086504, 2086505, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Protean Horror - On Respawn - Run Random Script'),
(-(@CGUID+24), 0, 1002, 0, 58, 0, 100, 0, 0, 0, 0, 0, 0, 87, 2086503, 2086504, 2086505, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Protean Horror - On Waypoint Finished - Run Random Script');

DELETE FROM `smart_scripts` WHERE (`source_type` = 9 AND `entryorguid` BETWEEN 2086500 AND 2086505);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(2086500, 9, 0, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 53, 1, 2086500, 0, 0, 0, 2, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Protean Horror - Actionlist - Start Waypoint'),
(2086501, 9, 0, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 53, 1, 2086501, 0, 0, 0, 2, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Protean Horror - Actionlist - Start Waypoint'),
(2086502, 9, 0, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 53, 1, 2086502, 0, 0, 0, 2, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Protean Horror - Actionlist - Start Waypoint'),
(2086503, 9, 0, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 53, 1, 2086503, 0, 0, 0, 2, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Protean Horror - Actionlist - Start Waypoint'),
(2086504, 9, 0, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 53, 1, 2086504, 0, 0, 0, 2, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Protean Horror - Actionlist - Start Waypoint'),
(2086505, 9, 0, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 53, 1, 2086505, 0, 0, 0, 2, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Protean Horror - Actionlist - Start Waypoint');

-- Pathing for Protean Nightmare Entry: 20864
DELETE FROM `waypoints` WHERE `point_comment` LIKE 'Protean Nightmare%' AND `entry` BETWEEN 2086400 AND 2086403;
INSERT INTO `waypoints` (`entry`, `pointid`, `position_x`, `position_y`, `position_z`, `orientation`, `point_comment`) VALUES
-- @CGUID+01
(2086400,1,217.09438,9.082261,-7.4683995,NULL,'Protean Nightmare'),
(2086400,2,224.82596,-1.105318,-8.197451,NULL,'Protean Nightmare'),
(2086400,3,223.71288,-13.408787,-9.599378,NULL,'Protean Nightmare'),
(2086400,4,212.49054,-17.97817,-10.091022,NULL,'Protean Nightmare'),
(2086400,5,198.7105,-5.965413,-10.102091,NULL,'Protean Nightmare - Random Movement'), -- 20-30s of random movement (3y)
(2086401,1,192.63458,6.129091,-10.10528,NULL,'Protean Nightmare'),
(2086401,2,183.20636,12.026545,-10.096576,NULL,'Protean Nightmare'),
(2086401,3,187.25227,20.871046,-9.640596,NULL,'Protean Nightmare'),
(2086401,4,196.87997,22.969841,-8.600537,NULL,'Protean Nightmare'),
(2086401,5,205.79718,18.459171,-7.626488,NULL,'Protean Nightmare'),
(2086401,6,208.34787,9.844978,-7.4684005,NULL,'Protean Nightmare'),
(2086401,7,208.99312,6.980381,-7.4684,2.862339973449707031,'Protean Nightmare - Random Movement'), -- 20-30s of random movement (3y)
-- @CGUID+02
(2086402,1,203.17947,-32.20689,-10.101378,NULL,'Protean Nightmare'),
(2086402,2,203.19337,-20.843853,-10.093281,NULL,'Protean Nightmare - Random Movement'), -- 20-30s of random movement (3y)
(2086403,1,203.17947,-32.20689,-10.101378,NULL,'Protean Nightmare'),
(2086403,2,202.77959,-41.40766,-10.095723,5.846852779388427734,'Protean Nightmare - Random Movement'); -- 20-30s of random movement (3y)

DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` IN (-(@CGUID+01),-(@CGUID+02)));
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(-(@CGUID+01), 0, 0, 0, 0, 0, 100, 2, 2000, 2000, 20000, 20000, 0, 11, 36617, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Protean Nightmare - In Combat - Cast \'Gaping Maw\' (Normal Dungeon)'),
(-(@CGUID+01), 0, 1, 0, 0, 0, 100, 4, 2000, 2000, 20000, 20000, 0, 11, 38810, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Protean Nightmare - In Combat - Cast \'Gaping Maw\' (Heroic Dungeon)'),
(-(@CGUID+01), 0, 2, 0, 0, 0, 100, 2, 8000, 8000, 20000, 20000, 0, 11, 36619, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Protean Nightmare - In Combat - Cast \'Infectious Poison\' (Normal Dungeon)'),
(-(@CGUID+01), 0, 3, 0, 0, 0, 100, 4, 8000, 8000, 20000, 20000, 0, 11, 38811, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Protean Nightmare - In Combat - Cast \'Infectious Poison\' (Heroic Dungeon)'),
(-(@CGUID+01), 0, 4, 0, 0, 0, 100, 0, 12000, 12000, 30000, 30000, 0, 11, 36622, 0, 0, 0, 0, 0, 5, 30, 0, 0, 0, 0, 0, 0, 0, 'Protean Nightmare - In Combat - Cast \'Incubation\''),
(-(@CGUID+01), 0, 5, 0, 8, 0, 50, 512, 36327, 0, 0, 0, 0, 51, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Protean Nightmare - On Spellhit \'Shoot Arcane Explosion Arrow\' - Kill Target'),
(-(@CGUID+01), 0, 1001, 0, 11, 0, 100, 0, 0, 0, 0, 0, 0, 80, 2086400, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Protean Nightmare - On Respawn - Run Script (Start Random Movement and Path 1)'),
(-(@CGUID+01), 0, 1002, 0, 58, 0, 100, 0, 0, 2086400, 0, 0, 0, 80, 2086401, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Protean Nightmare - On Waypoint Finished - Run Script (Start Random Movement and Path 2)'),
(-(@CGUID+01), 0, 1003, 0, 58, 0, 100, 0, 0, 2086401, 0, 0, 0, 80, 2086400, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Protean Nightmare - On Waypoint Finished - Run Script (Start Random Movement and Path 1)'),

(-(@CGUID+02), 0, 0, 0, 0, 0, 100, 2, 2000, 2000, 20000, 20000, 0, 11, 36617, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Protean Nightmare - In Combat - Cast \'Gaping Maw\' (Normal Dungeon)'),
(-(@CGUID+02), 0, 1, 0, 0, 0, 100, 4, 2000, 2000, 20000, 20000, 0, 11, 38810, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Protean Nightmare - In Combat - Cast \'Gaping Maw\' (Heroic Dungeon)'),
(-(@CGUID+02), 0, 2, 0, 0, 0, 100, 2, 8000, 8000, 20000, 20000, 0, 11, 36619, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Protean Nightmare - In Combat - Cast \'Infectious Poison\' (Normal Dungeon)'),
(-(@CGUID+02), 0, 3, 0, 0, 0, 100, 4, 8000, 8000, 20000, 20000, 0, 11, 38811, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Protean Nightmare - In Combat - Cast \'Infectious Poison\' (Heroic Dungeon)'),
(-(@CGUID+02), 0, 4, 0, 0, 0, 100, 0, 12000, 12000, 30000, 30000, 0, 11, 36622, 0, 0, 0, 0, 0, 5, 30, 0, 0, 0, 0, 0, 0, 0, 'Protean Nightmare - In Combat - Cast \'Incubation\''),
(-(@CGUID+02), 0, 5, 0, 8, 0, 50, 512, 36327, 0, 0, 0, 0, 51, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Protean Nightmare - On Spellhit \'Shoot Arcane Explosion Arrow\' - Kill Target'),
(-(@CGUID+02), 0, 1001, 0, 11, 0, 100, 0, 0, 0, 0, 0, 0, 80, 2086402, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Protean Nightmare - On Respawn - Run Script (Start Random Movement and Path 1)'),
(-(@CGUID+02), 0, 1002, 0, 58, 0, 100, 0, 0, 2086402, 0, 0, 0, 80, 2086403, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Protean Nightmare - On Waypoint Finished - Run Script (Start Random Movement and Path 2)'),
(-(@CGUID+02), 0, 1003, 0, 58, 0, 100, 0, 0, 2086403, 0, 0, 0, 80, 2086402, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Protean Nightmare - On Waypoint Finished - Run Script (Start Random Movement and Path 1)');

DELETE FROM `smart_scripts` WHERE (`source_type` = 9 AND `entryorguid` IN (2086400, 2086401, 2086402, 2086403));
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(2086400, 9, 0, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 45, 1, 1, 0, 0, 0, 0, 9, 20865, 0, 10, 1, 0, 0, 0, 0, 'Protean Nightmare - Actionlist - Set Data 1 1 (Stop Follow and Start Random Movement)'),
(2086400, 9, 1, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 89, 3, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Protean Nightmare - Actionlist - Start Random Movement'),
(2086400, 9, 2, 0, 0, 0, 100, 0, 20000, 40000, 0, 0, 0, 45, 2, 2, 0, 0, 0, 0, 9, 20865, 0, 10, 1, 0, 0, 0, 0, 'Protean Nightmare - Actionlist - Set Data 2 2  (Start Follow and Stop Random Movement)'),
(2086400, 9, 3, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 53, 0, 2086400, 0, 0, 0, 2, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Protean Nightmare - Actionlist - Start Waypoint'),

(2086401, 9, 0, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 45, 1, 1, 0, 0, 0, 0, 9, 20865, 0, 10, 1, 0, 0, 0, 0, 'Protean Nightmare - Actionlist - Set Data 1 1 (Stop Follow and Start Random Movement)'),
(2086401, 9, 1, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 89, 3, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Protean Nightmare - Actionlist - Start Random Movement'),
(2086401, 9, 2, 0, 0, 0, 100, 0, 20000, 40000, 0, 0, 0, 45, 2, 2, 0, 0, 0, 0, 9, 20865, 0, 10, 1, 0, 0, 0, 0, 'Protean Nightmare - Actionlist - Set Data 2 2  (Start Follow and Stop Random Movement)'),
(2086401, 9, 3, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 53, 0, 2086401, 0, 0, 0, 2, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Protean Nightmare - Actionlist - Start Waypoint'),

(2086402, 9, 0, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 45, 1, 1, 0, 0, 0, 0, 9, 20865, 0, 10, 1, 0, 0, 0, 0, 'Protean Nightmare - Actionlist - Set Data 1 1 (Stop Follow and Start Random Movement)'),
(2086402, 9, 1, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 89, 3, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Protean Nightmare - Actionlist - Start Random Movement'),
(2086402, 9, 2, 0, 0, 0, 100, 0, 20000, 40000, 0, 0, 0, 45, 2, 2, 0, 0, 0, 0, 9, 20865, 0, 10, 1, 0, 0, 0, 0, 'Protean Nightmare - Actionlist - Set Data 2 2  (Start Follow and Stop Random Movement)'),
(2086402, 9, 3, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 53, 0, 2086402, 0, 0, 0, 2, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Protean Nightmare - Actionlist - Start Waypoint'),

(2086403, 9, 0, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 45, 1, 1, 0, 0, 0, 0, 9, 20865, 0, 10, 1, 0, 0, 0, 0, 'Protean Nightmare - Actionlist - Set Data 1 1 (Stop Follow and Start Random Movement)'),
(2086403, 9, 1, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 89, 3, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Protean Nightmare - Actionlist - Start Random Movement'),
(2086403, 9, 2, 0, 0, 0, 100, 0, 20000, 40000, 0, 0, 0, 45, 2, 2, 0, 0, 0, 0, 9, 20865, 0, 10, 1, 0, 0, 0, 0, 'Protean Nightmare - Actionlist - Set Data 2 2  (Start Follow and Stop Random Movement)'),
(2086403, 9, 3, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 53, 0, 2086403, 0, 0, 0, 2, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Protean Nightmare - Actionlist - Start Waypoint');

DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` IN (-(@CGUID+20),-(@CGUID+16),-(@CGUID+18),-(@CGUID+09)));
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(-(@CGUID+20), 0, 0, 0, 0, 0, 100, 0, 2000, 8000, 7000, 7000, 0, 11, 36612, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Protean Horror - In Combat - Cast \'Toothy Bite\''),
(-(@CGUID+20), 0, 1, 0, 8, 0, 50, 512, 36327, 0, 0, 0, 0, 51, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Protean Horror - On Spellhit \'Shoot Arcane Explosion Arrow\' - Kill Target'),
(-(@CGUID+20), 0, 1001, 1002, 38, 0, 100, 0, 1, 1, 0, 0, 0, 29, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Protean Horror - On Data Set 1 1 (Protean Nightmare) - Start Follow Self'),
(-(@CGUID+20), 0, 1002, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 89, 3, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Protean Horror - On Data Set 1 1 (Protean Nightmare) - Start Random Movement'),
(-(@CGUID+20), 0, 1003, 0, 38, 0, 100, 0, 2, 2, 0, 0, 0, 29, 1, 135, 0, 0, 0, 0, 10, (@CGUID+01), 20864, 0, 0, 0, 0, 0, 0, 'Protean Horror - On Data Set 2 2 (Protean Nightmare) - Start Follow Closest Creature \'Protean Nightmare\''),

(-(@CGUID+16), 0, 0, 0, 0, 0, 100, 0, 2000, 8000, 7000, 7000, 0, 11, 36612, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Protean Horror - In Combat - Cast \'Toothy Bite\''),
(-(@CGUID+16), 0, 1, 0, 8, 0, 50, 512, 36327, 0, 0, 0, 0, 51, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Protean Horror - On Spellhit \'Shoot Arcane Explosion Arrow\' - Kill Target'),
(-(@CGUID+16), 0, 1001, 1002, 38, 0, 100, 0, 1, 1, 0, 0, 0, 29, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Protean Horror - On Data Set 1 1 (Protean Nightmare) - Start Follow Self'),
(-(@CGUID+16), 0, 1002, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 89, 3, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Protean Horror - On Data Set 1 1 (Protean Nightmare) - Start Random Movement'),
(-(@CGUID+16), 0, 1003, 0, 38, 0, 100, 0, 2, 2, 0, 0, 0, 29, 1, 225, 0, 0, 0, 0, 10, (@CGUID+01), 20864, 0, 0, 0, 0, 0, 0, 'Protean Horror - On Data Set 2 2 (Protean Nightmare) - Start Follow Closest Creature \'Protean Nightmare\''),

(-(@CGUID+18), 0, 0, 0, 0, 0, 100, 0, 2000, 8000, 7000, 7000, 0, 11, 36612, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Protean Horror - In Combat - Cast \'Toothy Bite\''),
(-(@CGUID+18), 0, 1, 0, 8, 0, 50, 512, 36327, 0, 0, 0, 0, 51, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Protean Horror - On Spellhit \'Shoot Arcane Explosion Arrow\' - Kill Target'),
(-(@CGUID+18), 0, 1001, 1002, 38, 0, 100, 0, 1, 1, 0, 0, 0, 29, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Protean Horror - On Data Set 1 1 (Protean Nightmare) - Start Follow Self'),
(-(@CGUID+18), 0, 1002, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 89, 3, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Protean Horror - On Data Set 1 1 (Protean Nightmare) - Start Random Movement'),
(-(@CGUID+18), 0, 1003, 0, 38, 0, 100, 0, 2, 2, 0, 0, 0, 29, 1, 135, 0, 0, 0, 0, 10, (@CGUID+02), 20864, 0, 0, 0, 0, 0, 0, 'Protean Horror - On Data Set 2 2 (Protean Nightmare) - Start Follow Closest Creature \'Protean Nightmare\''),

(-(@CGUID+09), 0, 0, 0, 0, 0, 100, 0, 2000, 8000, 7000, 7000, 0, 11, 36612, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Protean Horror - In Combat - Cast \'Toothy Bite\''),
(-(@CGUID+09), 0, 1, 0, 8, 0, 50, 512, 36327, 0, 0, 0, 0, 51, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Protean Horror - On Spellhit \'Shoot Arcane Explosion Arrow\' - Kill Target'),
(-(@CGUID+09), 0, 1001, 1002, 38, 0, 100, 0, 1, 1, 0, 0, 0, 29, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Protean Horror - On Data Set 1 1 (Protean Nightmare) - Start Follow Self'),
(-(@CGUID+09), 0, 1002, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 89, 3, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Protean Horror - On Data Set 1 1 (Protean Nightmare) - Start Random Movement'),
(-(@CGUID+09), 0, 1003, 0, 38, 0, 100, 0, 2, 2, 0, 0, 0, 29, 1, 225, 0, 0, 0, 0, 10, (@CGUID+02), 20864, 0, 0, 0, 0, 0, 0, 'Protean Horror - On Data Set 2 2 (Protean Nightmare) - Start Follow Closest Creature \'Protean Nightmare\'');

-- Action 40 has trouble with short WPs, After it's fixed delete duplicated WPs
DELETE FROM `waypoints` WHERE `point_comment` LIKE 'Entropic Eye%' AND `entry`=2086800;
INSERT INTO `waypoints` (`entry`, `pointid`, `position_x`, `position_y`, `position_z`, `orientation`, `point_comment`) VALUES
(2086800,1,257.83023,-125.83658,-10.123239,NULL,'Entropic Eye'),
(2086800,2,258.53995,-147.47809,-10.109458,NULL,'Entropic Eye'),
(2086800,3,257.83023,-125.83658,-10.123239,NULL,'Entropic Eye - Duplicated Waypoint, Delete Later'),
(2086800,4,258.53995,-147.47809,-10.109458,NULL,'Entropic Eye - Duplicated Waypoint, Delete Later');

DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = -(@CGUID+30));
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(-(@CGUID+30), 0, 0, 0, 0, 0, 70, 6, 3000, 3000, 25000, 25000, 0, 11, 36677, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Entropic Eye - In Combat - Cast \'Chaos Breath\' (Dungeon)'),
(-(@CGUID+30), 0, 1, 0, 0, 0, 75, 2, 8000, 8000, 22000, 22000, 0, 11, 36664, 0, 0, 0, 0, 0, 5, 0, 0, 0, 0, 0, 0, 0, 0, 'Entropic Eye - In Combat - Cast \'Tentacle Cleave\' (Normal Dungeon)'),
(-(@CGUID+30), 0, 2, 0, 0, 0, 75, 4, 8000, 8000, 22000, 22000, 0, 11, 38816, 0, 0, 0, 0, 0, 5, 0, 0, 0, 0, 0, 0, 0, 0, 'Entropic Eye - In Combat - Cast \'Tentacle Cleave\' (Heroic Dungeon)'),
(-(@CGUID+30), 0, 1001, 0, 11, 0, 100, 0, 0, 0, 0, 0, 0, 53, 0, 2086800, 1, 0, 0, 2, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Entropic Eye - On Respawn - Start Waypoint'),
(-(@CGUID+30), 0, 1002, 0, 40, 0, 100, 0, 0, 2086800, 0, 0, 0, 80, 2086800, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Entropic Eye - On Waypoint Any Reached - Run Script');

DELETE FROM `smart_scripts` WHERE (`source_type` = 9 AND `entryorguid` = 2086800);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(2086800, 9, 0, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 54, 25000, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Entropic Eye - Actionlist - Pause Waypoint'),
(2086800, 9, 2, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 89, 5, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Entropic Eye - Actionlist - Start Random Movement');

-- Pathing for Death Watcher Entry: 20867
DELETE FROM `waypoints` WHERE `point_comment` LIKE 'Death Watcher%' AND `entry`=2086700;
INSERT INTO `waypoints` (`entry`, `pointid`, `position_x`, `position_y`, `position_z`, `orientation`, `point_comment`) VALUES
(2086700,1,232.48465,-138.72578,-10.11108,2.408554315567016601,'Death Watcher'),
(2086700,2,214.05183,-138.74442,-10.110648,NULL,'Death Watcher'),
(2086700,3,232.48465,-138.72578,-10.11108,2.408554315567016601,'Death Watcher - Duplicated Waypoint, Delete Later'),
(2086700,4,214.05183,-138.74442,-10.110648,NULL,'Death Watcher - Duplicated Waypoint, Delete Later');

DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = -(@CGUID+27));
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(-(@CGUID+27), 0, 0, 0, 2, 0, 100, 3, 0, 50, 0, 0, 0, 11, 36657, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Death Watcher - Between 0-50% Health - Cast \'Death Count\' (No Repeat) (Normal Dungeon)'),
(-(@CGUID+27), 0, 1, 0, 2, 0, 100, 5, 0, 50, 0, 0, 0, 11, 38818, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Death Watcher - Between 0-50% Health - Cast \'Death Count\' (No Repeat) (Heroic Dungeon)'),
(-(@CGUID+27), 0, 2, 0, 0, 0, 100, 2, 7000, 10000, 20000, 23000, 0, 11, 36655, 0, 0, 0, 0, 0, 5, 20, 0, 0, 0, 0, 0, 0, 0, 'Death Watcher - In Combat - Cast \'Drain Life\' (Normal Dungeon)'),
(-(@CGUID+27), 0, 3, 0, 0, 0, 100, 4, 7000, 10000, 20000, 23000, 0, 11, 38817, 0, 0, 0, 0, 0, 5, 20, 0, 0, 0, 0, 0, 0, 0, 'Death Watcher - In Combat - Cast \'Drain Life\' (Heroic Dungeon)'),
(-(@CGUID+27), 0, 4, 0, 0, 0, 100, 2, 1000, 3000, 10000, 13000, 0, 11, 36664, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Death Watcher - In Combat - Cast \'Tentacle Cleave\' (Normal Dungeon)'),
(-(@CGUID+27), 0, 5, 0, 0, 0, 100, 4, 1000, 3000, 10000, 13000, 0, 11, 38816, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Death Watcher - In Combat - Cast \'Tentacle Cleave\' (Heroic Dungeon)'),
(-(@CGUID+27), 0, 6, 0, 6, 0, 100, 514, 0, 0, 0, 0, 0, 28, 36657, 0, 0, 0, 0, 0, 21, 50, 0, 0, 0, 0, 0, 0, 0, 'Death Watcher - On Just Died - Remove Aura \'Death Count\' (Normal Dungeon)'),
(-(@CGUID+27), 0, 7, 0, 6, 0, 100, 516, 0, 0, 0, 0, 0, 28, 38818, 0, 0, 0, 0, 0, 21, 50, 0, 0, 0, 0, 0, 0, 0, 'Death Watcher - On Just Died - Remove Aura \'Death Count\' (Heroic Dungeon)'),
(-(@CGUID+27), 0, 1001, 0, 11, 0, 100, 0, 0, 0, 0, 0, 0, 53, 0, 2086700, 1, 0, 0, 2, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Death Watcher - On Respawn - Start Waypoint'),
(-(@CGUID+27), 0, 1002, 0, 40, 0, 100, 0, 0, 2086700, 0, 0, 0, 80, 2086700, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Death Watcher - On Waypoint Any Reached - Run Script');

DELETE FROM `smart_scripts` WHERE (`source_type` = 9 AND `entryorguid` = 2086700);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(2086700, 9, 0, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 54, 25000, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Death Watcher - Actionlist - Pause Waypoint'),
(2086700, 9, 2, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 89, 5, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Death Watcher - Actionlist - Start Random Movement');

-- Pathing for Negaton Screamer Entry: 20875
DELETE FROM `waypoints` WHERE `point_comment` LIKE 'Negaton Screamer%' AND `entry`=2087500;
INSERT INTO `waypoints` (`entry`, `pointid`, `position_x`, `position_y`, `position_z`, `orientation`, `point_comment`) VALUES
(2087500,1,266.75012,-17.823483,22.449232,5.899212837219238281,'Negaton Screamer'),
(2087500,2,275.1938,4.183415,22.44412,NULL,'Negaton Screamer'),
(2087500,3,266.75012,-17.823483,22.449232,5.899212837219238281,'Negaton Screamer - Duplicated Waypoint, Delete Later'),
(2087500,4,275.1938,4.183415,22.44412,NULL,'Negaton Screamer - Duplicated Waypoint, Delete Later');

DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = -(@CGUID+40));
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(-(@CGUID+40), 0, 0, 0, 25, 0, 100, 512, 0, 0, 0, 0, 0, 31, 1, 6, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Negaton Screamer - On Reset - Set Phase Random Between 1-6'),
(-(@CGUID+40), 0, 1, 0, 4, 1, 100, 1, 0, 0, 0, 0, 0, 11, 34331, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Negaton Screamer - On Aggro - Cast \'Damage Reduction: Arcane\' (Phase 1) (No Repeat)'),
(-(@CGUID+40), 0, 2, 0, 0, 1, 100, 2, 3000, 8000, 10000, 10000, 0, 11, 36738, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Negaton Screamer - In Combat - Cast \'Arcane Volley\' (Phase 1) (Normal Dungeon)'),
(-(@CGUID+40), 0, 3, 0, 0, 1, 100, 4, 3000, 8000, 10000, 10000, 0, 11, 38835, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Negaton Screamer - In Combat - Cast \'Arcane Volley\' (Phase 1) (Heroic Dungeon)'),
(-(@CGUID+40), 0, 4, 0, 4, 2, 100, 1, 0, 0, 0, 0, 0, 11, 34333, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Negaton Screamer - On Aggro - Cast \'Damage Reduction: Fire\' (Phase 2) (No Repeat)'),
(-(@CGUID+40), 0, 5, 0, 0, 2, 100, 2, 3000, 8000, 10000, 10000, 0, 11, 36742, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Negaton Screamer - In Combat - Cast \'Fireball Volley\' (Phase 2) (Normal Dungeon)'),
(-(@CGUID+40), 0, 6, 0, 0, 2, 100, 4, 3000, 8000, 10000, 10000, 0, 11, 38836, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Negaton Screamer - In Combat - Cast \'Fireball Volley\' (Phase 2) (Heroic Dungeon)'),
(-(@CGUID+40), 0, 7, 0, 4, 4, 100, 1, 0, 0, 0, 0, 0, 11, 34334, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Negaton Screamer - On Aggro - Cast \'Damage Reduction: Frost\' (Phase 4) (No Repeat)'),
(-(@CGUID+40), 0, 8, 0, 0, 4, 100, 2, 3000, 8000, 10000, 10000, 0, 11, 36741, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Negaton Screamer - In Combat - Cast \'Frostbolt Volley\' (Phase 4) (Normal Dungeon)'),
(-(@CGUID+40), 0, 9, 0, 0, 4, 100, 4, 3000, 8000, 10000, 10000, 0, 11, 38837, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Negaton Screamer - In Combat - Cast \'Frostbolt Volley\' (Phase 4) (Heroic Dungeon)'),
(-(@CGUID+40), 0, 10, 0, 4, 8, 100, 1, 0, 0, 0, 0, 0, 11, 34336, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Negaton Screamer - On Aggro - Cast \'Damage Reduction: Holy\' (Phase 8) (No Repeat)'),
(-(@CGUID+40), 0, 11, 0, 0, 8, 100, 2, 3000, 8000, 10000, 10000, 0, 11, 36743, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Negaton Screamer - In Combat - Cast \'Holy Bolt Volley\' (Phase 8) (Normal Dungeon)'),
(-(@CGUID+40), 0, 12, 0, 0, 8, 100, 4, 3000, 8000, 10000, 10000, 0, 11, 38838, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Negaton Screamer - In Combat - Cast \'Holy Bolt Volley\' (Phase 8) (Heroic Dungeon)'),
(-(@CGUID+40), 0, 13, 0, 4, 16, 100, 1, 0, 0, 0, 0, 0, 11, 34335, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Negaton Screamer - On Aggro - Cast \'Damage Reduction: Nature\' (Phase 16) (No Repeat)'),
(-(@CGUID+40), 0, 14, 0, 0, 16, 100, 2, 3000, 8000, 10000, 10000, 0, 11, 36740, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Negaton Screamer - In Combat - Cast \'Lightning Bolt Volley\' (Phase 16) (Normal Dungeon)'),
(-(@CGUID+40), 0, 15, 0, 0, 16, 100, 4, 3000, 8000, 10000, 10000, 0, 11, 38839, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Negaton Screamer - In Combat - Cast \'Lightning Bolt Volley\' (Phase 16) (Heroic Dungeon)'),
(-(@CGUID+40), 0, 16, 0, 4, 32, 100, 1, 0, 0, 0, 0, 0, 11, 34338, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Negaton Screamer - On Aggro - Cast \'Damage Reduction: Shadow\' (Phase 32) (No Repeat)'),
(-(@CGUID+40), 0, 17, 0, 0, 32, 100, 2, 3000, 8000, 10000, 10000, 0, 11, 36736, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Negaton Screamer - In Combat - Cast \'Shadow Bolt Volley\' (Phase 32) (Normal Dungeon)'),
(-(@CGUID+40), 0, 18, 0, 0, 32, 100, 4, 3000, 8000, 10000, 10000, 0, 11, 38840, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Negaton Screamer - In Combat - Cast \'Shadow Bolt Volley\' (Phase 32) (Heroic Dungeon)'),
(-(@CGUID+40), 0, 19, 0, 0, 0, 100, 0, 20000, 20000, 30000, 30000, 0, 11, 13704, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Negaton Screamer - In Combat - Cast \'Psychic Scream\''),
(-(@CGUID+40), 0, 1001, 0, 11, 0, 100, 0, 0, 0, 0, 0, 0, 53, 0, 2087500, 1, 0, 0, 2, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Negaton Screamer - On Respawn - Start Waypoint'),
(-(@CGUID+40), 0, 1002, 0, 40, 0, 100, 0, 0, 2087500, 0, 0, 0, 80, 2087500, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Negaton Screamer - On Waypoint Any Reached - Run Script');

DELETE FROM `smart_scripts` WHERE (`source_type` = 9 AND `entryorguid` = 2087500);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(2087500, 9, 0, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 54, 25000, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Negaton Screamer - Actionlist - Pause Waypoint'),
(2087500, 9, 2, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 89, 5, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Negaton Screamer - Actionlist - Start Random Movement');

-- Pathing for Negaton Warp-Master Entry: 20873
DELETE FROM `waypoints` WHERE `point_comment` LIKE 'Negaton Warp-Master%' AND `entry` IN (2087300, 2087301);
INSERT INTO `waypoints` (`entry`, `pointid`, `position_x`, `position_y`, `position_z`, `orientation`, `point_comment`) VALUES
(2087300,1,275.32532,37.143127,22.441074,5.637413501739501953,'Negaton Warp-Master'),
(2087300,2,265.88467,55.07243,22.441204,NULL,'Negaton Warp-Master'),
(2087300,3,275.32532,37.143127,22.441074,5.637413501739501953,'Negaton Warp-Master - Duplicated Waypoint, Delete Later'),
(2087300,4,265.88467,55.07243,22.441204,NULL,'Negaton Warp-Master - Duplicated Waypoint, Delete Later'),

(2087301,1,291.2633,6.761013,22.441162,NULL,'Negaton Warp-Master'),
(2087301,2,308.48526,-14.237305,22.443472,NULL,'Negaton Warp-Master'),
(2087301,3,291.2633,6.761013,22.441162,NULL,'Negaton Warp-Master - Duplicated Waypoint, Delete Later'),
(2087301,4,308.48526,-14.237305,22.443472,NULL,'Negaton Warp-Master - Duplicated Waypoint, Delete Later');

DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` IN (-(@CGUID+37),-(@CGUID+38)));
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(-(@CGUID+37), 0, 0, 0, 0, 0, 100, 0, 2000, 8000, 6000, 8000, 0, 11, 36813, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Negaton Warp-Master - In Combat - Cast \'Summon Negaton Field\''),
(-(@CGUID+37), 0, 1001, 0, 11, 0, 100, 0, 0, 0, 0, 0, 0, 53, 0, 2087300, 1, 0, 0, 2, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Negaton Screamer - On Respawn - Start Waypoint'),
(-(@CGUID+37), 0, 1002, 0, 40, 0, 100, 0, 0, 2087300, 0, 0, 0, 80, 2087300, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Negaton Warp-Master - On Waypoint Any Reached - Run Script'),

(-(@CGUID+38), 0, 0, 0, 0, 0, 100, 0, 2000, 8000, 6000, 8000, 0, 11, 36813, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Negaton Warp-Master - In Combat - Cast \'Summon Negaton Field\''),
(-(@CGUID+38), 0, 1001, 0, 11, 0, 100, 0, 0, 0, 0, 0, 0, 53, 0, 2087301, 1, 0, 0, 2, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Negaton Screamer - On Respawn - Start Waypoint'),
(-(@CGUID+38), 0, 1002, 0, 40, 0, 100, 0, 0, 2087301, 0, 0, 0, 80, 2087300, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Negaton Warp-Master - On Waypoint Any Reached - Run Script');

DELETE FROM `smart_scripts` WHERE (`source_type` = 9 AND `entryorguid` = 2087300);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(2087300, 9, 0, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 54, 25000, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Negaton Warp-Master - Actionlist - Pause Waypoint'),
(2087300, 9, 2, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 89, 5, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Negaton Warp-Master - Actionlist - Start Random Movement');

-- Pathing for Unbound Devastator Entry: 20881 @CGUID+45
DELETE FROM `waypoints` WHERE `point_comment` LIKE 'Unbound Devastator%' AND `entry`=2088100;
INSERT INTO `waypoints` (`entry`, `pointid`, `position_x`, `position_y`, `position_z`, `orientation`, `point_comment`) VALUES
(2088100,1,199.71545,135.69438,22.45939,NULL,'Unbound Devastator'),
(2088100,2,188.94356,135.94778,22.441149,NULL,'Unbound Devastator'),
(2088100,3,178.95024,136.18616,22.441147,NULL,'Unbound Devastator - Random Movement'), -- 20-30s of random movement (5y)
(2088100,4,193.13338,134.66946,22.571707,NULL,'Unbound Devastator'),
(2088100,5,199.88423,134.85597,22.37441,NULL,'Unbound Devastator'),
(2088100,6,200.01999,143.80635,22.404247,NULL,'Unbound Devastator - Random Movement'); -- 20-30s of random movement (5y)

DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = -(@CGUID+45));
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(-(@CGUID+45), 0, 0, 0, 0, 0, 100, 2, 4000, 5000, 15000, 15000, 0, 11, 36887, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Unbound Devastator - In Combat - Cast \'Deafening Roar\' (Normal Dungeon)'),
(-(@CGUID+45), 0, 1, 0, 0, 0, 100, 4, 4000, 5000, 15000, 15000, 0, 11, 38850, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Unbound Devastator - In Combat - Cast \'Deafening Roar\' (Heroic Dungeon)'),
(-(@CGUID+45), 0, 2, 0, 0, 0, 100, 2, 9000, 10000, 15000, 15000, 0, 11, 36891, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Unbound Devastator - In Combat - Cast \'Devastate\' (Normal Dungeon)'),
(-(@CGUID+45), 0, 3, 0, 0, 0, 100, 4, 9000, 10000, 15000, 15000, 0, 11, 38849, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Unbound Devastator - In Combat - Cast \'Devastate\' (Heroic Dungeon)'),
(-(@CGUID+45), 0, 1001, 0, 11, 0, 100, 0, 0, 0, 0, 0, 0, 53, 0, 2088100, 1, 0, 0, 2, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Unbound Devastator - On Respawn - Start Waypoint'),
(-(@CGUID+45), 0, 1002, 0, 40, 0, 100, 0, 3, 2088100, 0, 0, 0, 80, 2088100, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Unbound Devastator - On Waypoint 3 Reached - Run Script'),
(-(@CGUID+45), 0, 1003, 0, 40, 0, 100, 0, 6, 2088100, 0, 0, 0, 80, 2088100, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Unbound Devastator - On Waypoint 6 Reached - Run Script');

DELETE FROM `smart_scripts` WHERE (`source_type` = 9 AND `entryorguid` = 2088100);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(2088100, 9, 0, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 54, 25000, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Unbound Devastator - Actionlist - Pause Waypoint'),
(2088100, 9, 2, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 89, 5, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Unbound Devastator - Actionlist - Start Random Movement');

-- Pathing for Spiteful Temptress Entry: 20883 @CGUID+49
DELETE FROM `waypoints` WHERE `point_comment` LIKE 'Spiteful Temptress%' AND `entry`=2088300;
INSERT INTO `waypoints` (`entry`, `pointid`, `position_x`, `position_y`, `position_z`, `orientation`, `point_comment`) VALUES
(2088300,1,189.48445,157.87857,22.44115,NULL,'Spiteful Temptress'),
(2088300,2,180.3669,158.23933,22.441147,NULL,'Spiteful Temptress'),
(2088300,3,180.26875,151.43074,22.441147,NULL,'Spiteful Temptress - Random Movement'), -- 20-40s of random movement (5y)
(2088300,4,179.83174,157.97197,22.441147,NULL,'Spiteful Temptress'),
(2088300,5,189.29553,157.5333,22.44115,NULL,'Spiteful Temptress'),
(2088300,6,198.717,156.83224,22.364504,NULL,'Spiteful Temptress - Random Movement'); -- 20-40s of random movement (5y)

DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = -(@CGUID+49));
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(-(@CGUID+49), 0, 0, 0, 0, 0, 100, 0, 4000, 10000, 20000, 20000, 0, 11, 36886, 0, 0, 0, 0, 0, 6, 50, 0, 0, 0, 0, 0, 0, 0, 'Spiteful Temptress - In Combat - Cast \'Spiteful Fury\''),
(-(@CGUID+49), 0, 1, 0, 0, 0, 100, 0, 14000, 15000, 25000, 25000, 0, 11, 36866, 0, 0, 0, 0, 0, 6, 50, 0, 0, 0, 0, 0, 0, 0, 'Spiteful Temptress - In Combat - Cast \'Domination\''),
(-(@CGUID+49), 0, 2, 0, 0, 0, 100, 2, 1000, 2000, 4000, 4000, 0, 11, 36868, 64, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Spiteful Temptress - In Combat - Cast \'Shadow Bolt\' (Normal Dungeon)'),
(-(@CGUID+49), 0, 3, 0, 0, 0, 100, 4, 1000, 2000, 4000, 4000, 0, 11, 38892, 64, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Spiteful Temptress - In Combat - Cast \'Shadow Bolt\' (Heroic Dungeon)'),
(-(@CGUID+49), 0, 1001, 0, 11, 0, 100, 0, 0, 0, 0, 0, 0, 53, 0, 2088300, 1, 0, 0, 2, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Spiteful Temptress - On Respawn - Start Waypoint'),
(-(@CGUID+49), 0, 1002, 0, 40, 0, 100, 0, 3, 2088300, 0, 0, 0, 80, 2088300, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Spiteful Temptress - On Waypoint 3 Reached - Run Script'),
(-(@CGUID+49), 0, 1003, 0, 40, 0, 100, 0, 6, 2088300, 0, 0, 0, 80, 2088300, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Spiteful Temptress - On Waypoint 6 Reached - Run Script');

DELETE FROM `smart_scripts` WHERE (`source_type` = 9 AND `entryorguid` = 2088300);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(2088300, 9, 0, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 54, 30000, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Spiteful Temptress - Actionlist - Pause Waypoint'),
(2088300, 9, 2, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 89, 5, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Spiteful Temptress - Actionlist - Start Random Movement');

DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` IN (-(@CGUID+10), -(@CGUID+22)));
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(-(@CGUID+10), 0, 0, 0, 0, 0, 100, 0, 2000, 8000, 7000, 7000, 0, 11, 36612, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Protean Horror - In Combat - Cast \'Toothy Bite\''),
(-(@CGUID+10), 0, 1, 0, 8, 0, 50, 512, 36327, 0, 0, 0, 0, 51, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Protean Horror - On Spellhit \'Shoot Arcane Explosion Arrow\' - Kill Target'),
(-(@CGUID+10), 0, 1001, 0, 25, 0, 100, 0, 0, 0, 0, 0, 0, 59, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Protean Horror - On Reset - Set Run On'),

(-(@CGUID+22), 0, 0, 0, 0, 0, 100, 0, 2000, 8000, 7000, 7000, 0, 11, 36612, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Protean Horror - In Combat - Cast \'Toothy Bite\''),
(-(@CGUID+22), 0, 1, 0, 8, 0, 50, 512, 36327, 0, 0, 0, 0, 51, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Protean Horror - On Spellhit \'Shoot Arcane Explosion Arrow\' - Kill Target'),
(-(@CGUID+22), 0, 1001, 0, 25, 0, 100, 0, 0, 0, 0, 0, 0, 59, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Protean Horror - On Reset - Set Run On');

-- Static Formations
DELETE FROM `creature_formations` WHERE `leaderGUID` IN (79392,79396,79400,@CGUID+01,@CGUID+02,@CGUID+52,@CGUID+62,@CGUID+63) AND `memberGUID` IN (79392,79393,79396,79397,79400,79399,79395,@CGUID+01,@CGUID+16,@CGUID+20,@CGUID+02,@CGUID+09,@CGUID+18,@CGUID+52,@CGUID+56,@CGUID+54,@CGUID+95,@CGUID+62,@CGUID+64,@CGUID+63,@CGUID+65);
INSERT INTO `creature_formations` (`leaderGUID`, `memberGUID`, `dist`, `angle`, `groupAI`) VALUES
(79392, 79392, 0, 0, 3),
(79392, 79393, 0, 0, 3),
(79396, 79396, 0, 0, 3),
(79396, 79397, 0, 0, 3),
(79400, 79400, 0, 0, 3),
(79400, 79399, 0, 0, 3),
(79400, 79395, 0, 0, 3),
(@CGUID+01, @CGUID+01, 0, 0, 3),
(@CGUID+01, @CGUID+16, 0, 0, 3),
(@CGUID+01, @CGUID+20, 0, 0, 3),
(@CGUID+02, @CGUID+02, 0, 0, 3),
(@CGUID+02, @CGUID+09, 0, 0, 3),
(@CGUID+02, @CGUID+18, 0, 0, 3),
(@CGUID+52, @CGUID+52, 0, 0, 3),
(@CGUID+52, @CGUID+56, 0, 0, 3),
(@CGUID+52, @CGUID+54, 0, 0, 3),
(@CGUID+52, @CGUID+95, 0, 0, 3),
(@CGUID+62, @CGUID+62, 0, 0, 3),
(@CGUID+62, @CGUID+64, 0, 0, 3),
(@CGUID+63, @CGUID+63, 0, 0, 3),
(@CGUID+63, @CGUID+65, 0, 0, 3);
