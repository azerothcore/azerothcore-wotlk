-- Convert smart scripts

-- Creatures

-- Ya-six Spell Generator
DELETE FROM `smart_scripts` WHERE `entry` IN (-247235,-247236) AND `source_type`=0;
DELETE FROM `smart_scripts` WHERE `entry` IN (20608) AND `source_type`=0;
INSERT INTO `smart_scripts` (`entry`,`guid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`event_param5`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_param4`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(20608,247235,0,0,0,60,0,100,512,0,0,5000,5000,0,45,1,0,0,0,0,0,11,20603,5,0,0,0,0,0,0,'Ya-six Spell Generator - On Update - Set Data'),
(20608,247236,0,1,0,60,0,100,512,0,0,5000,5000,0,45,2,0,0,0,0,0,11,20603,5,0,0,0,0,0,0,'Ya-six Spell Generator - On Update - Set Data');

-- Argent Cruasder
DELETE FROM `smart_scripts` WHERE `entry` IN (-246904,-246915) AND `source_type`=0;
DELETE FROM `smart_scripts` WHERE `entry` IN (38493) AND `source_type`=0;
INSERT INTO `smart_scripts` (`entry`,`guid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`event_param5`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_param4`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(38493,246904,0,0,0,60,0,100,512,180000,180000,180000,180000,0,80,3849300,2,0,0,0,0,1,0,0,0,0,0,0,0,0,'Argent Cruasder - On Update - Run Script'),
(38493,246904,0,1,2,17,0,100,512,0,0,0,0,0,45,2,0,0,0,0,0,7,0,0,0,0,0,0,0,0,'Argent Cruasder - Just Summoned - Move Target To Position'),
(38493,246904,0,2,0,61,0,100,512,0,0,0,0,0,201,1,0,0,0,0,0,7,0,0,0,0,5869.55,2192.07,636.05,0,'Argent Cruasder - Just Summoned - Move Target To Position'),
(38493,246915,0,3,0,60,0,100,512,180000,180000,180000,180000,0,80,3849301,2,0,0,0,0,1,0,0,0,0,0,0,0,0,'Argent Cruasder - On Update - Run Script'),
(38493,246915,0,4,2,17,0,100,512,0,0,0,0,0,45,1,0,0,0,0,0,7,0,0,0,0,0,0,0,0,'Argent Cruasder - Just Summoned - Set Data'),
(38493,246915,0,5,0,61,0,100,512,0,0,0,0,0,201,1,0,0,0,0,0,7,0,0,0,0,5911.48,2049,636.05,0,'Argent Cruasder - Just Summoned - Move Target To Position');

-- Ghostly Denizen
DELETE FROM `smart_scripts` WHERE `entry` IN (-239030,-239029,-239028,-239027,-239026,-239025,-239024,-239023,-239022) AND `source_type`=0;
DELETE FROM `smart_scripts` WHERE `entry` IN (16976) AND `source_type`=0;
INSERT INTO `smart_scripts` (`entry`,`guid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`event_param5`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_param4`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(16976,239022,0,0,0,1,1,30,0,10000,50000,30000,60000,0,1,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Ghostly Denizen - Out of Combat - Say Line 0'),
(16976,239022,0,1,0,38,0,100,512,1,1,0,0,0,80,1697600,2,0,0,0,0,1,0,0,0,0,0,0,0,0,'Ghostly Denizen - On Data Set - Run Script'),
(16976,239022,0,2,0,25,0,100,512,0,0,0,0,0,22,1,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Ghostly Denizen - On Reset - Set Event Phase'),
(16976,239023,0,3,0,1,1,30,0,10000,50000,30000,60000,0,1,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Ghostly Denizen - Out of Combat - Say Line 0'),
(16976,239023,0,4,0,38,0,100,512,1,1,0,0,0,80,1697600,2,0,0,0,0,1,0,0,0,0,0,0,0,0,'Ghostly Denizen - On Data Set - Run Script'),
(16976,239023,0,5,0,25,0,100,512,0,0,0,0,0,22,1,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Ghostly Denizen - On Reset - Set Event Phase'),
(16976,239024,0,6,0,1,1,30,0,10000,50000,30000,60000,0,1,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Ghostly Denizen - Out of Combat - Say Line 0'),
(16976,239024,0,7,0,38,0,100,512,1,1,0,0,0,80,1697600,2,0,0,0,0,1,0,0,0,0,0,0,0,0,'Ghostly Denizen - On Data Set - Run Script'),
(16976,239024,0,8,0,25,0,100,512,0,0,0,0,0,22,1,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Ghostly Denizen - On Reset - Set Event Phase'),
(16976,239025,0,9,0,1,1,30,0,10000,50000,30000,60000,0,1,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Ghostly Denizen - Out of Combat - Say Line 0'),
(16976,239025,0,10,0,38,0,100,512,1,1,0,0,0,80,1697600,2,0,0,0,0,1,0,0,0,0,0,0,0,0,'Ghostly Denizen - On Data Set - Run Script'),
(16976,239025,0,11,0,25,0,100,512,0,0,0,0,0,22,1,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Ghostly Denizen - On Reset - Set Event Phase'),
(16976,239026,0,12,0,1,1,30,0,10000,50000,30000,60000,0,1,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Ghostly Denizen - Out of Combat - Say Line 0'),
(16976,239026,0,13,0,38,0,100,512,1,1,0,0,0,80,1697600,2,0,0,0,0,1,0,0,0,0,0,0,0,0,'Ghostly Denizen - On Data Set - Run Script'),
(16976,239026,0,14,0,25,0,100,512,0,0,0,0,0,22,1,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Ghostly Denizen - On Reset - Set Event Phase'),
(16976,239027,0,15,0,1,1,30,0,10000,50000,30000,60000,0,1,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Ghostly Denizen - Out of Combat - Say Line 0'),
(16976,239027,0,16,0,38,0,100,512,1,1,0,0,0,80,1697600,2,0,0,0,0,1,0,0,0,0,0,0,0,0,'Ghostly Denizen - On Data Set - Run Script'),
(16976,239027,0,17,0,25,0,100,512,0,0,0,0,0,22,1,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Ghostly Denizen - On Reset - Set Event Phase'),
(16976,239028,0,18,0,1,1,30,0,10000,50000,30000,60000,0,1,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Ghostly Denizen - Out of Combat - Say Line 0'),
(16976,239028,0,19,0,38,0,100,512,1,1,0,0,0,80,1697600,2,0,0,0,0,1,0,0,0,0,0,0,0,0,'Ghostly Denizen - On Data Set - Run Script'),
(16976,239028,0,20,0,25,0,100,512,0,0,0,0,0,22,1,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Ghostly Denizen - On Reset - Set Event Phase'),
(16976,239029,0,21,0,1,1,30,0,10000,50000,30000,60000,0,1,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Ghostly Denizen - Out of Combat - Say Line 0'),
(16976,239029,0,22,0,38,0,100,512,1,1,0,0,0,80,1697600,2,0,0,0,0,1,0,0,0,0,0,0,0,0,'Ghostly Denizen - On Data Set - Run Script'),
(16976,239029,0,23,0,25,0,100,512,0,0,0,0,0,22,1,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Ghostly Denizen - On Reset - Set Event Phase'),
(16976,239030,0,24,0,1,1,30,0,10000,50000,30000,60000,0,1,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Ghostly Denizen - Out of Combat - Say Line 0'),
(16976,239030,0,25,0,38,0,100,512,1,1,0,0,0,80,1697600,2,0,0,0,0,1,0,0,0,0,0,0,0,0,'Ghostly Denizen - On Data Set - Run Script'),
(16976,239030,0,26,0,25,0,100,512,0,0,0,0,0,22,1,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Ghostly Denizen - On Reset - Set Event Phase');

-- Drakuru's Bunny 05
DELETE FROM `smart_scripts` WHERE `entry` IN (-245801,-245800) AND `source_type`=0;
DELETE FROM `smart_scripts` WHERE `entry` IN (28015) AND `source_type`=0;
INSERT INTO `smart_scripts` (`entry`,`guid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`event_param5`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_param4`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(28015,245800,0,0,0,1,0,100,1,0,0,180000,180000,0,11,46314,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Drakuru''s Bunny 05 - Ahune event frozen ground effect'),
(28015,245801,0,1,0,1,0,100,1,0,0,180000,180000,0,11,46314,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Drakuru''s Bunny 05 - Ahune event frozen ground effect');

-- Injured Goblin Miner
DELETE FROM `smart_scripts` WHERE `entry` IN (-209188,-209187,-202337) AND `source_type`=0;
DELETE FROM `smart_scripts` WHERE `entry` IN (29434) AND `source_type`=0;
INSERT INTO `smart_scripts` (`entry`,`guid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`event_param5`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_param4`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(29434,209187,0,0,0,11,0,100,512,0,0,0,0,0,90,7,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Injured Goblin Miner - ON Respawn - SET ''UNIT_STAND_STATE_DEAD'''),
(29434,209187,0,1,2,19,0,100,512,12832,0,0,0,0,91,7,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Injured Goblin Miner - ON Accepted Quest ''Bitter Departure'' - REMOVE ''UNIT_STAND_STATE_DEAD'''),
(29434,209187,0,2,3,61,0,100,512,0,0,0,0,0,1,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Injured Goblin Miner - Linked - Say Line 0'),
(29434,209187,0,3,0,61,0,100,512,0,0,0,0,0,66,0,0,0,0,0,0,7,0,0,0,0,0,0,0,0,'Injured Goblin Miner - Linked - SET Orientation (INVOKER)'),
(29434,209187,0,4,5,62,0,100,512,9859,0,0,0,0,48,1,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Injured Goblin Miner - ON Gossip SELECT 0 - SET Active ON'),
(29434,209187,0,5,6,61,0,100,512,0,0,0,0,0,91,7,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Injured Goblin Miner - Linked - REMOVE ''UNIT_STAND_STATE_DEAD'''),
(29434,209187,0,6,7,61,0,100,512,0,0,0,0,0,64,1,0,0,0,0,0,7,0,0,0,0,0,0,0,0,'Injured Goblin Miner - Linked - Store Target LIST (INVOKER)'),
(29434,209187,0,7,8,61,0,100,512,0,0,0,0,0,83,3,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Injured Goblin Miner - Linked - REMOVE NPC Flags ''Gossip'' & ''Quest Giver'''),
(29434,209187,0,8,9,61,0,100,512,0,0,0,0,0,2,250,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Injured Goblin Miner - Linked - SET Faction 250'),
(29434,209187,0,9,0,61,0,100,512,0,0,0,0,0,53,1,2943401,0,0,0,2,1,0,0,0,0,0,0,0,0,'Injured Goblin Miner - Linked - START Waypoint Movement (React State ''Aggressive'')'),
(29434,209187,0,10,0,58,0,100,512,0,0,0,0,0,80,2943400,2,0,0,0,0,1,0,0,0,0,0,0,0,0,'Injured Goblin Miner - ON Waypoint Ended - CALL Timed ACTION LIST'),
(29434,209187,0,11,0,6,0,100,512,0,0,0,0,0,6,12832,0,0,0,0,0,12,1,0,0,0,0,0,0,0,'Injured Goblin Miner - ON Just Died - Fail Quest ''Bitter Departure'' (STORED Target)'),
(29434,209188,0,12,0,11,0,100,512,0,0,0,0,0,90,7,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Injured Goblin Miner - On Respawn - Set ''UNIT_STAND_STATE_DEAD'''),
(29434,209188,0,13,2,19,0,100,512,12832,0,0,0,0,91,7,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Injured Goblin Miner - On Accepted Quest ''Bitter Departure'' - Remove ''UNIT_STAND_STATE_DEAD'''),
(29434,209188,0,14,3,61,0,100,512,0,0,0,0,0,1,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Injured Goblin Miner - Linked - Say Line 0'),
(29434,209188,0,15,0,61,0,100,512,0,0,0,0,0,66,0,0,0,0,0,0,7,0,0,0,0,0,0,0,0,'Injured Goblin Miner - Linked - Set Orientation (Invoker)'),
(29434,209188,0,16,5,62,0,100,512,9859,0,0,0,0,48,1,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Injured Goblin Miner - On Gossip Select 0 - Set Active On'),
(29434,209188,0,17,6,61,0,100,512,0,0,0,0,0,91,7,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Injured Goblin Miner - Linked - Remove ''UNIT_STAND_STATE_DEAD'''),
(29434,209188,0,18,7,61,0,100,512,0,0,0,0,0,64,1,0,0,0,0,0,7,0,0,0,0,0,0,0,0,'Injured Goblin Miner - Linked - Store Target List (Invoker)'),
(29434,209188,0,19,8,61,0,100,512,0,0,0,0,0,83,3,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Injured Goblin Miner - Linked - Remove NPC Flags ''Gossip'' & ''Quest Giver'''),
(29434,209188,0,20,9,61,0,100,512,0,0,0,0,0,2,250,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Injured Goblin Miner - Linked - Set Faction 250'),
(29434,209188,0,21,0,61,0,100,512,0,0,0,0,0,53,1,2943402,0,0,0,2,1,0,0,0,0,0,0,0,0,'Injured Goblin Miner - Linked - Start Waypoint Movement (React State ''Aggressive'')'),
(29434,209188,0,22,0,58,0,100,512,0,0,0,0,0,80,2943400,2,0,0,0,0,1,0,0,0,0,0,0,0,0,'Injured Goblin Miner - On Waypoint Ended - Call Timed Action List'),
(29434,209188,0,23,0,6,0,100,512,0,0,0,0,0,6,12832,0,0,0,0,0,12,1,0,0,0,0,0,0,0,'Injured Goblin Miner - On Just Died - Fail Quest ''Bitter Departure'' (Stored Target)'),
(29434,202337,0,24,0,11,0,100,512,0,0,0,0,0,90,7,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Injured Goblin Miner - On Respawn - Set ''UNIT_STAND_STATE_DEAD'''),
(29434,202337,0,25,2,19,0,100,512,12832,0,0,0,0,91,7,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Injured Goblin Miner - On Accepted Quest ''Bitter Departure'' - Remove ''UNIT_STAND_STATE_DEAD'''),
(29434,202337,0,26,3,61,0,100,512,0,0,0,0,0,1,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Injured Goblin Miner - Linked - Say Line 0'),
(29434,202337,0,27,0,61,0,100,512,0,0,0,0,0,66,0,0,0,0,0,0,7,0,0,0,0,0,0,0,0,'Injured Goblin Miner - Linked - Set Orientation (Invoker)'),
(29434,202337,0,28,5,62,0,100,512,9859,0,0,0,0,48,1,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Injured Goblin Miner - On Gossip Select 0 - Set Active On'),
(29434,202337,0,29,6,61,0,100,512,0,0,0,0,0,91,7,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Injured Goblin Miner - Linked - Remove ''UNIT_STAND_STATE_DEAD'''),
(29434,202337,0,30,7,61,0,100,512,0,0,0,0,0,64,1,0,0,0,0,0,7,0,0,0,0,0,0,0,0,'Injured Goblin Miner - Linked - Store Target List (Invoker)'),
(29434,202337,0,31,8,61,0,100,512,0,0,0,0,0,83,3,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Injured Goblin Miner - Linked - Remove NPC Flags ''Gossip'' & ''Quest Giver'''),
(29434,202337,0,32,9,61,0,100,512,0,0,0,0,0,2,250,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Injured Goblin Miner - Linked - Set Faction 250'),
(29434,202337,0,33,0,61,0,100,512,0,0,0,0,0,53,1,2943400,0,0,0,2,1,0,0,0,0,0,0,0,0,'Injured Goblin Miner - Linked - Start Waypoint Movement (React State ''Aggressive'')'),
(29434,202337,0,34,0,58,0,100,512,0,0,0,0,0,80,2943400,2,0,0,0,0,1,0,0,0,0,0,0,0,0,'Injured Goblin Miner - On Waypoint Ended - Call Timed Action List'),
(29434,202337,0,35,0,6,0,100,512,0,0,0,0,0,6,12832,0,0,0,0,0,12,1,0,0,0,0,0,0,0,'Injured Goblin Miner - On Just Died - Fail Quest ''Bitter Departure'' (Stored Target)');

-- Goblin Sapper
DELETE FROM `smart_scripts` WHERE `entry` IN (-209158,-209157,-209156,-209155,-209154,-209153) AND `source_type`=0;
DELETE FROM `smart_scripts` WHERE `entry` IN (29555) AND `source_type`=0;
INSERT INTO `smart_scripts` (`entry`,`guid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`event_param5`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_param4`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(29555,209153,0,0,0,11,0,100,512,0,0,0,0,0,20,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Goblin Sapper - On Respawn - Disable Auto Attack'),
(29555,209153,0,1,0,1,0,100,512,1000,30000,0,0,0,53,1,2955500,0,0,0,2,1,0,0,0,0,0,0,0,0,'Goblin Sapper - OOC - Start Waypoint Movement'),
(29555,209153,0,2,0,9,0,100,512,0,2,0,0,0,80,2955500,2,0,0,0,0,1,0,0,0,0,0,0,0,0,'Goblin Sapper - Victim In Range 0-2 Yards - Call Action List'),
(29555,209153,0,3,0,58,0,100,512,0,0,0,0,0,80,2955500,2,0,0,0,0,1,0,0,0,0,0,0,0,0,'Goblin Sapper - On Waypoint Path Ended - Call Action List'),
(29555,209154,0,4,0,11,0,100,512,0,0,0,0,0,20,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Goblin Sapper - On Respawn - Disable Auto Attack'),
(29555,209154,0,5,0,1,0,100,512,1000,30000,0,0,0,53,1,2955500,0,0,0,2,1,0,0,0,0,0,0,0,0,'Goblin Sapper - OOC - Start Waypoint Movement'),
(29555,209154,0,6,0,9,0,100,512,0,2,0,0,0,80,2955500,2,0,0,0,0,1,0,0,0,0,0,0,0,0,'Goblin Sapper - Victim In Range 0-2 Yards - Call Action List'),
(29555,209154,0,7,0,58,0,100,512,0,0,0,0,0,80,2955500,2,0,0,0,0,1,0,0,0,0,0,0,0,0,'Goblin Sapper - On Waypoint Path Ended - Call Action List'),
(29555,209155,0,8,0,11,0,100,512,0,0,0,0,0,20,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Goblin Sapper - On Respawn - Disable Auto Attack'),
(29555,209155,0,9,0,1,0,100,512,1000,30000,0,0,0,53,1,2955500,0,0,0,2,1,0,0,0,0,0,0,0,0,'Goblin Sapper - OOC - Start Waypoint Movement'),
(29555,209155,0,10,0,9,0,100,512,0,2,0,0,0,80,2955500,2,0,0,0,0,1,0,0,0,0,0,0,0,0,'Goblin Sapper - Victim In Range 0-2 Yards - Call Action List'),
(29555,209155,0,11,0,58,0,100,512,0,0,0,0,0,80,2955500,2,0,0,0,0,1,0,0,0,0,0,0,0,0,'Goblin Sapper - On Waypoint Path Ended - Call Action List'),
(29555,209156,0,12,0,11,0,100,512,0,0,0,0,0,20,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Goblin Sapper - On Respawn - Disable Auto Attack'),
(29555,209156,0,13,0,1,0,100,512,1000,30000,0,0,0,53,1,2955500,0,0,0,2,1,0,0,0,0,0,0,0,0,'Goblin Sapper - OOC - Start Waypoint Movement'),
(29555,209156,0,14,0,9,0,100,512,0,2,0,0,0,80,2955500,2,0,0,0,0,1,0,0,0,0,0,0,0,0,'Goblin Sapper - Victim In Range 0-2 Yards - Call Action List'),
(29555,209156,0,15,0,58,0,100,512,0,0,0,0,0,80,2955500,2,0,0,0,0,1,0,0,0,0,0,0,0,0,'Goblin Sapper - On Waypoint Path Ended - Call Action List'),
(29555,209157,0,16,0,11,0,100,512,0,0,0,0,0,20,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Goblin Sapper - On Respawn - Disable Auto Attack'),
(29555,209157,0,17,0,1,0,100,512,1000,30000,0,0,0,53,1,2955500,0,0,0,2,1,0,0,0,0,0,0,0,0,'Goblin Sapper - OOC - Start Waypoint Movement'),
(29555,209157,0,18,0,9,0,100,512,0,2,0,0,0,80,2955500,2,0,0,0,0,1,0,0,0,0,0,0,0,0,'Goblin Sapper - Victim In Range 0-2 Yards - Call Action List'),
(29555,209157,0,19,0,58,0,100,512,0,0,0,0,0,80,2955500,2,0,0,0,0,1,0,0,0,0,0,0,0,0,'Goblin Sapper - On Waypoint Path Ended - Call Action List'),
(29555,209158,0,20,0,11,0,100,512,0,0,0,0,0,20,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Goblin Sapper - On Respawn - Disable Auto Attack'),
(29555,209158,0,21,0,1,0,100,512,1000,30000,0,0,0,53,1,2955500,0,0,0,2,1,0,0,0,0,0,0,0,0,'Goblin Sapper - OOC - Start Waypoint Movement'),
(29555,209158,0,22,0,9,0,100,512,0,2,0,0,0,80,2955500,2,0,0,0,0,1,0,0,0,0,0,0,0,0,'Goblin Sapper - Victim In Range 0-2 Yards - Call Action List'),
(29555,209158,0,23,0,58,0,100,512,0,0,0,0,0,80,2955500,2,0,0,0,0,1,0,0,0,0,0,0,0,0,'Goblin Sapper - On Waypoint Path Ended - Call Action List');

-- Invisible Stalker (Scale x0.5)
DELETE FROM `smart_scripts` WHERE `entry` IN (-209026,-209025,-209024,-209023,-209022,-209021,-209020,-209019) AND `source_type`=0;
DELETE FROM `smart_scripts` WHERE `entry` IN (25171) AND `source_type`=0;
INSERT INTO `smart_scripts` (`entry`,`guid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`event_param5`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_param4`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(25171,209019,0,0,0,1,0,100,1,500,500,0,0,0,11,63413,0,0,0,0,0,11,35469,10,0,0,0,0,0,0,'Invisible Stalker (Scale x0.5) - OUT of Combat - CAST ''Rope Beam'' (NO REPEAT)'),
(25171,209020,0,1,0,1,0,100,1,500,500,0,0,0,11,63413,0,0,0,0,0,11,35469,10,0,0,0,0,0,0,'Invisible Stalker (Scale x0.5) - OUT of Combat - CAST ''Rope Beam'' (NO REPEAT)'),
(25171,209021,0,2,0,1,0,100,1,500,500,0,0,0,11,63413,0,0,0,0,0,11,35470,10,0,0,0,0,0,0,'Invisible Stalker (Scale x0.5) - OUT of Combat - CAST ''Rope Beam'' (NO REPEAT)'),
(25171,209022,0,3,0,1,0,100,1,500,500,0,0,0,11,63413,0,0,0,0,0,11,35469,10,0,0,0,0,0,0,'Invisible Stalker (Scale x0.5) - OUT of Combat - CAST ''Rope Beam'' (NO REPEAT)'),
(25171,209023,0,4,0,1,0,100,1,500,500,0,0,0,11,63413,0,0,0,0,0,11,35469,10,0,0,0,0,0,0,'Invisible Stalker (Scale x0.5) - OUT of Combat - CAST ''Rope Beam'' (NO REPEAT)'),
(25171,209024,0,5,0,1,0,100,1,500,500,0,0,0,11,63413,0,0,0,0,0,11,35470,10,0,0,0,0,0,0,'Invisible Stalker (Scale x0.5) - OUT of Combat - CAST ''Rope Beam'' (NO REPEAT)'),
(25171,209025,0,6,0,1,0,100,1,500,500,0,0,0,11,63413,0,0,0,0,0,11,35470,10,0,0,0,0,0,0,'Invisible Stalker (Scale x0.5) - OUT of Combat - CAST ''Rope Beam'' (NO REPEAT)'),
(25171,209026,0,7,0,1,0,100,1,500,500,0,0,0,11,63413,0,0,0,0,0,11,35470,10,0,0,0,0,0,0,'Invisible Stalker (Scale x0.5) - OUT of Combat - CAST ''Rope Beam'' (NO REPEAT)');

-- Azure Front Channel Stalker
DELETE FROM `smart_scripts` WHERE `entry` IN (-203457) AND `source_type`=0;
DELETE FROM `smart_scripts` WHERE `entry` IN (31400) AND `source_type`=0;
INSERT INTO `smart_scripts` (`entry`,`guid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`event_param5`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_param4`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(31400,203457,0,0,0,1,0,100,513,1000,1000,1000,1000,0,11,59044,2,0,0,0,0,10,111746,31400,0,0,0,0,0,0,'Azure Front Channel Stalker - Out of Combat - Cast ''Cosmetic - Crystalsong Tree Beam'' (No Repeat)');

-- Rotting Storm Giant
DELETE FROM `smart_scripts` WHERE `entry` IN (-203373,-203372) AND `source_type`=0;
DELETE FROM `smart_scripts` WHERE `entry` IN (27270) AND `source_type`=0;
INSERT INTO `smart_scripts` (`entry`,`guid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`event_param5`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_param4`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(27270,203372,0,0,1,1,0,100,1,1000,1000,1000,1000,0,11,50389,1,0,0,0,0,1,0,0,0,0,0,0,0,0,'Rotting Storm Giant - Out of Combat - Cast ''Flesh Construct Test'' (No Repeat)'),
(27270,203372,0,1,0,61,0,100,1,0,0,0,0,0,11,50390,1,0,0,0,0,1,0,0,0,0,0,0,0,0,'Rotting Storm Giant - Out of Combat - Cast ''Flesh Construct Test'' (No Repeat)'),
(27270,203372,0,2,3,4,0,100,512,0,0,0,0,0,28,50389,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Rotting Storm Giant - On Aggro - Remove Aura ''Flesh Construct Test'''),
(27270,203372,0,3,0,61,0,100,512,0,0,0,0,0,28,50390,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Rotting Storm Giant - On Aggro - Remove Aura ''Flesh Construct Test'''),
(27270,203373,0,4,1,1,0,100,1,1000,1000,1000,1000,0,11,50389,1,0,0,0,0,1,0,0,0,0,0,0,0,0,'Rotting Storm Giant - Out of Combat - Cast ''Flesh Construct Test'' (No Repeat)'),
(27270,203373,0,5,0,61,0,100,1,0,0,0,0,0,11,50390,1,0,0,0,0,1,0,0,0,0,0,0,0,0,'Rotting Storm Giant - Out of Combat - Cast ''Flesh Construct Test'' (No Repeat)'),
(27270,203373,0,6,3,4,0,100,512,0,0,0,0,0,28,50389,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Rotting Storm Giant - On Aggro - Remove Aura ''Flesh Construct Test'''),
(27270,203373,0,7,0,61,0,100,512,0,0,0,0,0,28,50390,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Rotting Storm Giant - On Aggro - Remove Aura ''Flesh Construct Test''');

-- Sunreaver War Mage
DELETE FROM `smart_scripts` WHERE `entry` IN (-202778,-202777) AND `source_type`=0;
DELETE FROM `smart_scripts` WHERE `entry` IN (36657) AND `source_type`=0;
INSERT INTO `smart_scripts` (`entry`,`guid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`event_param5`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_param4`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(36657,202777,0,0,1,38,0,100,512,50,0,0,0,0,53,1,3665700,0,0,0,0,1,0,0,0,0,0,0,0,0,'Sunreaver War Mage - On Data Set 50 0 - Start Waypoint'),
(36657,202777,0,1,0,61,0,100,512,0,0,0,0,0,22,1,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Sunreaver War Mage - On Data Set 50 0 - Set Event Phase 1'),
(36657,202777,0,2,3,40,1,100,512,1,0,0,0,0,66,0,0,0,0,0,0,19,37846,0,0,0,0,0,0,0,'Sunreaver War Mage - On Waypoint 1 Reached - Set Orientation Closest Creature ''Blood-Queen Lana''thel'' (Phase 1)'),
(36657,202777,0,3,4,61,1,100,512,0,0,0,0,0,17,425,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Sunreaver War Mage - On Waypoint 1 Reached - Set Emote State 425 (Phase 1)'),
(36657,202777,0,4,5,61,1,100,512,0,0,0,0,0,55,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Sunreaver War Mage - On Waypoint 1 Reached - Stop Waypoint (Phase 1)'),
(36657,202777,0,5,0,61,1,100,512,0,0,0,0,0,22,2,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Sunreaver War Mage - On Waypoint 1 Reached - Set Event Phase 2 (Phase 1)'),
(36657,202777,0,6,0,38,0,100,512,51,0,0,0,0,75,71365,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Sunreaver War Mage - On Data Set 51 0 - Add Aura ''Freeze Guards'' (Phase 1)'),
(36657,202777,0,7,8,38,0,100,512,52,0,0,0,0,28,71365,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Sunreaver War Mage - On Data Set 52 0 - Remove Aura ''Freeze Guards'''),
(36657,202777,0,8,0,61,0,100,512,0,0,0,0,0,80,3665600,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Sunreaver War Mage - On Data Set 52 0 - Run Script'),
(36657,202777,0,9,0,38,0,100,512,53,0,0,0,0,53,0,3665700,0,0,0,0,1,0,0,0,0,0,0,0,0,'Sunreaver War Mage - On Data Set 53 0 - Start Waypoint'),
(36657,202777,0,10,11,40,0,100,512,2,0,0,0,0,66,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Sunreaver War Mage - On Waypoint 2 Reached - Set Orientation Home Position'),
(36657,202777,0,11,0,61,0,100,512,0,0,0,0,0,17,26,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Sunreaver War Mage - On Waypoint 2 Reached - Set Emote State 26'),
(36657,202778,0,12,1,38,0,100,512,50,0,0,0,0,53,1,3665701,0,0,0,0,1,0,0,0,0,0,0,0,0,'Sunreaver War Mage - On Data Set 50 0 - Start Waypoint'),
(36657,202778,0,13,0,61,0,100,512,0,0,0,0,0,22,1,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Sunreaver War Mage - On Data Set 50 0 - Set Event Phase 1'),
(36657,202778,0,14,3,40,1,100,512,1,0,0,0,0,66,0,0,0,0,0,0,19,37846,0,0,0,0,0,0,0,'Sunreaver War Mage - On Waypoint 1 Reached - Set Orientation Closest Creature ''Blood-Queen Lana''thel'' (Phase 1)'),
(36657,202778,0,15,4,61,1,100,512,0,0,0,0,0,17,425,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Sunreaver War Mage - On Waypoint 1 Reached - Set Emote State 425 (Phase 1)'),
(36657,202778,0,16,5,61,1,100,512,0,0,0,0,0,55,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Sunreaver War Mage - On Waypoint 1 Reached - Stop Waypoint (Phase 1)'),
(36657,202778,0,17,0,61,1,100,512,0,0,0,0,0,22,2,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Sunreaver War Mage - On Waypoint 1 Reached - Set Event Phase 2 (Phase 1)'),
(36657,202778,0,18,0,38,0,100,512,51,0,0,0,0,75,71365,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Sunreaver War Mage - On Data Set 51 0 - Add Aura ''Freeze Guards'' (Phase 1)'),
(36657,202778,0,19,8,38,0,100,512,52,0,0,0,0,28,71365,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Sunreaver War Mage - On Data Set 52 0 - Remove Aura ''Freeze Guards'''),
(36657,202778,0,20,0,61,0,100,512,0,0,0,0,0,80,3665600,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Sunreaver War Mage - On Data Set 52 0 - Run Script'),
(36657,202778,0,21,0,38,0,100,512,53,0,0,0,0,53,0,3665701,0,0,0,0,1,0,0,0,0,0,0,0,0,'Sunreaver War Mage - On Data Set 53 0 - Start Waypoint'),
(36657,202778,0,22,11,40,0,100,512,2,0,0,0,0,66,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Sunreaver War Mage - On Waypoint 2 Reached - Set Orientation Home Position'),
(36657,202778,0,23,0,61,0,100,512,0,0,0,0,0,17,26,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Sunreaver War Mage - On Waypoint 2 Reached - Set Emote State 26');

-- Silver Covenant Sentinel
DELETE FROM `smart_scripts` WHERE `entry` IN (-202776,-202775) AND `source_type`=0;
DELETE FROM `smart_scripts` WHERE `entry` IN (36656) AND `source_type`=0;
INSERT INTO `smart_scripts` (`entry`,`guid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`event_param5`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_param4`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(36656,202775,0,0,1,38,0,100,512,50,0,0,0,0,53,1,3665601,0,0,0,0,1,0,0,0,0,0,0,0,0,'Silver Covenant Sentinel - On Data Set 50 0 - Start Waypoint'),
(36656,202775,0,1,0,61,0,100,512,0,0,0,0,0,22,1,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Silver Covenant Sentinel - On Data Set 50 0 - Set Event Phase 1'),
(36656,202775,0,2,3,40,1,100,512,1,0,0,0,0,66,0,0,0,0,0,0,19,37846,0,0,0,0,0,0,0,'Silver Covenant Sentinel - On Waypoint 1 Reached - Set Orientation Closest Creature ''Blood-Queen Lana''thel'' (Phase 1)'),
(36656,202775,0,3,4,61,1,100,512,0,0,0,0,0,17,425,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Silver Covenant Sentinel - On Waypoint 1 Reached - Set Emote State 425 (Phase 1)'),
(36656,202775,0,4,5,61,1,100,512,0,0,0,0,0,55,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Silver Covenant Sentinel - On Waypoint 1 Reached - Stop Waypoint (Phase 1)'),
(36656,202775,0,5,0,61,1,100,512,0,0,0,0,0,22,2,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Silver Covenant Sentinel - On Waypoint 1 Reached - Set Event Phase 2 (Phase 1)'),
(36656,202775,0,6,0,38,0,100,512,51,0,0,0,0,75,71365,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Silver Covenant Sentinel - On Data Set 51 0 - Add Aura ''Freeze Guards'' (Phase 1)'),
(36656,202775,0,7,8,38,0,100,512,52,0,0,0,0,28,71365,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Silver Covenant Sentinel - On Data Set 52 0 - Remove Aura ''Freeze Guards'''),
(36656,202775,0,8,0,61,0,100,512,0,0,0,0,0,80,3665600,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Silver Covenant Sentinel - On Data Set 52 0 - Run Script'),
(36656,202775,0,9,0,38,0,100,512,53,0,0,0,0,53,0,3665601,0,0,0,0,1,0,0,0,0,0,0,0,0,'Silver Covenant Sentinel - On Data Set 53 0 - Start Waypoint'),
(36656,202775,0,10,11,40,0,100,512,2,0,0,0,0,66,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Silver Covenant Sentinel - On Waypoint 2 Reached - Set Orientation Home Position'),
(36656,202775,0,11,0,61,0,100,512,0,0,0,0,0,17,26,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Silver Covenant Sentinel - On Waypoint 2 Reached - Set Emote State 26'),
(36656,202776,0,12,0,61,0,100,512,0,0,0,0,0,22,1,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Silver Covenant Sentinel - On Data Set 50 0 - Set Event Phase 1'),
(36656,202776,0,13,3,40,1,100,512,1,0,0,0,0,66,0,0,0,0,0,0,19,37846,0,0,0,0,0,0,0,'Silver Covenant Sentinel - On Waypoint 1 Reached - Set Orientation Closest Creature ''Blood-Queen Lana''thel'' (Phase 1)'),
(36656,202776,0,14,4,61,1,100,512,0,0,0,0,0,17,425,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Silver Covenant Sentinel - On Waypoint 1 Reached - Set Emote State 425 (Phase 1)'),
(36656,202776,0,15,5,61,1,100,512,0,0,0,0,0,55,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Silver Covenant Sentinel - On Waypoint 1 Reached - Stop Waypoint (Phase 1)'),
(36656,202776,0,16,12,61,1,100,512,0,0,0,0,0,22,2,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Silver Covenant Sentinel - On Waypoint 1 Reached - Set Event Phase 2 (Phase 1)'),
(36656,202776,0,17,0,38,0,100,512,51,0,0,0,0,75,71365,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Silver Covenant Sentinel - On Data Set 51 0 - Add Aura ''Freeze Guards'' (Phase 1)'),
(36656,202776,0,18,8,38,0,100,512,52,0,0,0,0,28,71365,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Silver Covenant Sentinel - On Data Set 52 0 - Remove Aura ''Freeze Guards'''),
(36656,202776,0,19,0,61,0,100,512,0,0,0,0,0,80,3665600,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Silver Covenant Sentinel - On Data Set 52 0 - Run Script'),
(36656,202776,0,20,0,38,0,100,512,53,0,0,0,0,53,0,3665600,0,0,0,0,1,0,0,0,0,0,0,0,0,'Silver Covenant Sentinel - On Data Set 53 0 - Start Waypoint'),
(36656,202776,0,21,11,40,0,100,512,2,0,0,0,0,66,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Silver Covenant Sentinel - On Waypoint 2 Reached - Set Orientation Home Position'),
(36656,202776,0,22,0,61,0,100,512,0,0,0,0,0,17,26,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Silver Covenant Sentinel - On Waypoint 2 Reached - Set Emote State 26'),
(36656,202776,0,23,0,61,1,100,512,0,0,0,0,0,1,1,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Silver Covenant Sentinel - On Waypoint 2 Reached - Say Line 1');

-- Directional Rune
DELETE FROM `smart_scripts` WHERE `entry` IN (-202405) AND `source_type`=0;
DELETE FROM `smart_scripts` WHERE `entry` IN (26785) AND `source_type`=0;
INSERT INTO `smart_scripts` (`entry`,`guid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`event_param5`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_param4`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(26785,202405,0,0,0,60,0,100,0,5000,5000,300000,300000,0,12,26923,4,30000,0,0,0,1,0,0,0,0,0,0,0,0,'Directional Rune - On Update OOC - Summon Overseer Brunon');
-- Update condition
UPDATE `conditions` SET `SourceEntry`=26785 WHERE `SourceTypeOrReferenceId`=22 AND `SourceGroup`=1 AND `SourceEntry`=-202405;

-- Rescued Alliance Slave
DELETE FROM `smart_scripts` WHERE `entry` IN (-202288,-202287,-202286,-202285) AND `source_type`=0;
DELETE FROM `smart_scripts` WHERE `entry` IN (36888) AND `source_type`=0;
INSERT INTO `smart_scripts` (`entry`,`guid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`event_param5`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_param4`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(36888,202285,0,0,0,1,0,100,1,0,0,0,0,0,17,4,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Rescued Alliance Slave - update ooc - cheer emote state for self'),
(36888,202285,0,1,0,1,0,100,1,0,0,0,0,0,17,4,0,0,0,0,0,10,202286,36888,0,0,0,0,0,0,'Rescued Alliance Slave - update ooc - cheer emote state for npc2'),
(36888,202285,0,2,0,1,0,100,1,0,0,0,0,0,17,4,0,0,0,0,0,10,202287,36888,0,0,0,0,0,0,'Rescued Alliance Slave - update ooc - cheer emote state for npc3'),
(36888,202285,0,3,0,1,0,100,1,0,0,0,0,0,17,4,0,0,0,0,0,10,202288,36888,0,0,0,0,0,0,'Rescued Alliance Slave - update ooc - cheer emote state for npc4'),
(36888,202285,0,4,0,25,0,100,512,0,0,0,0,0,8,1,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Rescued Alliance Slave - on reset - react defensive'),
(36888,202285,0,5,0,38,0,100,513,1234,1,0,0,0,80,3688800,2,0,0,0,0,1,0,0,0,0,0,0,0,0,'Rescued Alliance Slave - set data - start timed'),
(36888,202286,0,6,0,38,0,100,513,1,1,0,0,0,29,0,240,0,0,0,0,10,202285,36888,0,0,0,0,0,0,'Rescued Alliance Slave - set data - follow'),
(36888,202286,0,7,0,25,0,100,512,0,0,0,0,0,8,1,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Rescued Alliance Slave - on reset - react defensive'),
(36888,202287,0,8,0,38,0,100,513,1,1,0,0,0,29,0,180,0,0,0,0,10,202285,36888,0,0,0,0,0,0,'Rescued Alliance Slave - set data - follow'),
(36888,202287,0,9,0,25,0,100,512,0,0,0,0,0,8,1,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Rescued Alliance Slave - on reset - react defensive'),
(36888,202288,0,10,0,38,0,100,513,1,1,0,0,0,29,0,120,0,0,0,0,10,202285,36888,0,0,0,0,0,0,'Rescued Alliance Slave - set data - follow'),
(36888,202288,0,11,0,25,0,100,512,0,0,0,0,0,8,1,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Rescued Alliance Slave - on reset - react defensive');

-- Rescued Horde Slave
DELETE FROM `smart_scripts` WHERE `entry` IN (-202284,-202283,-202280,-202279) AND `source_type`=0;
DELETE FROM `smart_scripts` WHERE `entry` IN (36889) AND `source_type`=0;
INSERT INTO `smart_scripts` (`entry`,`guid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`event_param5`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_param4`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(36889,202279,0,0,0,1,0,100,1,0,0,0,0,0,17,4,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Rescued Horde Slave - update ooc - cheer emote state for self'),
(36889,202279,0,1,0,1,0,100,1,0,0,0,0,0,17,4,0,0,0,0,0,10,202280,36889,0,0,0,0,0,0,'Rescued Horde Slave - update ooc - cheer emote state for npc2'),
(36889,202279,0,2,0,1,0,100,1,0,0,0,0,0,17,4,0,0,0,0,0,10,202283,36889,0,0,0,0,0,0,'Rescued Horde Slave - update ooc - cheer emote state for npc3'),
(36889,202279,0,3,0,1,0,100,1,0,0,0,0,0,17,4,0,0,0,0,0,10,202284,36889,0,0,0,0,0,0,'Rescued Horde Slave - update ooc - cheer emote state for npc4'),
(36889,202279,0,4,0,25,0,100,512,0,0,0,0,0,8,1,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Rescued Horde Slave - on reset - react defensive'),
(36889,202279,0,5,0,38,0,100,513,1234,1,0,0,0,80,3688900,2,0,0,0,0,1,0,0,0,0,0,0,0,0,'Rescued Horde Slave - set data - start timed'),
(36889,202280,0,6,0,38,0,100,513,1,1,0,0,0,29,0,240,0,0,0,0,10,202279,36889,0,0,0,0,0,0,'Rescued Horde Slave - set data - follow'),
(36889,202280,0,7,0,25,0,100,512,0,0,0,0,0,8,1,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Rescued Horde Slave - on reset - react defensive'),
(36889,202283,0,8,0,38,0,100,513,1,1,0,0,0,29,0,180,0,0,0,0,10,202279,36889,0,0,0,0,0,0,'set data - follow'),
(36889,202283,0,9,0,25,0,100,512,0,0,0,0,0,8,1,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Rescued Horde Slave - on reset - react defensive'),
(36889,202284,0,10,0,38,0,100,513,1,1,0,0,0,29,0,120,0,0,0,0,10,202279,36889,0,0,0,0,0,0,'set data - follow'),
(36889,202284,0,11,0,25,0,100,512,0,0,0,0,0,8,1,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Rescued Horde Slave - on reset - react defensive');

-- Wrathbone Laborer (34 more lines)
DELETE FROM `smart_scripts` WHERE `entry` IN (-201800) AND `source_type`=0;
DELETE FROM `smart_scripts` WHERE `entry` IN (36830) AND `source_type`=0;
INSERT INTO `smart_scripts` (`entry`,`guid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`event_param5`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_param4`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(36830,0,0,0,0,0,0,100,0,5000,7000,10000,15000,0,11,70302,0,0,0,0,0,6,0,0,0,0,0,0,0,0,'Wrathbone Laborer - In Combat - Cast ''Blinding Dirt'''),
(36830,0,0,1,0,0,0,100,0,3000,4000,7000,9000,0,11,70278,0,0,0,0,0,2,0,0,0,0,0,0,0,0,'Wrathbone Laborer - In Combat - Cast ''Puncture Wound'''),
(36830,0,0,2,0,0,0,100,0,8000,9000,8000,9000,0,11,69572,0,0,0,0,0,2,0,0,0,0,0,0,0,0,'Wrathbone Laborer - In Combat - Cast ''Shovelled!'''),
(36830,201817,0,3,0,25,0,100,0,0,0,0,0,0,17,38,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Wrathbone Laborer - reset - add emote state'),
(36830,201817,0,4,0,4,0,100,0,0,0,0,0,0,17,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Wrathbone Laborer - combat - remove emote state'),
(36830,201865,0,5,0,25,0,100,0,0,0,0,0,0,17,38,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Wrathbone Laborer - reset - add emote state'),
(36830,201865,0,6,0,4,0,100,0,0,0,0,0,0,17,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Wrathbone Laborer - combat - remove emote state'),
(36830,201897,0,7,0,25,0,100,0,0,0,0,0,0,17,38,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Wrathbone Laborer - reset - add emote state'),
(36830,201897,0,8,0,4,0,100,0,0,0,0,0,0,17,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Wrathbone Laborer - combat - remove emote state'),
(36830,201901,0,9,0,25,0,100,0,0,0,0,0,0,17,38,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Wrathbone Laborer - reset - add emote state'),
(36830,201901,0,10,0,4,0,100,0,0,0,0,0,0,17,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Wrathbone Laborer - combat - remove emote state'),
(36830,201947,0,11,0,25,0,100,0,0,0,0,0,0,17,38,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Wrathbone Laborer - reset - add emote state'),
(36830,201947,0,12,0,4,0,100,0,0,0,0,0,0,17,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Wrathbone Laborer - combat - remove emote state'),
(36830,201952,0,13,0,25,0,100,0,0,0,0,0,0,17,38,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Wrathbone Laborer - reset - add emote state'),
(36830,201952,0,14,0,4,0,100,0,0,0,0,0,0,17,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Wrathbone Laborer - combat - remove emote state'),
(36830,201985,0,15,0,25,0,100,0,0,0,0,0,0,17,38,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Wrathbone Laborer - reset - add emote state'),
(36830,201985,0,16,0,4,0,100,0,0,0,0,0,0,17,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Wrathbone Laborer - combat - remove emote state'),
(36830,201994,0,17,0,25,0,100,0,0,0,0,0,0,17,38,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Wrathbone Laborer - reset - add emote state'),
(36830,201994,0,18,0,4,0,100,0,0,0,0,0,0,17,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Wrathbone Laborer - combat - remove emote state'),
(36830,202013,0,19,0,25,0,100,0,0,0,0,0,0,17,38,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Wrathbone Laborer - reset - add emote state'),
(36830,202013,0,20,0,4,0,100,0,0,0,0,0,0,17,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Wrathbone Laborer - combat - remove emote state'),
(36830,202032,0,21,0,25,0,100,0,0,0,0,0,0,17,38,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Wrathbone Laborer - reset - add emote state'),
(36830,202032,0,22,0,4,0,100,0,0,0,0,0,0,17,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Wrathbone Laborer - combat - remove emote state'),
(36830,202059,0,23,0,25,0,100,0,0,0,0,0,0,17,38,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Wrathbone Laborer - reset - add emote state'),
(36830,202059,0,24,0,4,0,100,0,0,0,0,0,0,17,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Wrathbone Laborer - combat - remove emote state'),
(36830,202097,0,25,0,25,0,100,0,0,0,0,0,0,17,38,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Wrathbone Laborer - reset - add emote state'),
(36830,202097,0,26,0,4,0,100,0,0,0,0,0,0,17,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Wrathbone Laborer - combat - remove emote state'),
(36830,202119,0,27,0,25,0,100,0,0,0,0,0,0,17,38,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Wrathbone Laborer - reset - add emote state'),
(36830,202119,0,28,0,4,0,100,0,0,0,0,0,0,17,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Wrathbone Laborer - combat - remove emote state');

-- Soulguard Bonecaster (1 more line)
DELETE FROM `smart_scripts` WHERE `entry` IN (-201686) AND `source_type`=0;
DELETE FROM `smart_scripts` WHERE `entry` IN (36564) AND `source_type`=0;
INSERT INTO `smart_scripts` (`entry`,`guid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`event_param5`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_param4`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(36564,0,0,0,0,0,0,100,0,4000,8000,7000,9000,0,11,69080,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Soulguard Bonecaster- In Combat - Cast ''Bone Volley'''),
(36564,0,0,1,0,0,0,100,0,3000,5000,15000,16000,0,11,69069,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Soulguard Bonecaster- In Combat - Cast ''Shield of Bones'''),
(36564,201686,0,2,0,1,0,100,1,1000,1000,0,0,0,11,68797,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Soulguard Bonecaster- OOC - Cast ''Soulguard Channel'''),
(36564,201678,0,3,0,1,0,100,1,1000,1000,0,0,0,11,68834,0,0,0,0,0,19,36522,25,0,0,0,0,0,0,'Soulguard Bonecaster- OOC - Cast ''Soulguard Channel Beam02'''),
(36564,201688,0,4,0,1,0,100,1,1000,1000,0,0,0,11,68834,0,0,0,0,0,19,36522,25,0,0,0,0,0,0,'Soulguard Bonecaster- OOC - Cast ''Soulguard Channel Beam02'''),
(36564,201712,0,5,0,1,0,100,1,1000,1000,0,0,0,11,68834,0,0,0,0,0,19,36522,25,0,0,0,0,0,0,'Soulguard Bonecaster- OOC - Cast ''Soulguard Channel Beam02'''),
(36564,201783,0,6,0,1,0,100,1,1000,1000,0,0,0,11,68834,0,0,0,0,0,19,36522,25,0,0,0,0,0,0,'Soulguard Bonecaster- OOC - Cast ''Soulguard Channel Beam02''');

-- Darkfallen Noble <The San'layn> (3 less lines)
DELETE FROM `smart_scripts` WHERE `entry` IN (-201659) AND `source_type`=0;
DELETE FROM `smart_scripts` WHERE `entry` IN (37663) AND `source_type`=0;
INSERT INTO `smart_scripts` (`entry`,`guid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`event_param5`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_param4`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(37663,0,0,0,0,0,0,100,0,3000,5000,5000,5000,0,11,72960,0,0,0,0,0,2,0,0,0,0,0,0,0,0,'Darkfallen Noble - Combat - Cast ''Shadow Bolt'''),
(37663,0,0,1,0,0,0,100,0,10000,15000,15000,15000,0,11,70645,0,0,0,0,0,6,0,0,0,0,0,0,0,0,'Darkfallen Noble - Combat - Cast ''Chains of Shadow'''),
(37663,0,0,2,0,4,0,100,0,0,0,0,0,0,39,19,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Darkfallen Noble - On Aggro - Call for help'),
(37663,201659,0,3,0,6,0,100,512,0,0,0,0,0,34,300,1,0,0,0,0,1,0,0,0,0,0,0,0,0,'Darkfallen Noble - On Death - SET INSTANCE DATA 300 TO 1');

-- Darkfallen Blood Knight <The San'layn> (3 less lines)
DELETE FROM `smart_scripts` WHERE `entry` IN (-201646) AND `source_type`=0;
DELETE FROM `smart_scripts` WHERE `entry` IN (37595) AND `source_type`=0;
INSERT INTO `smart_scripts` (`entry`,`guid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`event_param5`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_param4`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(37595,0,0,0,0,0,0,100,0,3000,5000,5000,5000,0,11,70437,0,0,0,0,0,2,0,0,0,0,0,0,0,0,'Darkfallen Blood Knight - Combat - Cast ''Unholy Strike'''),
(37595,0,0,1,0,0,0,100,0,0,0,20000,20000,0,11,71736,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Darkfallen Blood Knight - Combat - Cast ''Vampiric Aura'''),
(37595,0,0,3,0,4,0,100,0,0,0,0,0,0,39,19,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Darkfallen Blood Knight - On Aggro - Call for help'),
(37595,201646,0,4,0,6,0,100,512,0,0,0,0,0,34,300,1,0,0,0,0,1,0,0,0,0,0,0,0,0,'Darkfallen Blood Knight - On Death - SET INSTANCE DATA 300 TO 1');

-- Darkfallen Archmage <The San'layn> (3 less lines)
DELETE FROM `smart_scripts` WHERE `entry` IN (-201482) AND `source_type`=0;
DELETE FROM `smart_scripts` WHERE `entry` IN (37664) AND `source_type`=0;
INSERT INTO `smart_scripts` (`entry`,`guid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`event_param5`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_param4`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(37664,0,0,0,0,0,0,100,0,8000,10000,15000,20000,0,11,70408,0,0,0,0,0,2,0,0,0,0,0,0,0,0,'Darkfallen Archmage - Combat - Cast ''Amplify Magic'''),
(37664,0,0,1,0,0,0,100,0,6000,8000,12000,15000,0,11,70407,0,0,0,0,0,2,0,0,0,0,0,0,0,0,'Darkfallen Archmage - Combat - Cast ''Blast Wave'''),
(37664,0,0,2,0,0,0,100,0,2000,4000,8000,10000,0,11,70409,0,0,0,0,0,2,0,0,0,0,0,0,0,0,'Darkfallen Archmage - Combat - Cast ''Fireball'''),
(37664,0,0,3,0,0,0,100,0,6000,10000,16000,20000,0,11,70410,0,0,0,0,0,17,14,29,1,0,0,0,0,0,'Darkfallen Archmage - Combat - Cast ''Polymorph'''),
(37664,0,0,4,5,4,0,100,0,0,0,0,0,0,39,19,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Darkfallen Archmage - On Aggro - Call for help'),
(37664,0,0,5,0,61,0,100,0,0,0,0,0,0,11,70299,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Darkfallen Archmage - On Aggro - Cast Siphon Essence'),
(37664,201482,0,6,7,6,0,100,512,0,0,0,0,0,104,0,0,0,0,0,0,20,201741,40,0,0,0,0,0,0,'Darkfallen Archmage - ON Death - SET GO Flags'),
(37664,201482,0,7,0,61,0,100,512,0,0,0,0,0,34,300,1,0,0,0,0,1,0,0,0,0,0,0,0,0,'Darkfallen Archmage - ON Death - SET INSTANCE DATA 300 TO 1'),
(37664,201335,0,8,0,6,0,100,512,0,0,0,0,0,104,0,0,0,0,0,0,20,201741,40,0,0,0,0,0,0,'Darkfallen Archmage - On Death - Set GO Flags'),
(37664,201385,0,9,0,6,0,100,512,0,0,0,0,0,104,0,0,0,0,0,0,20,201741,40,0,0,0,0,0,0,'Darkfallen Archmage - ON Death - SET GO Flags'),
(37664,201595,0,10,0,6,0,100,512,0,0,0,0,0,104,0,0,0,0,0,0,20,201741,40,0,0,0,0,0,0,'Darkfallen Archmage - ON Death - SET GO Flags'),
(37664,201630,0,11,0,6,0,100,512,0,0,0,0,0,104,0,0,0,0,0,0,20,201741,40,0,0,0,0,0,0,'Darkfallen Archmage - ON Death - SET GO Flags');

-- The Damned (19 more lines)
DELETE FROM `smart_scripts` WHERE `entry` IN (-200966) AND `source_type`=0;
DELETE FROM `smart_scripts` WHERE `entry` IN (37011) AND `source_type`=0;
INSERT INTO `smart_scripts` (`entry`,`guid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`event_param5`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_param4`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(37011,0,0,0,0,2,0,100,0,1,30,15000,20000,0,11,70960,0,0,0,0,0,2,0,0,0,0,0,0,0,0,'The Damned - Health 30% - Cast ''Bone Flurry'''),
(37011,0,0,1,0,4,0,100,0,0,0,0,0,0,39,15,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'The Damned - On aggro - call for help'),
(37011,0,0,2,0,1,0,100,0,1000,1000,60000,60000,0,49,0,0,0,0,0,0,25,8,0,0,0,0,0,0,0,'The Damned - OCC - aggro'),
(37011,200966,0,3,4,6,0,100,513,0,0,0,0,0,11,70961,3,0,0,0,0,1,0,0,0,0,0,0,0,0,'The Damned - On Death - Cast ''Shattered Bones'''),
(37011,200966,0,4,0,61,0,100,513,0,0,0,0,0,45,1,1,0,0,0,0,10,201466,0,0,0,0,0,0,0,'The Damned - On Death - SetData on Tirion Fordring'),
(37011,200883,0,5,0,6,0,100,513,0,0,0,0,0,11,70961,3,0,0,0,0,1,0,0,0,0,0,0,0,0,'The Damned - On Death - Cast ''Shattered Bones'''),
(37011,200913,0,6,0,6,0,100,513,0,0,0,0,0,11,70961,3,0,0,0,0,1,0,0,0,0,0,0,0,0,'The Damned - On Death - Cast ''Shattered Bones'''),
(37011,200919,0,7,0,6,0,100,513,0,0,0,0,0,11,70961,3,0,0,0,0,1,0,0,0,0,0,0,0,0,'The Damned - On Death - Cast ''Shattered Bones'''),
(37011,200969,0,8,0,6,0,100,513,0,0,0,0,0,11,70961,3,0,0,0,0,1,0,0,0,0,0,0,0,0,'The Damned - On Death - Cast ''Shattered Bones'''),
(37011,201029,0,9,0,6,0,100,513,0,0,0,0,0,11,70961,3,0,0,0,0,1,0,0,0,0,0,0,0,0,'The Damned - On Death - Cast ''Shattered Bones'''),
(37011,201036,0,10,0,6,0,100,513,0,0,0,0,0,11,70961,3,0,0,0,0,1,0,0,0,0,0,0,0,0,'The Damned - On Death - Cast ''Shattered Bones'''),
(37011,201037,0,11,0,6,0,100,513,0,0,0,0,0,11,70961,3,0,0,0,0,1,0,0,0,0,0,0,0,0,'The Damned - On Death - Cast ''Shattered Bones'''),
(37011,201065,0,12,0,6,0,100,513,0,0,0,0,0,11,70961,3,0,0,0,0,1,0,0,0,0,0,0,0,0,'The Damned - On Death - Cast ''Shattered Bones'''),
(37011,201066,0,13,0,6,0,100,513,0,0,0,0,0,11,70961,3,0,0,0,0,1,0,0,0,0,0,0,0,0,'The Damned - On Death - Cast ''Shattered Bones'''),
(37011,201087,0,14,0,6,0,100,513,0,0,0,0,0,11,70961,3,0,0,0,0,1,0,0,0,0,0,0,0,0,'The Damned - On Death - Cast ''Shattered Bones'''),
(37011,201093,0,15,0,6,0,100,513,0,0,0,0,0,11,70961,3,0,0,0,0,1,0,0,0,0,0,0,0,0,'The Damned - On Death - Cast ''Shattered Bones'''),
(37011,201107,0,16,0,6,0,100,513,0,0,0,0,0,11,70961,3,0,0,0,0,1,0,0,0,0,0,0,0,0,'The Damned - On Death - Cast ''Shattered Bones'''),
(37011,201124,0,17,0,6,0,100,513,0,0,0,0,0,11,70961,3,0,0,0,0,1,0,0,0,0,0,0,0,0,'The Damned - On Death - Cast ''Shattered Bones'''),
(37011,201145,0,18,0,6,0,100,513,0,0,0,0,0,11,70961,3,0,0,0,0,1,0,0,0,0,0,0,0,0,'The Damned - On Death - Cast ''Shattered Bones'''),
(37011,201146,0,19,0,6,0,100,513,0,0,0,0,0,11,70961,3,0,0,0,0,1,0,0,0,0,0,0,0,0,'The Damned - On Death - Cast ''Shattered Bones'''),
(37011,201177,0,20,0,6,0,100,513,0,0,0,0,0,11,70961,3,0,0,0,0,1,0,0,0,0,0,0,0,0,'The Damned - On Death - Cast ''Shattered Bones'''),
(37011,201186,0,21,0,6,0,100,513,0,0,0,0,0,11,70961,3,0,0,0,0,1,0,0,0,0,0,0,0,0,'The Damned - On Death - Cast ''Shattered Bones'''),
(37011,247110,0,22,0,6,0,100,513,0,0,0,0,0,11,70961,3,0,0,0,0,1,0,0,0,0,0,0,0,0,'The Damned - On Death - Cast ''Shattered Bones'''),
(37011,247111,0,23,0,6,0,100,513,0,0,0,0,0,11,70961,3,0,0,0,0,1,0,0,0,0,0,0,0,0,'The Damned - On Death - Cast ''Shattered Bones'''),
(37011,247112,0,24,0,6,0,100,513,0,0,0,0,0,11,70961,3,0,0,0,0,1,0,0,0,0,0,0,0,0,'The Damned - On Death - Cast ''Shattered Bones'''),
(37011,247113,0,25,0,6,0,100,513,0,0,0,0,0,11,70961,3,0,0,0,0,1,0,0,0,0,0,0,0,0,'The Damned - On Death - Cast ''Shattered Bones'''),
(37011,247114,0,26,0,6,0,100,513,0,0,0,0,0,11,70961,3,0,0,0,0,1,0,0,0,0,0,0,0,0,'The Damned - On Death - Cast ''Shattered Bones'''),
(37011,247115,0,27,0,6,0,100,513,0,0,0,0,0,11,70961,3,0,0,0,0,1,0,0,0,0,0,0,0,0,'The Damned - On Death - Cast ''Shattered Bones''');

-- Sunblade Protector (6 less lines)
DELETE FROM `smart_scripts` WHERE `entry` IN (-45537,-45570,-45571) AND `source_type`=0;
DELETE FROM `smart_scripts` WHERE `entry` IN (25507) AND `source_type`=0;
INSERT INTO `smart_scripts` (`entry`,`guid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`event_param5`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_param4`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(25507,0,0,0,0,11,0,100,0,0,0,0,0,0,11,18950,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Sunblade Protector - On Respawn - Cast Invisibility and Stealth Detection'),
(25507,0,0,1,0,0,0,100,0,5800,6800,10400,11400,0,11,46480,0,0,0,0,0,2,0,0,0,0,0,0,0,0,'Sunblade Protector - In Combat - Cast Fel Lightning'),
(25507,45537,0,2,3,25,0,100,769,0,0,0,0,0,11,59123,2,0,0,0,0,1,0,0,0,0,0,0,0,0,'Sunblade Protector - On Reset - Cast Banish'),
(25507,45537,0,3,4,61,0,100,512,0,0,0,0,0,18,33554432,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Sunblade Protector - On Reset - Add Unit Flag'),
(25507,45537,0,4,0,61,0,100,512,0,0,0,0,0,8,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Sunblade Protector - On Reset - Set React State'),
(25507,45537,0,5,6,8,0,100,512,46476,0,0,0,0,8,2,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Sunblade Protector - On Spell Hit - Set React State'),
(25507,45537,0,6,7,61,0,100,512,0,0,0,0,0,28,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Sunblade Protector - On Spell Hit - Remove All Auras'),
(25507,45537,0,7,8,61,0,100,512,0,0,0,0,0,38,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Sunblade Protector - On Spell Hit - Set In Combat With Zone'),
(25507,45537,0,8,0,61,0,100,512,0,0,0,0,0,19,33554432,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Sunblade Protector - On Spell Hit - Remove Unit Flag'),
(25507,45570,0,9,10,25,0,100,769,0,0,0,0,0,11,59123,2,0,0,0,0,1,0,0,0,0,0,0,0,0,'Sunblade Protector - On Reset - Cast Banish'),
(25507,45570,0,10,11,61,0,100,512,0,0,0,0,0,18,33554432,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Sunblade Protector - On Reset - Add Unit Flag'),
(25507,45570,0,11,0,61,0,100,512,0,0,0,0,0,8,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Sunblade Protector - On Reset - Set React State'),
(25507,45570,0,12,13,8,0,100,512,46476,0,0,0,0,8,2,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Sunblade Protector - On Spell Hit - Set React State'),
(25507,45570,0,13,14,61,0,100,512,0,0,0,0,0,28,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Sunblade Protector - On Spell Hit - Remove All Auras'),
(25507,45570,0,14,15,61,0,100,512,0,0,0,0,0,38,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Sunblade Protector - On Spell Hit - Set In Combat With Zone'),
(25507,45570,0,15,0,61,0,100,512,0,0,0,0,0,19,33554432,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Sunblade Protector - On Spell Hit - Remove Unit Flag'),
(25507,45571,0,16,17,25,0,100,769,0,0,0,0,0,11,59123,2,0,0,0,0,1,0,0,0,0,0,0,0,0,'Sunblade Protector - On Reset - Cast Banish'),
(25507,45571,0,17,18,61,0,100,512,0,0,0,0,0,18,33554432,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Sunblade Protector - On Reset - Add Unit Flag'),
(25507,45571,0,18,0,61,0,100,512,0,0,0,0,0,8,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Sunblade Protector - On Reset - Set React State'),
(25507,45571,0,19,20,8,0,100,512,46476,0,0,0,0,8,2,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Sunblade Protector - On Spell Hit - Set React State'),
(25507,45571,0,20,21,61,0,100,512,0,0,0,0,0,28,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Sunblade Protector - On Spell Hit - Remove All Auras'),
(25507,45571,0,21,22,61,0,100,512,0,0,0,0,0,38,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Sunblade Protector - On Spell Hit - Set In Combat With Zone'),
(25507,45571,0,22,0,61,0,100,512,0,0,0,0,0,19,33554432,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Sunblade Protector - On Spell Hit - Remove Unit Flag');

-- Shadowsword Assassin (6 less lines)
DELETE FROM `smart_scripts` WHERE `entry` IN (-44268) AND `source_type`=0;
DELETE FROM `smart_scripts` WHERE `entry` IN (25484) AND `source_type`=0;
INSERT INTO `smart_scripts` (`entry`,`guid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`event_param5`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_param4`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(25484,0,0,0,0,1,0,100,1,500,500,0,0,0,11,16380,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Shadowsword Assassin - Out of Combat - Cast ''Greater Invisbility'''),
(25484,0,0,1,0,1,0,100,0,2000,2000,2000,2000,0,49,0,0,0,0,0,0,21,15,0,0,0,0,0,0,0,'Shadowsword Assassin - Out of Combat - Attack Start'),
(25484,0,0,2,3,0,0,100,0,12000,15000,24000,28000,0,11,46463,0,0,0,0,0,5,30,0,0,0,0,0,0,0,'Shadowsword Assassin - In Combat - Cast ''Shadowstep'''),
(25484,0,0,3,0,61,0,100,512,0,0,0,0,0,14,0,100,0,0,0,0,1,0,0,0,0,0,0,0,0,'Shadowsword Assassin - In Combat - Reset All Threat'),
(25484,0,0,4,0,9,0,100,0,10,35,5000,5000,0,11,46460,0,0,0,0,0,2,0,0,0,0,0,0,0,0,'Shadowsword Assassin - Within Range 10-35yd - Cast ''Aimed Shot'''),
(25484,0,0,5,0,4,0,100,0,0,0,0,0,0,11,46459,0,0,0,0,0,7,0,0,0,0,0,0,0,0,'Shadowsword Assassin - On Aggro - Cast ''Assassins Mark'''),
(25484,44268,0,6,0,4,0,100,769,0,0,0,0,0,80,2548400,2,0,0,0,0,1,0,0,0,0,0,0,0,0,'Shadowsword Assassin - On Aggro - Run Script'),
(25484,44268,0,7,0,17,0,100,512,0,0,0,0,0,64,1,0,0,0,0,0,7,0,0,0,0,0,0,0,0,'Shadowsword Assassin - Summoned Unit - Store Target');

-- Plaguebone Pillager (2 less lines)
DELETE FROM `smart_scripts` WHERE `entry` IN (-43457,-43458) AND `source_type`=0;
DELETE FROM `smart_scripts` WHERE `entry` IN (15654) AND `source_type`=0;
INSERT INTO `smart_scripts` (`entry`,`guid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`event_param5`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_param4`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(15654,0,0,0,0,0,0,100,0,5900,12200,11900,22100,0,11,11976,0,0,0,0,0,2,0,0,0,0,0,0,0,0,'Plaguebone Pillager - In Combat - Cast ''Strike'''),
(15654,43457,0,1,2,11,0,100,0,0,0,0,0,0,47,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Plaguebone Pillager - On Spawn - Set Invisible'),
(15654,43457,0,2,0,61,0,100,0,0,0,0,0,0,8,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Plaguebone Pillager - On Spawn - Set ReactState Passive'),
(15654,43457,0,3,4,38,0,100,0,1,1,0,0,0,47,1,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Plaguebone Pillager - On Data 1 1 Set - Set Visible'),
(15654,43457,0,4,0,61,0,100,0,0,0,0,0,0,53,0,1565501,0,0,120000,2,1,0,0,0,0,0,0,0,0,'Plaguebone Pillager - On Data 1 1 Set - Start Waypoint'),
(15654,43457,0,5,0,40,0,100,0,1,0,0,0,0,1,0,0,0,0,0,0,19,15942,0,0,0,0,0,0,0,'Plaguebone Pillager - On Waypoint 1 Reached - Say Line 0 (Ranger Sareyn)'),
(15654,43458,0,6,2,11,0,100,0,0,0,0,0,0,47,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Plaguebone Pillager - On Spawn - Set Invisible'),
(15654,43458,0,7,0,61,0,100,0,0,0,0,0,0,8,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Plaguebone Pillager - On Spawn - Set ReactState Passive'),
(15654,43458,0,8,4,38,0,100,0,1,1,0,0,0,47,1,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Plaguebone Pillager - On Data 1 1 Set - Set Visible'),
(15654,43458,0,9,0,61,0,100,0,0,0,0,0,0,53,0,1565501,0,0,120000,2,1,0,0,0,0,0,0,0,0,'Plaguebone Pillager - On Data 1 1 Set - Start Waypoint');

-- Rotlimb Cannibal
DELETE FROM `smart_scripts` WHERE `entry` IN (-43456) AND `source_type`=0;
DELETE FROM `smart_scripts` WHERE `entry` IN (15655) AND `source_type`=0;
INSERT INTO `smart_scripts` (`entry`,`guid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`event_param5`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_param4`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(15655,43456,0,0,1,11,0,100,0,0,0,0,0,0,47,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Rotlimb Cannibal - On Spawn - Set Invisible'),
(15655,43456,0,1,0,61,0,100,0,0,0,0,0,0,8,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Rotlimb Cannibal - On Spawn - Set ReactState Passive'),
(15655,43456,0,2,3,38,0,100,0,1,1,0,0,0,47,1,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Rotlimb Cannibal - On Data 1 1 Set - Set Visible'),
(15655,43456,0,3,4,61,0,100,0,0,0,0,0,0,53,0,1565501,0,0,120000,2,1,0,0,0,0,0,0,0,0,'Rotlimb Cannibal - On Data 1 1 Set - Start Waypoint'),
(15655,43456,0,4,5,61,0,100,0,0,0,0,0,0,45,1,1,0,0,0,0,10,43457,15654,0,0,0,0,0,0,'Rotlimb Cannibal - On Data 1 1 Set - Set Data 1 1 (Plaguebone Villager)'),
(15655,43456,0,5,0,61,0,100,0,0,0,0,0,0,45,1,1,0,0,0,0,10,43458,15654,0,0,0,0,0,0,'Rotlimb Cannibal - On Data 1 1 Set - Set Data 1 1 (Plaguebone Villager)');

-- Surge Needle Sorcerer (2 less lines)
DELETE FROM `smart_scripts` WHERE `entry` IN (-42875,-42876) AND `source_type`=0;
DELETE FROM `smart_scripts` WHERE `entry` IN (26257) AND `source_type`=0;
INSERT INTO `smart_scripts` (`entry`,`guid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`event_param5`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_param4`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(26257,0,0,1,0,0,0,100,0,3000,4000,3000,5000,0,11,51797,0,0,0,0,0,2,0,0,0,0,0,0,0,0,'Surge Needle Sorcerer - In Combat - Cast ''Arcane Blast'''),
(26257,42875,0,2,0,1,0,100,513,1000,1000,30000,30000,0,11,46906,2,0,0,0,0,10,115101,27853,0,0,0,0,0,0,'Surge Needle Sorcerer - Out of Combat - Cast ''Surge Needle Beam'''),
(26257,42876,0,3,0,1,0,100,513,1000,1000,30000,30000,0,11,46906,2,0,0,0,0,10,115101,27853,0,0,0,0,0,0,'Surge Needle Sorcerer - Out of Combat - Cast ''Surge Needle Beam''');

-- Atal'ai Priest (2 less lines)
DELETE FROM `smart_scripts` WHERE `entry` IN (-39745) AND `source_type`=0;
DELETE FROM `smart_scripts` WHERE `entry` IN (5269) AND `source_type`=0;
INSERT INTO `smart_scripts` (`entry`,`guid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`event_param5`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_param4`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(5269,0,0,0,0,14,0,100,0,1000,40,4000,6000,0,11,11642,0,0,0,0,0,7,0,0,0,0,0,0,0,0,'Atal''ai Priest - Friendly Missing Health - Cast ''Heal'''),
(5269,0,0,1,0,0,0,100,0,0,3000,3000,5000,0,11,9613,64,0,0,0,0,2,0,0,0,0,0,0,0,0,'Atal''ai Priest - In Combat - Cast ''Shadow Bolt'''),
(5269,39745,0,2,0,1,0,100,512,5000,5000,5000,5000,0,19,256,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Atal''ai Priest - Out of Combat - Remove Unit Flags');

-- Theramore Sentry
DELETE FROM `smart_scripts` WHERE `entry` IN (-31268,-31271) AND `source_type`=0;
DELETE FROM `smart_scripts` WHERE `entry` IN (5184) AND `source_type`=0;
INSERT INTO `smart_scripts` (`entry`,`guid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`event_param5`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_param4`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(5184,0,0,0,0,4,0,100,0,0,0,0,0,0,11,7165,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Theramore Sentry - On Aggro - Cast ''Battle Stance'''),
(5184,0,0,1,0,38,0,100,513,3,3,1,2,0,41,60000,1,0,0,0,0,1,0,0,0,0,0,0,0,0,'Theramore Sentry - On Data Set 3 3 - Despawn In 60000 ms (No Repeat)'),
(5184,31268,0,2,0,38,0,100,513,1,1,0,0,0,2,168,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Theramore Sentry - On Data Set - Set Faction 168'),
(5184,31268,0,3,0,38,0,100,1,1,1,0,0,0,49,0,0,0,0,0,0,21,50,0,0,0,0,0,0,0,'Theramore Sentry - On Data Set - Start Attacking'),
(5184,31268,0,4,0,38,0,100,513,2,2,0,0,0,80,518401,2,0,0,0,0,1,0,0,0,0,0,0,0,0,'Theramore Sentry - On Data 2 Set - Run Script'),
(5184,31268,0,5,0,40,0,100,512,3,518401,0,0,0,41,1000,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Theramore Sentry - On Waypoint 3 Reached - Despawn'),
(5184,31271,0,6,0,38,0,100,513,1,1,0,0,0,2,168,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Theramore Sentry - On Data 1 Set - Set Faction 168'),
(5184,31271,0,7,0,38,0,100,1,1,1,0,0,0,49,0,0,0,0,0,0,21,50,0,0,0,0,0,0,0,'Theramore Sentry - On Data 1 Set - Start Attacking'),
(5184,31271,0,8,0,38,0,100,513,2,2,0,0,0,80,518400,2,0,0,0,0,1,0,0,0,0,0,0,0,0,'Theramore Sentry - On Data 2 Set - Run Script'),
(5184,31271,0,9,0,40,0,100,512,2,518400,0,0,0,41,1000,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Theramore Sentry - On Waypoint 2 Reached - Despawn');

-- Kil'sorrow Cultist (4 less lines)
DELETE FROM `smart_scripts` WHERE `entry` IN (-28654,-28655,-28656,-28657) AND `source_type`=0;
DELETE FROM `smart_scripts` WHERE `entry` IN (17147) AND `source_type`=0;
INSERT INTO `smart_scripts` (`entry`,`guid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`event_param5`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_param4`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(17147,0,0,0,0,0,0,85,0,4500,4500,7000,11000,0,11,32000,0,0,0,0,0,2,0,0,0,0,0,0,0,0,'Kil''sorrow Cultist - In Combat - Cast ''Mind Sear'''),
(17147,28654,0,1,0,1,0,100,1,1000,1000,1000,1000,0,11,31902,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Kil''sorrow Cultist - Reset - Cast ''Purple Beam'''),
(17147,28655,0,2,0,1,0,100,1,1000,1000,1000,1000,0,11,31902,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Kil''sorrow Cultist - Reset - Cast ''Purple Beam'''),
(17147,28656,0,3,0,1,0,100,1,1000,1000,1000,1000,0,11,31902,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Kil''sorrow Cultist - Reset - Cast ''Purple Beam'''),
(17147,28657,0,4,0,1,0,100,1,1000,1000,1000,1000,0,11,31902,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Kil''sorrow Cultist - Reset - Cast ''Purple Beam''');

-- Stone Keeper (21 less lines)
DELETE FROM `smart_scripts` WHERE `entry` IN (-27554,-27555,-27794,-28368) AND `source_type`=0;
DELETE FROM `smart_scripts` WHERE `entry` IN (4857) AND `source_type`=0;
INSERT INTO `smart_scripts` (`entry`,`guid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`event_param5`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_param4`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(4857,0,0,0,0,21,0,100,512,0,0,0,0,0,70,0,0,0,0,0,0,11,4857,100,0,0,0,0,0,0,'Stone Keeper - Just Reached Home - Respawn'),
(4857,0,0,1,0,25,0,100,0,0,0,0,0,0,11,10255,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Stone Keeper - On Reset - Cast Stoned'),
(4857,0,0,2,0,0,0,100,0,3000,7000,7000,11000,0,11,5568,0,0,0,0,0,2,0,0,0,0,0,0,0,0,'Stone Keeper - In Combat - Cast Trample'),
(4857,0,0,3,4,38,0,100,512,1,1,0,0,0,28,10255,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Stone Keeper - On Data Set - Remove Stoned'),
(4857,0,0,4,0,61,0,100,512,0,0,0,0,0,38,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Stone Keeper - On Data Set - Set In Combat With Zone'),
(4857,0,0,5,6,6,0,100,512,0,0,0,0,0,202,0,0,0,0,0,0,20,124367,200,0,0,0,0,0,0,'Stone Keeper - On Death - Set GO State'),
(4857,0,0,6,0,61,0,100,512,0,0,0,0,0,34,1,3,0,0,0,0,1,0,0,0,0,0,0,0,0,'Stone Keeper - On Death - Set Instance Data'),
(4857,27554,0,7,8,6,0,100,0,0,0,0,0,0,11,9874,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Stone Keeper - On Death - Cast Self Destruct'),
(4857,27554,0,8,0,61,0,100,512,0,0,0,0,0,45,1,1,0,0,0,0,10,28368,4857,0,0,0,0,0,0,'Stone Keeper - On Death - Set Data'),
(4857,27555,0,9,10,6,0,100,0,0,0,0,0,0,11,9874,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Stone Keeper - On Death - Cast Self Destruct'),
(4857,27555,0,10,0,61,0,100,512,0,0,0,0,0,45,1,1,0,0,0,0,10,27554,4857,0,0,0,0,0,0,'Stone Keeper - On Death - Set Data'),
(4857,27794,0,11,12,6,0,100,0,0,0,0,0,0,11,9874,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Stone Keeper - On Death - Cast Self Destruct'),
(4857,27794,0,12,0,61,0,100,512,0,0,0,0,0,45,1,1,0,0,0,0,10,27555,4857,0,0,0,0,0,0,'Stone Keeper - On Death - Set Data'),
(4857,28368,0,13,14,6,0,100,0,0,0,0,0,0,11,9874,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Stone Keeper - On Death - Cast Self Destruct'),
(4857,28368,0,14,0,61,0,100,512,0,0,0,0,0,45,1,1,0,0,0,0,10,27794,4857,0,0,0,0,0,0,'Stone Keeper - On Death - Set Data');

-- Krakle's Thermometer
DELETE FROM `smart_scripts` WHERE `entry` IN (-23712,-23713,-23714,-23715,-23716) AND `source_type`=0;
DELETE FROM `smart_scripts` WHERE `entry` IN (10541) AND `source_type`=0;
INSERT INTO `smart_scripts` (`entry`,`guid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`event_param5`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_param4`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(10541,23712,0,0,0,8,0,100,0,16378,0,0,0,0,1,1,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Krakle''s Thermometer - On Spellhit ''Temperature Reading'' - Say Line 1'),
(10541,23713,0,1,0,8,0,100,0,16378,0,0,0,0,1,1,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Krakle''s Thermometer - On Spellhit ''Temperature Reading'' - Say Line 1'),
(10541,23714,0,2,0,8,0,100,0,16378,0,0,0,0,1,1,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Krakle''s Thermometer - On Spellhit ''Temperature Reading'' - Say Line 1'),
(10541,23715,0,3,0,8,0,100,0,16378,0,0,0,0,1,1,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Krakle''s Thermometer - On Spellhit ''Temperature Reading'' - Say Line 1'),
(10541,23716,0,4,5,8,0,100,512,16378,0,0,0,0,33,10541,0,0,0,0,0,7,0,0,0,0,0,0,0,0,'Krakle''s Thermometer - On Spellhit ''Temperature Reading'' - Quest Credit ''Finding the Source'''),
(10541,23716,0,5,0,61,0,100,512,0,0,0,0,0,1,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Krakle''s Thermometer - On Spellhit ''Temperature Reading'' - Say Line 0');

-- Time Watcher
DELETE FROM `smart_scripts` WHERE `entry` IN (-23426,-23429,-23432,-23433,-23436,-23437,-23438,-23439,-23440) AND `source_type`=0;
DELETE FROM `smart_scripts` WHERE `entry` IN (19918) AND `source_type`=0;
INSERT INTO `smart_scripts` (`entry`,`guid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`event_param5`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_param4`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(19918,23426,0,0,0,1,0,100,512,2600000,2600000,2600000,2600000,0,53,1,2344001,0,0,0,0,1,0,0,0,0,0,0,0,0,'Time Watcher (19918, OOC (19918, Start wp'),
(19918,23426,0,1,0,40,0,100,0,2,0,0,0,0,11,34702,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Time Watcher (19918, On wp2 (19918, Cast'),
(19918,23426,0,2,0,58,0,100,512,7,0,0,0,0,80,1991801,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Time Watcher (19918, On wp Ended (19918, Action list'),
(19918,23426,0,3,0,25,0,100,512,0,0,0,0,0,48,1,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Time Watcher (19918, On Reset (19918, Set Active On'),
(19918,23429,0,4,0,1,0,100,512,3000000,3000000,3000000,3000000,0,53,1,2344001,0,0,0,0,1,0,0,0,0,0,0,0,0,'Time Watcher (19918, OOC (19918, Start wp'),
(19918,23429,0,5,0,40,0,100,0,2,0,0,0,0,11,34702,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Time Watcher (19918, On wp2 (19918, Cast'),
(19918,23429,0,6,0,58,0,100,512,7,0,0,0,0,80,1991801,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Time Watcher (19918, On wp Ended (19918, Action list'),
(19918,23429,0,7,0,25,0,100,512,0,0,0,0,0,48,1,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Time Watcher (19918, On Reset (19918, Set Active On'),
(19918,23432,0,8,0,1,0,100,512,2200000,2200000,2200000,2200000,0,53,1,2344001,0,0,0,0,1,0,0,0,0,0,0,0,0,'Time Watcher (19918, OOC (19918, Start wp'),
(19918,23432,0,9,0,40,0,100,0,2,0,0,0,0,11,34702,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Time Watcher (19918, On wp2 (19918, Cast'),
(19918,23432,0,10,0,58,0,100,512,7,0,0,0,0,80,1991801,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Time Watcher (19918, On wp Ended (19918, Action list'),
(19918,23432,0,11,0,25,0,100,512,0,0,0,0,0,48,1,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Time Watcher (19918, On Reset (19918, Set Active On'),
(19918,23433,0,12,0,1,0,100,512,2600000,2600000,2600000,2600000,0,53,0,2344000,0,0,0,0,1,0,0,0,0,0,0,0,0,'Time Watcher (19918, OOC (19918, Start wp'),
(19918,23433,0,13,0,40,0,100,0,2,0,0,0,0,11,34699,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Time Watcher (19918, On wp2 (19918, Cast'),
(19918,23433,0,14,0,58,0,100,512,6,0,0,0,0,80,1991800,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Time Watcher (19918, On wp Ended (19918, Action list'),
(19918,23433,0,15,0,25,0,100,512,0,0,0,0,0,48,1,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Time Watcher (19918, On Reset (19918, Set Active On'),
(19918,23436,0,16,0,1,0,100,512,2200000,2200000,2200000,2200000,0,53,0,2344000,0,0,0,0,1,0,0,0,0,0,0,0,0,'Time Watcher (19918, OOC (19918, Start wp'),
(19918,23436,0,17,0,40,0,100,0,2,0,0,0,0,11,34699,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Time Watcher (19918, On wp2 (19918, Cast'),
(19918,23436,0,18,0,58,0,100,512,6,0,0,0,0,80,1991800,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Time Watcher (19918, On wp Ended (19918, Action list'),
(19918,23436,0,19,0,25,0,100,512,0,0,0,0,0,48,1,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Time Watcher (19918, On Reset (19918, Set Active On'),
(19918,23437,0,20,0,1,0,100,512,1800000,1800000,1800000,1800000,0,53,1,2344001,0,0,0,0,1,0,0,0,0,0,0,0,0,'Time Watcher (19918, OOC (19918, Start wp'),
(19918,23437,0,21,0,40,0,100,0,2,0,0,0,0,11,34702,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Time Watcher (19918, On wp2 (19918, Cast'),
(19918,23437,0,22,0,58,0,100,512,7,0,0,0,0,80,1991801,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Time Watcher (19918, On wp Ended (19918, Action list'),
(19918,23437,0,23,0,25,0,100,512,0,0,0,0,0,48,1,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Time Watcher (19918, On Reset (19918, Set Active On'),
(19918,23438,0,24,0,1,0,100,512,1800000,1800000,1800000,1800000,0,53,0,2344000,0,0,0,0,1,0,0,0,0,0,0,0,0,'Time Watcher (19918, OOC  (19918, Start wp'),
(19918,23438,0,25,0,40,0,100,0,2,0,0,0,0,11,34699,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Time Watcher (19918, On wp2 (19918, Cast'),
(19918,23438,0,26,0,58,0,100,512,6,0,0,0,0,80,1991800,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Time Watcher (19918, On wp Ended (19918, Action list'),
(19918,23438,0,27,0,25,0,100,512,0,0,0,0,0,48,1,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Time Watcher (19918, On Reset (19918, Set Active On'),
(19918,23439,0,28,0,1,0,100,512,1200000,1200000,1200000,1200000,0,53,1,2344001,0,0,0,0,1,0,0,0,0,0,0,0,0,'Time Watcher (19918, OOC (19918, Start wp'),
(19918,23439,0,29,0,40,0,100,0,2,0,0,0,0,11,34702,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Time Watcher (19918, On wp2 (19918, Cast'),
(19918,23439,0,30,0,58,0,100,512,7,0,0,0,0,80,1991801,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Time Watcher (19918, On wp Ended (19918, Action list'),
(19918,23439,0,31,0,25,0,100,512,0,0,0,0,0,48,1,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Time Watcher (19918, On Reset (19918, Set Active On'),
(19918,23440,0,32,0,1,0,100,512,1200000,1200000,1200000,1200000,0,53,0,2344000,0,0,0,0,1,0,0,0,0,0,0,0,0,'Time Watcher (19918, OOC  (19918, Start wp'),
(19918,23440,0,33,0,40,0,100,0,2,0,0,0,0,11,34699,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Time Watcher (19918, On wp2 (19918, Cast'),
(19918,23440,0,34,0,58,0,100,512,6,0,0,0,0,80,1991800,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Time Watcher (19918, On wp Ended (19918, Action list'),
(19918,23440,0,35,0,25,0,100,512,0,0,0,0,0,48,1,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Time Watcher (19918, On Reset (19918, Set Active On');

-- Overlord Drakuru
DELETE FROM `smart_scripts` WHERE `entry` IN (-21707) AND `source_type`=0;
DELETE FROM `smart_scripts` WHERE `entry` IN (28717) AND `source_type`=0;
INSERT INTO `smart_scripts` (`entry`,`guid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`event_param5`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_param4`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(28717,21707,0,0,0,11,0,100,512,0,0,0,0,0,22,1,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Overlord Drakuru - On Respawn - Set Event Phase 1'),
(28717,21707,0,2,0,61,1,100,512,0,0,0,0,0,80,2871700,2,0,0,0,0,1,0,0,0,0,0,0,0,0,'Overlord Drakuru - On Data Set 0 1 - Run Script (Phase 1)'),
(28717,21707,0,1,2,38,1,100,0,0,1,0,0,0,1,3,0,0,0,0,0,12,1,0,0,0,0,0,0,0,'Overlord Drakuru - On Data Set 0 1 - Say Line 3 (Phase 1)');

-- Horde Guard
DELETE FROM `smart_scripts` WHERE `entry` IN (-19403) AND `source_type`=0;
DELETE FROM `smart_scripts` WHERE `entry` IN (3501) AND `source_type`=0;
INSERT INTO `smart_scripts` (`entry`,`guid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`event_param5`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_param4`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(3501,19403,0,0,0,1,0,100,512,0,0,10000,10000,0,80,1940300,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Horde Guard - Out of Combat - Run Script');

-- Bleak Worg (1 less line)
DELETE FROM `smart_scripts` WHERE `entry` IN (-16239) AND `source_type`=0;
DELETE FROM `smart_scripts` WHERE `entry` IN (3861) AND `source_type`=0;
INSERT INTO `smart_scripts` (`entry`,`guid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`event_param5`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_param4`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(3861,0,0,0,0,0,0,100,0,2000,10000,15000,20000,0,11,7127,0,0,0,0,0,2,0,0,0,0,0,0,0,0,'Bleak Worg - In Combat - Cast Wavering Will'),
(3861,16239,0,1,0,6,0,100,512,0,0,0,0,0,63,1,1,0,0,0,0,19,3927,100,0,0,0,0,0,0,'Bleak Worg - On Just Died - Set Counter');

-- Lavering Worg
DELETE FROM `smart_scripts` WHERE `entry` IN (-16240) AND `source_type`=0;
DELETE FROM `smart_scripts` WHERE `entry` IN (3862) AND `source_type`=0;
INSERT INTO `smart_scripts` (`entry`,`guid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`event_param5`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_param4`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(3862,16240,0,0,0,6,0,100,512,0,0,0,0,0,63,1,1,0,0,0,0,19,3927,100,0,0,0,0,0,0,'Lavering Worg - On Just Died - Set Counter');

-- Wolfguard Worg
DELETE FROM `smart_scripts` WHERE `entry` IN (-16241) AND `source_type`=0;
DELETE FROM `smart_scripts` WHERE `entry` IN (5058) AND `source_type`=0;
INSERT INTO `smart_scripts` (`entry`,`guid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`event_param5`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_param4`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(5058,16241,0,0,0,6,0,100,512,0,0,0,0,0,63,1,1,0,0,0,0,19,3927,100,0,0,0,0,0,0,'Wolfguard Worg - On Just Died - Set Counter');

-- Lupine Horror (1 less line)
DELETE FROM `smart_scripts` WHERE `entry` IN (-16238) AND `source_type`=0;
DELETE FROM `smart_scripts` WHERE `entry` IN (3863) AND `source_type`=0;
INSERT INTO `smart_scripts` (`entry`,`guid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`event_param5`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_param4`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(3863,0,0,0,0,0,0,100,0,4000,12000,60000,60000,0,11,7132,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Lupine Horror - In Combat - Cast Summon Lupine Delusions'),
(3863,16238,0,1,0,6,0,100,512,0,0,0,0,0,63,1,1,0,0,0,0,19,3927,100,0,0,0,0,0,0,'Lupine Horror - On Death - Set Counter');

-- Peon
DELETE FROM `smart_scripts` WHERE `entry` IN (-13751) AND `source_type`=0;
DELETE FROM `smart_scripts` WHERE `entry` IN (14901) AND `source_type`=0;
INSERT INTO `smart_scripts` (`entry`,`guid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`event_param5`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_param4`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(14901,13751,0,0,0,1,0,100,512,0,0,10000,10000,0,80,1375100,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Peon - Out of Combat - Run Script');

-- Soulgrinder Ritual Bunny "I'm not sure if there is a summon here or SAI was just over written so added on summon just in case"
DELETE FROM `smart_scripts` WHERE `entry` IN (-12481) AND `source_type`=0;
DELETE FROM `smart_scripts` WHERE `entry` IN (23037) AND `source_type`=0;
INSERT INTO `smart_scripts` (`entry`,`guid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`event_param5`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_param4`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(23037,0,0,0,0,54,0,100,0,0,0,0,0,0,22,1,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Soulgrinder Ritual Bunny - Just Summoned - Set Phase 1'),
(23037,0,0,1,0,1,1,100,0,2000,2000,0,0,0,11,39920,0,0,0,0,0,10,12481,23037,0,0,0,0,0,0,'Soulgrinder Ritual Bunny - Out of Combat - Cast Soulgrinder Ritual Visual (beam) (Phase 1)'),
(23037,12481,0,2,0,25,0,100,512,0,0,0,0,0,8,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Soulgrinder Ritual Bunny - On Reset  - React passive (dummy to overwrite the Entry SAI)');

-- Hammerfall Guardian
DELETE FROM `smart_scripts` WHERE `entry` IN (-11212) AND `source_type`=0;
DELETE FROM `smart_scripts` WHERE `entry` IN (2621) AND `source_type`=0;
INSERT INTO `smart_scripts` (`entry`,`guid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`event_param5`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_param4`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(2621,11212,0,0,0,1,0,100,512,0,0,10000,10000,0,80,1121200,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Hammerfall Guardian - Out of Combat - Run Script');

-- Lazy Peon (13 less lines)
DELETE FROM `smart_scripts` WHERE `entry` IN (-3345,-3346,-3347,-3348,-6523,-6524,-6525,-6526,-6527,-7372,-7373,-7374,-7375,-7376) AND `source_type`=0;
DELETE FROM `smart_scripts` WHERE `entry` IN (10556) AND `source_type`=0;
INSERT INTO `smart_scripts` (`entry`,`guid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`event_param5`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_param4`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(10556,0,0,0,0,25,0,100,0,0,0,0,0,0,11,17743,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Lazy Peon - On Reset - Cast ''Peon Sleeping'''),
(10556,3345,0,1,0,1,0,100,512,120000,150000,120000,150000,0,80,334500,2,0,0,0,0,1,0,0,0,0,0,0,0,0,'Lazy Peon - Out of Combat - Run Script'),
(10556,3345,0,2,3,8,0,100,512,19938,0,0,0,0,78,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Lazy Peon - On Spellhit ''Awaken Peon'' - Reset All Scripts'),
(10556,3345,0,3,4,61,0,100,512,0,0,0,0,0,80,334501,2,0,0,0,0,1,0,0,0,0,0,0,0,0,'Lazy Peon - On Spellhit ''Awaken Peon'' - Run Script'),
(10556,3345,0,4,0,61,0,100,512,0,0,0,0,0,64,1,0,0,0,0,0,7,0,0,0,0,0,0,0,0,'Lazy Peon - On Spellhit ''Awaken Peon'' - Store Targetlist'),
(10556,3346,0,5,0,1,0,100,512,120000,150000,120000,150000,0,80,334600,2,0,0,0,0,1,0,0,0,0,0,0,0,0,'Lazy Peon - Out of Combat - Run Script'),
(10556,3346,0,6,7,8,0,100,512,19938,0,0,0,0,78,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Lazy Peon - On Spellhit ''Awaken Peon'' - Reset All Scripts'),
(10556,3346,0,7,8,61,0,100,512,0,0,0,0,0,80,334601,2,0,0,0,0,1,0,0,0,0,0,0,0,0,'Lazy Peon - On Spellhit ''Awaken Peon'' - Run Script'),
(10556,3346,0,8,0,61,0,100,512,0,0,0,0,0,64,1,0,0,0,0,0,7,0,0,0,0,0,0,0,0,'Lazy Peon - On Spellhit ''Awaken Peon'' - Store Targetlist'),
(10556,3347,0,9,0,1,0,100,512,120000,150000,120000,150000,0,80,334700,2,0,0,0,0,1,0,0,0,0,0,0,0,0,'Lazy Peon - Out of Combat - Run Script'),
(10556,3347,0,10,11,8,0,100,512,19938,0,0,0,0,78,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Lazy Peon - On Spellhit ''Awaken Peon'' - Reset All Scripts'),
(10556,3347,0,11,12,61,0,100,512,0,0,0,0,0,80,334701,2,0,0,0,0,1,0,0,0,0,0,0,0,0,'Lazy Peon - On Spellhit ''Awaken Peon'' - Run Script'),
(10556,3347,0,12,0,61,0,100,512,0,0,0,0,0,64,1,0,0,0,0,0,7,0,0,0,0,0,0,0,0,'Lazy Peon - On Spellhit ''Awaken Peon'' - Store Targetlist'),
(10556,3348,0,13,0,1,0,100,512,120000,150000,120000,150000,0,80,334800,2,0,0,0,0,1,0,0,0,0,0,0,0,0,'Lazy Peon - Out of Combat - Run Script'),
(10556,3348,0,14,15,8,0,100,512,19938,0,0,0,0,78,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Lazy Peon - On Spellhit ''Awaken Peon'' - Reset All Scripts'),
(10556,3348,0,15,16,61,0,100,512,0,0,0,0,0,80,334801,2,0,0,0,0,1,0,0,0,0,0,0,0,0,'Lazy Peon - On Spellhit ''Awaken Peon'' - Run Script'),
(10556,3348,0,16,0,61,0,100,512,0,0,0,0,0,64,1,0,0,0,0,0,7,0,0,0,0,0,0,0,0,'Lazy Peon - On Spellhit ''Awaken Peon'' - Store Targetlist'),
(10556,6523,0,17,0,1,0,100,512,120000,150000,120000,150000,0,80,652300,2,0,0,0,0,1,0,0,0,0,0,0,0,0,'Lazy Peon - Out of Combat - Run Script'),
(10556,6523,0,18,19,8,0,100,512,19938,0,0,0,0,78,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Lazy Peon - On Spellhit ''Awaken Peon'' - Reset All Scripts'),
(10556,6523,0,19,20,61,0,100,512,0,0,0,0,0,80,652301,2,0,0,0,0,1,0,0,0,0,0,0,0,0,'Lazy Peon - On Spellhit ''Awaken Peon'' - Run Script'),
(10556,6523,0,20,0,61,0,100,512,0,0,0,0,0,64,1,0,0,0,0,0,7,0,0,0,0,0,0,0,0,'Lazy Peon - On Spellhit ''Awaken Peon'' - Store Targetlist'),
(10556,6524,0,21,0,1,0,100,512,120000,150000,120000,150000,0,80,652400,2,0,0,0,0,1,0,0,0,0,0,0,0,0,'Lazy Peon - Out of Combat - Run Script'),
(10556,6524,0,22,23,8,0,100,512,19938,0,0,0,0,78,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Lazy Peon - On Spellhit ''Awaken Peon'' - Reset All Scripts'),
(10556,6524,0,23,24,61,0,100,512,0,0,0,0,0,80,652401,2,0,0,0,0,1,0,0,0,0,0,0,0,0,'Lazy Peon - On Spellhit ''Awaken Peon'' - Run Script'),
(10556,6524,0,24,0,61,0,100,512,0,0,0,0,0,64,1,0,0,0,0,0,7,0,0,0,0,0,0,0,0,'Lazy Peon - On Spellhit ''Awaken Peon'' - Store Targetlist'),
(10556,6525,0,25,0,1,0,100,512,120000,150000,120000,150000,0,80,652500,2,0,0,0,0,1,0,0,0,0,0,0,0,0,'Lazy Peon - Out of Combat - Run Script'),
(10556,6525,0,26,27,8,0,100,512,19938,0,0,0,0,78,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Lazy Peon - On Spellhit ''Awaken Peon'' - Reset All Scripts'),
(10556,6525,0,27,28,61,0,100,512,0,0,0,0,0,80,652501,2,0,0,0,0,1,0,0,0,0,0,0,0,0,'Lazy Peon - On Spellhit ''Awaken Peon'' - Run Script'),
(10556,6525,0,28,0,61,0,100,512,0,0,0,0,0,64,1,0,0,0,0,0,7,0,0,0,0,0,0,0,0,'Lazy Peon - On Spellhit ''Awaken Peon'' - Store Targetlist'),
(10556,6526,0,29,0,1,0,100,512,120000,150000,120000,150000,0,80,652600,2,0,0,0,0,1,0,0,0,0,0,0,0,0,'Lazy Peon - Out of Combat - Run Script'),
(10556,6526,0,30,31,8,0,100,512,19938,0,0,0,0,78,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Lazy Peon - On Spellhit ''Awaken Peon'' - Reset All Scripts'),
(10556,6526,0,31,32,61,0,100,512,0,0,0,0,0,80,652601,2,0,0,0,0,1,0,0,0,0,0,0,0,0,'Lazy Peon - On Spellhit ''Awaken Peon'' - Run Script'),
(10556,6526,0,32,0,61,0,100,512,0,0,0,0,0,64,1,0,0,0,0,0,7,0,0,0,0,0,0,0,0,'Lazy Peon - On Spellhit ''Awaken Peon'' - Store Targetlist'),
(10556,6527,0,33,0,1,0,100,512,120000,150000,120000,150000,0,80,652700,2,0,0,0,0,1,0,0,0,0,0,0,0,0,'Lazy Peon - Out of Combat - Run Script'),
(10556,6527,0,34,35,8,0,100,512,19938,0,0,0,0,78,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Lazy Peon - On Spellhit ''Awaken Peon'' - Reset All Scripts'),
(10556,6527,0,35,36,61,0,100,512,0,0,0,0,0,80,652701,2,0,0,0,0,1,0,0,0,0,0,0,0,0,'Lazy Peon - On Spellhit ''Awaken Peon'' - Run Script'),
(10556,6527,0,36,0,61,0,100,512,0,0,0,0,0,64,1,0,0,0,0,0,7,0,0,0,0,0,0,0,0,'Lazy Peon - On Spellhit ''Awaken Peon'' - Store Targetlist'),
(10556,7372,0,37,0,1,0,100,512,120000,150000,120000,150000,0,80,737200,2,0,0,0,0,1,0,0,0,0,0,0,0,0,'Lazy Peon - Out of Combat - Run Script'),
(10556,7372,0,38,39,8,0,100,512,19938,0,0,0,0,78,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Lazy Peon - On Spellhit ''Awaken Peon'' - Reset All Scripts'),
(10556,7372,0,39,40,61,0,100,512,0,0,0,0,0,80,737201,2,0,0,0,0,1,0,0,0,0,0,0,0,0,'Lazy Peon - On Spellhit ''Awaken Peon'' - Run Script'),
(10556,7372,0,40,0,61,0,100,512,0,0,0,0,0,64,1,0,0,0,0,0,7,0,0,0,0,0,0,0,0,'Lazy Peon - On Spellhit ''Awaken Peon'' - Store Targetlist'),
(10556,7373,0,41,0,1,0,100,512,120000,150000,120000,150000,0,80,737300,2,0,0,0,0,1,0,0,0,0,0,0,0,0,'Lazy Peon - Out of Combat - Run Script'),
(10556,7373,0,42,43,8,0,100,512,19938,0,0,0,0,78,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Lazy Peon - On Spellhit ''Awaken Peon'' - Reset All Scripts'),
(10556,7373,0,43,44,61,0,100,512,0,0,0,0,0,80,737301,2,0,0,0,0,1,0,0,0,0,0,0,0,0,'Lazy Peon - On Spellhit ''Awaken Peon'' - Run Script'),
(10556,7373,0,44,0,61,0,100,512,0,0,0,0,0,64,1,0,0,0,0,0,7,0,0,0,0,0,0,0,0,'Lazy Peon - On Spellhit ''Awaken Peon'' - Store Targetlist'),
(10556,7374,0,45,0,1,0,100,512,120000,150000,120000,150000,0,80,737400,2,0,0,0,0,1,0,0,0,0,0,0,0,0,'Lazy Peon - Out of Combat - Run Script'),
(10556,7374,0,46,47,8,0,100,512,19938,0,0,0,0,78,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Lazy Peon - On Spellhit ''Awaken Peon'' - Reset All Scripts'),
(10556,7374,0,47,48,61,0,100,512,0,0,0,0,0,80,737401,2,0,0,0,0,1,0,0,0,0,0,0,0,0,'Lazy Peon - On Spellhit ''Awaken Peon'' - Run Script'),
(10556,7374,0,48,0,61,0,100,512,0,0,0,0,0,64,1,0,0,0,0,0,7,0,0,0,0,0,0,0,0,'Lazy Peon - On Spellhit ''Awaken Peon'' - Store Targetlist'),
(10556,7375,0,49,0,1,0,100,512,120000,150000,120000,150000,0,80,737500,2,0,0,0,0,1,0,0,0,0,0,0,0,0,'Lazy Peon - Out of Combat - Run Script'),
(10556,7375,0,50,51,8,0,100,512,19938,0,0,0,0,78,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Lazy Peon - On Spellhit ''Awaken Peon'' - Reset All Scripts'),
(10556,7375,0,51,52,61,0,100,512,0,0,0,0,0,80,737501,2,0,0,0,0,1,0,0,0,0,0,0,0,0,'Lazy Peon - On Spellhit ''Awaken Peon'' - Run Script'),
(10556,7375,0,52,0,61,0,100,512,0,0,0,0,0,64,1,0,0,0,0,0,7,0,0,0,0,0,0,0,0,'Lazy Peon - On Spellhit ''Awaken Peon'' - Store Targetlist'),
(10556,7376,0,53,0,1,0,100,512,120000,150000,120000,150000,0,80,737600,2,0,0,0,0,1,0,0,0,0,0,0,0,0,'Lazy Peon - Out of Combat - Run Script'),
(10556,7376,0,54,55,8,0,100,512,19938,0,0,0,0,78,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Lazy Peon - On Spellhit ''Awaken Peon'' - Reset All Scripts'),
(10556,7376,0,55,56,61,0,100,512,0,0,0,0,0,80,737601,2,0,0,0,0,1,0,0,0,0,0,0,0,0,'Lazy Peon - On Spellhit ''Awaken Peon'' - Run Script'),
(10556,7376,0,56,0,61,0,100,512,0,0,0,0,0,64,1,0,0,0,0,0,7,0,0,0,0,0,0,0,0,'Lazy Peon - On Spellhit ''Awaken Peon'' - Store Targetlist');
-- Update condition
UPDATE `conditions` SET `SourceEntry`=10556, `SourceGroup`=3 WHERE `SourceTypeOrReferenceId`=22 AND `SourceGroup`=3 AND `SourceEntry`=-3345;
UPDATE `conditions` SET `SourceEntry`=10556, `SourceGroup`=7 WHERE `SourceTypeOrReferenceId`=22 AND `SourceGroup`=3 AND `SourceEntry`=-3346;
UPDATE `conditions` SET `SourceEntry`=10556, `SourceGroup`=11 WHERE `SourceTypeOrReferenceId`=22 AND `SourceGroup`=3 AND `SourceEntry`=-3347;
UPDATE `conditions` SET `SourceEntry`=10556, `SourceGroup`=15 WHERE `SourceTypeOrReferenceId`=22 AND `SourceGroup`=3 AND `SourceEntry`=-3348;
UPDATE `conditions` SET `SourceEntry`=10556, `SourceGroup`=19 WHERE `SourceTypeOrReferenceId`=22 AND `SourceGroup`=3 AND `SourceEntry`=-6523;
UPDATE `conditions` SET `SourceEntry`=10556, `SourceGroup`=23 WHERE `SourceTypeOrReferenceId`=22 AND `SourceGroup`=3 AND `SourceEntry`=-6524;
UPDATE `conditions` SET `SourceEntry`=10556, `SourceGroup`=27 WHERE `SourceTypeOrReferenceId`=22 AND `SourceGroup`=3 AND `SourceEntry`=-6525;
UPDATE `conditions` SET `SourceEntry`=10556, `SourceGroup`=31 WHERE `SourceTypeOrReferenceId`=22 AND `SourceGroup`=3 AND `SourceEntry`=-6526;
UPDATE `conditions` SET `SourceEntry`=10556, `SourceGroup`=35 WHERE `SourceTypeOrReferenceId`=22 AND `SourceGroup`=3 AND `SourceEntry`=-6527;
UPDATE `conditions` SET `SourceEntry`=10556, `SourceGroup`=39 WHERE `SourceTypeOrReferenceId`=22 AND `SourceGroup`=3 AND `SourceEntry`=-7372;
UPDATE `conditions` SET `SourceEntry`=10556, `SourceGroup`=43 WHERE `SourceTypeOrReferenceId`=22 AND `SourceGroup`=3 AND `SourceEntry`=-7373;
UPDATE `conditions` SET `SourceEntry`=10556, `SourceGroup`=47 WHERE `SourceTypeOrReferenceId`=22 AND `SourceGroup`=3 AND `SourceEntry`=-7374;
UPDATE `conditions` SET `SourceEntry`=10556, `SourceGroup`=51 WHERE `SourceTypeOrReferenceId`=22 AND `SourceGroup`=3 AND `SourceEntry`=-7375;
UPDATE `conditions` SET `SourceEntry`=10556, `SourceGroup`=54 WHERE `SourceTypeOrReferenceId`=22 AND `SourceGroup`=3 AND `SourceEntry`=-7376;

-- Gameobjects

-- Sunhawk Portal Controller 
DELETE FROM `smart_scripts` WHERE `entry` IN (-12164,-12166,-12168,-12173) AND `source_type`=1;
DELETE FROM `smart_scripts` WHERE `entry` IN (184850) AND `source_type`=1;
INSERT INTO `smart_scripts` (`entry`,`guid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`event_param5`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_param4`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(184850,12164,1,0,1,70,0,100,0,2,0,0,0,0,41,0,0,0,0,0,0,10,63584,17886,0,0,0,0,0,0,'Sunhawk Portal Controller - ON Gameobject State CHANGED - Despawn Target'),
(184850,12164,1,1,0,61,0,100,0,0,0,0,0,0,22,1,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Sunhawk Portal Controller - On Gameobject State Changed - Set Event Phase 1'),
(184850,12164,1,2,0,60,1,100,0,0,0,0,0,0,41,3000,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Sunhawk Portal Controller - ON UPDATE - Despawn IN 3000 ms (PHASE 1)'),
(184850,12166,1,3,1,70,0,100,0,2,0,0,0,0,41,0,0,0,0,0,0,10,63583,17886,0,0,0,0,0,0,'Sunhawk Portal Controller - ON Gameobject State CHANGED - Despawn Target'),
(184850,12166,1,4,0,61,0,100,0,0,0,0,0,0,22,1,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Sunhawk Portal Controller - On Gameobject State Changed - Set Event Phase 1'),
(184850,12166,1,5,0,60,1,100,0,0,0,0,0,0,41,3000,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Sunhawk Portal Controller - On Update - Despawn In 3000 ms (Phase 1)'),
(184850,12168,1,6,1,70,0,100,0,2,0,0,0,0,41,0,0,0,0,0,0,10,63582,17886,0,0,0,0,0,0,'Sunhawk Portal Controller - On Gameobject State Changed - Despawn Target'),
(184850,12168,1,7,0,61,0,100,0,0,0,0,0,0,22,1,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Sunhawk Portal Controller - On Gameobject State Changed - Set Event Phase 1'),
(184850,12168,1,8,0,60,1,100,0,0,0,0,0,0,41,3000,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Sunhawk Portal Controller - ON UPDATE - Despawn IN 3000 ms (PHASE 1)'),
(184850,12173,1,9,1,70,0,100,0,2,0,0,0,0,41,0,0,0,0,0,0,10,63585,17886,0,0,0,0,0,0,'Sunhawk Portal Controller - ON Gameobject State CHANGED - Despawn Target'),
(184850,12173,1,10,0,61,0,100,0,0,0,0,0,0,22,1,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Sunhawk Portal Controller - On Gameobject State Changed - Set Event Phase 1'),
(184850,12173,1,11,0,60,1,100,0,0,0,0,0,0,41,3000,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Sunhawk Portal Controller - On Update - Despawn In 3000 ms (Phase 1)');
