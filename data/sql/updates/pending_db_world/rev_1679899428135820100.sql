-- EffectMiscValueB_1 64 does not make the adds show the title "'s minion"
UPDATE `spell_dbc` SET `Effect_1` = 28, `EffectMiscValueB_1` = 67 WHERE `ID` IN (36042, 36043, 36044, 36045, 36046, 36047, 36048, 36049, 36050);

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
(20202, 0, 1, 0, 2, 0, 100, 512, 0, 90, 0, 0, 0, 11, 36048, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Cragskaar - Between 0-75% Health - Cast \'Serverside - Summon Motherlode Shardling\''),
(20202, 0, 2, 0, 2, 0, 100, 512, 0, 60, 0, 0, 0, 11, 36049, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Cragskaar - Between 0-50% Health - Cast \'Serverside - Summon Motherlode Shardling\''),
(20202, 0, 3, 0, 2, 0, 100, 512, 0, 30, 0, 0, 0, 11, 36050, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Cragskaar - Between 0-25% Health - Cast \'Serverside - Summon Motherlode Shardling\'');
-- ID 21079 (Cragskaar Shardling)
UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 21079;

DELETE FROM `smart_scripts` WHERE (`entryorguid` = 21079) AND (`source_type` = 0);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(21079, 0, 0, 0, 1, 0, 100, 0, 15000, 15000, 0, 0, 0, 41, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Cragskaar Shardling - Out of Combat - Despawn Instant');
