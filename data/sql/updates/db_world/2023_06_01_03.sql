-- DB update 2023_06_01_02 -> 2023_06_01_03
-- 5097: Lupine Delusion (Shadowfang Keep)
-- 6493: Illusionary Phantasm (Scarlet Monastery Graveyard)
UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` IN (5097, 6493);

DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` IN (5097, 6493));
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(5097, 0, 0, 0, 2, 0, 100, 0, 0, 99, 0, 0, 0, 41, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Lupine Delusion - Between 0-99% Health - Despawn Instant'),
(5097, 0, 1, 0, 6, 0, 100, 0, 0, 0, 0, 0, 0, 41, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Lupine Delusion - On Just Died - Despawn Instant'),
(6493, 0, 0, 0, 2, 0, 100, 0, 0, 99, 0, 0, 0, 41, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Illusionary Phantasm - Between 0-99% Health - Despawn Instant'),
(6493, 0, 1, 0, 6, 0, 100, 0, 0, 0, 0, 0, 0, 41, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Illusionary Phantasm - On Just Died - Despawn Instant');
