-- Ulduar: Mechanostriker 54-A templates, movement, pilot, and SmartAI
UPDATE `creature_template` SET `unit_flags` = 0, `AIName` = 'SmartAI', `ScriptName` = '', `VerifiedBuild` = 49822 WHERE `entry` = 34161;
UPDATE `creature_template` SET `unit_flags` = 0, `ScriptName` = '', `VerifiedBuild` = 48120 WHERE `entry` = 34162;

DELETE FROM `creature_template_movement` WHERE `CreatureId` IN (34161, 34162);
INSERT INTO `creature_template_movement` (`CreatureId`, `Ground`, `Swim`, `Flight`, `Rooted`, `Chase`, `Random`, `InteractionPauseTimer`) VALUES
(34161, 1, 0, 1, 0, 0, 0, NULL),
(34162, 1, 0, 1, 0, 0, 0, NULL);

DELETE FROM `creature_template_addon` WHERE `entry` IN (34161, 34162);
INSERT INTO `creature_template_addon` (`entry`, `path_id`, `mount`, `bytes1`, `bytes2`, `emote`, `visibilityDistanceType`, `auras`) VALUES
(34161, 0, 0, 50331648, 1, 0, 4, NULL),
(34162, 0, 0, 50331648, 1, 0, 4, NULL);

DELETE FROM `vehicle_template_accessory` WHERE `entry` IN (34161, 34162);
INSERT INTO `vehicle_template_accessory` (`entry`, `accessory_entry`, `seat_id`, `minion`, `description`, `summontype`, `summontimer`) VALUES
(34161, 33216, 0, 1, 'Mechanostriker 54-A - Mechagnome Pilot', 6, 30000),
(34162, 33216, 0, 1, 'Mechanostriker 54-A (1) - Mechagnome Pilot', 6, 30000);

-- Four sniffed packs, map 603 as summoner, leader first in each group
DELETE FROM `creature_summon_groups` WHERE `summonerId` = 603 AND `summonerType` = 2 AND `groupId` BETWEEN 8 AND 11;
INSERT INTO `creature_summon_groups` (`summonerId`, `summonerType`, `groupId`, `entry`, `position_x`, `position_y`, `position_z`, `orientation`, `summonType`, `summonTime`, `Comment`) VALUES
(603, 2, 8, 34161, -146.3554, 88.5399, 496.1797, 0.351635, 6, 3000, 'Mechanostriker 54-A - NW pack leader'),
(603, 2, 8, 34161, -154.0394, 92.1424, 495.0816, 4.7473, 6, 3000, 'Mechanostriker 54-A - NW pack follower 1'),
(603, 2, 8, 34161, -163.4960, 97.3559, 495.0816, 4.7473, 6, 3000, 'Mechanostriker 54-A - NW pack follower 2'),
(603, 2, 8, 34161, -138.6262, 96.0590, 495.0816, 4.7473, 6, 3000, 'Mechanostriker 54-A - NW pack follower 3'),
(603, 2, 8, 34161, -163.5845, 103.8819, 495.0816, 4.7473, 6, 3000, 'Mechanostriker 54-A - NW pack follower 4'),
(603, 2, 9, 34161, -315.9132, -249.9236, 464.6798, 0.999613, 6, 3000, 'Mechanostriker 54-A - SW pack leader'),
(603, 2, 9, 34161, -307.5799, -251.5295, 464.6798, 1.48353, 6, 3000, 'Mechanostriker 54-A - SW pack follower 1'),
(603, 2, 9, 34161, -297.1320, -254.2622, 464.6798, 1.6057, 6, 3000, 'Mechanostriker 54-A - SW pack follower 2'),
(603, 2, 9, 34161, -321.5590, -259.1111, 464.6798, 1.36136, 6, 3000, 'Mechanostriker 54-A - SW pack follower 3'),
(603, 2, 9, 34161, -295.4445, -260.5660, 464.6798, 1.6057, 6, 3000, 'Mechanostriker 54-A - SW pack follower 4'),
(603, 2, 10, 34161, 125.4236, 151.8278, 477.8963, 4.5346, 6, 3000, 'Mechanostriker 54-A - NE pack leader'),
(603, 2, 10, 34161, 117.7396, 155.4302, 477.8963, 4.7473, 6, 3000, 'Mechanostriker 54-A - NE pack follower 1'),
(603, 2, 10, 34161, 108.2830, 160.6438, 477.8963, 4.7473, 6, 3000, 'Mechanostriker 54-A - NE pack follower 2'),
(603, 2, 10, 34161, 133.1528, 159.3469, 477.8963, 4.7473, 6, 3000, 'Mechanostriker 54-A - NE pack follower 3'),
(603, 2, 10, 34161, 108.1944, 167.1698, 478.3961, 4.7473, 6, 3000, 'Mechanostriker 54-A - NE pack follower 4'),
(603, 2, 11, 34161, 63.0984, -226.8327, 437.0335, 1.30216, 6, 3000, 'Mechanostriker 54-A - SE pack leader'),
(603, 2, 11, 34161, 71.4317, -228.4386, 437.0407, 1.48353, 6, 3000, 'Mechanostriker 54-A - SE pack follower 1'),
(603, 2, 11, 34161, 81.8797, -231.1712, 437.0561, 1.6057, 6, 3000, 'Mechanostriker 54-A - SE pack follower 2'),
(603, 2, 11, 34161, 57.4526, -236.0202, 436.3434, 1.36136, 6, 3000, 'Mechanostriker 54-A - SE pack follower 3'),
(603, 2, 11, 34161, 83.5672, -237.4751, 436.1480, 1.6057, 6, 3000, 'Mechanostriker 54-A - SE pack follower 4');

-- Sniffed approach paths and the two captured western patrol loops
DELETE FROM `waypoint_data` WHERE `id` BETWEEN 341610 AND 341615;
INSERT INTO `waypoint_data` (`id`, `point`, `position_x`, `position_y`, `position_z`, `orientation`, `delay`, `smoothTransition`, `move_type`) VALUES
(341610, 1, -119.9108, 98.2420, 473.6217, NULL, 0, 1, 1),
(341610, 2, -159.6661, 26.5279, 462.5106, NULL, 0, 1, 1),
(341610, 3, -181.9548, 9.4048, 446.4273, NULL, 0, 1, 1),
(341610, 4, -204.8537, -2.2457, 449.1495, NULL, 0, 1, 1),
(341611, 1, -274.6202, -185.6683, 448.9162, NULL, 0, 1, 1),
(341611, 2, -264.4347, -166.8024, 446.0549, NULL, 0, 1, 1),
(341611, 3, -259.3202, -160.8745, 439.4439, NULL, 0, 1, 1),
(341611, 4, -279.2880, -127.6567, 435.1940, NULL, 0, 1, 1),
(341612, 1, 117.9948, 110.4852, 432.6256, NULL, 0, 1, 1),
(341612, 2, 119.1622, 67.0719, 432.6256, NULL, 0, 1, 1),
(341612, 3, 116.7926, 50.5963, 432.6256, NULL, 0, 1, 1),
(341612, 4, 90.7609, 39.9976, 432.6256, NULL, 0, 1, 1),
(341613, 1, 71.5712, -196.0553, 428.4298, NULL, 0, 1, 1),
(341613, 2, 76.4708, -164.1741, 428.4298, NULL, 0, 1, 1),
(341613, 3, 65.6607, -115.4833, 428.4298, NULL, 0, 1, 1),
(341613, 4, 58.9876, -108.4142, 428.4298, NULL, 0, 1, 1),
(341614, 1, -184.1136, -4.4610, 440.8869, NULL, 0, 1, 1),
(341614, 2, -122.7737, -0.9856, 440.8869, NULL, 0, 1, 1),
(341614, 3, -81.8279, -5.9144, 440.8869, NULL, 0, 1, 1),
(341614, 4, -87.1018, -58.6003, 440.8869, NULL, 0, 1, 1),
(341614, 5, -146.4584, -63.6573, 440.8869, NULL, 0, 1, 1),
(341614, 6, -163.9723, -46.4980, 440.8869, NULL, 0, 1, 1),
(341614, 7, -183.5796, -14.1416, 440.8869, NULL, 0, 1, 1),
(341615, 1, -277.7353, -108.7474, 431.0258, NULL, 0, 1, 1),
(341615, 2, -269.9046, -92.5296, 431.0258, NULL, 0, 1, 1),
(341615, 3, -296.7220, -76.3487, 431.0258, NULL, 0, 1, 1),
(341615, 4, -352.6099, -43.0742, 431.0258, NULL, 0, 1, 1),
(341615, 5, -363.2538, -39.3188, 431.0258, NULL, 0, 1, 1),
(341615, 6, -389.8955, -62.2886, 431.0258, NULL, 0, 1, 1),
(341615, 7, -413.9243, -102.9878, 431.0258, NULL, 0, 1, 1),
(341615, 8, -384.7040, -142.1766, 431.0258, NULL, 0, 1, 1),
(341615, 9, -318.4682, -110.9799, 431.0258, NULL, 0, 1, 1),
(341615, 10, -296.6186, -117.9092, 431.0258, NULL, 0, 1, 1);

DELETE FROM `areatrigger_scripts` WHERE `entry` IN (5416, 5417, 5428, 5442);
INSERT INTO `areatrigger_scripts` (`entry`, `ScriptName`) VALUES
(5428, 'at_ulduar_mechanostriker_spawn'),
(5442, 'at_ulduar_mechanostriker_spawn');

DELETE FROM `smart_scripts` WHERE `entryorguid` = 34161 AND `source_type` = 0;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(34161, 0, 0, 0, 0, 0, 100, 0, 0, 0, 2000, 2000, 0, 0, 11, 64766, 64, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Mechanostriker 54-A - In Combat - Cast Laser Barrage'),
(34161, 0, 1, 0, 6, 0, 100, 0, 0, 0, 0, 0, 0, 0, 11, 62987, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Mechanostriker 54-A - On Just Died - Cast Explosion'),
(34161, 0, 2, 0, 109, 0, 100, 0, 0, 341610, 0, 0, 0, 0, 232, 341614, 1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Mechanostriker 54-A - On Path 341610 Finished - Start Path 341614'),
(34161, 0, 3, 0, 109, 0, 100, 0, 0, 341611, 0, 0, 0, 0, 232, 341615, 1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Mechanostriker 54-A - On Path 341611 Finished - Start Path 341615'),
(34161, 0, 4, 5, 109, 0, 100, 0, 0, 0, 0, 0, 0, 0, 49, 0, 0, 0, 0, 0, 0, 21, 400, 0, 0, 0, 0, 0, 0, 0, 'Mechanostriker 54-A - On Path Finished - Start Attacking Closest Player'),
(34161, 0, 5, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 39, 30, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Mechanostriker 54-A - On Link - Call For Help');
