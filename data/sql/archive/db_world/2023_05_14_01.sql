-- DB update 2023_05_14_00 -> 2023_05_14_01
--
UPDATE `creature_template` SET `minlevel`=63, `maxlevel`=63, `AIName`='SmartAI' WHERE  `entry`=16383;

DELETE FROM `creature_template_addon` WHERE `entry`=16383;
INSERT INTO `creature_template_addon` (`entry`, `auras`) VALUES (16383, '28330');

DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = 16383);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(16383, 0, 0, 0, 0, 0, 100, 0, 5000, 10000, 10000, 20000, 0, 11, 28314, 32, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Flameshocker - In Combat - Cast \'Flameshocker`s Touch\''),
(16383, 0, 1, 0, 6, 0, 100, 0, 0, 0, 0, 0, 0, 11, 28323, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Flameshocker - On Just Died - Cast \'Flameshocker`s Revenge\'');
