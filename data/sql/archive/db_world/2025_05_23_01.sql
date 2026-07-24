-- DB update 2025_05_23_00 -> 2025_05_23_01

-- Mine Car
UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 28821;

DELETE FROM `smart_scripts` WHERE (`entryorguid` = 28821) AND (`source_type` = 0) AND (`id` IN (1));
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(28821, 0, 1, 0, 25, 0, 100, 0, 0, 0, 0, 0, 0, 0, 48, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Mine Car - On Reset - Set Active On');

-- Scarlet Miners
UPDATE `creature_template` SET `flags_extra` = `flags_extra` |134217728 WHERE (`entry` = 28822);

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 28822;

DELETE FROM `smart_scripts` WHERE (`entryorguid` = 28822) AND (`source_type` = 0) AND (`id` IN (6));
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(28822, 0, 6, 0, 25, 0, 100, 0, 0, 0, 0, 0, 0, 0, 48, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Scarlet Miner - On Reset - Set Active On');

-- Havenshire Stallions(some guids only)
DELETE FROM `smart_scripts` WHERE (`entryorguid` IN (-129208, -129214)) AND (`source_type` = 0) AND (`id` IN (3));
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(-129208, 0, 3, 0, 25, 0, 100, 0, 0, 0, 0, 0, 0, 0, 48, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Havenshire Stallion - On Reset - Set Active On'),
(-129214, 0, 3, 0, 25, 0, 100, 0, 0, 0, 0, 0, 0, 0, 48, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Havenshire Stallion - On Reset - Set Active On');

DELETE FROM `smart_scripts` WHERE (`entryorguid` = -129215) AND (`source_type` = 0) AND (`id` IN (12));
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(-129215, 0, 12, 0, 25, 0, 100, 0, 0, 0, 0, 0, 0, 0, 48, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Havenshire Stallion - On Reset - Set Active On');

DELETE FROM `smart_scripts` WHERE (`entryorguid` = -129210) AND (`source_type` = 0) AND (`id` IN (5));
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(-129210, 0, 5, 0, 25, 0, 100, 0, 0, 0, 0, 0, 0, 0, 48, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Havenshire Stallion - On Reset - Set Active On');

-- Havenshire Mares (some guids only)
UPDATE `creature_template` SET `flags_extra` = `flags_extra` |134217728 WHERE (`entry` = 28606);

DELETE FROM `smart_scripts` WHERE (`source_type` = 0) AND (`entryorguid` IN (-129230, -129234, -129235, -129236));
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(-129230, 0, 2, 0, 25, 0, 100, 0, 0, 0, 0, 0, 0, 0, 48, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Havenshire Mare - On Reset - Set Active On'),
(-129234, 0, 2, 0, 25, 0, 100, 0, 0, 0, 0, 0, 0, 0, 48, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Havenshire Mare - On Reset - Set Active On'),
(-129235, 0, 2, 0, 25, 0, 100, 0, 0, 0, 0, 0, 0, 0, 48, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Havenshire Mare - On Reset - Set Active On'),
(-129236, 0, 2, 0, 25, 0, 100, 0, 0, 0, 0, 0, 0, 0, 48, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Havenshire Mare - On Reset - Set Active On');

-- Havenshire Colts (some guids only)
UPDATE `creature_template` SET `flags_extra` = `flags_extra` |134217728 WHERE (`entry` = 28607);

DELETE FROM `smart_scripts` WHERE (`source_type` = 0) AND (`entryorguid` IN (-129243, -129245, -129246, -129248, -129249, -129251));
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(-129243, 0, 2, 0, 25, 0, 100, 0, 0, 0, 0, 0, 0, 0, 48, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Havenshire Colt - On Reset - Set Active On'),
(-129245, 0, 2, 0, 25, 0, 100, 0, 0, 0, 0, 0, 0, 0, 48, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Havenshire Colt - On Reset - Set Active On'),
(-129246, 0, 2, 0, 25, 0, 100, 0, 0, 0, 0, 0, 0, 0, 48, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Havenshire Colt - On Reset - Set Active On'),
(-129248, 0, 2, 0, 25, 0, 100, 0, 0, 0, 0, 0, 0, 0, 48, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Havenshire Colt - On Reset - Set Active On'),
(-129249, 0, 2, 0, 25, 0, 100, 0, 0, 0, 0, 0, 0, 0, 48, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Havenshire Colt - On Reset - Set Active On'),
(-129251, 0, 2, 0, 25, 0, 100, 0, 0, 0, 0, 0, 0, 0, 48, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Havenshire Colt - On Reset - Set Active On');

-- Scarlet Commanders
UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 28530;

DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = 28530);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(28530, 0, 0, 0, 25, 0, 100, 0, 0, 0, 0, 0, 0, 0, 48, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Scarlet Commander - On Reset - Set Active On');

-- Scarlet Crusaders (some guids only).
UPDATE `creature_template` SET `flags_extra` = `flags_extra` |134217728 WHERE (`entry` = 28529);

DELETE FROM `smart_scripts` WHERE (`source_type` = 0) AND (`entryorguid` IN (-128705, -128706, -128707, -128708, -128709, -128710, -128711, -128712, -128713));
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(-128705, 0, 3, 0, 25, 0, 100, 0, 0, 0, 0, 0, 0, 0, 48, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Scarlet Crusader - On Reset - Set Active On'),
(-128706, 0, 3, 0, 25, 0, 100, 0, 0, 0, 0, 0, 0, 0, 48, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Scarlet Crusader - On Reset - Set Active On'),
(-128707, 0, 3, 0, 25, 0, 100, 0, 0, 0, 0, 0, 0, 0, 48, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Scarlet Crusader - On Reset - Set Active On'),
(-128708, 0, 3, 0, 25, 0, 100, 0, 0, 0, 0, 0, 0, 0, 48, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Scarlet Crusader - On Reset - Set Active On'),
(-128709, 0, 3, 0, 25, 0, 100, 0, 0, 0, 0, 0, 0, 0, 48, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Scarlet Crusader - On Reset - Set Active On'),
(-128710, 0, 3, 0, 25, 0, 100, 0, 0, 0, 0, 0, 0, 0, 48, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Scarlet Crusader - On Reset - Set Active On'),
(-128711, 0, 3, 0, 25, 0, 100, 0, 0, 0, 0, 0, 0, 0, 48, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Scarlet Crusader - On Reset - Set Active On'),
(-128712, 0, 3, 0, 25, 0, 100, 0, 0, 0, 0, 0, 0, 0, 48, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Scarlet Crusader - On Reset - Set Active On'),
(-128713, 0, 3, 0, 25, 0, 100, 0, 0, 0, 0, 0, 0, 0, 48, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Scarlet Crusader - On Reset - Set Active On');

-- Tirisfal Crusaders
DELETE FROM `smart_scripts` WHERE (`entryorguid` IN (-130716, -130717, -130718, -130719, -130720, -130734, -130739, -130741, -130743, -130745, -130746, -130749, -130750, -130751, -130752, -130753, -130754, -130755, -130766, -130779, -130782, -130788, -130789, -130790, -130791, -130792, -130794, -130796, -130798, -130799, -130800, -130801, -130802, -130803, -130804, -130805, -130806, -130827, -130829, -130830)) AND (`source_type` = 0) AND (`id` IN (8));
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(-130716, 0, 8, 0, 25, 0, 100, 0, 0, 0, 0, 0, 0, 0, 48, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Tirisfal Crusader - On Reset - Set Active On'),
(-130717, 0, 8, 0, 25, 0, 100, 0, 0, 0, 0, 0, 0, 0, 48, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Tirisfal Crusader - On Reset - Set Active On'),
(-130718, 0, 8, 0, 25, 0, 100, 0, 0, 0, 0, 0, 0, 0, 48, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Tirisfal Crusader - On Reset - Set Active On'),
(-130719, 0, 8, 0, 25, 0, 100, 0, 0, 0, 0, 0, 0, 0, 48, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Tirisfal Crusader - On Reset - Set Active On'),
(-130720, 0, 8, 0, 25, 0, 100, 0, 0, 0, 0, 0, 0, 0, 48, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Tirisfal Crusader - On Reset - Set Active On'),
(-130734, 0, 8, 0, 25, 0, 100, 0, 0, 0, 0, 0, 0, 0, 48, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Tirisfal Crusader - On Reset - Set Active On'),
(-130739, 0, 8, 0, 25, 0, 100, 0, 0, 0, 0, 0, 0, 0, 48, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Tirisfal Crusader - On Reset - Set Active On'),
(-130741, 0, 8, 0, 25, 0, 100, 0, 0, 0, 0, 0, 0, 0, 48, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Tirisfal Crusader - On Reset - Set Active On'),
(-130743, 0, 8, 0, 25, 0, 100, 0, 0, 0, 0, 0, 0, 0, 48, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Tirisfal Crusader - On Reset - Set Active On'),
(-130745, 0, 8, 0, 25, 0, 100, 0, 0, 0, 0, 0, 0, 0, 48, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Tirisfal Crusader - On Reset - Set Active On'),
(-130746, 0, 8, 0, 25, 0, 100, 0, 0, 0, 0, 0, 0, 0, 48, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Tirisfal Crusader - On Reset - Set Active On'),
(-130749, 0, 8, 0, 25, 0, 100, 0, 0, 0, 0, 0, 0, 0, 48, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Tirisfal Crusader - On Reset - Set Active On'),
(-130750, 0, 8, 0, 25, 0, 100, 0, 0, 0, 0, 0, 0, 0, 48, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Tirisfal Crusader - On Reset - Set Active On'),
(-130751, 0, 8, 0, 25, 0, 100, 0, 0, 0, 0, 0, 0, 0, 48, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Tirisfal Crusader - On Reset - Set Active On'),
(-130752, 0, 8, 0, 25, 0, 100, 0, 0, 0, 0, 0, 0, 0, 48, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Tirisfal Crusader - On Reset - Set Active On'),
(-130753, 0, 8, 0, 25, 0, 100, 0, 0, 0, 0, 0, 0, 0, 48, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Tirisfal Crusader - On Reset - Set Active On'),
(-130754, 0, 8, 0, 25, 0, 100, 0, 0, 0, 0, 0, 0, 0, 48, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Tirisfal Crusader - On Reset - Set Active On'),
(-130755, 0, 8, 0, 25, 0, 100, 0, 0, 0, 0, 0, 0, 0, 48, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Tirisfal Crusader - On Reset - Set Active On'),
(-130766, 0, 8, 0, 25, 0, 100, 0, 0, 0, 0, 0, 0, 0, 48, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Tirisfal Crusader - On Reset - Set Active On'),
(-130779, 0, 8, 0, 25, 0, 100, 0, 0, 0, 0, 0, 0, 0, 48, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Tirisfal Crusader - On Reset - Set Active On'),
(-130782, 0, 8, 0, 25, 0, 100, 0, 0, 0, 0, 0, 0, 0, 48, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Tirisfal Crusader - On Reset - Set Active On'),
(-130788, 0, 8, 0, 25, 0, 100, 0, 0, 0, 0, 0, 0, 0, 48, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Tirisfal Crusader - On Reset - Set Active On'),
(-130789, 0, 8, 0, 25, 0, 100, 0, 0, 0, 0, 0, 0, 0, 48, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Tirisfal Crusader - On Reset - Set Active On'),
(-130790, 0, 8, 0, 25, 0, 100, 0, 0, 0, 0, 0, 0, 0, 48, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Tirisfal Crusader - On Reset - Set Active On'),
(-130791, 0, 8, 0, 25, 0, 100, 0, 0, 0, 0, 0, 0, 0, 48, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Tirisfal Crusader - On Reset - Set Active On'),
(-130792, 0, 8, 0, 25, 0, 100, 0, 0, 0, 0, 0, 0, 0, 48, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Tirisfal Crusader - On Reset - Set Active On'),
(-130794, 0, 8, 0, 25, 0, 100, 0, 0, 0, 0, 0, 0, 0, 48, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Tirisfal Crusader - On Reset - Set Active On'),
(-130796, 0, 8, 0, 25, 0, 100, 0, 0, 0, 0, 0, 0, 0, 48, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Tirisfal Crusader - On Reset - Set Active On'),
(-130798, 0, 8, 0, 25, 0, 100, 0, 0, 0, 0, 0, 0, 0, 48, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Tirisfal Crusader - On Reset - Set Active On'),
(-130799, 0, 8, 0, 25, 0, 100, 0, 0, 0, 0, 0, 0, 0, 48, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Tirisfal Crusader - On Reset - Set Active On'),
(-130800, 0, 8, 0, 25, 0, 100, 0, 0, 0, 0, 0, 0, 0, 48, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Tirisfal Crusader - On Reset - Set Active On'),
(-130801, 0, 8, 0, 25, 0, 100, 0, 0, 0, 0, 0, 0, 0, 48, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Tirisfal Crusader - On Reset - Set Active On'),
(-130802, 0, 8, 0, 25, 0, 100, 0, 0, 0, 0, 0, 0, 0, 48, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Tirisfal Crusader - On Reset - Set Active On'),
(-130803, 0, 8, 0, 25, 0, 100, 0, 0, 0, 0, 0, 0, 0, 48, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Tirisfal Crusader - On Reset - Set Active On'),
(-130804, 0, 8, 0, 25, 0, 100, 0, 0, 0, 0, 0, 0, 0, 48, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Tirisfal Crusader - On Reset - Set Active On'),
(-130805, 0, 8, 0, 25, 0, 100, 0, 0, 0, 0, 0, 0, 0, 48, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Tirisfal Crusader - On Reset - Set Active On'),
(-130806, 0, 8, 0, 25, 0, 100, 0, 0, 0, 0, 0, 0, 0, 48, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Tirisfal Crusader - On Reset - Set Active On'),
(-130827, 0, 8, 0, 25, 0, 100, 0, 0, 0, 0, 0, 0, 0, 48, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Tirisfal Crusader - On Reset - Set Active On'),
(-130829, 0, 8, 0, 25, 0, 100, 0, 0, 0, 0, 0, 0, 0, 48, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Tirisfal Crusader - On Reset - Set Active On'),
(-130830, 0, 8, 0, 25, 0, 100, 0, 0, 0, 0, 0, 0, 0, 48, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Tirisfal Crusader - On Reset - Set Active On');

-- Hearthglen Crusaders
DELETE FROM `smart_scripts` WHERE (`entryorguid` IN (-130558, -130559, -130565, -130566, -130567, -130569, -130570, -130577, -130587, -130599, -130603, -130608, -130609, -130613, -130615, -130616, -130617, -130618, -130619, -130620, -130637, -130641, -130642, -130653, -130654, -130655, -130656, -130657, -130659, -130661, -130662, -130663, -130664, -130665, -130666, -130667, -130682)) AND (`source_type` = 0) AND (`id` IN (8));
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(-130558, 0, 8, 0, 25, 0, 100, 0, 0, 0, 0, 0, 0, 0, 48, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Hearthglen Crusader - On Reset - Set Active On'),
(-130559, 0, 8, 0, 25, 0, 100, 0, 0, 0, 0, 0, 0, 0, 48, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Hearthglen Crusader - On Reset - Set Active On'),
(-130565, 0, 8, 0, 25, 0, 100, 0, 0, 0, 0, 0, 0, 0, 48, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Hearthglen Crusader - On Reset - Set Active On'),
(-130566, 0, 8, 0, 25, 0, 100, 0, 0, 0, 0, 0, 0, 0, 48, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Hearthglen Crusader - On Reset - Set Active On'),
(-130567, 0, 8, 0, 25, 0, 100, 0, 0, 0, 0, 0, 0, 0, 48, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Hearthglen Crusader - On Reset - Set Active On'),
(-130569, 0, 8, 0, 25, 0, 100, 0, 0, 0, 0, 0, 0, 0, 48, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Hearthglen Crusader - On Reset - Set Active On'),
(-130570, 0, 8, 0, 25, 0, 100, 0, 0, 0, 0, 0, 0, 0, 48, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Hearthglen Crusader - On Reset - Set Active On'),
(-130577, 0, 8, 0, 25, 0, 100, 0, 0, 0, 0, 0, 0, 0, 48, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Hearthglen Crusader - On Reset - Set Active On'),
(-130587, 0, 8, 0, 25, 0, 100, 0, 0, 0, 0, 0, 0, 0, 48, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Hearthglen Crusader - On Reset - Set Active On'),
(-130599, 0, 8, 0, 25, 0, 100, 0, 0, 0, 0, 0, 0, 0, 48, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Hearthglen Crusader - On Reset - Set Active On'),
(-130603, 0, 8, 0, 25, 0, 100, 0, 0, 0, 0, 0, 0, 0, 48, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Hearthglen Crusader - On Reset - Set Active On'),
(-130608, 0, 8, 0, 25, 0, 100, 0, 0, 0, 0, 0, 0, 0, 48, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Hearthglen Crusader - On Reset - Set Active On'),
(-130609, 0, 8, 0, 25, 0, 100, 0, 0, 0, 0, 0, 0, 0, 48, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Hearthglen Crusader - On Reset - Set Active On'),
(-130613, 0, 8, 0, 25, 0, 100, 0, 0, 0, 0, 0, 0, 0, 48, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Hearthglen Crusader - On Reset - Set Active On'),
(-130615, 0, 8, 0, 25, 0, 100, 0, 0, 0, 0, 0, 0, 0, 48, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Hearthglen Crusader - On Reset - Set Active On'),
(-130616, 0, 8, 0, 25, 0, 100, 0, 0, 0, 0, 0, 0, 0, 48, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Hearthglen Crusader - On Reset - Set Active On'),
(-130617, 0, 8, 0, 25, 0, 100, 0, 0, 0, 0, 0, 0, 0, 48, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Hearthglen Crusader - On Reset - Set Active On'),
(-130618, 0, 8, 0, 25, 0, 100, 0, 0, 0, 0, 0, 0, 0, 48, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Hearthglen Crusader - On Reset - Set Active On'),
(-130619, 0, 8, 0, 25, 0, 100, 0, 0, 0, 0, 0, 0, 0, 48, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Hearthglen Crusader - On Reset - Set Active On'),
(-130620, 0, 8, 0, 25, 0, 100, 0, 0, 0, 0, 0, 0, 0, 48, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Hearthglen Crusader - On Reset - Set Active On'),
(-130637, 0, 8, 0, 25, 0, 100, 0, 0, 0, 0, 0, 0, 0, 48, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Hearthglen Crusader - On Reset - Set Active On'),
(-130641, 0, 8, 0, 25, 0, 100, 0, 0, 0, 0, 0, 0, 0, 48, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Hearthglen Crusader - On Reset - Set Active On'),
(-130642, 0, 8, 0, 25, 0, 100, 0, 0, 0, 0, 0, 0, 0, 48, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Hearthglen Crusader - On Reset - Set Active On'),
(-130653, 0, 8, 0, 25, 0, 100, 0, 0, 0, 0, 0, 0, 0, 48, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Hearthglen Crusader - On Reset - Set Active On'),
(-130654, 0, 8, 0, 25, 0, 100, 0, 0, 0, 0, 0, 0, 0, 48, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Hearthglen Crusader - On Reset - Set Active On'),
(-130655, 0, 8, 0, 25, 0, 100, 0, 0, 0, 0, 0, 0, 0, 48, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Hearthglen Crusader - On Reset - Set Active On'),
(-130656, 0, 8, 0, 25, 0, 100, 0, 0, 0, 0, 0, 0, 0, 48, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Hearthglen Crusader - On Reset - Set Active On'),
(-130657, 0, 8, 0, 25, 0, 100, 0, 0, 0, 0, 0, 0, 0, 48, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Hearthglen Crusader - On Reset - Set Active On'),
(-130659, 0, 8, 0, 25, 0, 100, 0, 0, 0, 0, 0, 0, 0, 48, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Hearthglen Crusader - On Reset - Set Active On'),
(-130661, 0, 8, 0, 25, 0, 100, 0, 0, 0, 0, 0, 0, 0, 48, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Hearthglen Crusader - On Reset - Set Active On'),
(-130662, 0, 8, 0, 25, 0, 100, 0, 0, 0, 0, 0, 0, 0, 48, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Hearthglen Crusader - On Reset - Set Active On'),
(-130663, 0, 8, 0, 25, 0, 100, 0, 0, 0, 0, 0, 0, 0, 48, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Hearthglen Crusader - On Reset - Set Active On'),
(-130664, 0, 8, 0, 25, 0, 100, 0, 0, 0, 0, 0, 0, 0, 48, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Hearthglen Crusader - On Reset - Set Active On'),
(-130665, 0, 8, 0, 25, 0, 100, 0, 0, 0, 0, 0, 0, 0, 48, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Hearthglen Crusader - On Reset - Set Active On'),
(-130666, 0, 8, 0, 25, 0, 100, 0, 0, 0, 0, 0, 0, 0, 48, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Hearthglen Crusader - On Reset - Set Active On'),
(-130667, 0, 8, 0, 25, 0, 100, 0, 0, 0, 0, 0, 0, 0, 48, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Hearthglen Crusader - On Reset - Set Active On'),
(-130682, 0, 8, 0, 25, 0, 100, 0, 0, 0, 0, 0, 0, 0, 48, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Hearthglen Crusader - On Reset - Set Active On');

-- Volatile Ghouls
UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 29136;

DELETE FROM `smart_scripts` WHERE (`entryorguid` = 29136) AND (`source_type` = 0) AND (`id` IN (1));
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(29136, 0, 1, 0, 25, 0, 100, 0, 0, 0, 0, 0, 0, 0, 48, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Volatile Ghoul - On Reset - Set Active On');

-- Rampaging Abomination
UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 29115;

DELETE FROM `smart_scripts` WHERE (`entryorguid` = 29115) AND (`source_type` = 0) AND (`id` IN (2));
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(29115, 0, 2, 0, 25, 0, 100, 0, 0, 0, 0, 0, 0, 0, 48, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Rampaging Abomination - On Reset - Set Active On');

-- Death Knight Champions
UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 29106;

DELETE FROM `smart_scripts` WHERE (`entryorguid` = 29106) AND (`source_type` = 0) AND (`id` IN (4));
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(29106, 0, 4, 0, 25, 0, 100, 0, 0, 0, 0, 0, 0, 0, 48, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Death Knight Champion - On Reset - Set Active On');
