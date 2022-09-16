-- DB update 2020_10_30_00 -> 2020_10_30_01
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2020_10_30_00';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2020_10_30_00 2020_10_30_01 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1601315140580867400'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1601315140580867400');
/*
 * Zone: Azeroth (Skipped Part II)
 * Update by Knindza | <www.azerothcore.org>
 * Copyright (C) <www.shadowburn.net> & <www.lichbane.com>
*/

/* SMARTSCRIPT */
UPDATE `creature_template` SET `AIName`='SmartAI' WHERE `entry`=4011;
DELETE FROM `smart_scripts` WHERE `entryorguid`=4011 AND `source_type`=0;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(4011,0,0,0,0,0,100,0,5000,8000,12000,18000,11,744,32,0,0,0,0,2,0,0,0,0,0,0,0,'Young Pridewing - In Combat - Cast Poison');

UPDATE `creature_template` SET `AIName`='SmartAI' WHERE `entry`=4263;
DELETE FROM `smart_scripts` WHERE `entryorguid`=4263 AND `source_type`=0;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(4263,0,0,0,2,0,50,1,0,30,0,0,11,6536,0,0,0,0,0,1,0,0,0,0,0,0,0,'Deepmoss Hatchling - At 30% HP - Summon Deepmoss Matriarch');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 4264;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 4264);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(4264, 0, 0, 0, 7, 0, 100, 0, 0, 0, 0, 0, 41, 5000, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Deepmoss Matriarch - On Evade - Despawn In 5000 ms');

UPDATE `creature_template` SET `AIName`='SmartAI' WHERE `entry`=2172;
DELETE FROM `smart_scripts` WHERE `entryorguid`=2172 AND `source_type`=0;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(2172,0,0,0,0,0,100,0,7000,11000,12000,14000,11,7272,0,0,0,0,0,1,0,0,0,0,0,0,0,'Strider Clutchmother - In Combat - Cast Dust Cloud'),
(2172,0,1,0,9,0,100,0,0,5,15000,17000,11,6607,0,0,0,0,0,2,0,0,0,0,0,0,0,'Strider Clutchmother - Within 0-5 Range - Cast Lash'),
(2172,0,2,0,2,0,100,1,0,15,0,0,25,1,0,0,0,0,0,1,0,0,0,0,0,0,0,'Strider Clutchmother - Between 0-15% Health - Flee For Assist (No Repeat)');

UPDATE `creature_template` SET `AIName`='SmartAI' WHERE `entry`=2170;
DELETE FROM `smart_scripts` WHERE `entryorguid`=2170 AND `source_type`=0;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(2170,0,0,0,14,0,100,0,200,40,18000,21000,11,1058,0,0,0,0,0,7,0,0,0,0,0,0,0,'Blackwood Ursa - Friendly At 200 Health - Cast Rejuvenation');

UPDATE `creature_template` SET `AIName`='SmartAI' WHERE `entry`=2171;
DELETE FROM `smart_scripts` WHERE `entryorguid`=2171 AND `source_type`=0;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(2171,0,0,0,0,0,100,0,1000,2000,3000,3400,11,9532,64,0,0,0,0,2,0,0,0,0,0,0,0,'Blackwood Shaman - In Combat CMC - Cast Lightning Bolt'),
(2171,0,1,0,0,0,100,0,9000,14000,11000,15000,11,2606,0,0,0,0,0,2,0,0,0,0,0,0,0,'Blackwood Shaman - In Combat - Cast Shock'),
(2171,0,2,0,14,0,100,0,300,40,16000,21000,11,913,0,0,0,0,0,7,0,0,0,0,0,0,0,'Blackwood Shaman - Friendly At 300 Health - Cast Healing Wave');

UPDATE `creature_template` SET `AIName`='SmartAI' WHERE `entry`=2186;
DELETE FROM `smart_scripts` WHERE `entryorguid`=2186 AND `source_type`=0;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(2186,0,0,0,25,0,100,0,0,0,0,0,75,8876,0,0,0,0,0,1,0,0,0,0,0,0,0,'Carnivous the Breaker - On Respawn - Cast Thrash (No Repeat)'),
(2186,0,1,0,9,0,100,0,0,0,15000,20000,11,6016,0,0,0,0,0,2,0,0,0,0,0,0,0,'Carnivous the Breaker - Within 0-5 Range - Cast Pierce Armor');

UPDATE `creature_template` SET `AIName`='SmartAI' WHERE `entry`=2183;
DELETE FROM `smart_scripts` WHERE `entryorguid`=2183 AND `source_type`=0;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(2183,0,0,0,0,0,100,0,4000,8000,10000,12000,11,3248,0,0,0,0,0,1,0,0,0,0,0,0,0,'Stormscale Warrior - In Combat - Cast Improved Blocking');

UPDATE `creature_template` SET `AIName`='SmartAI' WHERE `entry`=7016;
DELETE FROM `smart_scripts` WHERE `entryorguid`=7016 AND `source_type`=0;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(7016,0,0,0,0,0,100,0,1500,3000,3000,3100,11,6660,64,0,0,0,0,2,0,0,0,0,0,0,0,'Lady Vespira - In Combat - Cast Shoot'),
(7016,0,1,0,9,0,100,0,0,5,9000,14000,11,11428,1,0,0,0,0,2,0,0,0,0,0,0,0,'Lady Vespira - Within 0-5 Range - Cast Knockdown'),
(7016,0,2,0,0,0,100,0,11000,15000,14000,17000,11,12549,1,0,0,0,0,2,0,0,0,0,0,0,0,'Lady Vespira - In Combat - Cast Forked Lightning');

UPDATE `creature_template` SET `AIName`='SmartAI' WHERE `entry`=2175;
DELETE FROM `smart_scripts` WHERE `entryorguid`=2175 AND `source_type`=0;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(2175,0,0,0,9,0,100,0,0,30,12000,15000,11,17227,0,0,0,0,0,2,0,0,0,0,0,0,0,'Shadowclaw - Within 0-30 Range - Cast Curse of Weakness');

DELETE FROM `creature_text` WHERE `CreatureID`=11915;
INSERT INTO `creature_text` (`CreatureID`, `GroupID`, `ID`, `Text`, `Type`, `Language`, `Probability`, `Emote`, `Duration`, `Sound`, `BroadcastTextId`, `TextRange`, `comment`) VALUES
(11915,0,0,'You no take candle!',12,0,100,0,0,0,16658,0,'Gogger Rock Keeper'),
(11915,0,1,'Yiieeeee! Me run!',12,0,100,0,0,0,1864,0,'Gogger Rock Keeper'),
(11915,0,2,'No kill me! No kill me!',12,0,100,0,0,0,1863,0,'Gogger Rock Keeper');

UPDATE `creature_template` SET `AIName`='SmartAI' WHERE `entry`=4001;
DELETE FROM `smart_scripts` WHERE `entryorguid`=4001 AND `source_type`=0;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(4001,0,0,0,0,0,100,0,4000,11000,7000,15000,11,8139,32,0,0,0,0,2,0,0,0,0,0,0,0,'Windshear Tunnel Rat - In Combat - Cast Fevered Fatigue');

DELETE FROM `creature_text` WHERE `CreatureID`=11917;
INSERT INTO `creature_text` (`CreatureID`, `GroupID`, `ID`, `Text`, `Type`, `Language`, `Probability`, `Emote`, `Duration`, `Sound`, `BroadcastTextId`, `TextRange`, `comment`) VALUES
(11917,0,0,'You NO take candle!',12,0,100,0,0,0,16658,0,'Gogger Geomancer'),
(11917,0,1,'Yiieeeee! Me run!',12,0,100,0,0,0,1864,0,'Gogger Geomancer'),
(11917,0,2,'No kill me! No kill me!',12,0,100,0,0,0,1863,0,'Gogger Geomancer');

UPDATE `creature_template` SET `AIName`='SmartAI' WHERE `entry`=4002;
DELETE FROM `smart_scripts` WHERE `entryorguid`=4002 AND `source_type`=0;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(4002,0,0,0,2,0,100,1,0,15,0,0,25,1,0,0,0,0,0,1,0,0,0,0,0,0,0,'Windshear Stonecutter - Between 0-15% Health - Flee For Assist (No Repeat)');

UPDATE `creature_template` SET `AIname`='SmartAI' WHERE `entry`=11912;
DELETE FROM `smart_scripts` WHERE `entryorguid`=11912 AND `source_type`=0;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(11912,0,0,0,4,0,100,0,0,0,0,0,11,6268,0,0,0,0,0,2,0,0,0,0,0,0,0,'Grimtotem Brute - On Aggro - Cast RushIng Charge'),
(11912,0,1,0,2,0,100,1,0,15,0,0,25,1,0,0,0,0,0,1,0,0,0,0,0,0,0,'Grimtotem Brute - Between 0-15% Health - Flee For Assist (No Repeat)');

UPDATE `creature_template` SET `AIName`='SmartAI' WHERE `entry`=17236;
DELETE FROM `smart_scripts` WHERE `entryorguid`=17236 AND `source_type`=0;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(17236,0,0,0,6,0,100,0,0,0,0,0,11,11018,0,0,0,0,0,7,0,0,0,0,0,0,0,'Tcha\'kaz - On Death - Summon Witherbark Bloodlings');

DELETE FROM `creature_text` WHERE `CreatureID`=11918;
INSERT INTO `creature_text` (`CreatureID`, `GroupID`, `ID`, `Text`, `Type`, `Language`, `Probability`, `Emote`, `Duration`, `Sound`, `BroadcastTextId`, `TextRange`, `comment`) VALUES
(11918,0,0,'You NO take candle!',12,0,100,0,0,0,16658,0,'Gogger Stonepounder'),
(11918,0,1,'Yiieeeee! Me run!',12,0,100,0,0,0,1864,0,'Gogger Stonepounder'),
(11918,0,2,'No kill me! No kill me!',12,0,100,0,0,0,1863,0,'Gogger Stonepounder');

UPDATE `creature_template` SET `AIname`='SmartAI' WHERE `entry`=4021;
DELETE FROM `smart_scripts` WHERE `entryorguid`=4021 AND `source_type`=0;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(4021,0,0,0,9,0,100,0,0,30,5000,11000,11,3396,32,0,0,0,0,2,0,0,0,0,0,0,0,'Corrosive Sap Beast - Within 0-30 Range - Cast Corrosive Poison');

UPDATE `creature_template` SET `AIname`='SmartAI' WHERE `entry`=4030;
DELETE FROM `smart_scripts` WHERE `entryorguid`=4030 AND `source_type`=0;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(4030,0,0,0,9,0,100,0,0,5,17000,25000,11,6909,32,0,0,0,0,2,0,0,0,0,0,0,0,'Vengeful Ancient - Within 0-5 Range - Cast Curse of Thorns');

UPDATE `creature_template` SET `AIname`='SmartAI' WHERE `entry`=4016;
DELETE FROM `smart_scripts` WHERE `entryorguid`=4016 AND `source_type`=0;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(4016,0,0,0,9,0,100,1,0,30,0,0,11,7994,0,0,0,0,0,2,0,0,0,0,0,0,0,'Fey Dragon - Within 0-30 Range - Cast Nullify Mana (No Repeat)');

DELETE FROM `creature` WHERE `guid` IN (36898, 36904, 36907, 36924, 36938, 36942, 36943, 36944, 36957, 36956, 36958);
DELETE FROM `creature_addon` WHERE `guid` IN (36898, 36904, 36907, 36924, 36938, 36942, 36943, 36944, 36957, 36956, 36958);

UPDATE `creature` SET `position_x`=6594.56, `position_y`=313.645, `position_z`=28.3839 WHERE `guid`=36643;
UPDATE `creature` SET `position_x`=4424.85, `position_y`=422.488, `position_z`=56.4554 WHERE `guid`=36794;
UPDATE `creature` SET `position_x`=7742.69, `position_y`=-1067.14, `position_z`=38.1206 WHERE `guid`=36959;

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 7768;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 7768);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(7768, 0, 0, 0, 7, 0, 100, 0, 0, 0, 0, 0, 41, 5000, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Witherbark Bloodling - On Evade - Despawn In 5000 ms');

--
-- END UPDATING QUERIES
--
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
