-- DB update 2022_08_29_00 -> 2022_08_30_00
--
-- Values not sniffed sadly
SET @NPC := 15571;
SET @PATH := @NPC * 10;
DELETE FROM `waypoints` WHERE `entry` = @PATH;
INSERT INTO `waypoints` (`entry`, `pointid`, `position_x`, `position_y`, `position_z`, `orientation`, `delay`) VALUES
(@PATH, 1, 3515.252197, -6675.288574, -7.512211, 0.581226, 0),
(@PATH, 2, 3551.346924, -6657.919434, -7.512211, 0.757155, 0),
(@PATH, 3, 3559.359863, -6599.407715, -7.384412, 2.317742, 0),
(@PATH, 4, 3519.906494, -6565.796875, -7.902094, 3.253937, 0),
(@PATH, 5, 3475.263428, -6586.950195, -7.407309, 4.410028, 0),
(@PATH, 6, 3475.084229, -6638.404785, -7.548372, 6.224278, 0),
(@PATH, 7, 3527.448975, -6642.081055, -7.449833, 1.806412, 0),
(@PATH, 8, 3519.724854, -6624.312988, -5.555761, 2.065593, 0);

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 15571;
DELETE FROM `smart_scripts` WHERE (`entryorguid` = 15571) AND (`source_type` = 0) AND (`id` IN (0));
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(15571, 0, 0, 0, 25, 0, 100, 1, 0, 0, 0, 0, 0, 53, 1, 155710, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Maws - On Reset - Start Waypoint (No Repeat)');

-- it is a long fish, without this the hitbox is inside its stomach
UPDATE `creature_model_info` SET `CombatReach` = 8 WHERE `DisplayID` = 15555;
