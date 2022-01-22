-- DB update 2020_12_14_00 -> 2020_12_15_00
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2020_12_14_00';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2020_12_14_00 2020_12_15_00 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1607432767438370200'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1607432767438370200');
DELETE FROM `creature_text` WHERE `CreatureID` IN (25317,25220,25222);
INSERT INTO `creature_text` (`CreatureID`, `groupid`, `id`, `text`, `type`, `language`, `probability`, `emote`, `duration`, `sound`, `BroadcastTextId`, `comment`) VALUES
(25317, 0, 0, 'What''s the matter, $c?  Think you''re too good to stand in line with the rest of us?', 12, 0, 100, 0, 0, 0, 24758, 'Civilian Recruit to Player'),
(25220, 0, 0, 'Miner.', 12, 7, 100, 66, 0, 0, 24377, 'Civilian Recruit to Generic Quest Trigger - LAB'),
(25220, 0, 1, 'Farmhand, sir.', 12, 7, 100, 66, 0, 0, 24373, 'Civilian Recruit to Generic Quest Trigger - LAB'),
(25220, 0, 2, 'Tailor.', 12, 7, 100, 66, 0, 0, 24374, 'Civilian Recruit to Generic Quest Trigger - LAB'),
(25220, 0, 3, 'Blacksmith.', 12, 7, 100, 66, 0, 0, 24375, 'Civilian Recruit to Generic Quest Trigger - LAB'),
(25220, 0, 4, 'Carpenter.', 12, 7, 100, 66, 0, 0, 24371, 'Civilian Recruit to Generic Quest Trigger - LAB'),
(25220, 0, 5, 'Shipwright.', 12, 7, 100, 66, 0, 0, 24372, 'Civilian Recruit to Generic Quest Trigger - LAB'),
(25220, 0, 6, 'Mason, sir.', 12, 7, 100, 66, 0, 0, 24376, 'Civilian Recruit to Generic Quest Trigger - LAB'),
(25220, 0, 7, 'Cook.', 12, 7, 100, 66, 0, 0, 24378, 'Civilian Recruit to Generic Quest Trigger - LAB'),
(25222, 0, 0, 'What did you do before you came to Northrend, then?', 12, 7, 100, 0, 0, 0, 24386, 'Recruitment Officer Carven to Generic Quest Trigger - LAB'),
(25222, 0, 1, 'State your profession.', 12, 7, 100, 0, 0, 0, 24382, 'Recruitment Officer Carven to Generic Quest Trigger - LAB'),
(25222, 0, 2, 'Yes, then.  What is your trade?', 12, 7, 100, 0, 0, 0, 24383, 'Recruitment Officer Carven to Generic Quest Trigger - LAB'),
(25222, 0, 3, 'Your previous line of work, recruit?', 12, 7, 100, 0, 0, 0, 24385, 'Recruitment Officer Carven to Generic Quest Trigger - LAB'),
(25222, 0, 4, 'Your profession?', 12, 7, 100, 0, 0, 0, 24384, 'Recruitment Officer Carven to Generic Quest Trigger - LAB'),
(25222, 1, 0, 'Yes, you''re well seasoned in your field of work.  Report to the civilian liaison at once, we need more like you!', 12, 7, 100, 273, 0, 0, 24361, 'Recruitment Officer Carven to Generic Quest Trigger - LAB'),
(25222, 1, 1, 'I thought we had enough in your line of work, but it looks like we have some openings.  Report to the civilian liaison.', 12, 7, 100, 273, 0, 0, 24360, 'Recruitment Officer Carven to Generic Quest Trigger - LAB'),
(25222, 1, 2, 'I do have some openings in your line of work.  Report to the civilian liaison.', 12, 7, 100, 273, 0, 0, 24359, 'Recruitment Officer Carven to Generic Quest Trigger - LAB'),
(25222, 1, 3, 'Yeah.  We could use some more of you.  Report to the civilian liaison for work assignment.', 12, 7, 100, 273, 0, 0, 24358, 'Recruitment Officer Carven to Generic Quest Trigger - LAB'),
(25222, 2, 0, 'Not anymore!  Here''s your sword.  Report to the barracks for duty!', 12, 7, 100, 397, 0, 0, 24363, 'Recruitment Officer Carven to Generic Quest Trigger - LAB'),
(25222, 2, 1, 'Afraid not, friend.  Here''s your sword and shield.  Report to the barracks for duty.', 12, 7, 100, 397, 0, 0, 24365, 'Recruitment Officer Carven to Generic Quest Trigger - LAB'),
(25222, 2, 2, 'You''re breaking my heart - I''ve quotas to fill, you know?  Can you wield a sword?  Off to the barracks.', 12, 7, 100, 397, 0, 0, 24367, 'Recruitment Officer Carven to Generic Quest Trigger - LAB'),
(25222, 2, 3, 'With a sword arm like that?  I''m afraid we need you in the front lines, my friend.  Report to the barracks.', 12, 7, 100, 397, 0, 0, 24366, 'Recruitment Officer Carven to Generic Quest Trigger - LAB'),
(25222, 2, 4, 'Looks like we have room for one more... no, my mistake.  That''s a seven not a one.  Hope you''re good with a sword - report to the barracks.', 12, 7, 100, 397, 0, 0, 24368, 'Recruitment Officer Carven to Generic Quest Trigger - LAB'),
(25222, 3, 0, 'Next, please!', 12, 7, 100, 22, 0, 0, 24370, 'Recruitment Officer Carven to Generic Quest Trigger - LAB'),
(25222, 3, 1, 'Keep it moving, people.', 12, 7, 100, 22, 0, 0, 24369, 'Recruitment Officer Carven to Generic Quest Trigger - LAB'),
(25222, 3, 2, 'Next!', 12, 7, 100, 22, 0, 0, 24357, 'Recruitment Officer Carven to Generic Quest Trigger - LAB');

DELETE FROM `waypoints` WHERE `entry` = 25220;
INSERT INTO `waypoints` (`entry`, `pointid`, `position_x`, `position_y`, `position_z`, `point_comment`) VALUES 
(25220, 1, 2253.644, 5195.469, 11.40062, 'Civilian Recruit'),
(25220, 2, 2254.098, 5196.36, 11.40062, 'Civilian Recruit'),
(25220, 3, 2277.823, 5238.724, 11.45096, 'Civilian Recruit'),
(25220, 4, 2279.217, 5241.407, 11.45096, 'Civilian Recruit'),
(25220, 5, 2280.84, 5244.218, 11.45719, 'Civilian Recruit'),
(25220, 6, 2282.603, 5245.736, 11.36353, 'Civilian Recruit'),
(25220, 7, 2284.867, 5246.299, 11.45096, 'Civilian Recruit'),
(25220, 8, 2287.469, 5245.929, 11.45096, 'Civilian Recruit'),
(25220, 9, 2289.469, 5244.898, 11.45096, 'Civilian Recruit'),
(25220, 10, 2291.772, 5243.933, 11.45096, 'Civilian Recruit'),
(25220, 11, 2294.129, 5242.708, 11.45096, 'Civilian Recruit'),
-- P12 this is blizzlike behavior, with it - they will end up on the table.
-- (25220, 12, 2298.062, 5241.932, 12.3176, 'Civilian Recruit'),
(25220, 12, 2297.330, 5241.240, 11.46370, 'Civilian Recruit'),
(25220, 13, 2303.019, 5253.306, 11.50584, 'Civilian Recruit'),
(25220, 14, 2308.73, 5256.926, 11.50584, 'Civilian Recruit'),
(25220, 15, 2320.826, 5259.258, 11.25584, 'Civilian Recruit');

DELETE FROM  `creature` WHERE `guid` IN (108008,108007,108006,108005,108004,108003,108002,108001,108000);

UPDATE `creature_template` SET `AIName`='SmartAI' WHERE `entry` IN (24959,25220,25307);
DELETE FROM `smart_scripts` WHERE `source_type`=0 AND `entryorguid` IN (-107575 ,-107574, 25220, 25307);
DELETE FROM `smart_scripts` WHERE `source_type`=9 AND `entryorguid` IN (2522000,2522001);

INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES 
(-107575, 0, 0, 0, 11, 0, 100, 0, 0, 0, 0, 0, 48, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Generic Quest Trigger - LAB - On Spawn - Set Active'),
(-107575, 0, 1, 0, 1, 0, 100, 0, 0, 0, 22000, 23000, 12, 25220, 8, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Generic Quest Trigger - LAB - OOC - Cast Borean Tundra - Valiance Keep Flavor - Summon Recruit'),
(-107574, 0, 1, 0, 1, 0, 100, 0, 0, 0, 22000, 23000, 11, 45307, 8, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Generic Quest Trigger - LAB - OOC - Cast Borean Tundra - Valiance Keep Flavor - Queue Global Ping'),
(25307, 0, 0, 0, 19, 0, 100, 0, 11672, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 19, 25317, 0, 0, 0, 0, 0, 0, 'Recruitment Officer Blythe - On Quest Accepted (Enlistment Day) - Say'),
(25220, 0, 0, 1, 54, 0, 100, 0, 0, 0, 0, 0, 48, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Civilian Recruit - On Just Summoned - Set Active'),
(25220, 0, 1, 0, 61, 0, 100, 0, 0, 0, 0, 0, 53, 0, 25220, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Civilian Recruit - On Just Summoned - Start WP'),
(25220, 0, 2, 0, 8, 0, 100, 0, 45313, 0, 0, 0, 54, 22000, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Civilian Recruit - On Spellhit - Anchor Here - Pause WP'),
(25220, 0, 3, 0, 8, 0, 100, 0, 45307, 0, 0, 0, 65, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Civilian Recruit - On Spellhit - Borean Tundra - Valiance Keep Flavor - Queue Global Ping - Resume WP'),
(25220, 0, 4, 0, 40, 0, 100, 0, 3, 25220, 0, 0, 11, 45313, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Civilian Recruit - On Reached WP3 - Cast Anchor Here'),
(25220, 0, 5, 0, 40, 0, 100, 0, 4, 25220, 0, 0, 11, 45313, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Civilian Recruit - On Reached WP4 - Cast Anchor Here'),
(25220, 0, 6, 0, 40, 0, 100, 0, 5, 25220, 0, 0, 11, 45313, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Civilian Recruit - On Reached WP5 - Cast Anchor Here'),
(25220, 0, 7, 0, 40, 0, 100, 0, 6, 25220, 0, 0, 11, 45313, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Civilian Recruit - On Reached WP6 - Cast Anchor Here'),
(25220, 0, 8, 0, 40, 0, 100, 0, 7, 25220, 0, 0, 11, 45313, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Civilian Recruit - On Reached WP7 - Cast Anchor Here'),
(25220, 0, 9, 0, 40, 0, 100, 0, 8, 25220, 0, 0, 11, 45313, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Civilian Recruit - On Reached WP8 - Cast Anchor Here'),
(25220, 0, 10, 0, 40, 0, 100, 0, 9, 25220, 0, 0, 11, 45313, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Civilian Recruit - On Reached WP9 - Cast Anchor Here'),
(25220, 0, 11, 0, 40, 0, 100, 0, 10, 25220, 0, 0, 11, 45313, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Civilian Recruit - On Reached WP10 - Cast Anchor Here'),
(25220, 0, 12, 0, 40, 0, 100, 0, 11, 25220, 0, 0, 11, 45313, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Civilian Recruit - On Reached WP11 - Cast Anchor Here'),
(25220, 0, 13, 14, 40, 0, 100, 0, 12, 25220, 0, 0, 54, 18000, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Civilian Recruit - On Reached WP11 - Cast Anchor Here'),
(25220, 0, 14, 0, 61, 0, 100, 0, 0, 0, 0, 0, 87, 2522000, 2522001, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Civilian Recruit - On Reached WP11 - Run Script'), 
(25220, 0, 15, 0, 40, 0, 100, 0, 15, 25220, 0, 0, 41, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Civilian Recruit - On Reached WP15 - Despawn'),
(2522000, 9, 0, 0, 0, 0, 100, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 19, 25222, 0, 0, 0, 0, 0, 0, 'Civilian Recruit - Script 1 - Say'),
(2522000, 9, 1, 0, 0, 0, 100, 0, 7000, 7000, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Civilian Recruit - Scrip 2 - Say'),
(2522000, 9, 2, 0, 0, 0, 100, 0, 6000, 7000, 0, 0, 1, 1, 0, 0, 0, 0, 0, 19, 25222, 0, 0, 0, 0, 0, 0, 'Civilian Recruit - Script 2 - Say'),
(2522000, 9, 3, 0, 0, 0, 100, 0, 0, 0, 0, 0, 71, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Civilian Recruit - Script 2 - Equip Items'),
(2522000, 9, 4, 0, 0, 0, 100, 0, 2000, 2000, 0, 0, 65, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Civilian Recruit - Script 2 - Resume WP'),
(2522000, 9, 5, 0, 0, 0, 100, 0, 4000, 5000, 0, 0, 1, 3, 0, 0, 0, 0, 0, 19, 25222, 0, 0, 0, 0, 0, 0, 'Civilian Recruit - Script 2 - Say'),
(2522001, 9, 0, 0, 0, 0, 100, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 19, 25222, 0, 0, 0, 0, 0, 0, 'Civilian Recruit - Script 1 - Say'),
(2522001, 9, 1, 0, 0, 0, 100, 0, 7000, 7000, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Civilian Recruit - Scrip 2 - Say'),
(2522001, 9, 2, 0, 0, 0, 100, 0, 6000, 7000, 0, 0, 1, 2, 0, 0, 0, 0, 0, 19, 25222, 0, 0, 0, 0, 0, 0, 'Civilian Recruit - Script 3 - Say'),
(2522001, 9, 3, 0, 0, 0, 100, 0, 0, 0, 0, 0, 71, 0, 0, 2178, 143, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Civilian Recruit - Script 3 - Equip Items'),
(2522001, 9, 4, 0, 0, 0, 100, 0, 2000, 2000, 0, 0, 65, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Civilian Recruit - Script 3 - Resume WP'),
(2522001, 9, 5, 0, 0, 0, 100, 0, 4000, 5000, 0, 0, 1, 3, 0, 0, 0, 0, 0, 19, 25222, 0, 0, 0, 0, 0, 0, 'Civilian Recruit - Script 2 - Say');

-- Civilian Recruit Scripts in Building
DELETE FROM `creature_addon` WHERE `guid` = 117789;
INSERT INTO `creature_addon` (`guid`, `path_id`, `mount`, `bytes1`, `bytes2`, `emote`, `auras`) VALUES 
(117789, 0, 0, 3, 0, 0, NULL);

-- Civilian Recruit SAI
SET @GUID := -117794;
UPDATE `creature_template` SET `AIName`="SmartAI" WHERE `entry` = 25317;
DELETE FROM `smart_scripts` WHERE `entryorguid`=@GUID AND `source_type` = 0;
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(@GUID,0,0,0,1,0,100,0,8000,8000,12000,12000,5,36,0,0,0,0,0,1,0,0,0,0,0,0,0,'Civilian Recruit - Out of Combat - Play Emote 36'),
(@GUID,0,1,0,1,0,100,0,35000,40000,35000,40000,80,11779400,0,0,0,0,0,1,0,0,0,0,0,0,0,'Civilian Recruit - Out of Combat - Run Script');

-- Actionlist SAI
SET @ENTRY := 11779400;
DELETE FROM `smart_scripts` WHERE `entryorguid`=@ENTRY AND `source_type` = 9;
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(@ENTRY,9,0,0,0,0,100,0,2000,2000,0,0,1,1,6000,0,0,0,0,1,0,0,0,0,0,0,0,'Civilian Recruit - On Script - Say Line 1'),
(@ENTRY,9,1,0,0,0,100,0,6000,6000,0,0,1,2,6000,0,0,0,0,10,117790,25317,0,0,0,0,0,'Civilian Recruit - On Script - Say Line 2'),
(@ENTRY,9,2,0,0,0,100,0,6000,6000,0,0,1,3,6000,0,0,0,0,1,0,0,0,0,0,0,0,'Civilian Recruit - On Script - Say Line 3');

-- Civilian Recruit SAI
SET @GUID := -117788;
UPDATE `creature_template` SET `AIName`="SmartAI" WHERE `entry` = 25317;
DELETE FROM `smart_scripts` WHERE `entryorguid`=@GUID AND `source_type` = 0;
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(@GUID,0,0,0,1,0,100,0,8000,8000,12000,12000,5,36,0,0,0,0,0,1,0,0,0,0,0,0,0,'Civilian Recruit - Out of Combat - Play Emote 36'),
(@GUID,0,1,0,1,0,100,0,35000,40000,35000,40000,80,11778800,0,0,0,0,0,1,0,0,0,0,0,0,0,'Civilian Recruit - Out of Combat - Run Script');

-- Actionlist SAI
SET @ENTRY := 11778800;
DELETE FROM `smart_scripts` WHERE `entryorguid`=@ENTRY AND `source_type` = 9;
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(@ENTRY,9,0,0,0,0,100,0,2000,2000,0,0,1,1,6000,0,0,0,0,1,0,0,0,0,0,0,0,'Civilian Recruit - On Script - Say Line 1'),
(@ENTRY,9,1,0,0,0,100,0,6000,6000,0,0,1,2,6000,0,0,0,0,10,117789,25317,0,0,0,0,0,'Civilian Recruit - On Script - Say Line 2'),
(@ENTRY,9,2,0,0,0,100,0,6000,6000,0,0,1,3,6000,0,0,0,0,1,0,0,0,0,0,0,0,'Civilian Recruit - On Script - Say Line 3');


DELETE FROM `creature_text` WHERE `CreatureID`=25317 AND `GroupID` >= 1;
INSERT INTO `creature_text` (`CreatureID`, `GroupID`, `ID`, `Text`, `Type`, `Language`, `Probability`, `Emote`, `Duration`, `Sound`, `BroadcastTextId`, `comment`) VALUES
-- First text
(25317, 1, 0, 'This is harder than it looks.', 12, 7, 100, 0, 0, 0, 26488, 'Civilian Recruit'),
(25317, 1, 1, 'Did that seem okay?', 12, 7, 100, 0, 0, 0, 26487, 'Civilian Recruit'),
(25317, 1, 2, 'My arm is getting sore.', 12, 7, 100, 0, 0, 0, 26491, 'Civilian Recruit'),
(25317, 1, 3, 'Hmm....', 12, 7, 100, 0, 0, 0, 26492, 'Civilian Recruit'),
(25317, 1, 4, 'I think I\'m starting to get the hang of this.', 12, 7, 100, 0, 0, 0, 26490, 'Civilian Recruit'),
(25317, 1, 5, 'This isn\'t easy.', 12, 7, 100, 0, 0, 0, 26489, 'Civilian Recruit'),
-- reaction
(25317, 2, 0, 'You aren\'t going to let me sleep are you?', 12, 7, 100, 0, 0, 0, 26497, 'Civilian Recruit'),
(25317, 2, 1, 'Are you going to be doing this for much longer?', 12, 7, 100, 0, 0, 0, 26502, 'Civilian Recruit'),
(25317, 2, 2, 'Could you try to be a little quieter?', 12, 7, 100, 0, 0, 0, 26500, 'Civilian Recruit'),
-- reaction 2
(25317, 3, 0, 'I just don\'t want to let anyone down.', 12, 7, 100, 0, 0, 0, 26494, 'Civilian Recruit'),
(25317, 3, 1, 'I need to do something to keep myself busy.', 12, 7, 100, 0, 0, 0, 26495, 'Civilian Recruit'),
(25317, 3, 2, 'I\'m just nervous.  Sorry.', 12, 7, 100, 0, 0, 0, 26493, 'Civilian Recruit');

DELETE FROM `creature_equip_template` WHERE `CreatureID` IN (25317, 25220);
UPDATE `creature` SET `equipment_id`=0 WHERE `id` = 25317;


--
-- END UPDATING QUERIES
--
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
