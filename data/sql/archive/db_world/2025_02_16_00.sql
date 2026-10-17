-- DB update 2025_02_15_02 -> 2025_02_16_00

-- Chillmere Tidehunter
UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 24460;

DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = 24460);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(24460, 0, 0, 0, 9, 0, 100, 0, 5000, 10000, 10000, 15000, 0, 5, 11, 6533, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Chillmere Tidehunter - Within 0-5 Range - Cast \'Net\''),
(24460, 0, 2, 0, 9, 0, 100, 0, 1000, 2000, 1000, 2000, 5, 30, 11, 38556, 64, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Chillmere Tidehunter - Within 5-30 Range - Cast \'Throw\'');

-- Chillmere Coastrunner
UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 24459;

DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = 24459);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(24459, 0, 0, 0, 0, 0, 100, 0, 6000, 12000, 12000, 18000, 0, 0, 11, 14874, 32, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Chillmere Coastrunner - In Combat - Cast \'Rupture\''),
(24459, 0, 1, 0, 0, 0, 100, 0, 12000, 18000, 8000, 16000, 0, 0, 11, 28428, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Chillmere Coastrunner - In Combat - Cast \'Instant Poison\'');

-- Chillmere Oracle
UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 24461;

DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = 24461);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(24461, 0, 0, 0, 9, 0, 100, 0, 1000, 2000, 8000, 45000, 0, 5, 11, 11831, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Chillmere Oracle - Within 0-5 Range - Cast \'Frost Nova\''),
(24461, 0, 1, 0, 0, 0, 100, 0, 4000, 8000, 12000, 18000, 0, 0, 11, 49935, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Chillmere Oracle - In Combat - Cast \'Hex of the Murloc\''),
(24461, 0, 2, 0, 0, 0, 100, 0, 8000, 12000, 8000, 12000, 0, 0, 11, 49906, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Chillmere Oracle - In Combat - Cast \'Ice Lance\'');

-- Rotgill
UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 24546;

DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = 24546);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(24546, 0, 0, 0, 0, 0, 100, 0, 2000, 4000, 2000, 12000, 0, 0, 11, 49956, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Rotgill - In Combat - Cast \'Searing Wound\''),
(24546, 0, 1, 0, 2, 0, 100, 0, 0, 25, 0, 0, 0, 0, 11, 8599, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Rotgill - Between 0-25% Health - Cast \'Enrage\'');

-- Reef Cow
UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 24797;

DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = 24797);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(24797, 0, 0, 0, 0, 0, 100, 0, 4000, 6000, 6000, 16000, 0, 0, 11, 50169, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Reef Cow - In Combat - Cast \'Flipper Thwack\'');

-- Blood Shade
UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 24872;

DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = 24872);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(24872, 0, 0, 0, 0, 0, 100, 0, 4000, 12000, 4000, 12000, 0, 0, 11, 49843, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Blood Shade - In Combat - Cast \'Vexed Blood of the Ancestors\'');

-- Risen Vrykul Ancestor
UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 24871;

DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = 24871);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(24871, 0, 0, 0, 0, 0, 100, 0, 10000, 30000, 30000, 60000, 0, 0, 11, 49841, 32, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Risen Vrykul Ancestor - In Combat - Cast \'Perturbing Strike\'');

-- Onslaught Infantry
UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 27330;

DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = 27330);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(27330, 0, 0, 0, 0, 0, 100, 0, 2000, 4000, 2000, 4000, 0, 0, 11, 50713, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Onslaught Infantry - In Combat - Cast \'Unrelenting Onslaught\'');

-- Forgotten Captain
UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 27220;

DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = 27220);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(27220, 0, 0, 0, 0, 0, 100, 0, 6000, 9000, 8000, 12000, 0, 0, 11, 51591, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Forgotten Captain - In Combat - Cast \'Stormhammer\'');

-- Old Crystalbark
UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 32357;

DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = 32357);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(32357, 0, 0, 0, 0, 0, 100, 0, 3700, 16200, 19200, 28000, 0, 0, 11, 50506, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Old Crystalbark - In Combat - Cast \'Mark of Detonation\''),
(32357, 0, 1, 0, 0, 0, 100, 0, 1625, 8100, 9600, 14000, 0, 0, 11, 60903, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Old Crystalbark - In Combat - Cast \'Arcane Breath\'');
