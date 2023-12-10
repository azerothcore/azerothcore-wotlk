-- DB update 2023_09_20_04 -> 2023_09_20_05
UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 21246;

DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = 21246);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(21246, 0, 0, 0, 0, 0, 100, 0, 4850, 19400, 10900, 14500, 0, 0, 11, 38461, 0, 0, 0, 0, 0, 5, 25, 0, 0, 0, 0, 0, 0, 0, 'Serpentshrine Sporebat - In Combat - Cast Sonic Charge'),
(21246, 0, 1, 0, 0, 0, 100, 0, 0, 0, 24000, 36800, 0, 0, 11, 38471, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Serpentshrine Sporebat - In Combat - Cast \'Spore Burst\'');
