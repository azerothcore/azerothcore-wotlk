--
DELETE FROM `creature_equip_template` WHERE (`CreatureID` = 23718);
INSERT INTO `creature_equip_template` (`CreatureID`, `ID`, `ItemID1`, `ItemID2`, `ItemID3`, `VerifiedBuild`) VALUES
(23718, 1, 2716, 0, 0, 57888);

-- Pathing for Mack Entry: 23718
SET @NPC := 139273;
SET @PATH := (@NPC * 10);
DELETE FROM `waypoint_data` WHERE `id`=@PATH;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`orientation`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
(@PATH,1,6752.6504,-7560.3726,126.15855,NULL,0,0,0,100,0),
(@PATH,2,6755.828,-7584.8135,127.33693,NULL,0,0,0,100,0),
(@PATH,3,6748.864,-7601.5347,127.00935,NULL,0,0,0,100,0),
(@PATH,4,6742.1353,-7608.194,126.093445,NULL,19400,0,0,100,0), -- Talk to Ameenah
(@PATH,5,6745.817,-7600.8325,126.54117,NULL,0,0,0,100,0),
(@PATH,6,6753.718,-7588.0425,127.563095,NULL,0,0,0,100,0),
(@PATH,7,6771.875,-7584.8584,127.290146,NULL,12960,0,0,100,0), -- Get Drink
(@PATH,8,6769.5576,-7577.0537,127.32736,NULL,0,0,0,100,0),
(@PATH,9,6770.5884,-7568.6104,127.41217,NULL,0,0,0,100,0),
(@PATH,10,6762.0464,-7555.414,126.224945,NULL,0,0,0,100,0),
(@PATH,11,6754.4546,-7549.847,126.13906,NULL,22670,0,0,100,0), -- Drink
(@PATH,12,6754.4546,-7549.847,126.13906,2.477182865142822265,11350,0,0,100,0), -- Cheer
(@PATH,13,6743.7188,-7553.3457,126.19035,NULL,0,0,0,100,0),
(@PATH,14,6743.7188,-7553.3457,126.19035,3.176499128341674804,0,0,0,100,0);
-- 0x20449C424017298000003A000079A064 .go xyz 6752.6504 -7560.3726 126.15855

-- Pathing for Mack Entry: 23718
SET @NPC := 139273;
SET @PATH := (@NPC * 10) + 1;
DELETE FROM `waypoint_data` WHERE `id`=@PATH;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`orientation`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
(@PATH,1,6725.964,-7561.686,128.34082,NULL,9570,0,0,100,0), -- Sleep
(@PATH,2,6725.964,-7561.686,128.34082,0.279252678155899047,120000,0,0,100,0),
(@PATH,3,6743.7188,-7553.3457,126.19035,NULL,0,0,0,100,0),
(@PATH,4,6743.7188,-7553.3457,126.19035,3.176499128341674804,0,0,0,100,0);
-- 0x20449C424017298000003A000079A064 .go xyz 6743.7188 -7553.3457 126.19035

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE (`entry` = 23718);
DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = -139273);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(-139273, 0, 0, 0, 11, 0, 100, 0, 0, 0, 0, 0, 0, 0, 22, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Mack - On Respawn - Set Event Phase 1'),
(-139273, 0, 1, 0, 109, 0, 100, 0, 0, 0, 0, 0, 0, 0, 22, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Mack - On Path Any Finished - Set Event Phase 1'),
(-139273, 0, 2, 0, 1, 1, 100, 0, 180000, 240000, 180000, 240000, 0, 0, 87, 2371800, 2371801, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Mack - Out of Combat - Run Random Script (Phase 1)'),
(-139273, 0, 3, 0, 1, 1, 100, 0, 6400, 20000, 6400, 20000, 0, 0, 10, 11, 21, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Mack - Out of Combat - Play Random Emote (11, 21) (Phase 1)'),
(-139273, 0, 4, 0, 108, 0, 100, 0, 4, 1392730, 0, 0, 0, 0, 80, 2371802, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Mack - On Point 4 of Path 1392730 Reached - Run Script'),
(-139273, 0, 5, 0, 108, 0, 100, 0, 7, 1392730, 0, 0, 0, 0, 80, 2371803, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Mack - On Point 7 of Path 1392730 Reached - Run Script'),
(-139273, 0, 6, 0, 108, 0, 100, 0, 11, 1392730, 0, 0, 0, 0, 80, 2371804, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Mack - On Point 11 of Path 1392730 Reached - Run Script'),
(-139273, 0, 7, 0, 108, 0, 100, 0, 1, 1392731, 0, 0, 0, 0, 1, 4, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Mack - On Point 1 of Path 1392731 Reached - Say Line 4'),
(-139273, 0, 8, 0, 108, 0, 100, 0, 2, 1392731, 0, 0, 0, 0, 80, 2371805, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Mack - On Point 2 of Path 1392731 Reached - Run Script');

DELETE FROM `smart_scripts` WHERE (`source_type` = 9 AND `entryorguid` IN (2371800, 2371801));
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(2371800, 9, 0, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 232, 1392730, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Mack - Actionlist - Start Waypoint Path 1392730'),
(2371800, 9, 1, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 22, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Mack - Actionlist - Set Event Phase 0'),
(2371801, 9, 0, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 232, 1392731, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Mack - Actionlist - Start Waypoint Path 1392731'),
(2371801, 9, 1, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 22, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Mack - Actionlist - Set Event Phase 0');

DELETE FROM `smart_scripts` WHERE (`source_type` = 9 AND `entryorguid` = 2371802);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(2371802, 9, 0, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Mack - Actionlist - Say Line 0'),
(2371802, 9, 1, 0, 0, 0, 100, 0, 6400, 6400, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 10, 139264, 0, 0, 0, 0, 0, 0, 0, 'Mack - Actionlist - Say Line 0 (Ameenah)'),
(2371802, 9, 2, 0, 0, 0, 100, 0, 6400, 6400, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Mack - Actionlist - Say Line 1');

DELETE FROM `smart_scripts` WHERE (`source_type` = 9 AND `entryorguid` = 2371803);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(2371803, 9, 0, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 17, 69, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Mack - Actionlist - Set Emote State 69'),
(2371803, 9, 1, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 1, 2, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Mack - Actionlist - Say Line 2'),
(2371803, 9, 2, 0, 0, 0, 100, 0, 3200, 3200, 0, 0, 0, 0, 17, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Mack - Actionlist - Set Emote State 0'),
(2371803, 9, 3, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 124, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Mack - Actionlist - Load Equipment Id 1'),
(2371803, 9, 4, 0, 0, 0, 100, 0, 3200, 3200, 0, 0, 0, 0, 5, 92, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Mack - Actionlist - Play Emote 92');

DELETE FROM `smart_scripts` WHERE (`source_type` = 9 AND `entryorguid` = 2371804);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(2371804, 9, 0, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 5, 92, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Mack - Actionlist - Play Emote 92'),
(2371804, 9, 1, 0, 0, 0, 100, 0, 3200, 3200, 0, 0, 0, 0, 5, 92, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Mack - Actionlist - Play Emote 92'),
(2371804, 9, 2, 0, 0, 0, 100, 0, 8100, 8100, 0, 0, 0, 0, 5, 92, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Mack - Actionlist - Play Emote 92'),
(2371804, 9, 3, 0, 0, 0, 100, 0, 11300, 11300, 0, 0, 0, 0, 11, 42333, 0, 0, 0, 0, 0, 10, 139292, 0, 0, 0, 0, 0, 0, 0, 'Mack - Actionlist - Cast \'Throw Torch\''),
(2371804, 9, 4, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 124, 0, 1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Mack - Actionlist - Load Equipment Id 0'),
(2371804, 9, 5, 0, 0, 0, 100, 0, 6480, 6480, 0, 0, 0, 0, 5, 4, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Mack - Actionlist - Play Emote 4');

DELETE FROM `smart_scripts` WHERE (`source_type` = 9 AND `entryorguid` = 2371805);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(2371805, 9, 0, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 11, 32951, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Mack - Actionlist - Cast \'Sleeping Sleep\''),
(2371805, 9, 1, 0, 0, 0, 100, 0, 120000, 120000, 0, 0, 0, 0, 28, 32951, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Mack - Actionlist - Remove Aura \'Sleeping Sleep\'');

-- Debug:
DELETE FROM `smart_scripts` WHERE (`entryorguid` = -139273) AND (`source_type` = 0) AND (`id` IN (9, 10));
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(-139273, 0, 9, 0, 38, 1, 100, 0, 1, 1, 0, 0, 0, 0, 80, 2371800, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Mack - On Data Set 1 1 - Run Script (Phase 1)'),
(-139273, 0, 10, 0, 38, 1, 100, 0, 1, 2, 0, 0, 0, 0, 80, 2371801, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Mack - On Data Set 1 2 - Run Script (Phase 1)');
