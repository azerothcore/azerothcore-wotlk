-- DB update 2025_01_26_00 -> 2025_01_26_01

-- Dragonflayer Vrykul
UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 23652;

DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = 23652);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(23652, 0, 0, 0, 8, 0, 100, 1, 43381, 0, 0, 0, 0, 0, 11, 43384, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Dragonflayer Vrykul - On Spellhit \'Plague Spray\' - Cast \'Spray Credit\' (No Repeat)'),
(23652, 0, 1, 0, 4, 0, 100, 0, 0, 0, 0, 0, 0, 0, 11, 38557, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Dragonflayer Vrykul - On Aggro - Cast \'Throw\''),
(23652, 0, 2, 0, 0, 0, 100, 0, 4000, 6000, 12000, 20000, 0, 0, 11, 43410, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Dragonflayer Vrykul - In Combat - Cast \'Chop\''),
(23652, 0, 3, 0, 0, 0, 100, 0, 25000, 30000, 30000, 45000, 0, 0, 11, 38557, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Dragonflayer Vrykul - In Combat - Cast \'Throw\'');

-- Dragonflayer Tribesman
UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 23651;

DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = 23651);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(23651, 0, 0, 0, 9, 0, 100, 0, 8000, 10000, 8000, 10000, 8, 25, 11, 35570, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Dragonflayer Tribesman - Within 8-25 Range - Cast \'Charge\''),
(23651, 0, 1, 0, 0, 0, 100, 0, 12000, 18000, 50000, 60000, 0, 0, 11, 48193, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Dragonflayer Tribesman - In Combat - Cast \'Enrage\''),
(23651, 0, 2, 0, 0, 0, 100, 0, 2000, 6000, 8000, 12000, 0, 0, 11, 15496, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Dragonflayer Tribesman - In Combat - Cast \'Cleave\'');

-- Dragonflayer Thane
UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 23660;

DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = 23660);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(23660, 0, 0, 0, 0, 0, 100, 0, 12000, 18000, 12000, 24000, 0, 0, 11, 11971, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Dragonflayer Thane - In Combat - Cast \'Sunder Armor\''),
(23660, 0, 1, 0, 0, 0, 100, 0, 8000, 12000, 12000, 16000, 0, 0, 11, 9080, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Dragonflayer Thane - In Combat - Cast \'Hamstring\'');

-- Dragonflayer Death Weaver
UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 23658;

DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = 23658);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(23658, 0, 0, 0, 1, 0, 100, 0, 1000, 1000, 1000, 1000, 0, 0, 11, 43159, 0, 0, 0, 0, 0, 19, 24158, 30, 0, 0, 0, 0, 0, 0, 'Dragonflayer Death Weaver - Out of Combat - Cast \'Soul Infusion\''),
(23658, 0, 1, 0, 0, 0, 100, 0, 2000, 4000, 8000, 12000, 0, 0, 11, 9613, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Dragonflayer Death Weaver - In Combat - Cast \'Shadow Bolt\''),
(23658, 0, 2, 0, 0, 0, 100, 0, 6000, 8000, 12000, 16000, 0, 0, 11, 43417, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Dragonflayer Death Weaver - In Combat - Cast \'Drain Life\'');

-- Dragonflayer Harpooner
UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 24635;

DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = 24635);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(24635, 0, 0, 0, 0, 0, 100, 0, 12000, 18000, 50000, 60000, 0, 0, 11, 48193, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Dragonflayer Tribesman - In Combat - Cast \'Enrage\''),
(24635, 0, 1, 0, 0, 0, 100, 0, 2000, 6000, 8000, 12000, 0, 0, 11, 43325, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Dragonflayer Tribesman - In Combat - Cast \'Oluf`s Harpoon\'');

-- Dragonflayer Lieutenant
UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 24169;

DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = 24169);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(24169, 0, 0, 0, 0, 0, 100, 0, 6000, 8000, 12000, 14000, 0, 0, 11, 48245, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Dragonflayer Lieutenant - In Combat - Cast \'Head Slash\''),
(24169, 0, 1, 0, 0, 0, 100, 0, 10000, 14000, 18000, 25000, 0, 0, 11, 48250, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Dragonflayer Lieutenant - In Combat - Cast \'Risky Feint\'');

-- Yanis the Mystic
UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 23932;

DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = 23932);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(23932, 0, 0, 0, 0, 0, 100, 0, 6000, 8000, 12000, 14000, 0, 0, 11, 42870, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Yanis the Mystic - In Combat - Cast \'Throw Dragonflayer Harpoon\''),
(23932, 0, 1, 0, 0, 0, 100, 0, 2000, 4000, 16000, 18000, 0, 0, 11, 58747, 0, 0, 0, 0, 0, 5, 25, 0, 0, 0, 0, 0, 0, 0, 'Yanis the Mystic - In Combat - Cast \'Intercept\'');
