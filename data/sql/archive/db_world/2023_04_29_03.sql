-- DB update 2023_04_29_02 -> 2023_04_29_03
--
DELETE FROM `waypoints` WHERE `entry` = 1728000;
INSERT INTO `waypoints` (`entry`, `pointid`, `position_x`, `position_y`, `position_z`, `orientation`, `point_comment`) VALUES 
(1728000,1,-1273.8602,1493.8004,68.55935,NULL,'Shattered Hand Warhound - Decomposed'), -- Decomposed
(1728000,2,-1279.3286,1497.2529,68.56155,NULL,'Shattered Hand Warhound'),
(1728000,3,-1290.9882,1513.8473,68.57747,NULL,'Shattered Hand Warhound'),
(1728000,4,-1293.7421,1531.0709,68.577995,NULL,'Shattered Hand Warhound');

DELETE FROM `smart_scripts` WHERE (`entryorguid` = 17455) AND (`source_type` = 0) AND (`id` IN (3, 4, 5, 6));
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(17455, 0, 3, 4, 0, 0, 100, 1, 25000, 25000, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Bonechewer Beastmaster - In Combat - Say Text'),
(17455, 0, 4, 5, 61, 0, 100, 0, 0, 0, 0, 0, 0, 12, 17280, 4, 60000, 0, 0, 0, 8, 0, 0, 0, 0, -1256.9419, 1483.1189, 68.57015, 2.578432559967041015, 'Bonechewer Beastmaster - In Combat - Summon Creature'),
(17455, 0, 5, 6, 61, 0, 100, 0, 0, 0, 0, 0, 0, 12, 17280, 4, 60000, 0, 0, 0, 8, 0, 0, 0, 0, -1256.0056, 1477.52, 68.560974, 2.30606842041015625, 'Bonechewer Beastmaster - In Combat - Summon Creature'),
(17455, 0, 6, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 12, 17280, 4, 60000, 0, 0, 0, 8, 0, 0, 0, 0, -1257.537, 1474.4856, 68.56642, 1.780675649642944335, 'Bonechewer Beastmaster - In Combat - Summon Creature');

DELETE FROM `smart_scripts` WHERE (`entryorguid` = 17280) AND (`source_type` = 0) AND (`id` IN (2, 3));
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(17280, 0, 2, 0, 54, 0, 100, 0, 0, 0, 0, 0, 0, 53, 1, 1728000, 0, 0, 0, 2, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Shattered Hand Warhound - On Just Summoned - Start Waypoint'),
(17280, 0, 3, 0, 58, 0, 100, 0, 4, 1728000, 0, 0, 0, 38, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Shattered Hand Warhound - On Waypoint Finished - Set In Combat With Zone');

UPDATE `creature_template` SET `flags_extra` = `flags_extra`&~33554432 WHERE (`entry` IN (17280, 18059));
