--
-- Give quest credit on waypoint complete, change target to invoker
DELETE FROM `smart_scripts` WHERE (`entryorguid` = 2821700) AND (`source_type` = 9) AND (`id` IN (2));
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(2821700, 9, 2, 0, 0, 0, 100, 0, 1000, 1000, 0, 0, 0, 0, 53, 1, 28217, 0, 12570, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Injured Rainspeaker Oracle - Script - Start WP');

-- Delete quest credit cast
DELETE FROM `smart_scripts` WHERE (`entryorguid` = 2821701) AND (`source_type` = 9) AND (`id` IN (1));
-- Delete target storage
-- Update links
DELETE FROM `smart_scripts` WHERE (`entryorguid` = 28217) AND (`source_type` = 0) AND (`id` IN (8, 9, 10));
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(28217, 0, 8, 11, 62, 0, 100, 512, 9684, 0, 0, 0, 0, 0, 2, 774, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Injured Rainspeaker Oracle - On Gossip Option Select - Set Faction (Alliance)'),
(28217, 0, 9, 11, 62, 0, 100, 512, 9684, 0, 0, 0, 0, 0, 2, 775, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Injured Rainspeaker Oracle - On Gossip Option Select - Set Faction (Horde)');
