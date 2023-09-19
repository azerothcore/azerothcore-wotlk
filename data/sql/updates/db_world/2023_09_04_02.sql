-- DB update 2023_09_04_01 -> 2023_09_04_02
--
DELETE FROM `creature_text` WHERE `CreatureID` = 14041;
INSERT INTO `creature_text` (`CreatureID`, `GroupID`, `ID`, `Text`, `Type`, `Language`, `Probability`, `Emote`, `Duration`, `Sound`, `BroadcastTextId`, `TextRange`, `comment`) VALUES
(14041, 0, 0, 'Spare some change?', 12, 0, 100, 1, 0, 0, 9088, 0, 'Haggle - Random Say'),
(14041, 0, 1, 'I had it all!  I had it all and then I lost it.  Lost... all gone... like... my mind.  My mind is like... cheese.  I like cheese.', 12, 0, 100, 1, 0, 0, 9089, 0, 'Haggle - Random Say'),
(14041, 0, 2, 'Forty-two... forty-two... forty-two what?  It could be anything!  Forty-two... hmmm...', 12, 0, 100, 1, 0, 0, 9098, 0, 'Haggle - Random Say'),
(14041, 0, 3, 'Rat-kabobs!  Get your tasty Rat-kabobs here!  Get them while they last!', 12, 0, 100, 1, 0, 0, 9150, 0, 'Haggle - Random Say'),
(14041, 0, 4, 'Rats everywhere.  Everywhere I see rats.  Always looking at me with their beedy little eyes.  I\'ll show them.  I\'ll show them all!', 12, 0, 100, 1, 0, 0, 9149, 0, 'Haggle - Random Say'),
(14041, 1, 0, '%s yawns.', 16, 0, 100, 0, 0, 0, 9147, 0, 'Haggle - Emote 1'),
(14041, 2, 0, '%s sifts through the trash.', 16, 0, 100, 69, 0, 0, 9141, 0, 'Haggle - Emote 2');

DELETE FROM `creature` WHERE `guid` = 53788 AND `id1` = 14041;
INSERT INTO `creature` (`guid`, `id1`, `id2`, `id3`, `map`, `zoneId`, `areaId`, `spawnMask`, `phaseMask`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `wander_distance`, `currentwaypoint`, `curhealth`, `curmana`, `MovementType`, `npcflag`, `unit_flags`, `dynamicflags`, `ScriptName`, `VerifiedBuild`) VALUES
(53788, 14041, 0, 0, 369, 0, 0, 1, 1, 0, 38.99483, 24.375648, -4.2973485, 0.366166770458221435, 190, 0, 0, 484, 0, 0, 0, 0, 0, '', 45704);

DELETE FROM `waypoints` WHERE `entry` = 1404100;
INSERT INTO `waypoints` (`entry`, `pointid`, `position_x`, `position_y`, `position_z`, `orientation`, `delay`, `point_comment`) VALUES
(1404100, 1, 33.34522, 31.454027, -4.2973475, NULL, 0, 'Haggle'),
(1404100, 2, 26.45702, 34.893867, -4.2973475, NULL, 0, 'Haggle'),
(1404100, 3, 20.477, 34.7853, -4.297975, NULL, 0, 'Haggle'),
(1404100, 4, 17.328176, 31.855068, -4.288516, NULL, 0, 'Haggle'),
(1404100, 5, 17.432047, -19.700907, -4.2973523, NULL, 0, 'Haggle'),
(1404100, 6, 14.175989, -24.883198, -4.290597, NULL, 0, 'Haggle'),
(1404100, 7, 14.169546, -28.330238, -4.2973585, NULL, 0, 'Haggle'),
(1404100, 8, 11.564287, -30.887716, -4.2973533, NULL, 0, 'Haggle'),
(1404100, 9, -4.735959, -30.929426, -4.2978487, NULL, 0, 'Haggle'),
(1404100, 10, -7.366175, -25.010038, -4.297242, NULL, 0, 'Haggle'),
(1404100, 11, -19.336628, -17.376917, -4.2973704, NULL, 0, 'Haggle - start wander 1'),
(1404100, 12, -15.261998, -3.653864, -4.297435, NULL, 0, 'Haggle - resume waypoint'),
(1404100, 13, -17.923254, -1.263314, -4.2876077, NULL, 0, 'Haggle - into sleeping on bench'),
(1404100, 14, -16.773191, -1.117661, -4.287462, NULL, 0, 'Haggle'),
(1404100, 15, -14.93353, -15.882146, -4.2973704, NULL, 0, 'Haggle'),
(1404100, 16, -19.337181, -17.266024, -4.2973704, NULL, 0, 'Haggle - start wander 2'),
(1404100, 17, -22.05402, -9.908834, -4.296536, NULL, 0, 'Haggle'),
(1404100, 18, -21.497362, -9.651139, -4.296598, NULL, 0, 'Haggle - sifting through trash 1'),
(1404100, 19, -19.452112, -3.621434, -4.2970552, NULL, 0, 'Haggle - sifting through trash 2'),
(1404100, 20, -14.487922, 0.329824, -4.287024, NULL, 0, 'Haggle'),
(1404100, 21, -15.168751, 20.166489, -4.3063, NULL, 0, 'Haggle'),
(1404100, 22, -16.66379, 21.67101, -4.305281, NULL, 0, 'Haggle'),
(1404100, 23, -18.431108, 21.27326, -4.304296, NULL, 0, 'Haggle - sifting through trash 3'),
(1404100, 24, -15.260129, 26.659346, -4.299999, NULL, 0, 'Haggle'),
(1404100, 25, -16.375502, 26.893675, -4.299803, NULL, 0, 'Haggle - sifting through trash 4'),
(1404100, 26, -13.471532, -15.474365, -4.2973704, NULL, 0, 'Haggle - into sitting on ground'),
(1404100, 27, -19.333311, -17.326876, -4.2973704, NULL, 0, 'Haggle - start wander 3'),
(1404100, 28, -15.293428, -22.230337, -4.299684, NULL, 0, 'Haggle'),
(1404100, 29, -11.042005, -22.395052, -4.29911, NULL, 0, 'Haggle'),
(1404100, 30, -6.875696, -25.810347, -4.29732, NULL, 0, 'Haggle'),
(1404100, 31, -6.518164, -29.358128, -4.2977223, NULL, 0, 'Haggle'),
(1404100, 32, -4.615194, -32.011036, -4.2979712, NULL, 0, 'Haggle'),
(1404100, 33, 10.915832, -32.93334, -4.2973523, NULL, 0, 'Haggle'),
(1404100, 34, 14.343336, -28.164183, -4.2973585, NULL, 0, 'Haggle'),
(1404100, 35, 14.472878, -22.567085, -4.289472, NULL, 0, 'Haggle'),
(1404100, 36, 21.931023, -18.69022, -4.2973504, NULL, 0, 'Haggle'),
(1404100, 37, 22.149866, -17.656652, -4.2973504, NULL, 0, 'Haggle - sifting through trash 5'),
(1404100, 38, 30.895535, -16.94747, -4.297347, NULL, 0, 'Haggle'),
(1404100, 39, 38.974773, -11.690686, -4.297347, NULL, 0, 'Haggle - sifting through trash 6'),
(1404100, 40, 37.514492, -1.188888, -4.2973495, NULL, 0, 'Haggle'),
(1404100, 41, 38.968258, 0.839936, -4.29735, NULL, 0, 'Haggle - sifting through trash 7'),
(1404100, 42, 27.43926, 5.252612, -4.297351, NULL, 0, 'Haggle'),
(1404100, 43, 21.324173, 13.69732, -4.2973514, NULL, 0, 'Haggle'),
(1404100, 44, 21.230026, 14.574246, -4.297351, NULL, 0, 'Haggle - sifting through trash 8'),
(1404100, 45, 27.30816, 14.715199, -4.2973504, NULL, 0, 'Haggle'),
(1404100, 46, 32.701, 21.962217, -4.2973495, NULL, 0, 'Haggle - talking'),
(1404100, 47, 38.99483, 24.375648, -4.2973485, NULL, 0, 'Haggle - sifting through trash 9');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 14041;

DELETE FROM `smart_scripts` WHERE `entryorguid` = 14041 AND `source_type` = 0;
DELETE FROM `smart_scripts` WHERE `entryorguid` IN (1404100, 1404101, 1404102, 1404103, 1404104, 1404105) AND `source_type` = 9;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(14041, 0, 0, 0, 11, 0, 100, 0, 0, 0, 0, 0, 0, 0, 53, 0, 1404100, 1, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Haggle - On Respawn - Start waypoint'),
(14041, 0, 1, 0, 40, 0, 100, 0, 11, 0, 0, 0, 0, 0, 80, 1404100, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Haggle - On WP11 reached - Run Actionlist'),
(14041, 0, 2, 0, 40, 0, 100, 0, 13, 0, 0, 0, 0, 0, 80, 1404101, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Haggle - On WP13 reached - Run Actionlist'),
(14041, 0, 3, 0, 40, 0, 100, 0, 16, 0, 0, 0, 0, 0, 80, 1404102, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Haggle - On WP16 reached - Run Actionlist'),
(14041, 0, 4, 0, 40, 0, 100, 0, 18, 0, 0, 0, 0, 0, 80, 1404105, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Haggle - On WP18 reached - Run Actionlist'),
(14041, 0, 5, 0, 40, 0, 100, 0, 19, 0, 0, 0, 0, 0, 80, 1404105, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Haggle - On WP19 reached - Run Actionlist'),
(14041, 0, 6, 0, 40, 0, 100, 0, 23, 0, 0, 0, 0, 0, 80, 1404105, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Haggle - On WP23 reached - Run Actionlist'),
(14041, 0, 7, 0, 40, 0, 100, 0, 25, 0, 0, 0, 0, 0, 80, 1404105, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Haggle - On WP25 reached - Run Actionlist'),
(14041, 0, 8, 0, 40, 0, 100, 0, 26, 0, 0, 0, 0, 0, 80, 1404104, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Haggle - On WP26 reached - Run Actionlist'),
(14041, 0, 9, 0, 40, 0, 100, 0, 27, 0, 0, 0, 0, 0, 80, 1404103, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Haggle - On WP27 reached - Run Actionlist'),
(14041, 0, 10, 0, 40, 0, 100, 0, 37, 0, 0, 0, 0, 0, 80, 1404105, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Haggle - On WP37 reached - Run Actionlist'),
(14041, 0, 11, 0, 40, 0, 100, 0, 39, 0, 0, 0, 0, 0, 80, 1404105, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Haggle - On WP39 reached - Run Actionlist'),
(14041, 0, 12, 0, 40, 0, 100, 0, 41, 0, 0, 0, 0, 0, 80, 1404105, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Haggle - On WP41 reached - Run Actionlist'),
(14041, 0, 13, 0, 40, 0, 100, 0, 44, 0, 0, 0, 0, 0, 80, 1404105, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Haggle - On WP44 reached - Run Actionlist'),
(14041, 0, 14, 0, 40, 0, 100, 0, 47, 0, 0, 0, 0, 0, 80, 1404105, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Haggle - On WP47 reached - Run Actionlist'),
(1404100, 9, 0, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 54, 20000, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Haggle - On Script - Pause Waypoint 20 seconds'),
(1404100, 9, 1, 0, 0, 0, 100, 0, 1000, 1000, 0, 0, 0, 0, 89, 2, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Haggle - On Script - Random movement'),
(1404100, 9, 2, 0, 0, 0, 100, 0, 10000, 10000, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Haggle - On Script - Say random'),
(1404100, 9, 3, 0, 0, 0, 100, 0, 12000, 12000, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Haggle - On Script - Say emote 1'),
(1404101, 9, 0, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 54, 122000, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Haggle - On Script - Pause Waypoint 122 seconds'),
(1404101, 9, 1, 0, 0, 0, 100, 0, 500, 500, 0, 0, 0, 0, 66, 0, 0, 0, 0, 0, 0, 8, 0, 0, 0, 0, 0, 0, 0, 1.448623299598693847, 'Haggle - On On Script - Change orientation'),
(1404101, 9, 2, 0, 0, 0, 100, 0, 1000, 1000, 0, 0, 0, 0, 90, 3, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Haggle - On On Script - Set bytes1 - sleep'),
(1404101, 9, 3, 0, 0, 0, 100, 0, 121500, 121500, 0, 0, 0, 0, 91, 3, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Haggle - On Script- Remove bytes1 - sleep'),
(1404102, 9, 0, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 54, 45000, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Haggle - On Script - Pause Waypoint 45 seconds'),
(1404102, 9, 1, 0, 0, 0, 100, 0, 1000, 1000, 0, 0, 0, 0, 89, 2, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Haggle - On Script - Random movement'),
(1404103, 9, 0, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 54, 45000, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Haggle - On Script - Pause Waypoint 45 seconds'),
(1404103, 9, 1, 0, 0, 0, 100, 0, 1000, 1000, 0, 0, 0, 0, 89, 2, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Haggle - On Script - Random movement'),
(1404103, 9, 2, 0, 0, 0, 100, 0, 36000, 36000, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Haggle - On Script - Say random'),
(1404104, 9, 0, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 54, 16000, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Haggle - On Script - Pause Waypoint 16 seconds'),
(1404104, 9, 1, 0, 0, 0, 100, 0, 500, 500, 0, 0, 0, 0, 90, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Haggle - On On Script - Set bytes1 - sit'),
(1404104, 9, 2, 0, 0, 0, 100, 0, 15500, 15500, 0, 0, 0, 0, 91, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Haggle - On Script- Remove bytes1 - sit'),
(1404105, 9, 0, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 54, 3000, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Haggle - On Script - Pause Waypoint 3 seconds'),
(1404105, 9, 1, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 1, 2, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Haggle - On Script - Say emote 2');
