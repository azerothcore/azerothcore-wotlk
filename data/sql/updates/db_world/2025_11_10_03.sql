-- DB update 2025_11_10_02 -> 2025_11_10_03
--
-- Increase grid searches to 60 from 40
DELETE FROM `smart_scripts` WHERE (`entryorguid` = 2572900) AND (`source_type` = 9) AND (`id` IN (2, 5));
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(2572900, 9, 2, 0, 0, 0, 100, 0, 8000, 8000, 0, 0, 0, 0, 1, 7, 0, 0, 0, 0, 0, 19, 25749, 60, 0, 0, 0, 0, 0, 0, 'Shadowstalker Getry - Actionlist - Say Line 7'),
(2572900, 9, 5, 0, 0, 0, 100, 0, 3000, 3000, 0, 0, 0, 0, 41, 0, 0, 0, 0, 0, 0, 19, 25749, 60, 0, 0, 0, 0, 0, 0, 'Shadowstalker Getry - Actionlist - Despawn Instant');
DELETE FROM `smart_scripts` WHERE (`entryorguid` = 25618) AND (`source_type` = 0) AND (`id` IN (3, 4));
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(25618, 0, 3, 4, 6, 0, 100, 512, 0, 0, 0, 0, 0, 0, 15, 11705, 0, 0, 0, 0, 0, 18, 60, 0, 0, 0, 0, 0, 0, 0, 'Varidus the Flenser - On Just Died - Quest Credit \'Foolish Endeavors\''),
(25618, 0, 4, 0, 61, 0, 100, 512, 0, 0, 0, 0, 0, 0, 45, 1, 1, 0, 0, 0, 0, 19, 25729, 60, 0, 0, 0, 0, 0, 0, 'Varidus the Flenser - On Just Died - Set Data 1 1');
--  Increase despawn time from 3 to 4 minutes
DELETE FROM `smart_scripts` WHERE (`entryorguid` = 2561800) AND (`source_type` = 9) AND (`id` IN (25));
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(2561800, 9, 25, 0, 0, 0, 100, 0, 240000, 240000, 0, 0, 0, 0, 41, 0, 0, 0, 0, 0, 0, 19, 25729, 100, 0, 0, 0, 0, 0, 0, 'Varidus the Flenser - Actionlist - Despawn Instant');
