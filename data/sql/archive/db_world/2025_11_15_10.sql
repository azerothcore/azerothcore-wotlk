-- DB update 2025_11_15_09 -> 2025_11_15_10
--
DELETE FROM `spell_linked_spell` WHERE `spell_trigger` = 54076;
INSERT INTO `spell_linked_spell` (`spell_trigger`, `spell_effect`, `type`, `comment`) VALUES
(54076, 49511, 0, 'Taxi validate - Gryphon to Star Rest');

DELETE FROM `smart_scripts` WHERE (`entryorguid` = 26878) AND (`source_type` = 0) AND (`id` IN (3));
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(26878, 0, 3, 0, 19, 0, 100, 0, 12440, 0, 0, 0, 0, 0, 11, 54076, 2, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Rodney Wells - On Quest \'To Stars\' Rest!\' Taken - Cast \'Taxi to Stars` Rest Validate\'');
