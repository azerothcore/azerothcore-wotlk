-- DB update 2025_12_01_00 -> 2025_12_01_01
--
SET @CGUID:=126834;

-- Remove old '[DND]' bunnies
DELETE FROM `creature` WHERE `id1` IN (30655, 30640, 30832, 30646, 30651, 30707, 30649, 30749, 30700, 30699, 30690, 31246, 31353, 30589, 30588, 30476, 30559);
DELETE FROM `creature` WHERE `id1` = 15214 AND `guid` IN (122568, 122569, 122570);
DELETE FROM `creature` WHERE `guid` BETWEEN @CGUID+0 AND @CGUID+29;
INSERT INTO `creature` (`guid`, `id1`, `map`, `spawnMask`, `phaseMask`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `wander_distance`, `MovementType`) VALUES
(@CGUID+0, 30640, 623, 1, 1, 35.03846, 36.06336, 25.11708, 5.288348, 120, 0, 0), -- 30640 (Area: 4508) (possible waypoints or random movement)
(@CGUID+1, 30640, 623, 1, 1, 6.909693, 9.529325, 20.54005, 2.303835, 120, 0, 0), -- 30640 (Area: 4508) (possible waypoints or random movement)
(@CGUID+2, 30640, 623, 1, 1, -27.16368, 2.981263, 20.54094, 0.122173, 120, 0, 0), -- 30640 (Area: 4508) (possible waypoints or random movement)
(@CGUID+3, 30640, 623, 1, 1, -56.31194, 12.39219, 31.00466, 3.281219, 120, 0, 0), -- 30640 (Area: 4537) (possible waypoints or random movement)
(@CGUID+4, 30646, 623, 1, 1, -30.25571, 31.80029, 12.35424, 1.605703, 120, 0, 0), -- 30646 (Area: 4508) (possible waypoints or random movement)
(@CGUID+5, 30646, 623, 1, 1, -5.325279, 31.62501, 12.34004, 1.500983, 120, 0, 0), -- 30646 (Area: 4508) (possible waypoints or random movement)
(@CGUID+6, 30651, 623, 1, 1, -40.68238, 29.21558, 12.33503, 1.919862, 120, 0, 0), -- 30651 (Area: 4508) (possible waypoints or random movement)
(@CGUID+7, 30651, 623, 1, 1, -17.81335, 32.07878, 12.3449, 1.553343, 120, 0, 0), -- 30651 (Area: 4508) (possible waypoints or random movement)
(@CGUID+8, 30651, 623, 1, 1, 5.88316, 30.50419, 12.34755, 1.32645, 120, 0, 0), -- 30651 (Area: 4508) (possible waypoints or random movement)
(@CGUID+9, 30655, 623, 1, 1, 6.662919, 19.23895, 10.05156, 0.5061455, 120, 0, 0), -- 30655 (Area: 4509)
(@CGUID+10, 30655, 623, 1, 1, -43.53964, 18.66365, 9.692578, 3.246312, 120, 0, 0), -- 30655 (Area: 4509) (possible waypoints or random movement)
(@CGUID+11, 30559, 623, 1, 1, 38.16154, -0.040522, 40.16801, 4.223697, 120, 0, 0), -- 30559 (Area: 4508) (possible waypoints or random movement)
(@CGUID+12, 30476, 623, 1, 1, 31.41805, 0.126893, 41.69821, 0.05235988, 120, 0, 0), -- 30476 (Area: 4508) (Auras: 56852 - 56852) (possible waypoints or random movement)
(@CGUID+13, 31353, 623, 1, 1, -21.7234, 19.33753, 9.687197, 1.64061, 120, 0, 0), -- 31353 (Area: 4509) (Auras: 57726 - 57726)
(@CGUID+14, 30690, 622, 1, 1, 15.24723, 32.37709, 10.63188, 1.553343, 120, 0, 0), -- 30690 (Area: 4533) (possible waypoints or random movement)
(@CGUID+15, 30690, 622, 1, 1, -11.22309, 32.91199, 10.55865, 1.58825, 120, 0, 0), -- 30690 (Area: 4533) (possible waypoints or random movement)
(@CGUID+16, 30649, 622, 1, 1, 4.109683, 19.52689, 34.74765, 3.752458, 120, 0, 0), -- 30649 (Area: 4533) (possible waypoints or random movement)
(@CGUID+17, 30649, 622, 1, 1, -32.53434, 24.30232, 33.9708, 3.211406, 120, 0, 0), -- 30649 (Area: 4533) (possible waypoints or random movement)
(@CGUID+18, 30649, 622, 1, 1, 50.99569, 46.95655, 23.41373, 2.583087, 120, 0, 0), -- 30649 (Area: 4533) (possible waypoints or random movement)
(@CGUID+19, 30649, 622, 1, 1, 2.006737, 15.73845, 9.250069, 3.368485, 120, 0, 0), -- 30649 (Area: 4533) (possible waypoints or random movement)
(@CGUID+20, 30699, 622, 1, 1, 1.853844, 32.8888, 10.02361, 1.58825, 120, 0, 0), -- 30699 (Area: 4533) (possible waypoints or random movement)
(@CGUID+21, 30700, 622, 1, 1, -35.66628, 29.43331, 1.87925, 1.745329, 120, 0, 0), -- 30700 (Area: 0) (possible waypoints or random movement)
(@CGUID+22, 30700, 622, 1, 1, 7.417077, 32.82674, 38.35604, 1.553343, 120, 0, 0), -- 30700 (Area: 0) (possible waypoints or random movement)
(@CGUID+23, 30700, 622, 1, 1, -55.9708, 28.44186, 18.02501, 2.268928, 120, 0, 0), -- 30700 (Area: 0) (possible waypoints or random movement)
(@CGUID+24, 30700, 622, 1, 1, 38.76255, 30.09343, 2.308181, 1.134464, 120, 0, 0), -- 30700 (Area: 4533) (possible waypoints or random movement)
(@CGUID+25, 30707, 622, 1, 1, 19.47087, 27.5296, 10.64527, 1.396263, 120, 0, 0), -- 30707 (Area: 4533) (possible waypoints or random movement)
(@CGUID+26, 30707, 622, 1, 1, -15.3085, 30.59285, 11.11614, 2.635447, 120, 0, 0), -- 30707 (Area: 0) (possible waypoints or random movement)
(@CGUID+27, 31353, 622, 1, 1, -7.999845, 17.85185, 35.04856, 2.460914, 120, 0, 0), -- 31353 (Area: 0) (possible waypoints or random movement)
(@CGUID+28, 30588, 622, 1, 1, -18.10283, -0.042108, 45.31725, 1.762783, 120, 0, 0), -- 30588 (Area: 4533) (Auras: 57424 - 57424) (possible waypoints or random movement)
(@CGUID+29, 30589, 622, 1, 1, -11.83204, -0.019289, 43.11467, 4.153883, 120, 0, 0); -- 30589 (Area: 4533) (possible waypoints or random movement)

UPDATE `creature_template` SET `flags_extra`= `flags_extra` | 128 WHERE `entry` IN (30690, 30699);

DELETE FROM `creature_addon` WHERE `guid` IN (122568, 122569, 122758, 122777, 124002, 124113);

-- Match existing (A) entry, 'To Icecrown - Airship (H) - Aura - Approach'
UPDATE `creature_template_addon` SET `auras` = '57424' WHERE (`entry` = 30588);

DELETE FROM `creature_template_movement` WHERE (`CreatureId` IN (30476, 30588));
INSERT INTO `creature_template_movement` (`CreatureId`, `Ground`, `Swim`, `Flight`, `Rooted`, `Chase`, `Random`, `InteractionPauseTimer`) VALUES
(30476, 0, 0, 1, 0, 0, 0, 0),
(30588, 0, 0, 1, 0, 0, 0, 0);

UPDATE `creature_template_addon` SET `auras` = '' WHERE (`entry` IN (30470, 30585));
DELETE FROM `creature_template_movement` WHERE (`CreatureId` IN (30470, 30585));
INSERT INTO `creature_template_movement` (`CreatureId`, `Ground`, `Swim`, `Flight`, `Rooted`, `Chase`, `Random`, `InteractionPauseTimer`) VALUES
(30470, 0, 0, 1, 0, 0, 0, 0),
(30585, 0, 0, 1, 0, 0, 0, 0);

-- teleport target condition
DELETE FROM `conditions` WHERE (`SourceTypeOrReferenceId` = 13) AND (`SourceGroup` = 1) AND (`SourceEntry` IN (56905, 56917, 57420, 57417)) AND (`SourceId` = 0) AND (`ElseGroup` IN (0, 1)) AND (`ConditionTypeOrReference` = 31) AND (`ConditionTarget` = 0) AND (`ConditionValue1` = 3) AND (`ConditionValue2` IN (30476, 30559, 30588, 30589)) AND (`ConditionValue3` = 0);
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `ErrorType`, `ErrorTextId`, `ScriptName`, `Comment`) VALUES
(13, 1, 56905, 0, 0, 31, 0, 3, 30476, 0, 0, 0, 0, '', 'target must be [DND] Icecrown Flight To Airship Bunny (A)'),
(13, 1, 56917, 0, 0, 31, 0, 3, 30559, 0, 0, 0, 0, '', 'target must be [DND] Icecrown Flight To Airship Bunny (A) Teleport Target'),
(13, 1, 57420, 0, 0, 31, 0, 3, 30588, 0, 0, 0, 0, '', 'target must be [DND] Icecrown Flight To Airship Bunny (H)'),
(13, 1, 57417, 0, 0, 31, 0, 3, 30589, 0, 0, 0, 0, '', 'target must be [DND] Icecrown Flight To Airship Bunny (H) Teleport Target');

-- dismount trigger condition
DELETE FROM `conditions` WHERE (`SourceTypeOrReferenceId` = 17) AND (`SourceGroup` = 0) AND (`SourceEntry` = 56921) AND (`SourceId` = 0) AND (`ElseGroup` IN (0, 1)) AND (`ConditionTypeOrReference` = 31) AND (`ConditionTarget` = 1) AND (`ConditionValue1` = 3) AND (`ConditionValue2` IN (30470, 30585)) AND (`ConditionValue3` = 0);
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `ErrorType`, `ErrorTextId`, `ScriptName`, `Comment`) VALUES
(17, 0, 56921, 0, 0, 31, 1, 3, 30470, 0, 0, 0, 0, '', 'target must be Skybreaker Cloudbuster'),
(17, 0, 56921, 0, 1, 31, 1, 3, 30585, 0, 0, 0, 0, '', 'target must be Hammerhead');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` IN (30476, 30588);
DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` IN (30476, 30588));
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(30476, 0, 0, 1, 8, 0, 100, 0, 56905, 0, 0, 0, 0, 0, 11, 57554, 2, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, '[DND] Icecrown Flight To Airship Bunny (A) - On Spellhit \'To Icecrown - Player - Aura (A) - Dismount Trigger\' - Cast \'To Icecrown Airship - Teleport to Airship (A) Force Player to Cast\''),
(30476, 0, 1, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 11, 56921, 2, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, '[DND] Icecrown Flight To Airship Bunny (A) - On Spellhit \'To Icecrown - Player - Aura (A) - Dismount Trigger\' - Cast \'To Icecrown - Aura - Dismount Response\''),
(30588, 0, 0, 1, 8, 0, 100, 0, 57420, 0, 0, 0, 0, 0, 11, 57556, 2, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, '[DND] Icecrown Flight To Airship Bunny (H) - On Spellhit \'To Icecrown - Player - Aura (A) - Dismount Trigger\' - Cast \'To Icecrown Airship - Teleport to Airship (H) Force Player to Cast\''),
(30588, 0, 1, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 11, 56921, 2, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, '[DND] Icecrown Flight To Airship Bunny (H) - On Spellhit \'To Icecrown - Player - Aura (A) - Dismount Trigger\' - Cast \'To Icecrown - Aura - Dismount Response\'');

DELETE FROM `waypoints` WHERE `entry` IN (30470, 30585) AND `pointid` BETWEEN 1 AND 18;
INSERT INTO `waypoints` (`entry`, `pointid`, `position_x`, `position_y`, `position_z`, `point_comment`) VALUES
(30470, 1, 5818.54, 483.97, 660.0, 'Skybreaker Cloudbuster'),
(30470, 2, 5810.04, 486.907, 660.167, 'Skybreaker Cloudbuster'),
(30470, 3, 5827.64, 482.851, 669.25, 'Skybreaker Cloudbuster'),
(30470, 4, 5845.60, 505.766, 677.9, 'Skybreaker Cloudbuster'),
(30470, 5, 5865.83, 544.756, 689.667, 'Skybreaker Cloudbuster'),
(30470, 6, 5897.43, 586.118, 689.667, 'Skybreaker Cloudbuster'),
(30470, 7, 5936.38, 642.625, 682.418, 'Skybreaker Cloudbuster'),
(30470, 8, 5954.68, 688.565, 678.141, 'Skybreaker Cloudbuster'),
(30470, 9, 5987.02, 725.128, 673.53, 'Skybreaker Cloudbuster'),
(30470, 10, 6055.09, 766.575, 663.057, 'Skybreaker Cloudbuster'),
(30470, 11, 6077.21, 796.139, 663.057, 'Skybreaker Cloudbuster'),
(30470, 12, 6089.87, 824.184, 658.753, 'Skybreaker Cloudbuster'),
(30470, 13, 6119.88, 881.953, 657.474, 'Skybreaker Cloudbuster'),
(30470, 14, 6187.39, 959.597, 663.057, 'Skybreaker Cloudbuster'),
(30470, 15, 6346.12, 1060.05, 654.669, 'Skybreaker Cloudbuster'),
(30470, 16, 6466.61, 1107.18, 653.78, 'Skybreaker Cloudbuster'),
(30470, 17, 6626.67, 1136.81, 647.084, 'Skybreaker Cloudbuster'),
(30470, 18, 6733.84, 1153.34, 663.057, 'Skybreaker Cloudbuster'),
(30585, 1, 5836.95, 475.408, 660.167, 'Hammerhead'),
(30585, 2, 5835.36, 490.093, 669.25, 'Hammerhead'),
(30585, 3, 5845.6,  505.766, 677.9, 'Hammerhead'),
(30585, 4, 5865.83, 544.756, 689.667, 'Hammerhead'),
(30585, 5, 5897.43, 586.118, 689.667, 'Hammerhead'),
(30585, 6, 5936.38, 642.625, 682.418, 'Hammerhead'),
(30585, 7, 5954.68, 688.565, 678.141, 'Hammerhead'),
(30585, 8, 5987.02, 725.128, 673.53, 'Hammerhead'),
(30585, 9, 6055.09, 766.575, 663.057, 'Hammerhead'),
(30585, 10, 6077.21, 796.139, 663.057, 'Hammerhead'),
(30585, 11, 6089.87, 824.184, 663.057, 'Hammerhead'),
(30585, 12, 6133.36, 911.233, 642.309, 'Hammerhead'),
(30585, 13, 6187.39, 959.597, 625.03, 'Hammerhead'),
(30585, 14, 6346.12, 1060.05, 631.336, 'Hammerhead'),
(30585, 15, 6466.61, 1107.18, 640.891, 'Hammerhead'),
(30585, 16, 6626.67, 1136.81, 639.669, 'Hammerhead'),
(30585, 17, 6733.84, 1153.34, 637.03, 'Hammerhead'),
(30585, 18, 6835.57, 1203.64, 642.974, 'Hammerhead');

-- TP To Dalaran after 5 minutes
-- Location copied from 30719 'Teleport to Dalaran'
DELETE FROM `spell_target_position` WHERE `ID` = 57461 AND `EffectIndex` = 0;
INSERT INTO `spell_target_position` (`ID`, `EffectIndex`, `MapID`, `PositionX`, `PositionY`, `PositionZ`, `Orientation`, `VerifiedBuild`) VALUES
(57461, 0, 571, 5807.75, 588.347, 661.505, 1.663, 0);
