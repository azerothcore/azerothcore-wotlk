-- DB update 2019_03_26_00 -> 2019_03_26_01
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2019_03_26_00';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2019_03_26_00 2019_03_26_01 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1553536152748153223'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1553536152748153223');

-- Cleanup the complete phasing/auras for all quests related to the Battle for the Undercity
DELETE FROM `spell_area` WHERE `quest_start` IN (13242,13257,13266,13267,13347,13369,13370,13371,13377) OR `quest_end` IN (13242,13257,13266,13267,13347,13369,13370,13371,13377);
INSERT INTO `spell_area` (`spell`,`area`,`quest_start`,`quest_end`,`aura_spell`,`racemask`,`gender`,`autocast`,`quest_start_status`,`quest_end_status`)
VALUES
(60943,4129,13257,0,0,690,2,1,2,0),        -- Warsong Hold - Mod Invisibility Detection (7) - Detect Orgrimmar Portal - Only for Quest "Herald of War"
(60943,1637,13266,0,0,690,2,1,2,0),        -- Orgrimmar - Mod Invisibility Detection (7) - Detect Undercity Portal - Only for Quest "A Life Without Regret"
(60943,1519,13371,0,0,1101,2,1,2,0),       -- Stormwind - Mod Invisibility Detection (7) - Detect Undercity Portal - Only for Quest "The Killing Time"
(60877,1519,13347,13377,0,1101,2,1,74,11), -- Stormwind City - Mod Invisibility Detection (10) - Detect Jaina Proudmoore - From Quest "Reborn From The Ashes" until "Battle for the Undercity"
(59062,14,13257,13267,0,690,2,1,74,11),    -- Durotar - Phasing for the Horde - From Quest "Herald of War" until "Battle for the Undercity"
(59062,1637,13257,13267,0,690,2,1,74,11),  -- Orgrimmar - Phasing for the Horde - From Quest "Herald of War" until "Battle for the Undercity"
(60815,14,13369,13377,0,1101,2,1,74,11),   -- Durotar - Phasing for the Alliance - From Quest "Fate,Up Against Your Will" until "Battle for the Undercity"
(60815,1637,13369,13377,0,1101,2,1,74,11), -- Orgrimmar - Phasing for the Alliance - From Quest "Fate,Up Against Your Will" until "Battle for the Undercity"
(59062,85,13266,13267,0,690,2,1,74,11),    -- Tirisfal Glades - Phasing for the Horde - From Quest "A Life Without Regret" until "Battle for the Undercity"
(59062,1497,13266,13267,0,690,2,1,74,11),  -- Undercity - Phasing for the Horde - From Quest "A Life Without Regret" until "Battle for the Undercity"
(60815,85,13371,13377,0,1101,2,1,74,11),   -- Tirisfal Glades - Phasing for the Alliance - From Quest "The Killing Time" until "Battle for the Undercity"
(60815,1497,13371,13377,0,1101,2,1,74,11); -- Undercity - Phasing for the Alliance - From Quest "The Killing Time" until "Battle for the Undercity"

-- Portals
DELETE FROM `gameobject` WHERE `guid` BETWEEN 2133392 AND 2133395;
INSERT INTO `gameobject` (`guid`,`id`,`map`,`zoneId`,`areaId`,`spawnMask`,`phaseMask`,`position_x`,`position_y`,`position_z`,`orientation`,`rotation0`,`rotation1`,`rotation2`,`rotation3`,`spawntimesecs`,`animprogress`,`state`,`VerifiedBuild`)
VALUES
(2133392,193206,571,3537,4129,1,1,2830.01,6179.37,84.66,4.16,0,0,0,0,120,100,1,0),       -- Portal from Warsong Hold to Orgrimmar
(2133393,193425,1,1637,1637,1,64,1932.9,-4145.64,40.5929,3.37621,0,0,0,0,120,100,1,0),   -- Portal from Grommash Hold to Undercity
(2133394,193425,1,1637,1637,1,64,1909.87,-4147.81,40.6327,0.268081,0,0,0,0,120,100,1,0), -- Portal from Grommash Hold to Undercity
(2133395,193955,0,1519,1519,1,1,-8448.49,323.76,121.33,0.686877,0,0,0,0,120,100,1,0);    -- Portal from Stormwind to Undercity

DELETE FROM `gameobject_addon` WHERE `guid` BETWEEN 2133392 AND 2133395;
INSERT INTO `gameobject_addon` (`guid`,`invisibilityType`,`invisibilityValue`)
VALUES
(2133392,7,1000), -- Portal from Warsong Hold to Orgrimmar - Needs Mod Invisibility Detection (7)
(2133393,7,1000), -- Portal from Grommash Hold to Undercity - Needs Mod Invisibility Detection (7)
(2133394,7,1000), -- Portal from Grommash Hold to Undercity - Needs Mod Invisibility Detection (7)
(2133395,7,1000); -- Portal from Stormwind to Undercity - Needs Mod Invisibility Detection (7)

DELETE FROM `spell_scripts` WHERE `id` IN (59064,59439,60940);
INSERT INTO `spell_scripts` (`id`,`command`,`datalong`,`x`,`y`,`z`,`o`)
VALUES
(59064,6,1,1333.489,-4375.514,26.204,0.104), -- Portal from Warsong Hold to Orgrimmar - Teleport destination
(59439,6,0,1969.03,237.55,38.39,3.21),       -- Portal from Orgrimmar to Undercity - Teleport destination
(60940,6,0,1769.13,772.25,56.22,3.97);       -- Portal from Stormwind to Undercity - Teleport destination

-- Thrall (Horde version): End quest "Herald of War"
DELETE FROM `creature_questender` WHERE `id` = 31412;
INSERT INTO `creature_questender` (`id`,`quest`)
VALUES
(31412,13257);

-- These game objects and creatures can be used in both phases (64: Horde / 128: Alliance)
UPDATE `gameobject` SET `phaseMask` = 192 WHERE `phaseMask` = 128 AND `id` IN (193219,193217,193218,193216,193215);
UPDATE `creature` SET `phaseMask` = 192 WHERE `phaseMask` = 128 AND `id` IN (31564,31416,31420,31421,31422,31423,31424,31425,31426,31427,31429,31430,31431,31437,31467);

-- Creature text for both Thrall versions (Horde and Alliance phase)
DELETE FROM `creature_text` WHERE `CreatureID` IN (31412,32363);
INSERT INTO `creature_text` (`CreatureID`,`groupid`,`id`,`text`,`type`,`language`,`probability`,`emote`,`duration`,`sound`,`BroadcastTextId`,`comment`)
VALUES
(31412,0,0,'Kor''kron, stand down!',12,0,100,5,0,16222,32286,'Thrall - Phased Orgrimmar (Horde)'),
(31412,1,0,'Jaina...',12,0,100,1,0,16223,32287,'Thrall - Phased Orgrimmar (Horde)'),
(31412,2,0,'Jaina, what happened at the Wrathgate. It was a betrayal from within...',12,0,100,1,0,16224,32289,'Thrall - Phased Orgrimmar (Horde)'),
(31412,3,0,'The Horde has lost the Undercity.',12,0,100,1,0,16225,32292,'Thrall - Phased Orgrimmar (Horde)'),
(31412,4,0,'We now prepare to lay siege to the city and bring the perpetrators of this unforgivable crime to justice.',12,0,100,1,0,16226,32293,'Thrall - Phased Orgrimmar (Horde)'),
(31412,5,0,'If we are forced into a conflict, the Lich King will destroy our divided forces in Northrend.',12,0,100,1,0,16227,32294,'Thrall - Phased Orgrimmar (Horde)'),
(31412,6,0,'We will make this right, Jaina. Tell your king all that you have learned here.',12,0,100,1,0,16228,32295,'Thrall - Phased Orgrimmar (Horde)'),
(31412,7,0,'Kor''kron, prepare transport to the Undercity.',12,0,100,1,0,16229,32300,'Thrall - Phased Orgrimmar (Horde)'),
(32363,0,0,'Kor''kron, stand down!',12,0,100,5,0,16222,32286,'Thrall - Phased Orgrimmar (Alliance)'),
(32363,1,0,'Jaina...',12,0,100,1,0,16223,32287,'Thrall - Phased Orgrimmar (Alliance)'),
(32363,2,0,'Jaina, what happened at the Wrathgate. It was a betrayal from within...',12,0,100,1,0,16224,32289,'Thrall - Phased Orgrimmar (Alliance)'),
(32363,3,0,'The Horde has lost the Undercity.',12,0,100,1,0,16225,32292,'Thrall - Phased Orgrimmar (Alliance)'),
(32363,4,0,'We now prepare to lay siege to the city and bring the perpetrators of this unforgivable crime to justice.',12,0,100,1,0,16226,32293,'Thrall - Phased Orgrimmar (Alliance)'),
(32363,5,0,'If we are forced into a conflict, the Lich King will destroy our divided forces in Northrend.',12,0,100,1,0,16227,32294,'Thrall - Phased Orgrimmar (Alliance)'),
(32363,6,0,'We will make this right, Jaina. Tell your king all that you have learned here.',12,0,100,1,0,16228,32295,'Thrall - Phased Orgrimmar (Alliance)'),
(32363,7,0,'Kor''kron, prepare transport to the Undercity.',12,0,100,1,0,16229,32300,'Thrall - Phased Orgrimmar (Alliance)');

-- Add "talk" emote to Sylvanas' creature text
UPDATE `creature_text` SET `Emote` = 1 WHERE `CreatureID` = 31419;

-- Creature text for the Forsaken Refugees
DELETE FROM `creature_text` WHERE `CreatureID` IN (31437,31467);
INSERT INTO `creature_text` (`CreatureID`,`groupid`,`id`,`text`,`type`,`language`,`probability`,`emote`,`duration`,`sound`,`BroadcastTextId`,`comment`)
VALUES
(31437,0,0,'We''ve lost Undercity. Nothing but demons and Putress'' apothecaries left there...',12,1,100,0,0,0,32226,'Forsaken Refugee'),
(31437,0,1,'They killed hundreds! We barely escaped with our lives! Help!',12,1,100,0,0,0,32229,'Forsaken Refugee'),
(31437,0,2,'The Dark Lady fought off as many as she could,but in the end... I hope she survived. Please help!',12,1,100,0,0,0,32230,'Forsaken Refugee'),
(31437,0,3,'You must help! We''re homeless!',12,1,100,0,0,0,32227,'Forsaken Refugee'),
(31437,0,4,'Help us! Please!',12,1,100,0,0,0,32225,'Forsaken Refugee'),
(31437,0,5,'Could you spare a gold?',12,1,100,0,0,0,32228,'Forsaken Refugee'),
(31467,0,0,'We''ve lost Undercity. Nothing but demons and Putress'' apothecaries left there...',12,1,100,0,0,0,32226,'Forsaken Refugee'),
(31467,0,1,'They killed hundreds! We barely escaped with our lives! Help!',12,1,100,0,0,0,32229,'Forsaken Refugee'),
(31467,0,2,'The Dark Lady fought off as many as she could,but in the end... I hope she survived. Please help!',12,1,100,0,0,0,32230,'Forsaken Refugee'),
(31467,0,3,'You must help! We''re homeless!',12,1,100,0,0,0,32227,'Forsaken Refugee'),
(31467,0,4,'Help us! Please!',12,1,100,0,0,0,32225,'Forsaken Refugee'),
(31467,0,5,'Could you spare a gold?',12,1,100,0,0,0,32228,'Forsaken Refugee');

UPDATE `creature_text` SET `language` = 1 WHERE `CreatureID` IN (31423,31425,31426,31427,31429,31430,31431,31433);

-- Runthak
UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 31431;

-- Jaina,Gamon,Karus,Koma,Soran,Kaja,Olvia,Doras,Felika,Sana,Auctioneer Thathung,Overlord Runthak,Forsaken Refugee (2x),Innkeeper Gryshka,Orc Commoner,Sylvanas
UPDATE `creature_template` SET `unit_flags` = 768 WHERE `entry` IN (31418,31424,31420,31421,31422,31423,31425,31426,31427,31429,31430,31431,31437,31467,31433,31434,31419);

-- Thrall (Horde), Sylvanas (Horde/Alliance), Jaina (Horde), Jaina (Alliance), Kor'kron Elite
UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` IN (31412,31419,31418,32364,32367);

-- Randomize the behaviour of the Forsaken Refugees
DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId` = 22 AND `SourceEntry` IN (31437,31467);
INSERT INTO `conditions` (`SourceTypeOrReferenceId`,`SourceGroup`,`SourceEntry`,`SourceId`,`ElseGroup`,`ConditionTypeOrReference`,`ConditionTarget`,`ConditionValue1`,`ConditionValue2`,`ConditionValue3`,`NegativeCondition`,`ErrorType`,`ErrorTextId`,`ScriptName`,`Comment`) VALUES
(22,1,31437,0,0,21,1,16,0,0,0,0,0,'','Forsaken Refugee Roaming - Enable Talk Script'),
(22,2,31437,0,0,21,1,16,0,0,1,0,0,'','Forsaken Refugee Not Roaming - Enable Sit/Sleep Script'),
(22,1,31467,0,0,21,1,16,0,0,0,0,0,'','Forsaken Refugee Roaming - Enable Talk Script'),
(22,2,31467,0,0,21,1,16,0,0,1,0,0,'','Forsaken Refugee Not Roaming - Enable Sit/Sleep Script');

DELETE FROM `smart_scripts` WHERE `entryorguid` IN (31437,31467) AND `source_type` = 0;
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`event_param5`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_param4`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`)
VALUES
(31437,0,0,0,60,0,70,0,1000,15000,20000,60000,0,1,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Forsaken Refugee - On Update - Talk'),
(31437,0,1,0,63,0,70,0,0,0,0,0,0,87,3143700,3143701,3143701,0,0,0,1,0,0,0,0,0,0,0,0,'Forsaken Refugee - On Create - Run Random Script (Sit/Sleep)'),
(31467,0,0,0,60,0,70,0,1000,15000,20000,60000,0,1,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Forsaken Refugee - On Update - Talk'),
(31467,0,1,0,63,0,70,0,0,0,0,0,0,87,3146700,3146701,3146701,0,0,0,1,0,0,0,0,0,0,0,0,'Forsaken Refugee - On Create - Run Random Script (Sit/Sleep)');

DELETE FROM `smart_scripts` WHERE `entryorguid` IN (3143700,3143701,3146700,3146701) AND `source_type` = 9;
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`event_param5`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_param4`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`)
VALUES
(3143700,9,0,0,0,0,100,0,0,0,0,0,0,75,42648,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Forsaken Refugee - On Script - Add Aura ''Sleeping Sleep'' (42648)'),
(3146700,9,0,0,0,0,100,0,0,0,0,0,0,75,42648,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Forsaken Refugee - On Script - Add Aura ''Sleeping Sleep'' (42648)'),
(3143701,9,0,0,0,0,100,0,0,0,0,0,0,90,1,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Forsaken Refugee - On Script - Set ''UNIT_STAND_STATE_SIT'''),
(3146701,9,0,0,0,0,100,0,0,0,0,0,0,90,1,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Forsaken Refugee - On Script - Set ''UNIT_STAND_STATE_SIT''');

-- Additional creatures
DELETE FROM `creature` WHERE `guid` BETWEEN 3108763 AND 3108775;
INSERT INTO `creature` (`guid`,`id`,`map`,`zoneId`,`areaId`,`spawnMask`,`phaseMask`,`modelid`,`equipment_id`,`position_x`,`position_y`,`position_z`,`orientation`,`spawntimesecs`,`spawndist`,`currentwaypoint`,`curhealth`,`curmana`,`MovementType`,`npcflag`,`unit_flags`,`dynamicflags`,`VerifiedBuild`)
VALUES
(3108763,31412,1,1637,1637,1,64,0,0,1913.81,-4127.87,43.23,0.147480,300,0,0,1,0,0,0,0,0,0),             -- Thrall
(3108764,31419,1,1637,1637,1,64,0,0,1920.589233,-4130.980469,43.090080,1.741838,300,0,0,1,0,0,0,0,0,0), -- Sylvanas
(3108765,32367,1,1637,1637,1,64,0,0,1909.64,-4139.34,40.6099,6.04237,300,0,0,1,0,0,0,0,0,0),            -- Kor'kron Elite
(3108766,32367,1,1637,1637,1,64,0,0,1931.32,-4136.56,40.6125,4.01604,300,0,0,1,0,0,0,0,0,0),            -- Kor'kron Elite
(3108767,32367,1,1637,1637,1,64,0,0,1931.97,-4154.32,40.6246,1.6245,300,0,0,1,0,0,0,0,0,0),             -- Kor'kron Elite
(3108768,32367,1,1637,1637,1,64,0,0,1910.9,-4154.71,40.6308,1.58916,300,0,0,1,0,0,0,0,0,0),             -- Kor'kron Elite
(3108769,31433,1,1637,1637,1,192,0,1,1597.02,-4395.84,8.61465,0.664267,300,0,0,1003,0,0,0,0,0,0),       -- Gryshka
(3108770,31434,1,1637,1637,1,192,0,0,1596.92,-4404.38,7.44287,0.664267,300,0,0,1395,0,0,0,0,0,0),       -- Orc Commoners
(3108771,31434,1,1637,1637,1,192,0,0,1599.55,-4403.68,8.18324,0.664267,300,0,0,2292,0,0,0,0,0,0),
(3108772,31434,1,1637,1637,1,192,0,0,1594.69,-4402.98,6.7853,0.764151,300,0,0,1110,0,0,0,0,0,0),
(3108773,31434,1,1637,1637,1,192,0,0,1594.08,-4399.7,6.717,0.664267,300,0,0,955,0,0,0,0,0,0),
(3108774,31434,1,1637,1637,1,192,0,0,1597.56,-4400.02,7.71554,0.862326,300,0,0,247,0,0,0,0,0,0),
(3108775,31434,1,1637,1637,1,192,0,0,1595.05,-4397.02,7.80377,0.622779,300,0,0,71,0,0,0,0,0,0);

-- Waypoints for Runthak and Thrall (Horde phase)
DELETE FROM `waypoints` WHERE `entry` IN (314310,314120);
INSERT INTO `waypoints`
(`entry`,`pointid`,`position_x`,`position_y`,`position_z`,`point_comment`)
VALUES
(314310,1,1601.677856,-4390.092773,10.024803,'Runthak'),
(314310,2,1607.239624,-4397.162109,10.247937,'Runthak'),
(314120,1,1923.388672,-4126.897949,43.180893,'Thrall'),
(314120,2,1916.156494,-4127.158691,43.197136,'Thrall');

-- Runthak
DELETE FROM `smart_scripts` WHERE `entryorguid` = 31431 AND `source_type` = 0;
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`event_param5`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_param4`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`)
VALUES
(31431,0,0,0,63,0,100,1,0,0,0,0,0,53,0,314310,1,0,0,2,1,0,0,0,0,0,0,0,0,'Runthak - On Created - Start Waypoint Movement'),
(31431,0,1,0,10,0,100,1,1,20,0,0,1,80,3143100,2,0,0,0,0,1,0,0,0,0,0,0,0,0,'Runthak - On OOC LoS Player Only - Run Script - No Repeat'),
(31431,0,2,0,10,0,100,0,1,20,80000,80000,1,80,3143100,2,0,0,0,0,1,0,0,0,0,0,0,0,0,'Runthak - On OOC LoS Player Only - Run Script (Cooldown 80s)');

DELETE FROM `smart_scripts` WHERE `entryorguid` = 3143100 AND `source_type` = 9;
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`event_param5`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_param4`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`)
VALUES
(3143100,9,0,0,0,0,100,0,2000,2000,0,0,0,1,0,0,0,0,0,0,11,31433,50,0,0,0,0,0,0,'Runthak - On Script - Say Line 0 (Gryshka)'),
(3143100,9,1,0,0,0,100,0,0,0,0,0,0,54,55000,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Runthak - On Script - Pause Waypoint Movement'),
(3143100,9,2,0,0,0,100,0,0,0,0,0,0,66,0,0,0,0,0,0,11,31433,50,0,0,0,0,0,0,'Runthak - On Script - Set Orientation (Gryshka)'),
(3143100,9,3,0,0,0,100,0,4500,4500,0,0,0,1,0,0,0,0,0,0,11,31425,50,0,0,0,0,0,0,'Runthak - On Script - Say Line 0 (Olvia)'),
(3143100,9,4,0,0,0,100,0,4500,4500,0,0,0,1,0,0,0,0,0,0,11,31427,50,0,0,0,0,0,0,'Runthak - On Script - Say Line 0 (Felika)'),
(3143100,9,5,0,0,0,100,0,4500,4500,0,0,0,1,0,0,0,0,0,0,11,31430,50,0,0,0,0,0,0,'Runthak - On Script - Say Line 0 (Thathung)'),
(3143100,9,6,0,0,0,100,0,4500,4500,0,0,0,1,0,0,0,0,0,0,11,31429,50,0,0,0,0,0,0,'Runthak - On Script - Say Line 0 (Sana)'),
(3143100,9,7,0,0,0,100,0,4500,4500,0,0,0,1,1,0,0,0,0,0,11,31433,50,0,0,0,0,0,0,'Runthak - On Script - Say Line 1 (Gryshka)'),
(3143100,9,8,0,0,0,100,0,4500,4500,0,0,0,1,0,0,0,0,0,0,11,31423,50,0,0,0,0,0,0,'Runthak - On Script - Say Line 0 (Kaja)'),
(3143100,9,9,0,0,0,100,0,4500,4500,0,0,0,1,1,0,0,0,0,0,11,31427,50,0,0,0,0,0,0,'Runthak - On Script - Say Line 1 (Felika)'),
(3143100,9,10,0,0,0,100,0,4500,4500,0,0,0,1,1,0,0,0,0,0,11,31425,50,0,0,0,0,0,0,'Runthak - On Script - Say Line 1 (Olvia)'),
(3143100,9,11,0,0,0,100,0,4500,4500,0,0,0,1,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Runthak - On Script - Say Line 0'),
(3143100,9,12,0,0,0,100,0,1500,1500,0,0,0,1,1,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Runthak - On Script - Say Line 1'),
(3143100,9,13,0,0,0,100,0,4500,4500,0,0,0,1,2,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Runthak - On Script - Say Line 2'),
(3143100,9,14,0,0,0,100,0,4500,4500,0,0,0,1,3,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Runthak - On Script - Say Line 3');

-- Sylvanas
DELETE FROM `smart_scripts` WHERE `entryorguid` = 31419 AND `source_type` = 0;
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`event_param5`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_param4`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`)
VALUES
(31419,0,0,0,25,0,100,0,0,0,0,0,0,90,8,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Sylvanas - On Reset - Set ''UNIT_STAND_STATE_KNEEL'''),
(31419,0,1,0,34,0,100,0,8,2,0,0,0,90,8,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Sylvanas - On Movement Inform - Set ''UNIT_STAND_STATE_KNEEL''');

DELETE FROM `smart_scripts` WHERE `entryorguid` = 3141900 AND `source_type` = 9;
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`event_param5`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_param4`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`)
VALUES
(3141900,9,0,0,0,0,100,0,5000,5000,0,0,0,66,0,0,0,0,0,0,11,32364,50,0,0,0,0,0,0,'Sylvanas - On Script - Set Orientation (Jaina)'),
(3141900,9,1,0,0,0,100,0,1000,1000,0,0,0,1,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Sylvanas - On Script - Say Line 0'),
(3141900,9,2,0,0,0,100,0,10000,10000,0,0,0,1,1,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Sylvanas - On Script - Say Line 1');

-- Assign the correct Sylvanas creature template
UPDATE `creature` SET `id` = 31419 WHERE `guid` = 1976217;

-- Prevent executing the event after the quests "Herald of War" (Horde) or "Fate,Up Against Your Will" (Alliance) are finished
DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId` = 22 AND `SourceEntry` IN (31412,32363);
INSERT INTO `conditions` (`SourceTypeOrReferenceId`,`SourceGroup`,`SourceEntry`,`SourceId`,`ElseGroup`,`ConditionTypeOrReference`,`ConditionTarget`,`ConditionValue1`,`ConditionValue2`,`ConditionValue3`,`NegativeCondition`,`ErrorType`,`ErrorTextId`,`ScriptName`,`Comment`) VALUES
(22,2,31412,0,0,28,0,13257,0,0,0,0,0,'','Quest ''Herald of War'' complete, but not yet rewarded - Enable Thrall Event Script (Horde)'),
(22,3,31412,0,0,28,0,13257,0,0,0,0,0,'','Quest ''Herald of War'' complete, but not yet rewarded - Enable Thrall Event Script (Horde)'),
(22,1,32363,0,0,28,0,13369,0,0,0,0,0,'','Quest ''Fate,Up Against Your Will'' complete, but not yet rewarded - Enable Thrall Event Script (Alliance)'),
(22,2,32363,0,0,28,0,13369,0,0,0,0,0,'','Quest ''Fate,Up Against Your Will'' complete, but not yet rewarded - Enable Thrall Event Script (Alliance)');

-- Thrall / Jaina Event - Horde version
DELETE FROM `smart_scripts` WHERE `entryorguid` = 31412 AND `source_type` = 0;
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`event_param5`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_param4`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`)
VALUES
(31412,0,0,0,25,0,100,1,0,0,0,0,0,53,0,314120,1,0,0,2,1,0,0,0,0,0,0,0,0,'Thrall - On Reset - Start Waypoint Movement'),
(31412,0,1,0,10,0,100,1,1,5,0,0,1,80,3141200,2,0,0,0,0,1,0,0,0,0,0,0,0,0,'Thrall - On OOC LoS Player Only - Run Script - No Repeat'),
(31412,0,2,0,10,0,100,0,1,5,170000,170000,1,80,3141200,2,0,0,0,0,1,0,0,0,0,0,0,0,0,'Thrall - On OOC LoS Player Only - Run Script (Cooldown 170s)');

DELETE FROM `smart_scripts` WHERE `entryorguid` = 3141200 AND `source_type` = 9;
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`event_param5`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_param4`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`)
VALUES
(3141200,9,0,0,0,0,100,0,0,0,0,0,0,54,142000,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Thrall - On Script - Pause Waypoint Movement'),
(3141200,9,1,0,0,0,100,0,0,0,0,0,0,48,1,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Thrall - On Script - Set Active On'), -- Set active or otherwise the event won't be updated if no player is near
(3141200,9,2,0,0,0,100,0,0,0,0,0,0,59,1,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Thrall - On Script - Set Run On'),
(3141200,9,3,0,0,0,100,0,0,0,0,0,0,201,1,0,0,0,0,0,1,0,0,0,0,1920.71,-4136.74,40.5393,4.84791,'Thrall - On Script - Move To Pos'),
(3141200,9,4,0,0,0,100,0,0,0,0,0,0,12,31640,3,132000,0,0,0,8,0,0,0,0,1921.34,-4146.44,40.4888,1.67552,'Thrall - On Script - Summon Portal to Stormwind'),
(3141200,9,5,0,0,0,100,0,0,0,0,0,0,12,32364,3,130000,0,0,0,8,0,0,0,0,1921.34,-4146.44,40.4888,1.67552,'Thrall - On Script - Summon Jaina'),
(3141200,9,6,0,0,0,100,0,0,0,0,0,0,86,55761,0,11,32364,50,0,1,0,0,0,0,0,0,0,0,'Thrall - On Script - Cross Cast ''Jaina'' (Air Revenant Entrance)'),
(3141200,9,7,0,0,0,100,0,0,0,0,0,0,59,1,0,0,0,0,0,11,32367,50,0,0,0,0,0,0,'Thrall - On Script - Set Run On (Kor''kron Elite)'),
(3141200,9,8,0,0,0,100,0,0,0,0,0,0,59,0,0,0,0,0,0,11,32364,50,0,0,0,0,0,0,'Thrall - On Script - Set Run Off (Jaina)'),
(3141200,9,9,0,0,0,100,0,0,0,0,0,0,59,0,0,0,0,0,0,11,31419,50,0,0,0,0,0,0,'Thrall - On Script - Set Run Off (Sylvanas)'),
(3141200,9,10,0,0,0,100,0,0,0,0,0,0,201,1,0,0,0,0,0,11,32367,50,0,0,1921.34,-4146.44,40.4888,1.67552,'Thrall - On Script - Move To Pos (Kor''kron Elite)'),
(3141200,9,11,0,0,0,100,0,2000,2000,0,0,0,59,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Thrall - On Script - Set Run Off'),
(3141200,9,12,0,0,0,100,0,0,0,0,0,0,91,8,0,0,0,0,0,11,31419,50,0,0,0,0,0,0,'Thrall - On Script - Remove ''UNIT_STAND_STATE_KNEEL'' (Sylvanas)'),
(3141200,9,13,0,0,0,100,0,0,0,0,0,0,1,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Thrall - On Script - Say Line 0'),
(3141200,9,14,0,0,0,100,0,700,700,0,0,0,24,0,0,0,0,0,0,11,32367,50,0,0,0,0,0,0,'Thrall - On Script - Enter Evade Target (Kor''kron Elite)'),
(3141200,9,15,0,0,0,100,0,1000,1000,0,0,0,66,0,0,0,0,0,0,11,32364,50,0,0,0,0,0,0,'Thrall - On Script - Set Orientation (Jaina)'),
(3141200,9,16,0,0,0,100,0,4000,4000,0,0,0,1,1,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Thrall - On Script - Say Line 1'),
(3141200,9,17,0,0,0,100,0,1000,1000,0,0,0,201,1,0,0,0,0,0,11,32364,50,0,0,1920.86,-4139.99,40.588,1.62,'Thrall - On Script - Move To Pos (Jaina)'),
(3141200,9,18,0,0,0,100,0,4000,4000,0,0,0,1,0,0,0,0,0,0,11,32364,50,0,0,0,0,0,0,'Thrall - On Script - Say Line 0 (Jaina)'),
(3141200,9,19,0,0,0,100,0,6000,6000,0,0,0,1,2,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Thrall - On Script - Say Line 2'),
(3141200,9,20,0,0,0,100,0,6000,6000,0,0,0,201,1,0,0,0,0,0,11,31419,50,0,0,1918.1,-4137.15,40.578,4.87,'Thrall - On Script - Move To Pos (Sylvanas)'),
(3141200,9,21,0,0,0,100,0,0,0,0,0,0,80,3141900,2,0,0,0,0,11,31419,50,0,0,0,0,0,0,'Thrall - On Script - Run Script (Sylvanas)'),
(3141200,9,22,0,0,0,100,0,35000,35000,0,0,0,1,3,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Thrall - On Script - Say Line 3'),
(3141200,9,23,0,0,0,100,0,5000,5000,0,0,0,1,4,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Thrall - On Script - Say Line 4'),
(3141200,9,24,0,0,0,100,0,9000,9000,0,0,0,1,5,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Thrall - On Script - Say Line 5'),
(3141200,9,25,0,0,0,100,0,7000,7000,0,0,0,1,6,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Thrall - On Script - Say Line 6'),
(3141200,9,26,0,0,0,100,0,6000,6000,0,0,0,1,1,0,0,0,0,0,11,32364,50,0,0,0,0,0,0,'Thrall - On Script - Say Line 1 (Jaina)'),
(3141200,9,27,0,0,0,100,0,4000,4000,0,0,0,1,2,0,0,0,0,0,11,32364,50,0,0,0,0,0,0,'Thrall - On Script - Say Line 2 (Jaina)'),
(3141200,9,28,0,0,0,100,0,16000,16000,0,0,0,1,3,0,0,0,0,0,11,32364,50,0,0,0,0,0,0,'Thrall - On Script - Say Line 3 (Jaina)'),
(3141200,9,29,0,0,0,100,0,11000,11000,0,0,0,1,4,0,0,0,0,0,11,32364,50,0,0,0,0,0,0,'Thrall - On Script - Say Line 4 (Jaina)'),
(3141200,9,30,0,0,0,100,0,8000,8000,0,0,0,201,1,0,0,0,0,0,11,32364,50,0,0,1921.34,-4146.44,40.4888,1.67552,'Thrall - On Script - Move To Pos (Jaina)'),
(3141200,9,31,0,0,0,100,0,9000,9000,0,0,0,1,7,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Thrall - On Script - Say Line 7'),
(3141200,9,32,0,0,0,100,0,1000,1000,0,0,0,24,0,0,0,0,0,0,11,31419,50,0,0,0,0,0,0,'Thrall - On Script - Enter Evade Target (Sylvanas)'),
(3141200,9,33,0,0,0,100,0,33000,33000,0,0,0,48,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Thrall - On Script - Set Active Off');

-- Thrall / Jaina Event - Alliance version
DELETE FROM `smart_scripts` WHERE `entryorguid` = 32363 AND `source_type` = 0;
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`event_param5`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_param4`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`)
VALUES
(32363,0,0,0,10,0,100,1,1,50,0,0,1,80,3236300,2,0,0,0,0,1,0,0,0,0,0,0,0,0,'Thrall - On OOC LoS Player Only - Run Script - No Repeat'),
(32363,0,1,0,10,0,100,0,1,50,170000,170000,1,80,3236300,2,0,0,0,0,1,0,0,0,0,0,0,0,0,'Thrall - On OOC LoS Player Only - Run Script (Cooldown 170s)');

DELETE FROM `smart_scripts` WHERE `entryorguid` = 3236300 AND `source_type` = 9;
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`event_param5`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_param4`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`)
VALUES
(3236300,9,0,0,0,0,100,0,0,0,0,0,0,48,1,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Thrall - On Script - Set Active On'), -- Set active or otherwise the event won't be updated if no player is near
(3236300,9,1,0,0,0,100,0,0,0,0,0,0,12,32364,3,128000,0,0,0,8,0,0,0,0,1921.34,-4146.44,40.4888,1.67552,'Thrall - On Script - Summon Jaina'),
(3236300,9,2,0,0,0,100,0,0,0,0,0,0,86,55761,0,11,32364,50,0,1,0,0,0,0,0,0,0,0,'Thrall - On Script - Cross Cast ''Jaina'' (Air Revenant Entrance)'),
(3236300,9,3,0,0,0,100,0,0,0,0,0,0,59,1,0,0,0,0,0,11,32367,50,0,0,0,0,0,0,'Thrall - On Script - Set Run On (Kor''kron Elite)'),
(3236300,9,4,0,0,0,100,0,0,0,0,0,0,59,0,0,0,0,0,0,11,32364,50,0,0,0,0,0,0,'Thrall - On Script - Set Run Off (Jaina)'),
(3236300,9,5,0,0,0,100,0,0,0,0,0,0,59,0,0,0,0,0,0,11,31419,50,0,0,0,0,0,0,'Thrall - On Script - Set Run Off (Sylvanas)'),
(3236300,9,6,0,0,0,100,0,0,0,0,0,0,201,1,0,0,0,0,0,11,32367,50,0,0,1921.34,-4146.44,40.4888,1.67552,'Thrall - On Script - Move To Pos (Kor''kron Elite)'),
(3236300,9,7,0,0,0,100,0,0,0,0,0,0,91,8,0,0,0,0,0,11,31419,50,0,0,0,0,0,0,'Thrall - On Script - Remove ''UNIT_STAND_STATE_KNEEL'' (Sylvanas)'),
(3236300,9,8,0,0,0,100,0,0,0,0,0,0,1,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Thrall - On Script - Say Line 0'),
(3236300,9,9,0,0,0,100,0,1700,1700,0,0,0,24,0,0,0,0,0,0,11,32367,50,0,0,0,0,0,0,'Thrall - On Script - Enter Evade Target (Kor''kron Elite)'),
(3236300,9,10,0,0,0,100,0,4000,4000,0,0,0,1,1,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Thrall - On Script - Say Line 1'),
(3236300,9,11,0,0,0,100,0,1000,1000,0,0,0,201,1,0,0,0,0,0,11,32364,50,0,0,1920.86,-4139.99,40.588,1.62,'Thrall - On Script - Move To Pos (Jaina)'),
(3236300,9,12,0,0,0,100,0,4000,4000,0,0,0,1,0,0,0,0,0,0,11,32364,50,0,0,0,0,0,0,'Thrall - On Script - Say Line 0 (Jaina)'),
(3236300,9,13,0,0,0,100,0,6000,6000,0,0,0,1,2,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Thrall - On Script - Say Line 2'),
(3236300,9,14,0,0,0,100,0,6000,6000,0,0,0,201,1,0,0,0,0,0,11,31419,50,0,0,1918.1,-4137.15,40.578,4.87,'Thrall - On Script - Move To Pos (Sylvanas)'),
(3236300,9,15,0,0,0,100,0,0,0,0,0,0,80,3141900,2,0,0,0,0,11,31419,50,0,0,0,0,0,0,'Thrall - On Script - Run Script (Sylvanas)'),
(3236300,9,16,0,0,0,100,0,35000,35000,0,0,0,1,3,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Thrall - On Script - Say Line 3'),
(3236300,9,17,0,0,0,100,0,5000,5000,0,0,0,1,4,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Thrall - On Script - Say Line 4'),
(3236300,9,18,0,0,0,100,0,9000,9000,0,0,0,1,5,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Thrall - On Script - Say Line 5'),
(3236300,9,19,0,0,0,100,0,7000,7000,0,0,0,1,6,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Thrall - On Script - Say Line 6'),
(3236300,9,20,0,0,0,100,0,6000,6000,0,0,0,1,1,0,0,0,0,0,11,32364,50,0,0,0,0,0,0,'Thrall - On Script - Say Line 1 (Jaina)'),
(3236300,9,21,0,0,0,100,0,4000,4000,0,0,0,1,2,0,0,0,0,0,11,32364,50,0,0,0,0,0,0,'Thrall - On Script - Say Line 2 (Jaina)'),
(3236300,9,22,0,0,0,100,0,16000,16000,0,0,0,1,3,0,0,0,0,0,11,32364,50,0,0,0,0,0,0,'Thrall - On Script - Say Line 3 (Jaina)'),
(3236300,9,23,0,0,0,100,0,11000,11000,0,0,0,1,4,0,0,0,0,0,11,32364,50,0,0,0,0,0,0,'Thrall - On Script - Say Line 4 (Jaina)'),
(3236300,9,24,0,0,0,100,0,8000,8000,0,0,0,201,1,0,0,0,0,0,11,32364,50,0,0,1921.34,-4146.44,40.4888,1.67552,'Thrall - On Script - Move To Pos (Jaina)'),
(3236300,9,25,0,0,0,100,0,3000,3000,0,0,0,1,7,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Thrall - On Script - Say Line 7'),
(3236300,9,26,0,0,0,100,0,1000,1000,0,0,0,24,0,0,0,0,0,0,11,31419,50,0,0,0,0,0,0,'Thrall - On Script - Enter Evade Target (Sylvanas)'),
(3236300,9,27,0,0,0,100,0,41000,41000,0,0,0,48,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Thrall - On Script - Set Active Off');

--
-- END UPDATING QUERIES
--
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
