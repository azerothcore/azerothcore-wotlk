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

-- Remove the opening Shoot, which the ranged rows below already cover
DELETE FROM `smart_scripts` WHERE (`entryorguid` = 27564) AND (`source_type` = 0) AND (`id` IN (2));
DELETE FROM `smart_scripts` WHERE (`entryorguid` = 27749) AND (`source_type` = 0) AND (`id` IN (2));

-- Summon Frigid Ghoul Attacker (49329) is a volley the captain fires for his whole squad at
-- once, not a timer each conscript keeps for itself: all 94 volleys in the sniff have every one
-- of their casts on a single timestamp - span 0.000s, 37 of them with 8 casters and 9 with all 9
-- - landing 15-16s apart. The template row is SMART_EVENT_UPDATE_OOC on top of that, so on a line
-- that is in combat for practically the whole event it never fired at all. npc_heated_battle_captain
-- casts it on every living formation member instead, so the per-conscript row only gets in the way.
DELETE FROM `smart_scripts` WHERE (`source_type` = 0) AND (`entryorguid` IN (27564, 27749)) AND (`id` = 15);

-- Remove Old Alliance Spawns
DELETE FROM `creature` WHERE `id` IN (27686, 27564, 27567, 27531, 27687, 27530, 27542) AND `guid` IN (110039,108330,99408,99407,99409,99410,99406,99420,112225,112247,112227,112221,112210,112226,112228,112523,112218,108613,99411,99412,99421,99427,99422,99423,99426,99607);
DELETE FROM `creature_addon` WHERE `guid`=99607;

-- WaypointMovementGenerator only applies a node's orientation when that node also carries a
-- delay (WaypointMovementGenerator.cpp, StartMove and the passed-waypoint branch both gate on
-- `Delay > 0`), so a facing put on a node the creature walks through is silently dropped. Every
-- march therefore ends with the position node followed by a second node on the same coordinates
-- that carries the facing and a 1ms delay: MoveSplineInit recognises the zero length move as an
-- orientation-only spline, so the squad turns without pausing.
DELETE FROM `waypoint_data` WHERE `id` BETWEEN ((@CGUID+0)*10)+0 AND ((@CGUID+8)*10)+3;
INSERT INTO `waypoint_data` (`id`, `point`, `position_x`, `position_y`, `position_z`, `orientation`, `delay`, `smoothTransition`, `move_type`) VALUES
-- ==========================================================================
-- PATH 1  --  SOUTH PASS -> EAST PASS
-- trigger: "On the move back up to the eastern pass!" / "Up to the eastern pass! Move!"
-- ==========================================================================

-- Captain Iskandar (27567)
(((@CGUID+0)*10)+0, 1, 3664.1853, 743.5434, 80.60251, NULL, 0, 0, 1),
(((@CGUID+0)*10)+0, 2, 3705.3503, 717.96375, 79.20914, NULL, 0, 0, 1),
(((@CGUID+0)*10)+0, 3, 3741.925, 686.94617, 78.98458, NULL, 0, 0, 1),
(((@CGUID+0)*10)+0, 4, 3785.0105, 666.7165, 77.00925, NULL, 0, 0, 1),
(((@CGUID+0)*10)+0, 5, 3818.5374, 657.2332, 70.50399, NULL, 0, 0, 1),
(((@CGUID+0)*10)+0, 6, 3847.3176, 667.232, 58.584705, NULL, 0, 0, 1),
(((@CGUID+0)*10)+0, 7, 3847.3176, 667.232, 58.584705, 2.268928050994873046, 1, 0, 1),

-- Soldier 1 (27564)
(((@CGUID+1)*10)+0, 1, 3666.7605, 740.5676, 80.25237, NULL, 0, 0, 1),
(((@CGUID+1)*10)+0, 2, 3707.3877, 718.00696, 79.51393, NULL, 0, 0, 1),
(((@CGUID+1)*10)+0, 3, 3744.7236, 686.0452, 79.04427, NULL, 0, 0, 1),
(((@CGUID+1)*10)+0, 4, 3786.1729, 673.13367, 77.9424, NULL, 0, 0, 1),
(((@CGUID+1)*10)+0, 5, 3818.717, 666.7327, 69.003555, NULL, 0, 0, 1),
(((@CGUID+1)*10)+0, 6, 3843.8794, 671.9085, 57.93257, NULL, 0, 0, 1),
(((@CGUID+1)*10)+0, 7, 3843.8794, 671.9085, 57.93257, 2.268928050994873046, 1, 0, 1),

-- Soldier 2 (27564)
(((@CGUID+2)*10)+0, 1, 3662.632, 742.999, 81.04816, NULL, 0, 0, 1),
(((@CGUID+2)*10)+0, 2, 3702.1367, 717.5947, 78.80129, NULL, 0, 0, 1),
(((@CGUID+2)*10)+0, 3, 3738.763, 686.8559, 78.93905, NULL, 0, 0, 1),
(((@CGUID+2)*10)+0, 4, 3783.2605, 667.0815, 77.26925, NULL, 0, 0, 1),
(((@CGUID+2)*10)+0, 5, 3813.4158, 657.46277, 71.3102, NULL, 0, 0, 1),
(((@CGUID+2)*10)+0, 6, 3846.6116, 678.9256, 58.37106, NULL, 0, 0, 1),
(((@CGUID+2)*10)+0, 7, 3846.6116, 678.9256, 58.37106, 2.268928050994873046, 1, 0, 1),

-- Soldier 3 (27564)
(((@CGUID+3)*10)+0, 1, 3663.0212, 743.1042, 80.938324, NULL, 0, 0, 1),
(((@CGUID+3)*10)+0, 2, 3705.7952, 716.0234, 79.14264, NULL, 0, 0, 1),
(((@CGUID+3)*10)+0, 3, 3744.9504, 685.0866, 78.99437, NULL, 0, 0, 1),
(((@CGUID+3)*10)+0, 4, 3784.126, 665.10406, 77.109184, NULL, 0, 0, 1),
(((@CGUID+3)*10)+0, 5, 3820.5674, 654.2676, 69.83214, NULL, 0, 0, 1),
(((@CGUID+3)*10)+0, 6, 3849.226, 674.7712, 58.362663, NULL, 0, 0, 1),
(((@CGUID+3)*10)+0, 7, 3849.226, 674.7712, 58.362663, 2.268928050994873046, 1, 0, 1),

-- Soldier 4 (27564)
(((@CGUID+4)*10)+0, 1, 3666.803, 744.38995, 80.46497, NULL, 0, 0, 1),
(((@CGUID+4)*10)+0, 2, 3706.174, 721.2485, 79.4731, NULL, 0, 0, 1),
(((@CGUID+4)*10)+0, 3, 3743.8816, 690.307, 79.454865, NULL, 0, 0, 1),
(((@CGUID+4)*10)+0, 4, 3786.942, 665.35474, 76.68507, NULL, 0, 0, 1),
(((@CGUID+4)*10)+0, 5, 3816.256, 667.1102, 70.86244, NULL, 0, 0, 1),
(((@CGUID+4)*10)+0, 6, 3853.7644, 676.84454, 58.918266, NULL, 0, 0, 1),
(((@CGUID+4)*10)+0, 7, 3853.7644, 676.84454, 58.918266, 2.268928050994873046, 1, 0, 1),

-- Soldier 5 (27564)
(((@CGUID+5)*10)+0, 1, 3666.8438, 739.67267, 80.22879, NULL, 0, 0, 1),
(((@CGUID+5)*10)+0, 2, 3706.6262, 716.10596, 79.27633, NULL, 0, 0, 1),
(((@CGUID+5)*10)+0, 3, 3743.904, 685.53754, 78.94694, NULL, 0, 0, 1),
(((@CGUID+5)*10)+0, 4, 3786.385, 665.5101, 76.79468, NULL, 0, 0, 1),
(((@CGUID+5)*10)+0, 5, 3820.683, 653.74786, 69.57719, NULL, 0, 0, 1),
(((@CGUID+5)*10)+0, 6, 3835.019, 665.9576, 58.229523, NULL, 0, 0, 1),
(((@CGUID+5)*10)+0, 7, 3835.019, 665.9576, 58.229523, 2.234021425247192382, 1, 0, 1),

-- Soldier 6 (27564)
(((@CGUID+6)*10)+0, 1, 3664.3762, 743.2789, 80.58217, NULL, 0, 0, 1),
(((@CGUID+6)*10)+0, 2, 3705.336, 717.8929, 79.20341, NULL, 0, 0, 1),
(((@CGUID+6)*10)+0, 3, 3741.7886, 686.91003, 78.99371, NULL, 0, 0, 1),
(((@CGUID+6)*10)+0, 4, 3786.3838, 666.79504, 76.8407, NULL, 0, 0, 1),
(((@CGUID+6)*10)+0, 5, 3818.1707, 657.25616, 70.622955, NULL, 0, 0, 1),
(((@CGUID+6)*10)+0, 6, 3836.0032, 674.0662, 57.494442, NULL, 0, 0, 1),
(((@CGUID+6)*10)+0, 7, 3836.0032, 674.0662, 57.494442, 2.268928050994873046, 1, 0, 1),

-- Soldier 7 (27564)
(((@CGUID+7)*10)+0, 1, 3664.5217, 745.05756, 80.66233, NULL, 0, 0, 1),
(((@CGUID+7)*10)+0, 2, 3705.226, 720.6887, 79.33128, NULL, 0, 0, 1),
(((@CGUID+7)*10)+0, 3, 3741.0535, 691.65955, 79.404396, NULL, 0, 0, 1),
(((@CGUID+7)*10)+0, 4, 3783.681, 670.13293, 77.57828, NULL, 0, 0, 1),
(((@CGUID+7)*10)+0, 5, 3811.697, 664.96857, 72.12637, NULL, 0, 0, 1),
(((@CGUID+7)*10)+0, 6, 3840.457, 676.5332, 57.830986, NULL, 0, 0, 1),
(((@CGUID+7)*10)+0, 7, 3840.457, 676.5332, 57.830986, 2.268928050994873046, 1, 0, 1),

-- Soldier 8 (27564)
(((@CGUID+8)*10)+0, 1, 3661.264, 744.9439, 81.08813, NULL, 0, 0, 1),
(((@CGUID+8)*10)+0, 2, 3701.3586, 719.5161, 78.84008, NULL, 0, 0, 1),
(((@CGUID+8)*10)+0, 3, 3740.6836, 689.13336, 79.111336, NULL, 0, 0, 1),
(((@CGUID+8)*10)+0, 4, 3782.0364, 667.8672, 77.37559, NULL, 0, 0, 1),
(((@CGUID+8)*10)+0, 5, 3813.5518, 658.8467, 71.36516, NULL, 0, 0, 1),
(((@CGUID+8)*10)+0, 6, 3839.341, 669.1519, 57.985825, NULL, 0, 0, 1),
(((@CGUID+8)*10)+0, 7, 3839.341, 669.1519, 57.985825, 2.251474618911743164, 1, 0, 1),

-- ==========================================================================
-- PATH 2  --  EAST PASS -> SOUTH PASS
-- trigger: "They're backing off here... get to the south pass! Quickly!" / "To the south! Move!"
-- ==========================================================================

-- Captain Iskandar (27567)
(((@CGUID+0)*10)+1, 1, 3768.8252, 678.3697, 78.06411, NULL, 0, 0, 1),
(((@CGUID+0)*10)+1, 2, 3726.1663, 704.9991, 80.14896, NULL, 0, 0, 1),
(((@CGUID+0)*10)+1, 3, 3685.6584, 731.27606, 78.24634, NULL, 0, 0, 1),
(((@CGUID+0)*10)+1, 4, 3648.1199, 756.0481, 82.18794, NULL, 0, 0, 1),
(((@CGUID+0)*10)+1, 5, 3613.8035, 769.6447, 71.40946, NULL, 0, 0, 1),
(((@CGUID+0)*10)+1, 6, 3613.8035, 769.6447, 71.40946, 1.099557399749755859, 1, 0, 1),

-- Soldier 1 (27564)
(((@CGUID+1)*10)+1, 1, 3766.4626, 676.31964, 78.25649, NULL, 0, 0, 1),
(((@CGUID+1)*10)+1, 2, 3725.1204, 702.493, 79.861984, NULL, 0, 0, 1),
(((@CGUID+1)*10)+1, 3, 3684.443, 729.3193, 78.32527, NULL, 0, 0, 1),
(((@CGUID+1)*10)+1, 4, 3647.6191, 753.4248, 82.67778, NULL, 0, 0, 1),
(((@CGUID+1)*10)+1, 5, 3614.318, 772.31415, 71.023026, NULL, 0, 0, 1),
(((@CGUID+1)*10)+1, 6, 3614.318, 772.31415, 71.023026, 1.099557399749755859, 1, 0, 1),

-- Soldier 2 (27564)
(((@CGUID+2)*10)+1, 1, 3766.2317, 676.41016, 78.284676, NULL, 0, 0, 1),
(((@CGUID+2)*10)+1, 2, 3725.0183, 703.82446, 79.96684, NULL, 0, 0, 1),
(((@CGUID+2)*10)+1, 3, 3683.2053, 728.40985, 78.66363, NULL, 0, 0, 1),
(((@CGUID+2)*10)+1, 4, 3645.3572, 754.9374, 81.95001, NULL, 0, 0, 1),
(((@CGUID+2)*10)+1, 5, 3618.5894, 773.3537, 70.67668, NULL, 0, 0, 1),
(((@CGUID+2)*10)+1, 6, 3618.5894, 773.3537, 70.67668, 1.099557399749755859, 1, 0, 1),

-- Soldier 3 (27564)
(((@CGUID+3)*10)+1, 1, 3767.095, 685.4401, 78.747375, NULL, 0, 0, 1),
(((@CGUID+3)*10)+1, 2, 3728.3013, 706.2984, 80.44603, NULL, 0, 0, 1),
(((@CGUID+3)*10)+1, 3, 3688.0051, 733.4498, 78.15838, NULL, 0, 0, 1),
(((@CGUID+3)*10)+1, 4, 3653.3564, 753.41113, 82.56124, NULL, 0, 0, 1),
(((@CGUID+3)*10)+1, 5, 3617.2458, 770.70123, 71.12394, NULL, 0, 0, 1),
(((@CGUID+3)*10)+1, 6, 3617.2458, 770.70123, 71.12394, 1.099557399749755859, 1, 0, 1),

-- Soldier 4 (27564)
(((@CGUID+4)*10)+1, 1, 3769.217, 680.07587, 78.069916, NULL, 0, 0, 1),
(((@CGUID+4)*10)+1, 2, 3727.02, 706.22894, 80.31082, NULL, 0, 0, 1),
(((@CGUID+4)*10)+1, 3, 3686.3938, 733.1165, 78.15929, NULL, 0, 0, 1),
(((@CGUID+4)*10)+1, 4, 3649.8186, 757.3432, 82.56831, NULL, 0, 0, 1),
(((@CGUID+4)*10)+1, 5, 3619.6326, 769.14233, 71.30871, NULL, 0, 0, 1),
(((@CGUID+4)*10)+1, 6, 3619.6326, 769.14233, 71.30871, 1.099557399749755859, 1, 0, 1),

-- Soldier 5 (27564)
(((@CGUID+5)*10)+1, 1, 3769.869, 675.0831, 78.00389, NULL, 0, 0, 1),
(((@CGUID+5)*10)+1, 2, 3726.3782, 699.79034, 79.71018, NULL, 0, 0, 1),
(((@CGUID+5)*10)+1, 3, 3686.1584, 727.3931, 78.23495, NULL, 0, 0, 1),
(((@CGUID+5)*10)+1, 4, 3649.4211, 750.8833, 82.896484, NULL, 0, 0, 1),
(((@CGUID+5)*10)+1, 5, 3608.8962, 774.6639, 71.21135, NULL, 0, 0, 1),
(((@CGUID+5)*10)+1, 6, 3608.8962, 774.6639, 71.21135, 1.099557399749755859, 1, 0, 1),

-- Soldier 6 (27564)
(((@CGUID+6)*10)+1, 1, 3768.8994, 678.05457, 78.04416, NULL, 0, 0, 1),
(((@CGUID+6)*10)+1, 2, 3728.7188, 706.09, 80.466354, NULL, 0, 0, 1),
(((@CGUID+6)*10)+1, 3, 3689.9966, 728.2758, 78.37219, NULL, 0, 0, 1),
(((@CGUID+6)*10)+1, 4, 3652.6562, 751.56445, 82.36038, NULL, 0, 0, 1),
(((@CGUID+6)*10)+1, 5, 3612.8298, 776.55817, 70.557816, NULL, 0, 0, 1),
(((@CGUID+6)*10)+1, 6, 3612.8298, 776.55817, 70.557816, 1.099557399749755859, 1, 0, 1),

-- Soldier 7 (27564)
(((@CGUID+7)*10)+1, 1, 3767.7493, 681.76434, 78.21749, NULL, 0, 0, 1),
(((@CGUID+7)*10)+1, 2, 3725.9995, 705.8206, 80.1919, NULL, 0, 0, 1),
(((@CGUID+7)*10)+1, 3, 3686.6306, 732.04425, 78.21279, NULL, 0, 0, 1),
(((@CGUID+7)*10)+1, 4, 3648.5955, 757.7414, 82.09204, NULL, 0, 0, 1),
(((@CGUID+7)*10)+1, 5, 3615.5586, 775.24554, 70.54306, NULL, 0, 0, 1),
(((@CGUID+7)*10)+1, 6, 3615.5586, 775.24554, 70.54306, 1.099557399749755859, 1, 0, 1),

-- Soldier 8 (27564)
(((@CGUID+8)*10)+1, 1, 3765.7678, 680.35223, 78.372955, NULL, 0, 0, 1),
(((@CGUID+8)*10)+1, 2, 3722.7988, 705.9375, 79.89299, NULL, 0, 0, 1),
(((@CGUID+8)*10)+1, 3, 3684.2183, 731.5422, 78.22879, NULL, 0, 0, 1),
(((@CGUID+8)*10)+1, 4, 3644.2935, 759.77716, 78.97675, NULL, 0, 0, 1),
(((@CGUID+8)*10)+1, 5, 3611.761, 773.5433, 71.0446, NULL, 0, 0, 1),
(((@CGUID+8)*10)+1, 6, 3611.761, 773.5433, 71.0446, 1.099557399749755859, 1, 0, 1),

-- ==========================================================================
-- PATH 3  --  SOUTH PASS -> SHRINE
-- trigger: "Push them back to the shrine!" / "Push them back and crush them!"
-- ==========================================================================

-- Captain Iskandar (27567)
(((@CGUID+0)*10)+2, 1, 3636.2717, 831.94476, 62.09581, NULL, 0, 0, 1),
(((@CGUID+0)*10)+2, 2, 3670.6267, 862.5305, 56.525215, NULL, 0, 0, 1),
(((@CGUID+0)*10)+2, 3, 3670.6267, 862.5305, 56.525215, 0.72877204418182373, 1, 0, 1),

-- Soldier 1 (27564)
(((@CGUID+1)*10)+2, 1, 3645.3616, 833.8261, 61.201496, NULL, 0, 0, 1),
(((@CGUID+1)*10)+2, 2, 3672.924, 859.67755, 57.21561, NULL, 0, 0, 1),
(((@CGUID+1)*10)+2, 3, 3672.924, 859.67755, 57.21561, 0.752923846244812011, 1, 0, 1),

-- Soldier 2 (27564)
(((@CGUID+2)*10)+2, 1, 3638.6726, 831.93646, 61.984608, NULL, 0, 0, 1),
(((@CGUID+2)*10)+2, 2, 3659.9465, 867.00323, 56.42431, NULL, 0, 0, 1),
(((@CGUID+2)*10)+2, 3, 3659.9465, 867.00323, 56.42431, 0.767944872379302978, 1, 0, 1),

-- Soldier 3 (27564)
(((@CGUID+3)*10)+2, 1, 3646.3364, 830.9135, 61.391457, NULL, 0, 0, 1),
(((@CGUID+3)*10)+2, 2, 3674.4683, 855.569, 57.858135, NULL, 0, 0, 1),
(((@CGUID+3)*10)+2, 3, 3674.4683, 855.569, 57.858135, 0.718384385108947753, 1, 0, 1),

-- Soldier 4 (27564)
(((@CGUID+4)*10)+2, 1, 3643.1914, 821.843, 62.37757, NULL, 0, 0, 1),
(((@CGUID+4)*10)+2, 2, 3674.641, 851.6335, 57.736794, NULL, 0, 0, 1),
(((@CGUID+4)*10)+2, 3, 3674.641, 851.6335, 57.736794, 0.758156239986419677, 1, 0, 1),

-- Soldier 5 (27564)
(((@CGUID+5)*10)+2, 1, 3634.9062, 834.31384, 61.950775, NULL, 0, 0, 1),
(((@CGUID+5)*10)+2, 2, 3663.5305, 866.5019, 56.303856, NULL, 0, 0, 1),
(((@CGUID+5)*10)+2, 3, 3663.5305, 866.5019, 56.303856, 0.844188630580902099, 1, 0, 1),

-- Soldier 6 (27564)
(((@CGUID+6)*10)+2, 1, 3638.9329, 835.89484, 61.394173, NULL, 0, 0, 1),
(((@CGUID+6)*10)+2, 2, 3667.1167, 861.211, 56.656033, NULL, 0, 0, 1),
(((@CGUID+6)*10)+2, 3, 3667.1167, 861.211, 56.656033, 0.732522368431091308, 1, 0, 1),

-- Soldier 7 (27564)
(((@CGUID+7)*10)+2, 1, 3644.177, 835.9828, 61.18009, NULL, 0, 0, 1),
(((@CGUID+7)*10)+2, 2, 3665.639, 854.9014, 57.103893, NULL, 0, 0, 1),
(((@CGUID+7)*10)+2, 3, 3665.639, 854.9014, 57.103893, 0.874624490737915039, 1, 0, 1),

-- Soldier 8 (27564)
(((@CGUID+8)*10)+2, 1, 3644.2617, 832.04205, 61.350395, NULL, 0, 0, 1),
(((@CGUID+8)*10)+2, 2, 3667.1372, 865.4031, 56.24513, NULL, 0, 0, 1),
(((@CGUID+8)*10)+2, 3, 3667.1372, 865.4031, 56.24513, 0.767944872379302978, 1, 0, 1),

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
(((@CGUID+0)*10)+3, 1, 3726.1663, 704.9991, 80.14896, NULL, 0, 0, 1),
(((@CGUID+0)*10)+3, 2, 3685.6584, 731.27606, 78.24634, NULL, 0, 0, 1),
(((@CGUID+0)*10)+3, 3, 3648.1199, 756.0481, 82.18794, NULL, 0, 0, 1),
(((@CGUID+0)*10)+3, 4, 3613.8035, 769.6447, 71.40946, NULL, 0, 0, 1),
(((@CGUID+0)*10)+3, 5, 3613.8035, 769.6447, 71.40946, 1.099557399749755859, 1, 0, 1),

-- Soldier 1 (27564)
(((@CGUID+1)*10)+3, 1, 3725.1204, 702.493, 79.861984, NULL, 0, 0, 1),
(((@CGUID+1)*10)+3, 2, 3684.443, 729.3193, 78.32527, NULL, 0, 0, 1),
(((@CGUID+1)*10)+3, 3, 3647.6191, 753.4248, 82.67778, NULL, 0, 0, 1),
(((@CGUID+1)*10)+3, 4, 3614.318, 772.31415, 71.023026, NULL, 0, 0, 1),
(((@CGUID+1)*10)+3, 5, 3614.318, 772.31415, 71.023026, 1.099557399749755859, 1, 0, 1),

-- Soldier 2 (27564)
(((@CGUID+2)*10)+3, 1, 3725.0183, 703.82446, 79.96684, NULL, 0, 0, 1),
(((@CGUID+2)*10)+3, 2, 3683.2053, 728.40985, 78.66363, NULL, 0, 0, 1),
(((@CGUID+2)*10)+3, 3, 3645.3572, 754.9374, 81.95001, NULL, 0, 0, 1),
(((@CGUID+2)*10)+3, 4, 3618.5894, 773.3537, 70.67668, NULL, 0, 0, 1),
(((@CGUID+2)*10)+3, 5, 3618.5894, 773.3537, 70.67668, 1.099557399749755859, 1, 0, 1),

-- Soldier 3 (27564)
(((@CGUID+3)*10)+3, 1, 3728.3013, 706.2984, 80.44603, NULL, 0, 0, 1),
(((@CGUID+3)*10)+3, 2, 3688.0051, 733.4498, 78.15838, NULL, 0, 0, 1),
(((@CGUID+3)*10)+3, 3, 3653.3564, 753.41113, 82.56124, NULL, 0, 0, 1),
(((@CGUID+3)*10)+3, 4, 3617.2458, 770.70123, 71.12394, NULL, 0, 0, 1),
(((@CGUID+3)*10)+3, 5, 3617.2458, 770.70123, 71.12394, 1.099557399749755859, 1, 0, 1),

-- Soldier 4 (27564)
(((@CGUID+4)*10)+3, 1, 3727.02, 706.22894, 80.31082, NULL, 0, 0, 1),
(((@CGUID+4)*10)+3, 2, 3686.3938, 733.1165, 78.15929, NULL, 0, 0, 1),
(((@CGUID+4)*10)+3, 3, 3649.8186, 757.3432, 82.56831, NULL, 0, 0, 1),
(((@CGUID+4)*10)+3, 4, 3619.6326, 769.14233, 71.30871, NULL, 0, 0, 1),
(((@CGUID+4)*10)+3, 5, 3619.6326, 769.14233, 71.30871, 1.099557399749755859, 1, 0, 1),

-- Soldier 5 (27564)
(((@CGUID+5)*10)+3, 1, 3726.3782, 699.79034, 79.71018, NULL, 0, 0, 1),
(((@CGUID+5)*10)+3, 2, 3686.1584, 727.3931, 78.23495, NULL, 0, 0, 1),
(((@CGUID+5)*10)+3, 3, 3649.4211, 750.8833, 82.896484, NULL, 0, 0, 1),
(((@CGUID+5)*10)+3, 4, 3608.8962, 774.6639, 71.21135, NULL, 0, 0, 1),
(((@CGUID+5)*10)+3, 5, 3608.8962, 774.6639, 71.21135, 1.099557399749755859, 1, 0, 1),

-- Soldier 6 (27564)
(((@CGUID+6)*10)+3, 1, 3728.7188, 706.09, 80.466354, NULL, 0, 0, 1),
(((@CGUID+6)*10)+3, 2, 3689.9966, 728.2758, 78.37219, NULL, 0, 0, 1),
(((@CGUID+6)*10)+3, 3, 3652.6562, 751.56445, 82.36038, NULL, 0, 0, 1),
(((@CGUID+6)*10)+3, 4, 3612.8298, 776.55817, 70.557816, NULL, 0, 0, 1),
(((@CGUID+6)*10)+3, 5, 3612.8298, 776.55817, 70.557816, 1.099557399749755859, 1, 0, 1),

-- Soldier 7 (27564)
(((@CGUID+7)*10)+3, 1, 3725.9995, 705.8206, 80.1919, NULL, 0, 0, 1),
(((@CGUID+7)*10)+3, 2, 3686.6306, 732.04425, 78.21279, NULL, 0, 0, 1),
(((@CGUID+7)*10)+3, 3, 3648.5955, 757.7414, 82.09204, NULL, 0, 0, 1),
(((@CGUID+7)*10)+3, 4, 3615.5586, 775.24554, 70.54306, NULL, 0, 0, 1),
(((@CGUID+7)*10)+3, 5, 3615.5586, 775.24554, 70.54306, 1.099557399749755859, 1, 0, 1),

-- Soldier 8 (27564)
(((@CGUID+8)*10)+3, 1, 3722.7556, 705.9954, 79.940636, NULL, 0, 0, 1),
(((@CGUID+8)*10)+3, 2, 3684.2183, 731.5422, 78.22879, NULL, 0, 0, 1),
(((@CGUID+8)*10)+3, 3, 3644.2935, 759.77716, 78.97675, NULL, 0, 0, 1),
(((@CGUID+8)*10)+3, 4, 3611.761, 773.5433, 71.0446, NULL, 0, 0, 1),
(((@CGUID+8)*10)+3, 5, 3611.761, 773.5433, 71.0446, 1.099557399749755859, 1, 0, 1);

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
(-(@CGUID+1), 0, 1000, 0, 72, 0, 100, 0, 0, 0, 0, 0, 0, 0, 232, ((@CGUID+1)*10)+0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Captain Iskandar or Alliance Conscripts - On Action 0 Done - Start Path South Pass to East Pass'),
(-(@CGUID+2), 0, 1000, 0, 72, 0, 100, 0, 0, 0, 0, 0, 0, 0, 232, ((@CGUID+2)*10)+0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Captain Iskandar or Alliance Conscripts - On Action 0 Done - Start Path South Pass to East Pass'),
(-(@CGUID+3), 0, 1000, 0, 72, 0, 100, 0, 0, 0, 0, 0, 0, 0, 232, ((@CGUID+3)*10)+0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Captain Iskandar or Alliance Conscripts - On Action 0 Done - Start Path South Pass to East Pass'),
(-(@CGUID+4), 0, 1000, 0, 72, 0, 100, 0, 0, 0, 0, 0, 0, 0, 232, ((@CGUID+4)*10)+0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Captain Iskandar or Alliance Conscripts - On Action 0 Done - Start Path South Pass to East Pass'),
(-(@CGUID+5), 0, 1000, 0, 72, 0, 100, 0, 0, 0, 0, 0, 0, 0, 232, ((@CGUID+5)*10)+0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Captain Iskandar or Alliance Conscripts - On Action 0 Done - Start Path South Pass to East Pass'),
(-(@CGUID+6), 0, 1000, 0, 72, 0, 100, 0, 0, 0, 0, 0, 0, 0, 232, ((@CGUID+6)*10)+0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Captain Iskandar or Alliance Conscripts - On Action 0 Done - Start Path South Pass to East Pass'),
(-(@CGUID+7), 0, 1000, 0, 72, 0, 100, 0, 0, 0, 0, 0, 0, 0, 232, ((@CGUID+7)*10)+0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Captain Iskandar or Alliance Conscripts - On Action 0 Done - Start Path South Pass to East Pass'),
(-(@CGUID+8), 0, 1000, 0, 72, 0, 100, 0, 0, 0, 0, 0, 0, 0, 232, ((@CGUID+8)*10)+0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Captain Iskandar or Alliance Conscripts - On Action 0 Done - Start Path South Pass to East Pass'),

(-(@CGUID+1), 0, 1001, 0, 72, 0, 100, 0, 1, 0, 0, 0, 0, 0, 232, ((@CGUID+1)*10)+1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Captain Iskandar or Alliance Conscripts - On Action 1 Done - Start Path East Pass to South Pass'),
(-(@CGUID+2), 0, 1001, 0, 72, 0, 100, 0, 1, 0, 0, 0, 0, 0, 232, ((@CGUID+2)*10)+1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Captain Iskandar or Alliance Conscripts - On Action 1 Done - Start Path East Pass to South Pass'),
(-(@CGUID+3), 0, 1001, 0, 72, 0, 100, 0, 1, 0, 0, 0, 0, 0, 232, ((@CGUID+3)*10)+1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Captain Iskandar or Alliance Conscripts - On Action 1 Done - Start Path East Pass to South Pass'),
(-(@CGUID+4), 0, 1001, 0, 72, 0, 100, 0, 1, 0, 0, 0, 0, 0, 232, ((@CGUID+4)*10)+1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Captain Iskandar or Alliance Conscripts - On Action 1 Done - Start Path East Pass to South Pass'),
(-(@CGUID+5), 0, 1001, 0, 72, 0, 100, 0, 1, 0, 0, 0, 0, 0, 232, ((@CGUID+5)*10)+1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Captain Iskandar or Alliance Conscripts - On Action 1 Done - Start Path East Pass to South Pass'),
(-(@CGUID+6), 0, 1001, 0, 72, 0, 100, 0, 1, 0, 0, 0, 0, 0, 232, ((@CGUID+6)*10)+1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Captain Iskandar or Alliance Conscripts - On Action 1 Done - Start Path East Pass to South Pass'),
(-(@CGUID+7), 0, 1001, 0, 72, 0, 100, 0, 1, 0, 0, 0, 0, 0, 232, ((@CGUID+7)*10)+1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Captain Iskandar or Alliance Conscripts - On Action 1 Done - Start Path East Pass to South Pass'),
(-(@CGUID+8), 0, 1001, 0, 72, 0, 100, 0, 1, 0, 0, 0, 0, 0, 232, ((@CGUID+8)*10)+1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Captain Iskandar or Alliance Conscripts - On Action 1 Done - Start Path East Pass to South Pass'),

(-(@CGUID+1), 0, 1002, 0, 72, 0, 100, 0, 2, 0, 0, 0, 0, 0, 232, ((@CGUID+1)*10)+2, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Captain Iskandar or Alliance Conscripts - On Action 2 Done - Start Path South Pass to Shrine'),
(-(@CGUID+2), 0, 1002, 0, 72, 0, 100, 0, 2, 0, 0, 0, 0, 0, 232, ((@CGUID+2)*10)+2, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Captain Iskandar or Alliance Conscripts - On Action 2 Done - Start Path South Pass to Shrine'),
(-(@CGUID+3), 0, 1002, 0, 72, 0, 100, 0, 2, 0, 0, 0, 0, 0, 232, ((@CGUID+3)*10)+2, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Captain Iskandar or Alliance Conscripts - On Action 2 Done - Start Path South Pass to Shrine'),
(-(@CGUID+4), 0, 1002, 0, 72, 0, 100, 0, 2, 0, 0, 0, 0, 0, 232, ((@CGUID+4)*10)+2, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Captain Iskandar or Alliance Conscripts - On Action 2 Done - Start Path South Pass to Shrine'),
(-(@CGUID+5), 0, 1002, 0, 72, 0, 100, 0, 2, 0, 0, 0, 0, 0, 232, ((@CGUID+5)*10)+2, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Captain Iskandar or Alliance Conscripts - On Action 2 Done - Start Path South Pass to Shrine'),
(-(@CGUID+6), 0, 1002, 0, 72, 0, 100, 0, 2, 0, 0, 0, 0, 0, 232, ((@CGUID+6)*10)+2, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Captain Iskandar or Alliance Conscripts - On Action 2 Done - Start Path South Pass to Shrine'),
(-(@CGUID+7), 0, 1002, 0, 72, 0, 100, 0, 2, 0, 0, 0, 0, 0, 232, ((@CGUID+7)*10)+2, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Captain Iskandar or Alliance Conscripts - On Action 2 Done - Start Path South Pass to Shrine'),
(-(@CGUID+8), 0, 1002, 0, 72, 0, 100, 0, 2, 0, 0, 0, 0, 0, 232, ((@CGUID+8)*10)+2, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Captain Iskandar or Alliance Conscripts - On Action 2 Done - Start Path South Pass to Shrine'),

(-(@CGUID+1), 0, 1003, 0, 72, 0, 100, 0, 3, 0, 0, 0, 0, 0, 232, ((@CGUID+1)*10)+3, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Captain Iskandar or Alliance Conscripts - On Action 3 Done - Start Path Spawn to South Pass'),
(-(@CGUID+2), 0, 1003, 0, 72, 0, 100, 0, 3, 0, 0, 0, 0, 0, 232, ((@CGUID+2)*10)+3, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Captain Iskandar or Alliance Conscripts - On Action 3 Done - Start Path Spawn to South Pass'),
(-(@CGUID+3), 0, 1003, 0, 72, 0, 100, 0, 3, 0, 0, 0, 0, 0, 232, ((@CGUID+3)*10)+3, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Captain Iskandar or Alliance Conscripts - On Action 3 Done - Start Path Spawn to South Pass'),
(-(@CGUID+4), 0, 1003, 0, 72, 0, 100, 0, 3, 0, 0, 0, 0, 0, 232, ((@CGUID+4)*10)+3, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Captain Iskandar or Alliance Conscripts - On Action 3 Done - Start Path Spawn to South Pass'),
(-(@CGUID+5), 0, 1003, 0, 72, 0, 100, 0, 3, 0, 0, 0, 0, 0, 232, ((@CGUID+5)*10)+3, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Captain Iskandar or Alliance Conscripts - On Action 3 Done - Start Path Spawn to South Pass'),
(-(@CGUID+6), 0, 1003, 0, 72, 0, 100, 0, 3, 0, 0, 0, 0, 0, 232, ((@CGUID+6)*10)+3, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Captain Iskandar or Alliance Conscripts - On Action 3 Done - Start Path Spawn to South Pass'),
(-(@CGUID+7), 0, 1003, 0, 72, 0, 100, 0, 3, 0, 0, 0, 0, 0, 232, ((@CGUID+7)*10)+3, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Captain Iskandar or Alliance Conscripts - On Action 3 Done - Start Path Spawn to South Pass'),
(-(@CGUID+8), 0, 1003, 0, 72, 0, 100, 0, 3, 0, 0, 0, 0, 0, 232, ((@CGUID+8)*10)+3, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Captain Iskandar or Alliance Conscripts - On Action 3 Done - Start Path Spawn to South Pass'),

(-(@CGUID+1), 0, 1004, 0, 109, 0, 100, 0, 0, 0, 0, 0, 0, 0, 17, 333, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Captain Iskandar or Alliance Conscripts - On Path Finished - Set Emote State 333'),
(-(@CGUID+2), 0, 1004, 0, 109, 0, 100, 0, 0, 0, 0, 0, 0, 0, 17, 333, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Captain Iskandar or Alliance Conscripts - On Path Finished - Set Emote State 333'),
(-(@CGUID+3), 0, 1004, 0, 109, 0, 100, 0, 0, 0, 0, 0, 0, 0, 17, 333, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Captain Iskandar or Alliance Conscripts - On Path Finished - Set Emote State 333'),
(-(@CGUID+4), 0, 1004, 0, 109, 0, 100, 0, 0, 0, 0, 0, 0, 0, 17, 333, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Captain Iskandar or Alliance Conscripts - On Path Finished - Set Emote State 333'),
(-(@CGUID+5), 0, 1004, 0, 109, 0, 100, 0, 0, 0, 0, 0, 0, 0, 17, 333, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Captain Iskandar or Alliance Conscripts - On Path Finished - Set Emote State 333'),
(-(@CGUID+6), 0, 1004, 0, 109, 0, 100, 0, 0, 0, 0, 0, 0, 0, 17, 333, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Captain Iskandar or Alliance Conscripts - On Path Finished - Set Emote State 333'),
(-(@CGUID+7), 0, 1004, 0, 109, 0, 100, 0, 0, 0, 0, 0, 0, 0, 17, 333, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Captain Iskandar or Alliance Conscripts - On Path Finished - Set Emote State 333'),
(-(@CGUID+8), 0, 1004, 0, 109, 0, 100, 0, 0, 0, 0, 0, 0, 0, 17, 333, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Captain Iskandar or Alliance Conscripts - On Path Finished - Set Emote State 333'),

(-(@CGUID+1), 0, 1005, 0, 21, 0, 100, 0, 0, 0, 0, 0, 0, 0, 17, 333, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Captain Iskandar or Alliance Conscripts - On Reached Home - Set Emote State 333'),
(-(@CGUID+2), 0, 1005, 0, 21, 0, 100, 0, 0, 0, 0, 0, 0, 0, 17, 333, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Captain Iskandar or Alliance Conscripts - On Reached Home - Set Emote State 333'),
(-(@CGUID+3), 0, 1005, 0, 21, 0, 100, 0, 0, 0, 0, 0, 0, 0, 17, 333, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Captain Iskandar or Alliance Conscripts - On Reached Home - Set Emote State 333'),
(-(@CGUID+4), 0, 1005, 0, 21, 0, 100, 0, 0, 0, 0, 0, 0, 0, 17, 333, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Captain Iskandar or Alliance Conscripts - On Reached Home - Set Emote State 333'),
(-(@CGUID+5), 0, 1005, 0, 21, 0, 100, 0, 0, 0, 0, 0, 0, 0, 17, 333, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Captain Iskandar or Alliance Conscripts - On Reached Home - Set Emote State 333'),
(-(@CGUID+6), 0, 1005, 0, 21, 0, 100, 0, 0, 0, 0, 0, 0, 0, 17, 333, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Captain Iskandar or Alliance Conscripts - On Reached Home - Set Emote State 333'),
(-(@CGUID+7), 0, 1005, 0, 21, 0, 100, 0, 0, 0, 0, 0, 0, 0, 17, 333, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Captain Iskandar or Alliance Conscripts - On Reached Home - Set Emote State 333'),
(-(@CGUID+8), 0, 1005, 0, 21, 0, 100, 0, 0, 0, 0, 0, 0, 0, 17, 333, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Captain Iskandar or Alliance Conscripts - On Reached Home - Set Emote State 333');

-- Both captains are driven by npc_heated_battle_captain (C++): the attack waves, the combat
-- rotation, the out of combat ghoul summons and the formation DoAction relays all live there.
-- Iskandar additionally marches between the passes; Drayzen holds one position, so his waves
-- simply never stop.
-- FactorySelector::SelectAI checks ScriptName before AIName, so AIName is cleared as well to
-- keep it honest.
UPDATE `creature_template` SET `AIName` = '', `ScriptName` = 'npc_heated_battle_captain' WHERE (`entry` IN (27567, 27751));
DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` IN (27567, 27751));

-- The wave attackers only ever needed npc_heated_battle to waive the player damage
-- requirement, which CREATURE_FLAG_EXTRA_NO_PLAYER_DAMAGE_REQ does on its own - the conscripts
-- do most of the killing, and quest credit has to land anyway. The corpse timer the script also
-- set is now the summonTime below. 27685 is not in a summon group - it is the ghoul the
-- conscripts and the captains summon themselves with 49329.
UPDATE `creature_template` SET `ScriptName` = '', `flags_extra` = `flags_extra`|2097152 WHERE (`entry` IN (27531, 27685));
UPDATE `creature_template` SET `flags_extra` = `flags_extra`|2097152 WHERE (`entry` IN (27686, 27687));

DELETE FROM `creature_text` WHERE (`CreatureID` = 27567);
INSERT INTO `creature_text` (`CreatureID`, `GroupID`, `ID`, `Text`, `Type`, `Language`, `Probability`, `Emote`, `Duration`, `Sound`, `BroadcastTextId`, `TextRange`, `comment`) VALUES
(27567, 0, 0, 'On the move to the southern pass!', 14, 0, 100, 0, 0, 0, 27559, 0, 'Captain Iskandar - Move to South'),
(27567, 0, 1, 'They\'re backing off here... get to the south pass! Quickly!', 14, 0, 100, 0, 0, 0, 27560, 0, 'Captain Iskandar - Move to South'),
(27567, 0, 2, 'They\'re pushing in the south!', 14, 0, 100, 0, 0, 0, 27561, 0, 'Captain Iskandar - Move to South'),
(27567, 0, 3, 'To the south! Move!', 14, 0, 100, 0, 0, 0, 27562, 0, 'Captain Iskandar - Move to South'),
(27567, 0, 4, 'There are more to the south!', 14, 0, 100, 0, 0, 0, 27563, 0, 'Captain Iskandar - Move to South'),
(27567, 0, 5, 'South! Now!', 14, 0, 100, 0, 0, 0, 27564, 0, 'Captain Iskandar - Move to South'),
(27567, 1, 0, 'On the move back up to the eastern pass!', 14, 0, 100, 0, 0, 0, 27565, 0, 'Captain Iskandar - Move to East'),
(27567, 1, 1, 'They\'re backing off here... get to the east pass! Quickly!', 14, 0, 100, 0, 0, 0, 27566, 0, 'Captain Iskandar - Move to East'),
(27567, 1, 2, 'Head back up to the east pass! They\'re pushing hard!', 14, 0, 100, 0, 0, 0, 27567, 0, 'Captain Iskandar - Move to East'),
(27567, 1, 3, 'Up to the eastern pass! Move!', 14, 0, 100, 0, 0, 0, 27568, 0, 'Captain Iskandar - Move to East'),
(27567, 1, 4, 'There are more at the east pass!', 14, 0, 100, 0, 0, 0, 27569, 0, 'Captain Iskandar - Move to East'),
(27567, 1, 5, 'East Pass! Now!', 14, 0, 100, 0, 0, 0, 27570, 0, 'Captain Iskandar - Move to East'),
(27567, 2, 0, 'This is our chance boys!  Push!', 14, 0, 100, 0, 0, 0, 26898, 0, 'Captain Iskandar - Move to Shrine'),
(27567, 2, 1, 'Push them back to the shrine!', 14, 0, 100, 0, 0, 0, 26899, 0, 'Captain Iskandar - Move to Shrine'),
(27567, 2, 2, 'Push them back and crush them!', 14, 0, 100, 0, 0, 0, 26900, 0, 'Captain Iskandar - Move to Shrine'),
(27567, 2, 3, 'Push!  Make a path to the shrine!', 14, 0, 100, 0, 0, 0, 26901, 0, 'Captain Iskandar - Move to Shrine'),
(27567, 3, 0, 'Emberwyrm incoming!  Pull back!  Pull back!', 14, 0, 100, 0, 0, 0, 26902, 0, 'Captain Iskandar - Emberwyrm'),
(27567, 3, 1, 'Incoming!  Get back down the pass!', 14, 0, 100, 0, 0, 0, 26903, 0, 'Captain Iskandar - Emberwyrm'),
(27567, 3, 2, 'Fall back!  Incoming Emberwyrm!', 14, 0, 100, 0, 0, 0, 26904, 0, 'Captain Iskandar - Emberwyrm'),
(27567, 4, 0, 'We\'ll hold them here for a moment.  Get into the shrine and stop those necromancers!', 14, 0, 100, 0, 0, 0, 26905, 0, 'Captain Iskandar - Heated Battle Complete'),
(27567, 4, 1, 'We can\'t hold them for long!  Get inside disrupt their necromancers!', 14, 0, 100, 0, 0, 0, 26906, 0, 'Captain Iskandar - Heated Battle Complete'),
(27567, 4, 2, 'We\'ll hold them a few more moments!  Get into the shrine while you can!', 14, 0, 100, 0, 0, 0, 26907, 0, 'Captain Iskandar - Heated Battle Complete'),
(27567, 5, 0, 'Incoming!  Get your heads down!', 14, 0, 100, 0, 0, 0, 26859, 0, 'Captain Iskandar - Ruby Dragon Strafe'),
(27567, 5, 1, 'Heads up!  Strafe incoming!', 14, 0, 100, 0, 0, 0, 26860, 0, 'Captain Iskandar - Ruby Dragon Strafe'),
(27567, 5, 2, 'Fire on the way, clear the field!', 14, 0, 100, 0, 0, 0, 26861, 0, 'Captain Iskandar - Ruby Dragon Strafe'),
(27567, 5, 3, 'Burn, you fiends!', 14, 0, 100, 0, 0, 0, 26862, 0, 'Captain Iskandar - Ruby Dragon Strafe'),
(27567, 5, 4, 'Make way!  A wyrm is coming to our aid!', 14, 0, 100, 0, 0, 0, 26863, 0, 'Captain Iskandar - Ruby Dragon Strafe'),
(27567, 5, 5, 'Red dragon incoming!', 14, 0, 100, 0, 0, 0, 26864, 0, 'Captain Iskandar - Ruby Dragon Strafe');

-- ==========================================================================
-- SCOURGE ATTACK WAVES
-- Summoned by the captains, one creature_summon_groups group per wave.
-- Groups 0-6 belong to Captain Iskandar, 7-8 to Captain Drayzen, so a path id stays
-- unique across both sides.
--
-- Route is a property of the spawn slot: every spawn point sighted more than once ran to
-- a byte-identical destination each time (32/32 in the sniff), and only 2 of 40 routes are
-- shared between slots. Paths therefore key off the slot and are numbered
--     <entry> * 100 + <groupId> * 10 + <index of that entry within the group>
-- which npc_heated_battle_captain derives directly from the summon list. Keep each group's
-- rows contiguous and in path order: creature_summon_groups has no index, so the order rows
-- come back in is the order they were inserted.
--
-- summonType 6 (TEMPSUMMON_CORPSE_TIMED_DESPAWN) with 60s: a wave stays until it is killed,
-- then the corpse lingers a minute before it is cleaned up.
-- move_type 1: the attackers run. Groups 1 and 3 legitimately share three spawn points.
-- ==========================================================================
DELETE FROM `creature_summon_groups` WHERE (`summonerId` IN (27567, 27751)) AND (`summonerType` = 0);
INSERT INTO `creature_summon_groups` (`summonerId`, `summonerType`, `groupId`, `entry`, `position_x`, `position_y`, `position_z`, `orientation`, `summonType`, `summonTime`, `Comment`) VALUES
-- group 0: SOUTH -- Necromancer + 6 Geists   (seen 7x; coordinates from 19:57:14.559 packet 67301)
(27567, 0, 0, 27686, 3626.7517, 844.8213, 60.66234, 2.792526721954345703, 6, 60000, 'SOUTH - Geist - path 2768600'),
(27567, 0, 0, 27686, 3630.2288, 848.45966, 60.46936, 5.235987663269042968, 6, 60000, 'SOUTH - Geist - path 2768601'),
(27567, 0, 0, 27686, 3632.0217, 843.6702, 60.856743, 3.351032257080078125, 6, 60000, 'SOUTH - Geist - path 2768602'),
(27567, 0, 0, 27686, 3636.2153, 841.21124, 60.656025, 5.270894527435302734, 6, 60000, 'SOUTH - Geist - path 2768603'),
(27567, 0, 0, 27686, 3639.7668, 845.14954, 59.896584, 6.230825424194335937, 6, 60000, 'SOUTH - Geist - path 2768604'),
(27567, 0, 0, 27686, 3641.884, 841.3059, 60.24088, 5.532693862915039062, 6, 60000, 'SOUTH - Geist - path 2768605'),
(27567, 0, 0, 27687, 3635.5405, 845.56226, 60.547443, 4.642575740814208984, 6, 60000, 'SOUTH - Necro - path 2768700'),
-- group 1: SOUTH -- Abomination + 2 Geists   (seen 4x; coordinates from 19:52:59.670 packet 56130)
(27567, 0, 1, 27531, 3631.0967, 827.1009, 62.925327, 1.850049018859863281, 6, 60000, 'SOUTH - Abom - path 2753110'),
(27567, 0, 1, 27686, 3627.7554, 833.6415, 62.412754, 0.733038306236267089, 6, 60000, 'SOUTH - Geist - path 2768610'),
(27567, 0, 1, 27686, 3636.0417, 830.93506, 62.21592, 2.478367567062377929, 6, 60000, 'SOUTH - Geist - path 2768611'),
-- group 2: SOUTH -- Abomination + 4 Geists   (seen 3x; coordinates from 19:58:04.741 packet 71046)
(27567, 0, 2, 27531, 3643.375, 858.74304, 58.42003, 5.393067359924316406, 6, 60000, 'SOUTH - Abom - path 2753120'),
(27567, 0, 2, 27686, 3639.5256, 862.6922, 57.844265, 6.0737457275390625, 6, 60000, 'SOUTH - Geist - path 2768620'),
(27567, 0, 2, 27686, 3643.201, 865.0904, 57.08768, 6.0737457275390625, 6, 60000, 'SOUTH - Geist - path 2768621'),
(27567, 0, 2, 27686, 3649.2886, 860.8603, 57.310757, 4.415682792663574218, 6, 60000, 'SOUTH - Geist - path 2768622'),
(27567, 0, 2, 27686, 3652.5833, 863.44226, 56.890697, 1.239183783531188964, 6, 60000, 'SOUTH - Geist - path 2768623'),
-- group 3: SOUTH -- Abomination + 6 Geists   (seen 4x; coordinates from 19:58:56.125 packet 74564)
(27567, 0, 3, 27531, 3631.0967, 827.1009, 62.925327, 1.850049018859863281, 6, 60000, 'SOUTH - Abom - path 2753130'),
(27567, 0, 3, 27686, 3627.7554, 833.6415, 62.412754, 0.733038306236267089, 6, 60000, 'SOUTH - Geist - path 2768630'),
(27567, 0, 3, 27686, 3630.396, 853.54175, 59.336708, 3.752457857131958007, 6, 60000, 'SOUTH - Geist - path 2768631'),
(27567, 0, 3, 27686, 3636.0417, 830.93506, 62.21592, 2.478367567062377929, 6, 60000, 'SOUTH - Geist - path 2768632'),
(27567, 0, 3, 27686, 3636.1807, 854.2664, 59.609524, 1.396263360977172851, 6, 60000, 'SOUTH - Geist - path 2768633'),
(27567, 0, 3, 27686, 3639.2942, 850.2552, 59.38392, 4.520402908325195312, 6, 60000, 'SOUTH - Geist - path 2768634'),
(27567, 0, 3, 27686, 3644.5542, 850.5862, 58.54313, 1.867502331733703613, 6, 60000, 'SOUTH - Geist - path 2768635'),
-- group 4: EAST -- 6 Geists   (seen 2x; coordinates from 20:12:40.733 packet 116929)
(27567, 0, 4, 27686, 3757.7104, 766.1674, 62.890156, 1.884955525398254394, 6, 60000, 'EAST - Geist - path 2768640'),
(27567, 0, 4, 27686, 3759.6614, 764.02844, 62.288853, 3.665191411972045898, 6, 60000, 'EAST - Geist - path 2768641'),
(27567, 0, 4, 27686, 3760.1384, 766.6206, 62.589363, 0.069813169538974761, 6, 60000, 'EAST - Geist - path 2768642'),
(27567, 0, 4, 27686, 3760.7493, 769.15607, 62.795174, 6.195918560028076171, 6, 60000, 'EAST - Geist - path 2768643'),
(27567, 0, 4, 27686, 3762.303, 764.4466, 61.909737, 2.007128715515136718, 6, 60000, 'EAST - Geist - path 2768644'),
(27567, 0, 4, 27686, 3762.8386, 766.9697, 62.177036, 4.590215682983398437, 6, 60000, 'EAST - Geist - path 2768645'),
-- group 5: EAST -- Abomination + 7 Geists   (seen 5x; coordinates from 20:37:41.089 packet 172873)
(27567, 0, 5, 27531, 3767.9536, 759.10095, 59.854744, 1.745329260826110839, 6, 60000, 'EAST - Abom - path 2753150'),   -- POSITION APPROXIMATE (caught mid-move)
(27567, 0, 5, 27686, 3755.6506, 768.1376, 63.41838, 0.628318548202514648, 6, 60000, 'EAST - Geist - path 2768650'),
(27567, 0, 5, 27686, 3758.6506, 768.2493, 63.0299, 2.426007747650146484, 6, 60000, 'EAST - Geist - path 2768651'),
(27567, 0, 5, 27686, 3759.448, 770.4917, 63.152355, 4.310963153839111328, 6, 60000, 'EAST - Geist - path 2768652'),
(27567, 0, 5, 27686, 3763.317, 761.05493, 61.153877, 5.759586334228515625, 6, 60000, 'EAST - Geist - path 2768653'),
(27567, 0, 5, 27686, 3766.462, 763.33606, 60.895473, 3.822271108627319335, 6, 60000, 'EAST - Geist - path 2768654'),
(27567, 0, 5, 27686, 3768.9658, 753.6746, 58.78656, 6.021385669708251953, 6, 60000, 'EAST - Geist - path 2768655'),
(27567, 0, 5, 27686, 3772.746, 756.7438, 58.82063, 2.809980154037475585, 6, 60000, 'EAST - Geist - path 2768656'),
-- group 6: SHRINE -- Abomination + 6 Geists + 2 Necromancers   (seen 3x; coordinates from 19:51:05.404 packet 52279)
(27567, 0, 6, 27531, 3675.567, 866.78033, 56.26623, 3.857177734375, 6, 60000, 'SHRINE - Abom - path 2753160'),
(27567, 0, 6, 27686, 3659.7483, 876.86786, 56.944252, 4.921828269958496093, 6, 60000, 'SHRINE - Geist - path 2768660'),
(27567, 0, 6, 27686, 3664.7622, 876.08655, 56.73396, 4.677482128143310546, 6, 60000, 'SHRINE - Geist - path 2768661'),
(27567, 0, 6, 27686, 3668.9622, 872.8576, 56.08941, 4.345870018005371093, 6, 60000, 'SHRINE - Geist - path 2768662'),
(27567, 0, 6, 27686, 3681.2483, 859.9791, 58.60043, 3.525565147399902343, 6, 60000, 'SHRINE - Geist - path 2768663'),
(27567, 0, 6, 27686, 3684.188, 855.4685, 59.003628, 3.193952560424804687, 6, 60000, 'SHRINE - Geist - path 2768664'),
(27567, 0, 6, 27686, 3686.5127, 848.71344, 57.36397, 2.792526721954345703, 6, 60000, 'SHRINE - Geist - path 2768665'),
(27567, 0, 6, 27687, 3666.8298, 880.2456, 57.150173, 4.625122547149658203, 6, 60000, 'SHRINE - Necro - path 2768760'),
(27567, 0, 6, 27687, 3688.361, 857.3421, 58.671318, 3.246312379837036132, 6, 60000, 'SHRINE - Necro - path 2768761'),
-- group 7: HORDE -- 4 Geists   (seen 3x; coordinates from 19:53:47.155 packet 57651)
(27751, 0, 7, 27686, 3637.799, 1113.7489, 80.1781, 2.059488534927368164, 6, 60000, 'HORDE - Geist - path 2768670'),
(27751, 0, 7, 27686, 3640.551, 1111.3931, 77.90086, 2.600540637969970703, 6, 60000, 'HORDE - Geist - path 2768671'),
(27751, 0, 7, 27686, 3643.1653, 1117.6732, 81.38985, 2.321287870407104492, 6, 60000, 'HORDE - Geist - path 2768672'),
(27751, 0, 7, 27686, 3645.316, 1113.3911, 78.04383, 5.462880611419677734, 6, 60000, 'HORDE - Geist - path 2768673'),
-- group 8: HORDE -- Abomination + 6 Geists   (seen 3x; coordinates from 20:23:08.112 packet 142415)
(27751, 0, 8, 27531, 3642.0183, 1108.3624, 76.29655, 0.575958669185638427, 6, 60000, 'HORDE - Abom - path 2753180'),
(27751, 0, 8, 27686, 3634.7134, 1110.0045, 79.1014, 3.455751895904541015, 6, 60000, 'HORDE - Geist - path 2768680'),
(27751, 0, 8, 27686, 3637.799, 1113.7489, 80.1781, 1.715128064155578613, 6, 60000, 'HORDE - Geist - path 2768681'),   -- POSITION APPROXIMATE (caught mid-move)
(27751, 0, 8, 27686, 3640.551, 1111.3931, 77.90086, 2.600540637969970703, 6, 60000, 'HORDE - Geist - path 2768682'),
(27751, 0, 8, 27686, 3643.1653, 1117.6732, 81.38985, 2.321287870407104492, 6, 60000, 'HORDE - Geist - path 2768683'),   -- POSITION APPROXIMATE (caught mid-move)
(27751, 0, 8, 27686, 3645.316, 1113.3911, 78.04383, 5.462880611419677734, 6, 60000, 'HORDE - Geist - path 2768684'),
(27751, 0, 8, 27686, 3649.7527, 1117.7316, 80.87788, 2.268928050994873046, 6, 60000, 'HORDE - Geist - path 2768685'),   -- POSITION APPROXIMATE (caught mid-move)

-- group 9: HORDE -- Necromancer + 7 Geists   (seen 4x; coordinates from 20:17:55.950 packet 127399)
-- This wave alternates with group 8 on a ~3m20s cycle (B,A,B,A,B,A,B at 1m52s / 1m27s), from a
-- spawn point ~15 yd uphill of group 8's. It was never caught at rest, so every position below
-- is the least advanced sighting of that slot; the four sightings agree to within 3 yd.
(27751, 0, 9, 27686, 3580.3958, 1093.16, 151.50317, 1.037295341491699218, 6, 60000, 'HORDE - Geist - path 2768690'),   -- APPROXIMATE: seen 3x, all moving, positions agree to 0.0 yd
(27751, 0, 9, 27686, 3635.384, 1123.8596, 87.98483, 3.228859186172485351, 6, 60000, 'HORDE - Geist - path 2768691'),   -- APPROXIMATE: seen 4x, all moving, positions agree to 2.6 yd
(27751, 0, 9, 27686, 3637.5662, 1128.3689, 90.990685, 1.915084242820739746, 6, 60000, 'HORDE - Geist - path 2768692'),   -- APPROXIMATE: seen 4x, all moving, positions agree to 3.0 yd
(27751, 0, 9, 27686, 3640.5002, 1130.9894, 93.34786, 1.972222089767456054, 6, 60000, 'HORDE - Geist - path 2768693'),   -- APPROXIMATE: seen 4x, all moving, positions agree to 2.4 yd
(27751, 0, 9, 27686, 3641.3264, 1125.1437, 88.22113, 3.298672199249267578, 6, 60000, 'HORDE - Geist - path 2768694'),   -- APPROXIMATE: seen 4x, all moving, positions agree to 2.9 yd
(27751, 0, 9, 27686, 3643.1401, 1127.9269, 90.793076, 6.056292533874511718, 6, 60000, 'HORDE - Geist - path 2768695'),   -- APPROXIMATE: seen 4x, all moving, positions agree to 2.4 yd
(27751, 0, 9, 27686, 3646.8403, 1125.3961, 89.62334, 2.617993831634521484, 6, 60000, 'HORDE - Geist - path 2768696'),   -- APPROXIMATE: seen 4x, all moving, positions agree to 2.2 yd
(27751, 0, 9, 27687, 3638.3464, 1119.1643, 84.02678, 1.917418122291564941, 6, 60000, 'HORDE - Necro - path 2768790');   -- APPROXIMATE: seen 1x, all moving, positions agree to 0.0 yd

DELETE FROM `waypoint_data` WHERE `id` BETWEEN 2753100 AND 2753199;
DELETE FROM `waypoint_data` WHERE `id` BETWEEN 2768600 AND 2768699;
DELETE FROM `waypoint_data` WHERE `id` BETWEEN 2768700 AND 2768799;
-- The shrine garrison never leaves its spawn, so these slots get no path:
-- path 2753160 (SHRINE Abom) - no approach spline sighted, creature holds at its spawn
-- path 2768660 (SHRINE Geist) - no approach spline sighted, creature holds at its spawn
-- path 2768661 (SHRINE Geist) - no approach spline sighted, creature holds at its spawn
-- path 2768662 (SHRINE Geist) - no approach spline sighted, creature holds at its spawn
-- path 2768663 (SHRINE Geist) - no approach spline sighted, creature holds at its spawn
-- path 2768664 (SHRINE Geist) - no approach spline sighted, creature holds at its spawn
-- path 2768665 (SHRINE Geist) - no approach spline sighted, creature holds at its spawn
-- path 2768760 (SHRINE Necro) - no approach spline sighted, creature holds at its spawn
-- path 2768761 (SHRINE Necro) - no approach spline sighted, creature holds at its spawn

INSERT INTO `waypoint_data` (`id`, `point`, `position_x`, `position_y`, `position_z`, `orientation`, `smoothTransition`, `move_type`) VALUES
-- path 2768600 -- SOUTH Geist from 3626.7517 844.8213
(2768600, 1, 3604.7288, 784.8661, 71.00964, NULL, 0, 1),
-- path 2768601 -- SOUTH Geist from 3630.2288 848.4597
(2768601, 1, 3612.8433, 778.84894, 70.24953, NULL, 0, 1),
-- path 2768602 -- SOUTH Geist from 3632.0217 843.6702
(2768602, 1, 3619.9165, 775.50354, 70.3247, NULL, 0, 1),
-- path 2768603 -- SOUTH Geist from 3636.2153 841.2112
(2768603, 1, 3616.293, 784.6094, 68.95116, NULL, 0, 1),
-- path 2768604 -- SOUTH Geist from 3639.7668 845.1495
(2768604, 1, 3624.9426, 776.4518, 70.06914, NULL, 0, 1),
-- path 2768605 -- SOUTH Geist from 3641.8840 841.3059
(2768605, 1, 3630.5693, 776.441, 70.19949, NULL, 0, 1),
-- path 2768700 -- SOUTH Necro from 3635.5405 845.5623
(2768700, 1, 3625.97, 813.184, 64.27876, NULL, 0, 1),
(2768700, 2, 3612.4, 773.206, 71.03034, NULL, 0, 1),
-- path 2753110 -- SOUTH Abom from 3631.0967 827.1009
(2753110, 1, 3614.0564, 778.05914, 70.30283, NULL, 0, 1),
-- path 2768610 -- SOUTH Geist from 3627.7554 833.6415
(2768610, 1, 3604.3188, 782.0027, 71.27799, NULL, 0, 1),
-- path 2768611 -- SOUTH Geist from 3636.0417 830.9351
(2768611, 1, 3620.3792, 775.383, 70.29366, NULL, 0, 1),
-- path 2753120 -- SOUTH Abom from 3643.3750 858.7430
(2753120, 1, 3614.1248, 778.0329, 70.2873, NULL, 0, 1),
-- path 2768620 -- SOUTH Geist from 3639.5256 862.6922
(2768620, 1, 3604.291, 782.083, 71.22034, NULL, 0, 1),
-- path 2768621 -- SOUTH Geist from 3643.2010 865.0904
(2768621, 1, 3604.4124, 781.9591, 71.26213, NULL, 0, 1),
-- path 2768622 -- SOUTH Geist from 3649.2886 860.8603
(2768622, 1, 3620.575, 775.3345, 70.30639, NULL, 0, 1),
-- path 2768623 -- SOUTH Geist from 3652.5833 863.4423
(2768623, 1, 3620.725, 775.28394, 70.31409, NULL, 0, 1),
-- path 2753130 -- SOUTH Abom from 3631.0967 827.1009
(2753130, 1, 3614.0564, 778.05914, 70.30283, NULL, 0, 1),
-- path 2768630 -- SOUTH Geist from 3627.7554 833.6415
(2768630, 1, 3604.3188, 782.0027, 71.27799, NULL, 0, 1),
-- path 2768631 -- SOUTH Geist from 3630.3960 853.5417
(2768631, 1, 3604.0488, 782.292, 71.4722, NULL, 0, 1),
-- path 2768632 -- SOUTH Geist from 3636.0417 830.9351
(2768632, 1, 3620.3792, 775.383, 70.29366, NULL, 0, 1),
-- path 2768633 -- SOUTH Geist from 3636.1807 854.2664
(2768633, 1, 3604.2644, 782.03094, 71.28683, NULL, 0, 1),
-- path 2768634 -- SOUTH Geist from 3639.2942 850.2552
(2768634, 1, 3620.2837, 775.4213, 70.31531, NULL, 0, 1),
-- path 2768635 -- SOUTH Geist from 3644.5542 850.5862
(2768635, 1, 3620.574, 775.3278, 70.2943, NULL, 0, 1),
-- path 2768640 -- EAST Geist from 3757.7104 766.1674
(2768640, 1, 3841.9866, 663.70935, 59.7098, NULL, 0, 1),
-- path 2768641 -- EAST Geist from 3759.6614 764.0284
(2768641, 1, 3858.7815, 677.822, 59.89315, NULL, 0, 1),
-- path 2768642 -- EAST Geist from 3760.1384 766.6206
(2768642, 1, 3841.9866, 663.70935, 59.7098, NULL, 0, 1),
-- path 2768643 -- EAST Geist from 3760.7493 769.1561
(2768643, 1, 3858.7815, 677.822, 59.89315, NULL, 0, 1),
-- path 2768644 -- EAST Geist from 3762.3030 764.4466
(2768644, 1, 3851.576, 671.38025, 58.56033, NULL, 0, 1),
-- path 2768645 -- EAST Geist from 3762.8386 766.9697
(2768645, 1, 3851.624, 671.43243, 58.60671, NULL, 0, 1),
-- path 2753150 -- EAST Abom from 3767.9536 759.1010
(2753150, 1, 3823.4775, 694.0947, 59.41341, NULL, 0, 1),
(2753150, 2, 3839.2588, 667.22906, 58.36109, NULL, 0, 1),
-- path 2768650 -- EAST Geist from 3755.6506 768.1376
(2768650, 1, 3859.2427, 678.4638, 59.9894, NULL, 0, 1),
-- path 2768651 -- EAST Geist from 3758.6506 768.2493
(2768651, 1, 3851.5723, 671.3806, 58.58128, NULL, 0, 1),
-- path 2768652 -- EAST Geist from 3759.4480 770.4917
(2768652, 1, 3851.5625, 671.3736, 58.59481, NULL, 0, 1),
-- path 2768653 -- EAST Geist from 3763.3170 761.0549
(2768653, 1, 3841.9866, 663.70935, 59.7098, NULL, 0, 1),
-- path 2768654 -- EAST Geist from 3766.4620 763.3361
(2768654, 1, 3845.4673, 670.1445, 58.13992, NULL, 0, 1),
-- path 2768655 -- EAST Geist from 3768.9658 753.6746
(2768655, 1, 3829.3748, 688.6724, 58.76442, NULL, 0, 1),
-- path 2768656 -- EAST Geist from 3772.7460 756.7438
(2768656, 1, 3838.4294, 681.2864, 58.12796, NULL, 0, 1),
-- path 2768670 -- HORDE Geist from 3637.7990 1113.7489
(2768670, 1, 3633.7605, 1141.5234, 101.31105, NULL, 0, 1),
-- path 2768671 -- HORDE Geist from 3640.5510 1111.3931
(2768671, 1, 3634.9346, 1137.7861, 98.78249, NULL, 0, 1),
-- path 2768672 -- HORDE Geist from 3643.1653 1117.6732  (legs taken from another sighting of this spawn point)
(2768672, 1, 3631.6848, 1148.7568, 106.89459, NULL, 0, 1),
(2768672, 2, 3637.073, 1186.4427, 125.71338, NULL, 0, 1),
(2768672, 3, 3644.1736, 1219.997, 133.5263, NULL, 0, 1),
-- path 2768673 -- HORDE Geist from 3645.3160 1113.3911
(2768673, 1, 3637.5745, 1137.416, 98.38801, NULL, 0, 1),
-- path 2753180 -- HORDE Abom from 3642.0183 1108.3624
(2753180, 1, 3635.76, 1138.0193, 98.79371, NULL, 0, 1),
(2753180, 2, 3629.212, 1149.0497, 106.53441, NULL, 0, 1),
(2753180, 3, 3637.1663, 1165.982, 117.88687, NULL, 0, 1),
(2753180, 4, 3636.7764, 1184.9824, 125.26865, NULL, 0, 1),
(2753180, 5, 3645.9688, 1216.4242, 132.84203, NULL, 0, 1),
-- path 2768680 -- HORDE Geist from 3634.7134 1110.0045
(2768680, 1, 3632.48, 1137.5823, 98.65333, NULL, 0, 1),
(2768680, 2, 3626.0415, 1153.6621, 108.8643, NULL, 0, 1),
(2768680, 3, 3632.8687, 1162.8483, 115.6544, NULL, 0, 1),
(2768680, 4, 3631.8752, 1188.38, 125.47243, NULL, 0, 1),
-- path 2768681 -- HORDE Geist from 3637.7990 1113.7489
(2768681, 1, 3634.779, 1163.5603, 116.25324, NULL, 0, 1),
(2768681, 2, 3635.0266, 1185.8761, 125.15726, NULL, 0, 1),
-- path 2768682 -- HORDE Geist from 3640.5510 1111.3931
(2768682, 1, 3634.9346, 1137.7861, 98.78249, NULL, 0, 1),
(2768682, 2, 3630.6736, 1151.5024, 108.38927, NULL, 0, 1),
(2768682, 3, 3635.5955, 1166.1969, 117.96056, NULL, 0, 1),
(2768682, 4, 3635.09, 1189.981, 126.20715, NULL, 0, 1),
-- path 2768683 -- HORDE Geist from 3643.1653 1117.6732
(2768683, 1, 3631.6848, 1148.7568, 106.89459, NULL, 0, 1),
(2768683, 2, 3636.5457, 1164.672, 117.09983, NULL, 0, 1),
(2768683, 3, 3637.073, 1186.4427, 125.71338, NULL, 0, 1),
(2768683, 4, 3644.1736, 1219.997, 133.5263, NULL, 0, 1),
-- path 2768684 -- HORDE Geist from 3645.3160 1113.3911
(2768684, 1, 3637.5745, 1137.416, 98.38801, NULL, 0, 1),
(2768684, 2, 3633.48, 1150.3357, 108.38216, NULL, 0, 1),
(2768684, 3, 3638.8582, 1165.4539, 117.84776, NULL, 0, 1),
-- path 2768685 -- HORDE Geist from 3649.7527 1117.7316
(2768685, 1, 3633.8318, 1149.235, 107.83878, NULL, 0, 1),
(2768685, 2, 3641.8008, 1164.2432, 117.80559, NULL, 0, 1),
(2768685, 3, 3641.6306, 1186.2717, 127.14329, NULL, 0, 1),

-- path 2768690 -- HORDE Geist from 3580.3958 1093.1600
(2768690, 1, 3598.924, 1118.5566, 148.73746, NULL, 0, 1),
(2768690, 2, 3592.9207, 1151.7969, 144.1357, NULL, 0, 1),
-- path 2768691 -- HORDE Geist from 3635.3840 1123.8596
(2768691, 1, 3632.8687, 1162.8483, 115.6544, NULL, 0, 1),
(2768691, 2, 3631.8752, 1188.38, 125.47243, NULL, 0, 1),
-- path 2768692 -- HORDE Geist from 3637.5662 1128.3689
(2768692, 1, 3635.7112, 1164.098, 116.69835, NULL, 0, 1),
(2768692, 2, 3633.8196, 1185.0059, 124.71602, NULL, 0, 1),
(2768692, 3, 3635.3923, 1207.9268, 130.7355, NULL, 0, 1),
-- path 2768693 -- HORDE Geist from 3640.5002 1130.9894
(2768693, 1, 3638.2612, 1163.5366, 116.67506, NULL, 0, 1),
(2768693, 2, 3637.8162, 1186.8447, 126.01469, NULL, 0, 1),
(2768693, 3, 3645.3655, 1216.4551, 132.8346, NULL, 0, 1),
-- path 2768694 -- HORDE Geist from 3641.3264 1125.1437
(2768694, 1, 3636.4634, 1163.2134, 116.26178, NULL, 0, 1),
(2768694, 2, 3636.4883, 1188.4065, 126.09148, NULL, 0, 1),
-- path 2768695 -- HORDE Geist from 3643.1401 1127.9269
(2768695, 1, 3637.9875, 1164.7682, 117.31805, NULL, 0, 1),
(2768695, 2, 3638.7454, 1187.7439, 126.53552, NULL, 0, 1),
-- path 2768696 -- HORDE Geist from 3646.8403 1125.3961
(2768696, 1, 3637.312, 1159.0553, 113.98731, NULL, 0, 1),
(2768696, 2, 3640.8872, 1185.2339, 126.60243, NULL, 0, 1),
-- path 2768790 -- HORDE Necromancer from 3638.3464 1119.1643
(2768790, 1, 3634.9985, 1168.4827, 119.01706, NULL, 0, 1),
(2768790, 2, 3633.7864, 1189.277, 125.84503, NULL, 0, 1);

-- Horde Cleanup
UPDATE `creature` SET `position_x`=3648.959961, `position_y`=1215.579956, `position_z`=132.792007, `orientation`=2.731850, `wander_distance`=0.00, `MovementType`=0, `VerifiedBuild`=54261, `CreateObject`=1 WHERE `guid`=105011 AND `id`=27749;
UPDATE `creature` SET `position_x`=3651.820068, `position_y`=1213.819946, `position_z`=132.641998, `orientation`=4.188790, `wander_distance`=0.00, `MovementType`=0, `VerifiedBuild`=52237, `CreateObject`=2 WHERE `guid`=105024 AND `id`=27749;
UPDATE `creature` SET `position_x`=3631.699951, `position_y`=1221.650024, `position_z`=134.931000, `orientation`=3.877450, `wander_distance`=0.00, `MovementType`=0, `VerifiedBuild`=54261, `CreateObject`=1 WHERE `guid`=104996 AND `id`=27749;
UPDATE `creature` SET `position_x`=3634.260010, `position_y`=1221.520020, `position_z`=134.399002, `orientation`=4.817110, `wander_distance`=0.00, `MovementType`=0, `VerifiedBuild`=47720, `CreateObject`=2 WHERE `guid`=104998 AND `id`=27749;
UPDATE `creature` SET `position_x`=3637.129883, `position_y`=1221.699951, `position_z`=134.242996, `orientation`=2.826820, `wander_distance`=0.00, `MovementType`=0, `VerifiedBuild`=54261, `CreateObject`=1 WHERE `guid`=105005 AND `id`=27749;
UPDATE `creature` SET `position_x`=3619.350098, `position_y`=1198.109985, `position_z`=143.143997, `orientation`=4.922500, `wander_distance`=0.00, `MovementType`=0, `VerifiedBuild`=54261, `CreateObject`=1 WHERE `guid`=109986 AND `id`=27542;
UPDATE `creature` SET `position_x`=3660.879883, `position_y`=1198.310059, `position_z`=145.843002, `orientation`=3.061770, `wander_distance`=0.00, `MovementType`=0, `VerifiedBuild`=54261, `CreateObject`=1 WHERE `guid`=109994 AND `id`=27542;

DELETE FROM `creature` WHERE `guid` IN (99413,99414,99419,99418,99415,99417,99416) AND `id` = 27686;
UPDATE `creature_addon` SET `emote` = 376 WHERE `guid` = 104997;

-- Ruby Arrow Periodic
UPDATE `creature_addon` SET `auras` = '49199' WHERE `emote` = 376 AND `bytes2` = 2 AND `guid` IN (SELECT `guid` FROM `creature` WHERE `id` IN (27564, 27749));

DELETE FROM `conditions` WHERE (`SourceTypeOrReferenceId` = 13) AND (`SourceGroup` = 3) AND (`SourceEntry` = 49197) AND (`ConditionTypeOrReference` = 31);
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `ErrorType`, `ErrorTextId`, `ScriptName`, `Comment`) VALUES
(13, 3, 49197, 0, 0, 31, 0, 3, 27686, 0, 0, 0, 0, '', 'Ruby Arrow from Heated Battle Event in Ruby Dragonshrine only targets Frigid Attackers'),
(13, 3, 49197, 0, 1, 31, 0, 3, 27531, 0, 0, 0, 0, '', 'Ruby Arrow from Heated Battle Event in Ruby Dragonshrine only targets Frigid Attackers'),
(13, 3, 49197, 0, 2, 31, 0, 3, 27687, 0, 0, 0, 0, '', 'Ruby Arrow from Heated Battle Event in Ruby Dragonshrine only targets Frigid Attackers');

-- The conditions above decide which entries Ruby Arrow may hit, not how many of them it hits at
-- once: effect 0 is TARGET_UNIT_CONE_ENTRY, so one shot landed on every attacker standing in the
-- cone. The script trims that to the nearest one, which is also the unit effect 1 picks.
DELETE FROM `spell_script_names` WHERE (`spell_id` = 49197) AND (`ScriptName` = 'spell_ruby_arrow');
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES
(49197, 'spell_ruby_arrow');

-- Captain Drayzen formation
DELETE FROM `creature_formations` WHERE `leaderGUID` = 105167;
INSERT INTO `creature_formations` (`leaderGUID`, `memberGUID`, `groupAI`) VALUES
(105167, 104996, 3),
(105167, 104998, 3),
(105167, 105005, 3),
(105167, 105011, 3),
(105167, 105024, 3),
(105167, 105012, 3),
(105167, 105167, 3);

-- Remove flag 64 from Shoot
UPDATE `smart_scripts` SET `action_param2` = 0 WHERE `entryorguid` IN (27564, 27749) AND `source_type` = 0 AND `action_type` = 11 AND `action_param1` = 15620;

-- Also remove old stuff
UPDATE `creature_template` SET `RegenHealth` = 0, `ScriptName` = '' WHERE (`entry` IN (27686, 27687, 27531, 27685));
UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 27687;
DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = 27687);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(27687, 0, 0, 0, 60, 0, 100, 0, 3200, 10000, 3200, 10000, 0, 0, 11, 50324, 32, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Frigid Necromancer Attacker - On Update - Cast \'Bone Armor\''),
(27687, 0, 1, 2, 0, 0, 100, 0, 0, 1200, 3600, 4800, 0, 0, 11, 9613, 64, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Frigid Necromancer Attacker - In Combat - Cast \'Shadow Bolt\'');
