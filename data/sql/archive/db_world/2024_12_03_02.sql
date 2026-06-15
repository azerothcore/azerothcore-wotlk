-- DB update 2024_12_03_01 -> 2024_12_03_02
--
-- delete unused waypoint_data for swiftmane
DELETE FROM `waypoint_data` WHERE `id` = 204330;
-- set idle movement
UPDATE `creature_template` SET `MovementType` = 0 WHERE (`entry` = 5831);
UPDATE `creature` SET `MovementType` = 0 WHERE `guid` = 20433 AND `id1` = 5831;
-- defensive reactstate
DELETE FROM `smart_scripts` WHERE (`entryorguid` = 5831) AND (`source_type` = 0) AND (`id` = 1);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(5831, 0, 1, 0, 25, 0, 100, 512, 0, 0, 0, 0, 0, 0, 53, 1, 5831, 1, 0, 0, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Swiftmane - On Reset - Start Patrol Path 5831');
