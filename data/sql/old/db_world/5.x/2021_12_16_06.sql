-- DB update 2021_12_16_05 -> 2021_12_16_06
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2021_12_16_05';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2021_12_16_05 2021_12_16_06 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1639063426788133858'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1639063426788133858');

-- Remove some overspawns
DELETE FROM `creature` WHERE `guid` IN (81889,81890,81893,81894,81899,81901,81903,81904,82016,82018,82024,82029,82034,82037,82023,82025,82028,82031,82039);

-- Suncrown Village, Ghostlands

-- Reuse some overspawns
UPDATE `creature` SET `id`=16313, `position_x`=7971.8804, `position_y`=-7380.269, `position_z`=141.32101, `orientation`=6.143461227416992187, `curhealth`=168, `curmana`=178 WHERE `guid`=81882;
UPDATE `creature` SET `id`=16313, `position_x`=7943.367, `position_y`=-7388.2334, `position_z`=142.48712, `orientation`=3.677036762237548828, `curhealth`=168, `curmana`=178 WHERE `guid`=81884;
UPDATE `creature` SET `id`=16313, `position_x`=7947.7134, `position_y`=-7354.116, `position_z`=142.76176, `orientation`=4.914618968963623046, `curhealth`=168, `curmana`=178 WHERE `guid`=82041;
-- 16 of 57 Proper spawn locations from sniff
UPDATE `creature` SET `position_x`=8037.8213, `position_y`=-7382.6606, `position_z`=165.41771, `orientation`=5.553741931915283203 WHERE `guid`=81810;
UPDATE `creature` SET `position_x`=8037.8213, `position_y`=-7382.6606, `position_z`=165.41771, `orientation`=5.553741931915283203 WHERE `guid`=82110;
UPDATE `creature` SET `position_x`=7881.9863, `position_y`=-7250.483, `position_z`=134.22247, `orientation`=0.426802843809127807 WHERE `guid`=81769;
UPDATE `creature` SET `position_x`=7891.922, `position_y`=-7269.1685, `position_z`=155.8974, `orientation`=2.36991286277770996 WHERE `guid`=81767;
UPDATE `creature` SET `position_x`=7907.989, `position_y`=-7291.5615, `position_z`=155.89781, `orientation`=1.554324746131896972 WHERE `guid`=81784;
UPDATE `creature` SET `position_x`=7911.893, `position_y`=-7275.0146, `position_z`=140.01123, `orientation`=5.516409873962402343 WHERE `guid`=81771;
UPDATE `creature` SET `position_x`=7912.164, `position_y`=-7274.4907, `position_z`=155.89624, `orientation`=1.193374514579772949 WHERE `guid`=81772;
UPDATE `creature` SET `position_x`=7912.9194, `position_y`=-7351.9307, `position_z`=144.84807, `orientation`=0.670562922954559326 WHERE `guid`=81788;
UPDATE `creature` SET `position_x`=7913.404, `position_y`=-7320.0376, `position_z`=141.83772, `orientation`=2.287100553512573242 WHERE `guid`=81790;
UPDATE `creature` SET `position_x`=7919.2095, `position_y`=-7257.4404, `position_z`=155.89677, `orientation`=2.387856721878051757 WHERE `guid`=81766;
UPDATE `creature` SET `position_x`=7919.733, `position_y`=-7217.0396, `position_z`=131.48665, `orientation`=0.222675919532775878 WHERE `guid`=81768;
UPDATE `creature` SET `position_x`=7932.935, `position_y`=-7280.28, `position_z`=140.02618, `orientation`=0.624598264694213867 WHERE `guid`=81773;
UPDATE `creature` SET `position_x`=7978.2153, `position_y`=-7314.3267, `position_z`=142.7645, `orientation`=5.090083599090576171 WHERE `guid`=81789;
UPDATE `creature` SET `position_x`=7986.704, `position_y`=-7182.1206, `position_z`=136.10928, `orientation`=0.916203022003173828 WHERE `guid`=81776;
UPDATE `creature` SET `position_x`=7982.987, `position_y`=-7278.188, `position_z`=142.57901, `orientation`=6.258038043975830078 WHERE `guid`=81778;
UPDATE `creature` SET `position_x`=8002.7007, `position_y`=-7216.4355, `position_z`=140.88164, `orientation`=0.245077401399612426 WHERE `guid`=81775;
UPDATE `creature` SET `position_x`=8017.7163, `position_y`=-7319.009, `position_z`=143.38083, `orientation`=2.097393989562988281 WHERE `guid`=81802;
UPDATE `creature` SET `position_x`=8019.029, `position_y`=-7278.618, `position_z`=141.91353, `orientation`=0.881062269210815429 WHERE `guid`=82111;
UPDATE `creature` SET `position_x`=8019.0337, `position_y`=-7182.7383, `position_z`=136.10959, `orientation`=2.62692880630493164 WHERE `guid`=81777;
UPDATE `creature` SET `position_x`=8037.097, `position_y`=-7362.474, `position_z`=144.15495, `orientation`=4.267343997955322265 WHERE `guid`=81804;
UPDATE `creature` SET `position_x`=8045.23, `position_y`=-7285.9673, `position_z`=141.19753, `orientation`=4.222597122192382812 WHERE `guid`=81827;
UPDATE `creature` SET `position_x`=8047.971, `position_y`=-7315.4497, `position_z`=141.55814, `orientation`=1.364494681358337402 WHERE `guid`=81779;
UPDATE `creature` SET `position_x`=8051.4897, `position_y`=-7244.594, `position_z`=142.79373, `orientation`=1.455305337905883789 WHERE `guid`=81786;
UPDATE `creature` SET `position_x`=8050.903, `position_y`=-7185.6304, `position_z`=141.23912, `orientation`=0.224479854106903076 WHERE `guid`=82112;
UPDATE `creature` SET `position_x`=8052.1313, `position_y`=-7384.1016, `position_z`=165.17769, `orientation`=3.334594964981079101 WHERE `guid`=81811;
UPDATE `creature` SET `position_x`=8049.752, `position_y`=-7549.5767, `position_z`=150.15224, `orientation`=1.507288813591003417 WHERE `guid`=81823;
UPDATE `creature` SET `position_x`=8053.758, `position_y`=-7511.7935, `position_z`=150.82181, `orientation`=0.983593106269836425 WHERE `guid`=81821;
UPDATE `creature` SET `position_x`=8057.4673, `position_y`=-7371.387, `position_z`=143.97952, `orientation`=0.921935975551605224 WHERE `guid`=81807;
UPDATE `creature` SET `position_x`=8058.329, `position_y`=-7364.76, `position_z`=164.47891, `orientation`=1.952818632125854492 WHERE `guid`=81812;
UPDATE `creature` SET `position_x`=8085.4106, `position_y`=-7349.3037, `position_z`=140.41075, `orientation`=1.29018402099609375 WHERE `guid`=81806;
UPDATE `creature` SET `position_x`=8080.5312, `position_y`=-7317.009, `position_z`=142.25566, `orientation`=1.856836676597595214 WHERE `guid`=81815;
UPDATE `creature` SET `position_x`=8081.1104, `position_y`=-7591.1626, `position_z`=149.2503, `orientation`=3.104130983352661132 WHERE `guid`=81828;
UPDATE `creature` SET `position_x`=8084.3022, `position_y`=-7487.1997, `position_z`=150.96777, `orientation`=2.151896953582763671 WHERE `guid`=81814;
UPDATE `creature` SET `position_x`=8086.9863, `position_y`=-7380.058, `position_z`=164.30424, `orientation`=6.280980110168457031 WHERE `guid`=81808;
UPDATE `creature` SET `position_x`=8084.085, `position_y`=-7386.243, `position_z`=143.51062, `orientation`=0.480680257081985473 WHERE `guid`=81809;
UPDATE `creature` SET `position_x`=8115.0537, `position_y`=-7548.682, `position_z`=173.07104, `orientation`=1.374262452125549316 WHERE `guid`=81822;
UPDATE `creature` SET `position_x`=8119.0034, `position_y`=-7483.1997, `position_z`=153.47397, `orientation`=2.642226457595825195 WHERE `guid`=81817;
UPDATE `creature` SET `position_x`=8116.2554, `position_y`=-7587.172, `position_z`=160.12703, `orientation`=5.308646202087402343 WHERE `guid`=81826;
UPDATE `creature` SET `position_x`=8118.783, `position_y`=-7611.8984, `position_z`=148.70592, `orientation`=0.906582891941070556 WHERE `guid`=81825;
UPDATE `creature` SET `position_x`=8049.288, `position_y`=-7578.174, `position_z`=148.62862, `orientation`=0.983593106269836425 WHERE `guid`=81818;
UPDATE `creature` SET `position_x`=8120.1196, `position_y`=-7518.934, `position_z`=168.00075, `orientation`=3.149159193038940429 WHERE `guid`=81820;
UPDATE `creature` SET `position_x`=8149.155, `position_y`=-7485.593, `position_z`=151.39754, `orientation`=3.898998260498046875 WHERE `guid`=81829;
UPDATE `creature` SET `position_x`=8145.6157, `position_y`=-7614.4966, `position_z`=149.45955, `orientation`=2.301557064056396484 WHERE `guid`=81819;
UPDATE `creature` SET `position_x`=8150.204, `position_y`=-7583.5693, `position_z`=156.19228, `orientation`=4.686991691589355468 WHERE `guid`=81791;
UPDATE `creature` SET `position_x`=8155.163, `position_y`=-7549.097, `position_z`=156.29398, `orientation`=0.795627057552337646 WHERE `guid`=81792;
UPDATE `creature` SET `position_x`=8149.278, `position_y`=-7514.165, `position_z`=157.83986, `orientation`=2.711774826049804687 WHERE `guid`=81795;
UPDATE `creature` SET `position_x`=8050.1787, `position_y`=-7413.635, `position_z`=147.04948, `orientation`=5.355109214782714843 WHERE `guid`=81744;
UPDATE `creature` SET `position_x`=8019.5146, `position_y`=-7387.6196, `position_z`=143.35431, `orientation`=0.007975091226398944 WHERE `guid`=81798;
UPDATE `creature` SET `position_x`=8016.048, `position_y`=-7415.3506, `position_z`=146.32059, `orientation`=3.04085540771484375 WHERE `guid`=81781;
UPDATE `creature` SET `position_x`=8083.0146, `position_y`=-7252.842, `position_z`=141.04585, `orientation`=4.51193094253540039 WHERE `guid`=81803;
UPDATE `creature` SET `position_x`=8064.4443, `position_y`=-7226.681, `position_z`=142.77878, `orientation`=1.581316232681274414 WHERE `guid`=81813;
UPDATE `creature` SET `position_x`=8059.8994, `position_y`=-7235.2104, `position_z`=142.77878, `orientation`=1.696429610252380371 WHERE `guid`=81787;
UPDATE `creature` SET `position_x`=8048.194, `position_y`=-7215.254, `position_z`=158.66579, `orientation`=0.457142353057861328 WHERE `guid`=81824;
UPDATE `creature` SET `position_x`=8075.539, `position_y`=-7209.988, `position_z`=158.665, `orientation`=5.834308624267578125 WHERE `guid`=81805;
UPDATE `creature` SET `position_x`=8064.885, `position_y`=-7227.9834, `position_z`=158.66376, `orientation`=5.772104740142822265 WHERE `guid`=81816;
UPDATE `creature` SET `position_x`=8080.6973, `position_y`=-7237.239, `position_z`=158.66457, `orientation`=2.20580911636352539 WHERE `guid`=81783;
UPDATE `creature` SET `position_x`=8003.2197, `position_y`=-7356.0254, `position_z`=140.66624, `orientation`=0.265046238899230957 WHERE `guid`=81780;
UPDATE `creature` SET `equipment_id`=0, `wander_distance`=5, `MovementType`=1 WHERE `id`=16313;

-- Pathing for Nerubis Guard Entry: 16313
SET @NPC := 81810;
SET @PATH := @NPC * 10;
UPDATE `creature` SET `wander_distance`=0,`MovementType`=2 WHERE `guid`=@NPC;
DELETE FROM `creature_addon` WHERE `guid`=@NPC;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes1`,`bytes2`,`emote`,`visibilityDistanceType`,`auras`) VALUES (@NPC,@PATH,0,0,1,0,0, '');
DELETE FROM `waypoint_data` WHERE `id`=@PATH;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`orientation`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
(@PATH,1,8033.643,-7371.144,165.0797,0,0,0,0,100,0),
(@PATH,2,8040.8535,-7353.647,164.41042,0,0,0,0,100,0),
(@PATH,3,8056.7363,-7345.7485,163.84886,0,0,0,0,100,0),
(@PATH,4,8074,-7351.9585,163.66876,0,0,0,0,100,0),
(@PATH,5,8081.6147,-7362.401,163.82063,0,0,0,0,100,0),
(@PATH,6,8082.8716,-7378.999,164.28584,0,0,0,0,100,0),
(@PATH,7,8089.9097,-7380.9316,164.1907,0,0,0,0,100,0),
(@PATH,8,8094.854,-7362.633,159.5596,0,0,0,0,100,0),
(@PATH,9,8088.7847,-7351.132,155.29066,0,0,0,0,100,0),
(@PATH,10,8076.145,-7342.5244,152.84624,0,0,0,0,100,0),
(@PATH,11,8070.358,-7342.4834,152.83412,0,0,0,0,100,0),
(@PATH,12,8059.011,-7370.053,153.78862,0,0,0,0,100,0),
(@PATH,13,8051.393,-7386.35,152.3984,0,0,0,0,100,0),
(@PATH,14,8041.9385,-7383.407,149.58453,0,0,0,0,100,0),
(@PATH,15,8038.7256,-7376.1484,145.88435,0,0,0,0,100,0),
(@PATH,16,8040.108,-7364.4365,144.06822,0,0,0,0,100,0),
(@PATH,17,8020.9272,-7354.7837,140.86281,0,0,0,0,100,0),
(@PATH,18,8040.108,-7364.4365,144.06822,0,0,0,0,100,0),
(@PATH,19,8038.7256,-7376.1484,145.88435,0,0,0,0,100,0),
(@PATH,20,8041.9385,-7383.407,149.58453,0,0,0,0,100,0),
(@PATH,21,8051.393,-7386.35,152.3984,0,0,0,0,100,0),
(@PATH,22,8059.011,-7370.053,153.78862,0,0,0,0,100,0),
(@PATH,23,8070.358,-7342.4834,152.83412,0,0,0,0,100,0),
(@PATH,24,8076.145,-7342.5244,152.84624,0,0,0,0,100,0),
(@PATH,25,8088.7847,-7351.132,155.29066,0,0,0,0,100,0),
(@PATH,26,8088.7847,-7351.132,155.29066,0,0,0,0,100,0),
(@PATH,27,8094.854,-7362.633,159.5596,0,0,0,0,100,0),
(@PATH,28,8089.9097,-7380.9316,164.1907,0,0,0,0,100,0),
(@PATH,29,8082.8716,-7378.999,164.28584,0,0,0,0,100,0),
(@PATH,30,8081.6147,-7362.401,163.82063,0,0,0,0,100,0),
(@PATH,31,8074,-7351.9585,163.66876,0,0,0,0,100,0),
(@PATH,32,8056.7363,-7345.7485,163.84886,0,0,0,0,100,0),
(@PATH,33,8040.8535,-7353.647,164.41042,0,0,0,0,100,0),
(@PATH,34,8033.643,-7371.144,165.0797,0,0,0,0,100,0),
(@PATH,35,8038.7603,-7383.5,165.34204,0,0,0,0,100,0);

-- Pathing for Nerubis Guard Entry: 16313
SET @NPC := 81787;
SET @PATH := @NPC * 10;
UPDATE `creature` SET `wander_distance`=0,`MovementType`=2 WHERE `guid`=@NPC;
DELETE FROM `creature_addon` WHERE `guid`=@NPC;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes1`,`bytes2`,`emote`,`visibilityDistanceType`,`auras`) VALUES (@NPC,@PATH,0,0,1,0,0, '');
DELETE FROM `waypoint_data` WHERE `id`=@PATH;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`orientation`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
(@PATH,1,8059.7866,-7234.3174,142.74286,0,0,0,0,100,0),
(@PATH,2,8043.001,-7257.784,140.44353,0,0,0,0,100,0),
(@PATH,3,8031.8647,-7253.7134,140.51013,0,0,0,0,100,0),
(@PATH,4,8028.828,-7227.35,139.8902,0,0,0,0,100,0),
(@PATH,5,8045.1406,-7206.0024,149.90591,0,0,0,0,100,0),
(@PATH,6,8054.3125,-7201.0605,153.15536,0,0,0,0,100,0),
(@PATH,7,8062.401,-7201.203,156.12938,0,0,0,0,100,0),
(@PATH,8,8075.4395,-7211.2393,158.62915,0,0,0,0,100,0),
(@PATH,9,8056.79,-7237.8306,158.63235,0,0,0,0,100,0),
(@PATH,10,8075.4395,-7211.2393,158.62915,0,0,0,0,100,0),
(@PATH,11,8062.401,-7201.203,156.12938,0,0,0,0,100,0),
(@PATH,12,8054.413,-7201.0063,153.1906,0,0,0,0,100,0),
(@PATH,13,8045.1406,-7206.0024,149.90591,0,0,0,0,100,0),
(@PATH,14,8028.828,-7227.35,139.8902,0,0,0,0,100,0),
(@PATH,15,8031.8647,-7253.7134,140.51013,0,0,0,0,100,0),
(@PATH,16,8043.001,-7257.784,140.44353,0,0,0,0,100,0);

-- Pathing for Nerubis Guard Entry: 16313
SET @NPC := 81774;
SET @PATH := @NPC * 10;
UPDATE `creature` SET `wander_distance`=0,`MovementType`=2 WHERE `guid`=@NPC;
DELETE FROM `creature_addon` WHERE `guid`=@NPC;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes1`,`bytes2`,`emote`,`visibilityDistanceType`,`auras`) VALUES (@NPC,@PATH,0,0,1,0,0, '');
DELETE FROM `waypoint_data` WHERE `id`=@PATH;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`orientation`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
(@PATH,1,7948.3926,-7299.041,139.3423,0,0,0,0,100,0),
(@PATH,2,7950.742,-7287.3726,138.23781,0,0,0,0,100,0),
(@PATH,3,7918.5625,-7276.8574,139.9279,0,0,0,0,100,0),
(@PATH,4,7950.742,-7287.3726,138.23781,0,0,0,0,100,0),
(@PATH,5,7948.3926,-7299.041,139.3423,0,0,0,0,100,0),
(@PATH,6,7930.652,-7307.738,139.65376,0,0,0,0,100,0),
(@PATH,7,7904.759,-7302.8438,144.49107,0,0,0,0,100,0),
(@PATH,8,7890.218,-7292.889,149.99257,0,0,0,0,100,0),
(@PATH,9,7889.828,-7277.808,155.13405,0,0,0,0,100,0),
(@PATH,10,7892.1943,-7269.5376,155.81406,0,0,0,0,100,0),
(@PATH,11,7912.4756,-7274.6274,155.82387,0,0,0,0,100,0),
(@PATH,12,7924.9443,-7278.246,155.81685,0,0,0,0,100,0),
(@PATH,13,7912.4756,-7274.6274,155.82387,0,0,0,0,100,0),
(@PATH,14,7892.1943,-7269.5376,155.81406,0,0,0,0,100,0),
(@PATH,15,7889.8325,-7277.7925,155.13788,0,0,0,0,100,0),
(@PATH,16,7890.218,-7292.889,149.99257,0,0,0,0,100,0),
(@PATH,17,7904.759,-7302.8438,144.49107,0,0,0,0,100,0),
(@PATH,18,7930.652,-7307.738,139.65376,0,0,0,0,100,0);

-- Pathing for Nerubis Guard Entry: 16313
SET @NPC := 81780;
SET @PATH := @NPC * 10;
UPDATE `creature` SET `wander_distance`=0,`MovementType`=2 WHERE `guid`=@NPC;
DELETE FROM `creature_addon` WHERE `guid`=@NPC;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes1`,`bytes2`,`emote`,`visibilityDistanceType`,`auras`) VALUES (@NPC,@PATH,0,0,1,0,0, '');
DELETE FROM `waypoint_data` WHERE `id`=@PATH;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`orientation`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
(@PATH,1,8005.139,-7355.5044,140.77748,0,0,0,0,100,0),
(@PATH,2,8022.629,-7351.25,141.15248,0,0,0,0,100,0),
(@PATH,3,8037.9766,-7343.384,141.1213,0,0,0,0,100,0),
(@PATH,4,8048.9287,-7325.928,141.03996,0,0,0,0,100,0),
(@PATH,5,8059.8706,-7305.5493,141.4163,0,0,0,0,100,0),
(@PATH,6,8057.078,-7277.6445,140.63231,0,0,0,0,100,0),
(@PATH,7,8044.9673,-7262.834,140.56853,0,0,0,0,100,0),
(@PATH,8,8018.8813,-7248.543,140.63513,0,0,0,0,100,0),
(@PATH,9,8002.0835,-7244.932,140.01013,0,0,0,0,100,0),
(@PATH,10,7979.1963,-7250.8296,137.36232,0,0,0,0,100,0),
(@PATH,11,7959.9375,-7262.9375,137.16505,0,0,0,0,100,0),
(@PATH,12,7951.943,-7287.8804,138.21864,0,0,0,0,100,0),
(@PATH,13,7950.151,-7316.854,140.35782,0,0,0,0,100,0),
(@PATH,14,7956.857,-7334.874,140.92525,0,0,0,0,100,0),
(@PATH,15,7971.9644,-7348.172,139.4391,0,0,0,0,100,0);

-- Pathing for Anok'suten Entry: 16357
SET @NPC := 81785;
SET @PATH := @NPC * 10;
UPDATE `creature` SET `wander_distance`=0,`MovementType`=2,`position_x`=8022.0244,`position_y`=-7250.6743,`position_z`=140.63289, `Orientation`=2.715512275695800781 WHERE `guid`=@NPC;
DELETE FROM `creature_addon` WHERE `guid`=@NPC;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes1`,`bytes2`,`emote`,`visibilityDistanceType`,`auras`) VALUES (@NPC,@PATH,0,0,1,0,0, '');
DELETE FROM `waypoint_data` WHERE `id`=@PATH;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`orientation`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
(@PATH,1,7989.3853,-7246.862,138.67287,0,0,0,0,100,0),
(@PATH,2,7973.8228,-7252.6577,137.25917,0,0,0,0,100,0),
(@PATH,3,7962.366,-7261.485,137.04005,0,0,0,0,100,0),
(@PATH,4,7953.876,-7280.6797,137.76442,0,0,0,0,100,0),
(@PATH,5,7918.577,-7304.7744,140.1208,0,0,0,0,100,0),
(@PATH,6,7904.5815,-7301.776,144.68105,0,0,0,0,100,0),
(@PATH,7,7894.837,-7297.364,147.89558,0,0,0,0,100,0),
(@PATH,8,7890.0625,-7290.992,150.63379,0,0,0,0,100,0),
(@PATH,9,7889.0244,-7283.2954,153.71674,0,0,0,0,100,0),
(@PATH,10,7890.96,-7275.3027,155.81384,0,0,0,0,100,0),
(@PATH,11,7900.647,-7265.4077,155.81778,0,0,0,0,100,0),
(@PATH,12,7909.0566,-7261.003,155.81693,0,0,0,0,100,0),
(@PATH,13,7920.6763,-7263.211,155.81726,0,0,0,0,100,0),
(@PATH,14,7925.768,-7272.3706,155.81432,0,0,0,0,100,0),
(@PATH,15,7923.9473,-7281.567,155.81458,0,0,0,0,100,0),
(@PATH,16,7913.2866,-7288.8774,155.8172,0,0,0,0,100,0),
(@PATH,17,7902.268,-7284.6,155.81781,0,0,0,0,100,0),
(@PATH,18,7896.721,-7274.737,155.81569,0,0,0,0,100,0),
(@PATH,19,7892.6104,-7273.857,155.81433,0,0,0,0,100,0),
(@PATH,20,7889.3013,-7277.143,155.2871,0,0,0,0,100,0),
(@PATH,21,7888.722,-7288.2344,151.63979,0,0,0,0,100,0),
(@PATH,22,7891.923,-7295.921,148.78302,0,0,0,0,100,0),
(@PATH,23,7908.8823,-7303.67,142.74924,0,0,0,0,100,0),
(@PATH,24,7930.0903,-7317.6685,141.22017,0,0,0,0,100,0),
(@PATH,25,7955.0176,-7333.0054,140.89871,0,0,0,0,100,0),
(@PATH,26,7965.2476,-7344.0376,140.29329,0,0,0,0,100,0),
(@PATH,27,7984.58,-7354.614,138.95168,0,0,0,0,100,0),
(@PATH,28,8021.0947,-7357.2993,141.18483,0,0,0,0,100,0),
(@PATH,29,8031.5723,-7361.1997,144.14993,0,0,0,0,100,0),
(@PATH,30,8035.413,-7367.5054,144.25429,0,0,0,0,100,0),
(@PATH,31,8040.828,-7367.184,144.13156,0,0,0,0,100,0),
(@PATH,32,8042.856,-7361.6475,143.927,0,0,0,0,100,0),
(@PATH,33,8038.6978,-7358.2466,143.91435,0,0,0,0,100,0),
(@PATH,34,8033.383,-7360.155,144.08145,0,0,0,0,100,0),
(@PATH,35,8028.712,-7359.1294,143.39352,0,0,0,0,100,0),
(@PATH,36,8023.759,-7356.303,141.31606,0,0,0,0,100,0),
(@PATH,37,8023.71,-7353.0522,141.3102,0,0,0,0,100,0),
(@PATH,38,8039.088,-7342.489,141.1213,0,0,0,0,100,0),
(@PATH,39,8052.1616,-7325.52,141.14775,0,0,0,0,100,0),
(@PATH,40,8057.1235,-7312.013,141.27275,0,0,0,0,100,0),
(@PATH,41,8058.7734,-7296.549,141.38231,0,0,0,0,100,0),
(@PATH,42,8056.56,-7279.0728,140.63231,0,0,0,0,100,0),
(@PATH,43,8052.099,-7267.522,140.50731,0,0,0,0,100,0),
(@PATH,44,8044.862,-7261.3804,140.44353,0,0,0,0,100,0),
(@PATH,45,8044.366,-7256.9663,140.44353,0,0,0,0,100,0),
(@PATH,46,8048.0747,-7251.486,142.7578,0,0,0,0,100,0),
(@PATH,47,8057.78,-7236.897,142.74286,0,0,0,0,100,0),
(@PATH,48,8062.8853,-7235.33,142.74286,0,0,0,0,100,0),
(@PATH,49,8070.741,-7231.8384,142.74284,0,0,0,0,100,0),
(@PATH,50,8070.8423,-7224.639,142.74284,0,0,0,0,100,0),
(@PATH,51,8064.472,-7219.7246,142.74284,0,0,0,0,100,0),
(@PATH,52,8057.474,-7223.617,142.74286,0,0,0,0,100,0),
(@PATH,53,8056.8037,-7228.8247,142.74286,0,0,0,0,100,0),
(@PATH,54,8058.48,-7235.7656,142.74286,0,0,0,0,100,0),
(@PATH,55,8053.2397,-7243.334,142.75194,0,0,0,0,100,0),
(@PATH,56,8047.385,-7251.423,142.75778,0,0,0,0,100,0),
(@PATH,57,8042.708,-7257.291,140.44353,0,0,0,0,100,0),
(@PATH,58,8039.7646,-7258.069,140.44353,0,0,0,0,100,0),
(@PATH,59,8029.763,-7253.808,140.51013,0,0,0,0,100,0),
(@PATH,60,8019.065,-7249.331,140.63513,0,0,0,0,100,0);

-- Pathing for Lieutenant Tomathren Entry: 16217
SET @NPC := 82035;
SET @PATH := @NPC * 10;
UPDATE `creature` SET `wander_distance`=0,`MovementType`=2,`position_x`=7939.3125,`position_y`=-7570.184,`position_z`=145.08609 WHERE `guid`=@NPC;
DELETE FROM `creature_addon` WHERE `guid`=@NPC;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes1`,`bytes2`,`emote`,`visibilityDistanceType`,`auras`) VALUES (@NPC,@PATH,0,0,2,0,0, '');
DELETE FROM `waypoint_data` WHERE `id`=@PATH;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`orientation`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
(@PATH,1,7939.3125,-7570.184,145.08609,0,0,0,0,100,0),
(@PATH,2,7936.692,-7573.077,144.98636,0,0,0,0,100,0),
(@PATH,3,7933.509,-7571.933,145.58719,0,0,0,0,100,0),
(@PATH,4,7932.492,-7568.6675,145.68219,0,0,0,0,100,0),
(@PATH,5,7935.133,-7565.3193,145.54666,0,0,0,0,100,0),
(@PATH,6,7938.384,-7566.494,145.52103,0,0,0,0,100,0);

-- Zeb'Sora
UPDATE `creature` SET `id`=16341, `position_x`=7950.184, `position_y`=-7716.028, `position_z`=147.70898, `orientation`=4.932586669921875, `curhealth`=1, `curmana`=0 WHERE `guid`=81830;
UPDATE `creature` SET `id`=16341, `position_x`=7947.885, `position_y`=-7754.5312, `position_z`=154.45023, `orientation`=0.951909244060516357, `curhealth`=1, `curmana`=0 WHERE `guid`=81834;
UPDATE `creature` SET `id`=16340, `position_x`=7983.6494, `position_y`=-7717.0557, `position_z`=146.68106, `orientation`=4.956980705261230468, `curhealth`=1, `curmana`=0 WHERE `guid`=81836;
UPDATE `creature` SET `id`=16340, `position_x`=8010.9644, `position_y`=-7758.858, `position_z`=152.25708, `orientation`=5.637413501739501953, `curhealth`=1, `curmana`=0 WHERE `guid`=81837;
UPDATE `creature` SET `id`=16340, `position_x`=8026.048, `position_y`=-7757.151, `position_z`=151.98375, `orientation`=2.600540637969970703, `curhealth`=1, `curmana`=0 WHERE `guid`=81838;
UPDATE `creature` SET `id`=16340, `position_x`=7999.6016, `position_y`=-7738.1606, `position_z`=150.71187, `orientation`=4.555309295654296875, `curhealth`=1, `curmana`=0 WHERE `guid`=81840;
UPDATE `creature` SET `id`=16341, `position_x`=7977.1875, `position_y`=-7755.3516, `position_z`=151.73875, `orientation`=0.471238881349563598, `curhealth`=1, `curmana`=0 WHERE `guid`=81843;
UPDATE `creature` SET `id`=16341, `position_x`=7999.9287, `position_y`=-7727.414, `position_z`=151.52362, `orientation`=4.904375076293945312, `curhealth`=1, `curmana`=0 WHERE `guid`=81845;
UPDATE `creature` SET `id`=16341, `position_x`=8014.6426, `position_y`=-7714.463, `position_z`=149.17056, `orientation`=3.897283077239990234, `curhealth`=1, `curmana`=0 WHERE `guid`=81848;
UPDATE `creature` SET `id`=16340, `position_x`=8048.454, `position_y`=-7749.7915, `position_z`=155.80626, `orientation`=2.870305776596069335, `curhealth`=1, `curmana`=0 WHERE `guid`=81852;
UPDATE `creature` SET `id`=16340, `position_x`=8045.0337, `position_y`=-7846.7925, `position_z`=179.52547, `orientation`=5.188807487487792968, `curhealth`=1, `curmana`=0 WHERE `guid`=81854;
UPDATE `creature` SET `id`=16341, `position_x`=8012.868, `position_y`=-7785.3926, `position_z`=166.52962, `orientation`=5.404375076293945312, `curhealth`=1, `curmana`=0 WHERE `guid`=81831;
UPDATE `creature` SET `id`=16340, `position_x`=8081.817, `position_y`=-7815.8125, `position_z`=170.2799, `orientation`=2.079246997833251953, `curhealth`=1, `curmana`=0 WHERE `guid`=81833;
UPDATE `creature` SET `id`=16340, `position_x`=8033.663, `position_y`=-7806.441, `position_z`=168.05342, `orientation`=4.415682792663574218, `curhealth`=1, `curmana`=0 WHERE `guid`=81835;
UPDATE `creature` SET `id`=16341, `position_x`=8043.9634, `position_y`=-7785.6753, `position_z`=167.81241, `orientation`=3.857177734375, `curhealth`=1, `curmana`=0 WHERE `guid`=81839;
UPDATE `creature` SET `id`=16341, `position_x`=7984.847, `position_y`=-7785.586, `position_z`=159.48598, `orientation`=0.929249286651611328, `curhealth`=1, `curmana`=0 WHERE `guid`=81842;
UPDATE `creature` SET `id`=16340, `position_x`=8050.8047, `position_y`=-7821.547, `position_z`=169.22458, `orientation`=1.01261138916015625, `curhealth`=1, `curmana`=0 WHERE `guid`=81844;
UPDATE `creature` SET `id`=16340, `position_x`=7981.7744, `position_y`=-7818.1406, `position_z`=170.69917, `orientation`=4.563305854797363281, `curhealth`=1, `curmana`=0 WHERE `guid`=81849;
UPDATE `creature` SET `id`=16340, `position_x`=8036.8193, `position_y`=-7853.5625, `position_z`=180.80864, `orientation`=6.2657318115234375, `curhealth`=1, `curmana`=0 WHERE `guid`=81850;
UPDATE `creature` SET `id`=16341, `position_x`=8015.9966, `position_y`=-7846.4785, `position_z`=180.51056, `orientation`=1.182463884353637695, `curhealth`=1, `curmana`=0 WHERE `guid`=81851;
UPDATE `creature` SET `id`=16340, `position_x`=7998.8774, `position_y`=-7839.7056, `position_z`=177.41937, `orientation`=4.694935798645019531, `curhealth`=1, `curmana`=0 WHERE `guid`=81855;
UPDATE `creature` SET `id`=16340, `position_x`=8054.8306, `position_y`=-7865.0713, `position_z`=180.52309, `orientation`=2.059488534927368164, `curhealth`=1, `curmana`=0 WHERE `guid`=81856;
UPDATE `creature` SET `id`=16341, `position_x`=7988.116, `position_y`=-7849.2925, `position_z`=177.58176, `orientation`=1.064650893211364746, `curhealth`=1, `curmana`=0 WHERE `guid`=81896;
UPDATE `creature` SET `wander_distance`=0, `MovementType`=0 WHERE `id` IN (16340,16341);
UPDATE `creature` SET `wander_distance`=5, `MovementType`=1 WHERE `guid` IN (81830,81831,81833,81834,81836,81842,81844,81848,81849,81851,81852);
UPDATE `creature` SET `equipment_id`=0 WHERE `id`=16340;

-- Add missing aura to Shadowpine Witch
UPDATE `creature_template_addon` SET `auras`='12550' WHERE `entry`=16341;

-- Pathing for Shadowpine Ripper Entry: 16341
SET @NPC := 81854;
SET @PATH := @NPC * 10;
UPDATE `creature` SET `wander_distance`=0,`MovementType`=2 WHERE `guid`=@NPC;
DELETE FROM `creature_addon` WHERE `guid`=@NPC;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes1`,`bytes2`,`emote`,`visibilityDistanceType`,`auras`) VALUES (@NPC,@PATH,0,0,1,0,0, '');
DELETE FROM `waypoint_data` WHERE `id`=@PATH;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`orientation`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
(@PATH,1,8048.2744,-7853.059,180.01794,0,0,0,0,100,0),
(@PATH,2,8040.105,-7843.557,178.39294,0,0,0,0,100,0),
(@PATH,3,8029.627,-7832.954,174.46281,0,0,0,0,100,0),
(@PATH,4,8020.1196,-7826.1553,172.82353,0,0,0,0,100,0),
(@PATH,5,8005.4463,-7833.5337,175.81493,0,0,0,0,100,0),
(@PATH,6,7990.7524,-7833.9497,176.87799,0,0,0,0,100,0),
(@PATH,7,8009.6694,-7833.4688,175.17601,0,0,0,0,100,0),
(@PATH,8,8018.837,-7825.397,172.67534,0,0,0,0,100,0),
(@PATH,9,8023.389,-7808.493,168.68266,0,0,0,0,100,0),
(@PATH,10,8033.8115,-7799.6235,167.82736,0,0,0,0,100,0),
(@PATH,11,8013.4106,-7797.3896,166.5028,0,0,0,0,100,0),
(@PATH,12,7988.7153,-7791.19,160.87088,0,0,0,0,100,0),
(@PATH,13,7987.1895,-7769.5503,153.56888,0,0,0,0,100,0),
(@PATH,14,7990.617,-7758.394,152.00461,0,0,0,0,100,0),
(@PATH,15,8001.1113,-7749.106,150.56528,0,0,0,0,100,0),
(@PATH,16,8013.276,-7741.1353,151.64206,0,0,0,0,100,0),
(@PATH,17,8023.3896,-7726.5923,151.38942,0,0,0,0,100,0),
(@PATH,18,8013.276,-7741.1353,151.64206,0,0,0,0,100,0),
(@PATH,19,8001.1113,-7749.106,150.56528,0,0,0,0,100,0),
(@PATH,20,7990.625,-7758.375,152.00461,0,0,0,0,100,0),
(@PATH,21,7987.1895,-7769.5503,153.56888,0,0,0,0,100,0),
(@PATH,22,7988.7153,-7791.19,160.87088,0,0,0,0,100,0),
(@PATH,23,8013.4106,-7797.3896,166.5028,0,0,0,0,100,0),
(@PATH,24,8033.8115,-7799.6235,167.82736,0,0,0,0,100,0),
(@PATH,25,8023.389,-7808.493,168.68266,0,0,0,0,100,0),
(@PATH,26,8018.837,-7825.397,172.67534,0,0,0,0,100,0),
(@PATH,27,8009.6694,-7833.4688,175.17601,0,0,0,0,100,0),
(@PATH,28,7990.7524,-7833.9497,176.87799,0,0,0,0,100,0),
(@PATH,29,8005.4463,-7833.5337,175.81493,0,0,0,0,100,0),
(@PATH,30,8020.1196,-7826.1553,172.82353,0,0,0,0,100,0),
(@PATH,31,8029.627,-7832.954,174.46281,0,0,0,0,100,0),
(@PATH,32,8040.105,-7843.557,178.39294,0,0,0,0,100,0);

-- Pathing for Shadowpine Witch Entry: 16340
SET @NPC := 81845;
SET @PATH := @NPC * 10;
UPDATE `creature` SET `wander_distance`=0,`MovementType`=2 WHERE `guid`=@NPC;
DELETE FROM `creature_addon` WHERE `guid`=@NPC;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes1`,`bytes2`,`emote`,`visibilityDistanceType`,`auras`) VALUES (@NPC,@PATH,0,0,1,0,0, '');
DELETE FROM `waypoint_data` WHERE `id`=@PATH;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`orientation`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
(@PATH,1,7967.397,-7730.7065,149.00012,0,0,0,0,100,0),
(@PATH,2,7952.599,-7766.23,156.92992,0,0,0,0,100,0),
(@PATH,3,7982.2334,-7799.819,164.07877,0,0,0,0,100,0),
(@PATH,4,7992.651,-7828.961,176.4998,0,0,0,0,100,0),
(@PATH,5,8017.0425,-7846.4316,180.38597,0,0,0,0,100,0),
(@PATH,6,8050.9653,-7840.468,179.09497,0,0,0,0,100,0),
(@PATH,7,8075.693,-7818.263,170.33063,0,0,0,0,100,0),
(@PATH,8,8075.725,-7780.474,165.57294,0,0,0,0,100,0),
(@PATH,9,8056.597,-7753.424,157.44112,0,0,0,0,100,0),
(@PATH,10,8021.6196,-7727.0376,151.44264,0,0,0,0,100,0),
(@PATH,11,7997.29,-7724.7847,149.34265,0,0,0,0,100,0);

-- Lake Elremdar
-- Ravening Apparition Entry: 16327
UPDATE `creature` SET `position_x`=7643.9087, `position_y`=-7654.8345, `position_z`=126.60103, `orientation`=4.276057243347167968 WHERE `guid`=81871;
UPDATE `creature` SET `position_x`=7753.204, `position_y`=-7617.694, `position_z`=143.76439, `orientation`=3.918355464935302734 WHERE `guid`=81872;
UPDATE `creature` SET `position_x`=7717.6206, `position_y`=-7653.2544, `position_z`=145.30212, `orientation`=0.912793576717376708 WHERE `guid`=81873;
UPDATE `creature` SET `position_x`=7783.356, `position_y`=-7713.651, `position_z`=134.2633, `orientation`=0.71807265281677246 WHERE `guid`=81874;
UPDATE `creature` SET `position_x`=7751.0444, `position_y`=-7685.684, `position_z`=139.99017, `orientation`=5.371033191680908203 WHERE `guid`=81875;
UPDATE `creature` SET `position_x`=7883.066, `position_y`=-7611.987, `position_z`=130.09125, `orientation`=5.363660335540771484 WHERE `guid`=81877;
UPDATE `creature` SET `position_x`=7851.7363, `position_y`=-7586.299, `position_z`=119.55782, `orientation`=4.530877590179443359 WHERE `guid`=81878;
UPDATE `creature` SET `position_x`=7946.647, `position_y`=-7614.635, `position_z`=118.88725, `orientation`=4.347442626953125 WHERE `guid`=81880;
UPDATE `creature` SET `position_x`=7784.4385, `position_y`=-7588.4165, `position_z`=128.43668, `orientation`=3.700098037719726562 WHERE `guid`=81885;
-- Vengeful Apparition Entry: 16328
UPDATE `creature` SET `position_x`=7750.791, `position_y`=-7741.144, `position_z`=142.09476, `orientation`=2.133913755416870117 WHERE `guid`=81883;
UPDATE `creature` SET `position_x`=7814.6665, `position_y`=-7684.193, `position_z`=146.63611, `orientation`=3.969826698303222656 WHERE `guid`=81895;
UPDATE `creature` SET `position_x`=7772.8237, `position_y`=-7650.3003, `position_z`=136.22394, `orientation`=5.361404895782470703 WHERE `guid`=81898;
UPDATE `creature` SET `position_x`=7850.087, `position_y`=-7713.76, `position_z`=134.4645, `orientation`=4.914759635925292968 WHERE `guid`=81900;
UPDATE `creature` SET `position_x`=7817.7163, `position_y`=-7614.5312, `position_z`=133.9397, `orientation`=3.957546234130859375 WHERE `guid`=81902;
UPDATE `creature` SET `position_x`=7884.8706, `position_y`=-7683.608, `position_z`=139.4598, `orientation`=5.476381778717041015 WHERE `guid`=81906;
UPDATE `creature` SET `position_x`=7849.493, `position_y`=-7654.489, `position_z`=146.66054, `orientation`=2.375353336334228515 WHERE `guid`=82019;
UPDATE `creature` SET `position_x`=7917.6772, `position_y`=-7651.6997, `position_z`=118.304405, `orientation`=5.524006366729736328 WHERE `guid`=82021;
UPDATE `creature` SET `position_x`=7681.146, `position_y`=-7685.6973, `position_z`=121.68097, `orientation`=4.341725349426269531 WHERE `guid`=82022;
UPDATE `creature` SET `wander_distance`=20, `MovementType`=1 WHERE `id` IN (16327,16328);

--
-- END UPDATING QUERIES
--
UPDATE version_db_world SET date = '2021_12_16_06' WHERE sql_rev = '1639063426788133858';
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
