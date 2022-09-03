--
-- Remove setting react state 2. Set react state when waypoint starts to 1
DELETE FROM `smart_scripts` WHERE (`entryorguid` = 488000) AND (`source_type` = 9) AND (`id` IN (3,5));
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(488000, 9, 5, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 53, 0, 4880, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, '"Stinky" Ignatz - Script - Start WP');
-- Update talk target to victim for line 10
DELETE FROM `smart_scripts` WHERE (`entryorguid` = 4880) AND (`source_type` = 0) AND (`id` IN (26));
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(4880, 0, 26, 0, 0, 0, 100, 0, 1000, 1000, 30000, 30000, 0, 1, 10, 0, 1, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, '"Stinky" Ignatz - IC  - Say Line 10');
-- Disable assist player
UPDATE `creature_template` SET `type_flags` = `type_flags`&~4096 WHERE (`entry` = 4880);
