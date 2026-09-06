-- DB update 2025_11_28_02 -> 2025_11_28_03
--
DELETE FROM `smart_scripts` WHERE (`entryorguid` = 18636) AND (`source_type` = 0) AND (`id` IN (1, 2, 3, 4));
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(18636, 0, 1, 0, 10, 0, 100, 1, 0, 8, 4000, 8000, 0, 0, 11, 30986, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Cabal Assassin - Out of Combat LoS - Cast \'Cheap Shot\''),
(18636, 0, 2, 0, 67, 0, 100, 0, 5000, 7000, 4500, 6500, 0, 5, 11, 30992, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Cabal Assassin - On Behind Target - Cast \'Backstab\''),
(18636, 0, 3, 0, 0, 0, 100, 0, 2000, 4500, 12000, 20000, 0, 0, 11, 30981, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Cabal Assassin - In Combat - Cast \'Crippling Poison\''),
(18636, 0, 4, 0, 0, 0, 100, 0, 8000, 11000, 22000, 25000, 0, 0, 11, 36974, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Cabal Assassin - In Combat - Cast \'Wound Poison\'');
