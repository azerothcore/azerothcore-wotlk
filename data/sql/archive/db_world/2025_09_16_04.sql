-- DB update 2025_09_16_03 -> 2025_09_16_04
--
SET @CGUID = 93770;
DELETE FROM `creature` WHERE `id1` = 26094;
DELETE FROM `creature` WHERE `guid` BETWEEN @CGUID+0 AND @CGUID+31;
INSERT INTO `creature` (`guid`, `id1`, `map`, `zoneId`, `areaId`, `spawnMask`, `phaseMask`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `wander_distance`, `currentwaypoint`, `curhealth`, `curmana`, `MovementType`, `npcflag`, `unit_flags`, `dynamicflags`, `VerifiedBuild`) VALUES
(@CGUID+0, 26094, 571, 3537, 4128, 1, 1, 0, 3719.678955078125, 3563.5400390625, 353.03515625, 0.03490658476948738, 120, 0, 0, 2095, 852, 0, 0, 0, 0, 63163), -- 26094
(@CGUID+1, 26094, 571, 3537, 4128, 1, 1, 0, 3783.53564453125, 3558.092529296875, 357.4127197265625, 2.940582275390625, 120, 0, 0, 2095, 852, 0, 0, 0, 0, 63163), -- 26094
(@CGUID+2, 26094, 571, 3537, 4128, 1, 1, 0, 3735.954833984375, 3587.1259765625, 352.95361328125, 4.834561824798583984, 120, 0, 0, 2095, 852, 0, 0, 0, 0, 63163), -- 26094
(@CGUID+3, 26094, 571, 3537, 4128, 1, 1, 0, 3730.49658203125, 3523.23291015625, 357.273834228515625, 1.370625138282775878, 120, 0, 0, 2095, 852, 0, 0, 0, 0, 63163), -- 26094
(@CGUID+4, 26094, 571, 3537, 4128, 1, 1, 0, 3776.92529296875, 3591.88525390625, 357.232177734375, 3.725480079650878906, 120, 0, 0, 2095, 852, 0, 0, 0, 0, 63163), -- 26094
(@CGUID+5, 26094, 571, 3537, 4128, 1, 1, 0, 3801.709228515625, 3554.345947265625, 356.84326171875, 4.380776405334472656, 120, 0, 0, 2095, 852, 0, 0, 0, 0, 63163), -- 26094
(@CGUID+6, 26094, 571, 3537, 4128, 1, 1, 0, 3695.5478515625, 3576.253173828125, 357.273834228515625, 4.084070205688476562, 120, 0, 0, 2095, 852, 0, 0, 0, 0, 63163), -- 26094
(@CGUID+7, 26094, 571, 3537, 4128, 1, 1, 0, 3658.68310546875, 3569.76806640625, 379.58563232421875, 5.742133140563964843, 120, 0, 0, 2095, 852, 0, 0, 0, 0, 63163), -- 26094
(@CGUID+8, 26094, 571, 3537, 4128, 1, 1, 0, 3755.951904296875, 3555.982177734375, 352.608795166015625, 5.532693862915039062, 120, 0, 0, 2095, 852, 0, 0, 0, 0, 63163), -- 26094
(@CGUID+9, 26094, 571, 3537, 4128, 1, 1, 0, 3750.928955078125, 3583.85791015625, 353.133056640625, 5.305800914764404296, 120, 0, 0, 2095, 852, 0, 0, 0, 0, 63163), -- 26094
(@CGUID+10, 26094, 571, 3537, 4128, 1, 1, 0, 3743.177978515625, 3547.561767578125, 352.581085205078125, 1.93731546401977539, 120, 0, 0, 2095, 852, 0, 0, 0, 0, 63163), -- 26094
(@CGUID+11, 26094, 571, 3537, 4128, 1, 1, 0, 3764.579345703125, 3529.76904296875, 356.787750244140625, 2.164467573165893554, 120, 0, 0, 2095, 852, 0, 0, 0, 0, 63163), -- 26094
(@CGUID+12, 26094, 571, 3537, 4128, 1, 1, 0, 3677.7001953125, 3580.002685546875, 357.1766357421875, 2.984513044357299804, 120, 0, 0, 2095, 852, 0, 0, 0, 0, 63163), -- 26094
(@CGUID+13, 26094, 571, 3537, 4128, 1, 1, 0, 3722.888427734375, 3578.421630859375, 353.603179931640625, 4.555309295654296875, 120, 0, 0, 2095, 852, 0, 0, 0, 0, 63163), -- 26094
(@CGUID+14, 26094, 571, 3537, 4128, 1, 1, 0, 3687.4306640625, 3532.681884765625, 383.60858154296875, 0.750491559505462646, 120, 0, 0, 2095, 852, 0, 0, 0, 0, 63163), -- 26094
(@CGUID+15, 26094, 571, 3537, 4128, 1, 1, 0, 3714.739990234375, 3604.69384765625, 357.15423583984375, 3.700098037719726562, 120, 0, 0, 2095, 852, 0, 0, 0, 0, 63163), -- 26094
(@CGUID+16, 26094, 571, 3537, 4128, 1, 1, 0, 3664.64892578125, 3596.26025390625, 379.33416748046875, 1.535889744758605957, 120, 0, 0, 2095, 852, 0, 0, 0, 0, 63163), -- 26094
(@CGUID+17, 26094, 571, 3537, 4128, 1, 1, 0, 3759.2587890625, 3570.970458984375, 352.413238525390625, 0.78539818525314331, 120, 0, 0, 2095, 852, 0, 0, 0, 0, 63163), -- 26094
(@CGUID+18, 26094, 571, 3537, 4128, 1, 1, 0, 3728.220947265625, 3550.713134765625, 353.099822998046875, 1.029744267463684082, 120, 0, 0, 2095, 852, 0, 0, 0, 0, 63163), -- 26094
(@CGUID+19, 26094, 571, 3537, 4128, 1, 1, 0, 3792.02783203125, 3601.504638671875, 383.247467041015625, 0.872664630413055419, 120, 0, 0, 2095, 852, 0, 0, 0, 0, 63163), -- 26094
(@CGUID+20, 26094, 571, 3537, 4128, 1, 1, 0, 3742.228759765625, 3647.83642578125, 379.491424560546875, 4.677298545837402343, 120, 0, 0, 2095, 852, 0, 0, 0, 0, 63163), -- 26094
(@CGUID+21, 26094, 571, 3537, 4128, 1, 1, 0, 3768.669189453125, 3642.030517578125, 379.37896728515625, 4.33998727798461914, 120, 0, 0, 2095, 852, 0, 0, 0, 0, 63163), -- 26094
(@CGUID+22, 26094, 571, 3537, 4128, 1, 1, 0, 3705.007080078125, 3619.174072265625, 383.5230712890625, 5.295888423919677734, 120, 0, 0, 2095, 852, 0, 0, 0, 0, 63163), -- 26094
(@CGUID+23, 26094, 571, 3537, 4128, 1, 1, 0, 3736.970458984375, 3486.45263671875, 379.53594970703125, 1.540748834609985351, 120, 0, 0, 2095, 852, 0, 0, 0, 0, 63163), -- 26094
(@CGUID+24, 26094, 571, 3537, 4128, 1, 1, 0, 3701.977783203125, 3542.440185546875, 357.294677734375, 0.582478821277618408, 120, 0, 0, 2095, 852, 0, 0, 0, 0, 63163), -- 26094
(@CGUID+25, 26094, 571, 3537, 4128, 1, 1, 0, 3814.578125, 3537.555908203125, 379.378936767578125, 2.530727386474609375, 120, 0, 0, 2095, 852, 0, 0, 0, 0, 63163), -- 26094
(@CGUID+26, 26094, 571, 3537, 4128, 1, 1, 0, 3820.23828125, 3564.518798828125, 379.45037841796875, 3.109837055206298828, 120, 0, 0, 2095, 852, 0, 0, 0, 0, 63163), -- 26094
(@CGUID+27, 26094, 571, 3537, 4128, 1, 1, 0, 3710.322021484375, 3492.05078125, 379.546295166015625, 1.201164007186889648, 120, 0, 0, 2095, 852, 0, 0, 0, 0, 63163), -- 26094
(@CGUID+28, 26094, 571, 3537, 4128, 1, 1, 0, 3748.444580078125, 3611.04296875, 357.19744873046875, 4.136430263519287109, 120, 0, 0, 2095, 852, 0, 0, 0, 0, 63163), -- 26094
(@CGUID+29, 26094, 571, 3537, 4128, 1, 1, 0, 3752.42529296875, 3629.353271484375, 357.46136474609375, 4.506084442138671875, 120, 0, 0, 2095, 852, 0, 0, 0, 0, 63163), -- 26094
(@CGUID+30, 26094, 571, 3537, 4128, 1, 1, 0, 3726.805908203125, 3505.173828125, 357.183563232421875, 3.473205089569091796, 120, 0, 0, 2095, 852, 0, 0, 0, 0, 63163), -- 26094
(@CGUID+31, 26094, 571, 3537, 4128, 1, 1, 0, 3773.9384765625, 3514.71728515625, 383.30303955078125, 0.03490658476948738, 120, 0, 0, 2095, 852, 0, 0, 0, 0, 63163); -- 26094

UPDATE `creature_template_addon` SET `auras` = '32566' WHERE `entry` = 26093;

SET @CGUID = 1107;
DELETE FROM `creature` WHERE `id1` = 26093;
INSERT INTO `creature` (`guid`, `id1`, `map`, `zoneId`, `areaId`, `spawnMask`, `phaseMask`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `wander_distance`, `currentwaypoint`, `curhealth`, `curmana`, `MovementType`, `npcflag`, `unit_flags`, `dynamicflags`, `VerifiedBuild`) VALUES
(@CGUID+0, 26093, 571, 3537, 4128, 1, 1, 0, 3739.39404296875, 3567.0869140625, 374.34088134765625, 3.804817676544189453, 120, 0, 0, 2095, 852, 0, 0, 0, 0, 63163); -- 26093

DELETE FROM `creature_template_movement` WHERE `CreatureID` IN (26093, 26094);
INSERT INTO `creature_template_movement` (`CreatureID`, `Ground`, `Swim`, `Flight`) VALUES
(26093, 1, 0, 1),
(26094, 1, 0, 1);

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 26094;

DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = 26094);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(26094, 0, 0, 0, 25, 0, 100, 0, 0, 0, 0, 0, 0, 0, 11, 46477, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Naxxanar Caster - On Reset - Cast \'Naxxanar Beam 1\''),
(26094, 0, 1, 0, 60, 0, 100, 0, 8000, 8000, 8000, 8000, 0, 0, 11, 46521, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Naxxanar Caster - On Update - Cast \'Naxxanar Beam 3\'');

DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = 25601);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(25601, 0, 0, 0, 0, 0, 100, 0, 4000, 8000, 4000, 8000, 0, 0, 11, 15537, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Prince Valanar - In Combat - Cast \'Shadow Bolt\''),
(25601, 0, 1, 0, 0, 0, 100, 0, 7600, 14000, 6400, 19700, 0, 0, 11, 50992, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Prince Valanar - In Combat - Cast \'Soul Blast\''),
(25601, 0, 2, 0, 0, 0, 100, 0, 7200, 24100, 14500, 26600, 0, 0, 11, 51009, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Prince Valanar - In Combat - Cast \'Soul Deflection\''),
(25601, 0, 3, 0, 25, 0, 100, 0, 0, 0, 0, 0, 0, 0, 11, 46482, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Prince Valanar - On Reset - Cast \'Naxxanar Beam 2\'');

DELETE FROM `conditions` WHERE (`SourceTypeOrReferenceId` = 13) AND (`SourceGroup` = 1) AND (`SourceEntry` = 46477) AND (`SourceId` = 0) AND (`ElseGroup` = 0) AND (`ConditionTypeOrReference` = 31) AND (`ConditionTarget` = 0) AND (`ConditionValue1` = 3) AND (`ConditionValue2` = 26093) AND (`ConditionValue3` = 0);
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `ErrorType`, `ErrorTextId`, `ScriptName`, `Comment`) VALUES
(13, 1, 46477, 0, 0, 31, 0, 3, 26093, 0, 0, 0, 0, '', 'Spell Naxxanar Beam 1 only hit Naxxanar Target');

DELETE FROM `conditions` WHERE (`SourceTypeOrReferenceId` = 13) AND (`SourceGroup` = 1) AND (`SourceEntry` = 46482) AND (`SourceId` = 0) AND (`ElseGroup` = 0) AND (`ConditionTypeOrReference` = 31) AND (`ConditionTarget` = 0) AND (`ConditionValue1` = 3) AND (`ConditionValue2` = 26093) AND (`ConditionValue3` = 0);
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `ErrorType`, `ErrorTextId`, `ScriptName`, `Comment`) VALUES
(13, 1, 46482, 0, 0, 31, 0, 3, 26093, 0, 0, 0, 0, '', 'Spell Naxxanar Beam 2 only hit Naxxanar Target');

DELETE FROM `conditions` WHERE (`SourceTypeOrReferenceId` = 13) AND (`SourceGroup` = 1) AND (`SourceEntry` = 46521) AND (`SourceId` = 0) AND (`ElseGroup` = 0) AND (`ConditionTypeOrReference` = 31) AND (`ConditionTarget` = 0) AND (`ConditionValue1` = 3) AND (`ConditionValue2` = 26093) AND (`ConditionValue3` = 0);
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `ErrorType`, `ErrorTextId`, `ScriptName`, `Comment`) VALUES
(13, 1, 46521, 0, 0, 31, 0, 3, 26093, 0, 0, 0, 0, '', 'Spell Naxxanar Beam 3 only hit Naxxanar Target');

DELETE FROM `conditions` WHERE (`SourceTypeOrReferenceId` = 22) AND `SourceGroup` IN (1, 2) AND (`SourceEntry` = 26094);
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `ErrorType`, `ErrorTextId`, `ScriptName`, `Comment`) VALUES
(22, 1, 26094, 0, 0, 29, 1, 26093, 28, 0, 0, 0, 0, '', 'Naxxanar Beam 2 requires Naxxanar Target within 28yd'),
(22, 2, 26094, 0, 0, 29, 1, 26093, 28, 0, 1, 0, 0, '', 'Naxxanar Beam 2 requires Naxxanar Target NOT within 28yd');

DELETE FROM `creature_addon` WHERE `guid` = 85246;
