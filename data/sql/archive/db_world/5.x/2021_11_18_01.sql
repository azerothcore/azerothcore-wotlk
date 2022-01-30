-- DB update 2021_11_18_00 -> 2021_11_18_01
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2021_11_18_00';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2021_11_18_00 2021_11_18_01 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1636977376771149000'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1636977376771149000');

SET @BAT_GUID_1  := 201194;
SET @BAT_GUID_2  := 201195;
SET @BAT_GUID_3  := 201196;
SET @BAT_GUID_4  := 201197;
SET @BAT_GUID_5  := 201198;
SET @BAT_GUID_6  := 201199;
SET @BAT_GUID_7  := 201200;
SET @BAT_GUID_8  := 201201;
SET @BAT_GUID_9  := 201202;
SET @BAT_GUID_10 := 201203;
SET @BAT_GUID_11 := 201204;
SET @BAT_GUID_12 := 201205;

SET @PATH_BAT_GUID_1  := @BAT_GUID_1 * 10;
SET @PATH_BAT_GUID_2  := @BAT_GUID_2 * 10;
SET @PATH_BAT_GUID_3  := @BAT_GUID_3 * 10;
SET @PATH_BAT_GUID_4  := @BAT_GUID_4 * 10;
SET @PATH_BAT_GUID_5  := @BAT_GUID_5 * 10;
SET @PATH_BAT_GUID_6  := @BAT_GUID_6 * 10;
SET @PATH_BAT_GUID_7  := @BAT_GUID_7 * 10;
SET @PATH_BAT_GUID_8  := @BAT_GUID_8 * 10;
SET @PATH_BAT_GUID_9  := @BAT_GUID_9 * 10;
SET @PATH_BAT_GUID_10 := @BAT_GUID_10 * 10;
SET @PATH_BAT_GUID_11 := @BAT_GUID_11 * 10;
SET @PATH_BAT_GUID_12 := @BAT_GUID_12 * 10;

SET @BAT_SOUND_ACTION_1:= 849301;
SET @BAT_SOUND_ACTION_2:= 849910;

SET @BAT_MOVE_DELAY := 3000; -- Bats start moving after first bell toll

-- Correct inhabit type and flags for Belfry Bat.
UPDATE `creature_template` SET `InhabitType`=4 WHERE `entry`=10716;        -- Flying
UPDATE `creature_template` SET `unit_flags`=33555200 WHERE `entry`=10716;  -- UNIT_FLAG_IMMUNE_TO_PC | UNIT_FLAG_IMMUNE_TO_NPC | UNIT_FLAG_NOT_SELECTABLE

-- VMangos:
-- UPDATE `creature_template` SET `flags_extra`=33555202 WHERE `entry`=10716; -- 0x2000302 CREATURE_FLAG_EXTRA_CIVILIAN| CREATURE_FLAG_EXTRA_NO_TAUNT | CREATURE_FLAG_EXTRA_NO_MOVE_FLAGS_UPDATE | CREATURE_FLAG_EXTRA_UNUSED_26
-- startup error -> Table `creature_template` lists creature (Entry: 10716) with disallowed `flags_extra` 33554432, removing incorrect flag.

DELETE FROM `creature` WHERE `guid`=@BAT_GUID_1;
DELETE FROM `creature` WHERE `guid`=@BAT_GUID_2;
DELETE FROM `creature` WHERE `guid`=@BAT_GUID_3;
DELETE FROM `creature` WHERE `guid`=@BAT_GUID_4;
DELETE FROM `creature` WHERE `guid`=@BAT_GUID_5;
DELETE FROM `creature` WHERE `guid`=@BAT_GUID_6;
DELETE FROM `creature` WHERE `guid`=@BAT_GUID_7;
DELETE FROM `creature` WHERE `guid`=@BAT_GUID_8;
DELETE FROM `creature` WHERE `guid`=@BAT_GUID_9;
DELETE FROM `creature` WHERE `guid`=@BAT_GUID_10;
DELETE FROM `creature` WHERE `guid`=@BAT_GUID_11;
DELETE FROM `creature` WHERE `guid`=@BAT_GUID_12;

INSERT INTO `creature` (`guid`, `id`, `map`, `zoneId`, `areaId`, `spawnMask`, `phaseMask`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `wander_distance`, `currentwaypoint`, `curhealth`, `curmana`, `MovementType`, `npcflag`, `unit_flags`, `dynamicflags`, `ScriptName`, `VerifiedBuild`) VALUES
(@BAT_GUID_1,  10716, 0, 85, 2118, 1, 1, 0, 0, 2291.84, 292.171, 81.5713, 2.86234 , 60, 0, 0, 1, 0, 2, 0, 0, 0, '', 0),
(@BAT_GUID_2,  10716, 0, 85, 2118, 1, 1, 0, 0, 2290.52, 287.5  , 81.4823, 2.72271 , 60, 0, 0, 1, 0, 2, 0, 0, 0, '', 0),
(@BAT_GUID_3,  10716, 0, 85, 2118, 1, 1, 0, 0, 2293.2 , 296.473, 81.7742, 2.75762 , 60, 0, 0, 1, 0, 2, 0, 0, 0, '', 0),
(@BAT_GUID_4,  10716, 0, 85, 2118, 1, 1, 0, 0, 2295.22, 281.972, 81.7218, 3.97935 , 60, 0, 0, 1, 0, 2, 0, 0, 0, '', 0),
(@BAT_GUID_5,  10716, 0, 85, 2118, 1, 1, 0, 0, 2299.58, 280.706, 81.6103, 4.29351 , 60, 0, 0, 1, 0, 2, 0, 0, 0, '', 0),
(@BAT_GUID_6,  10716, 0, 85, 2118, 1, 1, 0, 0, 2303.57, 279.754, 81.6749, 4.74729 , 60, 0, 0, 1, 0, 2, 0, 0, 0, '', 0),
(@BAT_GUID_7,  10716, 0, 85, 2118, 1, 1, 0, 0, 2309.1 , 282.281, 81.0983, 6.05629 , 60, 0, 0, 1, 0, 2, 0, 0, 0, '', 0),
(@BAT_GUID_8,  10716, 0, 85, 2118, 1, 1, 0, 0, 2309.64, 287.967, 81.852 , 5.91667 , 60, 0, 0, 1, 0, 2, 0, 0, 0, '', 0),
(@BAT_GUID_9,  10716, 0, 85, 2118, 1, 1, 0, 0, 2311.46, 292.325, 81.2885, 0.383972, 60, 0, 0, 1, 0, 2, 0, 0, 0, '', 0),
(@BAT_GUID_10, 10716, 0, 85, 2118, 1, 1, 0, 0, 2308.97, 297.232, 81.7615, 1.22173 , 60, 0, 0, 1, 0, 2, 0, 0, 0, '', 0),
(@BAT_GUID_11, 10716, 0, 85, 2118, 1, 1, 0, 0, 2303.29, 298.127, 82.2253, 1.22173 , 60, 0, 0, 1, 0, 2, 0, 0, 0, '', 0),
(@BAT_GUID_12, 10716, 0, 85, 2118, 1, 1, 0, 0, 2298.5 , 299.817, 81.8604, 0.977384, 60, 0, 0, 1, 0, 2, 0, 0, 0, '', 0); 

DELETE FROM `game_event_creature` WHERE `eventEntry`=73;
-- Add Belfry Bat spawns to Hourly Bells event.
INSERT INTO `game_event_creature` (`eventEntry`, `guid`) VALUES
(73, @BAT_GUID_1),
(73, @BAT_GUID_2),
(73, @BAT_GUID_3),
(73, @BAT_GUID_4),
(73, @BAT_GUID_5),
(73, @BAT_GUID_6),
(73, @BAT_GUID_7),
(73, @BAT_GUID_8),
(73, @BAT_GUID_9),
(73, @BAT_GUID_10),
(73, @BAT_GUID_11),
(73, @BAT_GUID_12);

DELETE FROM `waypoint_data` WHERE `id`= @PATH_BAT_GUID_1;
-- Add waypoints for Belfry Bat @BAT_GUID_1
INSERT INTO `waypoint_data` (`id`, `point`, `position_x`, `position_y`, `position_z`, `orientation`, `delay`, `move_type`, `action`, `action_chance`, `wpguid`) VALUES
(@PATH_BAT_GUID_1, 1,  2291.84, 292.171, 81.5713, 2.86234, @BAT_MOVE_DELAY, 2, 0, 0, 0),                   -- Wait for bell toll
(@PATH_BAT_GUID_1, 2,  2264.929932, 300.329987, 76.030296, 100.000000, 0, 2, @BAT_SOUND_ACTION_1, 100, 0), -- spline 0/11
(@PATH_BAT_GUID_1, 3,  2245.699951, 321.632996, 59.558102, 100.000000, 0, 2, 0, 0, 0),                     -- spline 1/11
(@PATH_BAT_GUID_1, 4,  2227.820068, 320.307007, 60.324600, 100.000000, 0, 2, 0, 0, 0),                     -- spline 2/11
(@PATH_BAT_GUID_1, 5,  2208.379883, 340.748993, 60.324600, 100.000000, 0, 2, 0, 0, 0),                     -- spline 3/11
(@PATH_BAT_GUID_1, 6,  2184.139893, 372.239990, 60.324600, 100.000000, 0, 2, 0, 0, 0),                     -- spline 4/11
(@PATH_BAT_GUID_1, 7,  2180.270020, 386.799988, 60.324600, 100.000000, 0, 2, 0, 0, 0),                     -- spline 5/11
(@PATH_BAT_GUID_1, 8,  2163.419922, 392.268005, 60.324600, 100.000000, 0, 2, 0, 0, 0),                     -- spline 6/11
(@PATH_BAT_GUID_1, 9,  2119.560059, 369.352997, 60.324600, 100.000000, 0, 2, 0, 0, 0),                     -- spline 7/11
(@PATH_BAT_GUID_1, 10,  2096.479980, 331.221985, 69.324600, 100.000000, 0, 2, 0, 0, 0),                    -- spline 8/11
(@PATH_BAT_GUID_1, 11, 2081.800049, 305.434998, 80.074600, 100.000000, 0, 2, 0, 0, 0),                     -- spline 9/11
(@PATH_BAT_GUID_1, 12, 2062.149902, 278.320007, 75.241302, 100.000000, 0, 2, 0, 0, 0),                     -- spline 10/11
(@PATH_BAT_GUID_1, 13, 2058.270020, 272.925995, 68.741302, 100.000000, 60000, 2, 0, 0, 0);                 -- spline 11/11

-- Add sound script
DELETE FROM `waypoint_scripts` WHERE `id`= @BAT_SOUND_ACTION_1;
INSERT INTO `waypoint_scripts` (`id`, `delay`, `command`, `datalong`, `datalong2`, `dataint`, `x`, `y`, `z`, `o`, `guid`) VALUES
(@BAT_SOUND_ACTION_1, 0, 16, 6596 , 2 , 0 , 0 , 0 , 0 , 0 , @BAT_GUID_1);

DELETE FROM `waypoint_data` WHERE `id`= @PATH_BAT_GUID_2;
-- Add waypoints for Belfry Bat @BAT_GUID_2
INSERT INTO `waypoint_data` (`id`, `point`, `position_x`, `position_y`, `position_z`, `orientation`, `delay`, `move_type`, `action`, `action_chance`, `wpguid`) VALUES
(@PATH_BAT_GUID_2, 1,  2290.52, 287.5, 81.4823, 2.72271, @BAT_MOVE_DELAY, 2, 0, 0, 0),     -- Wait for bell toll
(@PATH_BAT_GUID_2, 2,  2266.399902, 299.696014, 76.504501, 100.000000, 0, 2, 0, 0, 0),     -- spline 0/10
(@PATH_BAT_GUID_2, 3,  2249.469971, 319.334991, 66.504501, 100.000000, 0, 2, 0, 0, 0),     -- spline 1/10
(@PATH_BAT_GUID_2, 4,  2225.669922, 327.811005, 58.365601, 100.000000, 0, 2, 0, 0, 0),     -- spline 2/10
(@PATH_BAT_GUID_2, 5,  2212.790039, 354.635986, 58.365601, 100.000000, 0, 2, 0, 0, 0),     -- spline 3/10
(@PATH_BAT_GUID_2, 6,  2188.070068, 387.682007, 58.365601, 100.000000, 0, 2, 0, 0, 0),     -- spline 4/10
(@PATH_BAT_GUID_2, 7,  2152.820068, 398.834991, 58.365601, 100.000000, 0, 2, 0, 0, 0),     -- spline 5/10
(@PATH_BAT_GUID_2, 8,  2108.860107, 381.304993, 58.365601, 100.000000, 0, 2, 0, 0, 0),     -- spline 6/10
(@PATH_BAT_GUID_2, 9,  2094.750000, 337.619995, 67.171204, 100.000000, 0, 2, 0, 0, 0),     -- spline 7/10
(@PATH_BAT_GUID_2, 10,  2085.129883, 303.131989, 80.587898, 100.000000, 0, 2, 0, 0, 0),    -- spline 8/10
(@PATH_BAT_GUID_2, 11, 2064.189941, 284.048004, 78.858200, 100.000000, 0, 2, 0, 0, 0),     -- spline 9/10
(@PATH_BAT_GUID_2, 12, 2058.659912, 276.401001, 68.552597, 100.000000, 60000, 2, 0, 0, 0); -- spline 10/10

DELETE FROM `waypoint_data` WHERE `id`= @PATH_BAT_GUID_3;
-- Add waypoints for Belfry Bat @BAT_GUID_3
INSERT INTO `waypoint_data` (`id`, `point`, `position_x`, `position_y`, `position_z`, `orientation`, `delay`, `move_type`, `action`, `action_chance`, `wpguid`) VALUES
(@PATH_BAT_GUID_3, 1,  2293.2, 296.473, 81.7742, 2.75762, @BAT_MOVE_DELAY, 2, 0, 0, 0),    -- Wait for bell toll
(@PATH_BAT_GUID_3, 2,  2266.489990, 305.485992, 75.808197, 100.000000, 0, 2, 0, 0, 0),     -- spline 0/10
(@PATH_BAT_GUID_3, 3,  2255.949951, 330.838989, 63.058201, 100.000000, 0, 2, 0, 0, 0),     -- spline 1/10
(@PATH_BAT_GUID_3, 4,  2226.149902, 362.273987, 47.752602, 100.000000, 0, 2, 0, 0, 0),     -- spline 2/10
(@PATH_BAT_GUID_3, 5,  2196.439941, 396.825989, 55.349800, 100.000000, 0, 2, 0, 0, 0),     -- spline 3/10
(@PATH_BAT_GUID_3, 6,  2166.129883, 402.358002, 72.002403, 100.000000, 0, 2, 0, 0, 0),     -- spline 4/10
(@PATH_BAT_GUID_3, 7,  2135.909912, 391.731995, 72.002403, 100.000000, 0, 2, 0, 0, 0),     -- spline 5/10
(@PATH_BAT_GUID_3, 8,  2111.649902, 352.752014, 76.335800, 100.000000, 0, 2, 0, 0, 0),     -- spline 6/10
(@PATH_BAT_GUID_3, 9,  2094.030029, 313.950989, 82.502403, 100.000000, 0, 2, 0, 0, 0),     -- spline 7/10
(@PATH_BAT_GUID_3, 10,  2086.229980, 297.226990, 79.280197, 100.000000, 0, 2, 0, 0, 0),    -- spline 8/10
(@PATH_BAT_GUID_3, 11, 2061.229980, 304.009003, 79.280197, 100.000000, 0, 2, 0, 0, 0),     -- spline 9/10
(@PATH_BAT_GUID_3, 12, 2059.000000, 280.492004, 68.085800, 100.000000, 60000, 2, 0, 0, 0); -- spline 10/10

DELETE FROM `waypoint_data` WHERE `id`= @PATH_BAT_GUID_4;
-- Add waypoints for Belfry Bat @BAT_GUID_4
INSERT INTO `waypoint_data` (`id`, `point`, `position_x`, `position_y`, `position_z`, `orientation`, `delay`, `move_type`, `action`, `action_chance`, `wpguid`) VALUES
(@PATH_BAT_GUID_4,  1, 2295.22, 281.972, 81.7218, 3.97935, @BAT_MOVE_DELAY, 2, 0, 0, 0),    -- Wait for bell toll
(@PATH_BAT_GUID_4, 2,  2271.699951, 260.510010, 79.634598, 100.000000, 0, 2, 0, 0, 0),      -- spline 0/9
(@PATH_BAT_GUID_4, 3,  2245.729980, 241.697006, 71.995697, 100.000000, 0, 2, 0, 0, 0),      -- spline 1/9
(@PATH_BAT_GUID_4, 4,  2199.070068, 250.287003, 61.079102, 100.000000, 0, 2, 0, 0, 0),      -- spline 2/9
(@PATH_BAT_GUID_4, 5,  2165.340088, 277.854004, 85.106796, 100.000000, 0, 2, 0, 0, 0),      -- spline 3/9
(@PATH_BAT_GUID_4, 6,  2157.689941, 323.028015, 71.995697, 100.000000, 0, 2, 0, 0, 0),      -- spline 4/9
(@PATH_BAT_GUID_4, 7,  2129.300049, 359.356995, 71.995697, 100.000000, 0, 2, 0, 0, 0),      -- spline 5/9
(@PATH_BAT_GUID_4, 8,  2112.340088, 354.092987, 71.995697, 100.000000, 0, 2, 0, 0, 0),      -- spline 6/9
(@PATH_BAT_GUID_4, 9,  2099.340088, 318.188995, 77.384598, 100.000000, 0, 2, 0, 0, 0),      -- spline 7/9
(@PATH_BAT_GUID_4, 10,  2055.800049, 296.967010, 79.276100, 100.000000, 0, 2, 0, 0, 0),     -- spline 8/9
(@PATH_BAT_GUID_4, 11, 2060.520020, 284.787994, 68.498299, 100.000000, 60000, 2, 0, 0, 0);  -- spline 9/9

DELETE FROM `waypoint_data` WHERE `id`= @PATH_BAT_GUID_5;
-- Add waypoints for Belfry Bat @BAT_GUID_5
INSERT INTO `waypoint_data` (`id`, `point`, `position_x`, `position_y`, `position_z`, `orientation`, `delay`, `move_type`, `action`, `action_chance`, `wpguid`) VALUES
(@PATH_BAT_GUID_5, 1,  2299.58, 280.706, 81.6103, 4.29351, @BAT_MOVE_DELAY, 2, 0, 0, 0),    -- Wait for bell toll
(@PATH_BAT_GUID_5, 2,  2285.689941, 255.447006, 78.652901, 100.000000, 0, 2, 0, 0, 0),      -- spline 0/12
(@PATH_BAT_GUID_5, 3,  2263.810059, 220.705002, 50.069500, 100.000000, 0, 2, 0, 0, 0),      -- spline 1/12
(@PATH_BAT_GUID_5, 4,  2240.590088, 205.897995, 41.402802, 100.000000, 0, 2, 0, 0, 0),      -- spline 2/12
(@PATH_BAT_GUID_5, 5,  2203.679932, 208.694000, 50.315102, 100.000000, 0, 2, 0, 0, 0),      -- spline 3/12
(@PATH_BAT_GUID_5, 6,  2184.360107, 226.690994, 43.870602, 100.000000, 0, 2, 0, 0, 0),      -- spline 4/12
(@PATH_BAT_GUID_5, 7,  2176.790039, 270.209991, 49.703999, 100.000000, 0, 2, 0, 0, 0),      -- spline 5/12
(@PATH_BAT_GUID_5, 8,  2163.310059, 304.420990, 69.681000, 100.000000, 0, 2, 0, 0, 0),      -- spline 6/12
(@PATH_BAT_GUID_5, 9,  2148.449951, 319.838989, 69.681000, 100.000000, 0, 2, 0, 0, 0),      -- spline 7/12
(@PATH_BAT_GUID_5, 10,  2125.100098, 328.727997, 69.681000, 100.000000, 0, 2, 0, 0, 0),     -- spline 8/12
(@PATH_BAT_GUID_5, 11, 2114.310059, 318.783997, 74.264397, 100.000000, 0, 2, 0, 0, 0),      -- spline 9/12
(@PATH_BAT_GUID_5, 12, 2092.639893, 301.253998, 78.403297, 100.000000, 0, 2, 0, 0, 0),      -- spline 10/12
(@PATH_BAT_GUID_5, 13, 2059.010010, 299.459991, 79.209198, 100.000000, 0, 2, 0, 0, 0),      -- spline 11/12
(@PATH_BAT_GUID_5, 14, 2061.620117, 288.808990, 68.431396, 100.000000, 60000, 2, 0, 0, 0);  -- spline 12/12

DELETE FROM `waypoint_data` WHERE `id`= @PATH_BAT_GUID_6;
-- Add waypoints for Belfry Bat @BAT_GUID_6
INSERT INTO `waypoint_data` (`id`, `point`, `position_x`, `position_y`, `position_z`, `orientation`, `delay`, `move_type`, `action`, `action_chance`, `wpguid`) VALUES
(@PATH_BAT_GUID_6, 1,  2303.57, 279.754, 81.6749, 4.74729, @BAT_MOVE_DELAY, 2, 0, 0, 0),    -- Wait for bell toll
(@PATH_BAT_GUID_6, 2,  2311.110107, 239.684006, 76.978600, 100.000000, 0, 2, 0, 0, 0),      -- spline 0/13
(@PATH_BAT_GUID_6, 3,  2292.060059, 209.531998, 51.839699, 100.000000, 0, 2, 0, 0, 0),      -- spline 1/13
(@PATH_BAT_GUID_6, 4,  2257.199951, 197.623993, 39.311901, 100.000000, 0, 2, 0, 0, 0),      -- spline 2/13
(@PATH_BAT_GUID_6, 5,  2216.389893, 194.893997, 48.751301, 100.000000, 0, 2, 0, 0, 0),      -- spline 3/13
(@PATH_BAT_GUID_6, 6,  2199.179932, 184.031998, 54.005199, 100.000000, 0, 2, 0, 0, 0),      -- spline 4/13
(@PATH_BAT_GUID_6, 7,  2191.929932, 184.959000, 54.005199, 100.000000, 0, 2, 0, 0, 0),      -- spline 5/13
(@PATH_BAT_GUID_6, 8,  2184.520020, 193.207001, 54.005199, 100.000000, 0, 2, 0, 0, 0),      -- spline 6/13
(@PATH_BAT_GUID_6, 9,  2162.159912, 233.373993, 54.005199, 100.000000, 0, 2, 0, 0, 0),      -- spline 7/13
(@PATH_BAT_GUID_6, 10,  2159.820068, 282.661987, 63.810699, 100.000000, 0, 2, 0, 0, 0),     -- spline 8/13
(@PATH_BAT_GUID_6, 11, 2134.770020, 300.579987, 79.866302, 100.000000, 0, 2, 0, 0, 0),      -- spline 9/13
(@PATH_BAT_GUID_6, 12, 2110.280029, 296.656006, 79.755302, 100.000000, 0, 2, 0, 0, 0),      -- spline 10/13
(@PATH_BAT_GUID_6, 13, 2083.850098, 304.947998, 79.560799, 100.000000, 0, 2, 0, 0, 0),      -- spline 11/13
(@PATH_BAT_GUID_6, 14, 2063.929932, 307.476013, 79.560799, 100.000000, 0, 2, 0, 0, 0),      -- spline 12/13
(@PATH_BAT_GUID_6, 15, 2063.409912, 290.584991, 70.671799, 100.000000, 60000, 2, 0, 0, 0);  -- spline 13/13

DELETE FROM `waypoint_data` WHERE `id`= @PATH_BAT_GUID_7;
-- Add waypoints for Belfry Bat @BAT_GUID_7
INSERT INTO `waypoint_data` (`id`, `point`, `position_x`, `position_y`, `position_z`, `orientation`, `delay`, `move_type`, `action`, `action_chance`, `wpguid`) VALUES
(@PATH_BAT_GUID_7, 1,  2309.1, 282.281, 81.0983, 6.05629, @BAT_MOVE_DELAY, 2, 0, 0, 0),                    -- Wait for bell toll
(@PATH_BAT_GUID_7, 2,  2338.199951, 263.053986, 76.536903, 100.000000, 0, 2, 0, 0, 0),                     -- spline 0/8
(@PATH_BAT_GUID_7, 3,  2344.889893, 261.101013, 66.342400, 100.000000, 0, 2, 0, 0, 0),                     -- spline 1/8
(@PATH_BAT_GUID_7, 4,  2361.709961, 242.326004, 52.675701, 100.000000, 0, 2, 0, 0, 0),                     -- spline 2/8
(@PATH_BAT_GUID_7, 5,  2349.909912, 220.966995, 47.870201, 100.000000, 0, 2, 0, 0, 0),                     -- spline 3/8
(@PATH_BAT_GUID_7, 6,  2323.969971, 238.057007, 45.064602, 100.000000, 0, 2, 0, 0, 0),                     -- spline 4/8
(@PATH_BAT_GUID_7, 7,  2290.469971, 258.101990, 43.092400, 100.000000, 0, 2, 0, 0, 0),                     -- spline 5/8
(@PATH_BAT_GUID_7, 8,  2247.540039, 281.933014, 43.092400, 100.000000, 0, 2, 0, 0, 0),                     -- spline 6/8
(@PATH_BAT_GUID_7, 9,  2212.919922, 296.894989, 45.647999, 100.000000, 0, 2, 0, 0, 0),                     -- spline 7/8
(@PATH_BAT_GUID_7, 10,  2181.479980, 318.591003, 46.897999, 100.000000, 0, 2, 0, 0, 0),                    -- spline 8/8
(@PATH_BAT_GUID_7, 11, 2144.870117, 327.882996, 71.922401, 100.000000, 0, 2, @BAT_SOUND_ACTION_2, 100, 0), -- spline 0/3
(@PATH_BAT_GUID_7, 12, 2110.179932, 313.437988, 88.172501, 100.000000, 0, 2, 0, 0, 0),                     -- spline 1/3
(@PATH_BAT_GUID_7, 13, 2101.520020, 321.703003, 79.090698, 100.000000, 0, 2, 0, 0, 0),                     -- spline 2/3
(@PATH_BAT_GUID_7, 14, 2071.030029, 289.042999, 70.729599, 100.000000, 60000, 2, 0, 0, 0);                 -- spline 3/3

-- Add sound script
DELETE FROM `waypoint_scripts` WHERE `id`= @BAT_SOUND_ACTION_2;
INSERT INTO `waypoint_scripts` (`id`, `delay`, `command`, `datalong`, `datalong2`, `dataint`, `x`, `y`, `z`, `o`, `guid`) VALUES
(@BAT_SOUND_ACTION_2, 0, 16, 6596 , 2 , 0 , 0 , 0 , 0 , 0 , @BAT_GUID_7);

DELETE FROM `waypoint_data` WHERE `id`= @PATH_BAT_GUID_8;
-- Add waypoints for Belfry Bat @BAT_GUID_8
INSERT INTO `waypoint_data` (`id`, `point`, `position_x`, `position_y`, `position_z`, `orientation`, `delay`, `move_type`, `action`, `action_chance`, `wpguid`) VALUES
(@PATH_BAT_GUID_8, 1,  2309.64, 287.967, 81.852, 5.91667, @BAT_MOVE_DELAY, 2, 0, 0, 0),     -- Wait for bell toll
(@PATH_BAT_GUID_8, 2,  2335.419922, 270.260986, 79.447502, 100.000000, 0, 2, 0, 0, 0),      -- spline 0/13
(@PATH_BAT_GUID_8, 3,  2342.520020, 265.394989, 79.447502, 100.000000, 0, 2, 0, 0, 0),      -- spline 1/13
(@PATH_BAT_GUID_8, 4,  2341.580078, 253.927002, 79.447502, 100.000000, 0, 2, 0, 0, 0),      -- spline 2/13
(@PATH_BAT_GUID_8, 5,  2324.810059, 240.490997, 79.447502, 100.000000, 0, 2, 0, 0, 0),      -- spline 3/13
(@PATH_BAT_GUID_8, 6,  2297.620117, 255.063995, 79.447502, 100.000000, 0, 2, 0, 0, 0),      -- spline 4/13
(@PATH_BAT_GUID_8, 7,  2268.709961, 283.138000, 62.280800, 100.000000, 0, 2, 0, 0, 0),      -- spline 5/13
(@PATH_BAT_GUID_8, 8,  2252.810059, 312.338989, 49.864101, 100.000000, 0, 2, 0, 0, 0),      -- spline 6/13
(@PATH_BAT_GUID_8, 9,  2242.409912, 346.750000, 43.141899, 100.000000, 0, 2, 0, 0, 0),      -- spline 7/13
(@PATH_BAT_GUID_8, 10,  2206.449951, 368.545990, 45.614101, 100.000000, 0, 2, 0, 0, 0),     -- spline 8/13
(@PATH_BAT_GUID_8, 11, 2166.879883, 368.070007, 71.656403, 100.000000, 0, 2, 0, 0, 0),      -- spline 9/13
(@PATH_BAT_GUID_8, 12, 2125.270020, 340.610992, 76.989700, 100.000000, 0, 2, 0, 0, 0),      -- spline 10/13
(@PATH_BAT_GUID_8, 13, 2103.600098, 308.622009, 80.017502, 100.000000, 0, 2, 0, 0, 0),      -- spline 11/13
(@PATH_BAT_GUID_8, 14, 2085.139893, 299.303986, 79.350800, 100.000000, 0, 2, 0, 0, 0),      -- spline 12/13
(@PATH_BAT_GUID_8, 15, 2073.129883, 286.395996, 68.628601, 100.000000, 60000, 2, 0, 0, 0);  -- spline 13/13

DELETE FROM `waypoint_data` WHERE `id`= @PATH_BAT_GUID_9;
-- Add waypoints for Belfry Bat @BAT_GUID_9
INSERT INTO `waypoint_data` (`id`, `point`, `position_x`, `position_y`, `position_z`, `orientation`, `delay`, `move_type`, `action`, `action_chance`, `wpguid`) VALUES
(@PATH_BAT_GUID_9, 1,  2311.46, 292.325, 81.2885, 0.383972, @BAT_MOVE_DELAY, 2, 0, 0, 0),   -- Wait for bell toll
(@PATH_BAT_GUID_9, 2,  2341.199951, 315.338989, 92.903099, 100.000000, 0, 2, 0, 0, 0),      -- spline 0/13
(@PATH_BAT_GUID_9, 3,  2346.010010, 334.989014, 92.903099, 100.000000, 0, 2, 0, 0, 0),      -- spline 1/13
(@PATH_BAT_GUID_9, 4,  2332.449951, 368.037994, 64.153000, 100.000000, 0, 2, 0, 0, 0),      -- spline 2/13
(@PATH_BAT_GUID_9, 5,  2295.639893, 383.843994, 48.264000, 100.000000, 0, 2, 0, 0, 0),      -- spline 3/13
(@PATH_BAT_GUID_9, 6,  2263.879883, 364.484985, 44.791801, 100.000000, 0, 2, 0, 0, 0),      -- spline 4/13
(@PATH_BAT_GUID_9, 7,  2244.020020, 354.554993, 41.930599, 100.000000, 0, 2, 0, 0, 0),      -- spline 5/13
(@PATH_BAT_GUID_9, 8,  2227.370117, 352.993988, 41.930599, 100.000000, 0, 2, 0, 0, 0),      -- spline 6/13
(@PATH_BAT_GUID_9, 9,  2219.439941, 372.144012, 49.652802, 100.000000, 0, 2, 0, 0, 0),      -- spline 7/13
(@PATH_BAT_GUID_9, 10,  2178.169922, 360.458008, 63.541698, 100.000000, 0, 2, 0, 0, 0),     -- spline 8/13
(@PATH_BAT_GUID_9, 11, 2142.389893, 329.195007, 78.597298, 100.000000, 0, 2, 0, 0, 0),      -- spline 9/13
(@PATH_BAT_GUID_9, 12, 2103.120117, 304.903992, 80.958397, 100.000000, 0, 2, 0, 0, 0),      -- spline 10/13
(@PATH_BAT_GUID_9, 13, 2102.169922, 281.625000, 79.625099, 100.000000, 0, 2, 0, 0, 0),      -- spline 11/13
(@PATH_BAT_GUID_9, 14, 2087.820068, 280.266998, 72.486198, 100.000000, 0, 2, 0, 0, 0),      -- spline 12/13
(@PATH_BAT_GUID_9, 15, 2073.350098, 281.459015, 68.402802, 100.000000, 60000, 2, 0, 0, 0);  -- spline 13/13

DELETE FROM `waypoint_data` WHERE `id`= @PATH_BAT_GUID_10;
-- Add waypoints for Belfry Bat @BAT_GUID_10
INSERT INTO `waypoint_data` (`id`, `point`, `position_x`, `position_y`, `position_z`, `orientation`, `delay`, `move_type`, `action`, `action_chance`, `wpguid`) VALUES
(@PATH_BAT_GUID_10, 1,  2308.97, 297.232, 81.7615, 1.22173, @BAT_MOVE_DELAY, 2, 0, 0, 0),    -- Wait for bell toll
(@PATH_BAT_GUID_10, 2,  2317.389893, 324.369995, 87.687500, 100.000000, 0, 2, 0, 0, 0),      -- spline 0/10
(@PATH_BAT_GUID_10, 3,  2319.510010, 352.401001, 98.159698, 100.000000, 0, 2, 0, 0, 0),      -- spline 1/10
(@PATH_BAT_GUID_10, 4,  2314.949951, 369.937988, 89.298599, 100.000000, 0, 2, 0, 0, 0),      -- spline 2/10
(@PATH_BAT_GUID_10, 5,  2298.729980, 382.324005, 78.242996, 100.000000, 0, 2, 0, 0, 0),      -- spline 3/10
(@PATH_BAT_GUID_10, 6,  2255.229980, 406.108002, 74.326302, 100.000000, 0, 2, 0, 0, 0),      -- spline 4/10
(@PATH_BAT_GUID_10, 7,  2213.989990, 403.273987, 68.409698, 100.000000, 0, 2, 0, 0, 0),      -- spline 5/10
(@PATH_BAT_GUID_10, 8,  2180.020020, 376.944000, 72.020798, 100.000000, 0, 2, 0, 0, 0),      -- spline 6/10
(@PATH_BAT_GUID_10, 9,  2145.969971, 346.626007, 91.992996, 100.000000, 0, 2, 0, 0, 0),      -- spline 7/10
(@PATH_BAT_GUID_10, 10,  2106.560059, 315.518005, 93.631897, 100.000000, 0, 2, 0, 0, 0),     -- spline 8/10
(@PATH_BAT_GUID_10, 11, 2088.439941, 276.399994, 79.492996, 100.000000, 0, 2, 0, 0, 0),      -- spline 9/10
(@PATH_BAT_GUID_10, 12, 2070.790039, 277.661011, 68.381897, 100.000000, 60000, 2, 0, 0, 0);  -- spline 10/10

DELETE FROM `waypoint_data` WHERE `id`= @PATH_BAT_GUID_11;
-- Add waypoints for Belfry Bat @BAT_GUID_11
INSERT INTO `waypoint_data` (`id`, `point`, `position_x`, `position_y`, `position_z`, `orientation`, `delay`, `move_type`, `action`, `action_chance`, `wpguid`) VALUES
(@PATH_BAT_GUID_11, 1,  2303.29, 298.127, 82.2253, 1.22173, @BAT_MOVE_DELAY, 2, 0, 0, 0),    -- Wait for bell toll
(@PATH_BAT_GUID_11, 2,  2320.830078, 333.566986, 84.623398, 100.000000, 0, 2, 0, 0, 0),      -- spline 0/16
(@PATH_BAT_GUID_11, 3,  2337.030029, 353.589996, 84.623398, 100.000000, 0, 2, 0, 0, 0),      -- spline 1/16
(@PATH_BAT_GUID_11, 4,  2342.090088, 369.609985, 70.484497, 100.000000, 0, 2, 0, 0, 0),      -- spline 2/16
(@PATH_BAT_GUID_11, 5,  2318.000000, 392.368011, 60.067799, 100.000000, 0, 2, 0, 0, 0),      -- spline 3/16
(@PATH_BAT_GUID_11, 6,  2288.770020, 379.468994, 44.845600, 100.000000, 0, 2, 0, 0, 0),      -- spline 4/16
(@PATH_BAT_GUID_11, 7,  2275.840088, 340.661011, 41.706699, 100.000000, 0, 2, 0, 0, 0),      -- spline 5/16
(@PATH_BAT_GUID_11, 8,  2259.179932, 303.696014, 40.373402, 100.000000, 0, 2, 0, 0, 0),      -- spline 6/16
(@PATH_BAT_GUID_11, 9,  2235.239990, 273.893005, 47.317799, 100.000000, 0, 2, 0, 0, 0),      -- spline 7/16
(@PATH_BAT_GUID_11, 10,  2202.870117, 260.562012, 59.873299, 100.000000, 0, 2, 0, 0, 0),     -- spline 8/16
(@PATH_BAT_GUID_11, 11, 2160.820068, 255.893005, 84.623398, 100.000000, 0, 2, 0, 0, 0),      -- spline 9/16
(@PATH_BAT_GUID_11, 12, 2128.030029, 276.407990, 78.512299, 100.000000, 0, 2, 0, 0, 0),      -- spline 10/16
(@PATH_BAT_GUID_11, 13, 2138.469971, 298.958008, 84.623398, 100.000000, 0, 2, 0, 0, 0),      -- spline 11/16
(@PATH_BAT_GUID_11, 14, 2128.320068, 327.652008, 101.651001, 100.000000, 0, 2, 0, 0, 0),     -- spline 12/16
(@PATH_BAT_GUID_11, 15, 2114.159912, 327.721008, 98.567902, 100.000000, 0, 2, 0, 0, 0),      -- spline 13/16
(@PATH_BAT_GUID_11, 16, 2101.719971, 303.272003, 90.040100, 100.000000, 0, 2, 0, 0, 0),      -- spline 14/16
(@PATH_BAT_GUID_11, 17, 2079.030029, 302.569000, 79.456703, 100.000000, 0, 2, 0, 0, 0),      -- spline 15/16
(@PATH_BAT_GUID_11, 18, 2070.139893, 274.324005, 68.484497, 100.000000, 60000, 2, 0, 0, 0);  -- spline 16/16

DELETE FROM `waypoint_data` WHERE `id`= @PATH_BAT_GUID_12;
-- Add waypoints for Belfry Bat @BAT_GUID_12
INSERT INTO `waypoint_data` (`id`, `point`, `position_x`, `position_y`, `position_z`, `orientation`, `delay`, `move_type`, `action`, `action_chance`, `wpguid`) VALUES
(@PATH_BAT_GUID_12, 1,  2298.5, 299.817, 81.8604, 0.977384, @BAT_MOVE_DELAY, 2, 0, 0, 0),   -- Wait for bell toll
(@PATH_BAT_GUID_12, 2,  2318.800049, 334.148987, 78.170601, 100.000000, 0, 2, 0, 0, 0),     -- spline 0/14
(@PATH_BAT_GUID_12, 3,  2342.189941, 358.182007, 78.170601, 100.000000, 0, 2, 0, 0, 0),     -- spline 1/14
(@PATH_BAT_GUID_12, 4,  2343.439941, 401.080994, 87.615097, 100.000000, 0, 2, 0, 0, 0),     -- spline 2/14
(@PATH_BAT_GUID_12, 5,  2322.850098, 445.485992, 78.170601, 100.000000, 0, 2, 0, 0, 0),     -- spline 3/14
(@PATH_BAT_GUID_12, 6,  2296.310059, 453.006989, 72.281700, 100.000000, 0, 2, 0, 0, 0),     -- spline 4/14
(@PATH_BAT_GUID_12, 7,  2266.729980, 428.024994, 60.309502, 100.000000, 0, 2, 0, 0, 0),     -- spline 5/14
(@PATH_BAT_GUID_12, 8,  2232.300049, 413.587006, 73.726196, 100.000000, 0, 2, 0, 0, 0),     -- spline 6/14
(@PATH_BAT_GUID_12, 9,  2188.090088, 402.131989, 86.976196, 100.000000, 0, 2, 0, 0, 0),     -- spline 7/14
(@PATH_BAT_GUID_12, 10, 2141.080078, 394.648987, 71.726097, 100.000000, 0, 2, 0, 0, 0),     -- spline 8/14
(@PATH_BAT_GUID_12, 11, 2118.989990, 353.406006, 78.170601, 100.000000, 0, 2, 0, 0, 0),     -- spline 9/14
(@PATH_BAT_GUID_12, 12, 2107.399902, 322.726990, 87.392799, 100.000000, 0, 2, 0, 0, 0),     -- spline 10/14
(@PATH_BAT_GUID_12, 13, 2083.290039, 311.605011, 81.753899, 100.000000, 0, 2, 0, 0, 0),     -- spline 11/14
(@PATH_BAT_GUID_12, 14, 2065.270020, 304.687988, 75.281700, 100.000000, 0, 2, 0, 0, 0),     -- spline 12/14
(@PATH_BAT_GUID_12, 15, 2062.120117, 283.634003, 75.281700, 100.000000, 0, 2, 0, 0, 0),     -- spline 13/14
(@PATH_BAT_GUID_12, 16, 2069.189941, 269.863007, 68.976097, 100.000000, 60000, 2, 0, 0, 0); -- spline 14/14

-- Assign waypoints for Belfry Bats
DELETE FROM `creature_addon` WHERE `guid`=@BAT_GUID_1;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes1`,`bytes2`,`emote`,`visibilityDistanceType`, `auras`) VALUES (@BAT_GUID_1, @PATH_BAT_GUID_1, 0, 0, 0 , 0, 3, '');
DELETE FROM `creature_addon` WHERE `guid`=@BAT_GUID_2;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes1`,`bytes2`,`emote`,`visibilityDistanceType`, `auras`) VALUES (@BAT_GUID_2, @PATH_BAT_GUID_2, 0, 0, 0 , 0, 3, '');
DELETE FROM `creature_addon` WHERE `guid`=@BAT_GUID_3;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes1`,`bytes2`,`emote`,`visibilityDistanceType`, `auras`) VALUES (@BAT_GUID_3, @PATH_BAT_GUID_3, 0, 0, 0 , 0, 3, '');
DELETE FROM `creature_addon` WHERE `guid`=@BAT_GUID_4;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes1`,`bytes2`,`emote`,`visibilityDistanceType`, `auras`) VALUES (@BAT_GUID_4, @PATH_BAT_GUID_4, 0, 0, 0 , 0, 3, '');
DELETE FROM `creature_addon` WHERE `guid`=@BAT_GUID_5;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes1`,`bytes2`,`emote`,`visibilityDistanceType`, `auras`) VALUES (@BAT_GUID_5, @PATH_BAT_GUID_5, 0, 0, 0 , 0, 3, '');
DELETE FROM `creature_addon` WHERE `guid`=@BAT_GUID_6;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes1`,`bytes2`,`emote`,`visibilityDistanceType`, `auras`) VALUES (@BAT_GUID_6, @PATH_BAT_GUID_6, 0, 0, 0 , 0, 3, '');
DELETE FROM `creature_addon` WHERE `guid`=@BAT_GUID_7;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes1`,`bytes2`,`emote`,`visibilityDistanceType`, `auras`) VALUES (@BAT_GUID_7, @PATH_BAT_GUID_7, 0, 0, 0 , 0, 3, '');
DELETE FROM `creature_addon` WHERE `guid`=@BAT_GUID_8;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes1`,`bytes2`,`emote`,`visibilityDistanceType`, `auras`) VALUES (@BAT_GUID_8, @PATH_BAT_GUID_8, 0, 0, 0 , 0, 3, '');
DELETE FROM `creature_addon` WHERE `guid`=@BAT_GUID_9;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes1`,`bytes2`,`emote`,`visibilityDistanceType`, `auras`) VALUES (@BAT_GUID_9, @PATH_BAT_GUID_9, 0, 0, 0 , 0, 3, '');
DELETE FROM `creature_addon` WHERE `guid`=@BAT_GUID_10;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes1`,`bytes2`,`emote`,`visibilityDistanceType`, `auras`) VALUES (@BAT_GUID_10, @PATH_BAT_GUID_10, 0, 0, 0 , 0, 3, '');
DELETE FROM `creature_addon` WHERE `guid`=@BAT_GUID_11;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes1`,`bytes2`,`emote`,`visibilityDistanceType`, `auras`) VALUES (@BAT_GUID_11, @PATH_BAT_GUID_11, 0, 0, 0 , 0, 3, '');
DELETE FROM `creature_addon` WHERE `guid`=@BAT_GUID_12;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes1`,`bytes2`,`emote`,`visibilityDistanceType`, `auras`) VALUES (@BAT_GUID_12, @PATH_BAT_GUID_12, 0, 0, 0 , 0, 3, '');

--
-- END UPDATING QUERIES
--
UPDATE version_db_world SET date = '2021_11_18_01' WHERE sql_rev = '1636977376771149000';
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
