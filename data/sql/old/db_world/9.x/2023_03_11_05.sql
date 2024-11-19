-- DB update 2023_03_11_04 -> 2023_03_11_05
-- Infinite Assasin
UPDATE `creature_template` SET `difficulty_entry_1`=20740 WHERE `entry`=17835;
UPDATE `creature_template` SET `faction`=1720, `MovementType`=1 WHERE `entry`=20740;

UPDATE `creature_template` SET `difficulty_entry_1`=22164, `AiName`='SmartAI' WHERE `entry`=21137;

DELETE FROM `smart_scripts` WHERE `entryorguid`=17835 AND `source_type`=0;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(17835,0,0,0,6,0,50,1,0,0,0,0,0,1,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Infinite Assassin - On Death - Talk'),
(17835,0,1,0,0,0,100,2,8000,12000,15000,17000,0,11,30832,0,0,0,0,0,2,0,0,0,0,0,0,0,0,'Infinite Assassin - In Combat - Cast Kidney Shot'),
(17835,0,2,0,0,0,100,4,8000,12000,15000,17000,0,11,30832,0,0,0,0,0,2,0,0,0,0,0,0,0,0,'Infinite Assassin - In Combat - Cast Kidney Shot'),
(17835,0,3,0,67,0,100,2,5000,5000,0,0,0,11,7159,0,0,0,0,0,2,0,0,0,0,0,0,0,0,'Infinite Assassin - Behind Target - Cast Backstab'),
(17835,0,4,0,67,0,100,4,5000,5000,0,0,0,11,15657,0,0,0,0,0,2,0,0,0,0,0,0,0,0,'Infinite Assassin - Behind Target - Cast Backstab'),
(17835,0,5,0,0,0,100,4,5000,8000,8000,12000,0,11,38520,0,0,0,0,0,2,0,0,0,0,0,0,0,0,'Infinite Assassin - In Combat - Cast Deadly Poison'),
(17835,0,6,0,25,0,100,0,0,0,0,0,0,11,31326,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Infinite Assassin - On Reset - Cast Corrupt Medivh');

DELETE FROM `smart_scripts` WHERE `entryorguid`=21137 AND `source_type`=0;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(21137,0,0,0,6,0,50,1,0,0,0,0,0,1,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Infinite Assassin - On Death - Talk'),
(21137,0,1,0,0,0,100,2,8000,12000,15000,17000,0,11,14874,0,0,0,0,0,2,0,0,0,0,0,0,0,0,'Infinite Assassin - In Combat - Cast Rupture'),
(21137,0,2,0,0,0,100,4,8000,12000,15000,17000,0,11,14874,0,0,0,0,0,2,0,0,0,0,0,0,0,0,'Infinite Assassin - In Combat - Cast Rupture'),
(21137,0,3,0,0,0,100,2,5000,8000,8000,12000,0,11,14873,0,0,0,0,0,2,0,0,0,0,0,0,0,0,'Infinite Assassin - In Combat - Cast Spell Sinister Strike'),
(21137,0,4,0,0,0,100,4,5000,8000,8000,12000,0,11,14873,0,0,0,0,0,2,0,0,0,0,0,0,0,0,'Infinite Assassin - In Combat - Cast Spell Sinister Strike'),
(21137,0,5,0,0,0,100,4,5000,8000,8000,12000,0,11,30981,0,0,0,0,0,2,0,0,0,0,0,0,0,0,'Infinite Assassin - In Combat - Cast Crippling Poison'),
(21137,0,6,0,25,0,100,0,0,0,0,0,0,11,31326,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Infinite Assassin - On Reset - Cast Spell Corrupt Medivh');

DELETE FROM `creature_text` WHERE `CreatureID`=21137;
INSERT INTO `creature_text` (`CreatureID`, `GroupID`, `ID`, `Text`, `Type`, `Language`, `Probability`, `Emote`, `Duration`, `Sound`, `BroadcastTextId`, `TextRange`, `comment`) VALUES
(21137,0,0,'More will take my place.',12,0,100,0,0,0,15167,0,'Infinite Assassin'),
(21137,0,1,'Our time has come!',12,0,100,0,0,0,15163,0,'Infinite Assassin'),
(21137,0,2,'The wizard will fall!',12,0,100,0,0,0,15164,0,'Infinite Assassin');

UPDATE `creature_onkill_reputation` SET `creature_id`=17835, `RewOnKillRepValue1`=2 WHERE `creature_id`=21137;
UPDATE `creature_onkill_reputation` SET `creature_id`=20740, `RewOnKillRepValue1`=3 WHERE `creature_id`=22164;

-- Infinite Chronomancer
UPDATE `creature_template` SET `AiName`='SmartAI' WHERE `entry`=21136;

DELETE FROM `smart_scripts` WHERE `entryorguid`=21136 AND `source_type`=0;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(21136,0,0,0,6,0,50,1,0,0,0,0,0,1,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Infinite Chronomancer - On Death - Talk'),
(21136,0,1,0,0,0,100,2,0,0,1500,1500,0,11,15497,64,0,0,0,0,2,0,0,0,0,0,0,0,0,'Infinite Chronomancer - In Combat - Cast Frostbolt'),
(21136,0,2,0,0,0,100,4,0,0,1500,1500,0,11,12675,64,0,0,0,0,2,0,0,0,0,0,0,0,0,'Infinite Chronomancer - In Combat - Cast Frostbolt'),
(21136,0,3,0,9,0,100,2,0,10,10000,10000,0,11,15063,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Infinite Chronomancer - Within Range 0-10yd - Cast Frost Nova'),
(21136,0,4,0,9,0,100,4,0,10,10000,10000,0,11,15531,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Infinite Chronomancer - Within Range 0-10yd - Cast Frost Nova'),
(21136,0,5,0,25,0,100,0,0,0,0,0,0,11,31326,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Infinite Chronomancer - On Reset - Cast Corrupt Medivh');

DELETE FROM `creature_text` WHERE `CreatureID`=21136;
INSERT INTO `creature_text` (`CreatureID`, `GroupID`, `ID`, `Text`, `Type`, `Language`, `Probability`, `Emote`, `Duration`, `Sound`, `BroadcastTextId`, `TextRange`, `comment`) VALUES
(21136,0,0,'We are not finished!',12,0,100,0,0,0,15174,0,'Infinite Chronomancer'),
(21136,0,1,'Death to the Last Guardian!',12,0,100,0,0,0,15171,0,'Infinite Chronomancer'),
(21136,0,2,'We will not fail!',12,0,100,0,0,0,23332,0,'Infinite Chronomancer');

DELETE FROM `creature_onkill_reputation` WHERE `creature_id` IN (21136,22165);

-- Infinite Executioner
UPDATE `creature_template` SET `difficulty_entry_1`=20742 WHERE `entry`=18994;
UPDATE `creature_template` SET `faction`=1720, `MovementType`=1 WHERE `entry`=20742;

UPDATE `creature_template` SET `difficulty_entry_1`=22166, `AiName`='SmartAI' WHERE `entry`=21138;
UPDATE `creature_template` SET `damagemodifier`=7.5 WHERE `entry`=22166;

DELETE FROM `smart_scripts` WHERE `entryorguid`=18994 AND `source_type`=0;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(18994,0,0,0,6,0,50,1,0,0,0,0,0,1,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Infinite Executioner - On Death - Talk'),
(18994,0,1,0,0,0,100,2,0,0,8000,12000,0,11,15580,0,0,0,0,0,2,0,0,0,0,0,0,0,0,'Infinite Executioner - In Combat - Cast Strike'),
(18994,0,2,0,0,0,100,4,0,0,8000,12000,0,11,34920,0,0,0,0,0,2,0,0,0,0,0,0,0,0,'Infinite Executioner - In Combat - Cast Strike'),
(18994,0,3,0,0,0,100,2,1000,1000,3000,3000,0,11,17198,0,0,0,0,0,2,0,0,0,0,0,0,0,0,'Infinite Executioner - In Combat - Cast Overpower'),
(18994,0,4,0,0,0,100,4,1000,1000,3000,3000,0,11,37321,0,0,0,0,0,2,0,0,0,0,0,0,0,0,'Infinite Executioner - In Combat - Cast Overpower'),
(18994,0,5,0,25,0,100,0,0,0,0,0,0,11,31326,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Infinite Executioner - On Reset - Cast Corrupt Medivh');

DELETE FROM `smart_scripts` WHERE `entryorguid`=21138 AND `source_type`=0;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(21138,0,0,0,6,0,50,1,0,0,0,0,0,1,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Infinite Executioner - On Death - Talk'),
(21138,0,1,0,0,0,100,2,0,0,8000,12000,0,11,15496,0,0,0,0,0,2,0,0,0,0,0,0,0,0,'Infinite Executioner - In Combat - Cast Cleave'),
(21138,0,2,0,0,0,100,4,0,0,8000,12000,0,11,15496,0,0,0,0,0,2,0,0,0,0,0,0,0,0,'Infinite Executioner - In Combat - Cast Cleave'),
(21138,0,3,0,0,0,100,2,5000,8000,12000,18000,0,11,9080,0,0,0,0,0,2,0,0,0,0,0,0,0,0,'Infinite Executioner - In Combat - Cast Hamstring'),
(21138,0,4,0,0,0,100,4,5000,8000,12000,18000,0,11,9080,0,0,0,0,0,2,0,0,0,0,0,0,0,0,'Infinite Executioner - In Combat - Cast Hamstring'),
(21138,0,5,0,25,0,100,0,0,0,0,0,0,11,31326,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Infinite Executioner - On Reset - Cast Corrupt Medivh');

DELETE FROM `creature_text` WHERE `CreatureID`=21138;
INSERT INTO `creature_text` (`CreatureID`, `GroupID`, `ID`, `Text`, `Type`, `Language`, `Probability`, `Emote`, `Duration`, `Sound`, `BroadcastTextId`, `TextRange`, `comment`) VALUES
(21138,0,0,'More will take my place.',12,0,100,0,0,0,15167,0,'Infinite Executioner'),
(21138,0,1,'We will not be stopped!',12,0,100,0,0,0,15166,0,'Infinite Executioner'),
(21138,0,2,'Your efforts... are in vain.',12,0,100,0,0,0,15168,0,'Infinite Executioner');

DELETE FROM `creature_onkill_reputation` WHERE `creature_id` IN (21138,22166);

-- Infinite Vanquisher
UPDATE `creature_template` SET `difficulty_entry_1`=20743 WHERE `entry`=18995;
UPDATE `creature_template` SET `faction`=1720, `MovementType`=1 WHERE `entry`=20743;

UPDATE `creature_template` SET `difficulty_entry_1`=22168, `AiName`='SmartAI' WHERE `entry`=21139;
UPDATE `creature_template` SET `BaseAttackTime`=2000 WHERE `entry`=22168;

DELETE FROM `smart_scripts` WHERE `entryorguid`=21139 AND `source_type`=0;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(21139,0,0,0,6,0,50,1,0,0,0,0,0,1,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Infinite Vanquisher - On Death - Talk'),
(21139,0,1,0,0,0,100,2,0,0,2000,2000,0,11,12739,64,0,0,0,0,2,0,0,0,0,0,0,0,0,'Infinite Vanquisher - In Combat - Cast Shadow Bolt'),
(21139,0,2,0,0,0,100,4,0,0,2000,2000,0,11,15472,64,0,0,0,0,2,0,0,0,0,0,0,0,0,'Infinite Vanquisher - In Combat - Cast Shadow Bolt'),
(21139,0,3,0,9,0,100,2,6000,7000,12000,18000,0,11,32063,0,0,0,0,0,5,30,0,0,0,0,0,0,0,'Infinite Vanquisher - In Combat - Cast Corruption'),
(21139,0,4,0,9,0,100,4,6000,7000,12000,18000,0,11,32197,0,0,0,0,0,5,30,0,0,0,0,0,0,0,'Infinite Vanquisher - In Combat - Cast Corruption'),
(21139,0,5,0,25,0,100,0,0,0,0,0,0,11,31326,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Infinite Vanquisher - On Reset - Cast Corrupt Medivh');

DELETE FROM `creature_text` WHERE `CreatureID`=21139;
INSERT INTO `creature_text` (`CreatureID`, `GroupID`, `ID`, `Text`, `Type`, `Language`, `Probability`, `Emote`, `Duration`, `Sound`, `BroadcastTextId`, `TextRange`, `comment`) VALUES
(21139,0,0,'We are not finished!',12,0,100,0,0,0,15174,0,'Infinite Vanquisher'),
(21139,0,1,'Death to the Last Guardian!',12,0,100,0,0,0,15171,0,'Infinite Vanquisher'),
(21139,0,2,'We will not fail!',12,0,100,0,0,0,23332,0,'Infinite Vanquisher');

DELETE FROM `creature_onkill_reputation` WHERE `creature_id` IN (21139,22168);

-- Conditions
DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId`=22 AND `SourceEntry` IN (17835,17892,18994,18995,21136,21137,21138,21139);
INSERT INTO`conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `ErrorType`, `ErrorTextId`, `ScriptName`, `Comment`) VALUES
(22,7,17835,0,0,29,1,15608,20,0,0,0,0,'','SAI "Corrupt Medivh" requires Medivh in 20yd'),
(22,6,17892,0,0,29,1,15608,20,0,0,0,0,'','SAI "Corrupt Medivh" requires Medivh in 20yd'),
(22,6,18994,0,0,29,1,15608,20,0,0,0,0,'','SAI "Corrupt Medivh" requires Medivh in 20yd'),
(22,6,18995,0,0,29,1,15608,20,0,0,0,0,'','SAI "Corrupt Medivh" requires Medivh in 20yd'),
(22,6,21136,0,0,29,1,15608,20,0,0,0,0,'','SAI "Corrupt Medivh" requires Medivh in 20yd'),
(22,7,21137,0,0,29,1,15608,20,0,0,0,0,'','SAI "Corrupt Medivh" requires Medivh in 20yd'),
(22,6,21138,0,0,29,1,15608,20,0,0,0,0,'','SAI "Corrupt Medivh" requires Medivh in 20yd'),
(22,6,21139,0,0,29,1,15608,20,0,0,0,0,'','SAI "Corrupt Medivh" requires Medivh in 20yd');
