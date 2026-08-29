--
SET @CGUID := 100871;

DELETE FROM `creature` WHERE `guid` BETWEEN @CGUID+0 AND @CGUID+8 AND `id` IN (27567, 27564);
INSERT INTO `creature` (`guid`, `id`, `map`, `zoneId`, `areaId`, `spawnMask`, `phaseMask`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `VerifiedBuild`, `CreateObject`) VALUES
(@CGUID+0, 27567, 571, 65, 4254, 1, 1, 1, 3760.0703125, 677.15460205078125, 78.74155426025390625, 1.710422635078430175, 60, 69299, 2), -- Captain Iskandar (27567)
(@CGUID+1, 27564, 571, 65, 4254, 1, 1, 1, 3759.89404296875, 681.1414794921875, 79.21089935302734375, 4.764749050140380859, 86400, 69299, 2), -- Soldier 1 (27564)
(@CGUID+2, 27564, 571, 65, 4254, 1, 1, 1, 3765.93017578125, 684.806884765625, 78.933349609375, 4.066617012023925781, 86400, 69299, 2), -- Soldier 2 (27564)
(@CGUID+3, 27564, 571, 65, 4254, 1, 1, 1, 3765.8017578125, 681.5089111328125, 78.53423309326171875, 3.804817676544189453, 86400, 69299, 2), -- Soldier 3 (27564)
(@CGUID+4, 27564, 571, 65, 4254, 1, 1, 1, 3770.720458984375, 681.6798095703125, 78.208221435546875, 3.560471534729003906, 86400, 69299, 2), -- Soldier 4 (27564)
(@CGUID+5, 27564, 571, 65, 4254, 1, 1, 1, 3749.8125, 680.61187744140625, 78.88008880615234375, 5.951572895050048828, 86400, 69299, 2), -- Soldier 5 (27564)
(@CGUID+6, 27564, 571, 65, 4254, 1, 1, 1, 3754.420654296875, 684.20367431640625, 79.56980133056640625, 5.375614166259765625, 86400, 69299, 2), -- Soldier 6 (27564)
(@CGUID+7, 27564, 571, 65, 4254, 1, 1, 1, 3759.960205078125, 684.55242919921875, 79.56417083740234375, 4.729842185974121093, 86400, 69299, 2), -- Soldier 7 (27564)
(@CGUID+8, 27564, 571, 65, 4254, 1, 1, 1, 3754.80419921875, 680.96221923828125, 79.08824920654296875, 5.637413501739501953, 86400, 69299, 2); -- Soldier 8 (27564)

DELETE FROM `creature_formations` WHERE `leaderGUID` = @CGUID+0;
INSERT INTO `creature_formations` (`leaderGUID`, `memberGUID`, `groupAI`) VALUES
(@CGUID+0, @CGUID+0, 3),
(@CGUID+0, @CGUID+1, 3),
(@CGUID+0, @CGUID+2, 3),
(@CGUID+0, @CGUID+3, 3),
(@CGUID+0, @CGUID+4, 3),
(@CGUID+0, @CGUID+5, 3),
(@CGUID+0, @CGUID+6, 3),
(@CGUID+0, @CGUID+7, 3),
(@CGUID+0, @CGUID+8, 3);

UPDATE `creature_template` SET `flags_extra` = `flags_extra`|134217728 WHERE (`entry` IN (27564, 27567));

-- Update the dragons nearby
UPDATE `creature` SET `position_x`=3615.459961, `position_y`=753.809021, `position_z`=85.660202, `orientation`=1.390670, `wander_distance`=0.00, `MovementType`=0, `VerifiedBuild`=54261, `CreateObject`=1 WHERE `guid`=110006 AND `id`=27542;
UPDATE `creature` SET `position_x`=3599.889893, `position_y`=766.125000, `position_z`=78.575104, `orientation`=0.819270, `wander_distance`=0.00, `MovementType`=0, `VerifiedBuild`=54261, `CreateObject`=1 WHERE `guid`=109989 AND `id`=27542;
UPDATE `creature` SET `position_x`=3861.879883, `position_y`=664.810974, `position_z`=66.072701, `orientation`=2.516120, `wander_distance`=0.00, `MovementType`=0, `VerifiedBuild`=54261, `CreateObject`=1 WHERE `guid`=109990 AND `id`=27542;
UPDATE `creature` SET `position_x`=3843.209961, `position_y`=655.064026, `position_z`=73.652298, `orientation`=1.580700, `wander_distance`=0.00, `MovementType`=0, `VerifiedBuild`=54261, `CreateObject`=1 WHERE `guid`=110001 AND `id`=27542;

SET @GUID := 109995;
SET @PATH := @GUID*10;
UPDATE `creature` SET `position_x`=3774.919922, `position_y`=701.827026, `position_z`=98.784302, `wander_distance`=0, `MovementType`=2, `VerifiedBuild`=54261 WHERE `guid`=@GUID AND `id`=27542;
DELETE FROM `creature_addon` WHERE `guid`=@GUID;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes1`,`bytes2`,`emote`,`visibilityDistanceType`,`auras`) VALUES
(@GUID, @PATH, 0, 0, 0, 0, 0, NULL);
DELETE FROM `waypoint_data` WHERE `id`=@PATH;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`orientation`,`delay`,`smoothTransition`,`move_type`) VALUES
(@PATH, 1, 3774.919922, 701.827026, 98.784302, NULL, 0, 1, 1), -- 101.46y
(@PATH, 2, 3699.459961, 634.005005, 98.784302, NULL, 0, 1, 1), -- 100.91y
(@PATH, 3, 3600.159912, 616.075989, 98.784302, NULL, 0, 1, 1), -- 68.45y
(@PATH, 4, 3552.050049, 664.773987, 98.784302, NULL, 0, 1, 1), -- 71.65y
(@PATH, 5, 3580.050049, 730.703979, 100.311996, NULL, 0, 1, 1), -- 21.68y
(@PATH, 6, 3595.909912, 745.452026, 99.367500, NULL, 0, 1, 1), -- 54.54y
(@PATH, 7, 3649.959961, 752.450989, 101.533997, NULL, 0, 1, 1), -- 61.43y
(@PATH, 8, 3701.719971, 719.432007, 99.367500, NULL, 0, 1, 1), -- 78.67y
(@PATH, 9, 3717.629883, 642.588013, 104.894997, NULL, 0, 1, 1), -- 62.94y
(@PATH, 10, 3773.810059, 614.200989, 104.894997, NULL, 0, 1, 1), -- 102.40y
(@PATH, 11, 3876.139893, 617.883972, 104.894997, NULL, 0, 1, 1), -- 91.94y
(@PATH, 12, 3944.439941, 679.426025, 104.894997, NULL, 0, 1, 1), -- 51.82y
(@PATH, 13, 3925.250000, 727.560974, 104.894997, NULL, 0, 1, 1), -- 82.46y
(@PATH, 14, 3843.280029, 734.116028, 98.784302, NULL, 0, 1, 1); -- 75.60y back to 1


-- Update some creatures
UPDATE `creature` SET `position_x`=3846.620117, `position_y`=661.976013, `position_z`=60.248100, `orientation`=1.799750, `wander_distance`=0.00, `MovementType`=0, `VerifiedBuild`=50664, `CreateObject`=1 WHERE `guid`=112243 AND `id`=27564;
UPDATE `creature` SET `position_x`=3852.050049, `position_y`=665.716980, `position_z`=59.091599, `orientation`=2.647580, `wander_distance`=0.00, `MovementType`=0, `VerifiedBuild`=54261, `CreateObject`=1 WHERE `guid`=112244 AND `id`=27564;

-- Remove Old Summon Frigid Ghoul Summons (49329)
DELETE FROM `smart_scripts` WHERE (`entryorguid` = 27564) AND (`source_type` = 0) AND (`id` IN (2));
DELETE FROM `smart_scripts` WHERE (`entryorguid` = 27749) AND (`source_type` = 0) AND (`id` IN (2));

-- Remove Old Alliance Spawns
DELETE FROM `creature` WHERE `id` IN (27686, 27564, 27567, 27531, 27687, 27530, 27542) AND `guid` IN (110039,108330,99408,99407,99409,99410,99406,99420,112225,112247,112227,112221,112210,112226,112228,112523,112218,108613,99411,99412,99421,99427,99422,99423,99426,99607);
DELETE FROM `creature_addon` WHERE `guid`=99607;

DELETE FROM `waypoint_data` WHERE `id` BETWEEN ((@CGUID+0)*10)+0 AND ((@CGUID+8)*10)+3;
INSERT INTO `waypoint_data` (`id`, `point`, `position_x`, `position_y`, `position_z`, `orientation`, `smoothTransition`, `move_type`) VALUES
-- ==========================================================================
-- PATH 1  --  SOUTH PASS -> EAST PASS
-- trigger: "On the move back up to the eastern pass!" / "Up to the eastern pass! Move!"
-- ==========================================================================

-- Captain Iskandar (27567)
(((@CGUID+0)*10)+0, 1, 3664.1853, 743.5434, 80.60251 , NULL, 0, 1),
(((@CGUID+0)*10)+0, 2, 3705.3503, 717.96375, 79.20914, NULL, 0, 1),
(((@CGUID+0)*10)+0, 3, 3741.925, 686.94617, 78.98458 , NULL, 0, 1),
(((@CGUID+0)*10)+0, 4, 3785.0105, 666.7165, 77.00925 , NULL, 0, 1),
(((@CGUID+0)*10)+0, 5, 3818.5374, 657.2332, 70.50399 , NULL, 0, 1),
(((@CGUID+0)*10)+0, 6, 3847.3176, 667.232, 58.584705 , 2.268928050994873046, 0, 1),

-- Soldier 1 (27564)
(((@CGUID+1)*10)+0, 1, 3666.7605, 740.5676, 80.25237 , NULL, 0, 1),
(((@CGUID+1)*10)+0, 2, 3707.3877, 718.00696, 79.51393, NULL, 0, 1),
(((@CGUID+1)*10)+0, 3, 3744.7236, 686.0452, 79.04427 , NULL, 0, 1),
(((@CGUID+1)*10)+0, 4, 3786.1729, 673.13367, 77.9424 , NULL, 0, 1),
(((@CGUID+1)*10)+0, 5, 3818.717, 666.7327, 69.003555 , NULL, 0, 1),
(((@CGUID+1)*10)+0, 6, 3843.8794, 671.9085, 57.93257 , 2.268928050994873046, 0, 1),

-- Soldier 2 (27564)
(((@CGUID+2)*10)+0, 1, 3662.632, 742.999, 81.04816  , NULL, 0, 1),
(((@CGUID+2)*10)+0, 2, 3702.1367, 717.5947, 78.80129, NULL, 0, 1),
(((@CGUID+2)*10)+0, 3, 3738.763, 686.8559, 78.93905 , NULL, 0, 1),
(((@CGUID+2)*10)+0, 4, 3783.2605, 667.0815, 77.26925, NULL, 0, 1),
(((@CGUID+2)*10)+0, 5, 3813.4158, 657.46277, 71.3102, NULL, 0, 1),
(((@CGUID+2)*10)+0, 6, 3846.6116, 678.9256, 58.37106, 2.268928050994873046, 0, 1),

-- Soldier 3 (27564)
(((@CGUID+3)*10)+0, 1, 3663.0212, 743.1042, 80.938324, NULL, 0, 1),
(((@CGUID+3)*10)+0, 2, 3705.7952, 716.0234, 79.14264 , NULL, 0, 1),
(((@CGUID+3)*10)+0, 3, 3744.9504, 685.0866, 78.99437 , NULL, 0, 1),
(((@CGUID+3)*10)+0, 4, 3784.126, 665.10406, 77.109184, NULL, 0, 1),
(((@CGUID+3)*10)+0, 5, 3820.5674, 654.2676, 69.83214 , NULL, 0, 1),
(((@CGUID+3)*10)+0, 6, 3849.226, 674.7712, 58.362663 , 2.268928050994873046, 0, 1), 

-- Soldier 4 (27564)
(((@CGUID+4)*10)+0, 1, 3666.803, 744.38995, 80.46497  , NULL, 0, 1),
(((@CGUID+4)*10)+0, 2, 3706.174, 721.2485, 79.4731    , NULL, 0, 1),
(((@CGUID+4)*10)+0, 3, 3743.8816, 690.307, 79.454865  , NULL, 0, 1),
(((@CGUID+4)*10)+0, 4, 3786.942, 665.35474, 76.68507  , NULL, 0, 1),
(((@CGUID+4)*10)+0, 5, 3816.256, 667.1102, 70.86244   , NULL, 0, 1),
(((@CGUID+4)*10)+0, 6, 3853.7644, 676.84454, 58.918266, 2.268928050994873046, 0, 1),

-- Soldier 5 (27564)
(((@CGUID+5)*10)+0, 1, 3666.8438, 739.67267, 80.22879, NULL, 0, 1),
(((@CGUID+5)*10)+0, 2, 3706.6262, 716.10596, 79.27633, NULL, 0, 1),
(((@CGUID+5)*10)+0, 3, 3743.904, 685.53754, 78.94694 , NULL, 0, 1),
(((@CGUID+5)*10)+0, 4, 3786.385, 665.5101, 76.79468  , NULL, 0, 1),
(((@CGUID+5)*10)+0, 5, 3820.683, 653.74786, 69.57719 , NULL, 0, 1),
(((@CGUID+5)*10)+0, 6, 3835.019, 665.9576, 58.229523 , 2.234021425247192382, 0, 1),

-- Soldier 6 (27564)
(((@CGUID+6)*10)+0, 1, 3664.3762, 743.2789, 80.58217  , NULL, 0, 1),
(((@CGUID+6)*10)+0, 2, 3705.336, 717.8929, 79.20341   , NULL, 0, 1),
(((@CGUID+6)*10)+0, 3, 3741.7886, 686.91003, 78.99371 , NULL, 0, 1),
(((@CGUID+6)*10)+0, 4, 3786.3838, 666.79504, 76.8407  , NULL, 0, 1),
(((@CGUID+6)*10)+0, 5, 3818.1707, 657.25616, 70.622955, NULL, 0, 1),
(((@CGUID+6)*10)+0, 6, 3836.0032, 674.0662, 57.494442 , 2.268928050994873046, 0, 1),

-- Soldier 7 (27564)
(((@CGUID+7)*10)+0, 1, 3664.5217, 745.05756, 80.66233 , NULL, 0, 1),
(((@CGUID+7)*10)+0, 2, 3705.226, 720.6887, 79.33128   , NULL, 0, 1),
(((@CGUID+7)*10)+0, 3, 3741.0535, 691.65955, 79.404396, NULL, 0, 1),
(((@CGUID+7)*10)+0, 4, 3783.681, 670.13293, 77.57828  , NULL, 0, 1),
(((@CGUID+7)*10)+0, 5, 3811.697, 664.96857, 72.12637  , NULL, 0, 1),
(((@CGUID+7)*10)+0, 6, 3840.457, 676.5332, 57.830986  , 2.268928050994873046, 0, 1),

-- Soldier 8 (27564)
(((@CGUID+8)*10)+0, 1, 3661.264, 744.9439, 81.08813   , NULL, 0, 1),
(((@CGUID+8)*10)+0, 2, 3701.3586, 719.5161, 78.84008  , NULL, 0, 1),
(((@CGUID+8)*10)+0, 3, 3740.6836, 689.13336, 79.111336, NULL, 0, 1),
(((@CGUID+8)*10)+0, 4, 3782.0364, 667.8672, 77.37559  , NULL, 0, 1),
(((@CGUID+8)*10)+0, 5, 3813.5518, 658.8467, 71.36516  , NULL, 0, 1),
(((@CGUID+8)*10)+0, 6, 3839.341, 669.1519, 57.985825  , 2.251474618911743164, 0, 1),

-- ==========================================================================
-- PATH 2  --  EAST PASS -> SOUTH PASS
-- trigger: "They're backing off here... get to the south pass! Quickly!" / "To the south! Move!"
-- ==========================================================================

-- Captain Iskandar (27567)
(((@CGUID+0)*10)+1, 1, 3768.8252, 678.3697, 78.06411 , NULL, 0, 1),
(((@CGUID+0)*10)+1, 2, 3726.1663, 704.9991, 80.14896 , NULL, 0, 1),
(((@CGUID+0)*10)+1, 3, 3685.6584, 731.27606, 78.24634, NULL, 0, 1),
(((@CGUID+0)*10)+1, 4, 3648.1199, 756.0481, 82.18794 , NULL, 0, 1),
(((@CGUID+0)*10)+1, 5, 3613.8035, 769.6447, 71.40946 , 1.099557399749755859, 0, 1),

-- Soldier 1 (27564)
(((@CGUID+1)*10)+1, 1, 3766.4626, 676.31964, 78.25649, NULL, 0, 1),
(((@CGUID+1)*10)+1, 2, 3725.1204, 702.493, 79.861984 , NULL, 0, 1),
(((@CGUID+1)*10)+1, 3, 3684.443, 729.3193, 78.32527  , NULL, 0, 1),
(((@CGUID+1)*10)+1, 4, 3647.6191, 753.4248, 82.67778 , NULL, 0, 1),
(((@CGUID+1)*10)+1, 5, 3614.318, 772.31415, 71.023026, 1.099557399749755859, 0, 1),

-- Soldier 2 (27564)
(((@CGUID+2)*10)+1, 1, 3766.2317, 676.41016, 78.284676, NULL, 0, 1),
(((@CGUID+2)*10)+1, 2, 3725.0183, 703.82446, 79.96684 , NULL, 0, 1),
(((@CGUID+2)*10)+1, 3, 3683.2053, 728.40985, 78.66363 , NULL, 0, 1),
(((@CGUID+2)*10)+1, 4, 3645.3572, 754.9374, 81.95001  , NULL, 0, 1),
(((@CGUID+2)*10)+1, 5, 3618.5894, 773.3537, 70.67668  , 1.099557399749755859, 0, 1),

-- Soldier 3 (27564)
(((@CGUID+3)*10)+1, 1, 3767.095, 685.4401, 78.747375 , NULL, 0, 1),
(((@CGUID+3)*10)+1, 2, 3728.3013, 706.2984, 80.44603 , NULL, 0, 1),
(((@CGUID+3)*10)+1, 3, 3688.0051, 733.4498, 78.15838 , NULL, 0, 1),
(((@CGUID+3)*10)+1, 4, 3653.3564, 753.41113, 82.56124, NULL, 0, 1),
(((@CGUID+3)*10)+1, 5, 3617.2458, 770.70123, 71.12394, 1.099557399749755859, 0, 1),

-- Soldier 4 (27564)
(((@CGUID+4)*10)+1, 1, 3769.217, 680.07587, 78.069916, NULL, 0, 1),
(((@CGUID+4)*10)+1, 2, 3727.02, 706.22894, 80.31082  , NULL, 0, 1),
(((@CGUID+4)*10)+1, 3, 3686.3938, 733.1165, 78.15929 , NULL, 0, 1),
(((@CGUID+4)*10)+1, 4, 3649.8186, 757.3432, 82.56831 , NULL, 0, 1),
(((@CGUID+4)*10)+1, 5, 3619.6326, 769.14233, 71.30871, 1.099557399749755859, 0, 1),

-- Soldier 5 (27564)
(((@CGUID+5)*10)+1, 1, 3769.869, 675.0831, 78.00389  , NULL, 0, 1),
(((@CGUID+5)*10)+1, 2, 3726.3782, 699.79034, 79.71018, NULL, 0, 1),
(((@CGUID+5)*10)+1, 3, 3686.1584, 727.3931, 78.23495 , NULL, 0, 1),
(((@CGUID+5)*10)+1, 4, 3649.4211, 750.8833, 82.896484, NULL, 0, 1),
(((@CGUID+5)*10)+1, 5, 3608.8962, 774.6639, 71.21135 , 1.099557399749755859, 0, 1),

-- Soldier 6 (27564)
(((@CGUID+6)*10)+1, 1, 3768.8994, 678.05457, 78.04416 , NULL, 0, 1),
(((@CGUID+6)*10)+1, 2, 3728.7188, 706.09, 80.466354   , NULL, 0, 1),
(((@CGUID+6)*10)+1, 3, 3689.9966, 728.2758, 78.37219  , NULL, 0, 1),
(((@CGUID+6)*10)+1, 4, 3652.6562, 751.56445, 82.36038 , NULL, 0, 1),
(((@CGUID+6)*10)+1, 5, 3612.8298, 776.55817, 70.557816, 1.099557399749755859, 0, 1),

-- Soldier 7 (27564)
(((@CGUID+7)*10)+1, 1, 3767.7493, 681.76434, 78.21749, NULL, 0, 1),
(((@CGUID+7)*10)+1, 2, 3725.9995, 705.8206, 80.1919  , NULL, 0, 1),
(((@CGUID+7)*10)+1, 3, 3686.6306, 732.04425, 78.21279, NULL, 0, 1),
(((@CGUID+7)*10)+1, 4, 3648.5955, 757.7414, 82.09204 , NULL, 0, 1),
(((@CGUID+7)*10)+1, 5, 3615.5586, 775.24554, 70.54306, 1.099557399749755859, 0, 1),

-- Soldier 8 (27564)
(((@CGUID+8)*10)+1, 1, 3765.7678, 680.35223, 78.372955, NULL, 0, 1),
(((@CGUID+8)*10)+1, 2, 3722.7988, 705.9375, 79.89299  , NULL, 0, 1),
(((@CGUID+8)*10)+1, 3, 3684.2183, 731.5422, 78.22879  , NULL, 0, 1),
(((@CGUID+8)*10)+1, 4, 3644.2935, 759.77716, 78.97675 , NULL, 0, 1),
(((@CGUID+8)*10)+1, 5, 3611.761, 773.5433, 71.0446    , 1.099557399749755859, 0, 1),

-- ==========================================================================
-- PATH 3  --  SOUTH PASS -> SHRINE
-- trigger: "Push them back to the shrine!" / "Push them back and crush them!"
-- ==========================================================================

-- Captain Iskandar (27567)
(((@CGUID+0)*10)+2, 1, 3636.2717, 831.94476, 62.09581, NULL, 0, 1),
(((@CGUID+0)*10)+2, 2, 3670.6267, 862.5305, 56.525215, 0.72877204418182373, 0, 1),

-- Soldier 1 (27564)
(((@CGUID+1)*10)+2, 1, 3645.3616, 833.8261, 61.201496, NULL, 0, 1),
(((@CGUID+1)*10)+2, 2, 3672.924, 859.67755, 57.21561 , 0.752923846244812011, 0, 1),

-- Soldier 2 (27564)
(((@CGUID+2)*10)+2, 1, 3638.6726, 831.93646, 61.984608, NULL, 0, 1),
(((@CGUID+2)*10)+2, 2, 3659.9465, 867.00323, 56.42431 , 0.767944872379302978, 0, 1),

-- Soldier 3 (27564)
(((@CGUID+3)*10)+2, 1, 3646.3364, 830.9135, 61.391457, NULL, 0, 1),
(((@CGUID+3)*10)+2, 2, 3674.4683, 855.569, 57.858135 , 0.718384385108947753, 0, 1),

-- Soldier 4 (27564)
(((@CGUID+4)*10)+2, 1, 3643.1914, 821.843, 62.37757 , NULL, 0, 1),
(((@CGUID+4)*10)+2, 2, 3674.641, 851.6335, 57.736794, 0.758156239986419677, 0, 1),

-- Soldier 5 (27564)
(((@CGUID+5)*10)+2, 1, 3634.9062, 834.31384, 61.950775, NULL, 0, 1),
(((@CGUID+5)*10)+2, 2, 3663.5305, 866.5019, 56.303856 , 0.844188630580902099, 0, 1),

-- Soldier 6 (27564)
(((@CGUID+6)*10)+2, 1, 3638.9329, 835.89484, 61.394173, NULL, 0, 1),
(((@CGUID+6)*10)+2, 2, 3667.1167, 861.211, 56.656033  , 0.732522368431091308, 0, 1),

-- Soldier 7 (27564)
(((@CGUID+7)*10)+2, 1, 3644.177, 835.9828, 61.18009 , NULL, 0, 1),
(((@CGUID+7)*10)+2, 2, 3665.639, 854.9014, 57.103893, 0.874624490737915039, 0, 1),

-- Soldier 8 (27564)
(((@CGUID+8)*10)+2, 1, 3644.2617, 832.04205, 61.350395, NULL, 0, 1),
(((@CGUID+8)*10)+2, 2, 3667.1372, 865.4031, 56.24513  , 0.767944872379302978, 0, 1),

-- ==========================================================================================
-- PATH 4  --  EAST CAMP -> SOUTH PASS      ("On the move to the southern pass!")
--   run 1: 20:08:36.090  (squad spawned 20:06:02/20:06:09)
--   run 2: 20:13:42.303  (squad spawned 20:13:31)
--
-- VERDICT: this is NOT a separate route. It is PATH 2 with node 1 dropped.
-- Path 2 node 1 (~3766-3769 / 675-685) sits 8-11 yd in front of the camp spawn points, so a
-- squad starting at the camp skips it and goes straight to Path 2 node 2. Nodes below are
-- byte-identical to Path 2 nodes 2..5 for 8 of the 9 slots, in BOTH camp runs.
-- The single exception is Soldier 8's first node (see its entry). Final facing is the same
-- 1.099557399749755859 as Path 2, for all 9.
-- 
-- User Note: I'm keeping this because it's easier, sue me.
-- Actually we could make another parameter for waypoint start to start at a different point.
-- ==========================================================================================

-- Captain Iskandar (27567)
(((@CGUID+0)*10)+3, 1, 3726.1663, 704.9991, 80.14896 , NULL, 0, 1),
(((@CGUID+0)*10)+3, 2, 3685.6584, 731.27606, 78.24634, NULL, 0, 1),
(((@CGUID+0)*10)+3, 3, 3648.1199, 756.0481, 82.18794 , NULL, 0, 1),
(((@CGUID+0)*10)+3, 4, 3613.8035, 769.6447, 71.40946 , 1.099557399749755859, 0, 1),

-- Soldier 1 (27564)
(((@CGUID+1)*10)+3, 1, 3725.1204, 702.493, 79.861984 , NULL, 0, 1),
(((@CGUID+1)*10)+3, 2, 3684.443, 729.3193, 78.32527  , NULL, 0, 1),
(((@CGUID+1)*10)+3, 3, 3647.6191, 753.4248, 82.67778 , NULL, 0, 1),
(((@CGUID+1)*10)+3, 4, 3614.318, 772.31415, 71.023026, 1.099557399749755859, 0, 1),

-- Soldier 2 (27564)
(((@CGUID+2)*10)+3, 1, 3725.0183, 703.82446, 79.96684, NULL, 0, 1),
(((@CGUID+2)*10)+3, 2, 3683.2053, 728.40985, 78.66363, NULL, 0, 1),
(((@CGUID+2)*10)+3, 3, 3645.3572, 754.9374, 81.95001 , NULL, 0, 1),
(((@CGUID+2)*10)+3, 4, 3618.5894, 773.3537, 70.67668 , 1.099557399749755859, 0, 1),

-- Soldier 3 (27564)
(((@CGUID+3)*10)+3, 1, 3728.3013, 706.2984, 80.44603 , NULL, 0, 1),
(((@CGUID+3)*10)+3, 2, 3688.0051, 733.4498, 78.15838 , NULL, 0, 1),
(((@CGUID+3)*10)+3, 3, 3653.3564, 753.41113, 82.56124, NULL, 0, 1),
(((@CGUID+3)*10)+3, 4, 3617.2458, 770.70123, 71.12394, 1.099557399749755859, 0, 1),

-- Soldier 4 (27564)
(((@CGUID+4)*10)+3, 1, 3727.02, 706.22894, 80.31082  , NULL, 0, 1),
(((@CGUID+4)*10)+3, 2, 3686.3938, 733.1165, 78.15929 , NULL, 0, 1),
(((@CGUID+4)*10)+3, 3, 3649.8186, 757.3432, 82.56831 , NULL, 0, 1),
(((@CGUID+4)*10)+3, 4, 3619.6326, 769.14233, 71.30871, 1.099557399749755859, 0, 1),

-- Soldier 5 (27564)
(((@CGUID+5)*10)+3, 1, 3726.3782, 699.79034, 79.71018, NULL, 0, 1),
(((@CGUID+5)*10)+3, 2, 3686.1584, 727.3931, 78.23495 , NULL, 0, 1),
(((@CGUID+5)*10)+3, 3, 3649.4211, 750.8833, 82.896484, NULL, 0, 1),
(((@CGUID+5)*10)+3, 4, 3608.8962, 774.6639, 71.21135 , 1.099557399749755859, 0, 1),

-- Soldier 6 (27564)
(((@CGUID+6)*10)+3, 1, 3728.7188, 706.09, 80.466354   , NULL, 0, 1),
(((@CGUID+6)*10)+3, 2, 3689.9966, 728.2758, 78.37219  , NULL, 0, 1),
(((@CGUID+6)*10)+3, 3, 3652.6562, 751.56445, 82.36038 , NULL, 0, 1),
(((@CGUID+6)*10)+3, 4, 3612.8298, 776.55817, 70.557816, 1.099557399749755859, 0, 1),

-- Soldier 7 (27564)
(((@CGUID+7)*10)+3, 1, 3725.9995, 705.8206, 80.1919  , NULL, 0, 1),
(((@CGUID+7)*10)+3, 2, 3686.6306, 732.04425, 78.21279, NULL, 0, 1),
(((@CGUID+7)*10)+3, 3, 3648.5955, 757.7414, 82.09204 , NULL, 0, 1),
(((@CGUID+7)*10)+3, 4, 3615.5586, 775.24554, 70.54306, 1.099557399749755859, 0, 1),

-- Soldier 8 (27564)
(((@CGUID+8)*10)+3, 1, 3722.7556, 705.9954, 79.940636, NULL, 0, 1),
(((@CGUID+8)*10)+3, 2, 3684.2183, 731.5422, 78.22879 , NULL, 0, 1),
(((@CGUID+8)*10)+3, 3, 3644.2935, 759.77716, 78.97675, NULL, 0, 1),
(((@CGUID+8)*10)+3, 4, 3611.761, 773.5433, 71.0446   , 1.099557399749755859, 0, 1);

-- Correct Conscripts
DELETE FROM `creature` WHERE `guid` = @CGUID+9 AND `id` IN (27564);
INSERT INTO `creature` (`guid`,`id`,`map`,`zoneId`,`areaId`,`spawnMask`,`phaseMask`,`equipment_id`,`position_x`,`position_y`,`position_z`,`orientation`,`spawntimesecs`,`wander_distance`,`MovementType`,`unit_flags`,`VerifiedBuild`,`CreateObject`) VALUES
(@CGUID+9, 27564, 571, 65, 4254, 1, 1, 1, 3644.159912, 751.286987, 85.298302, 2.057580, 300, 0.00, 0, 0, 54261, 1);

UPDATE `creature` SET `position_x`=3633.919922, `position_y`=747.755005, `position_z`=82.171799, `orientation`=1.979700, `wander_distance`=0.00, `MovementType`=0, `VerifiedBuild`=54261, `CreateObject`=1 WHERE `guid`=112198 AND `id`=27564;
UPDATE `creature` SET `position_x`=3657.679932, `position_y`=732.791016, `position_z`=118.88400, `orientation`=1.968690, `wander_distance`=0.00, `MovementType`=0, `VerifiedBuild`=54261, `CreateObject`=1 WHERE `guid`=112199 AND `id`=27564;
UPDATE `creature` SET `position_x`=3666.179932, `position_y`=727.541016, `position_z`=112.16600, `orientation`=1.971730, `wander_distance`=0.00, `MovementType`=0, `VerifiedBuild`=54261, `CreateObject`=1 WHERE `guid`=112196 AND `id`=27564;
UPDATE `creature` SET `position_x`=3772.659912, `position_y`=724.043030, `position_z`=82.431602, `orientation`=1.225960, `wander_distance`=0.00, `MovementType`=0, `VerifiedBuild`=54261, `CreateObject`=1 WHERE `guid`=112209 AND `id`=27564;
UPDATE `creature` SET `position_x`=3783.899902, `position_y`=701.737000, `position_z`=79.870003, `orientation`=1.491850, `wander_distance`=0.00, `MovementType`=0, `VerifiedBuild`=54261, `CreateObject`=1 WHERE `guid`=112197 AND `id`=27564;
UPDATE `creature` SET `position_x`=3794.830078, `position_y`=691.456970, `position_z`=77.904198, `orientation`=1.385990, `wander_distance`=0.00, `MovementType`=0, `VerifiedBuild`=54261, `CreateObject`=1 WHERE `guid`=112211 AND `id`=27564;
UPDATE `creature` SET `position_x`=3807.050049, `position_y`=683.590027, `position_z`=76.553299, `orientation`=1.835710, `wander_distance`=0.00, `MovementType`=0, `VerifiedBuild`=54261, `CreateObject`=1 WHERE `guid`=112208 AND `id`=27564;
UPDATE `creature` SET `position_x`=3703.879883, `position_y`=699.020996, `position_z`=89.285698, `orientation`=3.769910, `wander_distance`=0.00, `MovementType`=0, `VerifiedBuild`=54261, `CreateObject`=1 WHERE `guid`=106514 AND `id`=27506;
UPDATE `creature` SET `position_x`=3701.000000, `position_y`=697.627014, `position_z`=89.976601, `orientation`=0.463364, `wander_distance`=0.00, `MovementType`=0, `VerifiedBuild`=54261, `CreateObject`=1 WHERE `guid`=112220 AND `id`=27564;
UPDATE `creature` SET `position_x`=3700.659912, `position_y`=699.822021, `position_z`=89.878098, `orientation`=6.056540, `wander_distance`=0.00, `MovementType`=0, `VerifiedBuild`=54261, `CreateObject`=1 WHERE `guid`=112219 AND `id`=27564;

DELETE FROM `creature_addon` WHERE `guid` IN (@CGUID+9,112198,112199,112196,112209,112197,112211,112208,106514,112220,112219,112243,112244,112245,112246);
INSERT INTO `creature_addon` (`guid`,`bytes2`,`emote`) VALUES
(@CGUID+9, 2, 376),
(112198, 2, 376),
(112199, 2, 376),
(112196, 2, 376),
(112209, 2, 376),
(112197, 2, 376),
(112211, 2, 376),
(112208, 2, 376),

(112245, 1, 333),
(112246, 1, 333),
(112243, 1, 333),
(112244, 1, 333);

-- SAI for Waypoints
DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` BETWEEN -(@CGUID+8) AND -(@CGUID+0));
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(-(@CGUID+0), 0, 1000, 0, 72, 0, 100, 0, 0, 0, 0, 0, 0, 0, 232, ((@CGUID+0)*10)+0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Captain Iskandar or Alliance Conscripts - On Action 0 Done - Start Path South Pass to East Pass'),
(-(@CGUID+1), 0, 1000, 0, 72, 0, 100, 0, 0, 0, 0, 0, 0, 0, 232, ((@CGUID+1)*10)+0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Captain Iskandar or Alliance Conscripts - On Action 0 Done - Start Path South Pass to East Pass'),
(-(@CGUID+2), 0, 1000, 0, 72, 0, 100, 0, 0, 0, 0, 0, 0, 0, 232, ((@CGUID+2)*10)+0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Captain Iskandar or Alliance Conscripts - On Action 0 Done - Start Path South Pass to East Pass'),
(-(@CGUID+3), 0, 1000, 0, 72, 0, 100, 0, 0, 0, 0, 0, 0, 0, 232, ((@CGUID+3)*10)+0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Captain Iskandar or Alliance Conscripts - On Action 0 Done - Start Path South Pass to East Pass'),
(-(@CGUID+4), 0, 1000, 0, 72, 0, 100, 0, 0, 0, 0, 0, 0, 0, 232, ((@CGUID+4)*10)+0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Captain Iskandar or Alliance Conscripts - On Action 0 Done - Start Path South Pass to East Pass'),
(-(@CGUID+5), 0, 1000, 0, 72, 0, 100, 0, 0, 0, 0, 0, 0, 0, 232, ((@CGUID+5)*10)+0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Captain Iskandar or Alliance Conscripts - On Action 0 Done - Start Path South Pass to East Pass'),
(-(@CGUID+6), 0, 1000, 0, 72, 0, 100, 0, 0, 0, 0, 0, 0, 0, 232, ((@CGUID+6)*10)+0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Captain Iskandar or Alliance Conscripts - On Action 0 Done - Start Path South Pass to East Pass'),
(-(@CGUID+7), 0, 1000, 0, 72, 0, 100, 0, 0, 0, 0, 0, 0, 0, 232, ((@CGUID+7)*10)+0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Captain Iskandar or Alliance Conscripts - On Action 0 Done - Start Path South Pass to East Pass'),
(-(@CGUID+8), 0, 1000, 0, 72, 0, 100, 0, 0, 0, 0, 0, 0, 0, 232, ((@CGUID+8)*10)+0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Captain Iskandar or Alliance Conscripts - On Action 0 Done - Start Path South Pass to East Pass'),

(-(@CGUID+0), 0, 1001, 0, 72, 0, 100, 0, 1, 0, 0, 0, 0, 0, 232, ((@CGUID+0)*10)+1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Captain Iskandar or Alliance Conscripts - On Action 1 Done - Start Path East Pass to South Pass'),
(-(@CGUID+1), 0, 1001, 0, 72, 0, 100, 0, 1, 0, 0, 0, 0, 0, 232, ((@CGUID+1)*10)+1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Captain Iskandar or Alliance Conscripts - On Action 1 Done - Start Path East Pass to South Pass'),
(-(@CGUID+2), 0, 1001, 0, 72, 0, 100, 0, 1, 0, 0, 0, 0, 0, 232, ((@CGUID+2)*10)+1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Captain Iskandar or Alliance Conscripts - On Action 1 Done - Start Path East Pass to South Pass'),
(-(@CGUID+3), 0, 1001, 0, 72, 0, 100, 0, 1, 0, 0, 0, 0, 0, 232, ((@CGUID+3)*10)+1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Captain Iskandar or Alliance Conscripts - On Action 1 Done - Start Path East Pass to South Pass'),
(-(@CGUID+4), 0, 1001, 0, 72, 0, 100, 0, 1, 0, 0, 0, 0, 0, 232, ((@CGUID+4)*10)+1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Captain Iskandar or Alliance Conscripts - On Action 1 Done - Start Path East Pass to South Pass'),
(-(@CGUID+5), 0, 1001, 0, 72, 0, 100, 0, 1, 0, 0, 0, 0, 0, 232, ((@CGUID+5)*10)+1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Captain Iskandar or Alliance Conscripts - On Action 1 Done - Start Path East Pass to South Pass'),
(-(@CGUID+6), 0, 1001, 0, 72, 0, 100, 0, 1, 0, 0, 0, 0, 0, 232, ((@CGUID+6)*10)+1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Captain Iskandar or Alliance Conscripts - On Action 1 Done - Start Path East Pass to South Pass'),
(-(@CGUID+7), 0, 1001, 0, 72, 0, 100, 0, 1, 0, 0, 0, 0, 0, 232, ((@CGUID+7)*10)+1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Captain Iskandar or Alliance Conscripts - On Action 1 Done - Start Path East Pass to South Pass'),
(-(@CGUID+8), 0, 1001, 0, 72, 0, 100, 0, 1, 0, 0, 0, 0, 0, 232, ((@CGUID+8)*10)+1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Captain Iskandar or Alliance Conscripts - On Action 1 Done - Start Path East Pass to South Pass'),

(-(@CGUID+0), 0, 1002, 0, 72, 0, 100, 0, 2, 0, 0, 0, 0, 0, 232, ((@CGUID+0)*10)+2, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Captain Iskandar or Alliance Conscripts - On Action 2 Done - Start Path South Pass to Shrine'),
(-(@CGUID+1), 0, 1002, 0, 72, 0, 100, 0, 2, 0, 0, 0, 0, 0, 232, ((@CGUID+1)*10)+2, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Captain Iskandar or Alliance Conscripts - On Action 2 Done - Start Path South Pass to Shrine'),
(-(@CGUID+2), 0, 1002, 0, 72, 0, 100, 0, 2, 0, 0, 0, 0, 0, 232, ((@CGUID+2)*10)+2, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Captain Iskandar or Alliance Conscripts - On Action 2 Done - Start Path South Pass to Shrine'),
(-(@CGUID+3), 0, 1002, 0, 72, 0, 100, 0, 2, 0, 0, 0, 0, 0, 232, ((@CGUID+3)*10)+2, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Captain Iskandar or Alliance Conscripts - On Action 2 Done - Start Path South Pass to Shrine'),
(-(@CGUID+4), 0, 1002, 0, 72, 0, 100, 0, 2, 0, 0, 0, 0, 0, 232, ((@CGUID+4)*10)+2, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Captain Iskandar or Alliance Conscripts - On Action 2 Done - Start Path South Pass to Shrine'),
(-(@CGUID+5), 0, 1002, 0, 72, 0, 100, 0, 2, 0, 0, 0, 0, 0, 232, ((@CGUID+5)*10)+2, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Captain Iskandar or Alliance Conscripts - On Action 2 Done - Start Path South Pass to Shrine'),
(-(@CGUID+6), 0, 1002, 0, 72, 0, 100, 0, 2, 0, 0, 0, 0, 0, 232, ((@CGUID+6)*10)+2, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Captain Iskandar or Alliance Conscripts - On Action 2 Done - Start Path South Pass to Shrine'),
(-(@CGUID+7), 0, 1002, 0, 72, 0, 100, 0, 2, 0, 0, 0, 0, 0, 232, ((@CGUID+7)*10)+2, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Captain Iskandar or Alliance Conscripts - On Action 2 Done - Start Path South Pass to Shrine'),
(-(@CGUID+8), 0, 1002, 0, 72, 0, 100, 0, 2, 0, 0, 0, 0, 0, 232, ((@CGUID+8)*10)+2, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Captain Iskandar or Alliance Conscripts - On Action 2 Done - Start Path South Pass to Shrine'),

(-(@CGUID+0), 0, 1003, 0, 72, 0, 100, 0, 3, 0, 0, 0, 0, 0, 232, ((@CGUID+0)*10)+3, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Captain Iskandar or Alliance Conscripts - On Action 3 Done - Start Path Spawn to South Pass'),
(-(@CGUID+1), 0, 1003, 0, 72, 0, 100, 0, 3, 0, 0, 0, 0, 0, 232, ((@CGUID+1)*10)+3, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Captain Iskandar or Alliance Conscripts - On Action 3 Done - Start Path Spawn to South Pass'),
(-(@CGUID+2), 0, 1003, 0, 72, 0, 100, 0, 3, 0, 0, 0, 0, 0, 232, ((@CGUID+2)*10)+3, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Captain Iskandar or Alliance Conscripts - On Action 3 Done - Start Path Spawn to South Pass'),
(-(@CGUID+3), 0, 1003, 0, 72, 0, 100, 0, 3, 0, 0, 0, 0, 0, 232, ((@CGUID+3)*10)+3, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Captain Iskandar or Alliance Conscripts - On Action 3 Done - Start Path Spawn to South Pass'),
(-(@CGUID+4), 0, 1003, 0, 72, 0, 100, 0, 3, 0, 0, 0, 0, 0, 232, ((@CGUID+4)*10)+3, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Captain Iskandar or Alliance Conscripts - On Action 3 Done - Start Path Spawn to South Pass'),
(-(@CGUID+5), 0, 1003, 0, 72, 0, 100, 0, 3, 0, 0, 0, 0, 0, 232, ((@CGUID+5)*10)+3, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Captain Iskandar or Alliance Conscripts - On Action 3 Done - Start Path Spawn to South Pass'),
(-(@CGUID+6), 0, 1003, 0, 72, 0, 100, 0, 3, 0, 0, 0, 0, 0, 232, ((@CGUID+6)*10)+3, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Captain Iskandar or Alliance Conscripts - On Action 3 Done - Start Path Spawn to South Pass'),
(-(@CGUID+7), 0, 1003, 0, 72, 0, 100, 0, 3, 0, 0, 0, 0, 0, 232, ((@CGUID+7)*10)+3, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Captain Iskandar or Alliance Conscripts - On Action 3 Done - Start Path Spawn to South Pass'),
(-(@CGUID+8), 0, 1003, 0, 72, 0, 100, 0, 3, 0, 0, 0, 0, 0, 232, ((@CGUID+8)*10)+3, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Captain Iskandar or Alliance Conscripts - On Action 3 Done - Start Path Spawn to South Pass'),

(-(@CGUID+0), 0, 1004, 0, 109, 0, 100, 0, 0, 0, 0, 0, 0, 0, 17, 375, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Captain Iskandar or Alliance Conscripts - On Path Finished - Set Emote State 375'),
(-(@CGUID+1), 0, 1004, 0, 109, 0, 100, 0, 0, 0, 0, 0, 0, 0, 17, 333, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Captain Iskandar or Alliance Conscripts - On Path Finished - Set Emote State 333'),
(-(@CGUID+2), 0, 1004, 0, 109, 0, 100, 0, 0, 0, 0, 0, 0, 0, 17, 333, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Captain Iskandar or Alliance Conscripts - On Path Finished - Set Emote State 333'),
(-(@CGUID+3), 0, 1004, 0, 109, 0, 100, 0, 0, 0, 0, 0, 0, 0, 17, 333, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Captain Iskandar or Alliance Conscripts - On Path Finished - Set Emote State 333'),
(-(@CGUID+4), 0, 1004, 0, 109, 0, 100, 0, 0, 0, 0, 0, 0, 0, 17, 333, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Captain Iskandar or Alliance Conscripts - On Path Finished - Set Emote State 333'),
(-(@CGUID+5), 0, 1004, 0, 109, 0, 100, 0, 0, 0, 0, 0, 0, 0, 17, 333, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Captain Iskandar or Alliance Conscripts - On Path Finished - Set Emote State 333'),
(-(@CGUID+6), 0, 1004, 0, 109, 0, 100, 0, 0, 0, 0, 0, 0, 0, 17, 333, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Captain Iskandar or Alliance Conscripts - On Path Finished - Set Emote State 333'),
(-(@CGUID+7), 0, 1004, 0, 109, 0, 100, 0, 0, 0, 0, 0, 0, 0, 17, 333, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Captain Iskandar or Alliance Conscripts - On Path Finished - Set Emote State 333'),
(-(@CGUID+8), 0, 1004, 0, 109, 0, 100, 0, 0, 0, 0, 0, 0, 0, 17, 333, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Captain Iskandar or Alliance Conscripts - On Path Finished - Set Emote State 333'),

(-(@CGUID+0), 0, 1005, 0, 21, 0, 100, 0, 0, 0, 0, 0, 0, 0, 17, 375, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Captain Iskandar or Alliance Conscripts - On Reached Home - Set Emote State 375'),
(-(@CGUID+1), 0, 1005, 0, 21, 0, 100, 0, 0, 0, 0, 0, 0, 0, 17, 333, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Captain Iskandar or Alliance Conscripts - On Reached Home - Set Emote State 333'),
(-(@CGUID+2), 0, 1005, 0, 21, 0, 100, 0, 0, 0, 0, 0, 0, 0, 17, 333, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Captain Iskandar or Alliance Conscripts - On Reached Home - Set Emote State 333'),
(-(@CGUID+3), 0, 1005, 0, 21, 0, 100, 0, 0, 0, 0, 0, 0, 0, 17, 333, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Captain Iskandar or Alliance Conscripts - On Reached Home - Set Emote State 333'),
(-(@CGUID+4), 0, 1005, 0, 21, 0, 100, 0, 0, 0, 0, 0, 0, 0, 17, 333, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Captain Iskandar or Alliance Conscripts - On Reached Home - Set Emote State 333'),
(-(@CGUID+5), 0, 1005, 0, 21, 0, 100, 0, 0, 0, 0, 0, 0, 0, 17, 333, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Captain Iskandar or Alliance Conscripts - On Reached Home - Set Emote State 333'),
(-(@CGUID+6), 0, 1005, 0, 21, 0, 100, 0, 0, 0, 0, 0, 0, 0, 17, 333, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Captain Iskandar or Alliance Conscripts - On Reached Home - Set Emote State 333'),
(-(@CGUID+7), 0, 1005, 0, 21, 0, 100, 0, 0, 0, 0, 0, 0, 0, 17, 333, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Captain Iskandar or Alliance Conscripts - On Reached Home - Set Emote State 333'),
(-(@CGUID+8), 0, 1005, 0, 21, 0, 100, 0, 0, 0, 0, 0, 0, 0, 17, 333, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Captain Iskandar or Alliance Conscripts - On Reached Home - Set Emote State 333');

-- SAI for march
DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = 27567);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(27567, 0, 0, 0, 0, 0, 100, 0, 3000, 7000, 7000, 11000, 0, 0, 11, 42724, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Captain Iskandar - In Combat - Cast \'Cleave\''),
(27567, 0, 1, 0, 9, 0, 100, 0, 0, 0, 11000, 16000, 0, 5, 11, 15708, 1, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Captain Iskandar - Within 0-5 Range - Cast \'Mortal Strike\''),
(27567, 0, 2, 0, 0, 0, 100, 0, 11000, 14000, 19000, 22000, 0, 0, 11, 38618, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Captain Iskandar - In Combat - Cast \'Whirlwind\''),
(27567, 0, 3, 0, 1, 0, 100, 0, 30000, 90000, 30000, 90000, 0, 0, 86, 49329, 0, 206, 2, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Captain Iskandar - Out of Combat - Cross Cast \'Summon Frigid Ghoul Attacker\'');

DELETE FROM `smart_scripts` WHERE (`entryorguid` = 27567) AND (`source_type` = 0) AND (`id` IN (4, 5, 6, 7));
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(27567, 0, 4, 0, 72, 0, 100, 0, 10, 0, 0, 0, 0, 0, 223, 0, 0, 0, 0, 0, 0, 206, 2, 0, 0, 0, 0, 0, 0, 0, 'Captain Iskandar - On Action 10 Done - Do Action ID 0'),
(27567, 0, 5, 0, 72, 0, 100, 0, 11, 0, 0, 0, 0, 0, 223, 1, 0, 0, 0, 0, 0, 206, 2, 0, 0, 0, 0, 0, 0, 0, 'Captain Iskandar - On Action 11 Done - Do Action ID 1'),
(27567, 0, 6, 0, 72, 0, 100, 0, 12, 0, 0, 0, 0, 0, 223, 2, 0, 0, 0, 0, 0, 206, 2, 0, 0, 0, 0, 0, 0, 0, 'Captain Iskandar - On Action 12 Done - Do Action ID 2'),
(27567, 0, 7, 0, 72, 0, 100, 0, 13, 0, 0, 0, 0, 0, 223, 3, 0, 0, 0, 0, 0, 206, 2, 0, 0, 0, 0, 0, 0, 0, 'Captain Iskandar - On Action 13 Done - Do Action ID 3');
