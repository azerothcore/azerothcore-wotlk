-- DB update 2026_10_08_00 -> 2026_10_09_00
--
SET @NATASHA := 22465;
UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = @NATASHA;
DELETE FROM `smart_scripts` WHERE `entryorguid` = @NATASHA AND `source_type` = 0;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(@NATASHA, 0, 0, 0, 1, 0, 100, 0, 60000, 120000, 60000, 120000, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Natasha - Out of Combat - Say Line 0');

DELETE FROM `creature_text` WHERE `CreatureID` = @NATASHA;
INSERT INTO `creature_text` (`CreatureID`, `GroupID`, `ID`, `Text`, `Type`, `Language`, `Probability`, `Emote`, `Duration`, `Sound`, `BroadcastTextId`, `TextRange`, `comment`) VALUES
(@NATASHA, 0, 0, 'I''m only 4 years old.', 12, 0, 100, 0, 0, 0, 20353, 0, 'Natasha'),
(@NATASHA, 0, 1, 'Have you seen my mommy and daddy?', 12, 0, 100, 0, 0, 0, 20355, 0, 'Natasha'),
(@NATASHA, 0, 2, 'Antelarion, is it safe to play in the forest yet?', 12, 0, 100, 6, 0, 0, 20357, 0, 'Natasha'),
(@NATASHA, 0, 3, 'I think I came from Eng-land, do you know where that is?', 12, 0, 100, 5, 0, 0, 20358, 0, 'Natasha'),
(@NATASHA, 0, 4, 'Antelarion says I fell off a big bird, as I fell he caught me... He is so pretty!', 12, 0, 100, 0, 0, 0, 20360, 0, 'Natasha');

SET @ANTELARION := 77716;
SET @PATH := @ANTELARION * 10;
UPDATE `creature` SET `wander_distance` = 0, `currentwaypoint` = 0, `MovementType` = 2 WHERE `guid` = @ANTELARION AND `id` = 22127;
DELETE FROM `creature_addon` WHERE `guid` = @ANTELARION;
INSERT INTO `creature_addon` (`guid`, `path_id`, `mount`, `bytes1`, `bytes2`, `emote`, `visibilityDistanceType`, `auras`) VALUES
(@ANTELARION, @PATH, 0, 0, 1, 0, 0, NULL);
DELETE FROM `waypoint_data` WHERE `id` = @PATH;
INSERT INTO `waypoint_data` (`id`, `point`, `position_x`, `position_y`, `position_z`, `orientation`, `delay`) VALUES
(@PATH, 1, 2965.87, 5451.4, 144.6, NULL, 0),
(@PATH, 2, 2989.8, 5444.5, 144.755, NULL, 0),
(@PATH, 3, 3012.29, 5452.81, 145.825, NULL, 0),
(@PATH, 4, 3024.48, 5468.78, 146.622, NULL, 0),
(@PATH, 5, 3025.23, 5486.21, 146.245, NULL, 0),
(@PATH, 6, 3015.91, 5508.87, 145.675, NULL, 0),
(@PATH, 7, 2993.65, 5520.81, 147.527, NULL, 0),
(@PATH, 8, 2964.14, 5506.05, 143.722, NULL, 0),
(@PATH, 9, 2954.42, 5477.45, 143.748, NULL, 0);

DELETE FROM `creature_formations` WHERE `leaderGUID` = @ANTELARION;
INSERT INTO `creature_formations` (`leaderGUID`, `memberGUID`, `dist`, `angle`, `groupAI`, `point_1`, `point_2`) VALUES
(@ANTELARION, @ANTELARION, 0, 0, 512, 0, 0),
(@ANTELARION, 78841, 3, 194, 512, 0, 0);
