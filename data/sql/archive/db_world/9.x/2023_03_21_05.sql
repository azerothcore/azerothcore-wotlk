-- DB update 2023_03_21_04 -> 2023_03_21_05
-- Coosh'coosh (18586)
-- Co-authored-by: aletson <aletson@users.noreply.github.com> https://github.com/TrinityCore/TrinityCore/pull/20773
UPDATE `creature_template` SET `AIName` = 'SmartAI', `ScriptName` = '' WHERE `entry` = 18586;

DELETE FROM `smart_scripts` WHERE `entryorguid`=18586 AND `source_type`=0;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(18586, 0, 0, 0, 0, 0, 100, 0, 0, 0, 3000, 3000, 0, 11, 9532, 64, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Coosh\'coosh - In Combat - Cast \'Lightning Bolt\''),
(18586, 0, 1, 2, 62, 0, 100, 0, 7730, 0, 0, 0, 0, 72, 0, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Coosh\'coosh - On Gossip Option 0 Selected - Close Gossip'),
(18586, 0, 2, 3, 61, 0, 100, 0, 0, 0, 0, 0, 0, 2, 45, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Coosh\'coosh - On Gossip Option 0 Selected - Set Faction Ogre'),
(18586, 0, 3, 4, 61, 0, 100, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Coosh\'coosh - On Gossip Option 0 Selected - Say Line 0'),
(18586, 0, 4, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 49, 0, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Coosh\'coosh - On Gossip Option 0 Selected - Start Attacking'),
(18586, 0, 5, 0, 25, 0, 100, 0, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Coosh\'coosh - On Reset - Set Default Faction'),
(18586, 0, 6, 0, 23, 0, 100, 0, 12550, 0, 10000, 10000, 0, 11, 12550, 64, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Coosh\'coosh - On Missing Buff - Cast Lightning Shield');

DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId` = 15 AND `SourceGroup` = 7730;
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `ErrorType`, `ErrorTextId`, `ScriptName`, `Comment`) VALUES
(15, 7730, 0, 0, 0, 9, 0, 10009, 0, 0, 0, 0, 0, '', 'Coosh\'coosh - Show gossip menu 7730 option id 0 if quest Crackin\' Some Skulls has been taken.');

-- Mortog Steamhead (23373)
-- Co-authored-by: tkrokli  <tkrokli @users.noreply.github.com> https://github.com/TrinityCore/TrinityCore/commit/0c6eeb3abc54dbc0f147e5098619e8e19e27accd
UPDATE `creature_template` SET `ScriptName`= '' WHERE `entry`= 23373;

DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId`= 15 AND `SourceGroup`= 8692;
INSERT INTO `conditions` (`SourceTypeOrReferenceId`,`SourceGroup`,`SourceEntry`,`SourceId`,`ElseGroup`,`ConditionTypeOrReference`,`ConditionTarget`,`ConditionValue1`,`ConditionValue2`,`ConditionValue3`,`NegativeCondition`,`ErrorType`,`ErrorTextId`,`ScriptName`,`Comment`) VALUES
(15,8692,0,0,0,5,0,942,128,0,0,0,0,'', 'Mortog Steamhead - Show gossip menu 8692 option id 0 if player is Exalted with Cenarion Expedition.');

-- Timothy Daniels (18019)
-- Co-authored-by: tkrokli  <tkrokli @users.noreply.github.com> https://github.com/TrinityCore/TrinityCore/commit/e2f395863a7fb1a85dc7d09f2692198faae16f46
UPDATE `creature_template` SET `ScriptName`= '' WHERE `entry` = 18019;

-- Elder Kuruti (18197)
-- Co-authored-by: aletson <aletson@users.noreply.github.com> https://github.com/TrinityCore/TrinityCore/pull/20430
UPDATE `creature_template` SET `AIName` = 'SmartAI', `ScriptName` = '' WHERE `entry` = 18197;

DELETE FROM `smart_scripts` WHERE `entryorguid` = 18197 AND `source_type` = 0; 
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(18197, 0, 0, 0, 62, 0, 100, 0, 7585, 0, 0, 0, 11, 32152, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 'Elder Kuruti - On Gossip Option 0 Selected - Cast \'Serverside - Summon Elder Kuruti`s Response\'');

DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId` = 15 AND `SourceGroup` = 7582;
INSERT INTO `conditions` (`SourceTypeOrReferenceId`,`SourceGroup`,`SourceEntry`,`SourceId`,`ElseGroup`,`ConditionTypeOrReference`,`ConditionTarget`,`ConditionValue1`,`ConditionValue2`,`ConditionValue3`,`NegativeCondition`,`ErrorTextId`,`ScriptName`,`Comment`) VALUES
(15,7582,0,0,1,8,0,9803,0,0,1,0,'','Elder Kuruti - Show gossip menu 7582 option id 0 if Quest 9803 is not rewarded'),
(15,7582,0,0,1,9,0,9803,0,0,0,0,'','Elder Kuruti -Show gossip menu 7582 option id 0 if Quest 9803 is taken'),
(15,7582,0,0,1,2,0,24573,1,0,1,0,'','Elder Kuruti - Show gossip menu 7582 option id 0 if player does not have item 24573 in inventory');

-- Escape from Umbrafen - Slavebinder(18042) &  Kayra Longmane(17969)
-- Co-authored-by: Faq <Faq@users.noreply.github.com>
-- Co-authored-by: offl <offl@users.noreply.github.com> https://github.com/Faq/TrinityCore/commit/2219319d5a5a3e04e81548d23efaa177879bbb29

-- Creature_text
DELETE FROM `creature_text` WHERE `CreatureID`=18042;
INSERT INTO `creature_text` (`CreatureID`, `GroupID`, `ID`, `Text`, `Type`, `Language`, `Probability`, `Emote`, `Duration`, `Sound`, `BroadcastTextId`, `TextRange`, `comment`) VALUES
(18042, 0, 0, 'You won\'t escape us, druid!', 12, 0, 100, 0, 0, 0, 14731, 0, 'Slavebinder');

DELETE FROM `creature_text` WHERE `CreatureID`=17969;
INSERT INTO `creature_text` (`CreatureID`, `GroupID`, `ID`, `Text`, `Type`, `Language`, `Probability`, `Emote`, `Duration`, `Sound`, `BroadcastTextId`, `TextRange`, `comment`) VALUES
(17969, 0, 0, 'Is the way clear?  Let\'s get out while we can, $n.', 12, 0, 100, 0, 0, 0, 14724, 0, 'Kayra Longmane'),
(17969, 1, 0, 'Looks like we won\'t get away so easily.  Get ready!', 12, 0, 100, 0, 0, 0, 14725, 0, 'Kayra Longmane'),
(17969, 2, 0, 'Let\'s keep moving.  We\'re not safe here!', 12, 0, 100, 0, 0, 0, 14726, 0, 'Kayra Longmane'),
(17969, 3, 0, 'Look out, $n!  Enemies ahead!', 12, 0, 100, 0, 0, 0, 14727, 0, 'Kayra Longmane'),
(17969, 4, 0, 'We\'re almost to the refuge!  Let\'s go.', 12, 0, 100, 0, 0, 0, 14728, 0, 'Kayra Longmane'),
(17969, 5, 0, 'I can see my fellow druids from here.  Thank you, $n.  I\'m sure Ysiel will reward you for your actions!', 12, 0, 100, 0, 0, 0, 14729, 0, 'Kayra Longmane');

-- Slavebinder
UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 18042;
DELETE FROM `smart_scripts` WHERE `entryorguid` = 18042 AND `source_type` = 0;
DELETE FROM `smart_scripts` WHERE `entryorguid` = 1804200 AND `source_type` = 9;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(18042, 0, 0, 0, 54, 0, 100, 0, 0, 0, 0, 0, 0, 80, 1804200, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Umbrafen Slavebinder - On Just Summoned - Run Script'),
(1804200, 9, 0, 0, 0, 0, 100, 0, 2000, 2000, 0, 0, 0, 49, 0, 0, 0, 0, 0, 0, 19, 17969, 0, 0, 0, 0, 0, 0, 0, 'Umbrafen Slavebinder - On Script - Start Attacking Closest Creature \'Kayra Longmane\'');

-- Kayra Longmane
DELETE FROM `script_waypoint` WHERE `entry`=17969;

DELETE FROM `waypoints` WHERE `entry` = 17969;
INSERT INTO `waypoints` (`entry`,`pointid`,`position_x`,`position_y`,`position_z`,`point_comment`) VALUES
(17969,1,-930.049,5288.08,23.8484,'Kayra Longmane'),
(17969,2,-925.678,5296.48,18.1837,'Kayra Longmane'),
(17969,3,-924.297,5299.02,17.7109,'Kayra Longmane'),
(17969,4,-928.39,5317.02,18.2086,'Kayra Longmane'),
(17969,5,-930.621,5329.92,18.7734,'Kayra Longmane'),
(17969,6,-931.49,5357.65,18.0272,'Kayra Longmane'),
(17969,7,-934.778,5369.34,22.278,'Kayra Longmane'),
(17969,8,-934.522,5373.41,22.8347,'Kayra Longmane'),
(17969,9,-937.009,5382.98,22.6991,'Kayra Longmane'),
(17969,10,-941.948,5404.14,22.6697,'Kayra Longmane'),
(17969,11,-931.244,5415.85,23.064,'Kayra Longmane'),
(17969,12,-901.498,5420.32,24.2133,'Kayra Longmane'),
(17969,13,-860.312,5415.62,23.6711,'Kayra Longmane'),
(17969,14,-777.989,5391.98,23.0017,'Kayra Longmane'),
(17969,15,-750.362,5385.79,22.7658,'Kayra Longmane'),
(17969,16,-731.339,5382.45,22.5171,'Kayra Longmane'),
(17969,17,-681.236,5381.38,22.0502,'Kayra Longmane'),
(17969,18,-637.944,5384.34,22.2056,'Kayra Longmane'),
(17969,19,-608.954,5408.72,21.6304,'Kayra Longmane'),
(17969,20,-598.134,5413.61,21.4123,'Kayra Longmane'),
(17969,21,-571.269,5420.77,21.1849,'Kayra Longmane'),
(17969,22,-553.1,5424.62,21.1937,'Kayra Longmane'),
(17969,23,-524.745,5443.95,20.977,'Kayra Longmane'),
(17969,24,-502.985,5446.28,22.1494,'Kayra Longmane'),
(17969,25,-472.464,5449.55,22.5615,'Kayra Longmane'),
(17969,26,-454.533,5461.3,22.6028,'Kayra Longmane');

-- Summon groups
DELETE FROM `creature_summon_groups` WHERE `summonerId` = 17969;
INSERT INTO `creature_summon_groups` (`summonerId`,`summonerType`,`groupId`,`entry`,`position_x`,`position_y`,`position_z`,`orientation`,`summonType`,`summonTime`) VALUES
(17969,0,0,18042,-916.4861,5355.635,18.25233,5.0,1,60000),
(17969,0,0,18042,-918.9288,5358.430,18.05894,5.0,1,60000),
(17969,0,1,18042,-668.2899,5382.913,22.32479,5.0,1,60000),
(17969,0,1,18042,-669.2795,5386.802,23.01249,5.0,1,60000);

SET @ID := 17969;
UPDATE `creature_template` SET `AIName` = 'SmartAI', `ScriptName` = '' WHERE `entry` = @ID;
UPDATE `creature_template_addon` SET `bytes1`=0 WHERE `entry` = @ID;
DELETE FROM `smart_scripts` WHERE `entryorguid` = @ID AND `source_type` = 0;
DELETE FROM `smart_scripts` WHERE `entryorguid` BETWEEN @ID*100+0 AND @ID*100+5 AND `source_type` = 9;
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`event_param5`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_param4`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(@ID,0,0,11,19,0,100,0,9752,0,0,0,0,80,@ID*100+0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Kayra Longmane - On Quest \'Escape from Umbrafen\' Taken - Run Script'),
(@ID,0,1,0,40,0,100,0,5,0,0,0,0,80,@ID*100+1,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Kayra Longmane - On Waypoint 5 Reached - Run Script'),
(@ID,0,2,0,40,0,100,0,6,0,0,0,0,80,@ID*100+2,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Kayra Longmane - On Waypoint 6 Reached - Run Script'),
(@ID,0,3,0,40,0,100,0,17,0,0,0,0,80,@ID*100+3,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Kayra Longmane - On Waypoint 17 Reached - Run Script'),
(@ID,0,4,0,40,0,100,0,18,0,0,0,0,80,@ID*100+4,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Kayra Longmane - On Waypoint 18 Reached - Run Script'),
(@ID,0,5,0,40,0,100,0,26,0,0,0,0,80,@ID*100+5,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Kayra Longmane - On Waypoint 26 Reached - Run Script'),
(@ID,0,6,0,6,0,100,0,0,0,0,0,0,6,9752,0,0,0,0,0,16,0,0,0,0,0,0,0,0,'Kayra Longmane - On Death - Fail Quest \'Escape from Umbrafen\''),
(@ID,0,7,0,11,0,100,0,0,0,0,0,0,90,8,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Kayra Longmane - On spawn -  Set Flag Standstate Kneel'),
(@ID,0,8,0,0,0,100,0,1000,2000,2000,3000,0,11,9739,64,0,0,0,0,2,0,0,0,0,0,0,0,0,'Kayra Longmane - In Combat -  Cast Wrath'),
(@ID,0,9,0,0,0,100,0,5000,6000,6000,7000,0,11,31401,64,0,0,0,0,2,0,0,0,0,0,0,0,0,'Kayra Longmane - In Combat -  Cast Moonfire'),
(@ID, 0, 10, 0, 74, 1, 100, 0, 0, 25, 8000, 15000, 0, 11, 23381, 64, 0, 0, 0, 0, 18, 25, 0, 0, 0, 0, 0, 0, 0, 'Kayra Longmane - On Friendly Between 0-25% Health (Range: 25) - Cast \'Healing Touch\' (Phase 1)'),
(@ID, 0, 11, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 22, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Kayra Longmane - On Quest \'Escape from Umbrafen\' Taken - Set Event Phase 1'),
(@ID*100+0,9,0,0,0,0,100,0,0,0,0,0,0,64,1,0,0,0,0,0,7,0,0,0,0,0,0,0,0,'Kayra Longmane - On Script - Store Targetlist'),
(@ID*100+0,9,1,0,0,0,100,0,0,0,0,0,0,1,0,0,0,0,0,0,12,1,0,0,0,0,0,0,0,'Kayra Longmane - On Script - Say Line 0'),
(@ID*100+0,9,2,0,0,0,100,0,0,0,0,0,0,2,495,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Kayra Longmane - On Script - Set Faction 495'),
(@ID*100+0,9,3,0,0,0,100,0,0,0,0,0,0,83,2,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Kayra Longmane - On Script - Remove NPC Flag Questgiver'),
(@ID*100+0,9,4,0,0,0,100,0,3000,3000,0,0,0,91,8,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Kayra Longmane - On Script - Remove Flag Standstate Kneel'),
(@ID*100+0,9,5,0,0,0,100,0,0,0,0,0,0,53,0,17969,0,0,0,2,1,0,0,0,0,0,0,0,0,'Kayra Longmane - On Script - Start Waypoint'),
-- Seems like with no time and resume when all creatures are killed
(@ID*100+1,9,0,0,0,0,100,0,0,0,0,0,0,54,10000,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Kayra Longmane - On Script - Pause Waypoint'),
(@ID*100+1,9,1,0,0,0,100,0,0,0,0,0,0,1,1,0,0,0,0,0,12,1,0,0,0,0,0,0,0,'Kayra Longmane - On Script - Say Line 1'),
(@ID*100+1,9,2,0,0,0,100,0,2000,2000,0,0,0,107,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,'Kayra Longmane - On Script - Summon Group 0'),
(@ID*100+1,9,3,0,0,0,100,0,1000,1000,0,0,0,1,0,0,0,0,0,0,19,18042,0,0,0,0,0,0,0,'Kayra Longmane - On Script - Say text'),
(@ID*100+2,9,0,0,0,0,100,0,0,0,0,0,0,54,4000,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Kayra Longmane - On Script - Pause Waypoint'),
(@ID*100+2,9,1,0,0,0,100,0,4000,4000,0,0,0,1,2,0,0,0,0,0,12,1,0,0,0,0,0,0,0,'Kayra Longmane - On Script - Say Line 2'),
(@ID*100+2,9,2,0,0,0,100,0,0,0,0,0,0,59,1,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Kayra Longmane - On Script - Set Run On'),
-- Seems like with no time and resume when all creatures are killed
(@ID*100+3,9,0,0,0,0,100,0,0,0,0,0,0,54,10000,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Kayra Longmane - On Script - Pause Waypoint'),
(@ID*100+3,9,1,0,0,0,100,0,3000,3000,0,0,0,1,3,0,0,0,0,0,12,1,0,0,0,0,0,0,0,'Kayra Longmane - On Script - Say Line 3'),
(@ID*100+3,9,2,0,0,0,100,0,2000,2000,0,0,0,107,1,1,0,0,0,0,0,0,0,0,0,0,0,0,0,'Kayra Longmane - On Script - Summon Group 1'),
(@ID*100+3,9,3,0,0,0,100,0,1000,1000,0,0,0,1,0,0,0,0,0,0,19,18042,0,0,0,0,0,0,0,'Kayra Longmane - On Script - Say text'),
(@ID*100+4,9,0,0,0,0,100,0,0,0,0,0,0,54,4000,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Kayra Longmane - On Script - Pause Waypoint'),
(@ID*100+4,9,1,0,0,0,100,0,1000,1000,0,0,0,1,4,0,0,0,0,0,12,1,0,0,0,0,0,0,0,'Kayra Longmane - On Script - Say Line 4'),
(@ID*100+5,9,0,0,0,0,100,0,0,0,0,0,0,54,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Kayra Longmane - On Script - Pause Waypoint'),
(@ID*100+5,9,1,0,0,0,100,0,0,0,0,0,0,1,5,0,0,0,0,0,12,1,0,0,0,0,0,0,0,'Kayra Longmane - On Script - Say Line 5'),
(@ID*100+5,9,2,0,0,0,100,0,0,0,0,0,0,15,9752,0,0,0,0,0,16,0,0,0,0,0,0,0,0,'Kayra Longmane - On Script - Quest Credit \'Escape from Umbrafen\''),
(@ID*100+5,9,3,0,0,0,100,0,0,0,0,0,0,41,10000,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Kayra Longmane - On Script - Despawn (10000)'),
(@ID*100+5, 9, 4, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 22, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Kayra Longmane - Actionlist - Set Event Phase 0');
