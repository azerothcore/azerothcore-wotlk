
-- Remove Wrong Npcs

DELETE FROM `creature` WHERE (`id1` = 28822) AND (`guid` IN (128885, 128886, 128887, 128888, 128889, 128890, 128891, 128897, 128900, 128902, 128903, 128904, 128905, 128906, 128907, 128908, 128909));
DELETE FROM `creature` WHERE (`id1` = 28821) AND (`guid` IN (128860, 128861, 128862, 128863, 128864, 128865, 128866, 128872, 128875, 128877, 128878, 128879, 128880, 128881, 128882, 128883, 128884));
DELETE FROM `creature_addon` WHERE `guid` IN (128860, 128861, 128862, 128863, 128864, 128865, 128866, 128872, 128875, 128877, 128878, 128879, 128880, 128881, 128882, 128883, 128884);


-- Add Waypoints

DELETE FROM `waypoint_data` WHERE `id` IN (12889500, 12890100, 12889300, 12889400, 12889200, 12889800, 12889900, 12889600, 12889800);
INSERT INTO `waypoint_data` (`id`, `point`, `position_x`, `position_y`, `position_z`, `orientation`, `delay`, `move_type`, `action`, `action_chance`, `wpguid`) VALUES
(12889500, 1, 2457.81, -5971.01, 94.5838, NULL, 0, 0, 0, 100, 0),
(12889500, 2, 2468.17, -5975.07, 95.2765, NULL, 0, 0, 0, 100, 0),
(12889500, 3, 2479.37, -5975.9, 95.7913, NULL, 0, 0, 0, 100, 0),
(12889500, 4, 2495.7, -5979.33, 95.4122, NULL, 0, 0, 0, 100, 0),
(12889500, 5, 2503.53, -5985.32, 96.5173, NULL, 0, 0, 0, 100, 0),
(12889500, 6, 2515.44, -5993.6, 102.24, NULL, 0, 0, 0, 100, 0),
(12889500, 7, 2526.11, -5994.83, 103.623, NULL, 0, 0, 0, 100, 0),
(12889500, 8, 2536.84, -5995.78, 103.055, NULL, 0, 0, 0, 100, 0),
(12890100, 1, 2531.59, -5984.55, 103.079, NULL, 0, 0, 0, 100, 0),
(12890100, 2, 2525.21, -5974.85, 104.959, NULL, 0, 0, 0, 100, 0),
(12890100, 3, 2519.88, -5963.3, 106.808, NULL, 0, 0, 0, 100, 0),
(12890100, 4, 2520.58, -5959.67, 107.449, NULL, 0, 0, 0, 100, 0),
(12890100, 5, 2522.39, -5951.61, 109.614, NULL, 0, 0, 0, 100, 0),
(12890100, 6, 2519.53, -5944.17, 110.163, NULL, 0, 0, 0, 100, 0),
(12890100, 7, 2514.74, -5940.45, 110.76, NULL, 0, 0, 0, 100, 0),
(12890100, 8, 2506.28, -5933.64, 114.661, NULL, 0, 0, 0, 100, 0),
(12890100, 9, 2497.09, -5932, 115.473, NULL, 0, 0, 0, 100, 0),
(12890100, 10, 2487.37, -5936.89, 116.275, NULL, 0, 0, 0, 100, 0),
(12890100, 11, 2481.05, -5933.07, 116.141, NULL, 0, 0, 0, 100, 0),
(12889300, 1, 2470.42, -5926.1, 115.008, NULL, 0, 0, 0, 100, 0),
(12889300, 2, 2463.34, -5917.07, 113.401, NULL, 0, 0, 0, 100, 0),
(12889300, 3, 2458.6, -5911.03, 112.855, NULL, 0, 0, 0, 100, 0),
(12889300, 4, 2451.09, -5911.71, 112.944, NULL, 0, 0, 0, 100, 0),
(12889300, 5, 2446.34, -5911.87, 113.166, NULL, 0, 0, 0, 100, 0),
(12889300, 6, 2436.46, -5915.82, 112.753, NULL, 0, 0, 0, 100, 0),
(12889300, 7, 2430.58, -5911.54, 112.894, NULL, 0, 0, 0, 100, 0),
(12889400, 1, 2435.06, -5894.12, 104.829, NULL, 0, 0, 0, 100, 0),
(12889400, 2, 2442.21, -5913, 102.131, NULL, 0, 0, 0, 100, 0),
(12889400, 3, 2436.28, -5932.54, 95.8856, NULL, 0, 0, 0, 100, 0),
(12889400, 4, 2426.06, -5937.89, 95.255, NULL, 0, 0, 0, 100, 0),
(12889400, 5, 2422.21, -5939.99, 96.5058, NULL, 0, 0, 0, 100, 0),
(12889400, 6, 2418.61, -5943.65, 96.577, NULL, 0, 0, 0, 100, 0),
(12889400, 7, 2419.33, -5951.59, 97.7769, NULL, 0, 0, 0, 100, 0),
(12889400, 8, 2421.13, -5961.58, 96.9244, NULL, 0, 0, 0, 100, 0),
(12889400, 9, 2438.07, -5973.54, 95.7458, NULL, 0, 0, 0, 100, 0),
(12889400, 10, 2439.83, -5978.79, 96.0635, NULL, 0, 0, 0, 100, 0),
(12889400, 11, 2444.96, -5980.43, 95.6443, NULL, 0, 0, 0, 100, 0),
(12889200, 1, 2382.04, -5921.96, 110.242, NULL, 0, 0, 0, 100, 0),
(12889200, 2, 2359.96, -5905.98, 105.751, NULL, 0, 0, 0, 100, 0),
(12889200, 3, 2345.92, -5901.88, 103.249, NULL, 0, 0, 0, 100, 0),
(12889200, 4, 2323.33, -5899.63, 97.4549, NULL, 0, 0, 0, 100, 0),
(12889200, 5, 2297.8, -5907.54, 87.3678, NULL, 0, 0, 0, 100, 0),
(12889200, 6, 2289.81, -5921.47, 80.0533, NULL, 0, 0, 0, 100, 0),
(12889200, 7, 2286.44, -5933.45, 70.1835, NULL, 0, 0, 0, 100, 0),
(12889200, 8, 2281.33, -5948.36, 60.3395, NULL, 0, 0, 0, 100, 0),
(12889200, 9, 2275.66, -5962.62, 52.2482, NULL, 0, 0, 0, 100, 0),
(12889200, 10, 2269.13, -5966.74, 48.7308, NULL, 0, 0, 0, 100, 0),
(12889200, 11, 2258.51, -5969.35, 43.6041, NULL, 0, 0, 0, 100, 0),
(12889200, 12, 2248.35, -5972.64, 39.794, NULL, 0, 0, 0, 100, 0),
(12889200, 13, 2240.77, -5976.29, 37.8815, NULL, 0, 0, 0, 100, 0),
(12889200, 14, 2230.78, -5991.88, 27.7426, NULL, 0, 0, 0, 100, 0),
(12889200, 15, 2219.15, -6015.72, 10.2269, NULL, 0, 0, 0, 100, 0),
(12889200, 16, 2199.6, -6039.85, 6.60174, NULL, 0, 0, 0, 100, 0),
(12889200, 17, 2192.6, -6052.12, 6.17986, NULL, 0, 0, 0, 100, 0),
(12889200, 18, 2187.14, -6079.83, 3.74995, NULL, 0, 0, 0, 100, 0),
(12889200, 19, 2183.58, -6099.15, 0.841535, NULL, 0, 0, 0, 100, 0),
(12889200, 20, 2177.88, -6122.1, 1.06551, NULL, 0, 0, 0, 100, 0),
(12889200, 21, 2171.2, -6141.99, 1.17394, NULL, 0, 0, 0, 100, 0),
(12889200, 22, 2169.57, -6166.28, 1.04462, NULL, 0, 0, 0, 100, 0),
(12889900, 1, 2405.54, -5918.65, 110.479, NULL, 0, 0, 0, 100, 0),
(12889900, 2, 2388.47, -5913.34, 109.999, NULL, 0, 0, 0, 100, 0),
(12889900, 3, 2369.29, -5911.69, 107.857, NULL, 0, 0, 0, 100, 0),
(12889900, 4, 2351.15, -5908.11, 104.67, NULL, 0, 0, 0, 100, 0),
(12889900, 5, 2331.58, -5902.87, 99.9088, NULL, 0, 0, 0, 100, 0),
(12889900, 6, 2313.75, -5905.73, 92.7526, NULL, 0, 0, 0, 100, 0),
(12889900, 7, 2299.84, -5911.64, 86.2449, NULL, 0, 0, 0, 100, 0),
(12889900, 8, 2295.14, -5918.49, 81.6661, NULL, 0, 0, 0, 100, 0),
(12889900, 9, 2291.21, -5934.34, 70.5652, NULL, 0, 0, 0, 100, 0),
(12889900, 10, 2284.95, -5949.05, 61.0421, NULL, 0, 0, 0, 100, 0),
(12889900, 11, 2277.55, -5963.95, 52.5199, NULL, 0, 0, 0, 100, 0),
(12889900, 12, 2271.31, -5970.06, 48.8038, NULL, 0, 0, 0, 100, 0),
(12889900, 13, 2256.63, -5978.17, 39.8053, NULL, 0, 0, 0, 100, 0),
(12889900, 14, 2244.13, -5984.78, 32.9579, NULL, 0, 0, 0, 100, 0),
(12889900, 15, 2240.24, -5996.13, 28.4352, NULL, 0, 0, 0, 100, 0),
(12889900, 16, 2231.2, -6010.75, 15.9018, NULL, 0, 0, 0, 100, 0),
(12889900, 17, 2224.83, -6023.55, 8.75607, NULL, 0, 0, 0, 100, 0),
(12889900, 18, 2208.88, -6041.44, 6.64625, NULL, 0, 0, 0, 100, 0),
(12889900, 19, 2195.44, -6062.24, 5.82559, NULL, 0, 0, 0, 100, 0),
(12889900, 20, 2189.48, -6086.39, 2.74145, NULL, 0, 0, 0, 100, 0),
(12889900, 21, 2184.48, -6107.44, 1.0489, NULL, 0, 0, 0, 100, 0),
(12889900, 22, 2179.47, -6125.15, 1.09328, NULL, 0, 0, 0, 100, 0),
(12889900, 23, 2176.12, -6147.15, 1.23713, NULL, 0, 0, 0, 100, 0),
(12889900, 24, 2171.64, -6166.66, 0.977108, NULL, 0, 0, 0, 100, 0),
(12889600, 1, 2369.51, -5908.76, 107.55, NULL, 0, 0, 0, 100, 0),
(12889600, 2, 2354.31, -5907.67, 105.178, NULL, 0, 0, 0, 100, 0),
(12889600, 3, 2343.31, -5906.82, 103.387, NULL, 0, 0, 0, 100, 0),
(12889600, 4, 2326.47, -5904.37, 98.0022, NULL, 0, 0, 0, 100, 0),
(12889600, 5, 2302.91, -5908.62, 88.0557, NULL, 0, 0, 0, 100, 0),
(12889600, 6, 2297.43, -5916.56, 83.4883, NULL, 0, 0, 0, 100, 0),
(12889600, 7, 2294.39, -5929.78, 73.8046, NULL, 0, 0, 0, 100, 0),
(12889600, 8, 2291.11, -5941.63, 66.5253, NULL, 0, 0, 0, 100, 0),
(12889600, 9, 2285.16, -5950, 60.6343, NULL, 0, 0, 0, 100, 0),
(12889600, 10, 2274.82, -5963.1, 51.807, NULL, 0, 0, 0, 100, 0),
(12889600, 11, 2266.62, -5968.36, 47.4507, NULL, 0, 0, 0, 100, 0),
(12889600, 12, 2256.1, -5974.46, 40.8902, NULL, 0, 0, 0, 100, 0),
(12889600, 13, 2245.62, -5980.4, 35.077, NULL, 0, 0, 0, 100, 0),
(12889600, 14, 2235.67, -5995.4, 26.6687, NULL, 0, 0, 0, 100, 0),
(12889600, 15, 2229.74, -6004.32, 19.4759, NULL, 0, 0, 0, 100, 0),
(12889600, 16, 2222.2, -6016.41, 10.5263, NULL, 0, 0, 0, 100, 0),
(12889600, 17, 2212.86, -6035.32, 7.05702, NULL, 0, 0, 0, 100, 0),
(12889600, 18, 2204.42, -6052.68, 6.20581, NULL, 0, 0, 0, 100, 0),
(12889600, 19, 2195.57, -6070.37, 4.4531, NULL, 0, 0, 0, 100, 0),
(12889600, 20, 2191.59, -6085.86, 2.81936, NULL, 0, 0, 0, 100, 0),
(12889600, 21, 2186.56, -6105.41, 0.901419, NULL, 0, 0, 0, 100, 0),
(12889600, 22, 2181.6, -6124.66, 1.21378, NULL, 0, 0, 0, 100, 0),
(12889600, 23, 2179.76, -6131.82, 1.79488, NULL, 0, 0, 0, 100, 0),
(12889600, 24, 2176.35, -6145.79, 1.26633, NULL, 0, 0, 0, 100, 0),
(12889600, 25, 2170.92, -6167.93, 0.92409, NULL, 0, 0, 0, 100, 0),
(12889800, 1, 2397.83, -5922.97, 110.373, NULL, 0, 0, 0, 100, 0),
(12889800, 2, 2386.57, -5918.26, 110.209, NULL, 0, 0, 0, 100, 0),
(12889800, 3, 2370.05, -5912.67, 108.097, NULL, 0, 0, 0, 100, 0),
(12889800, 4, 2352.75, -5908.58, 105.014, NULL, 0, 0, 0, 100, 0),
(12889800, 5, 2338.3, -5901.52, 101.878, NULL, 0, 0, 0, 100, 0),
(12889800, 6, 2320.69, -5902.6, 96.0814, NULL, 0, 0, 0, 100, 0),
(12889800, 7, 2303.02, -5906.62, 88.7967, NULL, 0, 0, 0, 100, 0),
(12889800, 8, 2292.08, -5910.15, 86.1959, NULL, 0, 0, 0, 100, 0),
(12889800, 9, 2290.14, -5919.46, 81.3954, NULL, 0, 0, 0, 100, 0),
(12889800, 10, 2288.1, -5929.7, 73.4314, NULL, 0, 0, 0, 100, 0),
(12889800, 11, 2285.71, -5938.77, 66.5439, NULL, 0, 0, 0, 100, 0),
(12889800, 12, 2282.96, -5948.26, 60.8342, NULL, 0, 0, 0, 100, 0),
(12889800, 13, 2278.88, -5960.01, 54.3672, NULL, 0, 0, 0, 100, 0),
(12889800, 14, 2275.86, -5972.99, 50.1883, NULL, 0, 0, 0, 100, 0),
(12889800, 15, 2266.45, -5975.92, 45.7126, NULL, 0, 0, 0, 100, 0),
(12889800, 16, 2257.05, -5977.68, 40.1854, NULL, 0, 0, 0, 100, 0),
(12889800, 17, 2248.05, -5979.76, 35.7801, NULL, 0, 0, 0, 100, 0),
(12889800, 18, 2240.11, -5989.08, 30.5966, NULL, 0, 0, 0, 100, 0),
(12889800, 19, 2232.67, -6001.29, 22.5347, NULL, 0, 0, 0, 100, 0),
(12889800, 20, 2227.55, -6009.1, 15.5793, NULL, 0, 0, 0, 100, 0),
(12889800, 21, 2222.56, -6017.32, 10.2762, NULL, 0, 0, 0, 100, 0),
(12889800, 22, 2219.65, -6035.31, 7.07337, NULL, 0, 0, 0, 100, 0),
(12889800, 23, 2217.22, -6052.6, 6.29405, NULL, 0, 0, 0, 100, 0),
(12889800, 24, 2207.43, -6063.66, 5.68002, NULL, 0, 0, 0, 100, 0),
(12889800, 25, 2197.98, -6074.32, 3.73188, NULL, 0, 0, 0, 100, 0),
(12889800, 26, 2189.35, -6084.07, 2.94724, NULL, 0, 0, 0, 100, 0),
(12889800, 27, 2185.1, -6101.54, 0.794792, NULL, 0, 0, 0, 100, 0),
(12889800, 28, 2177.46, -6117.68, 1.37871, NULL, 0, 0, 0, 100, 0),
(12889800, 29, 2174.98, -6134.95, 1.04813, NULL, 0, 0, 0, 100, 0),
(12889800, 30, 2172.89, -6151.2, 1.11969, NULL, 0, 0, 0, 100, 0),
(12889800, 31, 2170.15, -6167.93, 0.931593, NULL, 0, 0, 0, 100, 0);


-- Add SmartAI to Scarlet Miners and Mine Cars

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE (`entry` = 28822);
UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE (`entry` = 28821);


-- ADDING SMARTAI

-- Scarlet Miner

DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = -128895);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(-128895, 0, 0, 1, 11, 0, 100, 0, 0, 0, 0, 0, 0, 0, 11, 52465, 0, 0, 0, 0, 0, 10, 128870, 28821, 0, 0, 0, 0, 0, 0, 'Scarlet Miner - On Respawn - Cast \'Drag Mine Cart\''),
(-128895, 0, 1, 0, 61, 0, 100, 512, 0, 0, 0, 0, 0, 0, 232, 12889500, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Scarlet Miner - On Respawn - Start Path 12889500'),
(-128895, 0, 2, 3, 109, 0, 100, 512, 0, 12889500, 0, 0, 0, 0, 41, 2000, 10, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Scarlet Miner - On Path 12889500 Finished - Despawn In 2000 ms'),
(-128895, 0, 3, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 41, 2000, 10, 0, 0, 0, 0, 10, 128870, 28821, 0, 0, 0, 0, 0, 0, 'Scarlet Miner - On Path 12889500 Finished - Despawn In 2000 ms'),
(-128895, 0, 5, 0, 6, 0, 100, 0, 0, 0, 0, 0, 0, 0, 41, 1000, 0, 0, 0, 0, 0, 10, 128870, 28821, 0, 0, 0, 0, 0, 0, 'Scarlet Miner - On Just Died - Despawn In 1000 ms');

DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = -128901);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(-128901, 0, 0, 1, 11, 0, 100, 0, 0, 0, 0, 0, 0, 0, 11, 52465, 0, 0, 0, 0, 0, 10, 128876, 28821, 0, 0, 0, 0, 0, 0, 'Scarlet Miner - On Respawn - Cast \'Drag Mine Cart\''),
(-128901, 0, 1, 0, 61, 0, 100, 512, 0, 0, 0, 0, 0, 0, 232, 12890100, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Scarlet Miner - On Respawn - Start Path 12890100'),
(-128901, 0, 2, 3, 109, 0, 100, 512, 0, 12890100, 0, 0, 0, 0, 41, 2000, 10, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Scarlet Miner - On Path 12890100 Finished - Despawn In 2000 ms'),
(-128901, 0, 3, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 41, 2000, 10, 0, 0, 0, 0, 10, 128876, 28821, 0, 0, 0, 0, 0, 0, 'Scarlet Miner - On Path 12890100 Finished - Despawn In 2000 ms'),
(-128901, 0, 5, 0, 6, 0, 100, 0, 0, 0, 0, 0, 0, 0, 41, 1000, 0, 0, 0, 0, 0, 10, 128876, 28821, 0, 0, 0, 0, 0, 0, 'Scarlet Miner - On Just Died - Despawn In 1000 ms');

DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = -128893);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(-128893, 0, 0, 1, 11, 0, 100, 0, 0, 0, 0, 0, 0, 0, 11, 52465, 0, 0, 0, 0, 0, 10, 128868, 28821, 0, 0, 0, 0, 0, 0, 'Scarlet Miner - On Respawn - Cast \'Drag Mine Cart\''),
(-128893, 0, 1, 0, 61, 0, 100, 512, 0, 0, 0, 0, 0, 0, 232, 12889300, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Scarlet Miner - On Respawn - Start Path 12889300'),
(-128893, 0, 2, 3, 109, 0, 100, 512, 0, 12889300, 0, 0, 0, 0, 41, 2000, 10, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Scarlet Miner - On Path 12889300 Finished - Despawn In 2000 ms'),
(-128893, 0, 3, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 41, 2000, 10, 0, 0, 0, 0, 10, 128868, 28821, 0, 0, 0, 0, 0, 0, 'Scarlet Miner - On Path 12889300 Finished - Despawn In 2000 ms'),
(-128893, 0, 5, 0, 6, 0, 100, 0, 0, 0, 0, 0, 0, 0, 41, 1000, 0, 0, 0, 0, 0, 10, 128868, 28821, 0, 0, 0, 0, 0, 0, 'Scarlet Miner - On Just Died - Despawn In 1000 ms');

DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = -128894);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(-128894, 0, 0, 1, 11, 0, 100, 0, 0, 0, 0, 0, 0, 0, 11, 52465, 0, 0, 0, 0, 0, 10, 128869, 28821, 0, 0, 0, 0, 0, 0, 'Scarlet Miner - On Respawn - Cast \'Drag Mine Cart\''),
(-128894, 0, 1, 0, 61, 0, 100, 512, 0, 0, 0, 0, 0, 0, 232, 12889400, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Scarlet Miner - On Respawn - Start Path 12889400'),
(-128894, 0, 2, 3, 109, 0, 100, 512, 0, 12889400, 0, 0, 0, 0, 41, 2000, 10, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Scarlet Miner - On Path 12889400 Finished - Despawn In 2000 ms'),
(-128894, 0, 3, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 41, 2000, 10, 0, 0, 0, 0, 10, 128869, 28821, 0, 0, 0, 0, 0, 0, 'Scarlet Miner - On Path 12889400 Finished - Despawn In 2000 ms'),
(-128894, 0, 5, 0, 6, 0, 100, 0, 0, 0, 0, 0, 0, 0, 41, 1000, 0, 0, 0, 0, 0, 10, 128869, 28821, 0, 0, 0, 0, 0, 0, 'Scarlet Miner - On Just Died - Despawn In 1000 ms');

DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = -128892);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(-128892, 0, 0, 1, 11, 0, 100, 0, 0, 0, 0, 0, 0, 0, 11, 52465, 0, 0, 0, 0, 0, 10, 128867, 28821, 0, 0, 0, 0, 0, 0, 'Scarlet Miner - On Respawn - Cast \'Drag Mine Cart\''),
(-128892, 0, 1, 0, 61, 0, 100, 512, 0, 0, 0, 0, 0, 0, 232, 12889200, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Scarlet Miner - On Respawn - Start Path 12889200'),
(-128892, 0, 2, 3, 109, 0, 100, 512, 0, 12889200, 0, 0, 0, 0, 41, 2000, 10, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Scarlet Miner - On Path 12889200 Finished - Despawn In 2000 ms'),
(-128892, 0, 3, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 41, 2000, 10, 0, 0, 0, 0, 10, 128867, 28821, 0, 0, 0, 0, 0, 0, 'Scarlet Miner - On Path 12889200 Finished - Despawn In 2000 ms'),
(-128892, 0, 5, 0, 6, 0, 100, 0, 0, 0, 0, 0, 0, 0, 41, 1000, 0, 0, 0, 0, 0, 10, 128867, 28821, 0, 0, 0, 0, 0, 0, 'Scarlet Miner - On Just Died - Despawn In 1000 ms');

DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = -128899);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(-128899, 0, 0, 1, 11, 0, 100, 0, 0, 0, 0, 0, 0, 0, 11, 52465, 0, 0, 0, 0, 0, 10, 128874, 28821, 0, 0, 0, 0, 0, 0, 'Scarlet Miner - On Respawn - Cast \'Drag Mine Cart\''),
(-128899, 0, 1, 0, 61, 0, 100, 512, 0, 0, 0, 0, 0, 0, 232, 12889900, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Scarlet Miner - On Respawn - Start Path 12889200'),
(-128899, 0, 2, 3, 109, 0, 100, 512, 0, 12889900, 0, 0, 0, 0, 41, 2000, 10, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Scarlet Miner - On Path 12889900 Finished - Despawn In 2000 ms'),
(-128899, 0, 3, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 41, 2000, 10, 0, 0, 0, 0, 10, 128874, 28821, 0, 0, 0, 0, 0, 0, 'Scarlet Miner - On Path 12889900 Finished - Despawn In 2000 ms'),
(-128899, 0, 5, 0, 6, 0, 100, 0, 0, 0, 0, 0, 0, 0, 41, 1000, 0, 0, 0, 0, 0, 10, 128874, 28821, 0, 0, 0, 0, 0, 0, 'Scarlet Miner - On Just Died - Despawn In 1000 ms');

DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = -128896);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(-128896, 0, 0, 1, 11, 0, 100, 0, 0, 0, 0, 0, 0, 0, 11, 52465, 0, 0, 0, 0, 0, 10, 128871, 28821, 0, 0, 0, 0, 0, 0, 'Scarlet Miner - On Respawn - Cast \'Drag Mine Cart\''),
(-128896, 0, 1, 0, 61, 0, 100, 512, 0, 0, 0, 0, 0, 0, 232, 12889600, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Scarlet Miner - On Respawn - Start Path 12889600'),
(-128896, 0, 2, 3, 109, 0, 100, 512, 0, 12889600, 0, 0, 0, 0, 41, 2000, 10, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Scarlet Miner - On Path 12889600 Finished - Despawn In 2000 ms'),
(-128896, 0, 3, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 41, 2000, 10, 0, 0, 0, 0, 10, 128871, 28821, 0, 0, 0, 0, 0, 0, 'Scarlet Miner - On Path 12889600 Finished - Despawn In 2000 ms'),
(-128896, 0, 5, 0, 6, 0, 100, 0, 0, 0, 0, 0, 0, 0, 41, 1000, 0, 0, 0, 0, 0, 10, 128871, 28821, 0, 0, 0, 0, 0, 0, 'Scarlet Miner - On Just Died - Despawn In 1000 ms');

DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = -128898);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(-128898, 0, 0, 1, 11, 0, 100, 0, 0, 0, 0, 0, 0, 0, 11, 52465, 0, 0, 0, 0, 0, 10, 128873, 28821, 0, 0, 0, 0, 0, 0, 'Scarlet Miner - On Respawn - Cast \'Drag Mine Cart\''),
(-128898, 0, 1, 0, 61, 0, 100, 512, 0, 0, 0, 0, 0, 0, 232, 12889800, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Scarlet Miner - On Respawn - Start Path 12889800'),
(-128898, 0, 2, 3, 109, 0, 100, 512, 0, 12889800, 0, 0, 0, 0, 41, 2000, 10, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Scarlet Miner - On Path 12889800 Finished - Despawn In 2000 ms'),
(-128898, 0, 3, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 41, 2000, 10, 0, 0, 0, 0, 10, 128873, 28821, 0, 0, 0, 0, 0, 0, 'Scarlet Miner - On Path 12889800 Finished - Despawn In 2000 ms'),
(-128898, 0, 5, 0, 6, 0, 100, 0, 0, 0, 0, 0, 0, 0, 41, 1000, 0, 0, 0, 0, 0, 10, 128873, 28821, 0, 0, 0, 0, 0, 0, 'Scarlet Miner - On Just Died - Despawn In 1000 ms');


-- Mine Car

DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = -128870);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(-128870, 0, 0, 0, 1, 0, 100, 0, 0, 0, 0, 0, 0, 0, 29, 1, 180, 0, 0, 0, 0, 10, 128895, 28822, 0, 0, 0, 0, 0, 0, 'Mine Car - Out of Combat - Start Follow Closest Creature \'Scarlet Miner\'');

DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = -128876);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(-128876, 0, 0, 0, 1, 0, 100, 0, 0, 0, 0, 0, 0, 0, 29, 1, 180, 0, 0, 0, 0, 10, 128901, 28822, 0, 0, 0, 0, 0, 0, 'Mine Car - Out of Combat - Start Follow Closest Creature \'Scarlet Miner\'');

DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = -128868);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(-128868, 0, 0, 0, 1, 0, 100, 0, 0, 0, 0, 0, 0, 0, 29, 1, 180, 0, 0, 0, 0, 10, 128893, 28822, 0, 0, 0, 0, 0, 0, 'Mine Car - Out of Combat - Start Follow Closest Creature \'Scarlet Miner\'');

DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = -128869);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(-128869, 0, 0, 0, 1, 0, 100, 0, 0, 0, 0, 0, 0, 0, 29, 1, 180, 0, 0, 0, 0, 10, 128894, 28822, 0, 0, 0, 0, 0, 0, 'Mine Car - Out of Combat - Start Follow Closest Creature \'Scarlet Miner\'');

DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = -128867);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(-128867, 0, 0, 0, 1, 0, 100, 0, 0, 0, 0, 0, 0, 0, 29, 1, 180, 0, 0, 0, 0, 10, 128892, 28822, 0, 0, 0, 0, 0, 0, 'Mine Car - Out of Combat - Start Follow Closest Creature \'Scarlet Miner\'');

DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = -128874);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(-128874, 0, 0, 0, 1, 0, 100, 0, 0, 0, 0, 0, 0, 0, 29, 1, 180, 0, 0, 0, 0, 10, 128899, 28822, 0, 0, 0, 0, 0, 0, 'Mine Car - Out of Combat - Start Follow Closest Creature \'Scarlet Miner\'');

DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = -128871);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(-128871, 0, 0, 0, 1, 0, 100, 0, 0, 0, 0, 0, 0, 0, 29, 1, 180, 0, 0, 0, 0, 10, 128896, 28822, 0, 0, 0, 0, 0, 0, 'Mine Car - Out of Combat - Start Follow Closest Creature \'Scarlet Miner\'');

DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = -128873);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(-128873, 0, 0, 0, 1, 0, 100, 0, 0, 0, 0, 0, 0, 0, 29, 1, 180, 0, 0, 0, 0, 10, 128898, 28822, 0, 0, 0, 0, 0, 0, 'Mine Car - Out of Combat - Start Follow Closest Creature \'Scarlet Miner\'');
