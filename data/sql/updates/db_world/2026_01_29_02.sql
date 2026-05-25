-- DB update 2026_01_29_01 -> 2026_01_29_02
--
DELETE FROM `smart_scripts` WHERE (`entryorguid` = 2895202) AND (`source_type` = 9) AND (`id` IN (5));
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(2895202, 9, 5, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 48, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Akali - Quest Reset Script - Set Active Off');

DELETE FROM `smart_scripts` WHERE (`source_type` = 9 AND `entryorguid` = 2895200);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(2895200, 9, 0, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 48, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Akali - Quest Success Script - Set Active On'),
(2895200, 9, 1, 0, 0, 0, 100, 0, 2000, 2000, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Akali - Quest Success Script - Say Line 0'),
(2895200, 9, 2, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 15, 12721, 0, 0, 0, 0, 0, 18, 60, 0, 0, 0, 0, 0, 0, 0, 'Akali - Quest Success Script - Quest Credit \'Rampage\''),
(2895200, 9, 3, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 107, 1, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Akali - Quest Success Script - Summon Creature Group 1'),
(2895200, 9, 4, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 92, 0, 45579, 0, 0, 0, 0, 9, 28988, 0, 100, 0, 0, 0, 0, 0, 'Akali - Actionlist - Interrupt Spell \'Fire Channeling\''),
(2895200, 9, 5, 0, 0, 0, 100, 0, 4600, 4600, 0, 0, 0, 0, 19, 768, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Akali - Quest Success Script - Remove Flag Immune To NPC\'s'),
(2895200, 9, 6, 0, 0, 0, 100, 0, 55000, 55000, 0, 0, 0, 0, 12, 28996, 8, 0, 0, 0, 0, 8, 0, 0, 0, 0, 6882.03, -4571, 442.312, 2.37365, 'Akali - Quest Success Script - Summon Creature \'Prophet of Akali\'');

DELETE FROM `smart_scripts` WHERE (`entryorguid` = 28996) AND (`source_type` = 0) AND (`id` IN (7));
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(28996, 0, 7, 0, 37, 0, 100, 0, 0, 0, 0, 0, 0, 0, 48, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Prophet of Akali - On Initialize - Set Active On');
