-- DB update 2025_02_05_00 -> 2025_02_05_01

-- Trapdoor Crawler
UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 28221;

DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = 28221);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(28221, 0, 0, 0, 1, 0, 100, 0, 20000, 30000, 20000, 30000, 0, 0, 11, 50981, 32, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Trapdoor Crawler - Out of Combat - Cast \'Burrow\''),
(28221, 0, 1, 0, 23, 0, 100, 0, 50981, 1, 40000, 50000, 0, 0, 28, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Trapdoor Crawler - On Aura \'Burrow\' - Remove Aura \'null\''),
(28221, 0, 2, 0, 4, 0, 100, 0, 0, 0, 0, 0, 0, 0, 28, 50981, 1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Trapdoor Crawler - On Aggro - Remove Aura \'Burrow\''),
(28221, 0, 3, 0, 0, 0, 100, 0, 2000, 5000, 4000, 8000, 0, 0, 11, 11918, 2, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Trapdoor Crawler - In Combat - Cast \'Poison\'');

-- Thornvine Creeper
UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 23874;

DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = 23874);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(23874, 0, 0, 0, 1, 0, 100, 0, 4000, 6000, 4000, 6000, 0, 0, 11, 33907, 32, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Thornvine Creeper - Out of Combat - Cast \'Thorns\''),
(23874, 0, 1, 0, 0, 0, 100, 0, 4000, 6000, 12000, 16000, 0, 0, 11, 31287, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Thornvine Creeper - In Combat - Cast \'Entangling Roots\'');

-- Keeper Witherleaf
UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 24638;

DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = 24638);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(24638, 0, 0, 0, 0, 0, 100, 0, 4000, 12000, 4000, 12000, 0, 0, 11, 43619, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Keeper Witherleaf - In Combat - Cast \'Wrath\'');

-- Runic War Golem
UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 26347;

DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = 26347);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(26347, 0, 0, 0, 0, 0, 100, 0, 8000, 12000, 20000, 30000, 0, 0, 11, 52702, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Runic War Golem - In Combat - Cast \'Rune Punch\'');

-- Icetouched Earthrager
UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 29436;

DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = 29436);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(29436, 0, 0, 0, 0, 0, 100, 0, 4000, 8000, 12000, 24000, 0, 0, 11, 55216, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Icetouched Earthrager - In Combat - Cast \'Avalanche\'');

-- Tukemuth
UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 32400;

DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = 32400);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(32400, 0, 0, 0, 9, 0, 100, 0, 0, 0, 9000, 13000, 0, 5, 11, 50410, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Tukemuth - Within 0-5 Range - Cast \'Tusk Strike\''),
(32400, 0, 1, 0, 0, 0, 100, 0, 9000, 17000, 15000, 22000, 0, 0, 11, 57066, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Tukemuth - In Combat - Cast \'Trample\'');

-- Wandering Shadow
UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 30842;

DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = 30842);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(30842, 0, 0, 0, 0, 0, 100, 0, 4000, 8000, 12000, 24000, 0, 0, 11, 38240, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Wandering Shadow - In Combat - Cast \'Chilling Touch\''),
(30842, 0, 1, 0, 0, 0, 50, 0, 25000, 30000, 25000, 30000, 0, 0, 11, 18267, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Wandering Shadow - In Combat - Cast \'Curse of Weakness\'');

-- Shadow Revenant
UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 30872;

DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = 30872);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(30872, 0, 0, 0, 0, 0, 100, 0, 4000, 8000, 12000, 20000, 0, 0, 11, 51131, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Shadow Revenant - In Combat - Cast \'Strangulate\'');

-- Iron Rune Sentinel
UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 24316;

DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = 24316);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(24316, 0, 0, 0, 0, 0, 100, 0, 8000, 12000, 14000, 22000, 0, 0, 11, 48416, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Iron Rune Sentinel - In Combat - Cast \'Rune Detonation\'');
