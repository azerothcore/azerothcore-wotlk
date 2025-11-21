--
-- Gryphon Commander Urik SAI
SET @ID := 27317;
-- Gryphon Commander Urik SAI
SET @ID := 27317;
UPDATE `creature_template` SET `AIName` = "SmartAI" WHERE `entry` = @ID;
DELETE FROM `smart_scripts` WHERE `entryorguid` = @ID AND `source_type` = 0;
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`event_param5`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_param4`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(@ID,0,0,0,19,0,100,0,12511,0,0,0,0,11,50629,0,0,0,0,0,7,0,0,0,0,0,0,0,0,"Gryphon Commander Urik - On Quest 'The Hills Have Us' Taken - Cast 'Gryphon to Amberpine Lodge'");


-- Wintergarde Gryphon SAI
SET @ID := 28061;
-- CREATURE_FLAG_EXTRA_NO_COMBAT, taken from creature_difficulty
-- UPDATE `creature_template` SET `AIName` = "SmartAI", `flags_extra` = `flags_extra` | 0x00002000 WHERE `entry` = @ID;
UPDATE `creature_template` SET `AIName` = "SmartAI" WHERE `entry` = @ID;
DELETE FROM `smart_scripts` WHERE `entryorguid` = @ID AND `source_type` = 0;
DELETE FROM `smart_scripts` WHERE `entryorguid` BETWEEN @ID*100+0 AND @ID*100+4 AND `source_type` = 9;
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`event_param5`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_param4`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(@ID,0,0,0,54,0,100,0,0,0,0,0,0,80,@ID*100+0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,"Wintergarde Gryphon - On Just Summoned - Run Script"),
(@ID,0,1,0,40,0,100,0,10,0,0,0,0,80,@ID*100+1,0,0,0,0,0,1,0,0,0,0,0,0,0,0,"Wintergarde Gryphon - On Waypoint 10 Reached - Run Script"),
(@ID,0,2,0,40,0,100,0,21,0,0,0,0,80,@ID*100+2,2,0,0,0,0,1,0,0,0,0,0,0,0,0,"Wintergarde Gryphon - On Waypoint 21 Reached - Run Script"),
(@ID,0,3,0,40,0,100,0,31,0,0,0,0,80,@ID*100+3,0,0,0,0,0,1,0,0,0,0,0,0,0,0,"Wintergarde Gryphon - On Waypoint 31 Reached - Run Script"),
(@ID,0,4,0,40,0,100,0,33,0,0,0,0,80,@ID*100+4,0,0,0,0,0,1,0,0,0,0,0,0,0,0,"Wintergarde Gryphon - On Waypoint 33 Reached - Run Script"),
(@ID*100+0,9,0,0,0,0,100,0,0,0,0,0,0,85,46598,0,0,0,0,0,23,0,0,0,0,0,0,0,0,"Wintergarde Gryphon - On Script - Invoker Cast 'Ride Vehicle Hardcoded'"),
(@ID*100+0,9,1,0,0,0,100,0,0,0,0,0,0,86,46598,0,19,28065,0,0,1,0,0,0,0,0,0,0,0,"Wintergarde Gryphon - On Script - Cross Cast 'Ride Vehicle Hardcoded' (Wintergarde Gryphon Rider)"),
-- We have to start WP here and pause it instantly because otherwise speed from aura will be replaced by SetRun
-- (@ID*100+0,9,2,0,0,0,100,0,0,0,0,0,0,53,1,28061,0,0,0,2,1,0,0,0,0,0,0,0,0,"Wintergarde Gryphon - On Script - Start Waypoint"),
-- (@ID*100+0,9,3,0,0,0,100,0,0,0,0,0,0,54,5000,0,0,0,0,0,1,0,0,0,0,0,0,0,0,"Wintergarde Gryphon - On Script - Pause Waypoint"),
(@ID*100+0,9,4,0,0,0,100,0,0,0,0,0,0,11,49303,0,0,0,0,0,1,0,0,0,0,0,0,0,0,"Wintergarde Gryphon - On Script - Cast 'Flight + Speed'"),
(@ID*100+0,9,5,0,0,0,100,0,2000,2000,0,0,0,1,0,0,0,0,0,0,19,28065,0,0,0,0,0,0,0,"Wintergarde Gryphon - On Script - Say Line 0 (Wintergarde Gryphon Rider)"),

(@ID*100+1,9,0,0,0,0,100,0,1000,1000,0,0,0,1,1,0,0,0,0,0,19,28065,0,0,0,0,0,0,0,"Wintergarde Gryphon - On Script - Say Line 1 (Wintergarde Gryphon Rider)"),

(@ID*100+2,9,0,0,0,0,100,0,0,0,0,0,0,1,2,0,0,0,0,0,19,28065,0,0,0,0,0,0,0,"Wintergarde Gryphon - On Script - Say Line 2 (Wintergarde Gryphon Rider)"),
-- (@ID*100+2,9,1,0,0,0,100,0,2000,2000,0,0,0,11,50560,0,0,0,0,0,1,0,0,0,0,0,0,0,0,"Wintergarde Gryphon - On Script - Cast 'Summon Conquest War Rider'"),
-- (@ID*100+2,9,2,0,0,0,100,0,0,0,0,0,0,11,50560,0,0,0,0,0,1,0,0,0,0,0,0,0,0,"Wintergarde Gryphon - On Script - Cast 'Summon Conquest War Rider'"),
-- (@ID*100+2,9,3,0,0,0,100,0,2000,2000,0,0,0,11,50560,0,0,0,0,0,1,0,0,0,0,0,0,0,0,"Wintergarde Gryphon - On Script - Cast 'Summon Conquest War Rider'"),
(@ID*100+2,9,4,0,0,0,100,0,0,0,0,0,0,11,44423,0,0,0,0,0,1,0,0,0,0,0,0,0,0,"Wintergarde Gryphon - On Script - Cast 'Soar'"),
(@ID*100+2,9,5,0,0,0,100,0,0,0,0,0,0,1,3,0,0,0,0,0,19,28065,0,0,0,0,0,0,0,"Wintergarde Gryphon - On Script - Say Line 3 (Wintergarde Gryphon Rider)"),

(@ID*100+3,9,0,0,0,0,100,0,1000,1000,0,0,0,1,4,0,0,0,0,0,19,28065,0,0,0,0,0,0,0,"Wintergarde Gryphon - On Script - Say Line 4 (Wintergarde Gryphon Rider)"),
(@ID*100+3,9,1,0,0,0,100,0,5000,5000,0,0,0,11,49261,0,0,0,0,0,1,0,0,0,0,0,0,0,0,"Wintergarde Gryphon - On Script - Cast 'Dismount Passenger'"),
(@ID*100+3,9,2,0,0,0,100,0,0,0,0,0,0,11,45472,0,0,0,0,0,23,0,0,0,0,0,0,0,0,"Wintergarde Gryphon - On Script - Cast 'Parachute'"),

(@ID*100+4,9,0,0,0,0,100,0,0,0,0,0,0,11,49259,0,0,0,0,0,1,0,0,0,0,0,0,0,0,"Wintergarde Gryphon - On Script - Cast 'Despawn Driver'"),
(@ID*100+4,9,1,0,0,0,100,0,0,0,0,0,0,41,0,0,0,0,0,0,19,28065,0,0,0,0,0,0,0,"Wintergarde Gryphon - On Script - Despawn Instant Closest Creature 'Wintergarde Gryphon Rider'"),
(@ID*100+4,9,2,0,0,0,100,0,0,0,0,0,0,41,3000,0,0,0,0,0,1,0,0,0,0,0,0,0,0,"Wintergarde Gryphon - On Script - Despawn (3000)");

DELETE FROM `waypoints` WHERE `entry` = 28061;
INSERT INTO `waypoints` (`entry`,`pointid`,`position_x`,`position_y`,`position_z`,`orientation`,`delay`,`point_comment`) VALUES
(28061,1,3699.6936,-721.9221,219.29805,0,0,"Wintergarde Gryphon"),
(28061,2,3716.3372,-744.8086,219.29805,0,0,"Wintergarde Gryphon"),
(28061,3,3754.6975,-766.4142,219.29805,0,0,"Wintergarde Gryphon"),
(28061,4,3823.4036,-778.20447,229.43698,0,0,"Wintergarde Gryphon"),
(28061,5,3855.0312,-824.1102,240.18695,0,0,"Wintergarde Gryphon"),
(28061,6,3854.3972,-931.2962,240.18697,0,0,"Wintergarde Gryphon"),
(28061,7,3816.714,-1052.798,218.93703,0,0,"Wintergarde Gryphon"),
(28061,8,3674.9307,-1234.0061,169.63153,0,0,"Wintergarde Gryphon"),
(28061,9,3562.7188,-1421.7626,169.63153,0,0,"Wintergarde Gryphon"),
(28061,10,3549.2375,-1556.2838,169.63153,0,1000,"Wintergarde Gryphon"),
(28061,11,3494.7446,-1667.5358,166.7296,0,0,"Wintergarde Gryphon"),
(28061,12,3469.591,-1731.115,160.06296,0,0,"Wintergarde Gryphon"),
(28061,13,3398.6677,-1834.3002,160.06296,0,0,"Wintergarde Gryphon"),
(28061,14,3326.5435,-1956.757,160.06296,0,0,"Wintergarde Gryphon"),
(28061,15,3302.4072,-2047.635,160.06296,0,0,"Wintergarde Gryphon"),
(28061,16,3321.5894,-2172.2275,169.86847,0,0,"Wintergarde Gryphon"),
(28061,17,3352.4548,-2278.8647,174.61842,0,0,"Wintergarde Gryphon"),
(28061,18,3349.7534,-2368.1155,174.61842,0,0,"Wintergarde Gryphon"),
(28061,19,3273.5618,-2401.9539,174.61842,0,0,"Wintergarde Gryphon"),
(28061,20,3236.3962,-2316.1958,174.61842,0,0,"Wintergarde Gryphon"),
(28061,21,3353.9648,-2232.0115,170.36844,0,4000,"Wintergarde Gryphon"),
(28061,22,3406.751,-2232.2563,159.57182,0,0,"Wintergarde Gryphon"),
(28061,23,3484.2961,-2251.2778,147.90515,0,0,"Wintergarde Gryphon"),
(28061,24,3584.2512,-2299.296,147.90515,0,0,"Wintergarde Gryphon"),
(28061,25,3687.5261,-2328.181,173.07814,0,0,"Wintergarde Gryphon"),
(28061,26,3739.8252,-2392.6477,199.38365,0,0,"Wintergarde Gryphon"),
(28061,27,3800.0535,-2478.2786,214.51729,0,0,"Wintergarde Gryphon"),
(28061,28,3769.2024,-2553.0325,213.62839,0,0,"Wintergarde Gryphon"),
(28061,29,3692.256,-2609.5562,206.48958,0,0,"Wintergarde Gryphon"),
(28061,30,3558.7239,-2723.1643,213.62839,0,0,"Wintergarde Gryphon"),
(28061,31,3439.4553,-2757.1624,223.79466,0,7000,"Wintergarde Gryphon"),
(28061,32,3406.0881,-2755.1821,227.184,0,0,"Wintergarde Gryphon"),
(28061,33,3390.089,-2773.591,227.184,0,0,"Wintergarde Gryphon");

DELETE FROM `creature_template_movement` WHERE `CreatureId` IN (28061,28063);
INSERT INTO `creature_template_movement` (`CreatureId`,`Ground`,`Swim`,`Flight`,`Rooted`,`Chase`,`Random`) VALUES
(28061,0,0,1,0,0,0),
(28063,0,0,1,0,0,0);

DELETE FROM `vehicle_template_accessory` WHERE `entry` = 28061;
INSERT INTO `vehicle_template_accessory` (`entry`,`accessory_entry`,`seat_id`,`minion`,`description`,`summontype`,`summontimer`) VALUES
(28061,28065,0,1,"Wintergarde Gryphon - Wintergarde Gryphon Rider",8,0);

DELETE FROM `spell_script_names` WHERE `spell_id` = 49261 AND `ScriptName` = "spell_gen_eject_passenger";
INSERT INTO `spell_script_names` (`spell_id`,`ScriptName`) VALUES
(49261,"spell_gen_eject_passenger");


-- Wintergarde Gryphon SAI
SET @ID := 28063;
UPDATE `creature_template` SET `AIName` = "SmartAI" WHERE `entry` = @ID;
DELETE FROM `smart_scripts` WHERE `entryorguid` = @ID AND `source_type` = 0;
DELETE FROM `smart_scripts` WHERE `entryorguid` = @ID*100+0 AND `source_type` = 9;
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`event_param5`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_param4`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(@ID,0,0,0,54,0,100,0,0,0,0,0,0,80,@ID*100+0,2,0,0,0,0,1,0,0,0,0,0,0,0,0,"Conquest Hold Windrager - On Just Summoned - Run Script"),

(@ID*100+0,9,0,0,0,0,100,0,0,0,0,0,0,1,0,0,1,0,0,0,7,0,0,0,0,0,0,0,0,"Conquest Hold Windrager - On Script - Say Line 0"),
(@ID*100+0,9,1,0,0,0,100,0,0,0,0,0,0,11,50593,0,0,0,0,0,1,0,0,0,0,0,0,0,0,"Conquest Hold Windrager - On Script - Cast 'Throw Spear'"),
-- Seems like it's random only because they despawn after they reached last point in combat
(@ID*100+0,9,2,0,0,0,100,0,13000,16000,0,0,0,41,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,"Conquest Hold Windrager - On Script - Despawn");

DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId` = 13 AND `SourceEntry` = 50592;
INSERT INTO `conditions` (`SourceTypeOrReferenceId`,`SourceGroup`,`SourceEntry`,`SourceId`,`ElseGroup`,`ConditionTypeOrReference`,`ConditionTarget`,`ConditionValue1`,`ConditionValue2`,`ConditionValue3`,`NegativeCondition`,`ErrorType`,`ErrorTextId`,`ScriptName`,`Comment`) VALUES
(13,1,50592,0,0,31,0,3,28061,0,0,0,0,"","Group 0: Spell 'Throw Spear' (Effect 1) targets creature 'Wintergarde Gryphon'");

DELETE FROM `creature_text` WHERE `CreatureID` IN (28065,28063);
INSERT INTO `creature_text` (`CreatureID`,`GroupID`,`ID`,`Text`,`Type`,`Language`,`Probability`,`Emote`,`Duration`,`Sound`,`BroadcastTextId`,`TextRange`,`comment`) VALUES
(28065,0,0,"I'll have you at Amberpine Lodge in no time, ally! We just have to make one brief stop first...",12,7,100,0,0,0,27440,0,"Wintergarde Gryphon Rider"),
(28065,1,0,"We're gonna do a quick fly by Conquest Hold to see what those filthy, no good, Horde are up to. Keep your eyes peeled for their wind riders. Not that they'd ever catch me!",12,7,100,0,0,0,27442,0,"Wintergarde Gryphon Rider"),
(28065,2,0,"What in the name of Bronzebeard is goin' on here? Look at this place! I think...",12,7,100,0,0,0,27443,0,"Wintergarde Gryphon Rider"),
(28065,3,0,"Uh-oh. We've got company! HOLD ON TIGHT! I'm gonna try and lose 'em!",12,7,100,0,0,0,27444,0,"Wintergarde Gryphon Rider"),
(28065,4,0,"I think we lost 'em! That was a close one! Welp, as promised, Amberpine Lodge in one piece! Keep your feet on the ground, friend!",12,7,100,0,0,0,27472,0,"Wintergarde Gryphon Rider"),
(28063,0,0,"INTRUDERS! KILL THEM!",12,1,100,0,0,0,27473,0,"Conquest Hold Windrager"),
(28063,0,1,"ALLIANCE FILTH! DIE! DIE!",12,1,100,0,0,0,27474,0,"Conquest Hold Windrager"),
(28063,0,2,"Take their heads! For the Horde!",12,1,100,0,0,0,27475,0,"Conquest Hold Windrager");

-- Spell 50557 specified in npc_spellclick_spells is not a valid vehicle enter aura!
-- Why it was even added?
UPDATE `npc_spellclick_spells` SET `spell_id` = 46598 WHERE `npc_entry` = 28061 AND `spell_id` = 50557;


-- Wintergarde Gryphon SAI
SET @ID := 28061;
-- CREATURE_FLAG_EXTRA_NO_COMBAT, taken from creature_difficulty
-- UPDATE `creature_template` SET `AIName` = "SmartAI", `flags_extra` = `flags_extra` | 0x00002000 WHERE `entry` = @ID;
UPDATE `creature_template` SET `AIName` = "SmartAI" WHERE `entry` = @ID;
DELETE FROM `smart_scripts` WHERE `entryorguid` = @ID AND `source_type` = 0;
DELETE FROM `smart_scripts` WHERE `entryorguid` BETWEEN @ID*100+0 AND @ID*100+4 AND `source_type` = 9;
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`event_param5`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_param4`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(@ID,0,0,0,54,0,100,0,0,0,0,0,0,80,@ID*100+0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,"Wintergarde Gryphon - On Just Summoned - Run Script"),
(@ID,0,1,0,40,0,100,0,10,0,0,0,0,80,@ID*100+1,0,0,0,0,0,1,0,0,0,0,0,0,0,0,"Wintergarde Gryphon - On Waypoint 10 Reached - Run Script"),
(@ID,0,2,0,40,0,100,0,21,0,0,0,0,80,@ID*100+2,2,0,0,0,0,1,0,0,0,0,0,0,0,0,"Wintergarde Gryphon - On Waypoint 21 Reached - Run Script"),
(@ID,0,3,0,40,0,100,0,31,0,0,0,0,80,@ID*100+3,0,0,0,0,0,1,0,0,0,0,0,0,0,0,"Wintergarde Gryphon - On Waypoint 31 Reached - Run Script"),
(@ID,0,4,0,40,0,100,0,33,0,0,0,0,80,@ID*100+4,0,0,0,0,0,1,0,0,0,0,0,0,0,0,"Wintergarde Gryphon - On Waypoint 33 Reached - Run Script"),
(@ID*100+0,9,0,0,0,0,100,0,0,0,0,0,0,85,46598,0,0,0,0,0,23,0,0,0,0,0,0,0,0,"Wintergarde Gryphon - On Script - Invoker Cast 'Ride Vehicle Hardcoded'"),
(@ID*100+0,9,1,0,0,0,100,0,0,0,0,0,0,86,46598,0,19,28065,0,0,1,0,0,0,0,0,0,0,0,"Wintergarde Gryphon - On Script - Cross Cast 'Ride Vehicle Hardcoded' (Wintergarde Gryphon Rider)"),
-- We have to start WP here and pause it instantly because otherwise speed from aura will be replaced by SetRun
-- (@ID*100+0,9,2,0,0,0,100,0,0,0,0,0,0,53,1,28061,0,0,0,2,1,0,0,0,0,0,0,0,0,"Wintergarde Gryphon - On Script - Start Waypoint"),
-- (@ID*100+0,9,3,0,0,0,100,0,0,0,0,0,0,54,5000,0,0,0,0,0,1,0,0,0,0,0,0,0,0,"Wintergarde Gryphon - On Script - Pause Waypoint"),
(@ID*100+0,9,4,0,0,0,100,0,0,0,0,0,0,11,49303,0,0,0,0,0,1,0,0,0,0,0,0,0,0,"Wintergarde Gryphon - On Script - Cast 'Flight + Speed'"),
(@ID*100+0,9,5,0,0,0,100,0,2000,2000,0,0,0,1,0,0,0,0,0,0,19,28065,0,0,0,0,0,0,0,"Wintergarde Gryphon - On Script - Say Line 0 (Wintergarde Gryphon Rider)"),

(@ID*100+1,9,0,0,0,0,100,0,1000,1000,0,0,0,1,1,0,0,0,0,0,19,28065,0,0,0,0,0,0,0,"Wintergarde Gryphon - On Script - Say Line 1 (Wintergarde Gryphon Rider)"),

(@ID*100+2,9,0,0,0,0,100,0,0,0,0,0,0,1,2,0,0,0,0,0,19,28065,0,0,0,0,0,0,0,"Wintergarde Gryphon - On Script - Say Line 2 (Wintergarde Gryphon Rider)"),
-- (@ID*100+2,9,1,0,0,0,100,0,2000,2000,0,0,0,11,50560,0,0,0,0,0,1,0,0,0,0,0,0,0,0,"Wintergarde Gryphon - On Script - Cast 'Summon Conquest War Rider'"),
-- (@ID*100+2,9,2,0,0,0,100,0,0,0,0,0,0,11,50560,0,0,0,0,0,1,0,0,0,0,0,0,0,0,"Wintergarde Gryphon - On Script - Cast 'Summon Conquest War Rider'"),
-- (@ID*100+2,9,3,0,0,0,100,0,2000,2000,0,0,0,11,50560,0,0,0,0,0,1,0,0,0,0,0,0,0,0,"Wintergarde Gryphon - On Script - Cast 'Summon Conquest War Rider'"),
(@ID*100+2,9,4,0,0,0,100,0,0,0,0,0,0,11,44423,0,0,0,0,0,1,0,0,0,0,0,0,0,0,"Wintergarde Gryphon - On Script - Cast 'Soar'"),
(@ID*100+2,9,5,0,0,0,100,0,0,0,0,0,0,1,3,0,0,0,0,0,19,28065,0,0,0,0,0,0,0,"Wintergarde Gryphon - On Script - Say Line 3 (Wintergarde Gryphon Rider)"),

(@ID*100+3,9,0,0,0,0,100,0,1000,1000,0,0,0,1,4,0,0,0,0,0,19,28065,0,0,0,0,0,0,0,"Wintergarde Gryphon - On Script - Say Line 4 (Wintergarde Gryphon Rider)"),
(@ID*100+3,9,1,0,0,0,100,0,5000,5000,0,0,0,11,49261,0,0,0,0,0,1,0,0,0,0,0,0,0,0,"Wintergarde Gryphon - On Script - Cast 'Dismount Passenger'"),
(@ID*100+3,9,2,0,0,0,100,0,0,0,0,0,0,11,45472,0,0,0,0,0,23,0,0,0,0,0,0,0,0,"Wintergarde Gryphon - On Script - Cast 'Parachute'"),

(@ID*100+4,9,0,0,0,0,100,0,0,0,0,0,0,11,49259,0,0,0,0,0,1,0,0,0,0,0,0,0,0,"Wintergarde Gryphon - On Script - Cast 'Despawn Driver'"),
(@ID*100+4,9,1,0,0,0,100,0,0,0,0,0,0,41,0,0,0,0,0,0,19,28065,0,0,0,0,0,0,0,"Wintergarde Gryphon - On Script - Despawn Instant Closest Creature 'Wintergarde Gryphon Rider'"),
(@ID*100+4,9,2,0,0,0,100,0,0,0,0,0,0,41,3000,0,0,0,0,0,1,0,0,0,0,0,0,0,0,"Wintergarde Gryphon - On Script - Despawn (3000)");

DELETE FROM `waypoints` WHERE `entry` = 28061;
INSERT INTO `waypoints` (`entry`,`pointid`,`position_x`,`position_y`,`position_z`,`orientation`,`delay`,`point_comment`) VALUES
(28061,1,3699.6936,-721.9221,219.29805,0,0,"Wintergarde Gryphon"),
(28061,2,3716.3372,-744.8086,219.29805,0,0,"Wintergarde Gryphon"),
(28061,3,3754.6975,-766.4142,219.29805,0,0,"Wintergarde Gryphon"),
(28061,4,3823.4036,-778.20447,229.43698,0,0,"Wintergarde Gryphon"),
(28061,5,3855.0312,-824.1102,240.18695,0,0,"Wintergarde Gryphon"),
(28061,6,3854.3972,-931.2962,240.18697,0,0,"Wintergarde Gryphon"),
(28061,7,3816.714,-1052.798,218.93703,0,0,"Wintergarde Gryphon"),
(28061,8,3674.9307,-1234.0061,169.63153,0,0,"Wintergarde Gryphon"),
(28061,9,3562.7188,-1421.7626,169.63153,0,0,"Wintergarde Gryphon"),
(28061,10,3549.2375,-1556.2838,169.63153,0,1000,"Wintergarde Gryphon"),
(28061,11,3494.7446,-1667.5358,166.7296,0,0,"Wintergarde Gryphon"),
(28061,12,3469.591,-1731.115,160.06296,0,0,"Wintergarde Gryphon"),
(28061,13,3398.6677,-1834.3002,160.06296,0,0,"Wintergarde Gryphon"),
(28061,14,3326.5435,-1956.757,160.06296,0,0,"Wintergarde Gryphon"),
(28061,15,3302.4072,-2047.635,160.06296,0,0,"Wintergarde Gryphon"),
(28061,16,3321.5894,-2172.2275,169.86847,0,0,"Wintergarde Gryphon"),
(28061,17,3352.4548,-2278.8647,174.61842,0,0,"Wintergarde Gryphon"),
(28061,18,3349.7534,-2368.1155,174.61842,0,0,"Wintergarde Gryphon"),
(28061,19,3273.5618,-2401.9539,174.61842,0,0,"Wintergarde Gryphon"),
(28061,20,3236.3962,-2316.1958,174.61842,0,0,"Wintergarde Gryphon"),
(28061,21,3353.9648,-2232.0115,170.36844,0,4000,"Wintergarde Gryphon"),
(28061,22,3406.751,-2232.2563,159.57182,0,0,"Wintergarde Gryphon"),
(28061,23,3484.2961,-2251.2778,147.90515,0,0,"Wintergarde Gryphon"),
(28061,24,3584.2512,-2299.296,147.90515,0,0,"Wintergarde Gryphon"),
(28061,25,3687.5261,-2328.181,173.07814,0,0,"Wintergarde Gryphon"),
(28061,26,3739.8252,-2392.6477,199.38365,0,0,"Wintergarde Gryphon"),
(28061,27,3800.0535,-2478.2786,214.51729,0,0,"Wintergarde Gryphon"),
(28061,28,3769.2024,-2553.0325,213.62839,0,0,"Wintergarde Gryphon"),
(28061,29,3692.256,-2609.5562,206.48958,0,0,"Wintergarde Gryphon"),
(28061,30,3558.7239,-2723.1643,213.62839,0,0,"Wintergarde Gryphon"),
(28061,31,3439.4553,-2757.1624,223.79466,0,7000,"Wintergarde Gryphon"),
(28061,32,3406.0881,-2755.1821,227.184,0,0,"Wintergarde Gryphon"),
(28061,33,3390.089,-2773.591,227.184,0,0,"Wintergarde Gryphon");

DELETE FROM `creature_template_movement` WHERE `CreatureId` IN (28061,28063);
INSERT INTO `creature_template_movement` (`CreatureId`,`Ground`,`Swim`,`Flight`,`Rooted`,`Chase`,`Random`) VALUES
(28061,0,0,1,0,0,0),
(28063,0,0,1,0,0,0);

DELETE FROM `vehicle_template_accessory` WHERE `entry` = 28061;
INSERT INTO `vehicle_template_accessory` (`entry`,`accessory_entry`,`seat_id`,`minion`,`description`,`summontype`,`summontimer`) VALUES
(28061,28065,0,1,"Wintergarde Gryphon - Wintergarde Gryphon Rider",8,0);

DELETE FROM `spell_script_names` WHERE `spell_id` = 49261 AND `ScriptName` = "spell_gen_eject_passenger";
INSERT INTO `spell_script_names` (`spell_id`,`ScriptName`) VALUES
(49261,"spell_gen_eject_passenger");


-- Wintergarde Gryphon SAI
SET @ID := 28063;
UPDATE `creature_template` SET `AIName` = "SmartAI" WHERE `entry` = @ID;
DELETE FROM `smart_scripts` WHERE `entryorguid` = @ID AND `source_type` = 0;
DELETE FROM `smart_scripts` WHERE `entryorguid` = @ID*100+0 AND `source_type` = 9;
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`event_param5`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_param4`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(@ID,0,0,0,54,0,100,0,0,0,0,0,0,80,@ID*100+0,2,0,0,0,0,1,0,0,0,0,0,0,0,0,"Conquest Hold Windrager - On Just Summoned - Run Script"),

(@ID*100+0,9,0,0,0,0,100,0,0,0,0,0,0,1,0,0,1,0,0,0,7,0,0,0,0,0,0,0,0,"Conquest Hold Windrager - On Script - Say Line 0"),
(@ID*100+0,9,1,0,0,0,100,0,0,0,0,0,0,11,50593,0,0,0,0,0,1,0,0,0,0,0,0,0,0,"Conquest Hold Windrager - On Script - Cast 'Throw Spear'"),
-- Seems like it's random only because they despawn after they reached last point in combat
(@ID*100+0,9,2,0,0,0,100,0,13000,16000,0,0,0,41,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,"Conquest Hold Windrager - On Script - Despawn");

DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId` = 13 AND `SourceEntry` = 50592;
INSERT INTO `conditions` (`SourceTypeOrReferenceId`,`SourceGroup`,`SourceEntry`,`SourceId`,`ElseGroup`,`ConditionTypeOrReference`,`ConditionTarget`,`ConditionValue1`,`ConditionValue2`,`ConditionValue3`,`NegativeCondition`,`ErrorType`,`ErrorTextId`,`ScriptName`,`Comment`) VALUES
(13,1,50592,0,0,31,0,3,28061,0,0,0,0,"","Group 0: Spell 'Throw Spear' (Effect 1) targets creature 'Wintergarde Gryphon'");

DELETE FROM `creature_text` WHERE `CreatureID` IN (28065,28063);
INSERT INTO `creature_text` (`CreatureID`,`GroupID`,`ID`,`Text`,`Type`,`Language`,`Probability`,`Emote`,`Duration`,`Sound`,`BroadcastTextId`,`TextRange`,`comment`) VALUES
(28065,0,0,"I'll have you at Amberpine Lodge in no time, ally! We just have to make one brief stop first...",12,7,100,0,0,0,27440,0,"Wintergarde Gryphon Rider"),
(28065,1,0,"We're gonna do a quick fly by Conquest Hold to see what those filthy, no good, Horde are up to. Keep your eyes peeled for their wind riders. Not that they'd ever catch me!",12,7,100,0,0,0,27442,0,"Wintergarde Gryphon Rider"),
(28065,2,0,"What in the name of Bronzebeard is goin' on here? Look at this place! I think...",12,7,100,0,0,0,27443,0,"Wintergarde Gryphon Rider"),
(28065,3,0,"Uh-oh. We've got company! HOLD ON TIGHT! I'm gonna try and lose 'em!",12,7,100,0,0,0,27444,0,"Wintergarde Gryphon Rider"),
(28065,4,0,"I think we lost 'em! That was a close one! Welp, as promised, Amberpine Lodge in one piece! Keep your feet on the ground, friend!",12,7,100,0,0,0,27472,0,"Wintergarde Gryphon Rider"),
(28063,0,0,"INTRUDERS! KILL THEM!",12,1,100,0,0,0,27473,0,"Conquest Hold Windrager"),
(28063,0,1,"ALLIANCE FILTH! DIE! DIE!",12,1,100,0,0,0,27474,0,"Conquest Hold Windrager"),
(28063,0,2,"Take their heads! For the Horde!",12,1,100,0,0,0,27475,0,"Conquest Hold Windrager");

-- Spell 50557 specified in npc_spellclick_spells is not a valid vehicle enter aura!
-- Why it was even added?
UPDATE `npc_spellclick_spells` SET `spell_id` = 46598 WHERE `npc_entry` = 28061 AND `spell_id` = 50557;