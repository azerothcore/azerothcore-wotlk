-- DB update 2023_04_22_06 -> 2023_04_22_07
-- ID 18885 (Farahlon Giant)
UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 18885;

DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = 18885);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(18885, 0, 0, 0, 2, 0, 100, 512, 0, 75, 0, 0, 0, 11, 36042, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Farahlon Giant - Between 0-75% Health - Cast \'Serverside - Summon Farahlon Crumbler\''),
(18885, 0, 1, 0, 2, 0, 100, 512, 0, 50, 0, 0, 0, 11, 36043, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Farahlon Giant - Between 0-50% Health - Cast \'Serverside - Summon Farahlon Crumbler\''),
(18885, 0, 2, 0, 2, 0, 100, 512, 0, 25, 0, 0, 0, 11, 36044, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Farahlon Giant - Between 0-25% Health - Cast \'Serverside - Summon Farahlon Crumbler\'');
-- 21077 (Farahlon Crumbler)
UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 21077;

DELETE FROM `smart_scripts` WHERE (`entryorguid` = 21077) AND (`source_type` = 0);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(21077, 0, 0, 0, 1, 0, 100, 0, 15000, 15000, 0, 0, 0, 41, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Farahlon Crumbler - Out of Combat - Despawn Instant');

-- ID 18886 (Farahlon Breaker)
UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 18886;

DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = 18886);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(18886, 0, 0, 0, 2, 0, 100, 512, 0, 75, 0, 0, 0, 11, 36045, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Farahlon Breaker - Between 0-75% Health - Cast \'Serverside - Summon Farahlon Shardling\''),
(18886, 0, 1, 0, 2, 0, 100, 512, 0, 50, 0, 0, 0, 11, 36046, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Farahlon Breaker - Between 0-50% Health - Cast \'Serverside - Summon Farahlon Shardling\''),
(18886, 0, 2, 0, 2, 0, 100, 512, 0, 25, 0, 0, 0, 11, 36047, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Farahlon Breaker - Between 0-25% Health - Cast \'Serverside - Summon Farahlon Shardling\'');
-- ID 21078 (Farahlon Shardling)
UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 21078;
DELETE FROM `smart_scripts` WHERE (`entryorguid` = 21078) AND (`source_type` = 0);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(21078, 0, 0, 0, 1, 0, 100, 0, 15000, 15000, 0, 0, 0, 41, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Farahlon Shardling - Out of Combat - Despawn Instant');

-- ID 20202 (Cragskaar)
DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = 20202);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(20202, 0, 0, 0, 9, 0, 100, 0, 0, 10, 12000, 16000, 0, 11, 32959, 2, 0, 0, 0, 0, 5, 0, 0, 0, 0, 0, 0, 0, 0, 'Cragskaar - Within 0-10 Range - Cast \'Knock Away\''),
(20202, 0, 1, 0, 2, 0, 100, 512, 0, 90, 0, 0, 0, 11, 36048, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Cragskaar - Between 0-90% Health - Cast \'Serverside - Summon Motherlode Shardling\''),
(20202, 0, 2, 0, 2, 0, 100, 512, 0, 60, 0, 0, 0, 11, 36049, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Cragskaar - Between 0-60% Health - Cast \'Serverside - Summon Motherlode Shardling\''),
(20202, 0, 3, 0, 2, 0, 100, 512, 0, 30, 0, 0, 0, 11, 36050, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Cragskaar - Between 0-30% Health - Cast \'Serverside - Summon Motherlode Shardling\'');
-- ID 21079 (Cragskaar Shardling)
UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 21079;

DELETE FROM `smart_scripts` WHERE (`entryorguid` = 21079) AND (`source_type` = 0);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(21079, 0, 0, 0, 1, 0, 100, 0, 15000, 15000, 0, 0, 0, 41, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Cragskaar Shardling - Out of Combat - Despawn Instant');

-- ID 19940 (Apex)
UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 19940;

DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = 19940);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(19940, 0, 0, 0, 0, 0, 100, 0, 11900, 11900, 15000, 21200, 0, 11, 8078, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Apex - In Combat - Cast \'Thunderclap\''),
(19940, 0, 1, 0, 2, 0, 100, 512, 0, 75, 0, 0, 0, 11, 36595, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Apex - Between 0-75% Health - Cast \'Serverside - Summon Apex Crumbler\''),
(19940, 0, 2, 0, 2, 0, 100, 512, 0, 50, 0, 0, 0, 11, 36596, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Apex - Between 0-50% Health - Cast \'Serverside - Summon Apex Crumbler\''),
(19940, 0, 3, 0, 2, 0, 100, 512, 0, 25, 0, 0, 0, 11, 36597, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Apex - Between 0-25% Health - Cast \'Serverside - Summon Apex Crumbler\'');
-- ID 21328 (Apex Crumbler)
UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 21328;

DELETE FROM `smart_scripts` WHERE (`entryorguid` = 21328) AND (`source_type` = 0);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(21328, 0, 0, 0, 1, 0, 100, 0, 15000, 15000, 0, 0, 0, 41, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Apex Crumbler - Out of Combat - Despawn Instant');

-- ID 20772 (Netherock)
UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 20772;

DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = 20772);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(20772, 0, 1, 0, 2, 0, 100, 512, 0, 75, 0, 0, 0, 11, 36579, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Netherock - Between 0-75% Health - Cast \'Serverside - Summon Netherock Crumbler\''),
(20772, 0, 2, 0, 2, 0, 100, 512, 0, 50, 0, 0, 0, 11, 36584, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Netherock - Between 0-50% Health - Cast \'Serverside - Summon Netherock Crumbler\''),
(20772, 0, 3, 0, 2, 0, 100, 512, 0, 25, 0, 0, 0, 11, 36585, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Netherock - Between 0-25% Health - Cast \'Serverside - Summon Netherock Crumbler\'');
-- ID 21323 (Netherock Crumbler)
UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 21323;

DELETE FROM `smart_scripts` WHERE (`entryorguid` = 21323) AND (`source_type` = 0);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(21323, 0, 0, 0, 1, 0, 100, 0, 15000, 15000, 0, 0, 0, 41, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Netherock Crumbler - Out of Combat - Despawn Instant');

-- ID 18690 (Morcrush)
DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = 18690);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(18690, 0, 0, 0, 9, 0, 100, 0, 0, 5, 12000, 16000, 0, 11, 35238, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Morcrush - Within 0-5 Range - Cast \'War Stomp\''),
(18690, 0, 1, 0, 2, 0, 100, 512, 0, 75, 0, 0, 0, 11, 38888, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Morcrush - Between 0-75% Health - Cast \'Serverside - Summon Morcrush Shardling\''),
(18690, 0, 2, 0, 2, 0, 100, 512, 0, 50, 0, 0, 0, 11, 38889, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Morcrush - Between 0-50% Health - Cast \'Serverside - Summon Morcrush Shardling\''),
(18690, 0, 3, 0, 2, 0, 100, 512, 0, 25, 0, 0, 0, 11, 38890, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Morcrush - Between 0-25% Health - Cast \'Serverside - Summon Morcrush Shardling\'');
-- ID 22344 (Morcrush Shardling)
UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 22344;

DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = 22344);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(22344, 0, 0, 0, 9, 0, 100, 0, 0, 10, 16000, 21000, 0, 11, 8078, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Morcrush Shardling - Within 0-10 Range - Cast \'Thunderclap\''),
(22344, 0, 1, 0, 2, 0, 100, 0, 0, 50, 0, 0, 0, 11, 34970, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Morcrush Shardling - Between 0-50% Health - Cast \'Frenzy\''),
(22344, 0, 2, 0, 1, 0, 100, 0, 60000, 60000, 0, 0, 0, 41, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Morcrush Shardling - Out of Combat - Despawn Instant');

-- ID 21936 (Crazed Shardling)
UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 21936;

DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = 21936);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(21936, 0, 0, 0, 0, 0, 100, 0, 3000, 3000, 120000, 120000, 0, 11, 34970, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Crazed Shardling - In Combat - Cast \'Frenzy\''),
(21936, 0, 1, 0, 1, 0, 100, 0, 15000, 15000, 0, 0, 0, 41, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Crazed Shardling - Out of Combat - Despawn Instant');
