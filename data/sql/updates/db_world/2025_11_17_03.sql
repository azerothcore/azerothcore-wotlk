-- DB update 2025_11_17_02 -> 2025_11_17_03
--
DELETE FROM `smart_scripts` WHERE (`entryorguid` = 26814) AND (`source_type` = 0) AND (`id` IN (2, 4, 21, 32));
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(26814, 0, 2, 32, 61, 0, 100, 512, 0, 0, 0, 0, 0, 0, 71, 0, 3, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Harrison Jones - On Respawn - Change Equipment'),
(26814, 0, 4, 21, 61, 0, 100, 512, 0, 0, 0, 0, 0, 0, 64, 1, 0, 0, 0, 0, 0, 16, 0, 0, 0, 0, 0, 0, 0, 0, 'Harrison Jones - On Quest \'Dun-da-Dun-tah!\' Taken - Store Targetlist'),
(26814, 0, 21, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 83, 2, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Harrison Jones - On Quest \'Dun-da-Dun-tah!\' Taken - Remove Npc Flags Questgiver'),
(26814, 0, 32, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 82, 2, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Harrison Jones - On Respawn - Add Npc Flags Questgiver');
