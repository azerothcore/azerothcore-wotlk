--
SET @CGUID := 83245;

DELETE FROM `creature` WHERE `guid` BETWEEN @CGUID+0 AND @CGUID+20 AND `id` IN (15214, 29152, 29712);
INSERT INTO `creature` (`guid`,`id`,`map`,`zoneId`,`areaId`,`spawnMask`,`phaseMask`,`equipment_id`,`position_x`,`position_y`,`position_z`,`orientation`,`spawntimesecs`,`wander_distance`,`MovementType`,`unit_flags`,`VerifiedBuild`,`CreateObject`) VALUES
(@CGUID+0, 29712, 0, 1519, 4411, 1, 1, 1, -8052.729980, 1351.339966, 7.878640, 0.977384, 300, 0.00, 0, 0, 50664, 1),
(@CGUID+1, 29152, 0, 1519, 4411, 1, 1, 1, -8065.580078, 1327.869995, 18.871300, 4.293510, 300, 0.00, 0, 0, 50664, 1),
(@CGUID+2, 29152, 0, 1519, 4411, 1, 1, 1, -8064.589844, 1302.760010, 34.478001, 3.036870, 300, 0.00, 0, 0, 50664, 1),
(@CGUID+3, 29152, 0, 1519, 4411, 1, 1, 1, -8046.330078, 1305.569946, 33.731499, 3.159050, 300, 0.00, 0, 0, 50664, 1),
(@CGUID+4, 29152, 0, 1519, 4411, 1, 1, 1, -8081.189941, 1307.109985, 19.506300, 0.750492, 300, 0.00, 0, 0, 50664, 1),
(@CGUID+5, 29152, 0, 1519, 4411, 1, 1, 1, -8063.029785, 1297.849976, 32.785400, 2.548180, 300, 0.00, 0, 0, 50664, 1),
(@CGUID+6, 29152, 0, 1519, 4411, 1, 1, 1, -8106.500000, 1288.849976, 23.195700, 2.548180, 300, 0.00, 0, 0, 50664, 1),
(@CGUID+7, 29152, 0, 1519, 4411, 1, 1, 1, -8149.850098, 1301.569946, 29.305201, 2.478370, 300, 0.00, 0, 0, 50664, 1),
(@CGUID+8, 29712, 0, 1519, 4411, 1, 1, 1, -8097.720215, 1227.880005, 7.886000, 3.857180, 300, 0.00, 0, 0, 50664, 1),
(@CGUID+9, 15214, 0, 1519, 4411, 1, 1, 0, -8060.029785, 1221.520020, 13.693400, 4.450590, 300, 0.00, 0, 0, 50664, 1),
(@CGUID+10, 29152, 0, 1519, 4411, 1, 1, 1, -8100.649902, 1255.560059, 37.784901, 2.408550, 300, 0.00, 0, 0, 50664, 1),
(@CGUID+11, 15214, 0, 1519, 4411, 1, 1, 0, -8183.589844, 1217.800049, 7.763740, 1.727880, 300, 0.00, 0, 0, 50664, 1),
(@CGUID+12, 29712, 0, 1519, 4411, 1, 1, 1, -8178.660156, 1130.520020, 18.027599, 2.251470, 300, 0.00, 0, 0, 50664, 1),
(@CGUID+13, 29712, 0, 1519, 4411, 1, 1, 1, -8395.080078, 1341.680054, 5.313550, 0.000000, 300, 0.00, 0, 0, 54261, 1),
(@CGUID+14, 29712, 0, 1519, 4411, 1, 1, 1, -8394.179688, 1291.949951, 5.313550, 0.017453, 300, 0.00, 0, 0, 54261, 1),
(@CGUID+15, 15214, 0, 1519, 4411, 1, 1, 0, -8472.849609, 1332.599976, 5.453400, 2.792530, 300, 0.00, 0, 0, 50664, 1),
(@CGUID+16, 15214, 0, 1519, 4411, 1, 1, 0, -8463.410156, 1315.310059, 5.313560, 3.944440, 300, 0.00, 0, 0, 50664, 1),
(@CGUID+17, 15214, 0, 1519, 4411, 1, 1, 0, -8609.370117, 1195.369995, 5.626660, 5.358160, 300, 0.00, 0, 0, 53788, 1),
(@CGUID+18, 15214, 0, 1519, 4411, 1, 1, 0, -8614.620117, 1294.989990, 5.314710, 6.230830, 300, 0.00, 0, 0, 53788, 1),
(@CGUID+19, 15214, 0, 1519, 4411, 1, 1, 0, -8629.910156, 1338.229980, 5.742120, 6.178470, 300, 0.00, 0, 0, 53788, 1),
(@CGUID+20, 15214, 0, 1519, 4411, 1, 1, 0, -8451.059570, 1187.910034, 5.709350, 3.909540, 300, 0.00, 0, 0, 54261, 1);

DELETE FROM `creature_addon` WHERE `guid` BETWEEN @CGUID+0 AND @CGUID+20;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes1`,`bytes2`,`emote`,`visibilityDistanceType`,`auras`) VALUES
(@CGUID+1, 0, 0, 0, 1, 234, 0, ''),
(@CGUID+2, 0, 0, 0, 1, 234, 0, ''),
(@CGUID+3, 0, 0, 0, 1, 234, 0, ''),
(@CGUID+4, 0, 0, 0, 1, 234, 0, ''),
(@CGUID+5, 0, 0, 0, 1, 234, 0, ''),
(@CGUID+6, 0, 0, 0, 1, 234, 0, ''),
(@CGUID+7, 0, 0, 0, 1, 234, 0, ''),
(@CGUID+10, 0, 0, 0, 1, 234, 0, '');

UPDATE `creature` SET `position_x`=-8201.580078, `position_y`=1196.410034, `position_z`=5.699020, `orientation`=1.815140, `wander_distance`=0.00, `MovementType`=0, `VerifiedBuild`=50664, `CreateObject`=1 WHERE `guid`=203475;
UPDATE `creature` SET `position_x`=-8211.000000, `position_y`=1196.160034, `position_z`=5.711740, `orientation`=1.309000, `wander_distance`=0.00, `MovementType`=0, `VerifiedBuild`=54261, `CreateObject`=1 WHERE `guid`=203474;
UPDATE `creature` SET `position_x`=-8232.750000, `position_y`=1097.430054, `position_z`=18.003000, `orientation`=1.727880, `wander_distance`=0.00, `MovementType`=0, `VerifiedBuild`=50664, `CreateObject`=1 WHERE `guid`=203476;
UPDATE `creature` SET `position_x`=-8460.969727, `position_y`=1350.109985, `position_z`=5.313560, `orientation`=3.159050, `wander_distance`=0.00, `MovementType`=0, `VerifiedBuild`=50664, `CreateObject`=1 WHERE `guid`=203479;
UPDATE `creature` SET `position_x`=-8486.629883, `position_y`=1349.180054, `position_z`=5.313560, `orientation`=0.069813, `wander_distance`=0.00, `MovementType`=0, `VerifiedBuild`=53788, `CreateObject`=1 WHERE `guid`=203480;
UPDATE `creature` SET `position_x`=-8487.589844, `position_y`=1249.599976, `position_z`=5.313560, `orientation`=4.782200, `wander_distance`=0.00, `MovementType`=0, `VerifiedBuild`=50664, `CreateObject`=1 WHERE `guid`=203484;
UPDATE `creature` SET `position_x`=-8579.580078, `position_y`=1195.209961, `position_z`=5.565850, `orientation`=1.517490, `wander_distance`=0.00, `MovementType`=0, `VerifiedBuild`=53788, `CreateObject`=1 WHERE `guid`=203470;
UPDATE `creature` SET `position_x`=-8593.790039, `position_y`=1246.000000, `position_z`=5.313800, `orientation`=4.101520, `wander_distance`=0.00, `MovementType`=0, `VerifiedBuild`=53788, `CreateObject`=1 WHERE `guid`=203463;
UPDATE `creature` SET `position_x`=-8606.980469, `position_y`=1239.410034, `position_z`=5.314610, `orientation`=0.506145, `wander_distance`=0.00, `MovementType`=0, `VerifiedBuild`=53788, `CreateObject`=1 WHERE `guid`=203462;
UPDATE `creature` SET `position_x`=-8617.030273, `position_y`=1240.630005, `position_z`=5.315480, `orientation`=0.523599, `wander_distance`=0.00, `MovementType`=2, `VerifiedBuild`=53788, `CreateObject`=1 WHERE `guid`=203468;
UPDATE `creature` SET `position_x`=-8591.549805, `position_y`=1253.979980, `position_z`=5.313720, `orientation`=3.769910, `wander_distance`=0.00, `MovementType`=2, `VerifiedBuild`=53788, `CreateObject`=1 WHERE `guid`=203469;
UPDATE `creature` SET `position_x`=-8647.900391, `position_y`=1303.359985, `position_z`=5.315570, `orientation`=0.488692, `wander_distance`=0.00, `MovementType`=0, `VerifiedBuild`=53788, `CreateObject`=1 WHERE `guid`=203466;
UPDATE `creature` SET `position_x`=-8645.250000, `position_y`=1315.329956, `position_z`=5.315580, `orientation`=0.558505, `wander_distance`=0.00, `MovementType`=0, `VerifiedBuild`=53788, `CreateObject`=1 WHERE `guid`=203464;
UPDATE `creature` SET `position_x`=-8632.419922, `position_y`=1322.670044, `position_z`=5.315580, `orientation`=3.630280, `wander_distance`=0.00, `MovementType`=0, `VerifiedBuild`=53788, `CreateObject`=1 WHERE `guid`=203465;
UPDATE `creature` SET `position_x`=-8833.990234, `position_y`=984.073975, `position_z`=98.552002, `orientation`=4.607670, `wander_distance`=0.00, `MovementType`=0, `VerifiedBuild`=65795, `CreateObject`=1 WHERE `guid`=26834;
UPDATE `creature` SET `position_x`=-9008.980469, `position_y`=845.349976, `position_z`=105.920998, `orientation`=0.000000, `wander_distance`=0.00, `MovementType`=0, `VerifiedBuild`=68101, `CreateObject`=1 WHERE `guid`=90442;
UPDATE `creature` SET `position_x`=-8951.000000, `position_y`=898.653015, `position_z`=108.287003, `orientation`=5.288350, `wander_distance`=0.00, `MovementType`=0, `VerifiedBuild`=68101, `CreateObject`=1 WHERE `guid`=52921;
UPDATE `creature` SET `position_x`=-8961.839844, `position_y`=809.206970, `position_z`=109.629997, `orientation`=2.076940, `wander_distance`=0.00, `MovementType`=0, `VerifiedBuild`=68101, `CreateObject`=1 WHERE `guid`=89298;
UPDATE `creature` SET `position_x`=-8965.179688, `position_y`=807.979980, `position_z`=109.629997, `orientation`=1.640610, `wander_distance`=0.00, `MovementType`=0, `VerifiedBuild`=68101, `CreateObject`=1 WHERE `guid`=52923;
UPDATE `creature` SET `position_x`=-8963.190430, `position_y`=822.125000, `position_z`=109.587997, `orientation`=3.701650, `wander_distance`=0.00, `MovementType`=0, `VerifiedBuild`=68101, `CreateObject`=1 WHERE `guid`=52922;
UPDATE `creature` SET `position_x`=-9010.780273, `position_y`=876.575012, `position_z`=148.701996, `orientation`=4.869470, `wander_distance`=0.00, `MovementType`=0, `VerifiedBuild`=68101, `CreateObject`=1 WHERE `guid`=90470;
UPDATE `creature` SET `position_x`=-9006.110352, `position_y`=885.375000, `position_z`=29.704000, `orientation`=0.802851, `wander_distance`=0.00, `MovementType`=0, `VerifiedBuild`=68101, `CreateObject`=1 WHERE `guid`=90463;
UPDATE `creature` SET `position_x`=-9012.530273, `position_y`=867.142029, `position_z`=29.704000, `orientation`=3.735000, `wander_distance`=0.00, `MovementType`=0, `VerifiedBuild`=68101, `CreateObject`=1 WHERE `guid`=26835;
UPDATE `creature` SET `position_x`=-8991.900391, `position_y`=847.484009, `position_z`=29.704000, `orientation`=0.663225, `wander_distance`=0.00, `MovementType`=0, `VerifiedBuild`=68101, `CreateObject`=1 WHERE `guid`=90441;
UPDATE `creature` SET `position_x`=-8989.700195, `position_y`=861.880981, `position_z`=29.704000, `orientation`=4.739390, `wander_distance`=0.00, `MovementType`=0, `VerifiedBuild`=68101, `CreateObject`=1 WHERE `guid`=90462;
UPDATE `creature` SET `position_x`=-8484.549805, `position_y`=1195.430054, `position_z`=5.667070, `orientation`=1.500980, `wander_distance`=0.00, `MovementType`=0, `VerifiedBuild`=53788, `CreateObject`=1 WHERE `guid`=203472;
