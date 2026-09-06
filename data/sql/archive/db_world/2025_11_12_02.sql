-- DB update 2025_11_12_01 -> 2025_11_12_02
--
SET @PLANE := 28710;
SET @PILOT := 28646;
UPDATE `creature_template` SET `AIName`='SmartAI',`ScriptName`='', `speed_walk`=10, `speed_run`=1 WHERE `entry`=@PLANE;
DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = 28710);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(28710, 0, 1, 0, 60, 0, 100, 513, 1000, 1000, 0, 0, 0, 0, 53, 1, 28710, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Vic\'s Flying Machine - On Update - Start Waypoint Path 28710 (No Repeat)'),
(28710, 0, 2, 0, 40, 0, 100, 512, 5, 28710, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 19, 28646, 0, 0, 0, 0, 0, 0, 0, 'Vic\'s Flying Machine - On Point 5 of Path 28710 Reached - Say Line 0'),
(28710, 0, 3, 0, 40, 0, 100, 512, 11, 28710, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 19, 28646, 0, 0, 0, 0, 0, 0, 0, 'Vic\'s Flying Machine - On Point 11 of Path 28710 Reached - Say Line 1'),
(28710, 0, 4, 0, 40, 0, 100, 512, 12, 28710, 0, 0, 0, 0, 1, 2, 0, 0, 0, 0, 0, 19, 28646, 0, 0, 0, 0, 0, 0, 0, 'Vic\'s Flying Machine - On Point 12 of Path 28710 Reached - Say Line 2'),
(28710, 0, 5, 0, 40, 0, 100, 512, 14, 28710, 0, 0, 0, 0, 1, 3, 0, 0, 0, 0, 0, 19, 28646, 0, 0, 0, 0, 0, 0, 0, 'Vic\'s Flying Machine - On Point 14 of Path 28710 Reached - Say Line 3'),
(28710, 0, 6, 0, 40, 0, 100, 512, 15, 28710, 0, 0, 0, 0, 1, 4, 0, 0, 0, 0, 0, 19, 28646, 0, 0, 0, 0, 0, 0, 0, 'Vic\'s Flying Machine - On Point 15 of Path 28710 Reached - Say Line 4'),
(28710, 0, 7, 0, 40, 0, 100, 512, 17, 28710, 0, 0, 0, 0, 1, 5, 0, 0, 0, 0, 0, 19, 28646, 0, 0, 0, 0, 0, 0, 0, 'Vic\'s Flying Machine - On Point 17 of Path 28710 Reached - Say Line 5'),
(28710, 0, 8, 0, 40, 0, 100, 512, 21, 28710, 0, 0, 0, 0, 1, 6, 0, 0, 0, 0, 0, 19, 28646, 0, 0, 0, 0, 0, 0, 0, 'Vic\'s Flying Machine - On Point 21 of Path 28710 Reached - Say Line 6'),
(28710, 0, 9, 10, 40, 0, 100, 512, 25, 28710, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Vic\'s Flying Machine - On Point 25 of Path 28710 Reached - Say Line 0'),
(28710, 0, 10, 0, 61, 0, 100, 512, 0, 0, 0, 0, 0, 0, 11, 52255, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Vic\'s Flying Machine - On Point 25 of Path 28710 Reached - Cast \'Engine on Fire\''),
(28710, 0, 11, 0, 28, 0, 100, 512, 0, 0, 0, 0, 0, 0, 134, 44795, 2, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Vic\'s Flying Machine - On Passenger Removed - Invoker Cast \'Parachute\''),
(28710, 0, 12, 13, 8, 0, 100, 512, 52226, 0, 0, 0, 0, 0, 22, 2, 0, 0, 0, 0, 0, 23, 0, 0, 0, 0, 0, 0, 0, 0, 'Vic\'s Flying Machine - On Spellhit \'Land Flying Machine\' - Set Event Phase 2'),
(28710, 0, 13, 0, 61, 0, 100, 512, 0, 0, 0, 0, 0, 0, 11, 50630, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Vic\'s Flying Machine - On Spellhit \'Land Flying Machine\' - Cast \'Eject All Passengers\''),
(28710, 0, 14, 0, 40, 0, 100, 512, 26, 28710, 0, 0, 0, 0, 59, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Vic\'s Flying Machine - On Point 26 of Path 28710 Reached - Set Run On'),
(28710, 0, 15, 0, 28, 2, 100, 512, 0, 0, 0, 0, 0, 0, 134, 53328, 2, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Vic\'s Flying Machine - On Passenger Removed - Invoker Cast \'Land Flying Machine Credit\' (Phase 2)'),
(28710, 0, 16, 0, 11, 0, 100, 512, 0, 0, 0, 0, 0, 0, 22, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Vic\'s Flying Machine - On Respawn - Set Event Phase 1'),
(28710, 0, 17, 0, 28, 1, 100, 512, 0, 0, 0, 0, 0, 0, 6, 12671, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Vic\'s Flying Machine - On Passenger Removed - Fail Quest \'Reconnaissance Flight\' (Phase 1)');

DELETE FROM `waypoint_data` WHERE `id`=@PLANE;
DELETE FROM `waypoints` WHERE `entry`=@PLANE;
INSERT INTO `waypoints` (`entry`,`pointid`,`position_x`,`position_y`,`position_z`,`point_comment`) VALUES
(@PLANE,1,5494.87,4747.031,-187.8783, 'Vic''s Flying Machine'),
(@PLANE,2,5485.906,4740.681,-184.5172, 'Vic''s Flying Machine'),
(@PLANE,3,5472.882,4732.441,-172.1562, 'Vic''s Flying Machine'),
(@PLANE,4,5460.913,4712.542,-157.8784, 'Vic''s Flying Machine'),
(@PLANE,5,5452.147,4673.518,-137.8906, 'Vic''s Flying Machine'),
(@PLANE,6,5449.777,4630.711,-126.6684, 'Vic''s Flying Machine'),
(@PLANE,7,5507.432,4506.089,-126.6684, 'Vic''s Flying Machine'),
(@PLANE,8,5586.811,4465.319,-126.6684, 'Vic''s Flying Machine'),
(@PLANE,9,5676.111,4437.874,-126.6684, 'Vic''s Flying Machine'),
(@PLANE,10,5756.449,4391.051,-91.25155, 'Vic''s Flying Machine'),
(@PLANE,11,5817.163,4269.269,-91.25155, 'Vic''s Flying Machine'),
(@PLANE,12,5856.145,4202.824,-68.29334, 'Vic''s Flying Machine'),
(@PLANE,13,5921.523,4105.534,-68.29334, 'Vic''s Flying Machine'),
(@PLANE,14,5995.021,4029.883,-13.97897, 'Vic''s Flying Machine'),
(@PLANE,15,6118.298,3883.733,94.11866, 'Vic''s Flying Machine'),
(@PLANE,16,6132.932,3750.75,176.5123, 'Vic''s Flying Machine'),
(@PLANE,17,6165.863,3748.196,198.9567, 'Vic''s Flying Machine'),
(@PLANE,18,6208.277,3782.189,196.8455, 'Vic''s Flying Machine'),
(@PLANE,19,6227.615,3836.871,191.6234, 'Vic''s Flying Machine'),
(@PLANE,20,6218.483,3885.17,191.6234, 'Vic''s Flying Machine'),
(@PLANE,21,6197.045,3890.053,191.6234, 'Vic''s Flying Machine'),
(@PLANE,22,6168.752,3864.161,191.6234, 'Vic''s Flying Machine'),
(@PLANE,23,6204.037,3807.239,191.6234, 'Vic''s Flying Machine'),
(@PLANE,24,6232.975,3820.852,191.6234, 'Vic''s Flying Machine'),
(@PLANE,25,6219.879,3854.341,166.6234, 'Vic''s Flying Machine'),
(@PLANE,26,6210.428,3855.185,154.4848, 'Vic''s Flying Machine');

UPDATE `creature_template_movement` SET `Swim`=1,`Ground`=1,`Flight`=2 WHERE `CreatureId`=@PLANE;
DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId` =14 AND `SourceGroup`=9750;
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `ErrorType`, `ErrorTextId`, `ScriptName`, `Comment`) VALUES
(14, 9750, 13376, 0, 0, 8, 0, 12671, 0, 0, 0, 0, 0, '', 'Pilot Vic Show different gossip if player has rewarded quest 12671 '),
(14, 9750, 13375, 0, 0, 8, 0, 12671, 0, 0, 1, 0, 0, '', 'Pilot Vic Show different gossip if player is not rewarded quest 12671');

DELETE FROM `vehicle_template_accessory` WHERE `entry` IN (@PLANE);
INSERT INTO `vehicle_template_accessory` (`entry`,`accessory_entry`, `seat_id`, `minion`, `description`) VALUES
(@PLANE, @PILOT, 0, 1, 'Vics Flying Machine');
