
-- Death Knight Initiates (Remove Wrong Guids)
DELETE FROM `creature` WHERE (`id1` = 28406) AND (`guid` IN (129516, 129517, 129518, 129544, 129545, 129555));
DELETE FROM `creature_addon` WHERE (`guid` IN (129516, 129517, 129518, 129544, 129545, 129555));

-- Remove Scourge Gryphons
DELETE FROM `creature` WHERE `id1` = 28906;

-- Remove Scarlet Ghouls
DELETE FROM `creature` WHERE `id1` = 28897;

-- Gluttonous Geists (Remove Wrong Guids)
DELETE FROM `creature` WHERE (`id1` = 28905) AND (`guid` IN (130312));

-- Scourge Gryphons (remove wrong smartai)
UPDATE `creature_template` SET `AIName` = '' WHERE `entry` = 28906;
DELETE FROM `smart_scripts` WHERE (`entryorguid` = 28906) AND (`source_type` = 0);

-- Gothik the Harvester (Remove Wrong SmartAI, Actionlist and Addon)
UPDATE `creature_template` SET `AIName` = '' WHERE `entry` = 28890;
DELETE FROM `smart_scripts` WHERE (`entryorguid` = 28890) AND (`source_type` = 0);
DELETE FROM `smart_scripts` WHERE (`entryorguid` IN (2889000, 2889001, 2889002, 2889003)) AND (`source_type` = 9);
UPDATE `creature_addon` SET `path_id` = 13012100 WHERE (`guid` IN (130121));

-- Waypoints
DELETE FROM `waypoint_data` WHERE `id` IN (13011800, 13011900, 13012000, 13012100, 13022500, 13022600, 13027500);
INSERT INTO `waypoint_data` (`id`, `point`, `position_x`, `position_y`, `position_z`, `orientation`, `delay`, `move_type`, `action`, `action_chance`, `wpguid`) VALUES
("13011800", 1, 2192.1294, -5926.655, 101.12373, NULL, 0, 0, 0, 100, 0),
("13011800", 2, 2163.8767, -5928.8013, 99.28386, NULL, 0, 0, 0, 100, 0),
("13011800", 3, 2137.0066, -5913.505, 100.69998, NULL, 0, 0, 0, 100, 0),
("13011800", 4, 2128.6396, -5891.006, 102.839355, NULL, 0, 0, 0, 100, 0),
("13011800", 5, 2121.2722, -5864.696, 102.14012, NULL, 0, 0, 0, 100, 0),
("13011800", 6, 2143.547, -5855.4814, 101.34996, NULL, 0, 0, 0, 100, 0),
("13011800", 7, 2161.3018, -5863.1533, 101.344574, NULL, 0, 0, 0, 100, 0),
("13011800", 8, 2180.6997, -5890.154, 100.975784, NULL, 0, 0, 0, 100, 0),
("13011800", 9, 2201.1484, -5914.511, 101.01622, NULL, 0, 0, 0, 100, 0),
("13011900", 1, 2301.3235, -5846.832, 100.93423, NULL, 0, 0, 0, 100, 0),
("13011900", 2, 2346.4392, -5857.874, 101.7633, NULL, 0, 0, 0, 100, 0),
("13011900", 3, 2387.449, -5852.9507, 106.41135, NULL, 0, 0, 0, 100, 0),
("13011900", 4, 2374.95, -5877.5527, 104.83713, NULL, 0, 0, 0, 100, 0),
("13011900", 5, 2341.982, -5880.2476, 103.6744, NULL, 0, 0, 0, 100, 0),
("13011900", 6, 2299.1343, -5867.592, 100.96091, NULL, 0, 0, 0, 100, 0),
("13012000", 1, 2121.3906, -5834.899, 101.629395, NULL, 0, 0, 0, 100, 0),
("13012000", 2, 2155.612, -5825.2485, 101.583824, NULL, 0, 0, 0, 100, 0),
("13012000", 3, 2168.8728, -5791.4727, 101.15188, NULL, 0, 0, 0, 100, 0),
("13012000", 4, 2201.668, -5760.944, 101.81218, NULL, 0, 0, 0, 100, 0),
("13012000", 5, 2190.6316, -5745.712, 102.219986, NULL, 0, 0, 0, 100, 0),
("13012000", 6, 2155.179, -5760.8345, 100.59677, NULL, 0, 0, 0, 100, 0),
("13012000", 7, 2122.3743, -5761.1772, 98.24538, NULL, 0, 0, 0, 100, 0),
("13012000", 8, 2101.5413, -5781.742, 99.2695, NULL, 0, 0, 0, 100, 0),
("13012000", 9, 2092.2913, -5813.873, 102.13019, NULL, 0, 0, 0, 100, 0),
("13012100", 1, 2199.8826, -5906.583, 100.88099, NULL, 0, 0, 0, 100, 0),
("13012100", 2, 2179.8838, -5893.7793, 100.85527, NULL, 0, 0, 0, 100, 0),
("13012100", 3, 2168.7725, -5866.6797, 101.337105, NULL, 0, 0, 0, 100, 0),
("13012100", 4, 2156.3, -5843.0005, 102.0316, NULL, 0, 0, 0, 100, 0),
("13012100", 5, 2139.4514, -5813.6753, 100.5411, NULL, 0, 0, 0, 100, 0),
("13012100", 6, 2125.513, -5785.7827, 98.66528, NULL, 0, 0, 0, 100, 0),
("13012100", 7, 2111.2576, -5763.4824, 98.55336, NULL, 0, 0, 0, 100, 0),
("13012100", 8, 2104.5195, -5735.549, 100.19841, NULL, 0, 0, 0, 100, 0),
("13012100", 9, 2126.6138, -5720.4775, 100.45774, NULL, 0, 0, 0, 100, 0),
("13012100", 10, 2159.1223, -5715.318, 102.24907, NULL, 0, 0, 0, 100, 0),
("13012100", 11, 2172.173, -5736.729, 101.68556, NULL, 0, 0, 0, 100, 0),
("13012100", 12, 2189.5996, -5760.0767, 101.66215, NULL, 0, 0, 0, 100, 0),
("13012100", 13, 2220.4363, -5784.1973, 101.70216, NULL, 0, 0, 0, 100, 0),
("13012100", 14, 2245.4631, -5803.29, 100.99215, NULL, 0, 0, 0, 100, 0),
("13012100", 15, 2261.9277, -5823.2, 100.949066, NULL, 0, 0, 0, 100, 0),
("13012100", 16, 2266.139, -5838.5776, 100.95463, NULL, 0, 0, 0, 100, 0),
("13012100", 17, 2259.798, -5867.397, 101.46121, NULL, 0, 0, 0, 100, 0),
("13012100", 18, 2238.359, -5890.6216, 101.02715, NULL, 0, 0, 0, 100, 0),
("13012100", 19, 2221.4436, -5905.7744, 101.2207, NULL, 0, 0, 0, 100, 0),
("13022500", 1, 2268.467, -6093.4062, 5.9264297, NULL, 0, 0, 0, 100, 0),
("13022500", 2, 2278.5603, -6116.154, 3.778914, NULL, 0, 0, 0, 100, 0),
("13022500", 3, 2264.345, -6146.061, 1.8427824, NULL, 0, 0, 0, 100, 0),
("13022500", 4, 2228.4512, -6150.0234, 2.0125759, NULL, 0, 0, 0, 100, 0),
("13022500", 5, 2219.048, -6135.287, 4.938764, NULL, 0, 0, 0, 100, 0),
("13022500", 6, 2223.313, -6104.604, 4.9672318, NULL, 0, 0, 0, 100, 0),
("13022500", 7, 2240.6729, -6085.976, 5.9909015, NULL, 0, 0, 0, 100, 0),
("13022600", 1, 2191.675, -6144.397, 5.0053396, NULL, 0, 0, 0, 100, 0),
("13022600", 2, 2192.3867, -6118.4536, 1.5058692, NULL, 0, 0, 0, 100, 0),
("13022600", 3, 2196.8098, -6080.9766, 2.6130714, NULL, 0, 0, 0, 100, 0),
("13022600", 4, 2198.929, -6066.7637, 5.22815, NULL, 0, 0, 0, 100, 0),
("13022600", 5, 2196.8098, -6080.9766, 2.6130714, NULL, 0, 0, 0, 100, 0),
("13022600", 6, 2192.3867, -6118.4536, 1.5058692, NULL, 0, 0, 0, 100, 0),
("13022600", 7, 2191.675, -6144.397, 5.0053396, NULL, 0, 0, 0, 100, 0),
("13022600", 8, 2192.4177, -6164.6465, 1.7256374, NULL, 0, 0, 0, 100, 0),
("13027500", 1, 2164.9028, -6122.6245, 1.2296143, NULL, 0, 0, 0, 100, 0),
("13027500", 2, 2159.8381, -6102.25, 5.9564657, NULL, 0, 0, 0, 100, 0),
("13027500", 3, 2136.0344, -6084.53, 5.6670914, NULL, 0, 0, 0, 100, 0),
("13027500", 4, 2102.7676, -6104.246, 5.5596447, NULL, 0, 0, 0, 100, 0),
("13027500", 5, 2103.9224, -6143.393, 4.1376762, NULL, 0, 0, 0, 100, 0),
("13027500", 6, 2148.8723, -6160.114, 1.278019, NULL, 0, 0, 0, 100, 0);

-- Update Spawn Position, MT and WD for Gluttonous Geists
UPDATE `creature` SET `position_x` = 2388.3235, `position_y` = -5898.371, `position_z` = 108.7139 , `orientation` = 0.833046, `MovementType` = 1, `wander_distance` = 10 WHERE (`guid` IN (130297)) AND (`id1` IN (28905));
UPDATE `creature` SET `position_x` = 2356.6306, `position_y` = -5879.3896, `position_z` = 104.7101, `orientation` = 1.95747, `MovementType` = 1, `wander_distance` = 10 WHERE (`guid` IN (130298)) AND (`id1` IN (28905));
UPDATE `creature` SET `position_x` = 2312.349, `position_y` = -5901.662, `position_z` = 93.44686, `orientation` = 3.51433, `MovementType` = 1, `wander_distance` = 10 WHERE (`guid` IN (130299)) AND (`id1` IN (28905));
UPDATE `creature` SET `position_x` = 2428.0354, `position_y` = -5865.3955, `position_z` = 105.913315, `orientation` = 0.92807, `MovementType` = 1, `wander_distance` = 10 WHERE (`guid` IN (130300)) AND (`id1` IN (28905));
UPDATE `creature` SET `position_x` = 2247.437, `position_y` = -5865.558, `position_z` = 100.95554, `orientation` = 1.57079, `MovementType` = 1, `wander_distance` = 10 WHERE (`guid` IN (130301)) AND (`id1` IN (28905));
UPDATE `creature` SET `position_x` = 2252.52, `position_y` = -5820.546, `position_z` = 101.00846, `orientation` = 1.57079, `MovementType` = 1, `wander_distance` = 10 WHERE (`guid` IN (130302)) AND (`id1` IN (28905));
UPDATE `creature` SET `position_x` = 2235.5793, `position_y` = -5752.613, `position_z` = 101.88058, `orientation` = 1.57079, `MovementType` = 1, `wander_distance` = 10 WHERE (`guid` IN (130303)) AND (`id1` IN (28905));
UPDATE `creature` SET `position_x` = 2214.799, `position_y` = -5777.5337, `position_z` = 101.7837, `orientation` = 1.6580, `MovementType` = 1, `wander_distance` = 10 WHERE (`guid` IN (130304)) AND (`id1` IN (28905));
UPDATE `creature` SET `position_x` = 2192.6064, `position_y` = -5737.7773, `position_z` = 102.33999, `orientation` = 1.34156, `MovementType` = 1, `wander_distance` = 10 WHERE (`guid` IN (130305)) AND (`id1` IN (28905));
UPDATE `creature` SET `position_x` = 2147.7168, `position_y` = -5722.7305, `position_z` = 101.01196, `orientation` = 1.57079, `MovementType` = 1, `wander_distance` = 10 WHERE (`guid` IN (130306)) AND (`id1` IN (28905));
UPDATE `creature` SET `position_x` = 2131.7708, `position_y` = -5680.339, `position_z` = 101.83525, `orientation` = 1.57079, `MovementType` = 1, `wander_distance` = 10 WHERE (`guid` IN (130307)) AND (`id1` IN (28905));
UPDATE `creature` SET `position_x` = 2092.2354, `position_y` = -5713.4717, `position_z` = 100.232216, `orientation` = 0.86879, `MovementType` = 1, `wander_distance` = 10 WHERE (`guid` IN (130308)) AND (`id1` IN (28905));
UPDATE `creature` SET `position_x` = 2085.712, `position_y` = -5754.1934, `position_z` = 99.33097, `orientation` = 1.57079, `MovementType` = 1, `wander_distance` = 10 WHERE (`guid` IN (130309)) AND (`id1` IN (28905));
UPDATE `creature` SET `position_x` = 2112.1594, `position_y` = -5754.3667, `position_z` = 98.92251, `orientation` = 4.29416, `MovementType` = 1, `wander_distance` = 10 WHERE (`guid` IN (130310)) AND (`id1` IN (28905));
UPDATE `creature` SET `position_x` = 2146.0344, `position_y` = -5768.425, `position_z` = 99.74828, `orientation` = 1.57079, `MovementType` = 1, `wander_distance` = 10 WHERE (`guid` IN (130311)) AND (`id1` IN (28905));
UPDATE `creature` SET `position_x` = 2282.6775, `position_y` = -6127.073, `position_z` = 3.128897, `orientation` = 1.570796, `MovementType` = 1, `wander_distance` = 10 WHERE (`guid` IN (130313)) AND (`id1` IN (28905));
UPDATE `creature` SET `position_x` = 2155.9587, `position_y` = -5775.278, `position_z` = 100.73741, `orientation` = 1.57079, `MovementType` = 1, `wander_distance` = 10 WHERE (`guid` IN (130314)) AND (`id1` IN (28905));
UPDATE `creature` SET `position_x` = 2138.0042, `position_y` = -5892.933, `position_z` = 101.96939, `orientation` = 4.05716, `MovementType` = 1, `wander_distance` = 10 WHERE (`guid` IN (130315)) AND (`id1` IN (28905));
UPDATE `creature` SET `position_x` = 2141.9036, `position_y` = -5887.86, `position_z` = 101.54953, `orientation` = 1.57079, `MovementType` = 1, `wander_distance` = 10 WHERE (`guid` IN (130316)) AND (`id1` IN (28905));
UPDATE `creature` SET `position_x` = 2169.8506, `position_y` = -5863.065, `position_z` = 101.369194, `orientation` = 1.57079, `MovementType` = 1, `wander_distance` = 10 WHERE (`guid` IN (130317)) AND (`id1` IN (28905));
UPDATE `creature` SET `position_x` = 2183.372, `position_y` = -5923.872, `position_z` = 101.57689, `orientation` = 4.8328, `MovementType` = 1, `wander_distance` = 10 WHERE (`guid` IN (130318)) AND (`id1` IN (28905));
UPDATE `creature` SET `position_x` = 2249.3577, `position_y` = -5915.88, `position_z` = 99.13981, `orientation` = 1.57079, `MovementType` = 1, `wander_distance` = 10 WHERE (`guid` IN (130319)) AND (`id1` IN (28905));
UPDATE `creature` SET `position_x` = 2249.8372, `position_y` = -6081.656, `position_z` = 6.1703725, `orientation` = 1.570796, `MovementType` = 1, `wander_distance` = 10 WHERE (`guid` IN (130320)) AND (`id1` IN (28905));
UPDATE `creature` SET `position_x` = 2217.7444, `position_y` = -6110.887, `position_z` = 4.716755, `orientation` = 1.570796, `MovementType` = 1, `wander_distance` = 10 WHERE (`guid` IN (130321)) AND (`id1` IN (28905));
UPDATE `creature` SET `position_x` = 2223.4993, `position_y` = -6090.174, `position_z` = 4.934598, `orientation` = 2.358956, `MovementType` = 1, `wander_distance` = 10 WHERE (`guid` IN (130322)) AND (`id1` IN (28905));
UPDATE `creature` SET `position_x` = 2245.426, `position_y` = -6154.503, `position_z` = 1.8226079, `orientation` = 0.860172, `MovementType` = 1, `wander_distance` = 10 WHERE (`guid` IN (130323)) AND (`id1` IN (28905));
UPDATE `creature` SET `position_x` = 2208.11, `position_y` = -6158.6616, `position_z` = 1.6163365, `orientation` = 1.570796, `MovementType` = 1, `wander_distance` = 10 WHERE (`guid` IN (130324)) AND (`id1` IN (28905));
UPDATE `creature` SET `position_x` = 2206.7603, `position_y` = -6125.985, `position_z` = 4.9951015, `orientation` = 1.570796, `MovementType` = 1, `wander_distance` = 10 WHERE (`guid` IN (130325)) AND (`id1` IN (28905));
UPDATE `creature` SET `position_x` = 2145.946, `position_y` = -6108.169, `position_z` = 4.5653887, `orientation` = 2.261537, `MovementType` = 1, `wander_distance` = 10 WHERE (`guid` IN (130326)) AND (`id1` IN (28905));
UPDATE `creature` SET `position_x` = 2160.8967, `position_y` = -6068.0996, `position_z` = 5.431866, `orientation` = 1.570796, `MovementType` = 1, `wander_distance` = 10 WHERE (`guid` IN (130327)) AND (`id1` IN (28905));
UPDATE `creature` SET `position_x` = 2136.2654, `position_y` = -6072.4595, `position_z` = 5.4788465, `orientation` = 1.570796, `MovementType` = 1, `wander_distance` = 10 WHERE (`guid` IN (130328)) AND (`id1` IN (28905));
UPDATE `creature` SET `position_x` = 2126.696, `position_y` = -6146.5674, `position_z` = 2.2910354, `orientation` = 5.106129, `MovementType` = 1, `wander_distance` = 10 WHERE (`guid` IN (130330)) AND (`id1` IN (28905));
UPDATE `creature` SET `position_x` = 2116.3901, `position_y` = -6183.808, `position_z` = 13.845215, `orientation` = 1.570796, `MovementType` = 1, `wander_distance` = 10 WHERE (`guid` IN (130331)) AND (`id1` IN (28905));

-- Update Spawn Position, MT and WD for Acherus Necromancers
UPDATE `creature` SET `position_x` = 2190.7517, `position_y` = -5913.1743, `position_z` = 101.022514, `orientation` = 1.20243, `wander_distance` = 0, `MovementType` = 2 WHERE (`guid` IN (130118)) AND (`id1` IN (28889));
UPDATE `creature` SET `position_x` = 2299.1343, `position_y` = -5867.592, `position_z` = 100.96091, `orientation` = 0.84453, `wander_distance` = 0, `MovementType` = 2 WHERE (`guid` IN (130119)) AND (`id1` IN (28889));
UPDATE `creature` SET `position_x` = 2092.2913, `position_y` = -5813.873, `position_z` = 102.13019, `orientation` = 5.17755, `wander_distance` = 0, `MovementType` = 2 WHERE (`guid` IN (130120)) AND (`id1` IN (28889));

-- Add new Acherus Necromancers
DELETE FROM `creature` WHERE (`guid` IN (130225, 130226, 130275)) AND (`id1` = 28889);
INSERT INTO `creature` (`guid`, `id1`, `id2`, `id3`, `map`, `zoneId`, `areaId`, `spawnMask`, `phaseMask`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `wander_distance`, `currentwaypoint`, `curhealth`, `curmana`, `MovementType`, `npcflag`, `unit_flags`, `dynamicflags`, `ScriptName`, `VerifiedBuild`, `CreateObject`, `Comment`) VALUES
(130225, 28889, 0, 0, 609, 0, 0, 1, 4, 0, 2240.6729, -6085.976, 5.9909015, 5.99090, 360, 0, 0, 8982, 3155, 2, 0, 0, 0, '', 0, 0, NULL),
(130226, 28889, 0, 0, 609, 0, 0, 1, 4, 0, 2192.4177, -6164.6465, 1.7256374, 1.58369, 360, 0, 0, 8982, 3155, 2, 0, 0, 0, '', 0, 0, NULL),
(130275, 28889, 0, 0, 609, 0, 0, 1, 4, 0, 2148.8723, -6160.114, 1.278019, 2.03137, 360, 0, 0, 8982, 3155, 2, 0, 0, 0, '', 0, 0, NULL);

-- Add creature addon for Acherus Necromancers
DELETE FROM `creature_addon` WHERE (`guid` IN (130118, 130119, 130120, 130225, 130226, 130275));
INSERT INTO `creature_addon` (`guid`, `path_id`, `mount`, `bytes1`, `bytes2`, `emote`, `visibilityDistanceType`, `auras`) VALUES
(130118, 13011800, 0, 0, 0, 0, 0, ''),
(130119, 13011900, 0, 0, 0, 0, 0, ''),
(130120, 13012000, 0, 0, 0, 0, 0, ''),
(130225, 13022500, 0, 0, 0, 0, 0, ''),
(130226, 13022600, 0, 0, 0, 0, 0, ''),
(130275, 13027500, 0, 0, 0, 0, 0, '');

-- Update Spawn and MT for Gothik the Harvester
UPDATE `creature` SET `position_x` = 2221.4436, `position_y` = -5905.7744, `position_z` = 101.2207, `orientation` = 3.2595, `wander_distance` = 0, `MovementType` = 2 WHERE (`guid` IN (130121)) AND (`id1` IN (28890));
