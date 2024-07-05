-- DB update 2023_03_15_06 -> 2023_03_15_07
--
DELETE FROM `smart_scripts` WHERE (`entryorguid` = 18551200) AND (`source_type` = 9) AND (`id` IN (0, 1));
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(18551200, 9, 0, 0, 0, 0, 100, 0, 2400, 2400, 0, 0, 0, 12, 22920, 1, 300000, 0, 1, 0, 8, 0, 0, 0, 0, 3989.02, 6071.37, 266.41, 3.72, 'Stasis Chamber Alpha - On Script - Summon Creature \'Thuk the Defiant\''),
(18551200, 9, 1, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 41, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Stasis Chamber Alpha - On Script - Despawn Self');
