-- DB update 2024_06_29_10 -> 2024_06_29_11
--
-- trigger AI
UPDATE `creature_template` SET `ScriptName` = 'npc_gothik_trigger' WHERE `entry` = 16137;

-- re-do spawn locations for triggers
SET @CGUID = 127514;
DELETE FROM `creature` WHERE `guid` BETWEEN @CGUID+0 AND @CGUID+14 AND `id1`=16137;
INSERT INTO `creature` (`guid`, `id1`, `id2`, `id3`, `map`, `zoneId`, `areaId`, `spawnMask`, `phaseMask`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `wander_distance`, `currentwaypoint`, `curhealth`, `curmana`, `MovementType`, `npcflag`, `unit_flags`, `dynamicflags`, `ScriptName`, `VerifiedBuild`, `CreateObject`, `Comment`) VALUES
(@CGUID+0,  16137, 0, 0, 533, 3456, 3456, 3, 1, 0, 2643.73095703125,  -3399.680908203125, 284.18292236328125,  6.091198921203613281, 7200, 0, 0, 17010, 0, 0, 0, 0, 0, '', 46248, 0, 'living side soul trigger (south)'),
(@CGUID+1,  16137, 0, 0, 533, 3456, 3456, 3, 1, 0, 2739.994873046875, -3399.779296875,    284.294647216796875, 6.108652114868164062, 7200, 0, 0, 17010, 0, 0, 0, 0, 0, '', 46248, 0, 'living side soul trigger (north)'),
(@CGUID+2,  16137, 0, 0, 533, 3456, 3456, 3, 1, 0, 2643.73095703125,  -3321.72705078125,  284.23272705078125,  6.195918560028076171, 7200, 0, 0, 17010, 0, 0, 0, 0, 0, '', 46248, 0, 'spectral side soul trigger (south)'),
(@CGUID+3,  16137, 0, 0, 533, 3456, 3456, 3, 1, 0, 2739.994873046875, -3321.72705078125,  284.23162841796875,  2.827433347702026367, 7200, 0, 0, 17010, 0, 0, 0, 0, 0, '', 46248, 0, 'spectral side soul trigger (north)'),
(@CGUID+4,  16137, 0, 0, 533, 3456, 3456, 3, 1, 0, 2692.16064453125,  -3430.745849609375, 268.64617919921875,  1.605702877044677734, 7200, 0, 0, 17010, 0, 0, 0, 0, 0, '', 46248, 0, 'living side spawn trigger (center back)'),
(@CGUID+5,  16137, 0, 0, 533, 3456, 3456, 3, 1, 0, 2714.561767578125, -3430.6103515625,   268.646240234375,    1.413716673851013183, 7200, 0, 0, 17010, 0, 0, 0, 0, 0, '', 46248, 0, 'living side spawn trigger (north back)'),
(@CGUID+6,  16137, 0, 0, 533, 3456, 3456, 3, 1, 0, 2669.581298828125, -3428.858642578125, 268.64617919921875,  1.378810048103332519, 7200, 0, 0, 17010, 0, 0, 0, 0, 0, '', 46248, 0, 'living side spawn trigger (south front)'),
(@CGUID+7,  16137, 0, 0, 533, 3456, 3456, 3, 1, 0, 2669.59033203125,  -3431.460205078125, 268.64617919921875,  1.343903541564941406, 7200, 0, 0, 17010, 0, 0, 0, 0, 0, '', 46248, 0, 'living side spawn trigger (south back)'),
(@CGUID+8,  16137, 0, 0, 533, 3456, 3456, 3, 1, 0, 2692.212646484375, -3428.78271484375,  268.64617919921875,  1.48352980613708496,  7200, 0, 0, 17010, 0, 0, 0, 0, 0, '', 46248, 0, 'living side spawn trigger (center front)'),
(@CGUID+9,  16137, 0, 0, 533, 3456, 3456, 3, 1, 0, 2733.456787109375, -3349.387939453125, 267.7677001953125,   1.780235767364501953, 7200, 0, 0, 17010, 0, 0, 0, 0, 0, '', 46248, 0, 'living side spawn trigger (north front)'),
(@CGUID+10, 16137, 0, 0, 533, 3456, 3456, 3, 1, 0, 2714.4619140625,   -3428.727783203125, 268.64617919921875,  1.65806281566619873,  7200, 0, 0, 17010, 0, 0, 0, 0, 0, '', 46248, 0, 'spectral side spawn trigger (northwest)'),
(@CGUID+11, 16137, 0, 0, 533, 3456, 3456, 3, 1, 0, 2725.818603515625, -3309.567626953125, 267.89178466796875,  2.827433347702026367, 7200, 0, 0, 17010, 0, 0, 0, 0, 0, '', 46248, 0, 'spectral side spawn trigger (northeast)'),
(@CGUID+12, 16137, 0, 0, 533, 3456, 3456, 3, 1, 0, 2700.268798828125, -3322.3544921875,   267.767791748046875, 3.525565147399902343, 7200, 0, 0, 17010, 0, 0, 0, 0, 0, '', 46248, 0, 'spectral side spawn trigger (center)'),
(@CGUID+13, 16137, 0, 0, 533, 3456, 3456, 3, 1, 0, 2683.885986328125, -3304.212890625,    267.76800537109375,  2.49582076072692871,  7200, 0, 0, 17010, 0, 0, 0, 0, 0, '', 46248, 0, 'spectral side spawn trigger (southwest)'),
(@CGUID+14, 16137, 0, 0, 533, 3456, 3456, 3, 1, 0, 2664.871826171875, -3340.7490234375,   267.767364501953125, 5.934119224548339843, 7200, 0, 0, 17010, 0, 0, 0, 0, 0, '', 46248, 0, 'spectral side spawn trigger (southeast)');

-- make visuals target proper triggers
-- to anchor 1: 27892 (Trainee), 27928 (DK), 27935 (Rider)
-- to anchor 2: 27893 (Trainee), 27929 (DK), 27936 (Rider)
-- anchor -> skull: 27915 (Trainee), 27931 (DK), 27937 (Rider)
DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId`=13 AND `SourceEntry` IN (27892,27928,27935,27893,27929,27936,27915,27931,27937);
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `ErrorType`, `ErrorTextId`, `ScriptName`, `Comment`) VALUES
(13,1,27892,0,0,31,0,3,16137,@CGUID+0,0,0,0,'','To Anchor 1 - Target Anchor Living South'),
(13,1,27892,0,1,31,0,3,16137,@CGUID+1,0,0,0,'','To Anchor 1 - Target Anchor Living North'),
(13,1,27928,0,0,31,0,3,16137,@CGUID+0,0,0,0,'','To Anchor 1 - Target Anchor Living South'),
(13,1,27928,0,1,31,0,3,16137,@CGUID+1,0,0,0,'','To Anchor 1 - Target Anchor Living North'),
(13,1,27935,0,0,31,0,3,16137,@CGUID+0,0,0,0,'','To Anchor 1 - Target Anchor Living South'),
(13,1,27935,0,1,31,0,3,16137,@CGUID+1,0,0,0,'','To Anchor 1 - Target Anchor Living North'),
(13,1,27893,0,0,31,0,3,16137,@CGUID+2,0,0,0,'','To Anchor 2 - Target Anchor Spectral South'),
(13,1,27893,0,1,31,0,3,16137,@CGUID+3,0,0,0,'','To Anchor 2 - Target Anchor Spectral North'),
(13,1,27929,0,0,31,0,3,16137,@CGUID+2,0,0,0,'','To Anchor 2 - Target Anchor Spectral South'),
(13,1,27929,0,1,31,0,3,16137,@CGUID+3,0,0,0,'','To Anchor 2 - Target Anchor Spectral North'),
(13,1,27936,0,0,31,0,3,16137,@CGUID+2,0,0,0,'','To Anchor 2 - Target Anchor Spectral South'),
(13,1,27936,0,1,31,0,3,16137,@CGUID+3,0,0,0,'','To Anchor 2 - Target Anchor Spectral North');
