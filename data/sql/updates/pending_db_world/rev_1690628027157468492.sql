--
DELETE FROM `smart_scripts` WHERE (`entryorguid` = 18313) AND (`source_type` = 0) AND (`id` IN (2, 3, 6));
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(18313, 0, 2, 0, 0, 0, 100, 2, 0, 0, 10500, 10500, 0, 11, 15790, 64, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Ethereal Sorcerer - In Combat - Cast Arcane Missiles'),
(18313, 0, 3, 0, 0, 0, 100, 4, 0, 0, 10500, 10500, 0, 11, 22272, 64, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Ethereal Sorcerer - In Combat - Cast Arcane Missiles (Heroic)'),
(18313, 0, 6, 0, 0, 0, 100, 0, NULL, NULL, NULL, NULL, 0, 11, 32353, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Ethereal Sorcerer - In Combat - Cast Summon Arcane Fiend');


