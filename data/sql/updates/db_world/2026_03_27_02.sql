-- DB update 2026_03_27_01 -> 2026_03_27_02

-- Change row 3 event from ON_WAYPOINT_REACHED to ON_WAYPOINT_ENDED.
DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = -129210);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(-129210, 0, 2, 0, 11, 0, 100, 0, 0, 0, 0, 0, 0, 0, 232, 12921000, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Havenshire Stallion - On Respawn - Start Path 12921000'),
(-129210, 0, 3, 4, 109, 0, 100, 0, 0, 12921000, 0, 0, 0, 0, 234, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Havenshire Stallion - On Path 12921000 Finished - Stop Movement'),
(-129210, 0, 4, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 80, 2860500, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Havenshire Stallion - On Path 12921000 Finished - Run Script');
