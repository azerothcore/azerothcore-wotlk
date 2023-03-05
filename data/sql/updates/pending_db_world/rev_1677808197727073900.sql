--
UPDATE `creature_template_addon` SET `bytes2` = 1, `visibilityDistanceType` = 5 WHERE (`entry` = 19851);
UPDATE `creature_template` SET `unit_flags` = 32768, `flags_extra` = `flags_extra`|2097152 WHERE (`entry` = 19851);

DELETE FROM `creature` WHERE `id1`=19851; -- Delete extra Negatron

-- Position: X: 3148.7415 Y: 3233.878 Z: 97.6867
-- Orientation: 1.906365156173706054

DELETE FROM `waypoints` WHERE `entry` IN (1985100, 1985101) AND `point_comment`='Negatron';
INSERT INTO `waypoints` (`entry`, `pointid`, `position_x`, `position_y`, `position_z`, `orientation`, `point_comment`) VALUES
(1985100,1,3137.2078,3268.273,110.69139,NULL,'Negatron'),
(1985100,2,3128.09,3294.4512,107.87908,NULL,'Negatron'),
(1985100,3,3121.0325,3314.7815,110.84304,NULL,'Negatron'), -- Doctor Vomisa face Negatron
(1985100,4,3113.2158,3336.4111,107.649345,NULL,'Negatron'),
(1985100,5,3104.8281,3361.3098,104.649345,NULL,'Negatron'),
(1985100,6,3097.5208,3381.5989,105.865395,NULL,'Negatron'),
(1985101,1,3053.5566,3421.556,111.00708,NULL,'Negatron'),
(1985101,2,3051.7932,3455.1265,118.63066,NULL,'Negatron'),
(1985101,3,3034.655,3492.1448,134.73538,NULL,'Negatron'),
(1985101,4,3024.468,3515.7493,143.77145,NULL,'Negatron'),
(1985101,5,3028.9001,3538.7004,144.36063,NULL,'Negatron'),
(1985101,6,3036.7417,3573.2764,143.18323,NULL,'Negatron'),
(1985101,7,3049.1687,3585.138,143.41333,NULL,'Negatron');

UPDATE `creature_text` SET `Emote`=25, `BroadcastTextId`=17456 WHERE `CreatureID`=19832 AND `GroupID`=0 AND `ID`=0;

DELETE FROM `creature_text` WHERE `CreatureID` IN (19570, 19849, 19851);
INSERT INTO `creature_text` (`CreatureID`, `GroupID`, `ID`, `Text`, `Type`, `Language`, `Probability`, `Emote`, `Duration`, `Sound`, `BroadcastTextId`, `TextRange`, `comment`) VALUES
(19570, 0, 0, 'Oh no!  The X-52 Nether-Rocket is being attacked!  Guards!  Guards!', 14, 0, 100, 5, 0, 0, 17474, 0, 'Rocket-Chief Fuselage'),
(19849, 0, 0, 'The %s, having fought the good fight, falls to pieces.', 16, 0, 100, 0, 0, 0, 18587, 0, 'Scrap Reaver X6000'),
(19851, 0, 0, 'I AM DEATH!  PREPARE YOUR TOWN FOR ANNIHILATION!', 14, 0, 100, 0, 0, 0, 17455, 0, 'Negatron'),
(19851, 1, 0, 'YOUR SAD ATTEMPT AT CREATING A FEL REAVER TO STOP ME HAS FAILED!  NOW, ON TO AREA 52!', 14, 0, 100, 0, 0, 0, 17468, 0, 'Negatron');

DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = 19832);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(19832, 0, 0, 0, 38, 0, 100, 0, 1, 1, 0, 0, 0, 12, 19851, 4, 300000, 0, 0, 0, 8, 0, 0, 0, 0, 3148.7415, 3233.878, 97.6867, 1.906365156173706, 'Doctor Vomisa, Ph.T. - On Data Set 1 1 - Summon Creature \'Negatron\''),
(19832, 0, 1, 0, 38, 0, 100, 0, 2, 2, 0, 0, 0, 80, 1983200, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Doctor Vomisa, Ph.T. - On Data Set 2 2 - Run Script');

DELETE FROM `smart_scripts` WHERE (`source_type` = 9 AND `entryorguid` = 1983200);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(1983200, 9, 0, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 66, 0, 0, 0, 0, 0, 0, 8, 0, 0, 0, 0, 0, 0, 0, 5.072320938110352, 'Doctor Vomisa, Ph.T. - Actionlist - Set Orientation 5.072320938110352'),
(1983200, 9, 1, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 1, 0, 0, 1, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Doctor Vomisa, Ph.T. - Actionlist - Say Line 0');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 19849;
DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = 19849);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(19849, 0, 0, 1, 8, 0, 100, 513, 34630, 0, 0, 0, 0, 45, 1, 1, 0, 0, 0, 0, 10, 70967, 19832, 0, 0, 0, 0, 0, 0, 'Scrap Reaver X6000 - On Spellhit \'Scrap Reaver X6000\' - Set Data 1 1 on Doctor Vomisa, Ph.T. - Summon Negatron'),
(19849, 0, 1, 0, 61, 0, 100, 512, 0, 0, 0, 0, 0, 64, 1, 0, 0, 0, 0, 0, 16, 0, 0, 0, 0, 0, 0, 0, 0, 'Scrap Reaver X6000 - On Spellhit \'Scrap Reaver X6000\' - Store Targetlist Invoker Party'),
(19849, 0, 2, 0, 38, 0, 100, 512, 1, 1, 0, 0, 0, 80, 1984900, 2, 1, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Scrap Reaver X6000 - On Data Set 1 1 - Run Script');

DELETE FROM `smart_scripts` WHERE (`source_type` = 9 AND `entryorguid` = 1984900);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(1984900, 9, 0, 0, 0, 0, 100, 512, 0, 0, 0, 0, 0, 33, 19851, 0, 0, 0, 0, 0, 12, 1, 0, 0, 0, 0, 0, 0, 0, 'Scrap Reaver X6000 - Actionlist - Quest Credit \'You, Robot\''),
(1984900, 9, 1, 0, 0, 0, 100, 512, 10000, 10000, 0, 0, 0, 18, 33556488, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Scrap Reaver X6000 - Actionlist - Set Flags PvP Attackable & Pet In Combat & Not Selectable'),
(1984900, 9, 2, 0, 0, 0, 100, 512, 0, 0, 0, 0, 0, 90, 7, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Scrap Reaver X6000 - Actionlist - Set Flag Standstate Dead'),
(1984900, 9, 3, 0, 0, 0, 100, 512, 200, 200, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Scrap Reaver X6000 - Actionlist - Say Line 0'),
(1984900, 9, 4, 0, 0, 0, 100, 512, 0, 0, 0, 0, 0, 41, 6000, 60000, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Scrap Reaver X6000 - Actionlist - Despawn In 6000 ms');

DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = 19851);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(19851, 0, 0, 0, 54, 0, 100, 0, 0, 0, 0, 0, 0, 80, 1985100, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Negatron - On Just Summoned - Run Script'),
(19851, 0, 1, 0, 40, 0, 100, 0, 3, 1985100, 0, 0, 0, 45, 2, 2, 0, 0, 0, 0, 10, 70967, 19832, 0, 0, 0, 0, 0, 0, 'Negatron - On Waypoint 3 Reached - Set Data 2 2 on Doctor Vomisa, Ph.T.'),
(19851, 0, 2, 0, 58, 0, 100, 0, 6, 1985100, 0, 0, 0, 80, 1985101, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Negatron - On Waypoint Finished - Run Script'),
(19851, 0, 3, 0, 25, 0, 100, 0, 0, 0, 0, 0, 0, 22, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Negatron - On Reset - Set Event Phase 1 (Allow Failure Event Timer to Start)'),
(19851, 0, 4, 0, 1, 1, 100, 1, 15000, 15000, 0, 0, 0, 80, 1985102, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Negatron - Out of Combat - Run Failure Event Script (Phase 1)'),
(19851, 0, 5, 0, 58, 0, 100, 0, 7, 1985101, 0, 0, 0, 80, 1985103, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Negatron - On Waypoint Finished - Run Script'),
(19851, 0, 6, 0, 34, 0, 100, 0, 8, 1, 0, 0, 0, 80, 1985104, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Negatron - On MovementInform 1 - Run Script'),
(19851, 0, 7, 0, 6, 0, 100, 0, 0, 0, 0, 0, 0, 45, 1, 1, 0, 0, 0, 0, 19, 19849, 100, 0, 0, 0, 0, 0, 0, 'Negatron - On Just Died - Set Data 1 1 on Scrap Reaver X6000 - Start Success Event');

DELETE FROM `smart_scripts` WHERE (`source_type` = 9 AND `entryorguid` IN (1985100, 1985101, 1985102, 1985103, 1985104));
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(1985100, 9, 0, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 48, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Negatron - Actionlist - Set Active On'),
(1985100, 9, 1, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 18, 33024, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Negatron - Actionlist - Set Flags Immune To Players'),
(1985100, 9, 2, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 53, 1, 1985100, 0, 0, 0, 2, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Negatron - Actionlist - Start Waypoint'),
(1985100, 9, 3, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 11, 15742, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Negatron - Actionlist - Cast \'Ashcrombe`s Teleport\''),
(1985100, 9, 4, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 22, 2, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Negatron - Actionlist - Set Event Phase 2 (Do Not Start Timer for Failure Event)'),

(1985101, 9, 0, 0, 0, 0, 100, 0, 2000, 2000, 0, 0, 0, 66, 0, 0, 0, 0, 0, 0, 10, 70967, 19832, 0, 0, 0, 0, 0, 0, 'Negatron - Actionlist - Set Orientation Creature \'Doctor Vomisa, Ph.T.\''),
(1985101, 9, 1, 0, 0, 0, 100, 0, 150, 150, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Negatron - Actionlist - Say Line 0'),
(1985101, 9, 2, 0, 0, 0, 100, 0, 6000, 6000, 0, 0, 0, 18, 32768, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Negatron - Actionlist - Remove Immunity Flags'),
(1985101, 9, 3, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 49, 0, 0, 0, 0, 0, 0, 10, 70975, 19849, 0, 0, 0, 0, 0, 0, 'Negatron - Actionlist - Start Attacking Scrap Reaver X6000'),

(1985102, 9, 0, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 53, 1, 1985101, 0, 0, 0, 2, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Negatron - Actionlist - Start Waypoint'),
(1985102, 9, 1, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 18, 33536, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Negatron - Actionlist - Set Flags Immune To Players & Immune To NPC\'s'),
(1985102, 9, 2, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Negatron - Actionlist - Say Line 1'),

(1985103, 9, 0, 0, 0, 0, 100, 0, 300, 300, 0, 0, 0, 11, 34427, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Negatron - Actionlist - Cast \'Ethereal Teleport\''),
(1985103, 9, 1, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 62, 530, 0, 0, 0, 0, 0, 8, 0, 0, 0, 0, 3044.2, 3622.36, 143.269, 0, 'Negatron - Actionlist - Teleport'),
(1985103, 9, 2, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 59, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Negatron - Actionlist - Set Run On'),
(1985103, 9, 3, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 69, 1, 0, 0, 0, 0, 0, 8, 0, 0, 0, 0, 3037.824, 3659.001, 143.53865, 0, 'Negatron - Actionlist - Move To Position'),

(1985104, 9, 0, 0, 0, 0, 100, 0, 150, 150, 0, 0, 0, 5, 54, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Negatron - Actionlist - Play Emote 54'),
(1985104, 9, 1, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 50, 183987, 180000, 0, 0, 0, 0, 8, 0, 0, 0, 0, 3030.1443, 3656.7964, 159.49426, 0.15707901, 'Negatron - Actionlist - Summon Gameobject \'Rocket Fire\''),
(1985104, 9, 2, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 50, 183987, 180000, 0, 0, 0, 0, 8, 0, 0, 0, 0, 3047.6445, 3668.2544, 158.13696, 0.017452462, 'Negatron - Actionlist - Summon Gameobject \'Rocket Fire\''),
(1985104, 9, 3, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 50, 183987, 180000, 0, 0, 0, 0, 8, 0, 0, 0, 0, 3029.779, 3677.4927, 158.64986, 1.3439013, 'Negatron - Actionlist - Summon Gameobject \'Rocket Fire\''),
(1985104, 9, 4, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 50, 183987, 180000, 0, 0, 0, 0, 8, 0, 0, 0, 0, 3038.2305, 3670.395, 197.78914, 6.073746, 'Negatron - Actionlist - Summon Gameobject \'Rocket Fire\''),
(1985104, 9, 5, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 50, 183987, 180000, 0, 0, 0, 0, 8, 0, 0, 0, 0, 3042.363, 3667.0383, 180.62209, 4.747296, 'Negatron - Actionlist - Summon Gameobject \'Rocket Fire\''),
(1985104, 9, 6, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 50, 183987, 180000, 0, 0, 0, 0, 8, 0, 0, 0, 0, 3031.6763, 3671.5273, 180.86804, 0.69813144, 'Negatron - Actionlist - Summon Gameobject \'Rocket Fire\''),
(1985104, 9, 7, 0, 0, 0, 100, 0, 1200, 1200, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 10, 70009, 19570, 0, 0, 0, 0, 0, 0, 'Negatron - Actionlist - Say Line 0 (Rocket-Chief Fuselage)'),
(1985104, 9, 8, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 18, 33024, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Negatron - Actionlist - Set Flags Immune To Players');
