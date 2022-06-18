-- DB update 2022_06_16_07 -> 2022_06_18_00
UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` IN (6748, 17359);

DELETE FROM `smart_scripts` WHERE ((`entryorguid` = 6748) AND (`source_type` = 0) AND (`id` IN (0, 1))) OR (`entryorguid` = 17359) AND (`source_type` = 0) AND (`id` IN (5, 7, 8, 9));
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(6748, 0, 0, 0, 54, 0, 100, 513, 0, 0, 0, 0, 0, 22, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Water Spirit - On Just Summoned - Set Event Phase 1 (No Repeat)'),
(6748, 0, 1, 0, 75, 1, 100, 1, 0, 17359, 30, 500, 0, 1, 0, 1500, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Water Spirit - On Distance To Creature - Say Line 0 (Phase 1) (No Repeat)'),
(17359, 0, 5, 0, 0, 1, 100, 512, 5000, 5000, 5000, 5000, 0, 11, 9672, 64, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Tel\'athion the Impure - In Combat - Cast \'Frostbolt\' (Phase 1)'),
(17359, 0, 7, 0, 0, 1, 100, 512, 6200, 6200, 5000, 5000, 0, 11, 13339, 64, 0, 0, 0, 0, 5, 6748, 1, 0, 0, 0, 0, 0, 0, 'Tel\'athion the Impure - In Combat - Cast \'Fire Blast\' (Phase 1)'),
(17359, 0, 8, 0, 9, 1, 100, 512, 0, 10, 13000, 13000, 0, 11, 11831, 64, 0, 0, 0, 0, 5, 0, 0, 0, 0, 0, 0, 0, 0, 'Tel\'athion the Impure - Within 0-10 Range - Cast \'Frost Nova\' (Phase 1)'),
(17359, 0, 9, 0, 0, 1, 100, 512, 8000, 8000, 10000, 10000, 0, 11, 15735, 64, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Tel\'athion the Impure - In Combat - Cast \'Arcane Missiles\' (Phase 1)');
