--
DELETE FROM `smart_scripts` WHERE `entryorguid` = 488000 AND `source_type` = 9;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(488000, 9, 0, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 81, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, '"Stinky" Ignatz - Script - Set NPC Flags'),
(488000, 9, 1, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 2, 250, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, '"Stinky" Ignatz - Script - Set Faction'),
(488000, 9, 2, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 91, 8, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, '"Stinky" Ignatz - Script - Set Bytes 1'),
(488000, 9, 3, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, '"Stinky" Ignatz - Script - Say Line 0'),
(488000, 9, 4, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 53, 0, 4880, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, '"Stinky" Ignatz - Script - Start WP');
