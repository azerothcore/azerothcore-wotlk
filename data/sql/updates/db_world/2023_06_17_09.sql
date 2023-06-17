-- DB update 2023_06_17_08 -> 2023_06_17_09
--
-- Antu'Sul (Zul'Farrak)
DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = 8127);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(8127, 0, 0, 0, 0, 0, 75, 0, 5000, 5000, 17000, 17000, 0, 11, 8376, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Antu\'sul - In Combat - Cast Earthgrab Totem'),
(8127, 0, 1, 0, 0, 0, 75, 0, 13000, 13000, 17000, 17000, 0, 11, 11899, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Antu\'sul - In Combat - Cast Healing Ward'),
(8127, 0, 2, 3, 4, 0, 100, 0, 0, 0, 0, 0, 0, 11, 11894, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Antu\'sul - On Aggro - Cast Antu\'sul\'s Minion'),
(8127, 0, 3, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Antu\'sul - On Aggro - Say Line 1'),
(8127, 0, 4, 0, 0, 0, 100, 0, 5000, 5000, 12000, 14000, 0, 11, 16006, 0, 0, 0, 0, 0, 5, 0, 0, 0, 0, 0, 0, 0, 0, 'Antu\'sul - In Combat - Cast Chain Lightning'),
(8127, 0, 5, 0, 0, 0, 100, 0, 3000, 3000, 9000, 11000, 0, 11, 15501, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Antu\'sul - In Combat - Cast Earth Shock'),
(8127, 0, 6, 0, 38, 0, 100, 0, 1, 1, 0, 0, 0, 49, 0, 0, 0, 0, 0, 0, 21, 100, 0, 0, 0, 0, 0, 0, 0, 'Antu\'sul - On Data Set 1 1 - Start Attacking'),
(8127, 0, 7, 8, 2, 0, 100, 1, 0, 75, 0, 0, 0, 11, 11894, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Antu\'sul - Between 0-75% Health - Cast Antu\'sul\'s Minion'),
(8127, 0, 8, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 1, 2, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Antu\'sul - Between 0-75% Health - Say Line 2'),
(8127, 0, 9, 10, 2, 0, 100, 1, 0, 25, 0, 0, 0, 11, 11894, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Antu\'sul - Between 0-25% Health - Cast Antu\'sul\'s Minion'),
(8127, 0, 10, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Antu\'sul - Between 0-25% Health - Say Line 0'),
(8127, 0, 11, 0, 2, 0, 100, 1, 0, 20, 0, 0, 0, 11, 11895, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Antu\'sul - Between 0-20% Health - Cast Healing Wave of Antu\'sul'),
(8127, 0, 12, 0, 25, 0, 100, 0, 0, 0, 0, 0, 0, 41, 0, 0, 0, 0, 0, 0, 9, 8156, 0, 500, 1, 0, 0, 0, 0, 'Antu\'sul - On Reset - Despawn Summons');
