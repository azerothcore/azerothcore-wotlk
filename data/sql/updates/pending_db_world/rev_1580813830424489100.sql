INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1580813830424489100');
-- Cliff Stormer
UPDATE `creature_template` SET `AIName`="SmartAI" WHERE `entry`=4008;
DELETE FROM `smart_scripts` WHERE `entryorguid`=4008 AND `source_type`=0;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(4008,0,0,0,0,0,100,0,3000,5000,6000,8000,11,5401,0,0,0,0,0,2,0,0,0,0,0,0,0,"Cliff Stormer - In Combat - Cast Lizard Bolt");

-- Raging Cliff Stormer
UPDATE `creature_template` SET `AIName`="SmartAI" WHERE `entry`=4009;
DELETE FROM `smart_scripts` WHERE `entryorguid`=4009 AND `source_type`=0;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(4009,0,0,0,4,0,100,0,0,0,0,0,11,6268,0,0,0,0,0,2,0,0,0,0,0,0,0,"Raging Cliff Stormer - On Aggro - Cast Rushing Charge"),
(4009,0,1,0,9,0,100,0,0,8,12000,15000,11,8078,0,0,0,0,0,1,0,0,0,0,0,0,0,"Raging Cliff Stormer - Within 0-8 Range - Cast Thunderclap");

-- Sorrow Wing
UPDATE `creature_template` SET `AIName`="SmartAI" WHERE `entry`=5928;
DELETE FROM `smart_scripts` WHERE `entryorguid`=5928 AND `source_type`=0;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(5928,0,0,0,9,0,100,0,0,5,6000,12000,11,3388,32,0,0,0,0,2,0,0,0,0,0,0,0,"Sorrow Wing - In Combat - Cast Deadly Leech Poison"),
(5928,0,1,0,0,0,100,0,11000,18000,12000,15000,11,3405,0,0,0,0,0,2,0,0,0,0,0,0,0,"Sorrow Wing - IC - Cast Soul Rend");

-- Deepmoss Webspinner
UPDATE `creature_template` SET `AIName`="SmartAI" WHERE `entry`=4006;
DELETE FROM `smart_scripts` WHERE `entryorguid`=4006 AND `source_type`=0;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(4006,0,0,0,9,0,100,0,0,30,8000,12000,11,745,0,0,0,0,0,2,0,0,0,0,0,0,0,"Deepmoss Webspinner - In Combat - Cast Web");

-- Deepmoss Venomspitter
UPDATE `creature_template` SET `AIName`="SmartAI" WHERE `entry`=4007;
DELETE FROM `smart_scripts` WHERE `entryorguid`=4007 AND `source_type`=0;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(4007,0,0,0,0,0,100,0,0,0,2300,3900,11,7951,64,0,0,0,0,2,0,0,0,0,0,0,0,"Deepmoss Venomspitter - In Combat - Cast Toxic Spit");

-- Young Pridewing
UPDATE `creature_template` SET `AIName`="SmartAI" WHERE `entry`=4011;
DELETE FROM `smart_scripts` WHERE `entryorguid`=4011 AND `source_type`=0;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(4011,0,0,0,0,0,100,0,5000,8000,12000,18000,11,744,32,0,0,0,0,2,0,0,0,0,0,0,0,"Young Pridewing - In Combat - Cast Poison");

-- Pridewing Patriarch
UPDATE `creature_template` SET `AIName`="SmartAI" WHERE `entry`=4015;
DELETE FROM `smart_scripts` WHERE `entryorguid`=4015 AND `source_type`=0;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(4015,0,0,0,0,0,100,0,5000,8000,12000,18000,11,744,32,0,0,0,0,2,0,0,0,0,0,0,0,"Pridewing Patriarch - In Combat - Cast Poison");

-- Pridewing Wyvern
UPDATE `creature_template` SET `AIName`="SmartAI" WHERE `entry`=4012;
DELETE FROM `smart_scripts` WHERE `entryorguid`=4012 AND `source_type`=0;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(4012,0,0,0,0,0,100,0,5000,8000,12000,18000,11,744,32,0,0,0,0,2,0,0,0,0,0,0,0,"Pridewing Wyvern - In Combat - Cast Poison");

-- Pridewing Skyhunter
UPDATE `creature_template` SET `AIName`="SmartAI" WHERE `entry`=4013;
DELETE FROM `smart_scripts` WHERE `entryorguid`=4013 AND `source_type`=0;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(4013,0,0,0,0,0,100,0,3000,5000,12000,18000,11,744,32,0,0,0,0,2,0,0,0,0,0,0,0,"Pridewing Skyhunter - In Combat - Cast Poison"),
(4013,0,1,0,0,0,100,0,5000,8000,9000,12000,11,5708,0,0,0,0,0,2,0,0,0,0,0,0,0,"Pridewing Skyhunter - In Combat - Cast Swoop");

-- Deepmoss Hatchling
UPDATE `creature_template` SET `AIName`="SmartAI" WHERE `entry`=4263;
DELETE FROM `smart_scripts` WHERE `entryorguid`=4263 AND `source_type`=0;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(4263,0,0,0,2,0,50,1,0,30,0,0,11,6536,0,0,0,0,0,1,0,0,0,0,0,0,0,"Deepmoss Hatchling - At 30% HP - Summon Deepmoss Matriarch");

-- Venture Co. Logger
UPDATE `creature_template` SET `AIName`="SmartAI" WHERE `entry`=3989;
DELETE FROM `smart_scripts` WHERE `entryorguid`=3989 AND `source_type`=0;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(3989,0,0,0,0,0,100,0,0,0,2300,3900,11,10277,64,0,0,0,0,2,0,0,0,0,0,0,0,"Venture Co. Logger - In Combat CMC - Cast Throw"),
(3989,0,1,0,2,0,100,1,0,15,0,0,25,1,0,0,0,0,0,1,0,0,0,0,0,0,0,"Venture Co. Logger - Between 0-15% Health - Flee For Assist (No Repeat)");

-- Venture Co. Operator
UPDATE `creature_template` SET `AIName`="SmartAI" WHERE `entry`=3988;
DELETE FROM `smart_scripts` WHERE `entryorguid`=3988 AND `source_type`=0;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(3988,0,0,0,2,0,100,1,0,15,0,0,25,1,0,0,0,0,0,1,0,0,0,0,0,0,0,"Venture Co. Operator - Between 0-15% Health - Flee For Assist (No Repeat)");

-- Venture Co. Deforester
UPDATE `creature_template` SET `AIName`="SmartAI" WHERE `entry`=3991;
DELETE FROM `smart_scripts` WHERE `entryorguid`=3991 AND `source_type`=0;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(3991,0,0,0,0,0,100,0,0,0,3400,4800,11,20793,64,0,0,0,0,2,0,0,0,0,0,0,0,"Venture Co. Deforester - In Combat - Cast Fireball"),
(3991,0,1,0,0,0,100,0,9000,16000,18000,24000,11,5740,0,0,0,0,0,2,0,0,0,0,0,0,0,"Venture Co. Deforester - In Combat - Cast Rain of Fire"),
(3991,0,2,0,2,0,100,1,0,15,0,0,25,1,0,0,0,0,0,1,0,0,0,0,0,0,0,"Venture Co. Deforester - Between 0-15% Health - Flee For Assist (No Repeat)");

-- Venture Co. Engineer
UPDATE `creature_template` SET `AIName`="SmartAI" WHERE `entry`=3992;
DELETE FROM `smart_scripts` WHERE `entryorguid`=3992 AND `source_type`=0;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(3992,0,0,0,0,0,100,0,0,0,2300,3900,11,7978,64,0,0,0,0,2,0,0,0,0,0,0,0,"Venture Co. Engineer - In Combat CMC - Cast Throw Dynamite"),
(3992,0,1,0,2,0,100,1,0,15,0,0,25,1,0,0,0,0,0,1,0,0,0,0,0,0,0,"Venture Co. Engineer - Between 0-15% Health - Flee For Assist (No Repeat)");

-- Venture Co. Machine Smith
UPDATE `creature_template` SET `AIName`="SmartAI" WHERE `entry`=3993;
DELETE FROM `smart_scripts` WHERE `entryorguid`=3993 AND `source_type`=0;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(3993,0,0,0,0,0,100,0,5000,9000,70000,85000,11,7979,0,0,0,0,0,1,0,0,0,0,0,0,0,"Venture Co. Machine Smith - IC - Cast Compact Harvest Reaper"),
(3993,0,1,0,2,0,100,1,0,15,0,0,25,1,0,0,0,0,0,1,0,0,0,0,0,0,0,"Venture Co. Machine Smith - Between 0-15% Health - Flee For Assist (No Repeat)");

-- Venture Co. Builder
UPDATE `creature_template` SET `AIName`="SmartAI" WHERE `entry`=4070;
DELETE FROM `smart_scripts` WHERE `entryorguid`=4070 AND `source_type`=0;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(4070,0,0,0,0,0,100,0,0,0,2300,3900,11,6660,64,0,0,0,0,2,0,0,0,0,0,0,0,"Venture Co. Builder - In Combat CMC - Cast Shoot"),
(4070,0,1,0,2,0,100,1,0,15,0,0,25,1,0,0,0,0,0,1,0,0,0,0,0,0,0,"Venture Co. Builder - Between 0-15% Health - Flee For Assist (No Repeat)");

-- Taskmaster Whipfang
UPDATE `creature_template` SET `AIName`="SmartAI" WHERE `entry`=5932;
DELETE FROM `smart_scripts` WHERE `entryorguid`=5932 AND `source_type`=0;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(5932,0,0,0,9,0,100,0,0,8,15000,19000,11,16508,0,0,0,0,0,2,0,0,0,0,0,0,0,"Taskmaster Whipfang - Within 0-8 Range - Cast Intimidating Roar"),
(5932,0,1,0,2,0,100,1,0,20,0,0,25,1,0,0,0,0,0,1,0,0,0,0,0,0,0,"Taskmaster Whipfang - Between 0-20% Health - Flee For Assist (No Repeat)");

-- Foreman Rigger
UPDATE `creature_template` SET `AIName`="SmartAI" WHERE `entry`=5931;
DELETE FROM `smart_scripts` WHERE `entryorguid`=5931 AND `source_type`=0;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(5931,0,0,0,9,0,100,0,0,20,15500,25300,11,6533,0,0,0,0,0,2,0,0,0,0,0,0,0,"Foreman Rigger - Within 0-20 Range - Cast Net"),
(5931,0,1,0,9,0,100,0,0,5,45000,45000,11,6016,0,0,0,0,0,2,0,0,0,0,0,0,0,"Foreman Rigger - Within 0-5 Range - Cast Pierce Armor");

-- Windshear Tunnel Rat
UPDATE `creature_template` SET `AIName`="SmartAI" WHERE `entry`=4001;
DELETE FROM `smart_scripts` WHERE `entryorguid`=4001 AND `source_type`=0;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(4001,0,0,0,0,0,100,0,4000,11000,7000,15000,11,8139,32,0,0,0,0,2,0,0,0,0,0,0,0,"Windshear Tunnel Rat - In Combat - Cast Fevered Fatigue");

-- Windshear Stonecutter
UPDATE `creature_template` SET `AIName`="SmartAI" WHERE `entry`=4002;
DELETE FROM `smart_scripts` WHERE `entryorguid`=4002 AND `source_type`=0;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(4002,0,0,0,2,0,100,1,0,15,0,0,25,1,0,0,0,0,0,1,0,0,0,0,0,0,0,"Windshear Stonecutter - Between 0-15% Health - Flee For Assist (No Repeat)");

-- Windshear Geomancer
UPDATE `creature_template` SET `AIName`="SmartAI" WHERE `entry`=4003;
DELETE FROM `smart_scripts` WHERE `entryorguid`=4003 AND `source_type`=0;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(4003,0,0,0,0,0,100,0,0,0,3400,4800,11,20792,64,0,0,0,0,2,0,0,0,0,0,0,0,"Windshear Geomancer - In Combat CMC - Cast Frostbolt"),
(4003,0,1,0,0,0,100,0,4000,11000,7000,15000,11,8139,32,0,0,0,0,2,0,0,0,0,0,0,0,"Windshear Geomancer - In Combat - Cast Fevered Fatigue"),
(4003,0,2,0,2,0,100,1,0,15,0,0,25,1,0,0,0,0,0,1,0,0,0,0,0,0,0,"Windshear Geomancer - Between 0-15% Health - Flee For Assist (No Repeat)");

-- Windshear Overlord
UPDATE `creature_template` SET `AIName`="SmartAI" WHERE `entry`=4004;
DELETE FROM `smart_scripts` WHERE `entryorguid`=4004 AND `source_type`=0;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(4004,0,0,0,0,0,100,0,1000,3000,30000,45000,11,3631,0,0,0,0,0,1,0,0,0,0,0,0,0,"Windshear Overlord - In Combat - Cast Battle Fury"),
(4004,0,1,0,0,0,100,0,4000,11000,7000,15000,11,8139,32,0,0,0,0,2,0,0,0,0,0,0,0,"Windshear Overlord - In Combat - Cast Fevered Fatigue"),
(4004,0,2,0,2,0,100,1,0,15,0,0,25,1,0,0,0,0,0,1,0,0,0,0,0,0,0,"Windshear Overlord - Between 0-15% Health - Flee For Assist (No Repeat)");

-- Grimtotem Brute
UPDATE `creature_template` SET `AIname`="SmartAI" WHERE `entry`=11912;
DELETE FROM `smart_scripts` WHERE `entryorguid`=11912 AND `source_type`=0;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(11912,0,0,0,4,0,100,0,0,0,0,0,11,6268,0,0,0,0,0,2,0,0,0,0,0,0,0,"Grimtotem Brute - On Aggro - Cast RushIng Charge"),
(11912,0,1,0,2,0,100,1,0,15,0,0,25,1,0,0,0,0,0,1,0,0,0,0,0,0,0,"Grimtotem Brute - Between 0-15% Health - Flee For Assist (No Repeat)");

-- Grimtotem Sorcerer
UPDATE `creature_template` SET `AIname`="SmartAI" WHERE `entry`=11913;
DELETE FROM `smart_scripts` WHERE `entryorguid`=11913 AND `source_type`=0;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(11913,0,0,0,0,0,100,0,0,0,3400,4800,11,20802,64,0,0,0,0,2,0,0,0,0,0,0,0,"Grimtotem Sorcerer - In Combat - Cast LightnIng Bolt"),
(11913,0,1,0,2,0,100,0,0,50,18000,21000,11,12160,0,0,0,0,0,1,0,0,0,0,0,0,0,"Grimtotem Sorcerer - Between 0-50% Health - Cast Rejuvenation"),
(11913,0,2,0,2,0,100,1,0,15,0,0,25,1,0,0,0,0,0,1,0,0,0,0,0,0,0,"Grimtotem Sorcerer - Between 0-15% Health - Flee For Assist (No Repeat)");

-- Grimtotem Ruffian
UPDATE `creature_template` SET `AIname`="SmartAI" WHERE `entry`=11910;
DELETE FROM `smart_scripts` WHERE `entryorguid`=11910 AND `source_type`=0;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(11910,0,0,0,2,0,100,1,0,15,0,0,25,1,0,0,0,0,0,1,0,0,0,0,0,0,0,"Grimtotem Ruffian - Between 0-15% Health - Flee For Assist (No Repeat)");

-- Grimtotem Mercenary
UPDATE `creature_template` SET `AIname`="SmartAI" WHERE `entry`=11911;
DELETE FROM `smart_scripts` WHERE `entryorguid`=11911 AND `source_type`=0;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(11911,0,0,0,0,0,100,0,0,0,2300,3900,11,10277,64,0,0,0,0,2,0,0,0,0,0,0,0,"Grimtotem Mercenary - In Combat - Cast Throw"),
(11911,0,1,0,9,0,100,0,0,5,7000,11000,11,12555,0,0,0,0,0,2,0,0,0,0,0,0,0,"Grimtotem Mercenary - Within 0-5 Range - Cast Pummel"),
(11911,0,2,0,2,0,100,1,0,15,0,0,25,1,0,0,0,0,0,1,0,0,0,0,0,0,0,"Grimtotem Mercenary - Between 0-15% Health - Flee For Assist (No Repeat)");

-- Rogue Flame Spirit
UPDATE `creature_template` SET `AIname`="SmartAI" WHERE `entry`=4036;
DELETE FROM `smart_scripts` WHERE `entryorguid`=4036 AND `source_type`=0;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(4036,0,0,0,9,0,100,0,0,30,120000,125000,11,6205,32,0,0,0,0,2,0,0,0,0,0,0,0,"Rogue Flame Spirit - Within 0-30 Range - Cast Curse of Weakness"),
(4036,0,1,0,0,0,100,0,5000,9000,18000,22000,11,1094,0,0,0,0,0,2,0,0,0,0,0,0,0,"Rogue Flame Spirit - In Combat - Cast Immolate");

-- Charred Ancient
UPDATE `creature_template` SET `AIname`="SmartAI" WHERE `entry`=4028;
DELETE FROM `smart_scripts` WHERE `entryorguid`=4028 AND `source_type`=0;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(4028,0,0,0,9,0,100,0,0,30,14000,20000,11,12747,0,0,0,0,0,2,0,0,0,0,0,0,0,"Charred Ancient - Within 0-30 Range - Cast Entangling Roots");

-- Burning Ravager
UPDATE `creature_template` SET `AIname`="SmartAI" WHERE `entry`=4037;
DELETE FROM `smart_scripts` WHERE `entryorguid`=4037 AND `source_type`=0;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(4037,0,0,0,0,0,100,0,1000,3000,60000,65000,11,184,0,0,0,0,0,1,0,0,0,0,0,0,0,"BurnIng Ravager - In Combat - Cast Fire Shield II");

-- Young Chimaera
UPDATE `creature_template` SET `AIname`="SmartAI" WHERE `entry`=4032;
DELETE FROM `smart_scripts` WHERE `entryorguid`=4032 AND `source_type`=0;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(4032,0,0,0,0,0,100,0,3000,4000,6000,8000,11,9532,0,0,0,0,0,2,0,0,0,0,0,0,0,"Young Chimaera - In Combat CMC - Cast Lightning Bolt");

-- Fledgling Chimaera
UPDATE `creature_template` SET `AIname`="SmartAI" WHERE `entry`=4031;
DELETE FROM `smart_scripts` WHERE `entryorguid`=4031 AND `source_type`=0;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(4031,0,0,0,9,0,100,0,0,30,8000,16000,11,3396,32,0,0,0,0,2,0,0,0,0,0,0,0,"Fledgling Chimaera - Within 0-30 Range - Cast Corrosive Poison");

-- Sap Beast
UPDATE `creature_template` SET `AIname`="SmartAI" WHERE `entry`=4020;
DELETE FROM `smart_scripts` WHERE `entryorguid`=4020 AND `source_type`=0;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(4020,0,0,0,9,0,100,0,0,5,7000,16000,11,7997,32,0,0,0,0,2,0,0,0,0,0,0,0,"Sap Beast - Within 0-5 Range - Cast Sap Might");

-- Corrosive Sap Beast
UPDATE `creature_template` SET `AIname`="SmartAI" WHERE `entry`=4021;
DELETE FROM `smart_scripts` WHERE `entryorguid`=4021 AND `source_type`=0;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(4021,0,0,0,9,0,100,0,0,30,5000,11000,11,3396,32,0,0,0,0,2,0,0,0,0,0,0,0,"Corrosive Sap Beast - Within 0-30 Range - Cast Corrosive Poison");

-- Vengeful Ancient
UPDATE `creature_template` SET `AIname`="SmartAI" WHERE `entry`=4030;
DELETE FROM `smart_scripts` WHERE `entryorguid`=4030 AND `source_type`=0;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(4030,0,0,0,9,0,100,0,0,5,17000,25000,11,6909,32,0,0,0,0,2,0,0,0,0,0,0,0,"Vengeful Ancient - Within 0-5 Range - Cast Curse of Thorns");

-- Burning Destroyer
UPDATE `creature_template` SET `AIname`="SmartAI" WHERE `entry`=4038;
DELETE FROM `smart_scripts` WHERE `entryorguid`=4038 AND `source_type`=0;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(4038,0,0,0,0,0,100,0,0,0,3400,4800,11,9053,64,0,0,0,0,2,0,0,0,0,0,0,0,"Burning Destroyer - In Combat CMC - Cast Fireball"),
(4038,0,1,0,0,0,100,0,7000,11000,13000,16000,11,8000,0,0,0,0,0,2,0,0,0,0,0,0,0,"Burning Destroyer - In Combat CMC - Cast Area Burn");

-- Sister Riven
UPDATE `creature_template` SET `AIname`="SmartAI" WHERE `entry`=5930;
DELETE FROM `smart_scripts` WHERE `entryorguid`=5930 AND `source_type`=0;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(5930,0,0,0,4,0,100,1,0,0,0,0,11,184,2,0,0,0,0,1,0,0,0,0,0,0,0,"Sister Riven - On Aggro - Cast Fire Shield"),
(5930,0,1,0,9,0,100,0,0,20,8000,12000,11,3356,0,0,0,0,0,2,0,0,0,0,0,0,0,"Sister Riven - Within 0-20 Range - Cast Flame Lash"),
(5930,0,2,0,0,0,100,0,7000,10000,30000,30000,11,6725,0,0,0,0,0,4,0,0,0,0,0,0,0,"Sister Riven - In Combat - Cast Flame Spike");

-- Fey Dragon
UPDATE `creature_template` SET `AIname`="SmartAI" WHERE `entry`=4016;
DELETE FROM `smart_scripts` WHERE `entryorguid`=4016 AND `source_type`=0;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(4016,0,0,0,9,0,100,1,0,30,0,0,11,7994,0,0,0,0,0,2,0,0,0,0,0,0,0,"Fey Dragon - Within 0-30 Range - Cast Nullify Mana (No Repeat)");

-- Wily Fey Dragon
UPDATE `creature_template` SET `AIname`="SmartAI" WHERE `entry`=4017;
DELETE FROM `smart_scripts` WHERE `entryorguid`=4017 AND `source_type`=0;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(4017,0,0,0,9,0,100,0,0,30,8000,11000,11,17630,0,0,0,0,0,2,0,0,0,0,0,0,0,"Wily Fey Dragon - Within 0-30 Range - Cast Mana Burn");

-- Cenarion Botanist
UPDATE `creature_template` SET `AIname`="SmartAI" WHERE `entry`=4051;
DELETE FROM `smart_scripts` WHERE `entryorguid`=4051 AND `source_type`=0;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(4051,0,0,0,0,0,100,0,0,0,3400,4800,11,9739,64,0,0,0,0,2,0,0,0,0,0,0,0,"Cenarion Botanist - In Combat CMC - Cast Wrath"),
(4051,0,1,0,2,0,100,0,0,50,16100,17400,11,1430,1,0,0,0,0,1,0,0,0,0,0,0,0,"Cenarion Botanist - Between 0-50% Health - Cast Rejuvenation"),
(4051,0,2,0,2,0,100,1,0,15,0,0,25,1,0,0,0,0,0,7,0,0,0,0,0,0,0,"Cenarion Botanist - Between 0-15% Health - Flee for Assist (No Repeat)");

-- Cenarion Caretaker
UPDATE `creature_template` SET `AIname`="SmartAI" WHERE `entry`=4050;
DELETE FROM `smart_scripts` WHERE `entryorguid`=4050 AND `source_type`=0;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(4050,0,0,0,1,0,100,0,0,0,300000,300000,11,7090,0,0,0,0,0,1,0,0,0,0,0,0,0,"Cenarion Caretaker - Out of Combat - Cast Bear Form"),
(4050,0,1,0,4,0,100,1,0,0,0,0,11,782,1,0,0,0,0,1,0,0,0,0,0,0,0,"Cenarion Caretaker - On Aggro - Cast Thorns"),
(4050,0,2,0,9,0,100,0,0,5,7000,10000,11,12161,0,0,0,0,0,2,0,0,0,0,0,0,0,"Cenarion Caretaker - Within 0-5 Range - Cast Maul"),
(4050,0,3,0,2,0,100,1,0,15,0,0,25,1,0,0,0,0,0,7,0,0,0,0,0,0,0,"Cenarion Protector - Between 0-15% Health - Flee for Assist (No Repeat)"),
(4050,0,4,0,2,0,100,1,0,15,0,0,28,7090,0,0,0,0,0,1,0,0,0,0,0,0,0,"Cenarion Protector - Between 0-15% Health - Remove Bear Form");

-- Gatekeeper Kordurus
UPDATE `creature_template` SET `AIname`="SmartAI" WHERE `entry`=4409;
DELETE FROM `smart_scripts` WHERE `entryorguid`=4409 AND `source_type`=0;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(4409,0,0,0,2,0,100,1,0,15,0,0,25,1,0,0,0,0,0,1,0,0,0,0,0,0,0,"Gatekeeper Kordurus - Between 0-15% Health - Flee for Assist (No Repeat)");

-- Rynthariel the Keymaster
UPDATE `creature_template` SET `AIname`="SmartAI" WHERE `entry`=8518;
DELETE FROM `smart_scripts` WHERE `entryorguid`=8518 AND `source_type`=0;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(8518,0,0,0,0,0,100,0,0,0,2300,3900,11,10277,64,0,0,0,0,2,0,0,0,0,0,0,0,"Rynthariel the Keymaster - In Combat CMC - Cast Throw"),
(8518,0,1,0,9,0,100,0,0,30,10000,16000,11,7992,32,0,0,0,0,2,0,0,0,0,0,0,0,"Rynthariel the Keymaster - Within 0-30 Range - Cast Slowing Poison"),
(8518,0,2,0,2,0,100,1,0,15,0,0,25,1,0,0,0,0,0,1,0,0,0,0,0,0,0,"Rynthariel the Keymaster - Between 0-15% Health - Flee for Assist (No Repeat)");

-- Cenarion Druid
UPDATE `creature_template` SET `AIname`="SmartAI" WHERE `entry`=4052;
DELETE FROM `smart_scripts` WHERE `entryorguid`=4052 AND `source_type`=0;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(4052,0,0,0,4,0,100,1,0,0,0,0,22,1,0,0,0,0,0,1,0,0,0,0,0,0,0,"Cenarion Druid - On Aggro - Set Event Phase 1"),
(4052,0,1,0,0,1,100,0,0,0,3400,4700,11,9739,64,0,0,0,0,2,0,0,0,0,0,0,0,"Cenarion Druid - In Combat (Phase 1) - Cast Wrath"),
(4052,0,2,0,2,0,100,1,0,50,0,0,22,2,0,0,0,0,0,1,0,0,0,0,0,0,0,"Cenarion Druid - Between 0-50% Health - Set Event Phase 2"),
(4052,0,3,0,0,2,100,1,0,0,0,0,11,5759,1,0,0,0,0,1,0,0,0,0,0,0,0,"Cenarion Druid - In Combat (Phase 2) - Cast Cat Form"),
(4052,0,5,0,0,2,100,1,0,0,0,0,21,1,0,0,0,0,0,1,0,0,0,0,0,0,0,"Cenarion Druid - In Combat (Phase 2) - Enable Combat Movement"),
(4052,0,4,0,0,2,100,0,12000,16000,30000,35000,11,5217,0,0,0,0,0,1,0,0,0,0,0,0,0,"Cenarion Druid - In Combat (Phase 2) - Cast Tiger\'s Fury");

-- Mirkfallon Dryad
UPDATE `creature_template` SET `AIname`="SmartAI" WHERE `entry`=4061;
DELETE FROM `smart_scripts` WHERE `entryorguid`=4061 AND `source_type`=0;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(4061,0,0,0,0,0,100,0,0,0,2300,3900,11,10277,64,0,0,0,0,2,0,0,0,0,0,0,0,"Mirkfallon Dryad - In Combat CMC - Cast Throw"),
(4061,0,1,0,9,0,100,0,0,30,10000,16000,11,7992,32,0,0,0,0,2,0,0,0,0,0,0,0,"Mirkfallon Dryad - Within 0-30 Range - Cast Slowing Poison"),
(4061,0,2,0,2,0,100,1,0,15,0,0,25,1,0,0,0,0,0,1,0,0,0,0,0,0,0,"Mirkfallon Dryad - Between 0-15% Health - Flee for Assist (No Repeat)");

-- Brother Ravenoak
UPDATE `creature_template` SET `AIname`="SmartAI" WHERE `entry`=5915;
DELETE FROM `smart_scripts` WHERE `entryorguid`=5915 AND `source_type`=0;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(5915,0,0,0,4,0,100,1,0,0,0,0,11,7090,0,0,0,0,0,1,0,0,0,0,0,0,0,"Brother Ravenoak - On Aggro - Cast Bear Form"),
(5915,0,1,0,9,0,100,0,0,5,12000,15000,11,12161,0,0,0,0,0,2,0,0,0,0,0,0,0,"Brother Ravenoak - Within 0-5 Range - Cast Maul"),
(5915,0,2,0,9,0,100,0,0,5,17000,22000,11,8716,0,0,0,0,0,2,0,0,0,0,0,0,0,"Brother Ravenoak - Within 0-5 Range - Cast Low Swipe"),
(5915,0,3,0,1,0,100,0,30000,30000,480000,480000,11,7090,0,0,0,0,0,1,0,0,0,0,0,0,0,"Brother Ravenoak - Out of Combat - Cast Bear Form"),
(5915,0,4,0,2,0,100,0,0,75,21000,26000,11,2090,0,0,0,0,0,1,0,0,0,0,0,0,0,"Brother Ravenoak - Between 0-75% Health - Cast Rejuvenation");

-- Mirkfallon Keeper
UPDATE `creature_template` SET `AIname`="SmartAI" WHERE `entry`=4056;
DELETE FROM `smart_scripts` WHERE `entryorguid`=4056 AND `source_type`=0;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(4056,0,0,0,9,0,100,0,0,30,14000,26000,11,8138,32,0,0,0,0,2,0,0,0,0,0,0,0,"Mirkfallon Keeper - Within 0-5 Range - Cast Mirkfallon Fungus");

-- Nal'taszar
UPDATE `creature_template` SET `AIname`="SmartAI" WHERE `entry`=4066;
DELETE FROM `smart_scripts` WHERE `entryorguid`=4066 AND `source_type`=0;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(4066,0,0,0,9,0,100,0,0,30,11000,18000,11,8211,0,0,0,0,0,2,0,0,0,0,0,0,0,"Nal\'taszar - Within 0-30 Range - Cast Chain Burn"),
(4066,0,1,0,0,0,100,0,8000,13000,12000,15000,11,15305,0,0,0,0,0,2,0,0,0,0,0,0,0,"Nal\'taszar - In Combat - Cast Chain Lightning");

-- Gogger Rock Keeper
UPDATE `creature_template` SET `AIName`="SmartAI" WHERE `entry`=11915;
DELETE FROM `smart_scripts` WHERE `entryorguid`=11915 AND `source_type`=0;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(11915,0,0,0,4,0,15,1,0,0,0,0,1,0,0,0,0,0,0,7,0,0,0,0,0,0,0,"Gogger Rock Keeper - On Aggro - Say Line 0"),
(11915,0,1,0,9,0,100,0,0,20,9000,15000,11,13281,0,0,0,0,0,2,0,0,0,0,0,0,0,"Gogger Rock Keeper - In Combat - Cast Earth Shock"),
(11915,0,2,0,2,0,100,1,0,15,0,0,25,1,0,0,0,0,0,1,0,0,0,0,0,0,0,"Gogger Rock Keeper - Between 0-15% Health - Flee For Assist (No Repeat)");

DELETE FROM `creature_text` WHERE `CreatureID`=11915;
INSERT INTO `creature_text` (`CreatureID`, `GroupID`, `ID`, `Text`, `Type`, `Language`, `Probability`, `Emote`, `Duration`, `Sound`, `BroadcastTextId`, `TextRange`, `comment`) VALUES
(11915,0,0,"You no take candle!",12,0,100,0,0,0,16658,0,"Gogger Rock Keeper"),
(11915,0,1,"Yiieeeee! Me run!",12,0,100,0,0,0,1864,0,"Gogger Rock Keeper"),
(11915,0,2,"No kill me! No kill me!",12,0,100,0,0,0,1863,0,"Gogger Rock Keeper");

-- Gogger Geomancer
UPDATE `creature_template` SET `AIName`="SmartAI" WHERE `entry`=11917;
DELETE FROM `smart_scripts` WHERE `entryorguid`=11917 AND `source_type`=0;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(11917,0,0,0,4,0,15,1,0,0,0,0,1,0,0,0,0,0,0,7,0,0,0,0,0,0,0,"Gogger Geomancer - On Aggro - Say Line 0"),
(11917,0,1,0,0,0,100,0,0,0,3400,4800,11,20793,64,0,0,0,0,2,0,0,0,0,0,0,0,"Gogger Geomancer - In Combat - Cast Fireball"),
(11917,0,2,0,0,0,100,0,11000,17000,12000,18000,11,11990,0,0,0,0,0,2,0,0,0,0,0,0,0,"Gogger Geomancer - In Combat - Cast Rain of Fire");

DELETE FROM `creature_text` WHERE `CreatureID`=11917;
INSERT INTO `creature_text` (`CreatureID`, `GroupID`, `ID`, `Text`, `Type`, `Language`, `Probability`, `Emote`, `Duration`, `Sound`, `BroadcastTextId`, `TextRange`, `comment`) VALUES
(11917,0,0,"You NO take candle!",12,0,100,0,0,0,16658,0,"Gogger Geomancer"),
(11917,0,1,"Yiieeeee! Me run!",12,0,100,0,0,0,1864,0,"Gogger Geomancer"),
(11917,0,2,"No kill me! No kill me!",12,0,100,0,0,0,1863,0,"Gogger Geomancer");

-- Gogger Stonepounder
UPDATE `creature_template` SET `AIName`="SmartAI" WHERE `entry`=11918;
DELETE FROM `smart_scripts` WHERE `entryorguid`=11918 AND `source_type`=0;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(11918,0,0,0,4,0,15,1,0,0,0,0,1,0,0,0,0,0,0,7,0,0,0,0,0,0,0,"Gogger Stonepounder - On Aggro - Say Line 0"),
(11918,0,1,0,2,0,100,1,0,15,0,0,25,1,0,0,0,0,0,1,0,0,0,0,0,0,0,"Gogger Stonepounder - Between 0-15% Health - Flee For Assist (No Repeat)");

DELETE FROM `creature_text` WHERE `CreatureID`=11918;
INSERT INTO `creature_text` (`CreatureID`, `GroupID`, `ID`, `Text`, `Type`, `Language`, `Probability`, `Emote`, `Duration`, `Sound`, `BroadcastTextId`, `TextRange`, `comment`) VALUES
(11918,0,0,"You NO take candle!",12,0,100,0,0,0,16658,0,"Gogger Stonepounder"),
(11918,0,1,"Yiieeeee! Me run!",12,0,100,0,0,0,1864,0,"Gogger Stonepounder"),
(11918,0,2,"No kill me! No kill me!",12,0,100,0,0,0,1863,0,"Gogger Stonepounder");

-- Moonstalker Matriarch
UPDATE `creature_template` SET `AIName`="SmartAI" WHERE `entry`=2071;
DELETE FROM `smart_scripts` WHERE `entryorguid`=2071;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(2071,0,0,0,1,0,100,1,3000,5000,0,0,11,8594,0,0,0,0,0,1,0,0,0,0,0,0,0,'Moonstalker Matriarch - Out of Combat - Cast Summon Moonstalker Runt (No Repeat)');

-- Moonstalker Sire
UPDATE `creature_template` SET `AIName`="SmartAI" WHERE `entry`=2237;
DELETE FROM `smart_scripts` WHERE `entryorguid`=2237;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(2237,0,0,0,9,0,100,0,0,5,10000,14000,11,6595,0,0,0,0,0,2,0,0,0,0,0,0,0,'Moonstalker Sire - Within 0-5 Range - Cast Exploit Weakness');

-- Grizzled Thistle Bear
UPDATE `creature_template` SET `AIName`="SmartAI" WHERE `entry`=2165;
DELETE FROM `smart_scripts` WHERE `entryorguid`=2165;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(2165,0,0,0,0,0,100,0,3000,5000,7000,10000,11,3242,0,0,0,0,0,2,0,0,0,0,0,0,0,'Grizzled Thistle Bear - In Combat - Cast Ravage');

-- Strider Clutchmother
UPDATE `creature_template` SET `AIName`="SmartAI" WHERE `entry`=2172;
DELETE FROM `smart_scripts` WHERE `entryorguid`=2172;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(2172,0,0,0,0,0,100,0,7000,11000,12000,14000,11,7272,0,0,0,0,0,1,0,0,0,0,0,0,0,'Strider Clutchmother - In Combat - Cast Dust Cloud'),
(2172,0,1,0,9,0,100,0,0,5,15000,17000,11,6607,0,0,0,0,0,2,0,0,0,0,0,0,0,'Strider Clutchmother - Within 0-5 Range - Cast Lash'),
(2172,0,2,0,2,0,100,1,0,15,0,0,25,1,0,0,0,0,0,1,0,0,0,0,0,0,0,'Strider Clutchmother - Between 0-15% Health - Flee For Assist (No Repeat)');

-- Shadowclaw
UPDATE `creature_template` SET `AIName`="SmartAI" WHERE `entry`=2175;
DELETE FROM `smart_scripts` WHERE `entryorguid`=2175;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(2175,0,0,0,9,0,100,0,0,30,12000,15000,11,17227,0,0,0,0,0,2,0,0,0,0,0,0,0,'Shadowclaw - Within 0-30 Range - Cast Curse of Weakness');

-- Moonkin Oracle
UPDATE `creature_template` SET `AIName`="SmartAI" WHERE `entry`=10157;
DELETE FROM `smart_scripts` WHERE `entryorguid`=10157;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(10157,0,0,0,0,0,100,0,1000,2000,2000,2000,11,9739,64,0,0,0,0,2,0,0,0,0,0,0,0,'Moonkin Oracle - In Combat - Cast Wrath'),
(10157,0,1,0,0,0,100,0,7000,11000,12000,15000,11,15798,1,0,0,0,0,2,0,0,0,0,0,0,0,'Moonkin Oracle - In Combat - Cast Moonfire'),
(10157,0,2,0,14,0,100,0,200,40,25000,30000,11,16561,1,0,0,0,0,7,0,0,0,0,0,0,0,'Moonkin Oracle - Friendly At 200 Health - Cast Regrowth');

-- Moonkin
UPDATE `creature_template` SET `AIName`="SmartAI" WHERE `entry`=10158;
DELETE FROM `smart_scripts` WHERE `entryorguid`=10158;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(10158,0,0,0,4,0,100,0,0,0,0,0,75,12787,0,0,0,0,0,1,0,0,0,0,0,0,0,'Moonkin Cast Thrash on reset');

-- Raging Moonkin
UPDATE `creature_template` SET `AIName`="SmartAI" WHERE `entry`=10160;
DELETE FROM `smart_scripts` WHERE `entryorguid`=10160;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(10160,0,0,0,2,0,100,1,0,30,0,0,11,8599,1,0,0,0,0,1,0,0,0,0,0,0,0,'Raging Moonkin - Between 0-30% Health - Cast Enrage (No Repeat)'),
(10160,0,1,0,9,0,100,0,0,5,10000,15000,11,13443,0,0,0,0,0,2,0,0,0,0,0,0,0,'Raging Moonkin - Within 0-5 Range - Cast Rend');

-- Wild Grell
UPDATE `creature_template` SET `AIName`="SmartAI" WHERE `entry`=2190;
DELETE FROM `smart_scripts` WHERE `entryorguid`=2190;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(2190,0,0,0,2,0,100,0,0,30,60000,60000,11,5915,0,0,0,0,0,1,0,0,0,0,0,0,0,'Wild Grell - Between 0-30% Health - Cast Crazed');

-- Deth'ryll Satyr
UPDATE `creature_template` SET `AIName`="SmartAI" WHERE `entry`=2212;
DELETE FROM `smart_scripts` WHERE `entryorguid`=2212;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(2212,0,0,0,0,0,100,0,1000,2000,3500,4100,11,6660,64,0,0,0,0,2,0,0,0,0,0,0,0,'Dethryll Satyr - In Combat - Cast Shoot');

-- Licillin
UPDATE `creature_template` SET `AIName`="SmartAI" WHERE `entry`=2191;
DELETE FROM `smart_scripts` WHERE `entryorguid`=2191;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(2191,0,0,0,0,0,100,0,1000,2000,3000,3500,11,20793,64,0,0,0,0,2,0,0,0,0,0,0,0,'Licillin - In Combat - Cast Fireball'),
(2191,0,1,0,9,0,100,0,0,30,20000,25000,11,11980,1,0,0,0,0,2,0,0,0,0,0,0,0,'Licillin - Within 0-30 Range - Cast Curse of Weakness');

-- Blackwood Pathfinder
UPDATE `creature_template` SET `AIName`="SmartAI" WHERE `entry`=2167;
DELETE FROM `smart_scripts` WHERE `entryorguid`=2167;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(2167,0,0,0,9,0,100,0,0,30,30000,35000,11,6950,0,0,0,0,0,2,0,0,0,0,0,0,0,'Blackwood Pathfinder - Within 0-30 Range - Cast Faerie Fire'),
(2167,0,1,0,4,0,100,0,0,0,0,0,75,54913,0,0,0,0,0,1,0,0,0,0,0,0,0,'Blackwood Pathfinder - Within 0-5 Range - Cast Thrash');

-- Blackwood Warrior
UPDATE `creature_template` SET `AIName`="SmartAI" WHERE `entry`=2168;
DELETE FROM `smart_scripts` WHERE `entryorguid`=2168;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(2168,0,0,0,9,0,100,0,0,8,8000,13000,11,8078,0,0,0,0,0,2,0,0,0,0,0,0,0,'Blackwood Warrior - Within 0-8 Range - Cast Thunderclap'),
(2168,0,1,0,4,0,100,0,0,0,0,0,11,7165,0,0,0,0,0,1,0,0,0,0,0,0,0,'Blackwood Warrior - Out of Combat - Cast Battle Stance (No Repeat)');

-- Blackwood Totemic
UPDATE `creature_template` SET `AIName`="SmartAI" WHERE `entry`=2169;
DELETE FROM `smart_scripts` WHERE `entryorguid`=2169;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(2169,0,0,0,0,0,100,0,3000,6000,18000,23000,11,5605,0,0,0,0,0,1,0,0,0,0,0,0,0,'Blackwood Totemic - In Combat - Cast Healing Ward');

-- Blackwood Ursa
UPDATE `creature_template` SET `AIName`="SmartAI" WHERE `entry`=2170;
DELETE FROM `smart_scripts` WHERE `entryorguid`=2170;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(2170,0,0,0,14,0,100,0,200,40,18000,21000,11,1058,0,0,0,0,0,7,0,0,0,0,0,0,0,'Blackwood Ursa - Friendly At 200 Health - Cast Rejuvenation');

-- Blackwood Shaman
UPDATE `creature_template` SET `AIName`="SmartAI" WHERE `entry`=2171;
DELETE FROM `smart_scripts` WHERE `entryorguid`=2171;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(2171,0,0,0,0,0,100,0,1000,2000,3000,3400,11,9532,64,0,0,0,0,2,0,0,0,0,0,0,0,'Blackwood Shaman - In Combat CMC - Cast Lightning Bolt'),
(2171,0,1,0,0,0,100,0,9000,14000,11000,15000,11,2606,0,0,0,0,0,2,0,0,0,0,0,0,0,'Blackwood Shaman - In Combat - Cast Shock'),
(2171,0,2,0,14,0,100,0,300,40,16000,21000,11,913,0,0,0,0,0,7,0,0,0,0,0,0,0,'Blackwood Shaman - Friendly At 300 Health - Cast Healing Wave');

-- Blackwood Windtalker
UPDATE `creature_template` SET `AIName`="SmartAI" WHERE `entry`=2324;
DELETE FROM `smart_scripts` WHERE `entryorguid`=2324;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(2324,0,0,0,0,0,100,0,7000,11000,16000,21000,11,6982,0,0,0,0,0,1,0,0,0,0,0,0,0,'Blackwood Windtalker - In Combat - Cast Gust of Wind');

-- Carnivous the Breaker
UPDATE `creature_template` SET `AIName`="SmartAI" WHERE `entry`=2186;
DELETE FROM `smart_scripts` WHERE `entryorguid`=2186;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(2186,0,0,0,25,0,100,0,0,0,0,0,75,8876,0,0,0,0,0,1,0,0,0,0,0,0,0,'Carnivous the Breaker - On Respawn - Cast Thrash (No Repeat)'),
(2186,0,1,0,9,0,100,0,0,0,15000,20000,11,6016,0,0,0,0,0,2,0,0,0,0,0,0,0,'Carnivous the Breaker - Within 0-5 Range - Cast Pierce Armor');

-- Cursed Highborne
UPDATE `creature_template` SET `AIName`="SmartAI" WHERE `entry`=2176;
DELETE FROM `smart_scripts` WHERE `entryorguid`=2176;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(2176,0,0,0,0,0,100,0,5000,9000,10000,13000,11,5884,0,0,0,0,0,2,0,0,0,0,0,0,0,'Cursed Highborne - In Combat - Cast Banshee Curse');

-- Writhing Highborne
UPDATE `creature_template` SET `AIName`="SmartAI" WHERE `entry`=2177;
DELETE FROM `smart_scripts` WHERE `entryorguid`=2177;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(2177,0,0,0,0,0,100,0,5000,9000,10000,13000,11,5884,0,0,0,0,0,5,0,0,0,0,0,0,0,'Writhing Highborne - In Combat - Cast Banshee Curse');

-- Wailing Highborne
UPDATE `creature_template` SET `AIName`="SmartAI" WHERE `entry`=2178;
DELETE FROM `smart_scripts` WHERE `entryorguid`=2178;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(2178,0,0,0,0,0,100,0,5000,9000,10000,13000,11,5884,0,0,0,0,0,5,0,0,0,0,0,0,0,'Wailing Highborne - In Combat - Cast Banshee Curse');

-- Lady Moongazer
UPDATE `creature_template` SET `AIName`="SmartAI" WHERE `entry`=2184;
DELETE FROM `smart_scripts` WHERE `entryorguid`=2184;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(2184,0,0,0,0,0,100,0,1500,2000,3100,3500,11,6660,64,0,0,0,0,2,0,0,0,0,0,0,0,'Lady Moongazer - In Combat - Cast Shoot'),
(2184,0,1,0,9,0,100,0,0,20,8000,11000,11,6533,1,0,0,0,0,2,0,0,0,0,0,0,0,'Lady Moongazer - Within 0-20 Range - Cast Net');

-- Stormscale Siren
UPDATE `creature_template` SET `AIName`="SmartAI" WHERE `entry`=2180;
DELETE FROM `smart_scripts` WHERE `entryorguid`=2180;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(2180,0,0,0,0,0,100,0,1000,2000,2600,3000,11,9734,64,0,0,0,0,2,0,0,0,0,0,0,0,'Stormscale Siren - In Combat - Cast Holy Smite'),
(2180,0,1,0,2,0,100,0,0,50,18000,25000,11,11642,0,0,0,0,0,1,0,0,0,0,0,0,0,'Stormscale Siren - Between 0-50% Health - Cast Heal'),
(2180, 0, 2, 0, 2, 0, 100, 1, 0, 15, 0, 0, 25, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, "Flee at 15% HP");

-- Stormscale Wave Rider
UPDATE `creature_template` SET `AIName`="SmartAI" WHERE `entry`=2179;
DELETE FROM `smart_scripts` WHERE `entryorguid`=2179;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(2179,0,0,0,0,0,100,0,8000,13000,12000,16000,11,13586,0,0,0,0,0,2,0,0,0,0,0,0,0,'Stormscale Wave Rider - In Combat - Cast Aqua Jet');

-- Stormscale Warrior
UPDATE `creature_template` SET `AIName`="SmartAI" WHERE `entry`=2183;
DELETE FROM `smart_scripts` WHERE `entryorguid`=2183;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(2183,0,0,0,0,0,100,0,4000,8000,10000,12000,11,3248,0,0,0,0,0,1,0,0,0,0,0,0,0,'Stormscale Warrior - In Combat - Cast Improved Blocking');

-- Lord Sinslayer
UPDATE `creature_template` SET `AIName`="SmartAI" WHERE `entry`=7017;
DELETE FROM `smart_scripts` WHERE `entryorguid`=7017;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(7017,0,0,0,9,0,100,0,0,5,5000,10000,11,12057,0,0,0,0,0,2,0,0,0,0,0,0,0,'Lord Sinslayer - Within 0-5 Range - Cast Strike'),
(7017,0,1,0,0,0,100,0,9000,12000,9000,12000,11,13586,0,0,0,0,0,2,0,0,0,0,0,0,0,'Lord Sinslayer - In Combat - Cast Aqua Jet');

-- Encrusted Tide Crawler
UPDATE `creature_template` SET `AIName`="SmartAI" WHERE `entry`=2233;
DELETE FROM `smart_scripts` WHERE `entryorguid`=2233;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(2233,0,0,0,0,0,100,0,2000,3000,7000,12000,11,3427,0,0,0,0,0,2,0,0,0,0,0,0,0,'Encrusted Tide Crawler - In Combat - Cast Infected Wound');

-- Greymist Raider
UPDATE `creature_template` SET `AIName`="SmartAI" WHERE `entry`=2201;
DELETE FROM `smart_scripts` WHERE `entryorguid`=2201;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(2201,0,0,0,2,0,100,1,0,15,0,0,25,1,0,0,0,0,0,1,0,0,0,0,0,0,0,'Greymist Raider - Between 0-15% Health - Flee For Assist');

-- Greymist Coastrunner
UPDATE `creature_template` SET `AIName`="SmartAI" WHERE `entry`=2202;
DELETE FROM `smart_scripts` WHERE `entryorguid`=2202;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(2202,0,0,0,2,0,100,1,0,15,0,0,25,1,0,0,0,0,0,1,0,0,0,0,0,0,0,'Greymist Coastrunner - Between 0-15% Health - Flee For Assist');

-- Greymist Seer
UPDATE `creature_template` SET `AIName`="SmartAI" WHERE `entry`=2203;
DELETE FROM `smart_scripts` WHERE `entryorguid`=2203;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(2203,0,0,0,23,0,100,0,324,0,2000,3000,11,324,0,0,0,0,0,1,0,0,0,0,0,0,0,'Greymist Seer - On missing aura - Cast Lightning Shield'),
(2203,0,1,0,16,0,100,0,324,1,9000,29000,11,324,48,0,0,0,0,1,0,0,0,0,0,0,0,'Greymist Seer - On Friendly Unit Missing Buff Lightning Shield - Cast Lightning Shield'),
(2203,0,2,0,74,0,100,0,0,40,14000,18000,11,547,0,0,0,0,0,9,0,0,0,0,0,0,0,'Greymist Seer - On Friendly Between 0-40% Health - Cast Healing Wave'),
(2203,0,3,0,2,0,100,1,0,15,0,0,25,1,0,0,0,0,0,1,0,0,0,0,0,0,0,'Greymist Seer - Between 0-15% Health - Flee For Assist (No Repeat)');

-- Greymist Netter
UPDATE `creature_template` SET `AIName`="SmartAI" WHERE `entry`=2204;
DELETE FROM `smart_scripts` WHERE `entryorguid`=2204;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(2204,0,0,0,9,0,100,0,0,20,8000,14000,11,12024,0,0,0,0,0,2,0,0,0,0,0,0,0,'Greymist Netter - Within 0-20 Range - Cast Net'),
(2204,0,1,0,2,0,100,1,0,15,0,0,25,1,0,0,0,0,0,1,0,0,0,0,0,0,0,'Greymist Netter - Between 0-15% Health - Flee For Assist');

-- Greymist Warrior
UPDATE `creature_template` SET `AIName`="SmartAI" WHERE `entry`=2205;
DELETE FROM `smart_scripts` WHERE `entryorguid`=2205;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(2205,0,0,0,4,0,100,0,0,0,0,0,11,5242,0,0,0,0,0,1,0,0,0,0,0,0,0,'Greymist Warrior - In Combat - Cast Battle Shout'),
(2205,0,1,0,2,0,100,1,0,15,0,0,25,1,0,0,0,0,0,1,0,0,0,0,0,0,0,'Greymist Warrior - Between 0-15% Health - Flee For Assist');

-- Greymist Hunter
UPDATE `creature_template` SET `AIName`="SmartAI" WHERE `entry`=2206;
DELETE FROM `smart_scripts` WHERE `entryorguid`=2206;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(2206,0,0,0,0,0,100,0,1000,2000,2300,3000,11,10277,64,0,0,0,0,2,0,0,0,0,0,0,0,'Greymist Hunter - In Combat CMC - Cast Throw'),
(2206,0,1,0,2,0,100,1,0,15,0,0,25,1,0,0,0,0,0,1,0,0,0,0,0,0,0,'Greymist Hunter - Between 0-15% Health - Flee For Assist');

-- Greymist Tidehunter
UPDATE `creature_template` SET `AIName`="SmartAI" WHERE `entry`=2208;
DELETE FROM `smart_scripts` WHERE `entryorguid`=2208;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(2208,0,0,0,2,0,100,1,0,15,0,0,25,1,0,0,0,0,0,1,0,0,0,0,0,0,0,'Greymist Tidehunter - Between 0-15% Health - Flee For Assist');

-- Flagglemurk the Cruel
UPDATE `creature_template` SET `AIName`="SmartAI" WHERE `entry`=7015;
DELETE FROM `smart_scripts` WHERE `entryorguid`=7015;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(7015,0,0,0,9,0,100,0,0,5,7000,10000,11,11976,0,0,0,0,0,2,0,0,0,0,0,0,0,'Flagglemurk the Cruel - Within 0-5 Range - Cast Strike'),
(7015,0,1,0,0,0,100,0,8000,12000,9000,12000,11,11428,0,0,0,0,0,2,0,0,0,0,0,0,0,'Flagglemurk the Cruel - In Combat - Cast Knockdown'),
(7015,0,2,0,2,0,100,1,0,15,0,0,25,0,0,0,0,0,0,1,0,0,0,0,0,0,0,'Flagglemurk the Cruel - Between 0-15% Health - Flee For Assist (No Repeat)');

-- Darkshore Thresher
UPDATE `creature_template` SET `AIName`="SmartAI" WHERE `entry`=2185;
DELETE FROM `smart_scripts` WHERE `entryorguid`=2185;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(2185,0,0,0,9,0,100,0,0,5,18000,20000,11,6016,0,0,0,0,0,2,0,0,0,0,0,0,0,'Darkshore Thresher - Within 0-5 Range - Cast Pierce Armor');

-- Elder Darkshore Thresher
UPDATE `creature_template` SET `AIName`="SmartAI" WHERE `entry`=2187;
DELETE FROM `smart_scripts` WHERE `entryorguid`=2187;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(2187,0,0,0,9,0,100,0,0,5,19000,21000,11,6016,0,0,0,0,0,2,0,0,0,0,0,0,0,'Elder Darkshore Thresher - Within 0-5 Range - Cast Pierce Armor');

-- Firecaller Radison
UPDATE `creature_template` SET `AIName`="SmartAI" WHERE `entry`=2192;
DELETE FROM `smart_scripts` WHERE `entryorguid`=2192;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(2192,0,0,0,0,0,100,0,1000,2000,3400,4700,11,20793,64,0,0,0,0,2,0,0,0,0,0,0,0,'Firecaller Radison - In Combat - Cast Fireball'),
(2192,0,1,0,9,0,100,0,0,8,11000,13000,11,11969,2,0,0,0,0,2,0,0,0,0,0,0,0,'Firecaller Radison - Within 0-8 Range - Cast Fire Nova'),
(2192,0,2,0,2,0,100,0,0,30,60000,65000,11,5915,2,0,0,0,0,1,0,0,0,0,0,0,0,'Firecaller Radison - Between 0-30% Health - Cast Crazed');

-- Stone Behemoth
UPDATE `creature_template` SET `AIName`="SmartAI" WHERE `entry`=2157;
DELETE FROM `smart_scripts` WHERE `entryorguid`=2157;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(2157,0,0,0,0,0,100,0,5000,11000,13000,16000,11,5810,0,0,0,0,0,1,0,0,0,0,0,0,0,'Stone Behemoth - In Combat - Cast Stone Skin');

-- Lady Vespira
UPDATE `creature_template` SET `AIName`="SmartAI" WHERE `entry`=7016;
DELETE FROM `smart_scripts` WHERE `entryorguid`=7016;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(7016,0,0,0,0,0,100,0,1500,3000,3000,3100,11,6660,64,0,0,0,0,2,0,0,0,0,0,0,0,'Lady Vespira - In Combat - Cast Shoot'),
(7016,0,1,0,9,0,100,0,0,5,9000,14000,11,11428,1,0,0,0,0,2,0,0,0,0,0,0,0,'Lady Vespira - Within 0-5 Range - Cast Knockdown'),
(7016,0,2,0,0,0,100,0,11000,15000,14000,17000,11,12549,1,0,0,0,0,2,0,0,0,0,0,0,0,'Lady Vespira - In Combat - Cast Forked Lightning');

-- Remove Wrong 'Moonstalker Runt' Spawns
DELETE FROM `creature` WHERE `guid` IN (36898, 36904, 36907, 36924, 36938, 36942, 36943, 36944, 36957, 36956, 36958);
DELETE FROM `creature_addon` WHERE `guid` IN (36898, 36904, 36907, 36924, 36938, 36942, 36943, 36944, 36957, 36956, 36958);

UPDATE `creature` SET `position_x`=6594.56, `position_y`=313.645, `position_z`=28.3839 WHERE `guid`=36643;
UPDATE `creature` SET `position_x`=4424.85, `position_y`=422.488, `position_z`=56.4554 WHERE `guid`=36794;
UPDATE `creature` SET `position_x`=7742.69, `position_y`=-1067.14, `position_z`=38.1206 WHERE `guid`=36959;

-- Trained Razorbeak
UPDATE `creature_template` SET `AIName`="SmartAI" WHERE `entry`=2657;
DELETE FROM `smart_scripts` WHERE `entryorguid`=2657 AND `source_type`=0;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(2657,0,0,0,9,0,100,0,0,5,15000,19000,11,3147,0,0,0,0,0,2,0,0,0,0,0,0,0,"Trained Razorbeak - In Combat - Cast Rend Flesh");

-- Mangy Silvermane
UPDATE `creature_template` SET `AIName`="SmartAI" WHERE `entry`=2923;
DELETE FROM `smart_scripts` WHERE `entryorguid`=2923 AND `source_type`=0;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(2923,0,0,0,0,0,100,0,4000,4500,22000,25000,11,8139,0,0,0,0,0,2,0,0,0,0,0,0,0,"Mangy Silvermane - In Combat - Cast Fevered Fatigue");

-- Silvermane Howler
UPDATE `creature_template` SET `AIName`="SmartAI" WHERE `entry`=2925;
DELETE FROM `smart_scripts` WHERE `entryorguid`=2925 AND `source_type`=0;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(2925,0,0,0,0,0,100,0,2000,4500,12000,13000,11,32919,0,0,0,0,0,2,0,0,0,0,0,0,0,"Silvermane Howler - In Combat - Cast Snarl"),
(2925,0,1,0,0,0,100,0,6000,9000,18000,22000,11,3149,0,0,0,0,0,1,0,0,0,0,0,0,0,"Silvermane Howler - In Combat - Cast Furious Howl");

-- Silvermane Stalker
UPDATE `creature_template` SET `AIName`="SmartAI" WHERE `entry`=2926;
DELETE FROM `smart_scripts` WHERE `entryorguid`=2926 AND `source_type`=0;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(2926,0,0,0,0,0,100,0,4000,5000,17000,19000,11,7367,0,0,0,0,0,2,0,0,0,0,0,0,0,"Silvermane Stalker - In Combat - Cast Infected Bite"),
(2926,0,1,0,25,0,100,1,0,0,0,0,11,6408,0,0,0,0,0,1,0,0,0,0,0,0,0,"Silvermane Stalker - On Reset - Cast Faded (No Repeat)");

-- Old Cliff Jumper
UPDATE `creature_template` SET `AIName`="SmartAI" WHERE `entry`=8211;
DELETE FROM `smart_scripts` WHERE `entryorguid`=8211 AND `source_type`=0;

INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(8211,0,0,0,9,0,100,0,0,8,15000,18000,11,3264,0,0,0,0,0,1,0,0,0,0,0,0,0,"Old Cliff Jumper - Within 0-8 Range - Cast Blood Howl"),
(8211,0,1,0,9,0,100,0,0,5,20000,25000,11,3604,0,0,0,0,0,2,0,0,0,0,0,0,0,"Old Cliff Jumper - Within 0-5 Range - Cast Tendon Rip");

-- Vicious Owlbeast
UPDATE `creature_template` SET `AIName`="SmartAI" WHERE `entry`=2927;
DELETE FROM `smart_scripts` WHERE `entryorguid`=2927 AND `source_type`=0;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(2927,0,0,0,9,0,100,0,0,5,18000,24000,11,7938,0,0,0,0,0,2,0,0,0,0,0,0,0,"Vicious Owlbeast - Within 0-5 Range - Cast Fatal Bite");

-- Primitive Owlbeast
UPDATE `creature_template` SET `AIName`="SmartAI" WHERE `entry`=2928;
DELETE FROM `smart_scripts` WHERE `entryorguid`=2928 AND `source_type`=0;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(2928,0,0,0,9,0,100,0,0,5,13000,16000,11,3252,0,0,0,0,0,2,0,0,0,0,0,0,0,"Primitive Owlbeast - Within 0-5 Range - Cast Shred");

-- Razortalon
UPDATE `creature_template` SET `AIName`="SmartAI" WHERE `entry`=8210;
DELETE FROM `smart_scripts` WHERE `entryorguid`=8210 AND `source_type`=0;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(8210,0,0,0,9,0,100,0,0,5,9000,12000,11,13584,0,0,0,0,0,2,0,0,0,0,0,0,0,"Razortalon - Within 0-5 Range - Cast Strike"),
(8210,0,1,0,9,0,100,0,0,5,20000,25000,11,3604,0,0,0,0,0,2,0,0,0,0,0,0,0,"Razortalon - Within 0-5 Range - Cast Tendon Rip"),
(8210,0,2,0,0,0,100,0,6000,11000,18000,21000,11,13443,0,0,0,0,0,2,0,0,0,0,0,0,0,"Razortalon - In Combat - Cast Rend");

-- Jade Ooze
UPDATE `creature_template` SET `AIName`="SmartAI" WHERE `entry`=2656;
DELETE FROM `smart_scripts` WHERE `entryorguid`=2656 AND `source_type`=0;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(2656,0,0,0,0,0,100,0,4000,6000,16000,18000,11,6907,0,0,0,0,0,2,0,0,0,0,0,0,0,"Jade Ooze - In Combat - Cast Diseased Slime");

-- Green Sludge
UPDATE `creature_template` SET `AIName`="SmartAI" WHERE `entry`=2655;
DELETE FROM `smart_scripts` WHERE `entryorguid`=2655 AND `source_type`=0;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(2655,0,0,0,0,0,100,0,4000,6000,12000,16000,11,9459,0,0,0,0,0,2,0,0,0,0,0,0,0,"Green Sludge - In Combat - Cast Corrosive Ooze");

-- The Reak
UPDATE `creature_template` SET `AIName`="SmartAI" WHERE `entry`=8212;
DELETE FROM `smart_scripts` WHERE `entryorguid`=8212 AND `source_type`=0;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(8212,0,0,0,0,0,100,0,6000,8000,18000,24000,11,7279,0,0,0,0,0,2,0,0,0,0,0,0,0,"The Reak - In Combat - Cast Black Sludge"),
(8212,0,1,0,0,0,100,0,4000,6000,28000,32000,11,21062,0,0,0,0,0,2,0,0,0,0,0,0,0,"The Reak - In Combat - Cast Putrid Breath");

-- Witherbark Scalper
UPDATE `creature_template` SET `AIName`="SmartAI" WHERE `entry`=2649;
DELETE FROM `smart_scripts` WHERE `entryorguid`=2649 AND `source_type`=0;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(2649,0,0,0,0,0,100,0,0,0,2100,4800,11,10277,64,0,0,0,0,2,0,0,0,0,0,0,0,"Witherbark Scalper - In Combat CMC - Cast Throw"),
(2649,0,1,0,12,0,100,1,0,20,0,0,11,7160,1,0,0,0,0,2,0,0,0,0,0,0,0,"Witherbark Scalper - Target Between 0-20% Health - Cast Execute (No Repeat)"),
(2649,0,2,0,2,0,100,1,0,15,0,0,25,1,0,0,0,0,0,1,0,0,0,0,0,0,0,"Witherbark Scalper - Between 0-15% Health - Flee For Assist (No Repeat)");

-- Witherbark Zealot
UPDATE `creature_template` SET `AIName`="SmartAI" WHERE `entry`=2650;
DELETE FROM `smart_scripts` WHERE `entryorguid`=2650 AND `source_type`=0;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(2650,0,0,0,2,0,100,1,0,30,0,0,11,8599,1,0,0,0,0,1,0,0,0,0,0,0,0,"Witherbark Zealot - Between 0-30% Health - Cast Enrage (No Repeat)");

-- Witherbark Hideskinner
UPDATE `creature_template` SET `AIName`="SmartAI" WHERE `entry`=2651;
DELETE FROM `smart_scripts` WHERE `entryorguid`=2651 AND `source_type`=0;

INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(2651,0,0,0,9,0,100,0,0,5,5000,9000,11,8721,0,0,0,0,0,2,0,0,0,0,0,0,0,"Witherbark Hideskinner - In Combat - Cast Backstab"),
(2651,0,1,0,2,0,100,1,0,15,0,0,25,1,0,0,0,0,0,1,0,0,0,0,0,0,0,"Witherbark Hideskinner - Between 0-15% Health - Flee For Assist (No Repeat)");

-- Witherbark Venomblood
UPDATE `creature_template` SET `AIName`="SmartAI" WHERE `entry`=2652;
DELETE FROM `smart_scripts` WHERE `entryorguid`=2652 AND `source_type`=0;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(2652,0,0,0,2,0,100,1,0,15,0,0,25,1,0,0,0,0,0,1,0,0,0,0,0,0,0,"Witherbark Venomblood - Between 0-15% Health - Flee For Assist (No Repeat)");

-- Witherbark Sadist
UPDATE `creature_template` SET `AIName`="SmartAI" WHERE `entry`=2653;
DELETE FROM `smart_scripts` WHERE `entryorguid`=2653 AND `source_type`=0;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(2653,0,0,0,1,0,100,1,1000,1000,0,0,11,7165,0,0,0,0,0,1,0,0,0,0,0,0,0,"Witherbark Sadist - Out of Combat - Cast Battle Stance (No Repeat)"),
(2653,0,1,0,9,0,100,0,0,5,6000,9000,11,25710,0,0,0,0,0,2,0,0,0,0,0,0,0,"Witherbark Sadist - Within 0-5 Range - Cast Heroic Strike (No Repeat)"),
(2653,0,2,0,2,0,100,1,0,15,0,0,25,1,0,0,0,0,0,1,0,0,0,0,0,0,0,"Witherbark Sadist - Between 0-15% Health - Flee For Assist (No Repeat)");

-- Witherbark Caller
UPDATE `creature_template` SET `AIName`="SmartAI" WHERE `entry`=2654;
DELETE FROM `smart_scripts` WHERE `entryorguid`=2654 AND `source_type`=0;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(2654,0,0,0,0,0,100,0,0,0,3400,4800,11,20825,64,0,0,0,0,2,0,0,0,0,0,0,0,"Witherbark Caller - Combat CMC - Cast Shadow Bolt"),
(2654,0,1,0,4,0,100,0,0,0,0,0,11,11017,0,0,0,0,0,1,0,0,0,0,0,0,0,"Witherbark Caller - On Aggro - Summon Witherbark Felhunter"),
(2654,0,2,0,2,0,100,1,0,15,0,0,25,1,0,0,0,0,0,1,0,0,0,0,0,0,0,"Witherbark Caller - Between 0-15% Health - Flee For Assist (No Repeat)");

-- Witherbark Felhunter
UPDATE `creature_template` SET `AIName`="SmartAI" WHERE `entry`=7767;
DELETE FROM `smart_scripts` WHERE `entryorguid`=7767 AND `source_type`=0;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(7767,0,0,0,9,0,100,0,0,10,8000,14000,11,2691,0,0,0,0,0,2,0,0,0,0,0,0,0,"Witherbark Felhunter - Within 0-10 Range - Cast Mana Burn");

-- Witherbark Broodguard
UPDATE `creature_template` SET `AIName`="SmartAI" WHERE `entry`=2686;
DELETE FROM `smart_scripts` WHERE `entryorguid`=2686 AND `source_type`=0;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(2686,0,0,0,6,0,100,0,0,0,0,0,11,11018,0,0,0,0,0,7,0,0,0,0,0,0,0,"Witherbark Broodguard - On Death - Summon Witherbark Bloodlings");

-- Witherheart the Stalker
UPDATE `creature_template` SET `AIName`="SmartAI" WHERE `entry`=8218;
DELETE FROM `smart_scripts` WHERE `entryorguid`=8218 AND `source_type`=0;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(8218,0,0,0,25,0,100,0,0,0,0,0,11,22766,0,0,0,0,0,1,0,0,0,0,0,0,0,"Witherheart the Stalker - On Reset - Cast Sneak"),
(8218,0,1,0,67,0,100,0,5000,9000,0,0,11,7159,0,0,0,0,0,2,0,0,0,0,0,0,0,"Witherheart the Stalker - On Behind Target - Cast Backstab");

-- Zul'arek Hatefowler
UPDATE `creature_template` SET `AIName`="SmartAI" WHERE `entry`=8219;
DELETE FROM `smart_scripts` WHERE `entryorguid`=8219 AND `source_type`=0;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(8219,0,0,0,9,0,100,0,0,30,9000,14000,11,17228,0,0,0,0,0,2,0,0,0,0,0,0,0,"Zul\'arek Hatefowler - Within 0-30 Range - Cast Shadow Bolt Volley");

-- Witch Doctor Mai'jin
UPDATE `creature_template` SET `AIName`="SmartAI" WHERE `entry`=17235;
DELETE FROM `smart_scripts` WHERE `entryorguid`=17235 AND `source_type`=0;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(17235,0,0,0,0,0,100,0,15000,25000,30000,45000,11,5605,0,0,0,0,0,1,0,0,0,0,0,0,0,"Witch Doctor Mai\'jin - In Combat - Cast Healing Ward (No Repeat)"),
(17235,0,1,0,0,0,100,0,6000,8000,25000,28000,11,8190,0,0,0,0,0,1,0,0,0,0,0,0,0,"Witch Doctor Mai\'jin - In Combat - Cast Magma Totem (No Repeat)");

-- Tcha'kaz
UPDATE `creature_template` SET `AIName`="SmartAI" WHERE `entry`=17236;
DELETE FROM `smart_scripts` WHERE `entryorguid`=17236 AND `source_type`=0;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(17236,0,0,0,6,0,100,0,0,0,0,0,11,11018,0,0,0,0,0,7,0,0,0,0,0,0,0,"Tcha\'kaz - On Death - Summon Witherbark Bloodlings");

-- Highvale Outrunner
UPDATE `creature_template` SET `AIName`="SmartAI" WHERE `entry`=2691;
DELETE FROM `smart_scripts` WHERE `entryorguid`=2691 AND `source_type`=0;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(2691,0,0,0,0,0,100,0,0,0,2300,3900,11,6660,64,0,0,0,0,2,0,0,0,0,0,0,0,"Highvale Outrunner - In Combat CMC - Cast Shoot"),
(2691,0,1,0,2,0,100,1,0,15,0,0,25,1,0,0,0,0,0,1,0,0,0,0,0,0,0,"Highvale Outrunner - Between 0-15% Health - Flee For Assist (No Repeat)");

-- Highvale Scout
UPDATE `creature_template` SET `AIName`="SmartAI" WHERE `entry`=2692;
DELETE FROM `smart_scripts` WHERE `entryorguid`=2692 AND `source_type`=0;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(2692,0,0,0,2,0,100,1,0,15,0,0,25,1,0,0,0,0,0,1,0,0,0,0,0,0,0,"Highvale Scout - Between 0-15% Health - Flee For Assist (No Repeat)");

-- Highvale Marksman
UPDATE `creature_template` SET `AIName`="SmartAI" WHERE `entry`=2693;
DELETE FROM `smart_scripts` WHERE `entryorguid`=2693 AND `source_type`=0;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(2693,0,0,0,0,0,100,0,0,0,2300,3900,11,6660,64,0,0,0,0,2,0,0,0,0,0,0,0,"Highvale Marksman - In Combat CMC - Cast Shoot"),
(2693,0,1,0,9,0,100,0,5,30,9000,13000,11,14443,1,0,0,0,0,2,0,0,0,0,0,0,0,"Highvale Marksman - Within 5-30 Range - Cast Multi-Shot"),
(2693,0,2,0,2,0,100,1,0,15,0,0,25,1,0,0,0,0,0,1,0,0,0,0,0,0,0,"Highvale Marksman - Between 0-15% Health - Flee For Assist (No Repeat)");

-- Highvale Ranger
UPDATE `creature_template` SET `AIName`="SmartAI" WHERE `entry`=2694;
DELETE FROM `smart_scripts` WHERE `entryorguid`=2694 AND `source_type`=0;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(2694,0,0,0,9,0,100,0,0,30,30000,35000,11,6950,0,0,0,0,0,2,0,0,0,0,0,0,0,"Highvale Ranger - Within 0-30 Range - Cast Faerie Fire");

-- Vilebranch Soothsayer
UPDATE `creature_template` SET `AIName`="SmartAI" WHERE `entry`=4467;
DELETE FROM `smart_scripts` WHERE `entryorguid`=4467 AND `source_type`=0;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(4467,0,0,0,0,0,100,0,0,0,3400,4700,11,20824,64,0,0,0,0,2,0,0,0,0,0,0,0,"Vilebranch Soothsayer - In Combat - Cast Lightning Bolt"),
(4467,0,1,0,2,0,100,1,0,15,0,0,25,1,0,0,0,0,0,1,0,0,0,0,0,0,0,"Vilebranch Soothsayer - Between 0-15% Health - Flee For Assist (No Repeat)"),
(4467,0,2,0,14,0,100,0,2500,40,20000,30000,11,10395,1,0,0,0,0,7,0,0,0,0,0,0,0,"Vilebranch Soothsayer - Friendly At 40% Health - Cast Healing Wave");

-- Vilebranch Scalper
UPDATE `creature_template` SET `AIName`="SmartAI" WHERE `entry`=4466;
DELETE FROM `smart_scripts` WHERE `entryorguid`=4466 AND `source_type`=0;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(4466,0,0,0,12,0,100,1,0,20,0,0,11,7160,1,0,0,0,0,2,0,0,0,0,0,0,0,"Vilebranch Scalper - Target Between 0-20% Health - Cast Execute (No Repeat)"),
(4466,0,1,0,2,0,100,1,0,15,0,0,25,1,0,0,0,0,0,1,0,0,0,0,0,0,0,"Vilebranch Scalper - Between 0-15% Health - Flee For Assist (No Repeat)");

-- Qiaga the Keeperer
UPDATE `creature_template` SET `AIName`="SmartAI" WHERE `entry`=7996;
DELETE FROM `smart_scripts` WHERE `entryorguid`=7996 AND `source_type`=0;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(7996,0,0,0,0,0,100,0,0,0,3400,4800,11,9613,64,0,0,0,0,2,0,0,0,0,0,0,0,"Qiaga the Keeper - In Combat CMC - Cast Shadow Bolt"),
(7996,0,1,0,0,0,100,0,4200,7700,7100,16200,11,11639,32,0,0,0,0,2,0,0,0,0,0,0,0,"Qiaga the Keeper - In Combat - Cast Shadow Word: Pain"),
(7996,0,2,0,14,0,100,0,1000,40,15000,19000,11,11640,1,0,0,0,0,7,0,0,0,0,0,0,0,"Qiaga the Keeper - Friendly At 40% Health - Cast Renew"),
(7996,0,3,0,2,0,100,1,0,15,0,0,25,1,0,0,0,0,0,1,0,0,0,0,0,0,0,"Qiaga the Keeperer - Between 0-15% Health - Flee For Assist (No Repeat)");

-- Morta'gya the Keeperer
UPDATE `creature_template` SET `AIName`="SmartAI" WHERE `entry`=8636;
DELETE FROM `smart_scripts` WHERE `entryorguid`=8636 AND `source_type`=0;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(8636,0,0,0,0,0,100,0,0,0,3400,4800,11,9613,64,0,0,0,0,2,0,0,0,0,0,0,0,"Morta\'gya the Keeper - In Combat CMC - Cast Shadow Bolt"),
(8636,0,1,0,0,0,100,0,4200,7700,7100,16200,11,11639,32,0,0,0,0,2,0,0,0,0,0,0,0,"Morta\'gya the Keeper - In Combat - Cast Shadow Word: Pain"),
(8636,0,2,0,14,0,100,0,1000,40,15000,19000,11,11640,1,0,0,0,0,7,0,0,0,0,0,0,0,"Morta\'gya the Keeper - Friendly At 40% Health - Cast Renew"),
(8636,0,3,0,2,0,100,1,0,15,0,0,25,1,0,0,0,0,0,1,0,0,0,0,0,0,0,"Morta\'gya the Keeper - Between 0-15% Health - Flee For Assist (No Repeat)");

-- Retherokk the Berserker
UPDATE `creature_template` SET `AIName`="SmartAI" WHERE `entry`=8216;
DELETE FROM `smart_scripts` WHERE `entryorguid`=8216 AND `source_type`=0;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(8216,0,0,0,2,0,100,1,0,30,0,0,11,8599,0,0,0,0,0,1,0,0,0,0,0,0,0,"Retherokk the Berserker - Between 0-30% Health - Cast Enrage (No Repeat)"),
(8216,0,1,0,0,0,100,0,2000,3000,8000,9000,11,3391,0,0,0,0,0,1,0,0,0,0,0,0,0,"Retherokk the Berserker - In Combat - Cast Thrash");

-- Gammerita
UPDATE `creature_template` SET `AIName`="SmartAI" WHERE `entry`=7977;
DELETE FROM `smart_scripts` WHERE `entryorguid`=7977 AND `source_type`=0;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(7977,0,0,0,9,0,100,0,0,5,45000,45000,11,6016,0,0,0,0,0,2,0,0,0,0,0,0,0,"Gammerita - Within 0-5 Range - Cast Pierce Armor");

-- Jade Sludge
UPDATE `creature_template` SET `AIName`="SmartAI" WHERE `entry`=4468;
DELETE FROM `smart_scripts` WHERE `entryorguid`=4468 AND `source_type`=0;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(4468,0,0,0,9,0,100,0,0,10,15000,29000,11,6814,0,0,0,0,0,2,0,0,0,0,0,0,0,"Jade Sludge - Within 0-10 Range - Cast Sludge Toxin");

-- Emerald Ooze
UPDATE `creature_template` SET `AIName`="SmartAI" WHERE `entry`=4469;
DELETE FROM `smart_scripts` WHERE `entryorguid`=4469 AND `source_type`=0;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(4469,0,0,0,9,0,100,0,0,5,12000,19000,11,8245,0,0,0,0,0,2,0,0,0,0,0,0,0,"Emerald Ooze - Within 0-5 Range - Cast Corrosive Acid");

-- Vilebranch Warrior
UPDATE `creature_template` SET `AIName`="SmartAI" WHERE `entry`=4465;
DELETE FROM `smart_scripts` WHERE `entryorguid`=4465 AND `source_type`=0;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(4465,0,0,0,9,0,100,0,0,5,5000,9000,11,11976,0,0,0,0,0,2,0,0,0,0,0,0,0,"Vilebranch Warrior - Within 0-5 Range - Cast Strike"),
(4465,0,1,0,2,0,100,1,0,15,0,0,25,1,0,0,0,0,0,1,0,0,0,0,0,0,0,"Vilebranch Warrior - Between 0-15% Health - Flee For Assist (No Repeat)");

-- Vilebranch Witch Doctor
UPDATE `creature_template` SET `AIName`="SmartAI" WHERE `entry`=2640;
DELETE FROM `smart_scripts` WHERE `entryorguid`=2640 AND `source_type`=0;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(2640,0,0,0,0,0,100,0,0,0,3400,4800,11,9613,64,0,0,0,0,2,0,0,0,0,0,0,0,"Vilebranch Witch Doctor - In Combat CMC - Cast Shadow Bolt"),
(2640,0,1,0,14,0,100,0,1200,40,13000,17000,11,8005,0,0,0,0,0,7,0,0,0,0,0,0,0,"Vilebranch Witch Doctor - Friendly at 1200 Health - Cast Healing Wave"),
(2640,0,2,0,0,0,100,1,9000,13000,22000,28000,11,18503,0,0,0,0,0,2,0,0,0,0,0,0,0,"Vilebranch Witch Doctor - In Combat CMC - Cast Hex"),
(2640,0,3,0,2,0,100,1,0,15,0,0,25,1,0,0,0,0,0,1,0,0,0,0,0,0,0,"Vilebranch Witch Doctor - Between 0-15% Health - Flee For Assist (No Repeat)");

-- Vilebranch Headhunter
UPDATE `creature_template` SET `AIName`="SmartAI" WHERE `entry`=2641;
DELETE FROM `smart_scripts` WHERE `entryorguid`=2641 AND `source_type`=0;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(2641,0,0,0,0,0,100,0,0,0,2300,3900,11,10277,64,0,0,0,0,2,0,0,0,0,0,0,0,"Vilebranch Headhunter - In Combat CMC - Cast Throw"),
(2641,0,1,0,9,0,100,0,0,5,15000,18000,11,7357,0,0,0,0,0,2,0,0,0,0,0,0,0,"Vilebranch Headhunter - Within 0-5 Range - Cast Poisonous Stab"),
(2641,0,2,0,2,0,100,1,0,15,0,0,25,1,0,0,0,0,0,1,0,0,0,0,0,0,0,"Vilebranch Headhunter - Between 0-15% Health - Flee For Assist (No Repeat)");

-- Vilebranch Shadowcaster
UPDATE `creature_template` SET `AIName`="SmartAI" WHERE `entry`=2642;
DELETE FROM `smart_scripts` WHERE `entryorguid`=2642 AND `source_type`=0;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(2642,0,0,0,0,0,100,0,0,0,3400,4800,11,9613,64,0,0,0,0,2,0,0,0,0,0,0,0,"Vilebranch Shadowcaster - In Combat CMC - Cast Shadow Bolt"),
(2642,0,1,0,1,0,100,1,1000,1000,0,0,11,12746,0,0,0,0,0,1,0,0,0,0,0,0,0,"Vilebranch Shadowcaster - Out of Combat - Cast Summon Voidwalker"),
(2642,0,2,0,0,0,100,0,2500,10000,35000,40000,11,7289,0,0,0,0,0,2,0,0,0,0,0,0,0,"Vilebranch Shadowcaster - In Combat - Cast Shrink"),
(2642,0,3,0,2,0,100,1,0,15,0,0,25,1,0,0,0,0,0,1,0,0,0,0,0,0,0,"Vilebranch Shadowcaster - Between 0-15% Health - Flee For Assist (No Repeat)");

-- Vilebranch Hideskinnerr
UPDATE `creature_template` SET `AIName`="SmartAI" WHERE `entry`=2644;
DELETE FROM `smart_scripts` WHERE `entryorguid`=2644 AND `source_type`=0;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(2644,0,0,0,67,0,100,0,5000,9000,0,0,11,7159,0,0,0,0,0,2,0,0,0,0,0,0,0,"Vilebranch Hideskinner - On Behind Target - Cast Backstab"),
(2644,0,1,0,2,0,100,1,0,15,0,0,25,1,0,0,0,0,0,1,0,0,0,0,0,0,0,"Vilebranch Hideskinnerr - Between 0-15% Health - Flee For Assist (No Repeat)");

-- Vilebranch Shadow Hunter
UPDATE `creature_template` SET `AIName`="SmartAI" WHERE `entry`=2645;
DELETE FROM `smart_scripts` WHERE `entryorguid`=2645 AND `source_type`=0;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(2645,0,0,0,0,0,100,0,0,0,2300,3900,11,15547,64,0,0,0,0,2,0,0,0,0,0,0,0,"Vilebranch Shadow Hunter - Combat CMC - Cast Shoot"),
(2645,0,1,0,9,0,100,0,0,30,21000,26000,11,14032,0,0,0,0,0,2,0,0,0,0,0,0,0,"Vilebranch Shadow Hunter - Within 0-30 Range - Cast Shadow Word: Pain"),
(2645,0,2,0,0,0,100,0,4000,9000,15000,21000,11,9657,1,0,0,0,0,1,0,0,0,0,0,0,0,"Vilebranch Shadow Hunter - In Combat - Cast Shadow Shell"),
(2645,0,3,0,2,0,100,1,0,15,0,0,25,1,0,0,0,0,0,1,0,0,0,0,0,0,0,"Vilebranch Shadow Hunter - Between 0-15% Health - Flee For Assist (No Repeat)");

-- Mith'rethis the Enchanter
UPDATE `creature_template` SET `AIName`="SmartAI" WHERE `entry`=8217;
DELETE FROM `smart_scripts` WHERE `entryorguid`=8217 AND `source_type`=0;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(8217,0,0,0,0,0,100,0,5000,9000,12000,16000,11,11436,0,0,0,0,0,2,0,0,0,0,0,0,0,"Mith\'rethis the Enchanter - In Combat - Cast Slow"),
(8217,0,1,0,9,0,100,0,0,30,24000,29000,11,15654,0,0,0,0,0,2,0,0,0,0,0,0,0,"Mith\'rethis the Enchanter - Within 0-30 Range - Cast Shadow Word: Pain"),
(8217,0,2,0,0,0,100,0,1000,5000,21000,27000,11,3443,1,0,0,0,0,1,0,0,0,0,0,0,0,"Mith\'rethis the Enchanter - In Combat - Cast Enchanted Quickness");

-- Vilebranch Blood Drinker
UPDATE `creature_template` SET `AIName`="SmartAI" WHERE `entry`=2646;
DELETE FROM `smart_scripts` WHERE `entryorguid`=2646 AND `source_type`=0;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(2646,0,0,0,9,0,100,0,0,5,7000,15000,11,11015,0,0,0,0,0,2,0,0,0,0,0,0,0,"Vilebranch Blood Drinker - Within 0-5 Range - Cast Blood Leech"),
(2646,0,1,0,2,0,100,1,0,15,0,0,25,1,0,0,0,0,0,1,0,0,0,0,0,0,0,"Vilebranch Blood Drinker - Between 0-15% Health - Flee For Assist (No Repeat)");

-- Vilebranch Soul Eater
UPDATE `creature_template` SET `AIName`="SmartAI" WHERE `entry`=2647;
DELETE FROM `smart_scripts` WHERE `entryorguid`=2647 AND `source_type`=0;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(2647,0,0,0,9,0,100,0,0,5,8000,12000,11,11016,0,0,0,0,0,2,0,0,0,0,0,0,0,"Vilebranch Soul Eater - Within 0-5 Range - Cast Soul Bite"),
(2647,0,1,0,14,0,100,0,600,10,12000,15000,11,7154,1,0,0,0,0,7,0,0,0,0,0,0,0,"Vilebranch Soul Eater - On Friendly at 600 Health - Cast Dark Offering"),
(2647,0,2,0,2,0,100,1,0,15,0,0,25,1,0,0,0,0,0,1,0,0,0,0,0,0,0,"Vilebranch Soul Eater - Between 0-15% Health - Flee For Assist (No Repeat)");

-- Vilebranch Aman'zasi Guard
UPDATE `creature_template` SET `AIName`="SmartAI" WHERE `entry`=2648;
DELETE FROM `smart_scripts` WHERE `entryorguid`=2648 AND `source_type`=0;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(2648,0,0,0,0,0,100,0,4000,7000,8000,11000,11,8242,0,0,0,0,0,2,0,0,0,0,0,0,0,"Vilebranch Aman\'zasi Guard - In Combat - Cast Shield Slam"),
(2648,0,1,0,2,0,100,1,0,15,0,0,25,1,0,0,0,0,0,1,0,0,0,0,0,0,0,"Vilebranch Aman\'zasi Guard - Between 0-15% Health - Flee For Assist (No Repeat)");

-- Vilebranch Raiding Wolf
UPDATE `creature_template` SET `AIName`="SmartAI" WHERE `entry`=2681;
DELETE FROM `smart_scripts` WHERE `entryorguid`=2681 AND `source_type`=0;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(2681,0,0,0,0,0,100,0,8000,12000,15000,20000,11,3391,2,0,0,0,0,2,0,0,0,0,0,0,0,"Vilebranch Raiding Wolf - In Combat - Cast Thrash");

-- Vile Priestess Hexx
UPDATE `creature_template` SET `AIName`="SmartAI" WHERE `entry`=7995;
DELETE FROM `smart_scripts` WHERE `entryorguid`=7995 AND `source_type`=0;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(7995,0,0,0,9,0,100,0,0,30,9000,12000,11,11639,0,0,0,0,0,2,0,0,0,0,0,0,0,"Vile Priestess Hexx - Within 0-30 Range - Cast Shadow Word: Pain"),
(7995,0,1,0,0,0,100,0,7000,12000,18000,25000,11,11641,1,0,0,0,0,2,0,0,0,0,0,0,0,"Vile Priestess Hexx - In Combat - Cast Hex"),
(7995,0,2,0,14,0,100,0,1200,40,12000,15000,11,11642,0,0,0,0,0,7,0,0,0,0,0,0,0,"Vile Priestess Hexx - Friendly At 1200 Health - Cast Heal"),
(7995,0,3,0,2,0,100,1,0,15,0,0,25,1,0,0,0,0,0,1,0,0,0,0,0,0,0,"Vile Priestess Hexx - Between 0-15% Health - Flee For Assist (No Repeat)");

-- Hitah'ya the Keeper
UPDATE `creature_template` SET `AIName`="SmartAI" WHERE `entry`=10802;
DELETE FROM `smart_scripts` WHERE `entryorguid`=10802 AND `source_type`=0;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(10802,0,0,0,9,0,100,0,0,30,21000,25000,11,11639,0,0,0,0,0,2,0,0,0,0,0,0,0,"Hitah\'ya the Keeper - Within 0-30 Range - Cast Shadow Word: Pain"),
(10802,0,1,0,0,0,100,0,0,0,3400,4800,11,9613,0,0,0,0,0,2,0,0,0,0,0,0,0,"Hitah\'ya the Keeper - In Combat - Cast Shadow Bolt"),
(10802,0,2,0,14,0,100,0,1400,40,12000,18000,11,11640,0,0,0,0,0,7,0,0,0,0,0,0,0,"Hitah\'ya the Keeper - Friendly At 1400 Health - Cast Renew"),
(10802,0,3,0,2,0,100,1,0,15,0,0,25,1,0,0,0,0,0,1,0,0,0,0,0,0,0,"Hitah\'ya the Keeper - Between 0-15% Health - Flee For Assist (No Repeat)");

-- Vilebranch Kidnapper
UPDATE `creature_template` SET `AIName`="SmartAI" WHERE `entry`=14748;
DELETE FROM `smart_scripts` WHERE `entryorguid`=14748 AND `source_type`=0;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(14748,0,0,0,12,0,100,1,0,20,0,0,11,7160,1,0,0,0,0,2,0,0,0,0,0,0,0,"Vilebranch Kidnapper - Target Between 0-20% Health - Cast Execute (No Repeat)"),
(14748,0,1,0,2,0,100,1,0,15,0,0,25,1,0,0,0,0,0,1,0,0,0,0,0,0,0,"Vilebranch Kidnapper - Between 0-15% Health - Flee For Assist (No Repeat)"),
(14748,0,2,0,4,0,100,1,0,0,0,0,1,0,0,0,0,0,0,1,0,0,0,0,0,0,0,"Vilebranch Kidnapper - On Aggro - Say Line 0");

DELETE FROM `creature_text` WHERE `CreatureID`=14748;
INSERT INTO `creature_text` (`CreatureID`, `GroupID`, `ID`, `Text`, `Type`, `Language`, `Probability`, `Emote`, `Duration`, `Sound`, `BroadcastTextId`, `TextRange`, `comment`) VALUES
(14748,0,0,"Another fool falls for the trap!",12,0,100,0,0,0,10003,0,"Vilebranch Kidnapper"),
(14748,0,1,"Dinner has arrived!",12,0,100,0,0,0,10004,0,"Vilebranch Kidnapper"),
(14748,0,2,"The High Priestess will feast on your bones!",12,0,100,0,0,0,10005,0,"Vilebranch Kidnapper");

-- Elder Saltwater Crocolisk
UPDATE `creature_template` SET `AIName`="SmartAI" WHERE `entry`=2635;
DELETE FROM `smart_scripts` WHERE `entryorguid`=2635 AND `source_type`=0;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(2635,0,0,0,0,0,100,0,3000,8000,13000,24000,11,3604,0,0,0,0,0,2,0,0,0,0,0,0,0,'Elder Saltwater Crocolisk - In Combat - Cast \'Tendon Rip\' (No Repeat)');

-- Bloodscalp Hunter
UPDATE `creature_template` SET `AIName`="SmartAI" WHERE `entry`=595;
DELETE FROM `smart_scripts` WHERE `entryorguid`=595 AND `source_type`=0;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(595,0,0,0,0,0,100,0,0,0,2100,4800,11,10277,64,0,0,0,0,2,0,0,0,0,0,0,0,'Bloodscalp Hunter - In Combat CMC - Cast \'Throw\''),
(595,0,1,0,0,0,100,0,9500,24100,18500,39800,11,6533,0,0,0,0,0,2,0,0,0,0,0,0,0,'Bloodscalp Hunter - In Combat - Cast \'Net\''),
(595,0,2,0,2,0,100,1,0,30,0,0,11,8599,1,0,0,0,0,1,0,0,0,0,0,0,0,'Bloodscalp Hunter - Between 0-30% Health - Cast \'Enrage\' (No Repeat)');

-- Saltscale Oracle
UPDATE `creature_template` SET `AIName`="SmartAI" WHERE `entry`=873;
DELETE FROM `smart_scripts` WHERE `entryorguid`=873 AND `source_type`=0;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(873,0,0,0,0,0,100,0,0,0,3400,4800,11,9532,64,0,0,0,0,2,0,0,0,0,0,0,0,'Saltscale Oracle - In Combat CMC - Cast \'Lightning Bolt\''),
(873,0,1,0,14,0,100,0,700,40,25000,35000,11,11986,1,0,0,0,0,7,0,0,0,0,0,0,0,'Saltscale Oracle - Friendly At 700 Health - Cast \'Healing Wave\''),
(873,0,2,0,2,0,100,1,0,15,0,0,25,1,0,0,0,0,0,1,0,0,0,0,0,0,0,'Saltscale Oracle - Between 0-15% Health - Flee For Assist (No Repeat)');

-- Saltscale Tide Lord
UPDATE `creature_template` SET `AIName`="SmartAI" WHERE `entry`=875;
DELETE FROM `smart_scripts` WHERE `entryorguid`=875 AND `source_type`=0;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(875,0,0,0,0,0,100,0,1000,1000,1800000,1800000,11,12544,0,0,0,0,0,1,0,0,0,0,0,0,0,'Saltscale Tide Lord - Out of Combat - Cast \'Frost Armor\''),
(875,0,1,0,0,0,100,0,0,0,2400,3800,11,9672,64,0,0,0,0,2,0,0,0,0,0,0,0,'Saltscale Tide Lord - In Combat CMC - Cast \'Frostbolt\''),
(875,0,2,0,0,0,100,0,6000,9000,15000,18500,11,11831,1,0,0,0,0,1,0,0,0,0,0,0,0,'Saltscale Tide Lord - In Combat - Cast \'Frost Nova\''),
(875,0,3,0,2,0,100,1,0,15,0,0,25,1,0,0,0,0,0,1,0,0,0,0,0,0,0,'Saltscale Tide Lord - Between 0-15% Health - Flee For Assist (No Repeat)');

-- Saltscale Forager
UPDATE `creature_template` SET `AIName`="SmartAI" WHERE `entry`=877;
DELETE FROM `smart_scripts` WHERE `entryorguid`=877 AND `source_type`=0;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(877,0,0,0,9,0,100,0,0,5,20000,30000,11,13443,0,0,0,0,0,2,0,0,0,0,0,0,0,'Saltscale Forager - Within 0-5 Range - Cast \'Rend\''),
(877,0,1,0,0,0,100,0,2000,3000,4000,9000,11,744,32,0,0,0,0,2,0,0,0,0,0,0,0,'Saltscale Forager - In Combat - Cast \'Poison\''),
(877,0,2,0,2,0,100,1,0,15,0,0,25,1,0,0,0,0,0,7,0,0,0,0,0,0,0,'Saltscale Forager - Between 0-15% Health - Flee For Assist (No Repeat)');

-- Saltscale Hunter
UPDATE `creature_template` SET `AIName`="SmartAI" WHERE `entry`=879;
DELETE FROM `smart_scripts` WHERE `entryorguid`=879 AND `source_type`=0;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(879,0,0,0,0,0,100,0,0,0,2600,4800,11,10277,64,0,0,0,0,2,0,0,0,0,0,0,0,'Saltscale Hunter - In Combat CMC - Cast \'Throw\''),
(879,0,1,0,2,0,100,1,0,15,0,0,25,1,0,0,0,0,0,1,0,0,0,0,0,0,0,'Saltscale Hunter - Between 0-15% Health - Flee For Assist (No Repeat)');

-- Saltscale Warrior
UPDATE `creature_template` SET `AIName`="SmartAI" WHERE `entry`=871;
DELETE FROM `smart_scripts` WHERE `entryorguid`=871 AND `source_type`=0;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(871,0,0,0,2,0,100,1,0,15,0,0,25,1,0,0,0,0,0,7,0,0,0,0,0,0,0,'Saltscale Warrior - Between 0-15% Health - Flee For Assist (No Repeat)');

-- Kurzen Subchief
UPDATE `creature_template` SET `AIName`="SmartAI" WHERE `entry`=978;
DELETE FROM `smart_scripts` WHERE `entryorguid`=978 AND `source_type`=0;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(978,0,0,0,0,0,100,0,6000,11000,20000,30000,11,8053,0,0,0,0,0,2,0,0,0,0,0,0,0,'Kurzen Subchief - In Combat - Cast \'Flame Shock\'');

-- Kurzen Shadow Hunter
UPDATE `creature_template` SET `AIName`="SmartAI" WHERE `entry`=979;
DELETE FROM `smart_scripts` WHERE `entryorguid`=979 AND `source_type`=0;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(979,0,0,0,0,0,100,0,0,0,2300,3900,11,6660,64,0,0,0,0,2,0,0,0,0,0,0,0,'Kurzen Shadow Hunter - In Combat CMC - Cast \'Shoot\''),
(979,0,1,0,0,0,100,0,9000,14000,9000,14000,11,8806,32,0,0,0,0,5,0,0,0,0,0,0,0,'Kurzen Shadow Hunter - In Combat - Cast \'Poisoned Shot\''),
(979,0,2,0,2,0,100,1,0,15,0,0,25,1,0,0,0,0,0,1,0,0,0,0,0,0,0,'Kurzen Shadow Hunter - Between 0-15% Health - Flee For Assist (No Repeat)');

-- Colonel Kurzen
UPDATE `creature_template` SET `AIName`="SmartAI" WHERE `entry`=813;
DELETE FROM `smart_scripts` WHERE `entryorguid`=813 AND `source_type`=0;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(813,0,0,0,0,0,100,0,8000,12000,18000,25000,11,8817,0,0,0,0,0,1,0,0,0,0,0,0,0,'Colonel Kurzen - In Combat - Cast \'Smoke Bomb\''),
(813,0,1,0,24,0,100,0,8817,0,100,100,11,8818,32,0,0,0,0,2,0,0,0,0,0,0,0,'Colonel Kurzen - On Target Has \'Smoke Bomb\' Aura - Cast \'Garrote\'');

-- Mosh'Ogg Shaman
DELETE FROM `creature_text` WHERE `CreatureID`=679;
INSERT INTO `creature_text` (`CreatureID`, `GroupID`, `ID`, `Text`, `Type`, `Language`, `Probability`, `Emote`, `Duration`, `Sound`, `BroadcastTextId`, `TextRange`, `comment`) VALUES
(679,0,0,"Raaar!!! Me smash $r!",12,0,100,0,0,0,1927,0,"Mosh\'Ogg Shaman"),
(679,0,1,"Me smash! You die!",12,0,100,0,0,0,1926,0,"Mosh\'Ogg Shaman"),
(679,0,2,"I\'ll crush you!",12,0,100,0,0,0,1925,0,"Mosh\'Ogg Shaman");

UPDATE `creature_template` SET `AIName`="SmartAI" WHERE `entry`=679;
DELETE FROM `smart_scripts` WHERE `entryorguid`=679 AND `source_type`=0;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(679,0,0,0,0,0,100,0,6500,10000,9500,12500,11,12058,0,0,0,0,0,2,0,0,0,0,0,0,0,'Mosh\'Ogg Shaman - In Combat - Cast \'Chain Lightning\''),
(679,0,1,0,2,0,100,0,0,30,34000,38000,11,6742,1,0,0,0,0,1,0,0,0,0,0,0,0,'Mosh\'Ogg Shaman - Between 0-30% Health - Cast \'Bloodlust\''),
(679,0,2,0,0,0,100,0,9500,18000,33000,45000,11,11899,0,0,0,0,0,1,0,0,0,0,0,0,0,'Mosh\'Ogg Shaman - In Combat - Cast \'Healing Ward\''),
(679,0,3,0,4,0,15,0,0,0,0,0,1,0,0,0,0,0,0,7,0,0,0,0,0,0,0,"Mosh\'Ogg Shaman - On Aggro - Say Line 0");

-- Verifonix
UPDATE `creature_template` SET `AIName`="SmartAI" WHERE `entry`=14492;
DELETE FROM `smart_scripts` WHERE `entryorguid`=14492 AND `source_type`=0;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(14492,0,0,0,9,0,100,0,0,5,23800,28200,11,12097,0,0,0,0,0,2,0,0,0,0,0,0,0,'Verifonix - Within 0-5 Range - Cast \'Pierce Armor\'');

-- Mosh'Ogg Mauler --> Add Texts on Aggro
DELETE FROM `creature_text` WHERE `CreatureID`=678;
INSERT INTO `creature_text` (`CreatureID`, `GroupID`, `ID`, `Text`, `Type`, `Language`, `Probability`, `Emote`, `Duration`, `Sound`, `BroadcastTextId`, `TextRange`, `comment`) VALUES
(678,0,0,"Raaar!!! Me smash $r!",12,0,100,0,0,0,1927,0,"Mosh\'Ogg Mauler"),
(678,0,1,"Me smash! You die!",12,0,100,0,0,0,1926,0,"Mosh\'Ogg Mauler"),
(678,0,2,"I\'ll crush you!",12,0,100,0,0,0,1925,0,"Mosh\'Ogg Mauler");
DELETE FROM `smart_scripts` WHERE `entryorguid`=678 AND `id`=1 AND `source_type`=0;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(678,0,1,0,4,0,15,0,0,0,0,0,1,0,0,0,0,0,0,7,0,0,0,0,0,0,0,"Mosh\'Ogg Mauler - On Aggro - Say Line 0");

-- Mosh'Ogg Lord --> Add Texts on Aggro
DELETE FROM `creature_text` WHERE `CreatureID`=680;
INSERT INTO `creature_text` (`CreatureID`, `GroupID`, `ID`, `Text`, `Type`, `Language`, `Probability`, `Emote`, `Duration`, `Sound`, `BroadcastTextId`, `TextRange`, `comment`) VALUES
(680,0,0,"Raaar!!! Me smash $r!",12,0,100,0,0,0,1927,0,"Mosh\'Ogg Lord"),
(680,0,1,"Me smash! You die!",12,0,100,0,0,0,1926,0,"Mosh\'Ogg Lord"),
(680,0,2,"I\'ll crush you!",12,0,100,0,0,0,1925,0,"Mosh\'Ogg Lord");
DELETE FROM `smart_scripts` WHERE `entryorguid`=680 AND `id`=1 AND `source_type`=0;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(680,0,1,0,4,0,15,0,0,0,0,0,1,0,0,0,0,0,0,7,0,0,0,0,0,0,0,"Mosh\'Ogg Lord - On Aggro - Say Line 0");

-- Mosh'Ogg Warmonger --> Add Texts on Aggro
DELETE FROM `creature_text` WHERE `CreatureID`=709;
INSERT INTO `creature_text` (`CreatureID`, `GroupID`, `ID`, `Text`, `Type`, `Language`, `Probability`, `Emote`, `Duration`, `Sound`, `BroadcastTextId`, `TextRange`, `comment`) VALUES
(709,0,0,"Raaar!!! Me smash $r!",12,0,100,0,0,0,1927,0,"Mosh\'Ogg Warmonger"),
(709,0,1,"Me smash! You die!",12,0,100,0,0,0,1926,0,"Mosh\'Ogg Warmonger"),
(709,0,2,"I\'ll crush you!",12,0,100,0,0,0,1925,0,"Mosh\'Ogg Warmonger");
DELETE FROM `smart_scripts` WHERE `entryorguid`=709 AND `id`=1 AND `source_type`=0;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(709,0,1,0,4,0,15,0,0,0,0,0,1,0,0,0,0,0,0,7,0,0,0,0,0,0,0,"Mosh\'Ogg Warmonger - On Aggro - Say Line 0");

-- Mosh'Ogg Spellcrafter --> Add Texts on Aggro
DELETE FROM `creature_text` WHERE `CreatureID`=710;
INSERT INTO `creature_text` (`CreatureID`, `GroupID`, `ID`, `Text`, `Type`, `Language`, `Probability`, `Emote`, `Duration`, `Sound`, `BroadcastTextId`, `TextRange`, `comment`) VALUES
(710,0,0,"Raaar!!! Me smash $r!",12,0,100,0,0,0,1927,0,"Mosh\'Ogg Spellcrafter"),
(710,0,1,"Me smash! You die!",12,0,100,0,0,0,1926,0,"Mosh\'Ogg Spellcrafter"),
(710,0,2,"I\'ll crush you!",12,0,100,0,0,0,1925,0,"Mosh\'Ogg Spellcrafter");
DELETE FROM `smart_scripts` WHERE `entryorguid`=710 AND `id`=3 AND `source_type`=0;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(710,0,3,0,4,0,15,0,0,0,0,0,1,0,0,0,0,0,0,7,0,0,0,0,0,0,0,"Mosh\'Ogg Spellcrafter - On Aggro - Say Line 0");
