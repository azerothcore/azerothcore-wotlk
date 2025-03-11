-- DB update 2023_05_10_05 -> 2023_05_10_06
-- Void Baron Galaxi
DELETE FROM `creature_template_movement` WHERE (`CreatureId` = 16939);
INSERT INTO `creature_template_movement` (`CreatureId`, `Ground`, `Swim`, `Flight`, `Rooted`, `Chase`, `Random`, `InteractionPauseTimer`) VALUES
(16939, 0, 0, 1, 0, 0, 0, 0);

DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = 16939);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(16939, 0, 0, 1, 54, 0, 100, 257, 0, 0, 0, 0, 0, 11, 34302, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Void Baron Galaxis - On Just Summoned - Cast \'Coalesce\' (No Repeat/Reset)'),
(16939, 0, 1, 2, 61, 0, 100, 0, 0, 0, 0, 0, 0, 12, 22146, 3, 30000, 0, 0, 0, 8, 0, 0, 0, 0, -1243.23, 1312.41, -1, 0, 'Void Baron Galaxis - On Just Summoned - Summon Creature \'Summoning Voidstorm\' (No Repeat/Reset)'),
(16939, 0, 2, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 60, 1, 0, 0, 0, 0, 0, 9, 22146, 0, 5, 0, 0, 0, 0, 0, 'Void Baron Galaxis - On Just Summoned - Set Fly On (No Repeat/Reset)'),
(16939, 0, 3, 4, 60, 0, 100, 257, 2000, 2000, 0, 0, 0, 69, 1, 0, 0, 0, 0, 0, 8, 0, 0, 0, 0, -1232.9, 1355.96, 5.23, 1, 'Void Baron Galaxis - On Update - Move To Position (No Repeat/Reset)'),
(16939, 0, 4, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 101, 0, 0, 0, 0, 0, 0, 8, 0, 0, 0, 0, -1232.9, 1355.96, 5.23, 1, 'Void Baron Galaxis - On Update - Set Home Position (No Repeat/Reset)'),
(16939, 0, 5, 0, 60, 0, 100, 257, 8500, 8500, 0, 0, 0, 11, 34236, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Void Baron Galaxis - On Update - Cast \'Baron`s Summons\' (No Repeat/Reset)'),
(16939, 0, 6, 0, 0, 0, 100, 0, 12000, 15000, 15000, 20000, 0, 11, 34239, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Void Baron Galaxis - In Combat - Cast \'Absorb Life\'');

-- Summoning Voidstorm
DELETE FROM `creature_template_movement` WHERE (`CreatureId` = 22146);
INSERT INTO `creature_template_movement` (`CreatureId`, `Ground`, `Swim`, `Flight`, `Rooted`, `Chase`, `Random`, `InteractionPauseTimer`) VALUES
(22146, 0, 0, 1, 0, 0, 0, 0);
