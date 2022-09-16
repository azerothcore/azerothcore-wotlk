-- DB update 2022_01_22_01 -> 2022_01_22_02
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2022_01_22_01';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2022_01_22_01 2022_01_22_02 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1642861125376425056'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1642861125376425056');

-- Pathing for Razorfang Ravager Entry: 16933
SET @NPC := 58884;
SET @PATH := @NPC * 10;
UPDATE `creature` SET `wander_distance`=0,`MovementType`=2,`position_x`=-1378.6526,`position_y`=3379.965,`position_z`=43.642708,`curhealth`=1 WHERE `guid`=@NPC;
DELETE FROM `creature_addon` WHERE `guid`=@NPC;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes1`,`bytes2`,`emote`,`visibilityDistanceType`,`auras`) VALUES (@NPC,@PATH,0,0,1,0,0, '');
DELETE FROM `waypoint_data` WHERE `id`=@PATH;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`orientation`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
(@PATH,1,-1378.6526,3379.965,43.642708,0,0,0,0,100,0),
(@PATH,2,-1405.0708,3393.7217,38.861656,0,0,0,0,100,0),
(@PATH,3,-1427.9418,3416.7727,37.992054,0,0,0,0,100,0),
(@PATH,4,-1440.9492,3424.2285,36.940357,0,0,0,0,100,0),
(@PATH,5,-1462.6318,3424.4214,33.77727,0,0,0,0,100,0),
(@PATH,6,-1480.5194,3420.4365,29.188503,0,0,0,0,100,0),
(@PATH,7,-1467.6676,3448.5,34.003967,0,0,0,0,100,0),
(@PATH,8,-1495.6249,3465.923,30.51642,0,0,0,0,100,0),
(@PATH,9,-1529.0315,3486.4575,29.102755,0,0,0,0,100,0),
(@PATH,10,-1546.9016,3474.702,21.953114,0,0,0,0,100,0),
(@PATH,11,-1529.0315,3486.4575,29.102755,0,0,0,0,100,0),
(@PATH,12,-1495.6249,3465.923,30.51642,0,0,0,0,100,0),
(@PATH,13,-1467.6676,3448.5,34.003967,0,0,0,0,100,0),
(@PATH,14,-1480.5194,3420.4365,29.188503,0,0,0,0,100,0),
(@PATH,15,-1462.6318,3424.4214,33.77727,0,0,0,0,100,0),
(@PATH,16,-1440.9703,3424.2327,36.95281,0,0,0,0,100,0),
(@PATH,17,-1427.9418,3416.7727,37.992054,0,0,0,0,100,0),
(@PATH,18,-1405.0708,3393.7217,38.861656,0,0,0,0,100,0);

-- Pathing for Razorfang Ravager Entry: 16933
SET @NPC := 58885;
SET @PATH := @NPC * 10;
UPDATE `creature` SET `wander_distance`=0,`MovementType`=2,`position_x`=-1477.8384,`position_y`=3373.4348,`position_z`=13.880589,`curhealth`=1 WHERE `guid`=@NPC;
DELETE FROM `creature_addon` WHERE `guid`=@NPC;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes1`,`bytes2`,`emote`,`visibilityDistanceType`,`auras`) VALUES (@NPC,@PATH,0,0,1,0,0, '');
DELETE FROM `waypoint_data` WHERE `id`=@PATH;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`orientation`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
(@PATH,1,-1477.8384,3373.4348,13.880589,0,0,0,0,100,0),
(@PATH,2,-1464.2664,3393.7986,21.951616,0,0,0,0,100,0),
(@PATH,3,-1449.828,3401.353,33.181324,0,0,0,0,100,0),
(@PATH,4,-1423.2344,3427.1162,41.28258,0,0,0,0,100,0),
(@PATH,5,-1411.6805,3444.6787,47.62758,0,0,0,0,100,0),
(@PATH,6,-1384.3407,3459.402,56.110092,0,0,0,0,100,0),
(@PATH,7,-1419.903,3462.0461,47.064224,0,0,0,0,100,0),
(@PATH,8,-1443.0045,3466.578,42.467987,0,0,0,0,100,0),
(@PATH,9,-1471.4132,3470.6309,35.345505,0,0,0,0,100,0),
(@PATH,10,-1501.2354,3466.2256,30.334229,0,0,0,0,100,0),
(@PATH,11,-1526.7363,3446.8506,18.459229,0,0,0,0,100,0),
(@PATH,12,-1501.2354,3466.2256,30.334229,0,0,0,0,100,0),
(@PATH,13,-1471.5293,3470.62,35.28325,0,0,0,0,100,0),
(@PATH,14,-1443.0045,3466.578,42.467987,0,0,0,0,100,0),
(@PATH,15,-1419.903,3462.0461,47.064224,0,0,0,0,100,0),
(@PATH,16,-1384.3407,3459.402,56.110092,0,0,0,0,100,0),
(@PATH,17,-1411.6465,3444.6895,47.50685,0,0,0,0,100,0),
(@PATH,18,-1423.2129,3427.1553,41.28258,0,0,0,0,100,0),
(@PATH,19,-1449.8066,3401.3926,33.315357,0,0,0,0,100,0),
(@PATH,20,-1464.2664,3393.7986,21.951616,0,0,0,0,100,0);

-- Pathing for Razorfang Ravager Entry: 16933
SET @NPC := 58886;
SET @PATH := @NPC * 10;
UPDATE `creature` SET `wander_distance`=0,`MovementType`=2,`position_x`=-1466.2773,`position_y`=3563.0117,`position_z`=58.70063,`curhealth`=1 WHERE `guid`=@NPC;
DELETE FROM `creature_addon` WHERE `guid`=@NPC;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes1`,`bytes2`,`emote`,`visibilityDistanceType`,`auras`) VALUES (@NPC,@PATH,0,0,1,0,0, '');
DELETE FROM `waypoint_data` WHERE `id`=@PATH;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`orientation`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
(@PATH,1,-1466.2773,3563.0117,58.70063,0,0,0,0,100,0),
(@PATH,2,-1490.0895,3565.8716,47.936398,0,0,0,0,100,0),
(@PATH,3,-1516.2947,3560.6025,38.148518,0,0,0,0,100,0),
(@PATH,4,-1539.6699,3523.3057,30.420353,0,0,0,0,100,0),
(@PATH,5,-1531.8733,3484.162,28.398287,0,0,0,0,100,0),
(@PATH,6,-1499.7998,3470.1602,30.369917,0,0,0,0,100,0),
(@PATH,7,-1465.626,3453.3052,34.50827,0,0,0,0,100,0),
(@PATH,8,-1427.8556,3452.2356,43.527115,0,0,0,0,100,0),
(@PATH,9,-1393.8696,3452.1257,52.997055,0,0,0,0,100,0),
(@PATH,10,-1427.8556,3452.2356,43.527115,0,0,0,0,100,0),
(@PATH,11,-1465.626,3453.3052,34.50827,0,0,0,0,100,0),
(@PATH,12,-1499.7998,3470.1602,30.369917,0,0,0,0,100,0),
(@PATH,13,-1531.8733,3484.162,28.398287,0,0,0,0,100,0),
(@PATH,14,-1539.7134,3523.2544,30.467228,0,0,0,0,100,0),
(@PATH,15,-1516.3379,3560.5508,38.246662,0,0,0,0,100,0),
(@PATH,16,-1490.0895,3565.8716,47.936398,0,0,0,0,100,0);

-- Pathing for Razorfang Ravager Entry: 16933
SET @NPC := 58887;
SET @PATH := @NPC * 10;
UPDATE `creature` SET `wander_distance`=0,`MovementType`=2,`position_x`=-1594.6827,`position_y`=3536.7422,`position_z`=19.957382,`curhealth`=1 WHERE `guid`=@NPC;
DELETE FROM `creature_addon` WHERE `guid`=@NPC;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes1`,`bytes2`,`emote`,`visibilityDistanceType`,`auras`) VALUES (@NPC,@PATH,0,0,1,0,0, '');
DELETE FROM `waypoint_data` WHERE `id`=@PATH;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`orientation`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
(@PATH,1,-1594.6827,3536.7422,19.957382,0,0,0,0,100,0),
(@PATH,2,-1556.6017,3529.543,27.452335,0,0,0,0,100,0),
(@PATH,3,-1533.4274,3503.5586,30.137394,0,0,0,0,100,0),
(@PATH,4,-1500.071,3485.4187,33.203705,0,0,0,0,100,0),
(@PATH,5,-1494.9347,3442.922,27.857485,0,0,0,0,100,0),
(@PATH,6,-1468.7008,3415.3003,31.673489,0,0,0,0,100,0),
(@PATH,7,-1439.0641,3389.0647,31.949663,0,0,0,0,100,0),
(@PATH,8,-1468.7008,3415.3003,31.673489,0,0,0,0,100,0),
(@PATH,9,-1494.9347,3442.922,27.857485,0,0,0,0,100,0),
(@PATH,10,-1500.071,3485.4187,33.203705,0,0,0,0,100,0),
(@PATH,11,-1533.4274,3503.5586,30.137394,0,0,0,0,100,0),
(@PATH,12,-1556.6017,3529.543,27.452335,0,0,0,0,100,0);

-- Pathing for Razorfang Ravager Entry: 16933
SET @NPC := 58888;
SET @PATH := @NPC * 10;
UPDATE `creature` SET `wander_distance`=0,`MovementType`=2,`position_x`=-1635.8835,`position_y`=3595.0356,`position_z`=20.027435,`curhealth`=1 WHERE `guid`=@NPC;
DELETE FROM `creature_addon` WHERE `guid`=@NPC;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes1`,`bytes2`,`emote`,`visibilityDistanceType`,`auras`) VALUES (@NPC,@PATH,0,0,1,0,0, '');
DELETE FROM `waypoint_data` WHERE `id`=@PATH;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`orientation`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
(@PATH,1,-1635.8835,3595.0356,20.027435,0,0,0,0,100,0),
(@PATH,2,-1612.7592,3587.802,24.888426,0,0,0,0,100,0),
(@PATH,3,-1590.1842,3594.257,30.044992,0,0,0,0,100,0),
(@PATH,4,-1571.36,3569.9875,33.986153,0,0,0,0,100,0),
(@PATH,5,-1549.9204,3565.4995,36.24269,0,0,0,0,100,0),
(@PATH,6,-1517.6581,3568.7065,39.903496,0,0,0,0,100,0),
(@PATH,7,-1491.7346,3570.0496,49.15596,0,0,0,0,100,0),
(@PATH,8,-1465.1562,3561.2998,59.95063,0,0,0,0,100,0),
(@PATH,9,-1481.4537,3564.353,50.912228,0,0,0,0,100,0),
(@PATH,10,-1507.1627,3557.0754,39.22591,0,0,0,0,100,0),
(@PATH,11,-1537.0966,3546.386,33.76259,0,0,0,0,100,0),
(@PATH,12,-1563.3861,3539.6672,26.636976,0,0,0,0,100,0),
(@PATH,13,-1585.668,3533.9395,21.441391,0,0,0,0,100,0),
(@PATH,14,-1563.3861,3539.6672,26.636976,0,0,0,0,100,0),
(@PATH,15,-1537.2305,3546.3643,33.77272,0,0,0,0,100,0),
(@PATH,16,-1507.1627,3557.0754,39.22591,0,0,0,0,100,0),
(@PATH,17,-1481.4537,3564.353,50.912228,0,0,0,0,100,0),
(@PATH,18,-1465.0122,3561.2588,59.900826,0,0,0,0,100,0),
(@PATH,19,-1491.7346,3570.0496,49.15596,0,0,0,0,100,0),
(@PATH,20,-1517.6581,3568.7065,39.903496,0,0,0,0,100,0),
(@PATH,21,-1549.9204,3565.4995,36.24269,0,0,0,0,100,0),
(@PATH,22,-1571.36,3569.9875,33.986153,0,0,0,0,100,0),
(@PATH,23,-1590.1842,3594.257,30.044992,0,0,0,0,100,0),
(@PATH,24,-1612.7592,3587.802,24.888426,0,0,0,0,100,0);

-- Pathing for Razorfang Ravager Entry: 16933
SET @NPC := 58889;
SET @PATH := @NPC * 10;
UPDATE `creature` SET `wander_distance`=0,`MovementType`=2,`position_x`=-1513.7402,`position_y`=3625.1055,`position_z`=49.90627,`curhealth`=1 WHERE `guid`=@NPC;
DELETE FROM `creature_addon` WHERE `guid`=@NPC;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes1`,`bytes2`,`emote`,`visibilityDistanceType`,`auras`) VALUES (@NPC,@PATH,0,0,1,0,0, '');
DELETE FROM `waypoint_data` WHERE `id`=@PATH;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`orientation`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
(@PATH,1,-1513.7402,3625.1055,49.90627,0,0,0,0,100,0),
(@PATH,2,-1533.7402,3625.2617,38.559082,0,0,0,0,100,0),
(@PATH,3,-1566.8207,3631.3008,34.770805,0,0,0,0,100,0),
(@PATH,4,-1599.3047,3625.5967,32.895805,0,0,0,0,100,0),
(@PATH,5,-1632.2886,3642.7974,30.460894,0,0,0,0,100,0),
(@PATH,6,-1656.9404,3629.1025,27.955526,0,0,0,0,100,0),
(@PATH,7,-1635.577,3604.6924,24.288778,0,0,0,0,100,0),
(@PATH,8,-1614.1067,3575.0798,20.953733,0,0,0,0,100,0),
(@PATH,9,-1588.041,3569.1343,27.63679,0,0,0,0,100,0),
(@PATH,10,-1551.696,3578.2534,41.814255,0,0,0,0,100,0),
(@PATH,11,-1540.4839,3587.4478,49.79875,0,0,0,0,100,0),
(@PATH,12,-1551.696,3578.2534,41.814255,0,0,0,0,100,0),
(@PATH,13,-1588.041,3569.1343,27.63679,0,0,0,0,100,0),
(@PATH,14,-1614.1067,3575.0798,20.953733,0,0,0,0,100,0),
(@PATH,15,-1635.577,3604.6924,24.288778,0,0,0,0,100,0),
(@PATH,16,-1656.9404,3629.1025,27.955526,0,0,0,0,100,0),
(@PATH,17,-1632.2886,3642.7974,30.460894,0,0,0,0,100,0),
(@PATH,18,-1599.3359,3625.5876,32.92095,0,0,0,0,100,0),
(@PATH,19,-1566.8207,3631.3008,34.770805,0,0,0,0,100,0),
(@PATH,20,-1533.7399,3625.262,38.61377,0,0,0,0,100,0);

-- Pathing for Razorfang Ravager Entry: 16933
SET @NPC := 58890;
SET @PATH := @NPC * 10;
UPDATE `creature` SET `wander_distance`=0,`MovementType`=2,`position_x`=-1664.5951,`position_y`=3613.966,`position_z`=23.863485,`curhealth`=1 WHERE `guid`=@NPC;
DELETE FROM `creature_addon` WHERE `guid`=@NPC;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes1`,`bytes2`,`emote`,`visibilityDistanceType`,`auras`) VALUES (@NPC,@PATH,0,0,1,0,0, '');
DELETE FROM `waypoint_data` WHERE `id`=@PATH;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`orientation`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
(@PATH,1,-1664.5951,3613.966,23.863485,0,0,0,0,100,0),
(@PATH,2,-1655.0065,3631.9731,28.537558,0,0,0,0,100,0),
(@PATH,3,-1641.1675,3652.9648,30.97416,0,0,0,0,100,0),
(@PATH,4,-1612.196,3647.4683,33.12068,0,0,0,0,100,0),
(@PATH,5,-1581.6067,3628.8025,34.789604,0,0,0,0,100,0),
(@PATH,6,-1550.9424,3637.936,34.088367,0,0,0,0,100,0),
(@PATH,7,-1528.0364,3620.1926,40.639668,0,0,0,0,100,0),
(@PATH,8,-1545.4777,3609.8308,36.796875,0,0,0,0,100,0),
(@PATH,9,-1574.0957,3588.0342,33.815742,0,0,0,0,100,0),
(@PATH,10,-1591.1179,3575.8372,27.950998,0,0,0,0,100,0),
(@PATH,11,-1610.2288,3572.6455,21.348387,0,0,0,0,100,0),
(@PATH,12,-1591.1179,3575.8372,27.950998,0,0,0,0,100,0),
(@PATH,13,-1574.1925,3587.9866,33.79328,0,0,0,0,100,0),
(@PATH,14,-1545.4777,3609.8308,36.796875,0,0,0,0,100,0),
(@PATH,15,-1528.0364,3620.1926,40.639668,0,0,0,0,100,0),
(@PATH,16,-1550.9424,3637.936,34.088367,0,0,0,0,100,0),
(@PATH,17,-1581.6067,3628.8025,34.789604,0,0,0,0,100,0),
(@PATH,18,-1612.196,3647.4683,33.12068,0,0,0,0,100,0),
(@PATH,19,-1641.1675,3652.9648,30.97416,0,0,0,0,100,0),
(@PATH,20,-1654.9375,3632.0908,28.450644,0,0,0,0,100,0);

-- Pathing for Razorfang Ravager Entry: 16933
SET @NPC := 58891;
SET @PATH := @NPC * 10;
UPDATE `creature` SET `wander_distance`=0,`MovementType`=2,`position_x`=-1559.3668,`position_y`=3736.0747,`position_z`=54.180794,`curhealth`=1 WHERE `guid`=@NPC;
DELETE FROM `creature_addon` WHERE `guid`=@NPC;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes1`,`bytes2`,`emote`,`visibilityDistanceType`,`auras`) VALUES (@NPC,@PATH,0,0,1,0,0, '');
DELETE FROM `waypoint_data` WHERE `id`=@PATH;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`orientation`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
(@PATH,1,-1559.3668,3736.0747,54.180794,0,0,0,0,100,0),
(@PATH,2,-1582.4573,3724.0876,41.9687,0,0,0,0,100,0),
(@PATH,3,-1610.9769,3718.8604,36.08837,0,0,0,0,100,0),
(@PATH,4,-1645.1183,3713.3203,31.410147,0,0,0,0,100,0),
(@PATH,5,-1645.5286,3686.0422,30.489435,0,0,0,0,100,0),
(@PATH,6,-1667.6079,3677.024,37.941975,0,0,0,0,100,0),
(@PATH,7,-1684.5846,3704.4502,48.431522,0,0,0,0,100,0),
(@PATH,8,-1671.1266,3693.2092,39.095173,0,0,0,0,100,0),
(@PATH,9,-1651.9651,3688.9934,31.077814,0,0,0,0,100,0),
(@PATH,10,-1626.6747,3679.632,31.586761,0,0,0,0,100,0),
(@PATH,11,-1589.8738,3667.8315,41.43242,0,0,0,0,100,0),
(@PATH,12,-1626.6747,3679.632,31.586761,0,0,0,0,100,0),
(@PATH,13,-1651.9651,3688.9934,31.077814,0,0,0,0,100,0),
(@PATH,14,-1671.1266,3693.2092,39.095173,0,0,0,0,100,0),
(@PATH,15,-1684.5846,3704.4502,48.431522,0,0,0,0,100,0),
(@PATH,16,-1645.1183,3713.3203,31.410147,0,0,0,0,100,0),
(@PATH,17,-1610.9769,3718.8604,36.08837,0,0,0,0,100,0),
(@PATH,18,-1582.4573,3724.0876,41.9687,0,0,0,0,100,0);

-- Pathing for Razorfang Ravager Entry: 16933
SET @NPC := 58892;
SET @PATH := @NPC * 10;
UPDATE `creature` SET `wander_distance`=0,`MovementType`=2,`position_x`=-1546.2329,`position_y`=3744.9778,`position_z`=62.652596,`curhealth`=1 WHERE `guid`=@NPC;
DELETE FROM `creature_addon` WHERE `guid`=@NPC;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes1`,`bytes2`,`emote`,`visibilityDistanceType`,`auras`) VALUES (@NPC,@PATH,0,0,1,0,0, '');
DELETE FROM `waypoint_data` WHERE `id`=@PATH;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`orientation`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
(@PATH,1,-1546.2329,3744.9778,62.652596,0,0,0,0,100,0),
(@PATH,2,-1566.8759,3733.5208,50.870975,0,0,0,0,100,0),
(@PATH,3,-1597.2842,3721.1965,39.689404,0,0,0,0,100,0),
(@PATH,4,-1620.7115,3732.039,32.677727,0,0,0,0,100,0),
(@PATH,5,-1666.3969,3738.7297,35.76956,0,0,0,0,100,0),
(@PATH,6,-1699.231,3758.7856,45.249863,0,0,0,0,100,0),
(@PATH,7,-1695.2031,3731.3933,55.46912,0,0,0,0,100,0),
(@PATH,8,-1687.7887,3701.2349,50.709476,0,0,0,0,100,0),
(@PATH,9,-1666.736,3684.26,36.54439,0,0,0,0,100,0),
(@PATH,10,-1687.7887,3701.2349,50.709476,0,0,0,0,100,0),
(@PATH,11,-1695.1758,3731.3262,55.34644,0,0,0,0,100,0),
(@PATH,12,-1699.231,3758.7856,45.249863,0,0,0,0,100,0),
(@PATH,13,-1666.3969,3738.7297,35.76956,0,0,0,0,100,0),
(@PATH,14,-1620.7115,3732.039,32.677727,0,0,0,0,100,0),
(@PATH,15,-1597.2842,3721.1965,39.689404,0,0,0,0,100,0),
(@PATH,16,-1566.8759,3733.5208,50.870975,0,0,0,0,100,0);

-- Pathing for Razorfang Ravager Entry: 16933
SET @NPC := 58893;
SET @PATH := @NPC * 10;
UPDATE `creature` SET `wander_distance`=0,`MovementType`=2,`position_x`=-1608.8043,`position_y`=3818.8057,`position_z`=45.03594,`curhealth`=1 WHERE `guid`=@NPC;
DELETE FROM `creature_addon` WHERE `guid`=@NPC;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes1`,`bytes2`,`emote`,`visibilityDistanceType`,`auras`) VALUES (@NPC,@PATH,0,0,1,0,0, '');
DELETE FROM `waypoint_data` WHERE `id`=@PATH;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`orientation`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
(@PATH,1,-1608.8043,3818.8057,45.03594,0,0,0,0,100,0),
(@PATH,2,-1614.4458,3800.9993,40.992237,0,0,0,0,100,0),
(@PATH,3,-1634.9264,3795.826,35.45314,0,0,0,0,100,0),
(@PATH,4,-1623.834,3775.895,36.97846,0,0,0,0,100,0),
(@PATH,5,-1609.7363,3764.6797,43.61167,0,0,0,0,100,0),
(@PATH,6,-1640.0195,3747.1113,31.949615,0,0,0,0,100,0),
(@PATH,7,-1674.4713,3748.0735,36.774277,0,0,0,0,100,0),
(@PATH,8,-1699.1442,3754.7083,46.27623,0,0,0,0,100,0),
(@PATH,9,-1695.3422,3730.4653,55.820072,0,0,0,0,100,0),
(@PATH,10,-1699.1442,3754.7083,46.27623,0,0,0,0,100,0),
(@PATH,11,-1674.4713,3748.0735,36.774277,0,0,0,0,100,0),
(@PATH,12,-1640.107,3747.0747,31.949127,0,0,0,0,100,0),
(@PATH,13,-1609.7072,3764.6445,43.647316,0,0,0,0,100,0),
(@PATH,14,-1623.834,3775.895,36.97846,0,0,0,0,100,0),
(@PATH,15,-1634.9264,3795.826,35.45314,0,0,0,0,100,0),
(@PATH,16,-1614.4458,3800.9993,40.992237,0,0,0,0,100,0);

-- Pathing for Razorfang Ravager Entry: 16933
SET @NPC := 58894;
SET @PATH := @NPC * 10;
UPDATE `creature` SET `wander_distance`=0,`MovementType`=2,`position_x`=-1712.4985,`position_y`=3764.638,`position_z`=52.527252,`curhealth`=1 WHERE `guid`=@NPC;
DELETE FROM `creature_addon` WHERE `guid`=@NPC;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes1`,`bytes2`,`emote`,`visibilityDistanceType`,`auras`) VALUES (@NPC,@PATH,0,0,1,0,0, '');
DELETE FROM `waypoint_data` WHERE `id`=@PATH;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`orientation`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
(@PATH,1,-1712.4985,3764.638,52.527252,0,0,0,0,100,0),
(@PATH,2,-1685.1881,3780.0044,37.366917,0,0,0,0,100,0),
(@PATH,3,-1698.8727,3800.7014,41.648247,0,0,0,0,100,0),
(@PATH,4,-1714.8105,3802.2637,47.63476,0,0,0,0,100,0),
(@PATH,5,-1699.0303,3814.4727,42.060844,0,0,0,0,100,0),
(@PATH,6,-1695.6405,3824.4297,39.923637,0,0,0,0,100,0),
(@PATH,7,-1698.297,3835.6194,39.180065,0,0,0,0,100,0),
(@PATH,8,-1708.6315,3843.8203,41.907104,0,0,0,0,100,0),
(@PATH,9,-1729.4183,3848.4597,44.22998,0,0,0,0,100,0),
(@PATH,10,-1708.6315,3843.8203,41.907104,0,0,0,0,100,0),
(@PATH,11,-1698.297,3835.6194,39.180065,0,0,0,0,100,0),
(@PATH,12,-1695.6405,3824.4297,39.923637,0,0,0,0,100,0),
(@PATH,13,-1699.0303,3814.4727,42.060844,0,0,0,0,100,0),
(@PATH,14,-1714.9481,3802.2795,47.559566,0,0,0,0,100,0),
(@PATH,15,-1698.8727,3800.7014,41.648247,0,0,0,0,100,0),
(@PATH,16,-1685.1881,3780.0044,37.366917,0,0,0,0,100,0);

-- Pathing for Razorfang Ravager Entry: 16933
SET @NPC := 58895;
SET @PATH := @NPC * 10;
UPDATE `creature` SET `wander_distance`=0,`MovementType`=2,`position_x`=-1722.43,`position_y`=3795.058,`position_z`=51.801155,`curhealth`=1 WHERE `guid`=@NPC;
DELETE FROM `creature_addon` WHERE `guid`=@NPC;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes1`,`bytes2`,`emote`,`visibilityDistanceType`,`auras`) VALUES (@NPC,@PATH,0,0,1,0,0, '');
DELETE FROM `waypoint_data` WHERE `id`=@PATH;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`orientation`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
(@PATH,1,-1722.43,3795.058,51.801155,0,0,0,0,100,0),
(@PATH,2,-1702.9542,3805.079,42.844234,0,0,0,0,100,0),
(@PATH,3,-1666.6677,3807.4788,33.10601,0,0,0,0,100,0),
(@PATH,4,-1635.4498,3797.05,35.534195,0,0,0,0,100,0),
(@PATH,5,-1611.2941,3766.6262,43.473,0,0,0,0,100,0),
(@PATH,6,-1633.76,3750.2075,32.972076,0,0,0,0,100,0),
(@PATH,7,-1654.1313,3723.1523,33.515007,0,0,0,0,100,0),
(@PATH,8,-1654.426,3700.7974,33.30285,0,0,0,0,100,0),
(@PATH,9,-1676.9407,3680.8918,42.696735,0,0,0,0,100,0),
(@PATH,10,-1673.2794,3665.9988,44.95797,0,0,0,0,100,0),
(@PATH,11,-1676.9407,3680.8918,42.696735,0,0,0,0,100,0),
(@PATH,12,-1654.426,3700.7974,33.30285,0,0,0,0,100,0),
(@PATH,13,-1654.1313,3723.1523,33.515007,0,0,0,0,100,0),
(@PATH,14,-1633.76,3750.2075,32.972076,0,0,0,0,100,0),
(@PATH,15,-1611.2941,3766.6262,43.473,0,0,0,0,100,0),
(@PATH,16,-1635.4498,3797.05,35.534195,0,0,0,0,100,0),
(@PATH,17,-1666.6677,3807.4788,33.10601,0,0,0,0,100,0),
(@PATH,18,-1702.9542,3805.079,42.844234,0,0,0,0,100,0);

--
-- END UPDATING QUERIES
--
UPDATE version_db_world SET date = '2022_01_22_02' WHERE sql_rev = '1642861125376425056';
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
