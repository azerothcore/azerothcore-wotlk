-- DB update 2023_01_06_01 -> 2023_01_07_00
--
UPDATE `creature_template` SET `ScriptName` = '', `AIName` = 'SmartAI' WHERE `Entry` = 22095;

DELETE FROM `smart_scripts` WHERE `entryorguid`=22095;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(22095, 0, 0, 0, 6, 0, 75, 0, 0, 0, 0, 0, 0, 11, 39130, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Infested Root-Walker - On Just Died - Cast \'Summon Wood Mites\''),
(22095, 0, 1, 0, 0, 0, 100, 0, 15000, 20000, 32000, 38000, 0, 11, 39000, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Infested Root-Walker - In Combat - Cast \'Regrowth\' (No Repeat)');
