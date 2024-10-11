-- DB update 2022_11_21_16 -> 2022_11_21_17
-- Deathwhisperer (19299)
UPDATE `creature_template_addon` SET `auras` = '15088 12787' WHERE (`entry` = 19299);

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 19299;
DELETE FROM `smart_scripts` WHERE (`entryorguid` = 19299) AND (`source_type` = 0) AND (`id` IN (0, 1, 2));
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(19299, 0, 0, 0, 0, 0, 100, 0, 4000, 6000, 12000, 16000, 0, 11, 32417, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Deathwhisperer - In Combat - Cast \'Mind Flay\'');

-- Dread Tactician (16959)
UPDATE `creature_template` SET `AIName`='SmartAI' WHERE `entry`=16959;
DELETE FROM `smart_scripts` WHERE `entryorguid`=16959 AND `source_type`=0;
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`event_param5`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(16959,0,0,0,0,0,100,0,5000,8000,15000,20000,0,11,33678,0,0,0,0,0,2,0,0,0,0,0,0,0,'Dread Tactician - In Combat - Cast \'Carrion Swarm\''),
(16959,0,1,0,0,0,100,0,8000,11000,24000,29000,0,11,12098,0,0,0,0,0,6,0,0,0,0,0,0,0,'Dread Tactician - In Combat - Cast \'Sleep\''),
(16959,0,2,0,2,0,100,1,0,30,0,0,0,11,33679,0,0,0,0,0,5,0,0,0,0,0,0,0,'Dread Tactician - Between 0-30% Health - Cast \'Inferno\' (No Repeat)');

-- Felguard Destroyer (18977)
UPDATE `creature_template` SET `AIName`='SmartAI' WHERE `entry`=18977;
DELETE FROM `smart_scripts` WHERE `entryorguid`=18977 AND `source_type`=0;
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`event_param5`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(18977,0,0,0,9,0,100,1,8,40,0,0,0,11,33971,2,0,0,0,0,2,0,0,0,0,0,0,0,'Felguard Destroyer - Within 8-40 Range - Cast \'Sweeping Charge\' (No Repeat)'),
(18977,0,1,0,0,0,100,0,7000,9000,11000,15000,0,11,13737,0,0,0,0,0,2,0,0,0,0,0,0,0,'Felguard Destroyer - In Combat - Cast \'Mortal Strike\''),
(18977,0,2,0,0,0,100,0,3000,5000,7000,11000,0,11,40505,0,0,0,0,0,2,0,0,0,0,0,0,0,'Felguard Destroyer - In Combat - Cast \'Cleave\'');

-- Subjugator Yalqiz (19335)
UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 19335;
DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = 19335);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(19335, 0, 0, 0, 0, 0, 100, 0, 5000, 10000, 15000, 20000, 0, 11, 32026, 32, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Subjugator Yalqiz - In Combat - Cast \'Pain Spike\''),
(19335, 0, 1, 0, 2, 0, 100, 1, 20, 80, 0, 0, 0, 11, 32000, 32, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Subjugator Yalqiz - Between 20-80% Health - Cast \'Mind Sear\' (No Repeat)'),
(19335, 0, 2, 0, 25, 0, 100, 0, 0, 0, 0, 0, 0, 11, 29651, 32, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Subjugator Yalqiz - On Reset - Cast \'Dual Wield\'');

-- Vorakem Doomspeaker
UPDATE `creature_template` SET `AIName`='SmartAI' WHERE `entry`=18679;
DELETE FROM `smart_scripts` WHERE `entryorguid`=18679 AND `source_type`=0;
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`event_param5`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(18679,0,0,0,0,0,100,0,5000,7000,11000,14000,0,11,9080,0,0,0,0,0,2,0,0,0,0,0,0,0,'Vorakem Doomspeaker - In Combat - Cast \'Hamstring\''),
(18679,0,1,0,0,0,100,0,7000,9000,12000,15000,0,11,33804,0,0,0,0,0,1,0,0,0,0,0,0,0,'Vorakem Doomspeaker - In Combat - Cast \'Flame Wave\''),
(18679,0,2,0,2,0,100,1,0,20,0,0,0,11,8599,0,0,0,0,0,1,0,0,0,0,0,0,0,'Vorakem Doomspeaker - Between 0-20% Health - Cast Enrage (No Repeat)'),
(18679,0,3,0,2,0,100,1,0,20,0,0,0,1,0,0,0,0,0,0,1,0,0,0,0,0,0,0,'Vorakem Doomspeaker - Between 0-20% Health - Say Line 0 (No Repeat)');

DELETE FROM `creature_text` WHERE `CreatureID`=18679;
INSERT INTO `creature_text` (`CreatureID`, `GroupID`, `ID`, `Text`, `Type`, `Language`, `Probability`, `Emote`, `Duration`, `Sound`, `BroadcastTextId`, `TextRange`, `comment`) VALUES
(18679,0,0,'%s becomes enraged!',16,0,100,0,0,0,10677,0,'Vorakem Doomspeaker');

-- Flame Wave (19381)
DELETE FROM `creature_template_addon` WHERE (`entry` = 19381);
INSERT INTO `creature_template_addon` (`entry`, `path_id`, `mount`, `bytes1`, `bytes2`, `emote`, `visibilityDistanceType`, `auras`) VALUES
(19381, 0, 0, 0, 0, 0, 0, '33800');

-- Starving Helboar (16879)
DELETE FROM `smart_scripts` WHERE (`entryorguid` = 16879) AND (`source_type` = 0) AND (`id` IN (0));
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(16879, 0, 0, 0, 2, 0, 100, 1, 20, 80, 0, 0, 0, 11, 33908, 32, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Starving Helboar - Between 20-80% Health - Cast \'Burning Spikes\' (No Repeat)');

-- Infernal Warbringer (19261)
UPDATE `creature_template_addon` SET `auras` = '19483' WHERE (`entry` = 19261);
UPDATE `creature_template` SET `AIName` = '' WHERE `entry` = 19261;
DELETE FROM `smart_scripts` WHERE (`entryorguid` = 19261) AND (`source_type` = 0);

-- Mekthorg the Wild (18677)
DELETE FROM `smart_scripts` WHERE (`entryorguid` = 18677) AND (`source_type` = 0) AND (`id` IN (0, 1, 2, 3));
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(18677, 0, 0, 0, 0, 0, 100, 0, 3000, 3200, 7500, 8400, 0, 11, 38875, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Mekthorg the Wild - In Combat - Cast \'Pike Vault\''),
(18677, 0, 1, 0, 2, 0, 100, 1, 30, 40, 0, 0, 0, 11, 8599, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Mekthorg the Wild - Between 30-40% Health - Cast \'Enrage\' (No Repeat)'),
(18677, 0, 2, 0, 2, 0, 100, 1, 0, 15, 0, 0, 0, 11, 37704, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Mekthorg the Wild - Between 0-15% Health - Cast \'Whirlwind\' (No Repeat)'),
(18677, 0, 3, 0, 2, 0, 100, 0, 30, 40, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Mekthorg the Wild - Between 30-40% Health - Say Line 0');

DELETE FROM `creature_text` WHERE `CreatureID`=18677;
INSERT INTO `creature_text` (`CreatureID`, `GroupID`, `ID`, `Text`, `Type`, `Language`, `Probability`, `Emote`, `Duration`, `Sound`, `BroadcastTextId`, `TextRange`, `comment`) VALUES
(18677,0,0,'%s becomes enraged!',16,0,100,0,0,0,10677,0,'Mekthorg the Wild');

-- Arch Mage Xintor (16977)
DELETE FROM `creature_template_addon` WHERE (`entry` = 16977);
INSERT INTO `creature_template_addon` (`entry`, `path_id`, `mount`, `bytes1`, `bytes2`, `emote`, `visibilityDistanceType`, `auras`) VALUES
(16977, 0, 0, 0, 0, 0, 0, '33900');

-- Rogue Voidwalker (16974)
DELETE FROM `smart_scripts` WHERE (`entryorguid` = 16974) AND (`source_type` = 0) AND (`id` IN (0, 1));
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(16974, 0, 0, 0, 0, 0, 100, 0, 6000, 6000, 10000, 10000, 0, 11, 33914, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Rogue Voidwalker - In Combat - Cast \'Shadowstrike\''),
(16974, 0, 1, 0, 6, 0, 100, 0, 0, 0, 0, 0, 0, 11, 34234, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Rogue Voidwalker - On Just Died - Cast \'Collapse\'');

-- Void Spawner L (19681)
UPDATE `creature_template` SET `AIName`='SmartAI' WHERE `entry`=19681;
DELETE FROM `smart_scripts` WHERE `entryorguid`=19681 AND `source_type`=0;
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`event_param5`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(19681,0,0,0,1,0,100,0,1000,120000,120000,240000,0,11,34303,0,0,0,0,0,1,0,0,0,0,0,0,0,'Void Spawner L - Out of Combat - Cast \'Nether Charge\'');

DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId`=13 AND `SourceEntry`=34303;
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `ErrorType`, `ErrorTextId`, `ScriptName`, `Comment`) VALUES
(13,3,34303,0,0,32,0,144,0,0,1,0,0,'','Nether Charge cannot target players');

-- Warboss Nekrogg (19263)
UPDATE `creature_template` SET `AIName`='SmartAI' WHERE `entry`=19263;
DELETE FROM `smart_scripts` WHERE `entryorguid`=19263 AND `source_type`=0;
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`event_param5`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(19263,0,0,0,0,0,100,0,5000,7000,12000,16000,0,11,34113,0,0,0,0,0,2,0,0,0,0,0,0,0,'Warboss Nekrogg - In Combat - Cast \'Bonechewer Bite\''),
(19263,0,1,0,0,0,100,0,10000,12000,25000,30000,0,11,30474,0,0,0,0,0,2,0,0,0,0,0,0,0,'Warboss Nekrogg - In Combat - Cast \'Bloodthirst\'');

-- Shattered Hand Guard (19414)
DELETE FROM `smart_scripts` WHERE `entryorguid`=19414 AND `source_type`=0 AND `id`=1;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(19414,0,1,0,0,0,100,0,6000,9000,13000,16000,0,11,33960,0,0,0,0,0,2,0,0,0,0,0,0,0,'Shattered Hand Guard - In Combat - Cast \'Counterstrike\'');

-- Mo'arg Forgefiend (16946)
DELETE FROM `smart_scripts` WHERE (`entryorguid` = 16946) AND (`source_type` = 0) AND (`id` IN (0, 1));
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(16946, 0, 0, 0, 0, 0, 100, 0, 2000, 4000, 2000, 4000, 0, 11, 32735, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Mo\'arg Forgefiend - In Combat - Cast \'Saw Blade\''),
(16946, 0, 1, 0, 0, 0, 100, 0, 2500, 5000, 15000, 20000, 0, 11, 36486, 32, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Mo\'arg Forgefiend - In Combat - Cast \'Slime Spray\'');

-- Gan'arg Servant (16947)
DELETE FROM `smart_scripts` WHERE (`entryorguid` = 16947) AND (`source_type` = 0) AND (`id` IN (0));
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(16947, 0, 0, 0, 0, 0, 100, 0, 5000, 10000, 15000, 20000, 0, 11, 32003, 32, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Gan\'arg Servant - In Combat - Cast \'Power Burn\'');

-- Incandescent Fel Spark (22323)
DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = 22323);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(22323, 0, 0, 0, 0, 0, 100, 0, 1000, 2000, 3000, 5000, 0, 11, 36247, 64, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Incandescent Fel Spark - In Combat - Cast \'Fel Fireball\''),
(22323, 0, 2, 0, 0, 0, 100, 0, 8000, 11000, 18000, 24000, 0, 11, 39055, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Incandescent Fel Spark - In Combat - Cast \'Flames of Chaos\''),
(22323, 0, 1, 0, 6, 0, 100, 0, 0, 0, 0, 0, 0, 11, 44877, 3, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Incandescent Fel Spark - On Just Died - Cast \'Living Flare Master\'');

-- Thornfang Venomspitter (19350)
UPDATE `creature_template_addon` SET `auras` = '22696' WHERE (`entry` = 19350);

-- Haal'eshi Talonguard (16967)
UPDATE `creature_template_addon` SET `auras` = '29651' WHERE (`entry` = 16967);
DELETE FROM `smart_scripts` WHERE `entryorguid`=16967 AND `source_type`=0;
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`event_param5`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(16967,0,0,0,4,0,100,0,0,0,0,0,0,11,32720,0,0,0,0,0,1,0,0,0,0,0,0,0,'Haal\'eshi Talonguard - On Aggro - Cast \'Sprint\''),
(16967,0,1,0,2,0,100,1,0,15,0,0,0,25,1,0,0,0,0,0,1,0,0,0,0,0,0,0,'Haal\'eshi Talonguard - Between 0-15% Health - Flee For Assist (No Repeat)');

-- Haal'eshi Windwalker (16966)
DELETE FROM `smart_scripts` WHERE `entryorguid`=16966 AND `source_type`=0;
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`event_param5`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(16966,0,0,0,0,0,100,0,0,0,3000,5000,0,11,9532,64,0,0,0,0,2,0,0,0,0,0,0,0,'Haal\'eshi Windwalker - In Combat - Cast \'Lightning Bolt\''),
(16966,0,1,0,0,0,100,0,8000,12000,20000,24000,0,11,32717,0,0,0,0,0,5,0,0,0,0,0,0,0,'Haal\'eshi Windwalker - In Combat - Cast \'Hurricane\''),
(16966,0,2,0,2,0,100,1,0,15,0,0,0,25,1,0,0,0,0,0,1,0,0,0,0,0,0,0,'Haal\'eshi Windwalker - Between 0-15% Health - Flee For Assist (No Repeat)');
