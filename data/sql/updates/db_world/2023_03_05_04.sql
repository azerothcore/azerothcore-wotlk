-- DB update 2023_03_05_03 -> 2023_03_05_04
-- Deathstalker Vincent
DELETE FROM `smart_scripts` WHERE `source_type` = 0 AND `entryorguid` = 4444;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(4444, 0, 0, 0, 4, 0, 100, 512, 0, 0, 0, 0, 0, 91, 7, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Deathstalker Vincent - On Aggro - Remove FlagStandstate Dead'),
(4444, 0, 1, 2, 25, 0, 100, 513, 0, 0, 0, 0, 0, 42, 0, 1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Deathstalker Vincent - On Reset - Set Invincibility Hp 1% (No Repeat)'),
(4444, 0, 2, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 90, 7, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Deathstalker Vincent - On Reset - Set Flag Standstate Dead (No Repeat)'),
(4444, 0, 3, 4, 2, 0, 100, 513, 0, 1, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Deathstalker Vincent - Between 0-1% Health - Say Line 0 (No Repeat)'),
(4444, 0, 4, 5, 61, 0, 100, 0, 0, 0, 0, 0, 0, 101, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Deathstalker Vincent - Between 0-1% Health - Set Home Position (No Repeat)'),
(4444, 0, 5, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 2, 35, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Deathstalker Vincent - Between 0-1% Health - Set Faction 35 (No Repeat)');
