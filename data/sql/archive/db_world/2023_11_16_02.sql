-- DB update 2023_11_16_01 -> 2023_11_16_02
--
UPDATE `gameobject_template` SET `AIName` = 'SmartGameObjectAI', `ScriptName` = '' WHERE `entry` = 178247;

DELETE FROM `smart_scripts` WHERE (`entryorguid` = 178247) AND (`source_type` = 1) AND (`id` IN (0));
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(178247, 1, 0, 0, 64, 0, 100, 0, 0, 0, 0, 0, 0, 0, 223, 0, 0, 0, 0, 0, 0, 19, 12717, 10, 0, 0, 0, 0, 0, 0, 'Naga Brazier - On Gossip Hello - Do Action ID 0');
