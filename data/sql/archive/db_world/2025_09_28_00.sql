-- DB update 2025_09_27_03 -> 2025_09_28_00
--
DELETE FROM `areatrigger_scripts` WHERE `entry` = 4991;
INSERT INTO `areatrigger_scripts` (`entry`, `ScriptName`) VALUES (4991, 'SmartTrigger');

DELETE FROM `smart_scripts` WHERE (`entryorguid` = 4991) AND (`source_type` = 2) AND (`id` IN (0));
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(4991, 2, 0, 0, 46, 0, 100, 0, 4991, 0, 0, 0, 0, 0, 223, 1, 0, 0, 0, 0, 0, 205, 2, 1, 0, 0, 0, 0, 0, 0, 'Areatrigger - On Trigger - Do Action ID 1');

UPDATE `creature_template` SET `unit_flags` = `unit_flags`|64|256, `flags_extra` = `flags_extra`|2147483648 WHERE `entry` IN (26693, 30807);
