-- DB update 2025_10_01_02 -> 2025_10_02_00
--
DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = 31157);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(31157, 0, 0, 0, 27, 0, 100, 512, 0, 0, 0, 0, 0, 0, 53, 0, 31157, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Skeletal Assault Gryphon - On Passenger Boarded - Start Waypoint Path 31157'),
(31157, 0, 1, 0, 40, 0, 100, 512, 35, 31157, 0, 0, 0, 0, 11, 50630, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Skeletal Assault Gryphon - On Point 35 of Path 31157 Reached - Cast \'Eject All Passengers\'');
