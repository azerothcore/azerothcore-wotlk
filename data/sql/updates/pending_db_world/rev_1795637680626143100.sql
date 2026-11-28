-- Hot and Cold (quest 12981): Smoldering Scrap Bunny spawns from WotLK Classic sniffs
-- Builds 45942, 46779, 50664, 51739, 52237 (analysis by Gultask, issue #26441)
-- Each bunny summons its own Smoldering Scrap where it stands
SET @CGUID := 16208;

-- Missing spawns
DELETE FROM `creature` WHERE `id` = 30169 AND `guid` BETWEEN @CGUID+0 AND @CGUID+12;
INSERT INTO `creature` (`guid`, `id`, `map`, `zoneId`, `areaId`, `spawnMask`, `phaseMask`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `wander_distance`, `currentwaypoint`, `curhealth`, `curmana`, `MovementType`, `npcflag`, `unit_flags`, `dynamicflags`, `ScriptName`, `VerifiedBuild`, `CreateObject`, `Comment`) VALUES
(@CGUID+0, 30169, 571, 67, 4495, 1, 8, 0, 7163.6865234375, -3606.800048828125, 831.8533325195312, 4.066617012023926, 300, 0, 0, 1, 0, 0, 0, 0, 0, '', 52237, 2, NULL), -- Smoldering Scrap Bunny
(@CGUID+1, 30169, 571, 67, 4495, 1, 8, 0, 7167.14794921875, -3635.372802734375, 831.5135498046875, 3.071779489517212, 300, 0, 0, 1, 0, 0, 0, 0, 0, '', 52237, 2, NULL), -- Smoldering Scrap Bunny
(@CGUID+2, 30169, 571, 67, 4495, 1, 8, 0, 7191.63671875, -3490.59765625, 833.9930419921875, 0.20943951606750488, 300, 0, 0, 1, 0, 0, 0, 0, 0, '', 51739, 2, NULL), -- Smoldering Scrap Bunny
(@CGUID+3, 30169, 571, 67, 4495, 1, 8, 0, 7196.2646484375, -3652.62890625, 823.5907592773438, 4.8869218826293945, 300, 0, 0, 1, 0, 0, 0, 0, 0, '', 52237, 1, NULL), -- Smoldering Scrap Bunny
(@CGUID+4, 30169, 571, 67, 4495, 1, 8, 0, 7204.09716796875, -3497.684814453125, 830.767333984375, 2.6354472637176514, 300, 0, 0, 1, 0, 0, 0, 0, 0, '', 52237, 2, NULL), -- Smoldering Scrap Bunny
(@CGUID+5, 30169, 571, 67, 4495, 1, 8, 0, 7204.861328125, -3628.249267578125, 823.5885009765625, 4.223696708679199, 300, 0, 0, 1, 0, 0, 0, 0, 0, '', 52237, 2, NULL), -- Smoldering Scrap Bunny
(@CGUID+6, 30169, 571, 67, 4495, 1, 8, 0, 7206.61083984375, -3404.19580078125, 841.4804077148438, 4.223696708679199, 300, 0, 0, 1, 0, 0, 0, 0, 0, '', 52237, 2, NULL), -- Smoldering Scrap Bunny
(@CGUID+7, 30169, 571, 67, 4495, 1, 8, 0, 7210.07861328125, -3542.757568359375, 827.5762329101562, 3.0194196701049805, 300, 0, 0, 1, 0, 0, 0, 0, 0, '', 52237, 2, NULL), -- Smoldering Scrap Bunny
(@CGUID+8, 30169, 571, 67, 4495, 1, 8, 0, 7218.13134765625, -3519.231689453125, 831.1962280273438, 3.455751895904541, 300, 0, 0, 1, 0, 0, 0, 0, 0, '', 52237, 2, NULL), -- Smoldering Scrap Bunny
(@CGUID+9, 30169, 571, 67, 4495, 1, 8, 0, 7225.23974609375, -3495.3310546875, 839.9876708984375, 3.1415927410125732, 300, 0, 0, 1, 0, 0, 0, 0, 0, '', 52237, 2, NULL), -- Smoldering Scrap Bunny
(@CGUID+10, 30169, 571, 67, 4495, 1, 8, 0, 7236.38134765625, -3678.732666015625, 822.823486328125, 0.8726646304130554, 300, 0, 0, 1, 0, 0, 0, 0, 0, '', 52237, 1, NULL), -- Smoldering Scrap Bunny
(@CGUID+11, 30169, 571, 67, 4495, 1, 8, 0, 7246.63720703125, -3648.932373046875, 823.0460205078125, 0.9948376417160034, 300, 0, 0, 1, 0, 0, 0, 0, 0, '', 52237, 1, NULL), -- Smoldering Scrap Bunny
(@CGUID+12, 30169, 571, 67, 4495, 1, 8, 0, 7248.6376953125, -3625.24462890625, 826.923583984375, 3.647738218307495, 300, 0, 0, 1, 0, 0, 0, 0, 0, '', 52237, 1, NULL); -- Smoldering Scrap Bunny

-- Existing spawns: sniff stamp, positions unchanged
UPDATE `creature` SET `VerifiedBuild` = 52237, `CreateObject` = 2 WHERE `id` = 30169 AND `guid` IN
(1975965, 1975967, 1975968, 1975969, 1975970, 1975971, 1975972, 1975973, 1975974, 1975976, 1975977);
UPDATE `creature` SET `VerifiedBuild` = 52237, `CreateObject` = 1 WHERE `id` = 30169 AND `guid` IN (1975966, 1975975);
