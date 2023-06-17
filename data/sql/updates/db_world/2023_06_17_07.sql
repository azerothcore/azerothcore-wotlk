-- DB update 2023_06_17_06 -> 2023_06_17_07
--
DELETE FROM `smart_scripts` WHERE `entryorguid`=173 AND `source_type`=2;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(173, 2, 0, 1, 46, 0, 100, 0, 0, 0, 0, 0, 0, 12, 2056, 3, 300000, 0, 0, 0, 8, 0, 0, 0, 0, 1077, 1539, 28.89, 0, 'Areatrigger - On Trigger - Summon Creature \'Ravenclaw Apparition\' (The Dead Fields)'),
(173, 2, 1, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 15, 437, 0, 0, 0, 0, 0, 16, 0, 0, 0, 0, 0, 0, 0, 0, 'Areatrigger - Linked - Quest Credit \'The Dead Fields\'');
