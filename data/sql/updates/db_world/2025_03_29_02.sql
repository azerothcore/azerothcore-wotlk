-- DB update 2025_03_29_01 -> 2025_03_29_02

-- Southshore Crier
UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 2435;

DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = 2435);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(2435, 0, 0, 0, 11, 0, 100, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Southshore Crier - On Respawn - Say Line 0 (No Repeat)'),
(2435, 0, 1, 0, 1, 0, 100, 1, 120000, 120000, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Southshore Crier - Out of Combat - Say Line 1 (No Repeat)'),
(2435, 0, 2, 0, 1, 0, 100, 1, 126000, 126000, 0, 0, 0, 0, 1, 2, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Southshore Crier - Out of Combat - Say Line 2 (No Repeat)'),
(2435, 0, 3, 0, 1, 0, 100, 1, 130000, 130000, 0, 0, 0, 0, 1, 3, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Southshore Crier - Out of Combat - Say Line 3 (No Repeat)'),
(2435, 0, 4, 0, 1, 0, 100, 1, 140000, 140000, 0, 0, 0, 0, 12, 2434, 4, 30000, 0, 0, 0, 8, 0, 0, 0, 0, -780.091, -530.876, 20.6933, 0.205787, 'Southshore Crier - Out of Combat - Summon Creature \'Shadowy Assassin\' (No Repeat)'),
(2435, 0, 5, 0, 1, 0, 100, 1, 142000, 142000, 0, 0, 0, 0, 12, 2434, 4, 30000, 0, 0, 0, 8, 0, 0, 0, 0, -793.784, -572.726, 16.0755, 5.45041, 'Southshore Crier - Out of Combat - Summon Creature \'Shadowy Assassin\' (No Repeat)'),
(2435, 0, 6, 0, 1, 0, 100, 1, 144000, 144000, 0, 0, 0, 0, 12, 2434, 4, 30000, 0, 0, 0, 8, 0, 0, 0, 0, -851.03, -518.154, 12.1464, 2.4638, 'Southshore Crier - Out of Combat - Summon Creature \'Shadowy Assassin\' (No Repeat)'),
(2435, 0, 7, 0, 1, 0, 100, 1, 146000, 146000, 0, 0, 0, 0, 12, 2434, 4, 30000, 0, 0, 0, 8, 0, 0, 0, 0, -830.229, -530.124, 13.6917, 5.62034, 'Southshore Crier - Out of Combat - Summon Creature \'Shadowy Assassin\' (No Repeat)'),
(2435, 0, 8, 0, 1, 0, 100, 1, 148000, 148000, 0, 0, 0, 0, 12, 2434, 4, 30000, 0, 0, 0, 8, 0, 0, 0, 0, -859.667, -544.376, 10.1443, 1.15192, 'Southshore Crier - Out of Combat - Summon Creature \'Shadowy Assassin\' (No Repeat)'),
(2435, 0, 9, 0, 1, 0, 100, 1, 150000, 150000, 0, 0, 0, 0, 12, 2434, 4, 30000, 0, 0, 0, 8, 0, 0, 0, 0, -805.857, -479.744, 15.871, 5.60839, 'Southshore Crier - Out of Combat - Summon Creature \'Shadowy Assassin\' (No Repeat)'),
(2435, 0, 10, 0, 1, 0, 100, 1, 152000, 152000, 0, 0, 0, 0, 12, 2434, 4, 30000, 0, 0, 0, 8, 0, 0, 0, 0, -887.816, -545.123, 7.04742, 0.609322, 'Southshore Crier - Out of Combat - Summon Creature \'Shadowy Assassin\' (No Repeat)'),
(2435, 0, 11, 0, 1, 0, 100, 1, 154000, 154000, 0, 0, 0, 0, 12, 2434, 4, 30000, 0, 0, 0, 8, 0, 0, 0, 0, -893.224, -590.699, 7.4458, 1.06091, 'Southshore Crier - Out of Combat - Summon Creature \'Shadowy Assassin\' (No Repeat)'),
(2435, 0, 12, 0, 1, 0, 100, 1, 156000, 156000, 0, 0, 0, 0, 1, 4, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Southshore Crier - Out of Combat - Say Line 4 (No Repeat)'),
(2435, 0, 13, 0, 11, 0, 100, 513, 0, 0, 0, 0, 0, 0, 41, 180000, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Southshore Crier - On Respawn - Despawn In 180000 ms (No Repeat)');
