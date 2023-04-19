-- DB update 2023_04_19_00 -> 2023_04_19_01
--
-- Create and Enable SmartAI for creature 348 to enable broadcasts
UPDATE `creature_template` SET `AIName`='SmartAI' WHERE `entry`=348;
DELETE FROM `smart_scripts` WHERE `entryorguid` = 348;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES 
(348, 0, 0, 0, 1, 0, 100, 0, 20000, 30000, 603000, 603000, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Zem Leedward - Out of Combat - Say Line 0');
