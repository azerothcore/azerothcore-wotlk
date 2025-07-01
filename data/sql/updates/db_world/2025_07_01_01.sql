-- DB update 2025_07_01_00 -> 2025_07_01_01
-- Death Knight Initiates (Remove Wrong Guids)
DELETE FROM `creature` WHERE (`id1` = 28406) AND (`guid` IN (129516, 129517, 129518, 129544, 129545, 129555));
DELETE FROM `creature_addon` WHERE (`guid` IN (129516, 129517, 129518, 129544, 129545, 129555));

-- Remove Scourge Gryphons
DELETE FROM `creature` WHERE `id1` = 28906;

-- Remove Scarlet Ghouls
DELETE FROM `creature` WHERE `id1` = 28897;

-- Gluttonous Geists (Remove Wrong Guid)
DELETE FROM `creature` WHERE (`id1` = 28905) AND (`guid` IN (130312));

-- Gothik the Harvester (Remove Wrong SmartAI and Actionlist)
UPDATE `creature_template` SET `AIName` = '' WHERE `entry` = 28890;
DELETE FROM `smart_scripts` WHERE (`entryorguid` = 28890) AND (`source_type` = 0);
DELETE FROM `smart_scripts` WHERE (`entryorguid` IN (2889000, 2889001, 2889002, 2889003)) AND (`source_type` = 9);

-- Sniffed Waypoints
DELETE FROM `waypoint_data` WHERE `id` IN (13011800, 13011900, 13012000, 13012100, 13022500, 13022600, 13027500, 2889700, 2889701, 2889702, 2889703, 2889704, 2890600, 2890601, 2890602, 2890603, 2890604);
INSERT INTO `waypoint_data` (`id`, `point`, `position_x`, `position_y`, `position_z`, `orientation`, `delay`, `move_type`, `action`, `action_chance`, `wpguid`) VALUES

-- Acherus Necromancers
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
("13027500", 6, 2148.8723, -6160.114, 1.278019, NULL, 0, 0, 0, 100, 0),

-- Gothik the Harvester
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

-- Scourge Gryphons (patrol)
("2890600", 1, 1841.5955, -5838.637, 132.42058, NULL, 0, 2, 0, 100, 0),
("2890600", 2, 1784.4916, -5822.41, 136.97614, NULL, 0, 2, 0, 100, 0),
("2890600", 3, 1778.6383, -5898.7744, 135.94832, NULL, 0, 2, 0, 100, 0),
("2890600", 4, 1799.5969, -5927.9746, 135.94832, NULL, 0, 2, 0, 100, 0),
("2890600", 5, 1840.5508, -5923.3677, 135.94832, NULL, 0, 2, 0, 100, 0),
("2890600", 6, 1851.1428, -5908.0063, 132.42058, NULL, 0, 2, 0, 100, 0),
("2890601", 1, 1768.2115, -5862.899, 144.99065, NULL, 0, 2, 0, 100, 0),
("2890601", 2, 1813.2302, -5876.425, 166.76842, NULL, 0, 2, 0, 100, 0),
("2890601", 3, 1764.9922, -5872.4487, 160.85176, NULL, 0, 2, 0, 100, 0),
("2890601", 4, 1743.6553, -5895.7915, 160.85176, NULL, 0, 2, 0, 100, 0),
("2890601", 5, 1774.8065, -5966.014, 160.85176, NULL, 0, 2, 0, 100, 0),
("2890601", 6, 1848.6844, -5976.056, 160.85176, NULL, 0, 2, 0, 100, 0),
("2890601", 7, 1880.036, -5950.2583, 144.99065, NULL, 0, 2, 0, 100, 0),
("2890601", 8, 1848.8954, -5893.6606, 118.93514, NULL, 0, 2, 0, 100, 0),
("2890601", 9, 1832.9224, -5836.408, 125.35181, NULL, 0, 2, 0, 100, 0),
("2890602", 1, 1776.9531, -5897.504, 138.92468, NULL, 0, 2, 0, 100, 0),
("2890602", 2, 1868.4694, -5846.4653, 138.92468, NULL, 0, 2, 0, 100, 0),
("2890602", 3, 1909.5326, -5854.746, 138.92468, NULL, 0, 2, 0, 100, 0),
("2890602", 4, 1895.7626, -5905.596, 138.92468, NULL, 0, 2, 0, 100, 0),
("2890602", 5, 1824.9314, -5931.985, 135.24397, NULL, 0, 2, 0, 100, 0),
("2890602", 6, 1784.5319, -5930.701, 135.43845, NULL, 0, 2, 0, 100, 0),
("2890603", 1, 1791.9382, -5823.7505, 134.85405, NULL, 0, 2, 0, 100, 0),
("2890603", 2, 1835.8387, -5818.3184, 118.6983, NULL, 0, 2, 0, 100, 0),
("2890603", 3, 1836.2428, -5921.221, 130.0594, NULL, 0, 2, 0, 100, 0),
("2890603", 4, 1797.7716, -5938.2046, 130.0594, NULL, 0, 2, 0, 100, 0),
("2890603", 5, 1774.739, -5878.426, 142.21509, NULL, 0, 2, 0, 100, 0),
("2890604", 1, 1841.5955, -5838.637, 132.42058, NULL, 0, 2, 0, 100, 0),
("2890604", 2, 1851.1428, -5908.0063, 132.42058, NULL, 0, 2, 0, 100, 0),
("2890604", 3, 1840.5508, -5923.3677, 135.94832, NULL, 0, 2, 0, 100, 0),
("2890604", 4, 1799.5969, -5927.9746, 135.94832, NULL, 0, 2, 0, 100, 0),
("2890604", 5, 1778.6383, -5898.7744, 135.94832, NULL, 0, 2, 0, 100, 0),
("2890604", 6, 1784.4916, -5822.41, 136.97614, NULL, 0, 2, 0, 100, 0);

-- Scarlet Ghouls waypoints (must be optimized).
DELETE FROM `waypoints` WHERE `entry` IN (2889700, 2889701, 2889702, 2889703, 2889704, 2889705, 2889706);
INSERT INTO `waypoints` (`entry`, `pointid`, `position_x`, `position_y`, `position_z`, `orientation`, `point_comment`) VALUES
("2889700", 1, 2195.3638, -6096.684, 1.9554013, NULL, 'Scarlet Ghoul'),
("2889700", 2, 2134.17, -6095.6626, 6.1250257, NULL, 'Scarlet Ghoul'),
("2889700", 3, 2093.4673, -6034.3447, 9.515682, NULL, 'Scarlet Ghoul'),
("2889700", 4, 2071.7117, -6016.3516, 12.850294, NULL, 'Scarlet Ghoul'),
("2889700", 5, 2055.4822, -6009.923, 18.771358, NULL, 'Scarlet Ghoul'),
("2889700", 6, 2039.4476, -6003.6445, 26.167065, NULL, 'Scarlet Ghoul'),
("2889700", 7, 2031.4705, -6000.2095, 32.67357, NULL, 'Scarlet Ghoul'),
("2889700", 8, 2027.7562, -6003.44, 37.135815, NULL, 'Scarlet Ghoul'),
("2889700", 9, 2011.0663, -5996.0796, 44.111214, NULL, 'Scarlet Ghoul'),
("2889700", 10, 1997.2365, -5990.1543, 54.388668, NULL, 'Scarlet Ghoul'),
("2889700", 11, 1982.8765, -5984.335, 66.13348, NULL, 'Scarlet Ghoul'),
("2889700", 12, 1969.1548, -5978.072, 77.45486, NULL, 'Scarlet Ghoul'),
("2889700", 13, 1956.6283, -5972.649, 88.85666, NULL, 'Scarlet Ghoul'),
("2889700", 14, 1941.6298, -5965.9805, 100.383446, NULL, 'Scarlet Ghoul'),
("2889700", 15, 1916.4559, -5952.4526, 101.24492, NULL, 'Scarlet Ghoul'),
("2889700", 16, 1882.0538, -5938.461, 103.13395, NULL, 'Scarlet Ghoul'),
("2889700", 17, 1830.4075, -5918.2676, 109.342636, NULL, 'Scarlet Ghoul'),
("2889701", 1, 2134.17, -6095.6626, 6.1250257, NULL, 'Scarlet Ghoul'),
("2889701", 2, 2093.4673, -6034.3447, 9.515682, NULL, 'Scarlet Ghoul'),
("2889701", 3, 2071.7117, -6016.3516, 12.850294, NULL, 'Scarlet Ghoul'),
("2889701", 4, 2055.4822, -6009.923, 18.771358, NULL, 'Scarlet Ghoul'),
("2889701", 5, 2039.4476, -6003.6445, 26.167065, NULL, 'Scarlet Ghoul'),
("2889701", 6, 2031.4705, -6000.2095, 32.67357, NULL, 'Scarlet Ghoul'),
("2889701", 7, 2027.7562, -6003.44, 37.135815, NULL, 'Scarlet Ghoul'),
("2889701", 8, 2011.0663, -5996.0796, 44.111214, NULL, 'Scarlet Ghoul'),
("2889701", 9, 1997.2365, -5990.1543, 54.388668, NULL, 'Scarlet Ghoul'),
("2889701", 10, 1982.8765, -5984.335, 66.13348, NULL, 'Scarlet Ghoul'),
("2889701", 11, 1969.1548, -5978.072, 77.45486, NULL, 'Scarlet Ghoul'),
("2889701", 12, 1956.6283, -5972.649, 88.85666, NULL, 'Scarlet Ghoul'),
("2889701", 13, 1941.6298, -5965.9805, 100.383446, NULL, 'Scarlet Ghoul'),
("2889701", 14, 1932.219, -5938.6284, 102.60785, NULL, 'Scarlet Ghoul'),
("2889701", 15, 1922.8248, -5911.5547, 101.57721, NULL, 'Scarlet Ghoul'),
("2889701", 16, 1904.4485, -5886.1274, 101.34244, NULL, 'Scarlet Ghoul'),
("2889701", 17, 1885.0721, -5868.9033, 102.31583, NULL, 'Scarlet Ghoul'),
("2889701", 18, 1865.0361, -5856.944, 102.96336, NULL, 'Scarlet Ghoul'),
("2889701", 19, 1845.4574, -5845.153, 102.1159, NULL, 'Scarlet Ghoul'),
("2889701", 20, 1827.5663, -5833.8936, 102.35004, NULL, 'Scarlet Ghoul'),
("2889701", 21, 1815.0728, -5826.0312, 104.49583, NULL, 'Scarlet Ghoul'),
("2889701", 22, 1803.1136, -5819.4585, 108.53935, NULL, 'Scarlet Ghoul'),
("2889702", 1, 2149.137, -5851.649, 101.358665, NULL, 'Scarlet Ghoul'),
("2889702", 2, 2053.9631, -5848.3438, 102.19084, NULL, 'Scarlet Ghoul'),
("2889702", 3, 1979.5673, -5854.149, 100.74358, NULL, 'Scarlet Ghoul'),
("2889702", 4, 1892.4893, -5856.9663, 101.901276, NULL, 'Scarlet Ghoul'),
("2889702", 5, 1876.3115, -5847.535, 102.11675, NULL, 'Scarlet Ghoul'),
("2889702", 6, 1854.0287, -5836.069, 101.78623, NULL, 'Scarlet Ghoul'),
("2889702", 7, 1835.2474, -5825.923, 100.77055, NULL, 'Scarlet Ghoul'),
("2889702", 8, 1819.5686, -5818.2095, 104.0615, NULL, 'Scarlet Ghoul'),
("2889702", 9, 1804.9038, -5811.438, 108.21074, NULL, 'Scarlet Ghoul'),
("2889703", 1, 2137.5742, -5793.847, 99.60594, NULL, 'Scarlet Ghoul'),
("2889703", 2, 2061.7412, -5811.5776, 103.39335, NULL, 'Scarlet Ghoul'),
("2889703", 3, 1981.0283, -5807.502, 101.002556, NULL, 'Scarlet Ghoul'),
("2889703", 4, 1912.7769, -5768.238, 103.644135, NULL, 'Scarlet Ghoul'),
("2889703", 5, 1904.1472, -5806.2334, 100.84862, NULL, 'Scarlet Ghoul'),
("2889703", 6, 1896.8984, -5836.7305, 101.094154, NULL, 'Scarlet Ghoul'),
("2889703", 7, 1892.4893, -5856.9663, 101.901276, NULL, 'Scarlet Ghoul'),
("2889703", 8, 1887.3644, -5884.821, 102.246506, NULL, 'Scarlet Ghoul'),
("2889703", 9, 1871.814, -5893.7964, 103.64108, NULL, 'Scarlet Ghoul'),
("2889703", 10, 1857.1747, -5902.0386, 104.01655, NULL, 'Scarlet Ghoul'),
("2889703", 11, 1830.3524, -5917.68, 109.23609, NULL, 'Scarlet Ghoul'),
("2889704", 1, 2135.5713, -5917.6436, 99.79425, NULL, 'Scarlet Ghoul'),
("2889704", 2, 2128.1082, -5918.4746, 102.57842, NULL, 'Scarlet Ghoul'),
("2889704", 3, 2119.8977, -5919.75, 104.845924, NULL, 'Scarlet Ghoul'),
("2889704", 4, 2106.674, -5921.8564, 105.8994, NULL, 'Scarlet Ghoul'),
("2889704", 5, 2098.4468, -5923.068, 106.78917, NULL, 'Scarlet Ghoul'),
("2889704", 6, 2085.5823, -5925.1177, 105.65261, NULL, 'Scarlet Ghoul'),
("2889704", 7, 2072.7903, -5927.2314, 106.47965, NULL, 'Scarlet Ghoul'),
("2889704", 8, 2058.0674, -5929.905, 105.883446, NULL, 'Scarlet Ghoul'),
("2889704", 9, 1993.3854, -5934.4653, 103.23653, NULL, 'Scarlet Ghoul'),
("2889704", 10, 1914.4014, -5934.455, 103.03427, NULL, 'Scarlet Ghoul'),
("2889704", 11, 1897.3982, -5930.1514, 103.310394, NULL, 'Scarlet Ghoul'),
("2889704", 12, 1879.5057, -5926.649, 104.29986, NULL, 'Scarlet Ghoul'),
("2889704", 13, 1859.5677, -5922.3164, 104.62177, NULL, 'Scarlet Ghoul'),
("2889704", 14, 1844.7861, -5919.962, 106.564575, NULL, 'Scarlet Ghoul'),
("2889704", 15, 1830.4172, -5918.243, 109.36247, NULL, 'Scarlet Ghoul'),
("2889705", 1, 2339.3877, -5872.3906, 102.40258, NULL, 'Scarlet Ghoul'),
("2889705", 2, 2277.8735, -5881.4644, 100.51856, NULL, 'Scarlet Ghoul'),
("2889705", 3, 2237.9512, -5908.162, 100.5426, NULL, 'Scarlet Ghoul'),
("2889705", 4, 2179.2607, -5916.5723, 100.833466, NULL, 'Scarlet Ghoul'),
("2889705", 5, 2135.5713, -5917.6436, 99.79425, NULL, 'Scarlet Ghoul'),
("2889705", 6, 2128.1082, -5918.4746, 102.57842, NULL, 'Scarlet Ghoul'),
("2889705", 7, 2119.8977, -5919.75, 104.845924, NULL, 'Scarlet Ghoul'),
("2889705", 8, 2106.674, -5921.8564, 105.8994, NULL, 'Scarlet Ghoul'),
("2889705", 9, 2098.4468, -5923.068, 106.78917, NULL, 'Scarlet Ghoul'),
("2889705", 10, 2085.5823, -5925.1177, 105.65261, NULL, 'Scarlet Ghoul'),
("2889705", 11, 2072.7903, -5927.2314, 106.47965, NULL, 'Scarlet Ghoul'),
("2889705", 12, 2058.0674, -5929.905, 105.883446, NULL, 'Scarlet Ghoul'),
("2889705", 13, 1993.3854, -5934.4653, 103.23653, NULL, 'Scarlet Ghoul'),
("2889705", 14, 1914.4014, -5934.455, 103.03427, NULL, 'Scarlet Ghoul'),
("2889705", 15, 1897.3982, -5930.1514, 103.310394, NULL, 'Scarlet Ghoul'),
("2889705", 16, 1879.5057, -5926.649, 104.29986, NULL, 'Scarlet Ghoul'),
("2889705", 17, 1859.5677, -5922.3164, 104.62177, NULL, 'Scarlet Ghoul'),
("2889705", 18, 1844.7861, -5919.962, 106.564575, NULL, 'Scarlet Ghoul'),
("2889705", 19, 1830.4172, -5918.243, 109.36247, NULL, 'Scarlet Ghoul'),
("2889706", 1, 2278.1655, -5838.218, 100.934555, NULL, 'Scarlet Ghoul'),
("2889706", 2, 2226.8245, -5841.505, 101.31162, NULL, 'Scarlet Ghoul'),
("2889706", 3, 2172.0278, -5844.5312, 101.348076, NULL, 'Scarlet Ghoul'),
("2889706", 4, 2149.137, -5851.649, 101.358665, NULL, 'Scarlet Ghoul'),
("2889706", 5, 2053.9631, -5848.3438, 102.19084, NULL, 'Scarlet Ghoul'),
("2889706", 6, 1979.5673, -5854.149, 100.74358, NULL, 'Scarlet Ghoul'),
("2889706", 7, 1892.4893, -5856.9663, 101.901276, NULL, 'Scarlet Ghoul'),
("2889706", 8, 1876.3115, -5847.535, 102.11675, NULL, 'Scarlet Ghoul'),
("2889706", 9, 1854.0287, -5836.069, 101.78623, NULL, 'Scarlet Ghoul'),
("2889706", 10, 1835.2474, -5825.923, 100.77055, NULL, 'Scarlet Ghoul'),
("2889706", 11, 1819.5686, -5818.2095, 104.0615, NULL, 'Scarlet Ghoul'),
("2889706", 12, 1804.9038, -5811.438, 108.21074, NULL, 'Scarlet Ghoul');

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
UPDATE `creature` SET `position_x` = 2190.7517, `position_y` = -5913.1743, `position_z` = 101.022514, `orientation` = 1.20243, `wander_distance` = 0, `MovementType` = 0 WHERE (`guid` IN (130118)) AND (`id1` IN (28889));
UPDATE `creature` SET `position_x` = 2299.1343, `position_y` = -5867.592, `position_z` = 100.96091, `orientation` = 0.84453, `wander_distance` = 0, `MovementType` = 0 WHERE (`guid` IN (130119)) AND (`id1` IN (28889));
UPDATE `creature` SET `position_x` = 2092.2913, `position_y` = -5813.873, `position_z` = 102.13019, `orientation` = 5.17755, `wander_distance` = 0, `MovementType` = 0 WHERE (`guid` IN (130120)) AND (`id1` IN (28889));

-- Add new Acherus Necromancers
DELETE FROM `creature` WHERE (`guid` IN (130225, 130226, 130275)) AND (`id1` = 28889);
INSERT INTO `creature` (`guid`, `id1`, `id2`, `id3`, `map`, `zoneId`, `areaId`, `spawnMask`, `phaseMask`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `wander_distance`, `currentwaypoint`, `curhealth`, `curmana`, `MovementType`, `npcflag`, `unit_flags`, `dynamicflags`, `ScriptName`, `VerifiedBuild`, `CreateObject`, `Comment`) VALUES
(130225, 28889, 0, 0, 609, 0, 0, 1, 4, 0, 2240.6729, -6085.976, 5.9909015, 5.99090, 360, 0, 0, 8982, 3155, 0, 0, 0, 0, '', 0, 0, NULL),
(130226, 28889, 0, 0, 609, 0, 0, 1, 4, 0, 2192.4177, -6164.6465, 1.7256374, 1.58369, 360, 0, 0, 8982, 3155, 0, 0, 0, 0, '', 0, 0, NULL),
(130275, 28889, 0, 0, 609, 0, 0, 1, 4, 0, 2148.8723, -6160.114, 1.278019, 2.03137, 360, 0, 0, 8982, 3155, 0, 0, 0, 0, '', 0, 0, NULL);

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
UPDATE `creature` SET `position_x` = 2221.4436, `position_y` = -5905.7744, `position_z` = 101.2207, `orientation` = 3.2595, `wander_distance` = 0, `MovementType` = 0 WHERE (`guid` IN (130121)) AND (`id1` IN (28890));

-- Update Waypoint ID for Gothik the Harvester
UPDATE `creature_addon` SET `path_id` = 13012100 WHERE (`guid` IN (130121));

-- Update text_table for Gothik the Harvester
DELETE FROM `creature_text` WHERE(`CreatureID` = 28890);
INSERT INTO `creature_text` (`CreatureID`, `GroupID`, `ID`, `Text`, `Type`, `Language`, `Probability`, `Emote`, `Duration`, `Sound`, `BroadcastTextId`, `TextRange`, `comment`) VALUES
(28890, 0, 0, 'You will fly again, beast...', 12, 0, 100, 5, 0, 0, 29043, 0, 'Gothik the Harvester'),
(28890, 0, 1, 'Death comes on bony wings...', 12, 0, 100, 5, 0, 0, 29044, 0, 'Gothik the Harvester'),
(28890, 0, 2, 'Rise, minion. Rise and fly for the Scourge!', 12, 0, 100, 5, 0, 0, 29045, 0, 'Gothik the Harvester'),
(28890, 1, 0, 'Hrm? Lets see what we get out of this one.', 12, 0, 100, 5, 0, 0, 29032, 0, 'Gothik the Harvester'),
(28890, 1, 1, 'Blasted geists! They ve practically devoured this one whole...', 12, 0, 100, 5, 0, 0, 29033, 0, 'Gothik the Harvester'),
(28890, 1, 2, 'Contemptible wretches! Stay away from the bodies!', 12, 0, 100, 5, 0, 0, 29034, 0, 'Gothik the Harvester'),
(28890, 1, 3, 'This one is especially ugly. Perfect for a ghoul...', 12, 0, 100, 5, 0, 0, 29035, 0, 'Gothik the Harvester'),
(28890, 1, 4, 'I think its spine is broken. Ghoul it is!', 12, 0, 100, 5, 0, 0, 29036, 0, 'Gothik the Harvester'),
(28890, 1, 5, 'Is Gothik the Harvester going to have to choke a geist?', 12, 0, 100, 5, 0, 0, 29037, 0, 'Gothik the Harvester'),
(28890, 1, 6, 'Surprise, surprise! Another ghoul!', 12, 0, 100, 5, 0, 0, 29038, 0, 'Gothik the Harvester'),
(28890, 2, 0, 'Death is the only escape!', 12, 0, 100, 5, 0, 0, 29039, 0, 'Gothik the Harvester');

-- Create Scarlet Ghouls template_movement.
DELETE FROM `creature_template_movement` WHERE (`CreatureId` = 28897);
INSERT INTO `creature_template_movement` (`CreatureId`, `Ground`, `Swim`, `Flight`, `Rooted`, `Chase`, `Random`, `InteractionPauseTimer`) VALUES
(28897, 1, 0, 0, 0, 0, 2, 0);

-- Update Scarlet Ghouls SmartAI/ActionList
UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 28897;

DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = 28897);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(28897, 0, 0, 0, 54, 0, 100, 0, 0, 0, 0, 0, 0, 0, 80, 2889700, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Scarlet Ghoul - On Just Summoned - Run Script'),
(28897, 0, 1, 0, 54, 0, 100, 0, 0, 0, 0, 0, 0, 0, 37, 300000, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Scarlet Ghoul - On Just Summoned - Kill Self'),
(28897, 0, 2, 0, 58, 0, 100, 0, 0, 0, 0, 0, 0, 0, 89, 30, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Scarlet Ghoul - On Path 0 Finished - Start Random Movement');

DELETE FROM `smart_scripts` WHERE (`source_type` = 9 AND `entryorguid` = 2889700);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(2889700, 9, 0, 0, 0, 0, 100, 0, 2000, 2000, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Scarlet Ghoul - Actionlist - Say Line 0'),
(2889700, 9, 1, 0, 0, 0, 100, 0, 3000, 3000, 0, 0, 0, 0, 113, 2889700, 2889706, 1, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Scarlet Ghoul - Actionlist - Start Closest Waypoint 2889700-2889706');

-- Update Scourge Gryphons SmartAI/ActionList
UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 28906;

DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = 28906);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(28906, 0, 0, 0, 54, 0, 100, 0, 0, 0, 0, 0, 0, 0, 87, 2890600, 2890601, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Scourge Gryphon - On Just Summoned - Run Random Script'),
(28906, 0, 1, 0, 54, 0, 100, 0, 0, 0, 0, 0, 0, 0, 37, 300000, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Scourge Gryphon - On Just Summoned - Kill Self'),
(28906, 0, 2, 0, 34, 0, 100, 0, 8, 1, 0, 0, 0, 0, 233, 2890600, 2890604, 1, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Scourge Gryphon - On Reached Point 1 - Start Random Path 2890600-2890604');

DELETE FROM `smart_scripts` WHERE (`source_type` = 9 AND `entryorguid` = 2890600);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(2890600, 9, 0, 0, 0, 0, 100, 0, 3000, 3000, 0, 0, 0, 0, 69, 1, 0, 0, 0, 0, 0, 8, 0, 0, 0, 0, 1805.06, -5810.82, 128.38, 0, 'Scourge Gryphon - Actionlist - Move To Position');

DELETE FROM `smart_scripts` WHERE (`source_type` = 9 AND `entryorguid` = 2890601);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(2890601, 9, 0, 0, 0, 0, 100, 0, 3000, 3000, 0, 0, 0, 0, 69, 1, 0, 0, 0, 0, 0, 8, 0, 0, 0, 0, 1831.77, -5913.56, 129.329, 0, 'Scourge Gryphon - Actionlist - Move To Position');

-- Set Despawn on Spellhit
UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE (`entry` IN (28896, 28898, 28892, 28891, 28886, 28893));

DELETE FROM `smart_scripts` WHERE (`source_type` = 0) AND (`entryorguid` IN (28896, 28898, 28892, 28891, 28886, 28893));
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(28896, 0, 0, 0, 8, 0, 100, 512, 52683, 0, 0, 0, 0, 0, 41, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Scarlet Infantryman - On Spellhit \'Scarlet Ghoul\' - Despawn Instant'),
(28898, 0, 0, 0, 8, 0, 100, 512, 52683, 0, 0, 0, 0, 0, 41, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Scarlet Captain - On Spellhit \'Scarlet Ghoul\' - Despawn Instant'),
(28892, 0, 0, 0, 8, 0, 100, 512, 52683, 0, 0, 0, 0, 0, 41, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Scarlet Peasant - On Spellhit \'Scarlet Ghoul\' - Despawn Instant'),
(28891, 0, 0, 0, 8, 0, 100, 512, 52683, 0, 0, 0, 0, 0, 41, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Scarlet Miner - On Spellhit \'Scarlet Ghoul\' - Despawn Instant'),
(28886, 0, 0, 0, 8, 0, 100, 512, 52683, 0, 0, 0, 0, 0, 41, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Scarlet Fleet Defender - On Spellhit \'Scarlet Ghoul\' - Despawn Instant'),
(28893, 0, 0, 0, 8, 0, 100, 512, 52685, 0, 0, 0, 0, 0, 41, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Scarlet Gryphon - On Spellhit \'Scourge Gryphon\' - Despawn Instant');

-- Acherus Dummies (disable gravity and set active)
DELETE FROM `creature_template_movement` WHERE (`CreatureId` = 28935);
INSERT INTO `creature_template_movement` (`CreatureId`, `Ground`, `Swim`, `Flight`, `Rooted`, `Chase`, `Random`, `InteractionPauseTimer`) VALUES
(28935, 0, 0, 1, 0, 0, 0, 0);

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 28935;

DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = 28935);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(28935, 0, 0, 0, 25, 0, 100, 0, 0, 0, 0, 0, 0, 0, 48, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Acherus Dummy - On Reset - Set Active On');

-- Link creature entries to the implemented C++ scripts
UPDATE `creature_template` SET `ScriptName` = 'npc_acherus_necromancer' WHERE `entry` = 28889;
UPDATE `creature_template` SET `ScriptName` = 'npc_gothik_the_harvester' WHERE `entry` = 28890;

-- Fixes missing condition for Scarlet Ghoul
DELETE FROM `conditions` WHERE (`SourceTypeOrReferenceId` = 13 AND `SourceGroup` = 1 AND `SourceEntry` = 52683 AND `SourceId` = 0 AND `ConditionTypeOrReference` = 31 AND `ConditionTarget` = 0 AND `ConditionValue1` = 3 AND `ConditionValue2` = 28895 AND `ConditionValue3` = 0);
INSERT INTO `conditions` (`SourceTypeOrReferenceId`,`SourceGroup`,`SourceEntry`,`SourceId`,`ElseGroup`,`ConditionTypeOrReference`,`ConditionTarget`,`ConditionValue1`,`ConditionValue2`,`ConditionValue3`,`NegativeCondition`,`ErrorType`,`ErrorTextId`,`ScriptName`,`Comment`) VALUES
(13,1,52683,0,5,31,0,3,28895,0,0,0,0,'','Scarlet Ghoul only targets Scarlet Medic');
