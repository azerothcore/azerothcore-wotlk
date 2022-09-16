-- DB update 2022_01_11_04 -> 2022_01_11_05
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2022_01_11_04';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2022_01_11_04 2022_01_11_05 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1641924478819152116'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1641924478819152116');

-- Winterfall, Tmbermaw Post, & Frostfire Hot Springs, Winterspring

-- High Chief Winterfall & Winterfall Shaman follower in Cave (2 of 2)
DELETE FROM `creature` WHERE `guid` IN (41033,42315);
DELETE FROM `creature_addon` WHERE `guid` IN (41033);
INSERT INTO `creature` (`guid`,`creature_id1`,`creature_id2`,`chance_id1`,`map`,`zoneId`,`areaId`,`spawnMask`,`phaseMask`,`equipment_id`,`position_x`,`position_y`,`position_z`,`orientation`,`spawntimesecs`,`wander_distance`,`currentwaypoint`,`curhealth`,`curmana`,`MovementType`,`npcflag`,`unit_flags`,`dynamicflags`,`ScriptName`,`VerifiedBuild`) VALUES
(41033, 7439, 0, 100, 1, 0, 0, 1, 1, 0, 6721.2236, -5278.3413, 779.2601, 0.959931075572967529, 300, 0, 0, 1, 0, 0, 0, 0, 0, '', 0),
(42315, 10738, 0, 100, 1, 0, 0, 1, 1, 0, 6725.0884, -5277.6865, 778.6381, 1.867502331733703613, 300, 0, 0, 1, 0, 2, 0, 0, 0, '', 0);

-- Winterfall Ursa spawn points (7 of 7)
DELETE FROM `creature` WHERE `guid` IN (41017,41018,41020,41021,41022,41023,41019);
DELETE FROM `creature_addon` WHERE `guid` IN (41017,41018,41020,41021,41022,41023,41019);
INSERT INTO `creature` (`guid`,`creature_id1`,`creature_id2`,`chance_id1`,`map`,`zoneId`,`areaId`,`spawnMask`,`phaseMask`,`equipment_id`,`position_x`,`position_y`,`position_z`,`orientation`,`spawntimesecs`,`wander_distance`,`currentwaypoint`,`curhealth`,`curmana`,`MovementType`,`npcflag`,`unit_flags`,`dynamicflags`,`ScriptName`,`VerifiedBuild`) VALUES
(41017, 7438, 0, 100, 1, 0, 0, 1, 1, 0, 6747.0747, -4953.191, 771.3372, 1.119596242904663085, 300, 5, 0, 1, 0, 1, 0, 0, 0, '', 0),
(41018, 7438, 0, 100, 1, 0, 0, 1, 1, 0, 6667.7363, -5122.807, 780.1929, 0.105937860906124114, 300, 2, 0, 1, 0, 1, 0, 0, 0, '', 0),
(41020, 7438, 0, 100, 1, 0, 0, 1, 1, 0, 6780.801, -4955.6167, 761.73047, 4.427132606506347656, 300, 8, 0, 1, 0, 1, 0, 0, 0, '', 0),
(41021, 7438, 0, 100, 1, 0, 0, 1, 1, 0, 6646.41, -5083.277, 791.952, 1.214711427688598632, 300, 2, 0, 1, 0, 1, 0, 1, 0, '', 0),
(41022, 7438, 0, 100, 1, 0, 0, 1, 1, 0, 6720.027, -5013.563, 766.31665, 4.593924522399902343, 300, 5, 0, 1, 0, 1, 0, 0, 0, '', 0),
(41023, 7438, 0, 100, 1, 0, 0, 1, 1, 0, 6750.9517, -4982.4316, 774.3095, 6.040516853332519531, 300, 8, 0, 1, 0, 1, 0, 0, 0, '', 0),
(41019, 7438, 0, 100, 1, 0, 0, 1, 1, 0, 6683.7603, -5047.8804, 780.60803, 0.122173048555850982, 300, 5, 0, 1, 0, 1, 0, 0, 0, '', 0);

-- Winterfall Ursa or Winterfall Shaman spawn points (7 of 7)
DELETE FROM `creature` WHERE `guid` IN (41024,41025,41026,41027,41028,41031,41032);
DELETE FROM `creature_addon` WHERE `guid` IN (41024,41025,41026,41027,41028,41031,41032);
INSERT INTO `creature` (`guid`,`creature_id1`,`creature_id2`,`chance_id1`,`map`,`zoneId`,`areaId`,`spawnMask`,`phaseMask`,`equipment_id`,`position_x`,`position_y`,`position_z`,`orientation`,`spawntimesecs`,`wander_distance`,`currentwaypoint`,`curhealth`,`curmana`,`MovementType`,`npcflag`,`unit_flags`,`dynamicflags`,`ScriptName`,`VerifiedBuild`) VALUES
(41024, 7438, 7439, 50, 1, 0, 0, 1, 1, 0, 6780.277, -5049.571, 722.91614, 3.535489320755004882, 300, 1, 0, 1, 0, 1, 0, 0, 0, '', 0),
(41025, 7438, 7439, 50, 1, 0, 0, 1, 1, 0, 6779.971, -5061.6704, 722.91846, 0.001158748054876923, 300, 1, 0, 1, 0, 1, 0, 0, 0, '', 0),
(41026, 7438, 7439, 50, 1, 0, 0, 1, 1, 0, 6788.6978, -5150.9565, 731.9286, 1.842814087867736816, 300, 1, 0, 1, 0, 1, 0, 0, 0, '', 0),
(41027, 7438, 7439, 50, 1, 0, 0, 1, 1, 0, 6742.4766, -5201.8013, 761.6196, 6.039949417114257812, 300, 1, 0, 1, 0, 1, 0, 0, 0, '', 0),
(41028, 7438, 7439, 50, 1, 0, 0, 1, 1, 0, 6740.707, -5139.568, 729.9377, 4.78220224380493164, 300, 1, 0, 1, 0, 1, 0, 0, 0, '', 0),
(41031, 7438, 7439, 50, 1, 0, 0, 1, 1, 0, 6731.888, -5134.971, 733.1043, 1.870866894721984863, 300, 1, 0, 1, 0, 1, 0, 0, 0, '', 0),
(41032, 7438, 7439, 50, 1, 0, 0, 1, 1, 0, 6786.4136, -5161.687, 732.9416, 6.021045207977294921, 300, 1, 0, 1, 0, 1, 0, 0, 0, '', 0);

-- Winterfall Winterfall Shaman / Winterfall Den Watcher spawn points (7 of 7)
DELETE FROM `creature` WHERE `guid` IN (41029,41030,41034,41044,41047,41048,41049);
DELETE FROM `creature_addon` WHERE `guid` IN (41030,41034,41047,41048,41049);
INSERT INTO `creature` (`guid`,`creature_id1`,`creature_id2`,`chance_id1`,`map`,`zoneId`,`areaId`,`spawnMask`,`phaseMask`,`equipment_id`,`position_x`,`position_y`,`position_z`,`orientation`,`spawntimesecs`,`wander_distance`,`currentwaypoint`,`curhealth`,`curmana`,`MovementType`,`npcflag`,`unit_flags`,`dynamicflags`,`ScriptName`,`VerifiedBuild`) VALUES
(41029, 7439, 7440, 50, 1, 0, 0, 1, 1, 0, 6764.6, -4958.81, 768.4835, 3.979350566864013671, 300, 0, 0, 1, 0, 2, 0, 0, 0, '', 0),
(41030, 7439, 7440, 50, 1, 0, 0, 1, 1, 0, 6865.507, -5099.4946, 692.72516, 2.463026285171508789, 300, 1, 0, 1, 0, 1, 0, 0, 0, '', 0),
(41034, 7439, 7440, 50, 1, 0, 0, 1, 1, 0, 6845.324, -5115.655, 694.40393, 0.171919405460357666, 300, 1, 0, 1, 0, 1, 0, 0, 0, '', 0),
(41044, 7439, 7440, 50, 1, 0, 0, 1, 1, 0, 6898.3477, -5155.1655, 698.56287, 0.196150228381156921, 300, 0, 0, 1, 0, 2, 0, 0, 0, '', 0),
(41047, 7439, 7440, 50, 1, 0, 0, 1, 1, 0, 6818.078, -5083.1216, 693.5647, 0.789418816566467285, 300, 1, 0, 1, 0, 1, 0, 0, 0, '', 0),
(41048, 7439, 7440, 50, 1, 0, 0, 1, 1, 0, 6833.815, -5108.7603, 693.60394, 5.846852779388427734, 300, 1, 0, 1, 0, 1, 0, 0, 0, '', 0),
(41049, 7439, 7440, 50, 1, 0, 0, 1, 1, 0, 6833.1377, -5041.561, 690.78424, 1.365088462829589843, 300, 1, 0, 1, 0, 1, 0, 0, 0, '', 0);

-- Winterfall Den Watcher spawn points (7 of 7)
DELETE FROM `creature` WHERE `guid` IN (41035,41037,41041,41042,41043,41045,41046);
DELETE FROM `creature_addon` WHERE `guid` IN (41035,41037,41041,41042,41043,41045,41046);
INSERT INTO `creature` (`guid`,`creature_id1`,`creature_id2`,`chance_id1`,`map`,`zoneId`,`areaId`,`spawnMask`,`phaseMask`,`equipment_id`,`position_x`,`position_y`,`position_z`,`orientation`,`spawntimesecs`,`wander_distance`,`currentwaypoint`,`curhealth`,`curmana`,`MovementType`,`npcflag`,`unit_flags`,`dynamicflags`,`ScriptName`,`VerifiedBuild`) VALUES
(41035, 7440, 0, 100, 1, 0, 0, 1, 1, 0, 6914.6646, -5149.913, 696.0513, 1.166961431503295898, 300, 8, 0, 1, 0, 1, 0, 0, 0, '', 0),
(41037, 7440, 0, 100, 1, 0, 0, 1, 1, 0, 6883.6367, -4985.5376, 696.6467, 5.365018844604492187, 300, 8, 0, 1, 0, 1, 0, 0, 0, '', 0),
(41041, 7440, 0, 100, 1, 0, 0, 1, 1, 0, 6914.2114, -5016.2363, 692.7734, 3.098602533340454101, 300, 8, 0, 1, 0, 1, 0, 0, 0, '', 0),
(41042, 7440, 0, 100, 1, 0, 0, 1, 1, 0, 6853.5635, -5015.462, 694.4994, 0.699617505073547363, 300, 8, 0, 1, 0, 1, 0, 0, 0, '', 0),
(41043, 7440, 0, 100, 1, 0, 0, 1, 1, 0, 6917.2134, -5082.1694, 695.1275, 1.087926626205444335, 300, 8, 0, 1, 0, 1, 0, 0, 0, '', 0),
(41045, 7440, 0, 100, 1, 0, 0, 1, 1, 0, 6849.342, -5149.7134, 706.1964, 2.529907464981079101, 300, 3, 0, 1, 0, 1, 0, 0, 0, '', 0),
(41046, 7440, 0, 100, 1, 0, 0, 1, 1, 0, 6878.815, -5190.052, 728.32153, 3.797288417816162109, 300, 3, 0, 1, 0, 1, 0, 0, 0, '', 0);

-- Winterfall Pathfinders spawn points (19 of 19)
DELETE FROM `creature` WHERE `guid` IN (41065,41066,41067,41068,41069,41070,41071,41072,41073,41074,41075,41076,41077,41078,41079,41080,41081,41082,41083);
DELETE FROM `creature_addon` WHERE `guid` IN (41065,41066,41067,41068,41069,41070,41071,41072,41073,41074,41075,41076,41077,41078,41079,41080,41081,41082,41083);
INSERT INTO `creature` (`guid`,`creature_id1`,`creature_id2`,`chance_id1`,`map`,`zoneId`,`areaId`,`spawnMask`,`phaseMask`,`equipment_id`,`position_x`,`position_y`,`position_z`,`orientation`,`spawntimesecs`,`wander_distance`,`currentwaypoint`,`curhealth`,`curmana`,`MovementType`,`npcflag`,`unit_flags`,`dynamicflags`,`ScriptName`,`VerifiedBuild`) VALUES
(41065, 7442, 0, 100, 1, 0, 0, 1, 1, 1, 6418.1475, -3282.707, 594.6316, 0.814349532127380371, 300, 10, 0, 1, 0, 1, 0, 0, 0, '', 0),
(41066, 7442, 0, 100, 1, 0, 0, 1, 1, 1, 6449.6807, -3319, 588.16724, 1.204253435134887695, 300, 10, 0, 1, 0, 1, 0, 0, 0, '', 0),
(41067, 7442, 0, 100, 1, 0, 0, 1, 1, 1, 6493.3228, -3349.8264, 595.2726, 4.595508575439453125, 300, 4, 0, 1, 0, 1, 0, 0, 0, '', 0),
(41068, 7442, 0, 100, 1, 0, 0, 1, 1, 1, 6886.6616, -2516.4062, 584.2431, 0.599785089492797851, 300, 5, 0, 1, 0, 1, 0, 0, 0, '', 0),
(41069, 7442, 0, 100, 1, 0, 0, 1, 1, 1, 6881.9863, -2547.183, 591.8122, 5.1137542724609375, 300, 5, 0, 1, 0, 1, 0, 0, 0, '', 0),
(41070, 7442, 0, 100, 1, 0, 0, 1, 1, 1, 6450.3394, -3217.9045, 574.9307, 0.172744855284690856, 300, 10, 0, 1, 0, 1, 0, 0, 0, '', 0),
(41071, 7442, 0, 100, 1, 0, 0, 1, 1, 1, 6483.469, -3250.0137, 571.9422, 5.45286417007446289, 300, 10, 0, 1, 0, 1, 0, 0, 0, '', 0),
(41072, 7442, 0, 100, 1, 0, 0, 1, 1, 1, 6509.655, -3083.658, 594.20154, 5.431609630584716796, 300, 8, 0, 1, 0, 1, 0, 0, 0, '', 0),
(41073, 7442, 0, 100, 1, 0, 0, 1, 1, 1, 6515.28, -3183.9634, 573.33575, 0.710796356201171875, 300, 10, 0, 1, 0, 1, 0, 0, 0, '', 0),
(41074, 7442, 0, 100, 1, 0, 0, 1, 1, 1, 6516.794, -3214.0642, 572.25275, 0.488046348094940185, 300, 10, 0, 1, 0, 1, 0, 0, 0, '', 0),
(41075, 7442, 0, 100, 1, 0, 0, 1, 1, 1, 6518.047, -3318.8777, 578.84125, 3.801404714584350585, 300, 10, 0, 1, 0, 1, 0, 0, 0, '', 0),
(41076, 7442, 0, 100, 1, 0, 0, 1, 1, 1, 6783.3003, -2516.5417, 551.8681, 3.066561460494995117, 300, 10, 0, 1, 0, 1, 0, 0, 0, '', 0),
(41077, 7442, 0, 100, 1, 0, 0, 1, 1, 1, 6782.938, -2783.0176, 579.7641, 3.598474979400634765, 300, 10, 0, 1, 0, 1, 0, 0, 0, '', 0),
(41078, 7442, 0, 100, 1, 0, 0, 1, 1, 1, 6781.871, -2715.4636, 562.8753, 5.628547191619873046, 300, 10, 0, 1, 0, 1, 0, 0, 0, '', 0),
(41079, 7442, 0, 100, 1, 0, 0, 1, 1, 1, 6822.364, -2714.2249, 564.5935, 2.139829635620117187, 300, 10, 0, 1, 0, 1, 0, 0, 0, '', 0),
(41080, 7442, 0, 100, 1, 0, 0, 1, 1, 1, 6748.8613, -2683.6802, 543.2604, 3.834276914596557617, 300, 10, 0, 1, 0, 1, 0, 0, 0, '', 0),
(41081, 7442, 0, 100, 1, 0, 0, 1, 1, 1, 6849.94, -2450.5469, 557.3303, 2.917044639587402343, 300, 10, 0, 1, 0, 1, 0, 0, 0, '', 0),
(41082, 7442, 0, 100, 1, 0, 0, 1, 1, 1, 6779.973, -2615.7065, 556.5726, 2.103003501892089843, 300, 10, 0, 1, 0, 1, 0, 0, 0, '', 0),
(41083, 7442, 0, 100, 1, 0, 0, 1, 1, 1, 6816.885, -2547.8074, 557.44836, 4.464386463165283203, 300, 10, 0, 1, 0, 1, 0, 0, 0, '', 0);

-- Winterfall Den Watcher / Winterfall Totomic spawn points (18 of 18)
DELETE FROM `creature` WHERE `guid` IN (41036,41038,41039,41040,41050,41051,41052,41053,41054,41055,41056,41057,41058,41059,41060,41061,41062,41063,41064);
DELETE FROM `creature_addon` WHERE `guid` IN (41036,41038,41039,41040,41050,41051,41052,41053,41054,41055,41056,41057,41058,41059,41060,41061,41062,41063,41064);
INSERT INTO `creature` (`guid`,`creature_id1`,`creature_id2`,`chance_id1`,`map`,`zoneId`,`areaId`,`spawnMask`,`phaseMask`,`equipment_id`,`position_x`,`position_y`,`position_z`,`orientation`,`spawntimesecs`,`wander_distance`,`currentwaypoint`,`curhealth`,`curmana`,`MovementType`,`npcflag`,`unit_flags`,`dynamicflags`,`ScriptName`,`VerifiedBuild`) VALUES
(41036, 7440, 7441, 50, 1, 0, 0, 1, 1, 0, 6514.873, -3270.0852, 574.5846, 1.01229095458984375, 300, 1, 0, 1, 0, 1, 0, 0, 0, '', 0),
(41038, 7440, 7441, 50, 1, 0, 0, 1, 1, 0, 6813.864, -2470.587, 557.44977, 4.799655437469482421, 300, 2, 0, 1, 0, 1, 0, 0, 0, '', 0),
(41039, 7440, 7441, 50, 1, 0, 0, 1, 1, 0, 6846.676, -2491.2292, 561.8114, 0.794207215309143066, 300, 1, 0, 1, 0, 1, 0, 0, 0, '', 0),
(41040, 7440, 7441, 50, 1, 0, 0, 1, 1, 0, 6783.4297, -2483.271, 547.35486, 0.240555137395858764, 300, 10, 0, 1, 0, 1, 0, 0, 0, '', 0),
(41050, 7440, 7441, 50, 1, 0, 0, 1, 1, 0, 6415.419, -3116.069, 582.13226, 1.108349323272705078, 300, 10, 0, 1, 0, 1, 0, 0, 0, '', 0),
(41051, 7440, 7441, 50, 1, 0, 0, 1, 1, 0, 6451.1665, -3161.6187, 572.1596, 6.238460063934326171, 300, 1, 0, 1, 0, 1, 0, 0, 0, '', 0),
(41052, 7440, 7441, 50, 1, 0, 0, 1, 1, 0, 6453.8125, -3176.2395, 572.2842, 3.841460704803466796, 300, 1, 0, 1, 0, 1, 0, 0, 0, '', 0),
(41053, 7440, 7441, 50, 1, 0, 0, 1, 1, 0, 6513.6724, -3138.5808, 572.9725, 5.540058612823486328, 300, 1, 0, 1, 0, 1, 0, 0, 0, '', 0),
(41054, 7440, 7441, 50, 1, 0, 0, 1, 1, 0, 6496.5825, -3139.2622, 571.38586, 6.04640817642211914, 300, 1, 0, 1, 0, 1, 0, 0, 0, '', 0),
(41055, 7440, 7441, 50, 1, 0, 0, 1, 1, 0, 6484.9272, -3165.9692, 570.21545, 0.744649291038513183, 300, 10, 0, 1, 0, 1, 0, 0, 0, '', 0),
(41056, 7440, 7441, 50, 1, 0, 0, 1, 1, 0, 6452.784, -3114.611, 573.21545, 6.128229141235351562, 300, 10, 0, 1, 0, 1, 0, 0, 0, '', 0),
(41057, 7440, 7441, 50, 1, 0, 0, 1, 1, 0, 6513.4946, -3258.93, 574.01447, 6.248278617858886718, 300, 1, 0, 1, 0, 1, 0, 0, 0, '', 0),
(41058, 7440, 7441, 50, 1, 0, 0, 1, 1, 0, 6834.757, -2488.4932, 559.4921, 4.73670053482055664, 300, 1, 0, 1, 0, 1, 0, 0, 0, '', 0),
(41059, 7440, 7441, 50, 1, 0, 0, 1, 1, 0, 6790.382, -2671.4734, 544.37787, 0.994837641716003417, 300, 1, 0, 1, 0, 1, 0, 0, 0, '', 0),
(41060, 7440, 7441, 50, 1, 0, 0, 1, 1, 0, 6811.109, -2684.5818, 549.98303, 4.762197017669677734, 300, 2, 0, 1, 0, 1, 0, 0, 0, '', 0),
(41061, 7440, 7441, 50, 1, 0, 0, 1, 1, 0, 6790.1025, -2661.2285, 544.6327, 2.166149139404296875, 300, 1, 0, 1, 0, 1, 0, 0, 0, '', 0),
(41062, 7440, 7441, 50, 1, 0, 0, 1, 1, 0, 6783.3433, -2418.206, 552.68805, 0.387034803628921508, 300, 10, 0, 1, 0, 1, 0, 0, 0, '', 0),
(41063, 7440, 7441, 50, 1, 0, 0, 1, 1, 0, 6817.1553, -2448.8901, 551.21716, 1.60886538028717041, 300, 10, 0, 1, 0, 1, 0, 0, 0, '', 0),
(41064, 7440, 7441, 50, 1, 0, 0, 1, 1, 0, 6750.006, -2616.411, 546.54364, 4.006676673889160156, 300, 10, 0, 1, 0, 1, 0, 0, 0, '', 0);

-- Winterfall furbog SAI Fixs
DELETE FROM `smart_scripts` WHERE `entryorguid` IN (7438,7439,7440,7441,7442,10738,10199) AND `source_type`=0;
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`event_param5`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_param4`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(7438,0,0,0,1,0,100,0,4000,4000,4000,4000,0,11,17205,32,0,0,0,0,1,0,0,0,0,0,0,0,0,"Winterfall Ursa - OOC - Cast 'Winterfall Firewater'"),
(7439,0,0,0,1,0,100,0,7000,7000,4000,4000,0,11,17205,32,0,0,0,0,1,0,0,0,0,0,0,0,0,"Winterfall Shaman - OOC - Cast 'Winterfall Firewater'"),
(7439,0,1,0,1,0,100,0,4000,4000,4000,4000,0,11,13585,32,0,0,0,0,1,0,0,0,0,0,0,0,0,"Winterfall Shaman - OOC - Cast 'Lightning Shield'"),
(7439,0,2,0,0,0,100,0,1000,1500,7500,8000,0,11,9532,0,0,0,0,0,2,0,0,0,0,0,0,0,0,"Winterfall Shaman - In Combat - Cast 'Lightning Bolt'"),
(7439,0,3,0,2,0,100,1,30,60,0,0,0,11,13585,0,0,0,0,0,1,0,0,0,0,0,0,0,0,"Winterfall Shaman - Between 30-60% Health - Cast 'Lightning Shield' (No Repeat)"),
(7439,0,4,0,2,0,100,1,10,20,0,0,0,11,11431,0,0,0,0,0,1,0,0,0,0,0,0,0,0,"Winterfall Shaman - Between 10-20% Health - Cast 'Healing Touch' (No Repeat)"),
(7440,0,0,0,1,0,100,0,4000,4000,4000,4000,0,11,17205,32,0,0,0,0,1,0,0,0,0,0,0,0,0,"Winterfall Den Watcher - OOC - Cast 'Winterfall Firewater'"),
(7441,0,0,0,1,0,100,0,4000,4000,4000,4000,0,11,17205,32,0,0,0,0,1,0,0,0,0,0,0,0,0,"Winterfall Totemic - OOC - Cast 'Winterfall Firewater'"),
(7441,0,1,0,4,0,100,0,0,0,0,0,0,11,15786,0,0,0,0,0,1,0,0,0,0,0,0,0,0,"Winterfall Totemic - On Aggro - Cast 'Earthbind Totem'"),
(7441,0,2,0,0,0,100,0,2500,3000,7500,8000,0,11,15787,0,0,0,0,0,1,0,0,0,0,0,0,0,0,"Winterfall Totemic - In Combat - Cast 'Moonflare Totem'"),
(7442,0,0,0,1,0,100,0,4000,4000,4000,4000,0,11,17205,32,0,0,0,0,1,0,0,0,0,0,0,0,0,"Winterfall Pathfinder - OOC - Cast 'Winterfall Firewater'"),
(7442,0,1,0,4,0,100,0,0,0,0,0,0,11,16498,0,0,0,0,0,2,0,0,0,0,0,0,0,0,"Winterfall Pathfinder - On Aggro - Cast 'Faerie Fire'"),
(7442,0,2,0,0,0,100,0,1000,1000,4000,5000,0,11,6660,64,0,0,0,0,2,0,0,0,0,0,0,0,0,"Winterfall Pathfinder - In Combat CMC - Cast 'Shoot'"),
(10738,0,0,0,1,0,100,0,4000,4000,4000,4000,0,11,17205,32,0,0,0,0,1,0,0,0,0,0,0,0,0,"High Chief Winterfall - OOC - Cast 'Winterfall Firewater'"),
(10738,0,1,0,0,0,100,0,1000,2000,8000,9000,0,11,15793,0,0,0,0,0,2,0,0,0,0,0,0,0,0,"High Chief Winterfall - In Combat - Cast 'Maul'"),
(10738,0,2,0,0,0,100,0,6000,7000,14000,17000,0,11,12548,0,0,0,0,0,2,0,0,0,0,0,0,0,0,"High Chief Winterfall - In Combat - Cast 'Frost Shock'"),
(10199,0,0,0,1,0,100,0,4000,4000,4000,4000,0,11,17205,32,0,0,0,0,1,0,0,0,0,0,0,0,0,"Grizzle Snowpaw - On Respawn - Cast 'Winterfall Firewater'"),
(10199,0,1,0,0,0,100,0,1200,1400,8600,8900,0,11,15793,0,0,0,0,0,2,0,0,0,0,0,0,0,0,"Grizzle Snowpaw - In Combat - Cast 'Maul'"),
(10199,0,2,0,0,0,100,0,6500,7000,14200,16800,0,11,12548,0,0,0,0,0,2,0,0,0,0,0,0,0,0,"Grizzle Snowpaw - In Combat - Cast 'Frost Shock'");

-- Pathing for Winterfall Shaman / Winterfall Den Watcher Entry: 7439 / 7440
SET @NPC := 41029;
SET @PATH := @NPC * 10;
DELETE FROM `creature_addon` WHERE `guid`=@NPC;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes1`,`bytes2`,`emote`,`visibilityDistanceType`,`auras`) VALUES (@NPC,@PATH,0,0,1,0,0, '');
DELETE FROM `waypoint_data` WHERE `id`=@PATH;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`orientation`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
(@PATH,1,6733.8516,-4965.619,771.96893,0,0,0,0,100,0),
(@PATH,2,6740.082,-4984.6426,773.63275,0,0,0,0,100,0),
(@PATH,3,6724.4766,-5014.2603,765.80634,0,0,0,0,100,0),
(@PATH,4,6707.3794,-5024.815,766.31805,0,0,0,0,100,0),
(@PATH,5,6697.2207,-5037.676,775.3876,0,0,0,0,100,0),
(@PATH,6,6687.422,-5044.838,780.4641,0,0,0,0,100,0),
(@PATH,7,6677.6787,-5060.2393,780.31067,0,0,0,0,100,0),
(@PATH,8,6650.1963,-5078.844,791.29736,0,0,0,0,100,0),
(@PATH,9,6638.5166,-5102.051,785.7811,0,0,0,0,100,0),
(@PATH,10,6672.9907,-5123.819,776.9872,0,0,0,0,100,0),
(@PATH,11,6638.4517,-5102.194,785.7571,0,0,0,0,100,0),
(@PATH,12,6650.1963,-5078.844,791.29736,0,0,0,0,100,0),
(@PATH,13,6677.6787,-5060.2393,780.31067,0,0,0,0,100,0),
(@PATH,14,6687.422,-5044.838,780.4641,0,0,0,0,100,0),
(@PATH,15,6697.2207,-5037.676,775.3876,0,0,0,0,100,0),
(@PATH,16,6707.3794,-5024.815,766.31805,0,0,0,0,100,0),
(@PATH,17,6724.4766,-5014.2603,765.80634,0,0,0,0,100,0),
(@PATH,18,6740.1167,-4984.761,773.6827,0,0,0,0,100,0);

-- Pathing for Winterfall Shaman / Winterfall Den Watcher Entry: 7439 / 7440
SET @NPC := 41044;
SET @PATH := @NPC * 10;
DELETE FROM `creature_addon` WHERE `guid`=@NPC;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes1`,`bytes2`,`emote`,`visibilityDistanceType`,`auras`) VALUES (@NPC,@PATH,0,0,1,0,0, '');
DELETE FROM `waypoint_data` WHERE `id`=@PATH;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`orientation`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
(@PATH,1,6900.3013,-5154.777,698.81146,0,0,0,0,100,0),
(@PATH,2,6895.0947,-5126.145,695.9776,0,0,0,0,100,0),
(@PATH,3,6893.022,-5085.655,694.8563,0,0,0,0,100,0),
(@PATH,4,6904.772,-5064.3364,691.3245,0,0,0,0,100,0),
(@PATH,5,6894.1934,-5033.6455,693.06714,0,0,0,0,100,0),
(@PATH,6,6876.6357,-5016.819,694.66364,0,0,0,0,100,0),
(@PATH,7,6865.5957,-5000.893,694.55536,0,0,0,0,100,0),
(@PATH,8,6865.4287,-4973.0806,702.4603,0,0,0,0,100,0),
(@PATH,9,6856.0605,-4969.5615,704.8142,0,0,0,0,100,0),
(@PATH,10,6865.426,-4973.076,702.4133,0,0,0,0,100,0),
(@PATH,11,6865.5957,-5000.893,694.55536,0,0,0,0,100,0),
(@PATH,12,6876.6357,-5016.819,694.66364,0,0,0,0,100,0),
(@PATH,13,6894.1934,-5033.6455,693.06714,0,0,0,0,100,0),
(@PATH,14,6904.772,-5064.3364,691.3245,0,0,0,0,100,0),
(@PATH,15,6893.022,-5085.655,694.8563,0,0,0,0,100,0),
(@PATH,16,6895.0947,-5126.145,695.9776,0,0,0,0,100,0);

-- Pathing for High Chief Winterfall Entry: 10738
SET @NPC := 42315;
SET @PATH := @NPC * 10;
DELETE FROM `creature_addon` WHERE `guid`=@NPC;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes1`,`bytes2`,`emote`,`visibilityDistanceType`,`auras`) VALUES (@NPC,@PATH,0,0,1,0,0, '');
DELETE FROM `waypoint_data` WHERE `id`=@PATH;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`orientation`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
(@PATH,1,6726.2646,-5276.126,778.2435,0,0,0,0,100,0),
(@PATH,2,6723.2944,-5266.33,778.23706,0,0,0,0,100,0),
(@PATH,3,6716.651,-5246.5376,779.3957,0,0,0,0,100,0),
(@PATH,4,6719.367,-5253.45,778.29205,0,0,0,0,100,0),
(@PATH,5,6723.7593,-5268.194,778.045,0,0,0,0,100,0);
-- Formation
DELETE FROM `creature_formations` WHERE `leaderGUID`=42315;
INSERT INTO `creature_formations` (`leaderGUID`,`memberGUID`,`dist`,`angle`,`groupAI`,`point_1`,`point_2`) VALUES
(42315,41033,2,180,513,0,0),
(42315,42315,0,0,2,0,0);

-- Misc fixes
UPDATE `creature_template` SET `unit_flags`=0 WHERE entry IN (7440);
UPDATE `creature_template` SET `MovementType`=1 WHERE entry IN (7441);
DELETE FROM `creature_template_addon` WHERE entry IN (7438,7439,7440,7441,7442,10738);
DELETE FROM `waypoint_data` WHERE `id` IN (410730,410790,410330);

--
-- END UPDATING QUERIES
--
UPDATE version_db_world SET date = '2022_01_11_05' WHERE sql_rev = '1641924478819152116';
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
