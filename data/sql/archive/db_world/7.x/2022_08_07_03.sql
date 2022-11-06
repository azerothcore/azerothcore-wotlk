-- DB update 2022_08_07_02 -> 2022_08_07_03
--
UPDATE `creature_template_addon` SET `auras` = '' WHERE (`entry` = 15385);

DELETE FROM `smart_scripts` WHERE (`entryorguid` = 15385) AND (`source_type` = 0) AND (`id` IN (1));
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(15385, 0, 1, 0, 0, 0, 100, 2, 12000, 13000, 20000, 26000, 0, 11, 25462, 32, 0, 0, 0, 0, 26, 20, 0, 0, 0, 0, 0, 0, 0, 'Colonel Zerran - In Combat - Cast \'Enlarge\'');
