-- DB update 2025_09_09_02 -> 2025_09_09_03
--
DELETE FROM `spell_script_names` WHERE `spell_id`=48297;
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES (48297, 'spell_handover_reins');

DELETE FROM `vehicle_seat_addon` WHERE `SeatEntry`=742;
INSERT INTO `vehicle_seat_addon` (`SeatEntry`, `SeatOrientation`, `ExitParamX`, `ExitParamY`, `ExitParamZ`, `ExitParamO`, `ExitParamValue`) VALUES
(742, 0, 0, -2, 0, 0, 1);

-- Set Phase from 5 to 1 for id 2
-- Generate comments with Keira
DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = 27213);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(27213, 0, 0, 1, 11, 0, 100, 512, 0, 0, 0, 0, 0, 0, 211, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Onslaught Warhorse - On Respawn - Flag reset 0'),
(27213, 0, 1, 0, 61, 0, 100, 512, 0, 0, 0, 0, 0, 0, 22, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Onslaught Warhorse - On Respawn - Set Event Phase 1'),
(27213, 0, 2, 3, 28, 1, 100, 512, 0, 0, 0, 0, 0, 0, 22, 2, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Onslaught Warhorse - On Passenger Removed - Set Event Phase 2 (Phase 1)'),
(27213, 0, 3, 4, 61, 2, 100, 512, 0, 0, 0, 0, 0, 0, 101, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Onslaught Warhorse - On Passenger Removed - Set Home Position (Phase 1)'),
(27213, 0, 4, 5, 61, 2, 100, 512, 0, 0, 0, 0, 0, 0, 2, 35, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Onslaught Warhorse - On Passenger Removed - Set Faction 35 (Phase 1)'),
(27213, 0, 5, 6, 61, 2, 100, 512, 0, 0, 0, 0, 0, 0, 18, 131072, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Onslaught Warhorse - On Passenger Removed - Set Flags Pacified (Phase 1)'),
(27213, 0, 6, 0, 61, 2, 100, 512, 0, 0, 0, 0, 0, 0, 80, 2721300, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Onslaught Warhorse - On Passenger Removed - Run Script (Phase 1)'),
(27213, 0, 7, 0, 59, 2, 100, 512, 1, 0, 0, 0, 0, 0, 41, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Onslaught Warhorse - On Timed Event 1 Triggered - Despawn Instant (Phase 2)'),
(27213, 0, 8, 9, 23, 2, 100, 512, 48290, 1, 500, 500, 0, 0, 74, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Onslaught Warhorse - On Aura \'Onslaught Riding Crop\' - Remove Timed Event 1 (Phase 2)'),
(27213, 0, 9, 0, 61, 2, 100, 512, 0, 0, 0, 0, 0, 0, 22, 3, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Onslaught Warhorse - On Aura \'Onslaught Riding Crop\' - Set Event Phase 3 (Phase 2)'),
(27213, 0, 10, 11, 31, 4, 100, 513, 48297, 0, 0, 0, 0, 0, 22, 4, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Onslaught Warhorse - On Target Spellhit \'Hand Over Reins\' - Set Event Phase 4 (Phase 3) (No Repeat)'),
(27213, 0, 11, 0, 61, 8, 100, 512, 0, 0, 0, 0, 0, 0, 80, 2721301, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Onslaught Warhorse - On Target Spellhit \'Hand Over Reins\' - Run Script (Phase 3) (No Repeat)');
