-- DB update 2019_04_09_00 -> 2019_04_11_00
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2019_04_09_00';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2019_04_09_00 2019_04_11_00 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1554847609374764694'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1554847609374764694');

-- Shadowmoon Darkweaver
UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 22081;
DELETE FROM `smart_scripts` WHERE `entryorguid` = 22081 AND `source_type` = 0;
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`event_param5`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_param4`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`)
VALUES
(22081,0,0,0,0,0,100,0,0,0,3000,5000,0,11,9613,64,0,0,0,0,2,0,0,0,0,0,0,0,0,'Shadowmoon Darkweaver - In Combat - Cast ''Shadow Bolt'''),
(22081,0,1,0,9,0,100,0,0,30,15000,18000,0,11,11962,0,0,0,0,0,2,0,0,0,0,0,0,0,0,'Shadowmoon Darkweaver - Within 0-30 Range - Cast ''Immolate'''),
(22081,0,2,0,9,0,100,0,0,10,8000,11000,0,11,35373,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Shadowmoon Darkweaver - Within 0-10 Range - Cast ''Shadowfury''');

UPDATE `creature_template_addon` SET `emote` = 468, `auras` = '38442' WHERE `entry` = 22081;
DELETE FROM `creature_addon` WHERE `guid` IN (77374,77375,77376,77379,77380,77381,77382,77383,77384,77387,77389,77390,77391,77392,77393,77394);

-- Shadowmoon Chosen
UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 22084;
DELETE FROM `smart_scripts` WHERE `entryorguid` = 22084 AND `source_type` = 0;
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`event_param5`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_param4`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`)
VALUES
(22084,0,0,0,9,0,100,0,0,5,15000,17000,0,11,38618,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Shadowmoon Chosen - Within 0-5 Range - Cast ''Whirlwind'''),
(22084,0,1,0,0,0,100,0,8000,10000,18000,22000,0,11,10966,0,0,0,0,0,2,0,0,0,0,0,0,0,0,'Shadowmoon Chosen - In Combat - Cast ''Uppercut''');

-- Shadowmoon Slayer
UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 22082;
DELETE FROM `smart_scripts` WHERE `entryorguid` = 22082 AND `source_type` = 0;
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`event_param5`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_param4`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`)
VALUES
(22082,0,0,1,2,0,100,1,0,30,0,0,0,11,3019,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Shadowmoon Slayer - Between 0-30% Health - Cast ''Frenzy'''),
(22082,0,1,0,61,0,100,1,0,0,0,0,0,1,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Shadowmoon Slayer - Between 0-30% Health - Say Line 0'),
(22082,0,2,0,0,0,100,0,5000,7000,12000,15000,0,11,37577,0,0,0,0,0,2,0,0,0,0,0,0,0,0,'Shadowmoon Slayer - In Combat - Cast ''Debilitating Strike''');

-- Shadowsworn Drakonid
UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 22072;
DELETE FROM `smart_scripts` WHERE `entryorguid` = 22072 AND `source_type` = 0;
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`event_param5`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_param4`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`)
VALUES
(22072,0,0,0,0,0,100,0,5000,7000,11000,13000,0,11,15496,0,0,0,0,0,2,0,0,0,0,0,0,0,0,'Shadowsworn Drakonid - In Combat - Cast ''Cleave'''),
(22072,0,1,0,0,0,100,0,6000,8000,14000,16000,0,11,17547,0,0,0,0,0,2,0,0,0,0,0,0,0,0,'Shadowsworn Drakonid - In Combat - Cast ''Mortal Strike'''),
(22072,0,2,0,0,0,100,0,9000,11000,18000,22000,0,11,16145,0,0,0,0,0,2,0,0,0,0,0,0,0,0,'Shadowsworn Drakonid - In Combat - Cast ''Sunder Armor''');

-- Shadowmoon Soulstealer
UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 22061;
DELETE FROM `smart_scripts` WHERE `entryorguid` = 22061 AND `source_type` = 0;
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`event_param5`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_param4`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`)
VALUES
(22061,0,0,1,25,0,100,0,0,0,0,0,0,8,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Shadowmoon Soulstealer - On Reset - Set Reactstate Passive'),
(22061,0,1,0,61,0,100,0,0,0,0,0,0,11,38250,0,0,0,0,0,19,22058,100,0,0,0,0,0,0,'Shadowmoon Soulstealer - Linked - Cast spell'),
(22061,0,2,0,4,0,100,0,0,0,0,0,0,11,38250,0,0,0,0,0,19,22058,100,0,0,0,0,0,0,'Shadowmoon Soulstealer - On Aggro - Cast ''Heart of Fury Siphon'''),
(22061,0,3,0,4,0,100,0,0,0,0,0,0,45,1,1,0,0,0,0,19,22006,100,0,0,0,0,0,0,'Shadowmoon Soulstealer - On Aggro - Set Data 1 1 to Shadowlord Deathwail'),
(22061,0,4,0,6,0,100,0,0,0,0,0,0,45,2,2,0,0,0,0,19,22006,100,0,0,0,0,0,0,'Shadowmoon Soulstealer - On Just Died - Set Data 2 2 to Shadowlord Deathwail');

-- Shadowmoon Retainer
UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 22102;
DELETE FROM `smart_scripts` WHERE `entryorguid` = 22102 AND `source_type` = 0;
DELETE FROM `smart_scripts` WHERE `entryorguid` IN (2210200,2210201,2210202,2210203,2210204) AND `source_type` = 9;
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`event_param5`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_param4`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`)
VALUES
(22102,0,0,0,0,0,100,0,0,0,2000,4000,0,11,15547,64,0,0,0,0,2,0,0,0,0,0,0,0,0,'Shadowmoon Retainer - In Combat - Cast ''Shoot'''),
(22102,0,1,0,17,0,100,0,0,0,0,0,0,64,1,0,0,0,0,0,7,0,0,0,0,0,0,0,0,'Shadowmoon Retainer - On Summoned Unit - Store Targetlist'),
(22102,0,2,0,38,0,100,0,1,1,0,0,0,80,2210200,2,0,0,0,0,1,0,0,0,0,0,0,0,0,'Shadowmoon Retainer - On Data Set - Run Script'),
(22102,0,3,0,38,0,100,0,1,2,0,0,0,80,2210201,2,0,0,0,0,1,0,0,0,0,0,0,0,0,'Shadowmoon Retainer - On Data Set - Run Script'),
(22102,0,4,0,38,0,100,0,1,3,0,0,0,80,2210202,2,0,0,0,0,1,0,0,0,0,0,0,0,0,'Shadowmoon Retainer - On Data Set - Run Script'),
(22102,0,5,0,38,0,100,0,1,4,0,0,0,80,2210203,2,0,0,0,0,1,0,0,0,0,0,0,0,0,'Shadowmoon Retainer - On Data Set - Run Script'),
(22102,0,6,0,38,0,100,0,1,5,0,0,0,80,2210204,2,0,0,0,0,1,0,0,0,0,0,0,0,0,'Shadowmoon Retainer - On Data Set - Run Script'),
(22102,0,7,0,38,0,100,0,2,1,0,0,0,29,0,150,0,0,0,0,23,0,0,0,0,0,0,0,0,'Shadowmoon Retainer - On Data Set - Start Follow'),
(22102,0,8,0,38,0,100,0,2,2,0,0,0,29,0,210,0,0,0,0,23,0,0,0,0,0,0,0,0,'Shadowmoon Retainer - On Data Set - Start Follow'),
(2210200,9,0,0,0,0,100,0,0,0,0,0,0,12,22102,3,180000,0,0,0,8,0,0,0,0,-3214.73,251.193,139.047,2.36666,'Shadowmoon Retainer - On Script - Summon Creature ''Shadowmoon Retainer'''),
(2210200,9,1,0,0,0,100,0,0,0,0,0,0,45,2,1,0,0,0,0,12,1,0,0,0,0,0,0,0,'Shadowmoon Retainer - On Script - Set Data'),
(2210200,9,2,0,0,0,100,0,0,0,0,0,0,12,22102,3,180000,0,0,0,8,0,0,0,0,-3212.19,253.787,139.047,2.36666,'Shadowmoon Retainer - On Script - Summon Creature ''Shadowmoon Retainer'''),
(2210200,9,3,0,0,0,100,0,0,0,0,0,0,45,2,2,0,0,0,0,12,1,0,0,0,0,0,0,0,'Shadowmoon Retainer - On Script - Set Data'),
(2210200,9,4,0,0,0,100,0,0,0,0,0,0,53,1,2210200,0,0,0,2,1,0,0,0,0,0,0,0,0,'Shadowmoon Retainer - On Script - Start Waypoint'),
(2210201,9,0,0,0,0,100,0,0,0,0,0,0,12,22102,3,180000,0,0,0,8,0,0,0,0,-3214.73,251.193,139.047,2.36666,'Shadowmoon Retainer - On Script - Summon Creature ''Shadowmoon Retainer'''),
(2210201,9,1,0,0,0,100,0,0,0,0,0,0,45,2,1,0,0,0,0,12,1,0,0,0,0,0,0,0,'Shadowmoon Retainer - On Script - Set Data'),
(2210201,9,2,0,0,0,100,0,0,0,0,0,0,12,22102,3,180000,0,0,0,8,0,0,0,0,-3212.19,253.787,139.047,2.36666,'Shadowmoon Retainer - On Script - Summon Creature ''Shadowmoon Retainer'''),
(2210201,9,3,0,0,0,100,0,0,0,0,0,0,45,2,2,0,0,0,0,12,1,0,0,0,0,0,0,0,'Shadowmoon Retainer - On Script - Set Data'),
(2210201,9,4,0,0,0,100,0,0,0,0,0,0,53,1,2210201,0,0,0,2,1,0,0,0,0,0,0,0,0,'Shadowmoon Retainer - On Script - Start Waypoint'),
(2210202,9,0,0,0,0,100,0,0,0,0,0,0,12,22102,3,180000,0,0,0,8,0,0,0,0,-3259.99,257.488,137.045,1.23791,'Shadowmoon Retainer - On Script - Summon Creature ''Shadowmoon Retainer'''),
(2210202,9,1,0,0,0,100,0,0,0,0,0,0,45,2,1,0,0,0,0,12,1,0,0,0,0,0,0,0,'Shadowmoon Retainer - On Script - Set Data'),
(2210202,9,2,0,0,0,100,0,0,0,0,0,0,12,22102,3,180000,0,0,0,8,0,0,0,0,-3256.09,256.141,137.077,1.23791,'Shadowmoon Retainer - On Script - Summon Creature ''Shadowmoon Retainer'''),
(2210202,9,3,0,0,0,100,0,0,0,0,0,0,45,2,2,0,0,0,0,12,1,0,0,0,0,0,0,0,'Shadowmoon Retainer - On Script - Set Data'),
(2210202,9,4,0,0,0,100,0,0,0,0,0,0,53,0,2210202,0,0,0,2,1,0,0,0,0,0,0,0,0,'Shadowmoon Retainer - On Script - Start Waypoint'),
(2210203,9,0,0,0,0,100,0,0,0,0,0,0,12,22102,3,180000,0,0,0,8,0,0,0,0,-3247.74,348.919,127.443,0.0959725,'Shadowmoon Retainer - On Script - Summon Creature ''Shadowmoon Retainer'''),
(2210203,9,1,0,0,0,100,0,0,0,0,0,0,45,2,1,0,0,0,0,12,1,0,0,0,0,0,0,0,'Shadowmoon Retainer - On Script - Set Data'),
(2210203,9,2,0,0,0,100,0,0,0,0,0,0,12,22102,3,180000,0,0,0,8,0,0,0,0,-3247.61,344.952,127.443,0.0959725,'Shadowmoon Retainer - On Script - Summon Creature ''Shadowmoon Retainer'''),
(2210203,9,3,0,0,0,100,0,0,0,0,0,0,45,2,2,0,0,0,0,12,1,0,0,0,0,0,0,0,'Shadowmoon Retainer - On Script - Set Data'),
(2210203,9,4,0,0,0,100,0,0,0,0,0,0,53,0,2210203,0,0,0,2,1,0,0,0,0,0,0,0,0,'Shadowmoon Retainer - On Script - Start Waypoint'),
(2210204,9,0,0,0,0,100,0,0,0,0,0,0,12,22102,3,180000,0,0,0,8,0,0,0,0,-3247.74,348.919,127.443,0.0959725,'Shadowmoon Retainer - On Script - Summon Creature ''Shadowmoon Retainer'''),
(2210204,9,1,0,0,0,100,0,0,0,0,0,0,45,2,1,0,0,0,0,12,1,0,0,0,0,0,0,0,'Shadowmoon Retainer - On Script - Set Data'),
(2210204,9,2,0,0,0,100,0,0,0,0,0,0,12,22102,3,180000,0,0,0,8,0,0,0,0,-3247.61,344.952,127.443,0.0959725,'Shadowmoon Retainer - On Script - Summon Creature ''Shadowmoon Retainer'''),
(2210204,9,3,0,0,0,100,0,0,0,0,0,0,45,2,2,0,0,0,0,12,1,0,0,0,0,0,0,0,'Shadowmoon Retainer - On Script - Set Data'),
(2210204,9,4,0,0,0,100,0,0,0,0,0,0,53,0,2210204,0,0,0,2,1,0,0,0,0,0,0,0,0,'Shadowmoon Retainer - On Script - Start Waypoint');

DELETE FROM `waypoints` WHERE `entry` IN (2210200,2210201,2210202,2210203,2210204);
INSERT INTO `waypoints` (`entry`,`pointid`,`position_x`,`position_y`,`position_z`,`point_comment`)
VALUES
(2210200,1,-3243.46,281.49,137.111,''),
(2210200,2,-3241.79,298.108,137.055,''),
(2210200,3,-3258.93,306.993,136.986,''),
(2210200,4,-3269.23,294.214,136.989,''),
(2210200,5,-3265.87,279.522,137.01,''),
(2210200,6,-3243.46,281.49,137.111,''),
(2210200,7,-3220.84,303.139,137.045,''),
(2210201,1,-3243.46,281.49,137.111,''),
(2210201,2,-3241.79,298.108,137.055,''),
(2210201,3,-3258.93,306.993,136.986,''),
(2210201,4,-3269.23,294.214,136.989,''),
(2210201,5,-3263.77,268.623,137.019,''),
(2210201,6,-3254.17,266.099,137.088,''),
(2210201,7,-3248.72,278.363,137.108,''),
(2210202,1,-3243.46,281.49,137.111,''),
(2210202,2,-3228.1,292.874,137.111,''),
(2210203,1,-3240.07,346.884,127.5,''),
(2210203,2,-3230.84,332.969,128.183,''),
(2210203,3,-3230.15,308.479,136.995,''),
(2210203,4,-3243.53,293.283,137.067,''),
(2210203,5,-3243,278.767,137.121,''),
(2210203,6,-3253.34,265.224,137.095,''),
(2210203,7,-3266.03,269.369,137,''),
(2210203,8,-3270.26,295.106,136.985,''),
(2210203,9,-3256.06,301.488,137.038,''),
(2210203,10,-3251.09,292.567,137.079,''),
(2210204,1,-3240.07,346.884,127.5,''),
(2210204,2,-3230.84,332.969,128.183,''),
(2210204,3,-3230.15,308.479,136.995,''),
(2210204,4,-3241.79,298.108,137.055,''),
(2210204,5,-3258.93,306.993,136.986,''),
(2210204,6,-3269.23,294.214,136.989,''),
(2210204,7,-3264.68,284.52,137.014,''),
(2210204,8,-3258.65,285.294,137.031,'');

-- Heart of Fury
UPDATE `creature_template_addon` SET `auras` = '38376' WHERE `entry` = 22058;

DELETE FROM `conditions` WHERE `SourceEntry` = 38250 AND `SourceTypeOrReferenceId` = 13;
INSERT INTO conditions (`SourceTypeOrReferenceId`,`SourceGroup`,`SourceEntry`,`SourceId`,`ElseGroup`,`ConditionTypeOrReference`,`ConditionTarget`,`ConditionValue1`,`ConditionValue2`,`ConditionValue3`,`NegativeCondition`,`ErrorType`,`ErrorTextId`,`ScriptName`,`comment`)
VALUES
(13,1,38250,0,0,31,0,3,22058,0,0,0,0,'','Heart of Fury Siphon - target ''Heart of Fury Visual Trigger''');

-- Shadowlord Deathwail
UPDATE `creature` SET `position_x` = -3225.12, `position_y` = 246.817, `position_z` = 195.679, `orientation` = 4.87723, `spawndist` = 0, `MovementType` = 0 WHERE `guid` = 77084;

UPDATE `creature_template` SET `InhabitType` = 7, `AIName` = 'SmartAI' WHERE `entry` = 22006;

DELETE FROM `waypoints` WHERE `entry` = 220060;
INSERT INTO `waypoints`
(`entry`,`pointid`,`position_x`,`position_y`,`position_z`,`point_comment`)
VALUES
(220060,1,-3225.12,246.817,195.679,''),
(220060,2,-3240.03,255.9,201.579,''),
(220060,3,-3257.98,269.678,201.579,''),
(220060,4,-3274.72,279.532,201.579,''),
(220060,5,-3285.86,310.516,201.579,''),
(220060,6,-3275.1,325.252,201.579,''),
(220060,7,-3254.87,341.812,201.579,''),
(220060,8,-3227.61,331.076,201.579,''),
(220060,9,-3218.13,316.963,201.579,''),
(220060,10,-3217.59,298.951,201.579,''),
(220060,11,-3217.09,283.996,201.579,''),
(220060,12,-3207.64,260.908,203.19,''),
(220060,13,-3212.76,247.542,203.19,''),
(220060,14,-3220.4,239.538,203.19,''),
(220060,15,-3252.73,239.407,172.163,''),
(220060,16,-3266.67,280.529,161.968,''),
(220060,17,-3237.02,300.281,161.968,''),
(220060,18,-3205.82,285.144,183.413,''),
(220060,19,-3205.76,262.642,184.707,''),
(220060,20,-3213.83,246.444,194.429,'');

DELETE FROM `smart_scripts` WHERE `entryorguid` = 22006 AND `source_type` = 0;
DELETE FROM `smart_scripts` WHERE `entryorguid` = 2200600 AND `source_type` = 9;
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`event_param5`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_param4`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`)
VALUES
(22006,0,0,1,25,0,100,0,0,0,0,0,0,53,1,220060,1,0,0,0,1,0,0,0,0,0,0,0,0,'Shadowlord Deathwail - On Reset - Start Waypoint Movement'),
(22006,0,1,2,61,0,100,0,0,0,0,0,0,18,2,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Shadowlord Deathwail - Linked - Set Unit Flag ''Non Attackable'''),
(22006,0,2,0,61,0,100,0,0,0,0,0,0,8,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Shadowlord Deathwail - Linked - Set React State Passive'),
(22006,0,3,0,6,4,100,0,0,0,0,0,0,1,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Shadowlord Deathwail - On Just Died - Say Line 0 (Phase 3)'),
(22006,0,4,0,0,4,100,0,0,0,3000,5000,0,11,12471,64,0,0,0,0,2,0,0,0,0,0,0,0,0,'Shadowlord Deathwail - In Combat - Cast ''Shadow Bolt'' (Phase 3)'),
(22006,0,5,0,0,4,100,0,5000,7000,15000,17000,0,11,15245,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Shadowlord Deathwail - In Combat - Cast ''Shadow Bolt Volley'' (Phase 3)'),
(22006,0,6,0,0,4,100,0,9000,12000,18000,24000,0,11,32709,0,0,0,0,0,5,0,0,0,0,0,0,0,0,'Shadowlord Deathwail - In Combat - Cast ''Death Coil'' (Phase 3)'),
(22006,0,7,0,0,4,100,0,14000,17000,22000,28000,0,11,27641,0,0,0,0,0,5,0,0,0,0,0,0,0,0,'Shadowlord Deathwail - In Combat - Cast ''Fear'' (Phase 3)'),
(22006,0,8,0,17,0,100,0,0,0,0,0,0,64,1,0,0,0,0,0,7,0,0,0,0,0,0,0,0,'Shadowlord Deathwail - On Summoned Unit - Store Targetlist'),
(22006,0,9,10,38,0,100,1,1,1,0,0,0,22,1,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Shadowlord Deathwail - On Data Set 1 1 - Set Event Phase 1 (No Repeat)'),
(22006,0,10,0,61,0,100,0,0,0,0,0,0,80,2200600,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Shadowlord Deathwail - Linked - Run Script'),
(22006,0,11,0,1,1,100,0,5000,5000,5000,5000,0,11,38312,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Shadowlord Deathwail - Out of Combat - Cast ''Fel Fireball'' (Phase 1)'),
(22006,0,12,0,0,1,100,0,5000,5000,5000,5000,0,11,38312,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Shadowlord Deathwail - In Combat - Cast ''Fel Fireball'' (Phase 1)'),
(22006,0,13,14,38,0,100,1,2,2,0,0,0,18,768,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Shadowlord Deathwail - On Data Set 2 2 - Set Unit Flags ''Immune To Player'' & ''Immune To NPC'' (No Repeat)'),
(22006,0,14,15,61,0,100,0,0,0,0,0,0,22,2,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Shadowlord Deathwail - Linked - Set Event Phase 2'),
(22006,0,15,16,61,0,100,0,0,0,0,0,0,1,1,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Shadowlord Deathwail - Linked - Say Line 1'),
(22006,0,16,0,61,0,100,0,0,0,0,0,0,67,1,6000,6000,0,0,0,8,0,0,0,0,0,0,0,0,'Shadowlord Deathwail - Linked - Create Timed Event ID 1'),
(22006,0,17,0,59,0,100,0,1,0,0,0,0,69,25,0,0,0,0,0,8,0,0,0,0,-3245.43,288.623,137.093,1.72491,'Shadowlord Deathwail - On Timed Event ID 1 - Move to Point 25'),
(22006,0,18,19,34,0,100,0,0,25,0,0,0,54,600000,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Shadowlord Deathwail - On Point 25 Reached - Pause Waypoint Movement'),
(22006,0,19,20,61,0,100,0,0,0,0,0,0,67,2,600000,600000,0,0,0,8,0,0,0,0,0,0,0,0,'Shadowlord Deathwail - Linked - Create Timed Event ID 2'),
(22006,0,20,21,61,0,100,0,0,0,0,0,0,1,2,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Shadowlord Deathwail - Linked - Say Line 2'),
(22006,0,21,22,61,0,100,0,0,0,0,0,0,8,2,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Shadowlord Deathwail - Linked - Set React State Aggressive'),
(22006,0,22,23,61,0,100,0,0,0,0,0,0,41,0,0,0,0,0,0,19,22058,0,0,0,0,0,0,0,'Shadowlord Deathwail - Linked - Despawn Creature ''Heart of Fury Visual Trigger'''),
(22006,0,23,0,61,0,100,0,0,0,0,0,0,41,0,300,0,0,0,0,14,25982,185125,0,0,0,0,0,0,'Shadowlord Deathwail - Linked - Despawn Gameobject ''Heart of Fury'''),
(22006,0,24,25,52,0,100,1,2,0,0,0,0,22,3,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Shadowlord Deathwail - On Text Over - Set Event Phase 3 (No Repeat)'),
(22006,0,25,0,61,0,100,0,0,0,0,0,0,19,770,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Shadowlord Deathwail - Linked - Remove Unit Flags ''Non Attackable'' & ''Immune To Player'' & ''Immune To NPC'''),
(22006,0,26,27,59,0,100,0,2,0,0,0,0,24,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Shadowlord Deathwail - On Timed Event ID 2 - Evade'),
(22006,0,27,0,61,0,100,0,0,0,0,0,0,78,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Shadowlord Deathwail - Linked - Call Script Reset'),
(2200600,9,0,0,0,0,100,0,5000,5000,0,0,0,12,22102,3,180000,0,0,0,8,0,0,0,0,-3214.99,253.727,139.047,2.36666,'Shadowlord Deathwail - On Script - Summon Creature ''Shadowmoon Retainer'''),
(2200600,9,1,0,0,0,100,0,0,0,0,0,0,45,1,1,0,0,0,0,12,1,0,0,0,0,0,0,0,'Shadowlord Deathwail - On Script - Set Data'),
(2200600,9,2,0,0,0,100,0,16000,16000,0,0,0,12,22102,3,180000,0,0,0,8,0,0,0,0,-3214.99,253.727,139.047,2.36666,'Shadowlord Deathwail - On Script - Summon Creature ''Shadowmoon Retainer'''),
(2200600,9,3,0,0,0,100,0,0,0,0,0,0,45,1,2,0,0,0,0,12,1,0,0,0,0,0,0,0,'Shadowlord Deathwail - On Script - Set Data'),
(2200600,9,4,0,0,0,100,0,0,0,0,0,0,12,22102,3,180000,0,0,0,8,0,0,0,0,-3257.27,258.959,137.076,1.1633,'Shadowlord Deathwail - On Script - Summon Creature ''Shadowmoon Retainer'''),
(2200600,9,5,0,0,0,100,0,0,0,0,0,0,45,1,3,0,0,0,0,12,1,0,0,0,0,0,0,0,'Shadowlord Deathwail - On Script - Set Data'),
(2200600,9,6,0,0,0,100,0,10000,10000,0,0,0,12,22102,3,180000,0,0,0,8,0,0,0,0,-3245.69,346.943,127.465,6.26135,'Shadowlord Deathwail - On Script - Summon Creature ''Shadowmoon Retainer'''),
(2200600,9,7,0,0,0,100,0,0,0,0,0,0,45,1,4,0,0,0,0,12,1,0,0,0,0,0,0,0,'Shadowlord Deathwail - On Script - Set Data'),
(2200600,9,8,0,0,0,100,0,30000,30000,0,0,0,12,22102,3,180000,0,0,0,8,0,0,0,0,-3245.69,346.943,127.465,6.26135,'Shadowlord Deathwail - On Script - Summon Creature ''Shadowmoon Retainer'''),
(2200600,9,9,0,0,0,100,0,0,0,0,0,0,45,1,5,0,0,0,0,12,1,0,0,0,0,0,0,0,'Shadowlord Deathwail - On Script - Set Data');

DELETE FROM `creature_text` WHERE `CreatureID` = 22006;
INSERT INTO `creature_text` (`CreatureID`,`GroupID`,`ID`,`Text`,`Type`,`Language`,`Probability`,`Emote`,`Duration`,`Sound`,`BroadcastTextId`,`TextRange`,`comment`)
VALUES
(22006,0,0,'Master... I''ve failed you...',14,0,100,0,0,0,19820,0,'Shadowlord Deathwail'),
(22006,1,0,'You will never get the Heart of Fury!  Its power belongs to Illidan!',14,0,100,0,0,0,19744,0,'Shadowlord Deathwail'),
(22006,2,0,'%s retrieves the Heart of Fury.',16,0,100,0,0,0,19830,0,'Shadowlord Deathwail');

DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId` = 22 AND `SourceEntry` = 22061;
INSERT INTO `conditions` (`SourceTypeOrReferenceId`,`SourceGroup`,`SourceEntry`,`SourceId`,`ElseGroup`,`ConditionTypeOrReference`,`ConditionTarget`,`ConditionValue1`,`ConditionValue2`,`ConditionValue3`,`NegativeCondition`,`ErrorType`,`ErrorTextId`,`ScriptName`,`Comment`)
VALUES
(22,5,22061,0,0,29,1,22061,100,0,1,0,0,'','SAI triggers only if all Shadowmoon Soulstealers are dead');

DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId` = 13 AND `SourceEntry` = 38312;
INSERT INTO `conditions` (`SourceTypeOrReferenceId`,`SourceGroup`,`SourceEntry`,`SourceId`,`ElseGroup`,`ConditionTypeOrReference`,`ConditionTarget`,`ConditionValue1`,`ConditionValue2`,`ConditionValue3`,`NegativeCondition`,`ErrorTextId`,`ScriptName`,`Comment`)
VALUES
(13,7,38312,0,0,31,0,4,0,0,0,0,'','Fel Fireball - target Player');


--
-- END UPDATING QUERIES
--
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
