-- DB update 2026_05_04_01 -> 2026_05_05_00
--
DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = 3568);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(3568, 0, 1, 2, 19, 0, 100, 512, 938, 0, 0, 0, 0, 0, 29, 1, 1, 3519, 938, 1, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Mist - On Quest \'Mist\' Taken - Start Follow Invoker'),
(3568, 0, 2, 3, 61, 0, 100, 512, 0, 0, 0, 0, 0, 0, 83, 2, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Mist - On Quest \'Mist\' Taken - Remove Npc Flags Questgiver'),
(3568, 0, 3, 4, 61, 0, 100, 512, 0, 0, 0, 0, 0, 0, 19, 512, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Mist - On Quest \'Mist\' Taken - Remove Flags Immune To NPC\'s'),
(3568, 0, 4, 0, 61, 0, 100, 513, 0, 0, 0, 0, 0, 0, 8, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Mist - On Quest \'Mist\' Taken - Set Reactstate Defensive'),
(3568, 0, 5, 0, 6, 0, 100, 512, 0, 0, 0, 0, 0, 0, 70, 1000, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Mist - On Just Died - Respawn Self'),
(3568, 0, 6, 7, 11, 0, 100, 512, 0, 0, 0, 0, 0, 0, 18, 512, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Mist - On Respawn - Set Flags Immune To NPC\'s'),
(3568, 0, 7, 8, 61, 0, 100, 512, 0, 0, 0, 0, 0, 0, 81, 2, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Mist - On Respawn - Set Npc Flags Questgiver'),
(3568, 0, 8, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 8, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Mist - On Respawn - Set Reactstate Passive'),
(3568, 0, 9, 10, 65, 0, 100, 512, 0, 0, 0, 0, 0, 0, 70, 2000, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Mist - On Follow Complete - Respawn Self'),
(3568, 0, 10, 0, 61, 0, 100, 512, 0, 0, 0, 0, 0, 0, 1, 0, 1000, 0, 0, 0, 0, 19, 3519, 10, 0, 0, 0, 0, 0, 0, 'Mist - On Follow Complete - Say Line 0');
