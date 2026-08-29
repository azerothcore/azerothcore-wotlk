--
UPDATE `creature` SET `spawntimesecs` = 30 WHERE `id` = 34192 AND `guid` BETWEEN 1975178 AND 1975197;

DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = 34192);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(34192, 0, 0, 0, 25, 0, 100, 0, 0, 0, 0, 0, 0, 0, 8, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Boomer XP-500 - On Reset - Set React State Defensive'),
(34192, 0, 1, 0, 25, 0, 100, 0, 0, 0, 0, 0, 0, 0, 20, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Boomer XP-500 - On Reset - Disable Auto Attack'),
(34192, 0, 2, 4, 10, 0, 100, 1, 2, 1, 0, 0, 1, 0, 11, 63801, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Boomer XP-500 - Within 0-1 Range Out of Combat LoS - Cast Bomb Bot (No Repeat)'),
(34192, 0, 3, 4, 26, 0, 100, 1, 2, 1, 0, 0, 1, 0, 11, 63801, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Boomer XP-500 - Within 0-1 Range In Combat LoS - Cast Bomb Bot (No Repeat)'),
(34192, 0, 4, 5, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 37, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Boomer XP-500 - On Link - Die'),
(34192, 0, 5, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 41, 2000, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Boomer XP-500 - On Link - Despawn In 2000 ms');
