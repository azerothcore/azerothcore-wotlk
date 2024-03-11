-- DB update 2021_12_11_01 -> 2021_12_11_02
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2021_12_11_01';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2021_12_11_01 2021_12_11_02 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1638713468459702407'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1638713468459702407');

-- Respawn Sunsail Anchorage and add pathing

-- Entry: 16162
UPDATE `creature` SET `position_x`=8792.399, `position_y`=-6066.8813, `position_z`=4.8186393, `orientation`=3.657954216003417968, `curhealth`=1, `curmana`=0  WHERE `guid`=56755;
UPDATE `creature` SET `position_x`=8744.483, `position_y`=-6114.815, `position_z`=20.13449, `orientation`=1.200447797775268554, `curhealth`=1, `curmana`=0  WHERE `guid`=56756;
UPDATE `creature` SET `position_x`=8719.377, `position_y`=-6045.9033, `position_z`=10.080724, `orientation`=3.059785127639770507, `curhealth`=1, `curmana`=0  WHERE `guid`=56757;
UPDATE `creature` SET `position_x`=8802.869, `position_y`=-6087.3477, `position_z`=4.8214607, `orientation`=4.469288349151611328, `curhealth`=1, `curmana`=0  WHERE `guid`=56758;
UPDATE `creature` SET `position_x`=8768.191, `position_y`=-6112.8115, `position_z`=20.12771, `orientation`=4.040853500366210937, `curhealth`=1, `curmana`=0  WHERE `guid`=56759;
UPDATE `creature` SET `position_x`=8790.297, `position_y`=-6100.9004, `position_z`=49.37357, `orientation`=0.859713196754455566, `curhealth`=1, `curmana`=0  WHERE `guid`=56760;
UPDATE `creature` SET `position_x`=8759.677, `position_y`=-6107.8594, `position_z`=73.134544, `orientation`=4.11383056640625, `curhealth`=1, `curmana`=0  WHERE `guid`=56761;
UPDATE `creature` SET `position_x`=8707.95, `position_y`=-6125.222, `position_z`=15.401069, `orientation`=5.247717857360839843, `curhealth`=1, `curmana`=0  WHERE `guid`=56762;
UPDATE `creature` SET `position_x`=8769.488, `position_y`=-6181.0806, `position_z`=7.1089487, `orientation`=2.599578619003295898, `curhealth`=1, `curmana`=0  WHERE `guid`=56763;
UPDATE `creature` SET `position_x`=8823.881, `position_y`=-6197.242, `position_z`=6.9515533, `orientation`=4.05263519287109375, `curhealth`=1, `curmana`=0  WHERE `guid`=56764;
UPDATE `creature` SET `position_x`=8790.93, `position_y`=-6195.751, `position_z`=7.7876854, `orientation`=4.92553567886352539, `curhealth`=1, `curmana`=0  WHERE `guid`=56765;
UPDATE `creature` SET `position_x`=8796.261, `position_y`=-6133.534, `position_z`=4.7992897, `orientation`=0.651352286338806152, `curhealth`=1, `curmana`=0  WHERE `guid`=56766;
UPDATE `creature` SET `position_x`=8818.349, `position_y`=-6193.9575, `position_z`=6.9515514, `orientation`=1.479395270347595214, `curhealth`=1, `curmana`=0  WHERE `guid`=56767;
UPDATE `creature` SET `position_x`=8748.649, `position_y`=-6017.694, `position_z`=6.6460543, `orientation`=2.934762954711914062, `curhealth`=1, `curmana`=0  WHERE `guid`=56768;
UPDATE `creature` SET `position_x`=8748.132, `position_y`=-5995.0273, `position_z`=7.0714345, `orientation`=3.49887704849243164, `curhealth`=1, `curmana`=0  WHERE `guid`=56769;
UPDATE `creature` SET `position_x`=8764.446, `position_y`=-5979.7563, `position_z`=5.4162245, `orientation`=4.076509475708007812, `curhealth`=1, `curmana`=0  WHERE `guid`=56770;
UPDATE `creature` SET `position_x`=8757.111, `position_y`=-5919.1846, `position_z`=7.9779406, `orientation`=2.237923383712768554, `curhealth`=1, `curmana`=0  WHERE `guid`=56771;

-- Entry: 15645
UPDATE `creature` SET `position_x`=8804.077, `position_y`=-6098.996, `position_z`=4.8139596, `orientation`=6.062713146209716796, `curhealth`=1, `curmana`=0  WHERE `guid`=55708;
UPDATE `creature` SET `position_x`=8765.95, `position_y`=-6053.089, `position_z`=4.8159776, `orientation`=1.800667285919189453, `curhealth`=1, `curmana`=0  WHERE `guid`=55709;
UPDATE `creature` SET `position_x`=8746.321, `position_y`=-6093.983, `position_z`=20.138645, `orientation`=3.59537816047668457, `curhealth`=1, `curmana`=0  WHERE `guid`=55710;
UPDATE `creature` SET `position_x`=8806.474, `position_y`=-6101.204, `position_z`=20.37033, `orientation`=4.039678573608398437, `curhealth`=1, `curmana`=0  WHERE `guid`=55711;
UPDATE `creature` SET `position_x`=8725.093, `position_y`=-6102.7056, `position_z`=20.231623, `orientation`=5.579626083374023437, `curhealth`=1, `curmana`=0  WHERE `guid`=55712;
UPDATE `creature` SET `position_x`=8709.869, `position_y`=-6084.0186, `position_z`=14.919752, `orientation`=5.777106285095214843, `curhealth`=1, `curmana`=0  WHERE `guid`=55713;
UPDATE `creature` SET `position_x`=8696.824, `position_y`=-6104.001, `position_z`=16.884354, `orientation`=0.211077615618705749, `curhealth`=1, `curmana`=0  WHERE `guid`=55714;
UPDATE `creature` SET `position_x`=8766.109, `position_y`=-6091.0312, `position_z`=20.12771, `orientation`=4.457245826721191406, `curhealth`=1, `curmana`=0  WHERE `guid`=55715;
UPDATE `creature` SET `position_x`=8781.027, `position_y`=-6101.131, `position_z`=72.77925, `orientation`=6.18176889419555664, `curhealth`=1, `curmana`=0  WHERE `guid`=55716;
UPDATE `creature` SET `position_x`=8719.301, `position_y`=-6103.319, `position_z`=49.10902, `orientation`=2.952248811721801757, `curhealth`=1, `curmana`=0  WHERE `guid`=55717;
UPDATE `creature` SET `position_x`=8757.495, `position_y`=-6095.1963, `position_z`=73.119835, `orientation`=0.48869219422340393, `curhealth`=1, `curmana`=0  WHERE `guid`=55718;
UPDATE `creature` SET `position_x`=8767.833, `position_y`=-6148.6426, `position_z`=5.2683363, `orientation`=2.888228416442871093, `curhealth`=1, `curmana`=0  WHERE `guid`=55719;
UPDATE `creature` SET `position_x`=8722.362, `position_y`=-6017.753, `position_z`=7.6567135, `orientation`=4.326428890228271484, `curhealth`=1, `curmana`=0  WHERE `guid`=55720;
UPDATE `creature` SET `id`=15645, `position_x`=8757.697, `position_y`=-5952.1445, `position_z`=6.0995407, `orientation`=4.068219184875488281, `curhealth`=1, `curmana`=0  WHERE `guid`=56772;
UPDATE `creature` SET `id`=15645, `position_x`=8801.224, `position_y`=-5899.2603, `position_z`=11.118219, `orientation`=2.127599716186523437, `curhealth`=1, `curmana`=0  WHERE `guid`=56773;

-- Pathing for Wretched Hooligan Entry: 16162
SET @NPC := 56764;
SET @PATH := @NPC * 10;
UPDATE `creature` SET `wander_distance`=0,`MovementType`=2 WHERE `guid`=@NPC;
DELETE FROM `creature_addon` WHERE `guid`=@NPC;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes1`,`bytes2`,`emote`,`visibilityDistanceType`,`auras`) VALUES (@NPC,@PATH,0,0,1,0,0, '');
DELETE FROM `waypoint_data` WHERE `id`=@PATH;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`orientation`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
(@PATH,1,8790.31,-6193.6553,7.7344847,0,0,0,0,100,0),
(@PATH,2,8770.892,-6191.133,7.8946075,0,0,0,0,100,0),
(@PATH,3,8762.531,-6174.076,6.5267544,0,0,0,0,100,0),
(@PATH,4,8769.129,-6149.3022,5.157575,0,0,0,0,100,0),
(@PATH,5,8785.45,-6130.818,4.745669,0,0,0,0,100,0),
(@PATH,6,8803.583,-6119.035,4.7259707,0,0,0,0,100,0),
(@PATH,7,8805.411,-6100.76,4.7268863,0,0,0,0,100,0),
(@PATH,8,8803.583,-6119.035,4.7259707,0,0,0,0,100,0),
(@PATH,9,8785.45,-6130.818,4.745669,0,0,0,0,100,0),
(@PATH,10,8769.129,-6149.3022,5.157575,0,0,0,0,100,0),
(@PATH,11,8762.531,-6174.076,6.5267544,0,0,0,0,100,0),
(@PATH,12,8770.892,-6191.133,7.8946075,0,0,0,0,100,0),
(@PATH,13,8790.31,-6193.6553,7.7344847,0,0,0,0,100,0),
(@PATH,14,8822.802,-6198.6333,6.8682137,0,0,0,0,100,0);

-- Pathing for Wretched Thug Entry: 15645 
SET @NPC := 55714;
SET @PATH := @NPC * 10;
UPDATE `creature` SET `wander_distance`=0,`MovementType`=2 WHERE `guid`=@NPC;
DELETE FROM `creature_addon` WHERE `guid`=@NPC;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes1`,`bytes2`,`emote`,`visibilityDistanceType`,`auras`) VALUES (@NPC,@PATH,0,0,1,0,0, '');
DELETE FROM `waypoint_data` WHERE `id`=@PATH;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`orientation`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
(@PATH,1,8718.247,-6103.348,20.15411,0,0,0,0,100,0),
(@PATH,2,8740.154,-6103.3945,20.04662,0,0,0,0,100,0),
(@PATH,3,8758.364,-6103.089,20.044338,0,0,0,0,100,0),
(@PATH,4,8796.97,-6100.6807,20.016273,0,0,0,0,100,0),
(@PATH,5,8793.112,-6112.5596,20.497671,0,0,0,0,100,0),
(@PATH,6,8793.045,-6095.002,20.3138,0,0,0,0,100,0),
(@PATH,7,8783.771,-6076.5845,23.091232,0,0,0,0,100,0),
(@PATH,8,8772.813,-6070.7344,27.526878,0,0,0,0,100,0),
(@PATH,9,8755.792,-6070.63,35.44529,0,0,0,0,100,0),
(@PATH,10,8747.8125,-6072.5347,39.54242,0,0,0,0,100,0),
(@PATH,11,8736.914,-6079.4766,45.014812,0,0,0,0,100,0),
(@PATH,12,8728.632,-6091.969,48.9992,0,0,0,0,100,0),
(@PATH,13,8727.409,-6101.3267,49.10123,0,0,0,0,100,0),
(@PATH,14,8728.632,-6091.969,48.9992,0,0,0,0,100,0),
(@PATH,15,8736.914,-6079.4766,45.014812,0,0,0,0,100,0),
(@PATH,16,8747.8125,-6072.5347,39.54242,0,0,0,0,100,0),
(@PATH,17,8755.792,-6070.63,35.44529,0,0,0,0,100,0),
(@PATH,18,8772.701,-6070.6743,27.595491,0,0,0,0,100,0),
(@PATH,19,8783.771,-6076.5845,23.091232,0,0,0,0,100,0),
(@PATH,20,8793.045,-6095.002,20.3138,0,0,0,0,100,0),
(@PATH,21,8793.112,-6112.5596,20.497671,0,0,0,0,100,0),
(@PATH,22,8796.97,-6100.6807,20.016273,0,0,0,0,100,0),
(@PATH,23,8758.364,-6103.089,20.044338,0,0,0,0,100,0),
(@PATH,24,8740.154,-6103.3945,20.04662,0,0,0,0,100,0),
(@PATH,25,8718.247,-6103.348,20.15411,0,0,0,0,100,0),
(@PATH,26,8701.067,-6103.092,16.78898,0,0,0,0,100,0);

-- Pathing for Wretched Thug Entry: 15645 
SET @NPC := 55716;
SET @PATH := @NPC * 10;
UPDATE `creature` SET `wander_distance`=0,`MovementType`=2 WHERE `guid`=@NPC;
DELETE FROM `creature_addon` WHERE `guid`=@NPC;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes1`,`bytes2`,`emote`,`visibilityDistanceType`,`auras`) VALUES (@NPC,@PATH,0,0,1,0,0, '');
DELETE FROM `waypoint_data` WHERE `id`=@PATH;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`orientation`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
(@PATH,1,8775.428,-6100.3423,72.94468,0,0,0,0,100,0),
(@PATH,2,8767.179,-6088.449,72.907005,0,0,0,0,100,0),
(@PATH,3,8756.081,-6086.228,72.9515,0,0,0,0,100,0),
(@PATH,4,8746.539,-6092.935,72.944534,0,0,0,0,100,0),
(@PATH,5,8739.96,-6101.006,72.57038,0,0,0,0,100,0),
(@PATH,6,8740.239,-6108.4824,72.05762,0,0,0,0,100,0),
(@PATH,7,8743.731,-6115.136,70.11161,0,0,0,0,100,0),
(@PATH,8,8751.771,-6121.09,65.881584,0,0,0,0,100,0),
(@PATH,9,8759.717,-6124.3516,61.40932,0,0,0,0,100,0),
(@PATH,10,8769.294,-6122.837,56.436306,0,0,0,0,100,0),
(@PATH,11,8776.36,-6117.5635,52.60511,0,0,0,0,100,0),
(@PATH,12,8782.851,-6110.8477,49.970154,0,0,0,0,100,0),
(@PATH,13,8784.833,-6101.6685,49.293747,0,0,0,0,100,0),
(@PATH,14,8774.618,-6099.6943,48.852005,0,0,0,0,100,0),
(@PATH,15,8767.4375,-6091.573,48.87974,0,0,0,0,100,0),
(@PATH,16,8752.724,-6089.3916,48.879696,0,0,0,0,100,0),
(@PATH,17,8747.168,-6099.9463,48.879704,0,0,0,0,100,0),
(@PATH,18,8732.905,-6102.6836,49.083027,0,0,0,0,100,0),
(@PATH,19,8728.807,-6112.8545,48.988697,0,0,0,0,100,0),
(@PATH,20,8732.905,-6102.6836,49.083027,0,0,0,0,100,0),
(@PATH,21,8747.168,-6099.9463,48.879704,0,0,0,0,100,0),
(@PATH,22,8752.724,-6089.3916,48.879696,0,0,0,0,100,0),
(@PATH,23,8767.391,-6091.5664,48.87974,0,0,0,0,100,0),
(@PATH,24,8774.618,-6099.6943,48.852005,0,0,0,0,100,0),
(@PATH,25,8784.833,-6101.6685,49.293747,0,0,0,0,100,0),
(@PATH,26,8782.851,-6110.8477,49.970154,0,0,0,0,100,0),
(@PATH,27,8776.36,-6117.5635,52.60511,0,0,0,0,100,0),
(@PATH,28,8769.294,-6122.837,56.436306,0,0,0,0,100,0),
(@PATH,29,8759.717,-6124.3516,61.40932,0,0,0,0,100,0),
(@PATH,30,8751.771,-6121.09,65.881584,0,0,0,0,100,0),
(@PATH,31,8743.731,-6115.136,70.11161,0,0,0,0,100,0),
(@PATH,32,8740.239,-6108.4824,72.05762,0,0,0,0,100,0),
(@PATH,33,8739.96,-6101.006,72.57038,0,0,0,0,100,0),
(@PATH,34,8746.539,-6092.935,72.944534,0,0,0,0,100,0),
(@PATH,35,8756.081,-6086.228,72.9515,0,0,0,0,100,0),
(@PATH,36,8767.179,-6088.449,72.907005,0,0,0,0,100,0);

-- Pathing for Wretched Hooligan Entry: 16162
SET @NPC := 56758;
SET @PATH := @NPC * 10;
UPDATE `creature` SET `wander_distance`=0,`MovementType`=2 WHERE `guid`=@NPC;
DELETE FROM `creature_addon` WHERE `guid`=@NPC;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes1`,`bytes2`,`emote`,`visibilityDistanceType`,`auras`) VALUES (@NPC,@PATH,0,0,1,0,0, '');
DELETE FROM `waypoint_data` WHERE `id`=@PATH;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`orientation`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
(@PATH,1,8801.929,-6091.142,4.742103,0,0,0,0,100,0),
(@PATH,2,8782.346,-6068.44,4.750699,0,0,0,0,100,0),
(@PATH,3,8768.589,-6051.1616,4.7286,0,0,0,0,100,0),
(@PATH,4,8758.566,-6030.0054,4.781763,0,0,0,0,100,0),
(@PATH,5,8734.766,-6009.651,7.5876703,0,0,0,0,100,0),
(@PATH,6,8724.2,-6033.0522,8.352052,0,0,0,0,100,0),
(@PATH,7,8717.825,-6065.091,12.091096,0,0,0,0,100,0),
(@PATH,8,8700.467,-6090.364,16.421234,0,0,0,0,100,0),
(@PATH,9,8689.885,-6105.8267,17.41932,0,0,0,0,100,0),
(@PATH,10,8688.884,-6116.0186,17.56086,0,0,0,0,100,0),
(@PATH,11,8705.702,-6130.571,15.061197,0,0,0,0,100,0),
(@PATH,12,8723.668,-6144.8403,14.547258,0,0,0,0,100,0),
(@PATH,13,8748.775,-6150.1323,12.80402,0,0,0,0,100,0),
(@PATH,14,8777.313,-6138.6963,4.562116,0,0,0,0,100,0),
(@PATH,15,8798.16,-6124.6865,4.740193,0,0,0,0,100,0),
(@PATH,16,8803.16,-6109.0054,4.73484,0,0,0,0,100,0);

-- Pathing for Wretched Hooligan Entry: 16162 "Did not get spawn location for this one but its pathing."
SET @NPC := 56774;
SET @PATH := @NPC * 10;
UPDATE `creature` SET `wander_distance`=0,`MovementType`=2,`position_x`=8793.071,`position_y`=-5898.5283,`position_z`=11.034882 WHERE `guid`=@NPC;
DELETE FROM `creature_addon` WHERE `guid`=@NPC;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes1`,`bytes2`,`emote`,`visibilityDistanceType`,`auras`) VALUES (@NPC,@PATH,0,0,1,0,0, '');
DELETE FROM `waypoint_data` WHERE `id`=@PATH;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`orientation`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
(@PATH,1,8793.071,-5898.5283,11.034882,0,0,0,0,100,0),
(@PATH,2,8762.257,-5913.489,7.8946075,0,0,0,0,100,0),
(@PATH,3,8752.537,-5922.0376,7.535488,0,0,0,0,100,0),
(@PATH,4,8758.981,-5966.316,5.414267,0,0,0,0,100,0),
(@PATH,5,8760.918,-5994.3745,5.1113954,0,0,0,0,100,0),
(@PATH,6,8760.717,-6020.1978,4.778711,0,0,0,0,100,0),
(@PATH,7,8761.304,-6046.205,4.7286954,0,0,0,0,100,0),
(@PATH,8,8781.259,-6063.628,4.743196,0,0,0,0,100,0),
(@PATH,9,8802.356,-6092.2417,4.7402415,0,0,0,0,100,0),
(@PATH,10,8781.259,-6063.628,4.743196,0,0,0,0,100,0),
(@PATH,11,8761.304,-6046.205,4.7286954,0,0,0,0,100,0),
(@PATH,12,8760.717,-6020.1978,4.778711,0,0,0,0,100,0),
(@PATH,13,8760.918,-5994.3745,5.1113954,0,0,0,0,100,0),
(@PATH,14,8758.981,-5966.316,5.414267,0,0,0,0,100,0),
(@PATH,15,8752.537,-5922.0376,7.535488,0,0,0,0,100,0),
(@PATH,16,8762.257,-5913.489,7.8946075,0,0,0,0,100,0);

--
-- END UPDATING QUERIES
--
UPDATE version_db_world SET date = '2021_12_11_02' WHERE sql_rev = '1638713468459702407';
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
