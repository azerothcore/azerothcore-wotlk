-- DB update 2025_10_11_02 -> 2025_10_11_03
--
DELETE FROM `smart_scripts` WHERE (`entryorguid` = 780602) AND (`source_type` = 9) AND (`id` IN (5));
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(780602, 9, 5, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 26, 836, 0, 0, 0, 0, 0, 12, 1, 0, 0, 0, 0, 0, 0, 0, 'Homing Robot OOX-09/HL - Actionlist - Quest Credit \'Rescue OOX-09/HL!\'');

DELETE FROM `smart_scripts` WHERE (`entryorguid` = 780702) AND (`source_type` = 9) AND (`id` IN (6));
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(780702, 9, 6, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 26, 2767, 0, 0, 0, 0, 0, 12, 1, 0, 0, 0, 0, 0, 0, 0, 'Homing Robot OOX-22/FE - Actionlist - Quest Credit \'Rescue OOX-22/FE!\'');

DELETE FROM `smart_scripts` WHERE (`entryorguid` = 778402) AND (`source_type` = 9) AND (`id` IN (5));
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(778402, 9, 5, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 26, 648, 0, 0, 0, 0, 0, 12, 1, 0, 0, 0, 0, 0, 0, 0, 'Homing Robot OOX-17/TN - Actionlist - Quest Credit \'Rescue OOX-17/TN!\'');
