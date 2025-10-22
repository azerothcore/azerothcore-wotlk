-- DB update 2025_09_20_05 -> 2025_09_20_06
--
DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = 26321);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(26321, 0, 0, 1, 8, 0, 100, 512, 47530, 0, 0, 0, 0, 0, 33, 26321, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Lothalor Ancient - On Spellhit \'Bark of the Walkers\' - Quest Credit \'null\''),
(26321, 0, 1, 2, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Lothalor Ancient - On Spellhit \'Bark of the Walkers\' - Say Line 0'),
(26321, 0, 2, 3, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 28, 47044, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Lothalor Ancient - On Spellhit \'Bark of the Walkers\' - Remove Aura \'Cosmetic - Confused State Visual (Big)\''),
(26321, 0, 3, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 41, 4000, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Lothalor Ancient - On Spellhit \'Bark of the Walkers\' - Despawn In 4000 ms');

DELETE FROM `spell_script_names` WHERE `ScriptName` = 'spell_q12096_q12092_bark';
