-- Vekniss Wasp (15236)
UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 15236;
DELETE FROM `smart_scripts` WHERE (`entryorguid` = 15236) AND (`source_type` = 0) AND (`id` IN (0, 1, 2));
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(15236, 0, 0, 1, 9, 0, 100, 0, 0, 40, 9700, 17100, 0, 11, 26077, 2, 0, 0, 0, 0, 5, 0, 0, 0, 0, 0, 0, 0, 0, 'Vekniss Wasp - Within 0-40 Range - Cast \'Itch\''),
(15236, 0, 1, 2, 61, 0, 100, 0, 0, 40, 0, 0, 0, 11, 26077, 2, 0, 0, 0, 0, 5, 0, 0, 0, 0, 0, 0, 0, 0, 'Vekniss Wasp - Within 0-40 Range - Cast \'Itch\''),
(15236, 0, 2, 0, 61, 0, 100, 0, 0, 40, 0, 0, 0, 11, 26077, 2, 0, 0, 0, 0, 5, 0, 0, 0, 0, 0, 0, 0, 0, 'Vekniss Wasp - Within 0-40 Range - Cast \'Itch\'');

-- Qiraji Lasher (15249)
DELETE FROM `smart_scripts` WHERE (`entryorguid` = 15249) AND (`source_type` = 0) AND (`id` IN (0, 1));
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(15249, 0, 0, 0, 0, 0, 100, 0, 26600, 31500, 26600, 31500, 0, 11, 26027, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Qiraji Lasher - In Combat - Cast \'Knockback\''),
(15249, 0, 1, 0, 0, 0, 100, 0, 8400, 18200, 8400, 18200, 0, 11, 26038, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Qiraji Lasher - In Combat - Cast \'Whirlwind\'');

-- Vekniss Soldier (15229)
DELETE FROM `smart_scripts` WHERE (`entryorguid` = 15229) AND (`source_type` = 0) AND (`id` IN (0, 1, 2));
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(15229, 0, 0, 0, 0, 0, 100, 0, 0, 0, 60000, 60000, 0, 11, 25152, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Vekniss Soldier - In Combat - Cast \'Agro Drones\''),
(15229, 0, 1, 0, 9, 0, 100, 0, 0, 5, 5000, 7000, 0, 11, 40504, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Vekniss Soldier - Within 0-5 Range - Cast \'Cleave\''),
(15229, 0, 2, 0, 9, 0, 100, 0, 5, 25, 8000, 12000, 0, 11, 1906, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Vekniss Soldier - Within 5-25 Range - Cast \'Debilitating Charge\'');

-- Qiraji Mindslayer (15246)
DELETE FROM `smart_scripts` WHERE (`entryorguid` = 15246) AND (`source_type` = 0) AND (`id` IN (0, 1, 2, 3));
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(15246, 0, 0, 0, 0, 0, 100, 0, 15000, 18000, 10000, 15000, 0, 11, 26079, 0, 0, 0, 0, 0, 6, 0, 0, 0, 0, 0, 0, 0, 0, 'Qiraji Mindslayer - In Combat - Cast \'Cause Insanity\''),
(15246, 0, 1, 0, 0, 0, 100, 0, 9000, 13000, 13000, 16000, 0, 11, 26049, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Qiraji Mindslayer - In Combat - Cast \'Mana Burn\''),
(15246, 0, 2, 0, 0, 0, 100, 0, 0, 20, 3000, 5000, 0, 11, 26048, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Qiraji Mindslayer - In Combat - Cast \'Mind Blast\''),
(15246, 0, 3, 0, 0, 0, 100, 0, 3000, 5000, 12000, 17000, 0, 11, 26044, 0, 0, 0, 0, 0, 5, 0, 0, 0, 0, 0, 0, 0, 0, 'Qiraji Mindslayer - In Combat - Cast \'Mind Flay\'');

-- Qiraji Brainwasher (15247)
DELETE FROM `smart_scripts` WHERE (`entryorguid` = 15247) AND (`source_type` = 0) AND (`id` IN (0, 1, 2));
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(15247, 0, 0, 0, 0, 0, 100, 0, 5000, 8000, 16000, 21000, 0, 11, 26079, 0, 0, 0, 0, 0, 6, 0, 0, 0, 0, 0, 0, 0, 0, 'Qiraji Brainwasher - In Combat - Cast \'Cause Insanity\''),
(15247, 0, 1, 0, 0, 0, 100, 0, 3000, 5000, 9000, 13000, 0, 11, 26046, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Qiraji Brainwasher - In Combat - Cast \'Mana Burn\''),
(15247, 0, 2, 0, 0, 0, 100, 0, 8000, 11000, 14000, 17000, 0, 11, 26044, 0, 0, 0, 0, 0, 5, 0, 0, 0, 0, 0, 0, 0, 0, 'Qiraji Brainwasher - In Combat - Cast \'Mind Flay\'');
