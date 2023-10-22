-- DB update 2023_03_24_02 -> 2023_03_24_03
-- Mosh'Ogg Spellcrafter
DELETE FROM `smart_scripts` WHERE `source_type` = 0 AND `entryorguid` = 710;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(710, 0, 0, 0, 4, 0, 15, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Mosh\'Ogg Spellcrafter - On Aggro - Say Line 0'),
(710, 0, 1, 0, 23, 0, 100, 0, 12544, 0, 10000, 10000, 0, 11, 12544, 64, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Mosh\'Ogg Spellcrafter - On Aura \'Frost Armor\' Missing - Cast \'Frost Armor\''),
(710, 0, 2, 0, 0, 0, 100, 0, 0, 0, 3400, 4800, 0, 11, 9053, 64, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Mosh\'Ogg Spellcrafter - In Combat - Cast \'Fireball\''),
(710, 0, 3, 0, 0, 0, 100, 0, 5000, 9000, 12000, 15000, 0, 11, 11829, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Mosh\'Ogg Spellcrafter - In Combat - Cast \'Flamestrike\'');
