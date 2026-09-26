-- DB update 2026_08_27_09 -> 2026_08_27_10

-- Increase Despawn Timer by 6000 ms.
UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 22105;

DELETE FROM `smart_scripts` WHERE (`entryorguid` = 22105) AND (`source_type` = 0) AND (`id` IN (3));
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(22105, 0, 3, 0, 8, 0, 100, 513, 39246, 0, 0, 0, 0, 0, 41, 6000, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Decrepit Clefthoof - On Spellhit \'Fumping\' - Despawn In 6000 ms (No Repeat)');
