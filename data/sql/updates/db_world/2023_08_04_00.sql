-- DB update 2023_08_03_00 -> 2023_08_04_00
--

UPDATE `creature_template` SET `ScriptName` = "" WHERE `entry` = 22307;

DELETE FROM `smart_scripts` WHERE (`entryorguid` = 22095) AND (`source_type` = 0) AND (`id` IN (2));
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(22095, 0, 2, 0, 6, 0, 100, 0, 0, 0, 0, 0, 0, 89, 5, 0, 0, 0, 0, 0, 11, 22419, 20, 1, 0, 0, 0, 0, 0, 'Infested Root-Walker - On Just Died - Start Random Movement');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 22307;

DELETE FROM `smart_scripts` WHERE (`entryorguid` = 22307) AND (`source_type` = 0) AND (`id` IN (0, 1, 2));
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(22307, 0, 0, 0, 6, 0, 75, 0, 0, 0, 0, 0, 0, 11, 39134, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Rotting Forest-Rager - On Just Died - Cast \'Summon Lots of Wood Mites\''),
(22307, 0, 1, 0, 0, 0, 100, 0, 0, 5, 12000, 18000, 0, 11, 15548, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Rotting Forest-Rager - In Combat - Cast \'Thunderclap\' (No Repeat)'),
(22307, 0, 2, 0, 6, 0, 100, 0, 0, 0, 0, 0, 0, 89, 5, 0, 0, 0, 0, 0, 11, 22419, 20, 1, 0, 0, 0, 0, 0, 'Rotting Forest-Rager - On Just Died - Start Random Movement');
