-- DB update 2022_03_27_02 -> 2022_03_27_03
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2022_03_27_02';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2022_03_27_02 2022_03_27_03 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1647450466526877000'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1647450466526877000');

/*  Unliving Resident - GUID 4025  */


SET @NPC := 4025;
SET @PATH := @NPC * 10;

UPDATE `creature` SET `position_x` = -11095.1, `position_y` = -1910.74, `position_z` = 3.21322, `orientation` = 3.9274 WHERE `guid` = @NPC;

DELETE FROM `creature_addon` WHERE `guid` = @NPC;
INSERT INTO `creature_addon` (`guid`, `path_id`) VALUES (@NPC, @PATH);
UPDATE `creature` SET `MovementType` = 2 WHERE `guid` = @NPC;

DELETE FROM `waypoint_data` where `id` = @PATH;
INSERT INTO `waypoint_data` (`id`, `point`, `position_x`, `position_y`, `position_z`, `orientation`, `delay`) VALUES
(@PATH, 1, -11095.1, -1910.74, 3.21322, 100.0, 0),
(@PATH, 2, -11094.6, -1892.78, 2.01981, 100.0, 0),
(@PATH, 3, -11082.4, -1891.29, 1.17905, 100.0, 0),
(@PATH, 4, -11051.7, -1898.53, -3.986, 100.0, 0),
(@PATH, 5, -11038.2, -1906.65, -3.48946, 100.0, 0),
(@PATH, 6, -11038.9, -1923.58, -4.59355, 100.0, 0),
(@PATH, 7, -11052.0, -1932.28, -5.27407, 100.0, 0),
(@PATH, 8, -11073.3, -1936.16, -7.25148, 100.0, 0),
(@PATH, 9, -11104.5, -1945.88, -10.9586, 100.0, 0),
(@PATH, 10, -11121.1, -1928.71, -12.5844, 100.0, 0),
(@PATH, 11, -11133.4, -1888.57, -12.6572, 100.0, 0),
(@PATH, 12, -11133.1, -1869.91, -11.7546, 100.0, 0),
(@PATH, 13, -11120.5, -1848.14, -11.2241, 100.0, 0),
(@PATH, 14, -11137.5, -1870.44, -13.1619, 100.0, 0),
(@PATH, 15, -11134.2, -1905.88, -13.3185, 100.0, 0),
(@PATH, 16, -11122.8, -1929.82, -12.7888, 100.0, 0),
(@PATH, 17, -11097.8, -1944.76, -9.9939, 100.0, 0),
(@PATH, 18, -11071.5, -1936.73, -6.91792, 100.0, 0),
(@PATH, 19, -11049.2, -1932.39, -5.29754, 100.0, 0),
(@PATH, 20, -11036.9, -1919.96, -4.30209, 100.0, 0),
(@PATH, 21, -11037.8, -1906.61, -3.45571, 100.0, 0),
(@PATH, 22, -11053.3, -1896.37, -3.74098, 100.0, 0),
(@PATH, 23, -11071.2, -1893.61, -0.715124, 100.0, 0),
(@PATH, 24, -11093.8, -1892.31, 2.02048, 100.0, 0);


/*  Unliving Resident - GUID 4030  */


SET @NPC := 4030;
SET @PATH := @NPC * 10;

UPDATE `creature` SET `position_x` = -11106.1, `position_y` = -1917.02, `position_z` = 1.84265, `orientation` = 5.27257 WHERE `guid` = @NPC;

DELETE FROM `creature_addon` WHERE `guid` = @NPC;
INSERT INTO `creature_addon` (`guid`, `path_id`) VALUES (@NPC, @PATH);
UPDATE `creature` SET `MovementType` = 2 WHERE `guid` = @NPC;

DELETE FROM `waypoint_data` where `id` = @PATH;
INSERT INTO `waypoint_data` (`id`, `point`, `position_x`, `position_y`, `position_z`, `orientation`, `delay`) VALUES
(@PATH, 1, -11106.1, -1917.02, 1.84265, 100.0, 0),
(@PATH, 2, -11095.6, -1932.36, 4.8592, 100.0, 0),
(@PATH, 3, -11101.0, -1976.97, 6.75665, 100.0, 0),
(@PATH, 4, -11106.2, -1996.71, 12.7172, 100.0, 0),
(@PATH, 5, -11126.0, -2005.13, 14.4021, 100.0, 0),
(@PATH, 6, -11134.7, -1991.49, 16.7522, 100.0, 0),
(@PATH, 7, -11145.5, -1971.53, 22.9096, 100.0, 0),
(@PATH, 8, -11151.0, -1961.27, 22.8555, 100.0, 0),
(@PATH, 9, -11158.0, -1961.54, 22.797, 100.0, 0),
(@PATH, 10, -11170.1, -1968.57, 22.7836, 100.0, 0),
(@PATH, 11, -11182.9, -1982.89, 22.7616, 100.0, 0),
(@PATH, 12, -11181.5, -1994.34, 22.7571, 100.0, 0),
(@PATH, 13, -11177.3, -2001.36, 22.7926, 100.0, 0),
(@PATH, 14, -11183.6, -1990.17, 22.7412, 100.0, 0),
(@PATH, 15, -11178.9, -1975.15, 22.7914, 100.0, 0),
(@PATH, 16, -11154.5, -1961.37, 22.8387, 100.0, 0),
(@PATH, 17, -11144.7, -1969.68, 22.8894, 100.0, 0),
(@PATH, 18, -11134.0, -1996.18, 15.7482, 100.0, 0),
(@PATH, 19, -11121.0, -2006.04, 13.8847, 100.0, 0),
(@PATH, 20, -11107.6, -2001.98, 13.1692, 100.0, 0),
(@PATH, 21, -11100.6, -1966.46, 2.36667, 100.0, 0),
(@PATH, 22, -11096.0, -1933.57, 4.96026, 100.0, 0);


/*  Wailing Spectre - GUID 4051  */


SET @NPC := 4051;
SET @PATH := @NPC * 10;

UPDATE `creature` SET `position_x` = -11210.8, `position_y` = -2191.99, `position_z` = 22.7419, `orientation` = 2.71175 WHERE `guid` = @NPC;

DELETE FROM `creature_addon` WHERE `guid` = @NPC;
INSERT INTO `creature_addon` (`guid`, `path_id`) VALUES (@NPC, @PATH);
UPDATE `creature` SET `MovementType` = 2 WHERE `guid` = @NPC;

DELETE FROM `waypoint_data` where `id` = @PATH;
INSERT INTO `waypoint_data` (`id`, `point`, `position_x`, `position_y`, `position_z`, `orientation`, `delay`) VALUES
(@PATH, 1, -11210.8, -2191.99, 22.7419, 100.0, 1000),
(@PATH, 2, -11241.0, -2198.84, 22.7022, 100.0, 0),
(@PATH, 3, -11256.9, -2199.0, 22.7027, 100.0, 0),
(@PATH, 4, -11282.8, -2194.2, 22.7064, 100.0, 0),
(@PATH, 5, -11326.2, -2189.52, 22.7064, 100.0, 0),
(@PATH, 6, -11366.9, -2185.51, 22.9566, 100.0, 1000),
(@PATH, 7, -11326.3, -2189.22, 22.7074, 100.0, 0),
(@PATH, 8, -11286.8, -2193.12, 22.7074, 100.0, 0),
(@PATH, 9, -11246.0, -2200.46, 22.7043, 100.0, 0);


/*  Wailing Spectre - GUID 4055  */


SET @NPC := 4055;
SET @PATH := @NPC * 10;

UPDATE `creature` SET `position_x` = -11183.7, `position_y` = -2076.16, `position_z` = 35.5059, `orientation` = 1.53675 WHERE `guid` = @NPC;

DELETE FROM `creature_addon` WHERE `guid` = @NPC;
INSERT INTO `creature_addon` (`guid`, `path_id`) VALUES (@NPC, @PATH);
UPDATE `creature` SET `MovementType` = 2 WHERE `guid` = @NPC;

DELETE FROM `waypoint_data` where `id` = @PATH;
INSERT INTO `waypoint_data` (`id`, `point`, `position_x`, `position_y`, `position_z`, `orientation`, `delay`) VALUES
(@PATH, 1, -11183.7, -2076.16, 35.5059, 100.0, 0),
(@PATH, 2, -11172.0, -2076.4, 35.5059, 100.0, 0),
(@PATH, 3, -11193.6, -2074.82, 35.5059, 100.0, 0),
(@PATH, 4, -11183.5, -2075.88, 35.5059, 100.0, 0),
(@PATH, 5, -11185.9, -2102.24, 31.2394, 100.0, 0),
(@PATH, 6, -11173.0, -2103.66, 31.2394, 100.0, 0),
(@PATH, 7, -11195.6, -2101.73, 31.2394, 100.0, 0),
(@PATH, 8, -11185.6, -2103.02, 31.2394, 100.0, 0),
(@PATH, 9, -11188.0, -2129.38, 26.9742, 100.0, 0),
(@PATH, 10, -11176.8, -2130.71, 26.9742, 100.0, 0),
(@PATH, 11, -11197.1, -2129.47, 26.9742, 100.0, 0),
(@PATH, 12, -11188.2, -2129.57, 26.9742, 100.0, 0),
(@PATH, 13, -11190.6, -2161.87, 22.7, 100.0, 0),
(@PATH, 14, -11188.1, -2130.17, 26.9744, 100.0, 0),
(@PATH, 15, -11180.1, -2130.91, 26.9744, 100.0, 0),
(@PATH, 16, -11198.9, -2128.94, 26.9728, 100.0, 0),
(@PATH, 17, -11188.1, -2130.19, 26.9728, 100.0, 0),
(@PATH, 18, -11185.8, -2102.4, 31.2392, 100.0, 0),
(@PATH, 19, -11175.0, -2103.68, 31.2392, 100.0, 0),
(@PATH, 20, -11194.7, -2101.89, 31.2392, 100.0, 0),
(@PATH, 21, -11185.3, -2103.35, 31.2392, 100.0, 0),
(@PATH, 22, -11183.6, -2075.87, 35.5054, 100.0, 0),
(@PATH, 23, -11173.6, -2076.92, 35.5054, 100.0, 0),
(@PATH, 24, -11192.5, -2075.51, 35.5054, 100.0, 0);



/*  Green Recluse - GUID 4241  */


SET @NPC := 4241;
SET @PATH := @NPC * 10;

UPDATE `creature` SET `position_x` = -10963.0, `position_y` = 472.957, `position_z` = 41.2228, `orientation` = 3.66559 WHERE `guid` = @NPC;

DELETE FROM `creature_addon` WHERE `guid` = @NPC;
INSERT INTO `creature_addon` (`guid`, `path_id`) VALUES (@NPC, @PATH);
UPDATE `creature` SET `MovementType` = 2 WHERE `guid` = @NPC;

DELETE FROM `waypoint_data` where `id` = @PATH;
INSERT INTO `waypoint_data` (`id`, `point`, `position_x`, `position_y`, `position_z`, `orientation`, `delay`) VALUES
(@PATH, 1, -10963.0, 472.957, 41.2228, 100.0, 0),
(@PATH, 2, -10982.5, 454.528, 39.7546, 100.0, 0),
(@PATH, 3, -10994.2, 429.068, 38.7282, 100.0, 0),
(@PATH, 4, -11027.2, 412.812, 33.6053, 100.0, 0),
(@PATH, 5, -11033.6, 389.422, 34.703, 100.0, 0),
(@PATH, 6, -11050.3, 372.899, 31.9925, 100.0, 0),
(@PATH, 7, -11062.5, 352.555, 29.4821, 100.0, 0),
(@PATH, 8, -11051.4, 336.537, 32.0397, 100.0, 0),
(@PATH, 9, -11029.6, 327.061, 27.7174, 100.0, 0),
(@PATH, 10, -11007.0, 325.887, 34.4693, 100.0, 0),
(@PATH, 11, -10988.5, 353.52, 34.1904, 100.0, 0),
(@PATH, 12, -10975.6, 363.202, 35.3692, 100.0, 0),
(@PATH, 13, -10915.2, 396.127, 44.635, 100.0, 0),
(@PATH, 14, -10902.3, 439.368, 45.3285, 100.0, 0),
(@PATH, 15, -10907.2, 454.818, 44.8949, 100.0, 0),
(@PATH, 16, -10934.8, 471.136, 42.0589, 100.0, 0);


/*  Bone Chewer - GUID 4401  */


SET @NPC := 4401;
SET @PATH := @NPC * 10;

UPDATE `creature` SET `position_x` = -10228.7, `position_y` = 351.048, `position_z` = 9.63406, `orientation` = 0.107699 WHERE `guid` = @NPC;

UPDATE `creature_addon` set `path_id` = @PATH WHERE `guid` = @NPC;
UPDATE `creature` SET `MovementType` = 2 WHERE `guid` = @NPC;

DELETE FROM `waypoint_data` where `id` = @PATH;
INSERT INTO `waypoint_data` (`id`, `point`, `position_x`, `position_y`, `position_z`, `orientation`, `delay`) VALUES
(@PATH, 1, -10228.7, 351.048, 9.63406, 100.0, 0),
(@PATH, 2, -10220.9, 343.408, 8.31477, 100.0, 0),
(@PATH, 3, -10208.7, 343.188, 8.91591, 100.0, 0),
(@PATH, 4, -10196.6, 351.738, 8.76319, 100.0, 0),
(@PATH, 5, -10185.2, 352.423, 10.7034, 100.0, 0),
(@PATH, 6, -10176.9, 348.391, 9.77995, 100.0, 0),
(@PATH, 7, -10168.9, 339.213, 8.52578, 100.0, 0),
(@PATH, 8, -10165.7, 330.467, 7.31532, 100.0, 0),
(@PATH, 9, -10169.3, 322.305, 6.54894, 100.0, 0),
(@PATH, 10, -10180.0, 318.602, 6.77051, 100.0, 0),
(@PATH, 11, -10191.2, 314.034, 7.17364, 100.0, 0),
(@PATH, 12, -10198.5, 308.553, 5.12256, 100.0, 0),
(@PATH, 13, -10197.0, 294.262, 2.72569, 100.0, 0),
(@PATH, 14, -10194.3, 283.135, 2.02693, 100.0, 0),
(@PATH, 15, -10196.5, 292.286, 2.58085, 100.0, 0),
(@PATH, 16, -10199.8, 304.583, 3.86606, 100.0, 0),
(@PATH, 17, -10197.7, 309.325, 5.48173, 100.0, 0),
(@PATH, 18, -10187.4, 316.383, 7.23757, 100.0, 0),
(@PATH, 19, -10175.7, 318.966, 6.44419, 100.0, 0),
(@PATH, 20, -10166.8, 326.153, 6.87309, 100.0, 0),
(@PATH, 21, -10167.0, 334.818, 7.94311, 100.0, 0),
(@PATH, 22, -10171.3, 343.1, 9.22542, 100.0, 0),
(@PATH, 23, -10180.8, 350.711, 10.2878, 100.0, 0),
(@PATH, 24, -10192.7, 353.604, 9.31527, 100.0, 0),
(@PATH, 25, -10202.0, 346.365, 7.84645, 100.0, 0),
(@PATH, 26, -10216.3, 342.358, 8.45914, 100.0, 0),
(@PATH, 27, -10225.1, 345.221, 8.72192, 100.0, 0),
(@PATH, 28, -10229.0, 354.197, 9.80023, 100.0, 0);


/*  Skeletal Warder - GUID 4402  */


SET @NPC := 4402;
SET @PATH := @NPC * 10;

UPDATE `creature` SET `position_x` = -10414.1, `position_y` = 403.54, `position_z` = 47.7959, `orientation` = 3.0298 WHERE `guid` = @NPC;

DELETE FROM `creature_addon` WHERE `guid` = @NPC;
INSERT INTO `creature_addon` (`guid`, `path_id`) VALUES (@NPC, @PATH);
UPDATE `creature` SET `MovementType` = 2 WHERE `guid` = @NPC;

DELETE FROM `waypoint_data` where `id` = @PATH;
INSERT INTO `waypoint_data` (`id`, `point`, `position_x`, `position_y`, `position_z`, `orientation`, `delay`) VALUES
(@PATH, 1, -10414.1, 403.54, 47.7959, 100.0, 0),
(@PATH, 2, -10411.0, 415.171, 40.1772, 100.0, 0),
(@PATH, 3, -10392.9, 416.29, 29.1068, 100.0, 0),
(@PATH, 4, -10379.0, 412.91, 29.0842, 100.0, 0),
(@PATH, 5, -10348.1, 405.259, 15.9644, 100.0, 0),
(@PATH, 6, -10320.1, 398.071, 15.8847, 100.0, 0),
(@PATH, 7, -10285.7, 389.61, 15.6853, 100.0, 0),
(@PATH, 8, -10313.8, 396.488, 15.7496, 100.0, 0),
(@PATH, 9, -10345.2, 404.513, 16.0038, 100.0, 0),
(@PATH, 10, -10371.0, 410.878, 27.9095, 100.0, 0),
(@PATH, 11, -10384.4, 414.328, 29.0818, 100.0, 0),
(@PATH, 12, -10406.5, 418.847, 38.4252, 100.0, 0);


/*  Skeletal Raider - GUID 4889  */


SET @NPC := 4889;
SET @PATH := @NPC * 10;

UPDATE `creature` SET `position_x` = -10317.6, `position_y` = 464.207, `position_z` = 15.8576, `orientation` = 3.84139 WHERE `guid` = @NPC;

UPDATE `creature_addon` set `path_id` = @PATH WHERE `guid` = @NPC;
UPDATE `creature` SET `MovementType` = 2 WHERE `guid` = @NPC;

DELETE FROM `waypoint_data` where `id` = @PATH;
INSERT INTO `waypoint_data` (`id`, `point`, `position_x`, `position_y`, `position_z`, `orientation`, `delay`) VALUES
(@PATH, 1, -10317.6, 464.207, 15.8576, 100.0, 0),
(@PATH, 2, -10319.5, 457.095, 15.8678, 100.0, 0),
(@PATH, 3, -10322.1, 450.572, 15.8676, 100.0, 0),
(@PATH, 4, -10334.2, 443.355, 15.8676, 100.0, 0),
(@PATH, 5, -10336.5, 434.0, 15.8676, 100.0, 0),
(@PATH, 6, -10332.8, 424.144, 15.8676, 100.0, 0),
(@PATH, 7, -10333.8, 410.908, 16.0555, 100.0, 0),
(@PATH, 8, -10329.5, 401.654, 15.9962, 100.0, 0),
(@PATH, 9, -10306.3, 394.629, 15.6852, 100.0, 0),
(@PATH, 10, -10292.3, 395.424, 15.6853, 100.0, 0),
(@PATH, 11, -10278.6, 399.561, 15.6853, 100.0, 0),
(@PATH, 12, -10262.0, 397.602, 11.9738, 100.0, 0),
(@PATH, 13, -10256.8, 393.674, 10.4135, 100.0, 0),
(@PATH, 14, -10251.9, 389.152, 10.4135, 100.0, 0),
(@PATH, 15, -10250.8, 381.205, 10.4135, 100.0, 0),
(@PATH, 16, -10248.4, 376.254, 10.4135, 100.0, 0),
(@PATH, 17, -10239.5, 379.492, 10.4135, 100.0, 0),
(@PATH, 18, -10230.3, 378.412, 10.4135, 100.0, 0),
(@PATH, 19, -10218.9, 364.708, 10.4135, 100.0, 0),
(@PATH, 20, -10224.9, 373.694, 10.4135, 100.0, 0),
(@PATH, 21, -10233.3, 379.872, 10.4135, 100.0, 0),
(@PATH, 22, -10242.3, 377.349, 10.4135, 100.0, 0),
(@PATH, 23, -10248.3, 376.22, 10.4135, 100.0, 0),
(@PATH, 24, -10249.8, 384.505, 10.4135, 100.0, 0),
(@PATH, 25, -10251.7, 389.067, 10.4135, 100.0, 0),
(@PATH, 26, -10256.7, 393.442, 10.4135, 100.0, 0),
(@PATH, 27, -10270.8, 400.448, 15.6855, 100.0, 0),
(@PATH, 28, -10284.4, 397.469, 15.6853, 100.0, 0),
(@PATH, 29, -10299.2, 394.302, 15.6853, 100.0, 0),
(@PATH, 30, -10324.0, 397.968, 15.9209, 100.0, 0),
(@PATH, 31, -10333.4, 407.719, 16.0532, 100.0, 0),
(@PATH, 32, -10331.2, 417.762, 15.898, 100.0, 0),
(@PATH, 33, -10334.3, 427.185, 15.8676, 100.0, 0),
(@PATH, 34, -10336.4, 437.439, 15.8676, 100.0, 0),
(@PATH, 35, -10327.6, 446.085, 15.8676, 100.0, 0),
(@PATH, 36, -10322.2, 450.505, 15.8676, 100.0, 0);


/*  Black Widow Hatchling - GUID 4902  */


SET @NPC := 4902;
SET @PATH := @NPC * 10;

UPDATE `creature` SET `position_x` = -10301.6, `position_y` = 0.194063, `position_z` = 46.3445, `orientation` = 2.2823 WHERE `guid` = @NPC;

DELETE FROM `creature_addon` WHERE `guid` = @NPC;
INSERT INTO `creature_addon` (`guid`, `path_id`) VALUES (@NPC, @PATH);
UPDATE `creature` SET `MovementType` = 2 WHERE `guid` = @NPC;

DELETE FROM `waypoint_data` where `id` = @PATH;
INSERT INTO `waypoint_data` (`id`, `point`, `position_x`, `position_y`, `position_z`, `orientation`, `delay`) VALUES
(@PATH, 1, -10301.6, 0.194063, 46.3445, 100.0, 0),
(@PATH, 2, -10308.1, 26.6428, 47.8693, 100.0, 0),
(@PATH, 3, -10331.9, 39.0091, 47.9571, 100.0, 0),
(@PATH, 4, -10360.0, 41.4104, 50.7178, 100.0, 0),
(@PATH, 5, -10365.2, 36.9746, 51.8405, 100.0, 0),
(@PATH, 6, -10359.5, 23.8917, 51.019, 100.0, 0),
(@PATH, 7, -10332.1, -75.3978, 42.2366, 100.0, 0),
(@PATH, 8, -10299.8, -99.7262, 42.2065, 100.0, 0),
(@PATH, 9, -10303.5, -55.9479, 42.5999, 100.0, 0),
(@PATH, 10, -10308.6, -36.9398, 41.8928, 100.0, 0),
(@PATH, 11, -10308.8, -20.8141, 42.7561, 100.0, 0);


/*  Splinter Fist Warrior - GUID 5073  */


SET @NPC := 5073;
SET @PATH := @NPC * 10;

UPDATE `creature` SET `position_x` = -11110.0, `position_y` = -155.95, `position_z` = 11.7778, `orientation` = 0.459474 WHERE `guid` = @NPC;

DELETE FROM `creature_addon` WHERE `guid` = @NPC;
INSERT INTO `creature_addon` (`guid`, `path_id`) VALUES (@NPC, @PATH);
UPDATE `creature` SET `MovementType` = 2 WHERE `guid` = @NPC;

DELETE FROM `waypoint_data` where `id` = @PATH;
INSERT INTO `waypoint_data` (`id`, `point`, `position_x`, `position_y`, `position_z`, `orientation`, `delay`) VALUES
(@PATH, 1, -11110.0, -155.95, 11.7778, 100.0, 0),
(@PATH, 2, -11108.8, -148.036, 13.2968, 100.0, 0),
(@PATH, 3, -11118.4, -131.875, 12.0047, 100.0, 0),
(@PATH, 4, -11121.8, -106.117, 11.5575, 100.0, 0),
(@PATH, 5, -11121.7, -122.171, 12.0564, 100.0, 0),
(@PATH, 6, -11109.8, -141.866, 12.9087, 100.0, 0);


/*  Skeletal Warder - GUID 5094  */


SET @NPC := 5094;
SET @PATH := @NPC * 10;

UPDATE `creature` SET `position_x` = -10355.1, `position_y` = 352.33, `position_z` = 15.9736, `orientation` = 6.04304 WHERE `guid` = @NPC;

DELETE FROM `creature_addon` WHERE `guid` = @NPC;
INSERT INTO `creature_addon` (`guid`, `path_id`) VALUES (@NPC, @PATH);
UPDATE `creature` SET `MovementType` = 2 WHERE `guid` = @NPC;

DELETE FROM `waypoint_data` where `id` = @PATH;
INSERT INTO `waypoint_data` (`id`, `point`, `position_x`, `position_y`, `position_z`, `orientation`, `delay`) VALUES
(@PATH, 1, -10355.1, 352.33, 15.9736, 100.0, 0),
(@PATH, 2, -10347.7, 352.817, 15.9736, 100.0, 0),
(@PATH, 3, -10345.5, 354.638, 15.9736, 100.0, 0),
(@PATH, 4, -10344.5, 361.763, 15.9736, 100.0, 0),
(@PATH, 5, -10348.3, 366.464, 15.9736, 100.0, 0),
(@PATH, 6, -10351.5, 375.142, 15.9736, 100.0, 0),
(@PATH, 7, -10344.1, 382.128, 15.9736, 100.0, 0),
(@PATH, 8, -10344.5, 392.092, 15.9908, 100.0, 0),
(@PATH, 9, -10345.4, 402.749, 16.0175, 100.0, 0),
(@PATH, 10, -10369.4, 410.928, 26.8698, 100.0, 0),
(@PATH, 11, -10378.6, 414.903, 29.0807, 100.0, 0),
(@PATH, 12, -10379.9, 424.817, 29.0795, 100.0, 0),
(@PATH, 13, -10386.0, 432.277, 29.0795, 100.0, 0),
(@PATH, 14, -10387.2, 440.174, 24.8359, 100.0, 0),
(@PATH, 15, -10380.7, 448.117, 24.834, 100.0, 0),
(@PATH, 16, -10371.5, 455.446, 25.0028, 100.0, 0),
(@PATH, 17, -10367.0, 467.777, 25.0028, 100.0, 0),
(@PATH, 18, -10371.6, 481.233, 24.834, 100.0, 0),
(@PATH, 19, -10363.2, 481.035, 24.8734, 100.0, 0),
(@PATH, 20, -10367.5, 449.085, 24.834, 100.0, 0),
(@PATH, 21, -10367.7, 437.808, 24.834, 100.0, 0),
(@PATH, 22, -10368.1, 431.91, 27.4331, 100.0, 0),
(@PATH, 23, -10374.8, 425.168, 29.0795, 100.0, 0),
(@PATH, 24, -10381.9, 417.368, 29.0795, 100.0, 0),
(@PATH, 25, -10385.8, 406.396, 29.0795, 100.0, 0),
(@PATH, 26, -10379.2, 396.033, 29.0795, 100.0, 0),
(@PATH, 27, -10377.8, 390.704, 27.058, 100.0, 0),
(@PATH, 28, -10386.2, 381.035, 24.3922, 100.0, 0),
(@PATH, 29, -10398.7, 368.109, 24.3969, 100.0, 0),
(@PATH, 30, -10406.9, 352.263, 24.8339, 100.0, 0),
(@PATH, 31, -10394.3, 343.694, 24.8339, 100.0, 0),
(@PATH, 32, -10386.3, 368.522, 24.506, 100.0, 0),
(@PATH, 33, -10395.6, 381.512, 24.3923, 100.0, 0),
(@PATH, 34, -10397.7, 394.416, 25.9037, 100.0, 0),
(@PATH, 35, -10389.8, 402.244, 29.0795, 100.0, 0),
(@PATH, 36, -10393.0, 400.646, 29.0795, 100.0, 0),
(@PATH, 37, -10398.1, 387.175, 24.8339, 100.0, 0),
(@PATH, 38, -10389.0, 376.263, 24.3921, 100.0, 0),
(@PATH, 39, -10391.3, 347.907, 24.5479, 100.0, 0),
(@PATH, 40, -10404.2, 347.843, 24.442, 100.0, 0),
(@PATH, 41, -10392.0, 375.448, 24.3937, 100.0, 0),
(@PATH, 42, -10381.3, 385.024, 24.8339, 100.0, 0),
(@PATH, 43, -10377.9, 390.278, 26.6428, 100.0, 0),
(@PATH, 44, -10384.3, 400.086, 29.0795, 100.0, 0),
(@PATH, 45, -10384.3, 412.797, 29.0795, 100.0, 0),
(@PATH, 46, -10378.7, 421.913, 29.0795, 100.0, 0),
(@PATH, 47, -10373.1, 426.184, 29.0795, 100.0, 0),
(@PATH, 48, -10368.5, 430.843, 28.5664, 100.0, 0),
(@PATH, 49, -10368.2, 443.341, 24.834, 100.0, 0),
(@PATH, 50, -10379.0, 449.525, 24.8433, 100.0, 0),
(@PATH, 51, -10384.5, 444.873, 24.834, 100.0, 0),
(@PATH, 52, -10387.8, 436.284, 27.8481, 100.0, 0),
(@PATH, 53, -10382.0, 429.461, 29.0795, 100.0, 0),
(@PATH, 54, -10380.0, 419.797, 29.0795, 100.0, 0),
(@PATH, 55, -10377.4, 414.224, 29.0795, 100.0, 0),
(@PATH, 56, -10347.2, 405.139, 15.9772, 100.0, 0),
(@PATH, 57, -10345.5, 399.519, 16.0451, 100.0, 0),
(@PATH, 58, -10343.1, 385.361, 15.9725, 100.0, 0),
(@PATH, 59, -10349.5, 378.241, 15.9736, 100.0, 0),
(@PATH, 60, -10351.6, 372.054, 15.9736, 100.0, 0),
(@PATH, 61, -10348.9, 366.719, 15.9736, 100.0, 0),
(@PATH, 62, -10344.5, 362.374, 15.9736, 100.0, 0),
(@PATH, 63, -10345.4, 355.239, 15.9736, 100.0, 0);


/*  Rabid Dire Wolf - GUID 5150  */


SET @NPC := 5150;
SET @PATH := @NPC * 10;

UPDATE `creature` SET `position_x` = -10177.6, `position_y` = 222.201, `position_z` = 23.1674, `orientation` = 2.62509 WHERE `guid` = @NPC;

DELETE FROM `creature_addon` WHERE `guid` = @NPC;
INSERT INTO `creature_addon` (`guid`, `path_id`) VALUES (@NPC, @PATH);
UPDATE `creature` SET `MovementType` = 2 WHERE `guid` = @NPC;

DELETE FROM `waypoint_data` where `id` = @PATH;
INSERT INTO `waypoint_data` (`id`, `point`, `position_x`, `position_y`, `position_z`, `orientation`, `delay`) VALUES
(@PATH, 1, -10177.6, 222.201, 23.1674, 100.0, 0),
(@PATH, 2, -10168.8, 240.326, 22.6847, 100.0, 0),
(@PATH, 3, -10166.9, 276.071, 23.1022, 100.0, 0),
(@PATH, 4, -10178.8, 282.327, 23.6412, 100.0, 0),
(@PATH, 5, -10202.2, 288.041, 26.1563, 100.0, 0),
(@PATH, 6, -10219.9, 283.841, 32.6592, 100.0, 0),
(@PATH, 7, -10232.2, 264.566, 33.3733, 100.0, 0),
(@PATH, 8, -10232.0, 240.734, 31.767, 100.0, 0),
(@PATH, 9, -10249.2, 236.713, 31.0763, 100.0, 0),
(@PATH, 10, -10260.4, 213.571, 29.0039, 100.0, 0),
(@PATH, 11, -10257.2, 190.051, 32.6815, 100.0, 0),
(@PATH, 12, -10242.9, 161.452, 32.9415, 100.0, 0),
(@PATH, 13, -10227.4, 148.997, 31.5172, 100.0, 0),
(@PATH, 14, -10213.1, 134.704, 30.9467, 100.0, 0),
(@PATH, 15, -10197.6, 139.533, 29.8189, 100.0, 0),
(@PATH, 16, -10185.2, 154.721, 26.5017, 100.0, 0),
(@PATH, 17, -10176.7, 177.115, 24.2734, 100.0, 0),
(@PATH, 18, -10241.7, 159.204, 32.9059, 100.0, 0);


/*  Plague Spreader - GUID 5969  */


SET @NPC := 5969;
SET @PATH := @NPC * 10;

UPDATE `creature` SET `position_x` = -10342.1, `position_y` = 173.163, `position_z` = 16.1488, `orientation` = 4.31581 WHERE `guid` = @NPC;

DELETE FROM `creature_addon` WHERE `guid` = @NPC;
INSERT INTO `creature_addon` (`guid`, `path_id`) VALUES (@NPC, @PATH);
UPDATE `creature` SET `MovementType` = 2 WHERE `guid` = @NPC;

DELETE FROM `waypoint_data` where `id` = @PATH;
INSERT INTO `waypoint_data` (`id`, `point`, `position_x`, `position_y`, `position_z`, `orientation`, `delay`) VALUES
(@PATH, 1, -10342.1, 173.163, 16.1488, 100.0, 0),
(@PATH, 2, -10344.3, 191.582, 25.7489, 100.0, 0),
(@PATH, 3, -10342.7, 178.137, 18.1823, 100.0, 0),
(@PATH, 4, -10338.8, 147.441, 3.48252, 100.0, 0),
(@PATH, 5, -10340.9, 138.639, 4.90493, 100.0, 0),
(@PATH, 6, -10360.4, 134.447, 2.25113, 100.0, 0),
(@PATH, 7, -10342.9, 133.15, 5.46266, 100.0, 0),
(@PATH, 8, -10335.7, 128.401, 3.961, 100.0, 0),
(@PATH, 9, -10331.1, 107.815, 1.7015, 100.0, 0),
(@PATH, 10, -10333.2, 137.227, 3.82124, 100.0, 0),
(@PATH, 11, -10286.2, 147.016, 2.79024, 100.0, 0),
(@PATH, 12, -10329.6, 139.619, 2.96308, 100.0, 0);


/*  Nightbane Worgen - GUID 6063  */


SET @NPC := 6063;
SET @PATH := @NPC * 10;

UPDATE `creature` SET `position_x` = -10288.3, `position_y` = -785.67, `position_z` = 48.9806, `orientation` = 1.26872 WHERE `guid` = @NPC;

DELETE FROM `creature_addon` WHERE `guid` = @NPC;
INSERT INTO `creature_addon` (`guid`, `path_id`) VALUES (@NPC, @PATH);
UPDATE `creature` SET `MovementType` = 2 WHERE `guid` = @NPC;

DELETE FROM `waypoint_data` where `id` = @PATH;
INSERT INTO `waypoint_data` (`id`, `point`, `position_x`, `position_y`, `position_z`, `orientation`, `delay`) VALUES
(@PATH, 1, -10288.3, -785.67, 48.9806, 100.0, 0),
(@PATH, 2, -10328.0, -811.732, 45.3941, 100.0, 0),
(@PATH, 3, -10339.0, -811.817, 46.3963, 100.0, 0),
(@PATH, 4, -10351.8, -803.15, 49.1603, 100.0, 0),
(@PATH, 5, -10369.9, -799.214, 53.3723, 100.0, 0),
(@PATH, 6, -10379.8, -803.096, 50.8648, 100.0, 0),
(@PATH, 7, -10399.0, -822.987, 47.6148, 100.0, 0),
(@PATH, 8, -10400.4, -838.233, 49.7322, 100.0, 0),
(@PATH, 9, -10384.2, -854.297, 45.8654, 100.0, 0),
(@PATH, 10, -10358.5, -879.575, 42.8552, 100.0, 0),
(@PATH, 11, -10339.7, -905.276, 38.3699, 100.0, 0),
(@PATH, 12, -10321.3, -910.707, 38.4765, 100.0, 0),
(@PATH, 13, -10305.2, -895.979, 39.7254, 100.0, 0),
(@PATH, 14, -10290.0, -867.965, 40.6098, 100.0, 0),
(@PATH, 15, -10266.6, -848.708, 41.6361, 100.0, 0),
(@PATH, 16, -10252.6, -829.123, 42.5013, 100.0, 0),
(@PATH, 17, -10242.0, -811.97, 41.2834, 100.0, 0),
(@PATH, 18, -10257.8, -798.468, 44.4208, 100.0, 0),
(@PATH, 19, -10275.7, -782.271, 46.6242, 100.0, 0),
(@PATH, 20, -10278.7, -771.588, 47.5163, 100.0, 0),
(@PATH, 21, -10288.4, -785.682, 48.9411, 100.0, 0);

--
-- END UPDATING QUERIES
--
UPDATE version_db_world SET date = '2022_03_27_03' WHERE sql_rev = '1647450466526877000';
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
