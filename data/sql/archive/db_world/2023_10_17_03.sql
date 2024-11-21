-- DB update 2023_10_17_02 -> 2023_10_17_03
-- Eridan Bluewind
DELETE FROM `smart_scripts` WHERE (`source_type` = 9 AND `entryorguid` = 911600);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(911600, 9, 0, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 83, 3, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Eridan Bluewind - On Script - Remove Npc Flags Gossip & Questgiver'),
(911600, 9, 1, 0, 0, 0, 100, 0, 1000, 1000, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Eridan Bluewind - On Script - Say Line 0'),
(911600, 9, 2, 0, 0, 0, 100, 0, 1000, 1000, 0, 0, 0, 0, 66, 0, 0, 0, 0, 0, 0, 8, 0, 0, 0, 0, 0, 0, 0, 2.59669, 'Eridan Bluewind - On Script - Set Orientation 2,59669'),
(911600, 9, 3, 0, 0, 0, 100, 0, 1000, 1000, 0, 0, 0, 0, 11, 28892, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Eridan Bluewind - On Script - Cast \'Nature Channeling\''),
(911600, 9, 4, 0, 0, 0, 100, 0, 5000, 5000, 0, 0, 0, 0, 66, 0, 0, 0, 0, 0, 0, 8, 0, 0, 0, 0, 0, 0, 0, 2.72271, 'Eridan Bluewind - On Script - Set Orientation 2,72271'),
(911600, 9, 5, 0, 0, 0, 100, 0, 1000, 1000, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Eridan Bluewind - On Script - Say Line 1'),
(911600, 9, 6, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 28, 28892, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Eridan Bluewind - On Script - Remove Aura \'Nature Channeling\''),
(911600, 9, 7, 0, 0, 0, 100, 0, 1000, 1000, 0, 0, 0, 0, 82, 3, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Eridan Bluewind - On Script - Add Npc Flags Gossip & Questgiver');
