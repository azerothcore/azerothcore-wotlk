-- DB update 2019_04_05_01 -> 2019_04_05_02
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2019_04_05_01';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2019_04_05_01 2019_04_05_02 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1554419361319456000'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1554419361319456000');

DELETE FROM `creature_text` WHERE `creatureid`=25514; 
INSERT INTO `creature_text` (`creatureid`, `groupid`, `id`, `text`, `type`, `language`, `probability`, `emote`, `duration`, `sound`, `BroadcastTextId`, `TextRange`, `comment`) VALUES
(25514,0,0,'Frozen and destroyed. This is all your fleshy corpse is good for.',12,0,100,0,0,0,24727,0,'Rocknar'),
(25514,0,1,'You are not welcome here. Die!',12,0,100,0,0,0,24728,0,'Rocknar'),
(25514,0,2,'Your presence unbalances the land. You must be removed!',12,0,100,0,0,0,24729,0,'Rocknar');

-- Rocknar SAI
SET @ENTRY := 25514;
UPDATE `creature_template` SET `AIName`="SmartAI" WHERE `entry`=@ENTRY;
DELETE FROM `smart_scripts` WHERE `entryorguid`=@ENTRY AND `source_type`=0;
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(@ENTRY,0,0,1,25,0,100,0,0,0,0,0,11,42617,0,0,0,0,0,1,0,0,0,0,0,0,0,'Rocknar - On Reset - Cast ''Vertex Color Lt. Blue'''),
(@ENTRY,0,1,0,21,0,100,1,0,0,0,0,11,45776,0,0,0,0,0,1,0,0,0,0,0,0,0,'Rocknar - On Reached Home - Cast ''Ice Block'' (No Repeat)'),
(@ENTRY,0,2,3,4,0,100,0,0,0,0,0,1,0,0,0,0,0,0,1,0,0,0,0,0,0,0,'Rocknar - On Aggro - Say Line 0'),
(@ENTRY,0,3,0,61,0,100,0,0,0,0,0,28,45776,0,0,0,0,0,1,0,0,0,0,0,0,0,'Rocknar - On Aggro - Remove Aura ''Ice Block'''),
(@ENTRY,0,4,0,0,0,100,0,0,3000,8000,10000,11,50094,0,0,0,0,0,2,0,0,0,0,0,0,0,'Rocknar - In Combat - Cast ''Ice Spike'''),
(@ENTRY,0,5,0,11,0,100,1,0,0,0,0,11,45776,0,0,0,0,0,1,0,0,0,0,0,0,0,'Rocknar - On Respawn - Cast ''Ice Block'' (No Repeat)'),
(@ENTRY,0,6,0,0,0,100,0,4000,7000,14000,16000,11,22693,0,0,0,0,0,1,0,0,0,0,0,0,0,'Rocknar - In Combat - Cast ''Harden Skin''');

DELETE FROM `creature_text` WHERE `creatureid`=25467;
INSERT INTO `creature_text` (`creatureid`, `groupid`, `id`, `text`, `type`, `language`, `probability`, `emote`, `duration`, `sound`, `BroadcastTextId`, `TextRange`, `comment`) VALUES
(25467,0,0,'No hurt the lifegiver!',12,0,100,0,4000,0,24689,0,'Bloodspore Harvester'),
(25467,0,1,'Protect lifegiver!',12,0,100,0,4000,0,24691,0,'Bloodspore Harvester'),
(25467,0,2,'No touch spores!',12,0,100,0,4000,0,24690,0,'Bloodspore Harvester');

-- Bloodspore Harvester SAI
SET @ENTRY := 25467;
UPDATE `creature_template` SET `AIName`='SmartAI' WHERE `entry`=@ENTRY;
DELETE FROM `smart_scripts` WHERE `entryorguid`=@ENTRY AND `source_type`=0;
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(@ENTRY,0,0,0,25,0,100,0,0,0,0,0,11,45987,0,0,0,0,0,1,0,0,0,0,0,0,0,'Bloodspore Harvester - On Reset - Cast ''Bloodspore Malaise'''),
(@ENTRY,0,1,0,0,0,100,0,3000,6000,10000,13000,11,50380,0,0,0,0,0,2,0,0,0,0,0,0,0,'Bloodspore Harvester - In Combat - Cast ''Bloodspore Haze'''),
(@ENTRY,0,2,0,4,0,33,0,0,0,0,0,1,0,0,0,0,0,0,1,0,0,0,0,0,0,0,'Bloodspore Harvester - On Aggro - Say Line 0');

DELETE FROM `creature_text` WHERE `creatureid`=25468;
INSERT INTO `creature_text` (`creatureid`, `groupid`, `id`, `text`, `type`, `language`, `probability`, `emote`, `duration`, `sound`, `BroadcastTextId`, `TextRange`, `comment`) VALUES
(25468,0,0,'No hurt the lifegiver!',12,0,100,0,4000,0,24689,0,'Bloodspore Roaster'),
(25468,0,1,'Protect lifegiver!',12,0,100,0,4000,0,24691,0,'Bloodspore Roaster'),
(25468,0,2,'No touch spores!',12,0,100,0,4000,0,24690,0,'Bloodspore Roaster');

-- Bloodspore Roaster SAI
SET @ENTRY := 25468;
UPDATE `creature_template` SET `AIName`='SmartAI' WHERE `entry`=@ENTRY;
DELETE FROM `smart_scripts` WHERE `entryorguid`=@ENTRY AND `source_type`=0;
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(@ENTRY,0,0,0,1,0,100,0,1000,6000,10000,15000,11,45986,0,0,0,0,0,1,0,0,0,0,0,0,0,'Bloodspore Roaster - Out of Combat - Cast ''Spore Roast'''),
(@ENTRY,0,1,0,0,0,100,0,1000,4000,13000,15000,11,50402,0,0,0,0,0,2,0,0,0,0,0,0,0,'Bloodspore Roaster - In Combat - Cast ''Roast'''),
(@ENTRY,0,2,0,4,0,33,0,0,0,0,0,1,0,0,0,0,0,0,1,0,0,0,0,0,0,0,'Bloodspore Roaster - On Aggro - Say Line 0');

DELETE FROM `creature_text` WHERE `creatureid`=25470;
INSERT INTO `creature_text` (`creatureid`, `groupid`, `id`, `text`, `type`, `language`, `probability`, `emote`, `duration`, `sound`, `BroadcastTextId`, `TextRange`, `comment`) VALUES
(25470,0,0,'No hurt the lifegiver!',12,0,100,0,4000,0,24689,0,'Bloodspore Firestarter'),
(25470,0,1,'Protect lifegiver!',12,0,100,0,4000,0,24691,0,'Bloodspore Firestarter'),
(25470,0,2,'No touch spores!',12,0,100,0,4000,0,24690,0,'Bloodspore Firestarter'),
(25470,1,3,'Protect lifegiver!',14,0,100,0,4000,0,24691,0,'Bloodspore Firestarter');

-- Bloodspore Firestarter SAI
SET @ENTRY := 25470;
UPDATE `creature_template` SET `AIName`="SmartAI" WHERE `entry`=@ENTRY;
DELETE FROM `smart_scripts` WHERE `entryorguid`=@ENTRY AND `source_type`=0;
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(@ENTRY,0,0,0,1,0,100,0,1000,1000,600000,600000,11,45985,1,0,0,0,0,1,0,0,0,0,0,0,0,"Bloodspore Firestarter - Out of Combat - Cast 'Flaming Touch'"),
(@ENTRY,0,1,0,0,0,100,0,0,0,3800,6200,11,20793,0,0,0,0,0,2,0,0,0,0,0,0,0,"Bloodspore Firestarter - In Combat - Cast 'Fireball'"),
(@ENTRY,0,2,0,4,0,33,0,0,0,0,0,1,0,0,0,0,0,0,1,0,0,0,0,0,0,0,"Bloodspore Firestarter - On Aggro - Say Line 0"),
(@ENTRY,0,3,0,1,0,33,0,1000,300000,300000,600000,1,1,0,0,0,0,0,1,0,0,0,0,0,0,0,"Bloodspore Firestarter - Out of Combat - Say Line 1");

-- Bloodspore Moth
UPDATE `creature_template` SET `InhabitType`=4 WHERE `entry`=25464;

-- D.E.H.T.A. Enforcer
UPDATE `creature_template` SET `InhabitType`=4 WHERE `entry`=25819;
UPDATE `creature` SET `MovementType`=0, `spawndist`=0 WHERE `id`=25819;

SET @NPC:=132984;
UPDATE `creature` SET `spawndist`=0,`MovementType`=2 WHERE `guid`=@NPC;
DELETE FROM `creature_addon` WHERE `guid`=@NPC;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes1`,`bytes2`,`emote`,`auras`) VALUES (@NPC,1329840,0,0,0,0, '');
DELETE FROM `waypoint_data` WHERE `id`=1329840;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`orientation`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
(1329840,1,3197.389, 5262.509, 59.1744, 5.665670,0,0,0,100,0),
(1329840,2,3205.473, 5261.450, 59.1744, 0.418089,0,0,0,100,0),
(1329840,3,3213.649, 5266.860, 59.1744, 0.630147,0,0,0,100,0),
(1329840,4,3220.222, 5276.440, 59.1744, 1.021275,0,0,0,100,0),
(1329840,5,3219.638, 5285.621, 59.1744, 1.939406,0,0,0,100,0),
(1329840,6,3211.313, 5295.542, 59.1744, 2.873245,0,0,0,100,0),
(1329840,7,3199.114, 5292.031, 59.1744, 3.573035,0,0,0,100,0),
(1329840,8,3193.253, 5282.330, 59.1744, 4.762128,0,0,0,100,0),
(1329840,9,3195.002, 5273.082, 59.1744, 4.700867,0,0,0,100,0);

--
-- END UPDATING QUERIES
--
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
