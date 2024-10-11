-- DB update 2022_07_20_03 -> 2022_07_20_04
UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 11076;

DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = 11076);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(11076, 0, 0, 0, 0, 0, 100, 0, 0, 0, 3400, 4800, 0, 11, 12471, 64, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Cauldron Lord Razarch - In Combat - Cast \'Shadow Bolt\''),
(11076, 0, 1, 0, 0, 0, 100, 0, 11000, 15000, 20000, 25000, 0, 11, 17204, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Cauldron Lord Razarch - In Combat - Cast \'Summon Skeleton\''),
(11076, 0, 2, 0, 2, 0, 100, 0, 0, 50, 14000, 18000, 0, 11, 17173, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Cauldron Lord Razarch - Between 0-50% Health - Cast \'Drain Life\''),
(11076, 0, 3, 0, 4, 0, 100, 0, 0, 0, 0, 0, 0, 1, 0, 0, 1, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Cauldron Lord Razarch - On Aggro - Say Line 0');
