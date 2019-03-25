-- DB update 2019_03_18_01 -> 2019_03_19_00
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2019_03_18_01';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2019_03_18_01 2019_03_19_00 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1552430179337425838'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1552430179337425838');

-- Creature text for Pitfighter audience
DELETE FROM `creature_text` WHERE `CreatureID` IN (18292,18293,18299,18296);
INSERT INTO `creature_text` (`CreatureID`,`GroupID`,`ID`,`Text`,`Type`,`Language`,`Probability`,`Emote`,`Duration`,`Sound`,`BroadcastTextId`,`TextRange`,`comment`)
VALUES
(18292,0,0,'The pitfighter will be victorious! Just look at him!',12,1,100,5,0,0,16229,0,''),
(18292,0,1,'He''s so well disciplined!',12,1,100,21,0,0,16230,0,''),
(18292,0,2,'How does he do it?',12,1,100,6,0,0,16231,0,''),
(18293,0,0,'The pitfighter will be victorious! Just look at him!',12,1,100,5,0,0,16236,0,''),
(18293,0,1,'He''s so well disciplined!',12,1,100,21,0,0,16237,0,''),
(18293,0,2,'How does he do it?',12,1,100,6,0,0,16238,0,''),
(18296,0,0,'Wow! Look at his muscles!',12,1,100,0,0,0,16233,0,''),
(18296,0,1,'I wanna be just like the pitfighter!',12,1,100,0,0,0,16234,0,''),
(18296,0,2,'Will he win? Can he win?',12,1,100,0,0,0,16235,0,'');

-- Pitfighter audience creature text only for GUIDs, not for template entries
DELETE FROM `smart_scripts` WHERE `entryorguid` IN (18292,18293,18299,18296,-65612,-65631,-65632,-65633,-65622,-65623);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`)
VALUES
(-65612,0,0,0,1,0,100,0,60000,180000,60000,180000,0,1,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Bleeding Hollow Refugee - Out of Combat - Say Line 0'),
(-65631,0,0,0,1,0,100,0,60000,180000,60000,180000,0,1,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Sunspring Post Orphan - Out of Combat - Say Line 0'),
(-65632,0,0,0,1,0,100,0,60000,180000,60000,180000,0,1,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Sunspring Post Orphan - Out of Combat - Say Line 0'),
(-65633,0,0,0,1,0,100,0,60000,180000,60000,180000,0,1,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Sunspring Post Orphan - Out of Combat - Say Line 0'),
(-65622,0,0,0,1,0,100,0,60000,180000,60000,180000,0,1,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Sunspring Post Refugee - Out of Combat - Say Line 0'),
(-65623,0,0,0,1,0,100,0,60000,180000,60000,180000,0,1,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Sunspring Post Refugee - Out of Combat - Say Line 0');

-- Relocate two of the Garadar Defenders who wander aimlessly outside into the hospice
UPDATE `creature` SET `MovementType` = 0, `spawndist` = 0, `position_x` = -1215.76, `position_y` = 7158.35, `position_z` = 57.2651, `orientation` = 1.02516 WHERE `guid` = 66646;
UPDATE `creature` SET `MovementType` = 0, `spawndist` = 0, `position_x` = -1232.01, `position_y` = 7151.02, `position_z` = 57.2652, `orientation` = 3.91604 WHERE `guid` = 66647;

-- Equipment for Garadar Defender and Garadar Wolf Rider
DELETE FROM `creature_equip_template` WHERE `CreatureID` IN (18489,19068);
INSERT INTO `creature_equip_template` (`CreatureID`,`ID`,`ItemID1`,`ItemID2`,`ItemID3`,`VerifiedBuild`)
VALUES
(18489,1,10898,12456,0,0),
(18489,2,18062,0,0,0),
(18489,3,14877,14877,0,0),
(19068,1,18062,0,0,0);

UPDATE `creature` SET `equipment_id` = -1 WHERE `id` = 18489; -- Randomize equipment

-- Add additional templates for Kor'kron Honor Guard and Kor'kron Warrior in order to assign individual waypoint paths for the summoned creatures
SET @ENTRY := 182753;
DELETE FROM `creature_template` WHERE `entry` BETWEEN @ENTRY AND @ENTRY + 19;
INSERT INTO `creature_template` (`entry`,`difficulty_entry_1`,`difficulty_entry_2`,`difficulty_entry_3`,`KillCredit1`,`KillCredit2`,`modelid1`,`modelid2`,`modelid3`,`modelid4`,`name`,`subname`,`IconName`,`gossip_menu_id`,`minlevel`,`maxlevel`,`exp`,`faction`,`npcflag`,`speed_walk`,`speed_run`,`scale`,`rank`,`mindmg`,`maxdmg`,`dmgschool`,`attackpower`,`DamageModifier`,`BaseAttackTime`,`RangeAttackTime`,`unit_class`,`unit_flags`,`unit_flags2`,`dynamicflags`,`family`,`trainer_type`,`trainer_spell`,`trainer_class`,`trainer_race`,`minrangedmg`,`maxrangedmg`,`rangedattackpower`,`type`,`type_flags`,`lootid`,`pickpocketloot`,`skinloot`,`resistance1`,`resistance2`,`resistance3`,`resistance4`,`resistance5`,`resistance6`,`spell1`,`spell2`,`spell3`,`spell4`,`spell5`,`spell6`,`spell7`,`spell8`,`PetSpellDataId`,`VehicleId`,`mingold`,`maxgold`,`AIName`,`MovementType`,`InhabitType`,`HoverHeight`,`HealthModifier`,`ManaModifier`,`ArmorModifier`,`RacialLeader`,`movementId`,`RegenHealth`,`mechanic_immune_mask`,`flags_extra`,`ScriptName`,`VerifiedBuild`)
VALUES
(@ENTRY,0,0,0,0,0,19017,0,0,0,'Kor''kron Honor Guard','',NULL,0,73,73,1,1735,0,1,(9.7/7),1,1,316,450,0,320,7.5,1400,1900,1,320,2048,0,0,0,0,0,0,278,413,58,7,10,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,'SmartAI',0,3,1,1000,300,1,0,0,1,0,2,'',0),
(@ENTRY := @ENTRY + 1,0,0,0,0,0,19017,0,0,0,'Kor''kron Honor Guard','',NULL,0,73,73,1,1735,0,1,(9.7/7),1,1,316,450,0,320,7.5,1400,1900,1,320,2048,0,0,0,0,0,0,278,413,58,7,10,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,'SmartAI',0,3,1,1000,300,1,0,0,1,0,2,'',0),
(@ENTRY := @ENTRY + 1,0,0,0,0,0,19016,19519,0,0,'Kor''kron Warrior','',NULL,0,71,72,1,1735,0,1,(9.7/7),1,1,307,438,0,314,7.5,1400,1900,1,320,2048,0,0,0,0,0,0,270,401,53,7,10,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,'SmartAI',1,3,1,1000,300,1,0,0,1,0,2,'',0),
(@ENTRY := @ENTRY + 1,0,0,0,0,0,19016,19519,0,0,'Kor''kron Warrior','',NULL,0,71,72,1,1735,0,1,(9.7/7),1,1,307,438,0,314,7.5,1400,1900,1,320,2048,0,0,0,0,0,0,270,401,53,7,10,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,'SmartAI',1,3,1,1000,300,1,0,0,1,0,2,'',0),
(@ENTRY := @ENTRY + 1,0,0,0,0,0,19016,19519,0,0,'Kor''kron Warrior','',NULL,0,71,72,1,1735,0,1,(9.7/7),1,1,307,438,0,314,7.5,1400,1900,1,320,2048,0,0,0,0,0,0,270,401,53,7,10,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,'SmartAI',1,3,1,1000,300,1,0,0,1,0,2,'',0),
(@ENTRY := @ENTRY + 1,0,0,0,0,0,19016,19519,0,0,'Kor''kron Warrior','',NULL,0,71,72,1,1735,0,1,(9.7/7),1,1,307,438,0,314,7.5,1400,1900,1,320,2048,0,0,0,0,0,0,270,401,53,7,10,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,'SmartAI',1,3,1,1000,300,1,0,0,1,0,2,'',0),
(@ENTRY := @ENTRY + 1,0,0,0,0,0,19016,19519,0,0,'Kor''kron Warrior','',NULL,0,71,72,1,1735,0,1,(9.7/7),1,1,307,438,0,314,7.5,1400,1900,1,320,2048,0,0,0,0,0,0,270,401,53,7,10,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,'SmartAI',1,3,1,1000,300,1,0,0,1,0,2,'',0),
(@ENTRY := @ENTRY + 1,0,0,0,0,0,19016,19519,0,0,'Kor''kron Warrior','',NULL,0,71,72,1,1735,0,1,(9.7/7),1,1,307,438,0,314,7.5,1400,1900,1,320,2048,0,0,0,0,0,0,270,401,53,7,10,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,'SmartAI',1,3,1,1000,300,1,0,0,1,0,2,'',0),
(@ENTRY := @ENTRY + 1,0,0,0,0,0,19016,19519,0,0,'Kor''kron Warrior','',NULL,0,71,72,1,1735,0,1,(9.7/7),1,1,307,438,0,314,7.5,1400,1900,1,320,2048,0,0,0,0,0,0,270,401,53,7,10,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,'SmartAI',1,3,1,1000,300,1,0,0,1,0,2,'',0),
(@ENTRY := @ENTRY + 1,0,0,0,0,0,19016,19519,0,0,'Kor''kron Warrior','',NULL,0,71,72,1,1735,0,1,(9.7/7),1,1,307,438,0,314,7.5,1400,1900,1,320,2048,0,0,0,0,0,0,270,401,53,7,10,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,'SmartAI',1,3,1,1000,300,1,0,0,1,0,2,'',0),
(@ENTRY := @ENTRY + 1,0,0,0,0,0,19016,19519,0,0,'Kor''kron Warrior','',NULL,0,71,72,1,1735,0,1,(9.7/7),1,1,307,438,0,314,7.5,1400,1900,1,320,2048,0,0,0,0,0,0,270,401,53,7,10,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,'SmartAI',1,3,1,1000,300,1,0,0,1,0,2,'',0),
(@ENTRY := @ENTRY + 1,0,0,0,0,0,19016,19519,0,0,'Kor''kron Warrior','',NULL,0,71,72,1,1735,0,1,(9.7/7),1,1,307,438,0,314,7.5,1400,1900,1,320,2048,0,0,0,0,0,0,270,401,53,7,10,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,'SmartAI',1,3,1,1000,300,1,0,0,1,0,2,'',0),
(@ENTRY := @ENTRY + 1,0,0,0,0,0,19016,19519,0,0,'Kor''kron Warrior','',NULL,0,71,72,1,1735,0,1,(9.7/7),1,1,307,438,0,314,7.5,1400,1900,1,320,2048,0,0,0,0,0,0,270,401,53,7,10,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,'SmartAI',1,3,1,1000,300,1,0,0,1,0,2,'',0),
(@ENTRY := @ENTRY + 1,0,0,0,0,0,19016,19519,0,0,'Kor''kron Warrior','',NULL,0,71,72,1,1735,0,1,(9.7/7),1,1,307,438,0,314,7.5,1400,1900,1,320,2048,0,0,0,0,0,0,270,401,53,7,10,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,'SmartAI',1,3,1,1000,300,1,0,0,1,0,2,'',0),
(@ENTRY := @ENTRY + 1,0,0,0,0,0,19016,19519,0,0,'Kor''kron Warrior','',NULL,0,71,72,1,1735,0,1,(9.7/7),1,1,307,438,0,314,7.5,1400,1900,1,320,2048,0,0,0,0,0,0,270,401,53,7,10,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,'SmartAI',1,3,1,1000,300,1,0,0,1,0,2,'',0),
(@ENTRY := @ENTRY + 1,0,0,0,0,0,19016,19519,0,0,'Kor''kron Warrior','',NULL,0,71,72,1,1735,0,1,(9.7/7),1,1,307,438,0,314,7.5,1400,1900,1,320,2048,0,0,0,0,0,0,270,401,53,7,10,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,'SmartAI',1,3,1,1000,300,1,0,0,1,0,2,'',0),
(@ENTRY := @ENTRY + 1,0,0,0,0,0,19016,19519,0,0,'Kor''kron Warrior','',NULL,0,71,72,1,1735,0,1,(9.7/7),1,1,307,438,0,314,7.5,1400,1900,1,320,2048,0,0,0,0,0,0,270,401,53,7,10,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,'SmartAI',1,3,1,1000,300,1,0,0,1,0,2,'',0),
(@ENTRY := @ENTRY + 1,0,0,0,0,0,19016,19519,0,0,'Kor''kron Warrior','',NULL,0,71,72,1,1735,0,1,(9.7/7),1,1,307,438,0,314,7.5,1400,1900,1,320,2048,0,0,0,0,0,0,270,401,53,7,10,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,'SmartAI',1,3,1,1000,300,1,0,0,1,0,2,'',0),
(@ENTRY := @ENTRY + 1,0,0,0,0,0,19016,19519,0,0,'Kor''kron Warrior','',NULL,0,71,72,1,1735,0,1,(9.7/7),1,1,307,438,0,314,7.5,1400,1900,1,320,2048,0,0,0,0,0,0,270,401,53,7,10,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,'SmartAI',1,3,1,1000,300,1,0,0,1,0,2,'',0),
(@ENTRY := @ENTRY + 1,0,0,0,0,0,19016,19519,0,0,'Kor''kron Warrior','',NULL,0,71,72,1,1735,0,1,(9.7/7),1,1,307,438,0,314,7.5,1400,1900,1,320,2048,0,0,0,0,0,0,270,401,53,7,10,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,'SmartAI',1,3,1,1000,300,1,0,0,1,0,2,'',0);

-- Remove reward from quest "There Is No Hope" and add it to "Hero of the Mag'har" as it was originally the case
UPDATE `quest_template` SET `RewardItem1` = 0, `RewardChoiceItemId1` = 0, `RewardChoiceItemId2` = 0, `RewardChoiceItemId3` = 0, `RewardChoiceItemId4` = 0,
`RewardAmount1` = 0, `RewardChoiceItemQuantity1` = 0, `RewardChoiceItemQuantity2` = 0, `RewardChoiceItemQuantity3` = 0, `RewardChoiceItemQuantity4` = 0 WHERE `ID` = 10172;
UPDATE `quest_template` SET `RewardItem1` = 28168, `RewardChoiceItemId1` = 28173, `RewardChoiceItemId2` = 28169, `RewardChoiceItemId3` = 28172, `RewardChoiceItemId4` = 28175,
`RewardAmount1` = 1, `RewardChoiceItemQuantity1` = 1, `RewardChoiceItemQuantity2` = 1, `RewardChoiceItemQuantity3` = 1, `RewardChoiceItemQuantity4` = 1 WHERE `ID` = 10212;

DELETE FROM `creature` WHERE `id` IN (19590,19556); -- Delete old Thrall spawn and the Thrall Event Generator
DELETE FROM `creature_addon` WHERE `guid` = 86751; -- Delete old Thrall creature addon
DELETE FROM `waypoint_data` WHERE `id` = 867510; -- Delete old Thrall waypoints

-- Fix Thrall using an invisible model
UPDATE `creature_model_info` SET `DisplayID_Other_Gender` = 0 WHERE `DisplayID` = 19015; -- Old: 17612

DELETE FROM `conditions` WHERE `SourceEntry` = 34378;
INSERT INTO `conditions`
(`SourceTypeOrReferenceId`,`SourceGroup`,`SourceEntry`,`SourceId`,`ElseGroup`,`ConditionTypeOrReference`,`ConditionTarget`,`ConditionValue1`,`ConditionValue2`,`ConditionValue3`,`NegativeCondition`,`ErrorType`,`ErrorTextId`,`ScriptName`,`Comment`)
VALUES
(13,1,34378,0,0,31,0,3,18228,0,0,0,0,'','Thrall Calls Thunder - target Garadar Event Controller (Farseer)');

UPDATE `creature_template` SET `MovementType` = 0, `AIName` = 'SmartAI' WHERE `entry` = 19590; -- Thrall Event Generator
UPDATE `creature_template` SET `MovementType` = 0, `speed_walk` = 1, `speed_run` = (9.7/7), `unit_flags` = 320, `npcflag` = 0, `AIName` = 'SmartAI' WHERE `entry` = 19556; -- Thrall
UPDATE `creature_template` SET `MovementType` = 0, `speed_walk` = 1, `speed_run` = (9.7/7), `unit_flags` = 320, `flags_extra` = 2, `AIName` = 'SmartAI' WHERE `entry` = 19604; -- Drek'thar
UPDATE `creature_template` SET `speed_walk` = 1, `AIName` = 'SmartAI' WHERE `entry` = 18063; -- Garrosh
UPDATE `creature_template` SET `speed_walk` = 1, `MovementType` = 0, `unit_flags` = 33555264, `flags_extra` = 0, `AIName` = 'SmartAI' WHERE `entry` = 19647; -- Mini Thrall
UPDATE `creature_template` SET `MovementType` = 0, `unit_flags` = 33555200, `type` = 3, `AIName` = 'SmartAI' WHERE `entry` = 18075; -- Mannoroth
UPDATE `creature_template` SET `MovementType` = 0, `unit_flags` = 33555200, `flags_extra` = 0, `AIName` = 'SmartAI' WHERE `entry` = 18076; -- Grom Hellscream
UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 18489; -- Garadar Defender

DELETE FROM `creature_template_addon` WHERE `entry` in (19556,19604,19647,18076);
INSERT INTO `creature_template_addon` (`entry`,`path_id`,`mount`,`bytes1`,`bytes2`,`emote`,`auras`)
VALUES
(19556,0,19014,0,0,0,NULL), -- Thrall's mount
(19604,0,19040,0,0,0,NULL), -- Drek'thar's mount
(19647,0,0,0,1,375,NULL), -- Mini Thrall 
(18076,0,0,0,1,375,NULL); -- Grom Hellscream

-- Mounts for Kor'kron Honor Guard and Kor'kron Warrior
SET @ENTRY := 182753;
DELETE FROM `creature_template_addon` WHERE `entry` BETWEEN @ENTRY AND @ENTRY + 19;
INSERT INTO `creature_template_addon` (`entry`,`path_id`,`mount`,`bytes1`,`bytes2`,`emote`,`auras`)
VALUES
(@ENTRY,0,207,0,0,0,NULL),
(@ENTRY := @ENTRY + 1,0,1166,0,0,0,NULL),
(@ENTRY := @ENTRY + 1,0,2327,0,0,0,NULL),
(@ENTRY := @ENTRY + 1,0,2328,0,0,0,NULL),
(@ENTRY := @ENTRY + 1,0,2327,0,0,0,NULL),
(@ENTRY := @ENTRY + 1,0,1166,0,0,0,NULL),
(@ENTRY := @ENTRY + 1,0,1166,0,0,0,NULL),
(@ENTRY := @ENTRY + 1,0,2328,0,0,0,NULL),
(@ENTRY := @ENTRY + 1,0,2328,0,0,0,NULL),
(@ENTRY := @ENTRY + 1,0,1166,0,0,0,NULL),
(@ENTRY := @ENTRY + 1,0,207,0,0,0,NULL),
(@ENTRY := @ENTRY + 1,0,2327,0,0,0,NULL),
(@ENTRY := @ENTRY + 1,0,207,0,0,0,NULL),
(@ENTRY := @ENTRY + 1,0,2328,0,0,0,NULL),
(@ENTRY := @ENTRY + 1,0,207,0,0,0,NULL),
(@ENTRY := @ENTRY + 1,0,2328,0,0,0,NULL),
(@ENTRY := @ENTRY + 1,0,2327,0,0,0,NULL),
(@ENTRY := @ENTRY + 1,0,207,0,0,0,NULL),
(@ENTRY := @ENTRY + 1,0,1166,0,0,0,NULL),
(@ENTRY := @ENTRY + 1,0,2327,0,0,0,NULL);

DELETE FROM `creature_text` WHERE `CreatureID` IN (19556);
INSERT INTO `creature_text` (`CreatureID`,`GroupID`,`ID`,`Text`,`Type`,`Language`,`Probability`,`Emote`,`Duration`,`Sound`,`BroadcastTextId`,`TextRange`,`comment`)
VALUES
(19556,0,0,'War drums echo in the distance.',16,0,100,0,0,0,16980,2,'Thrall event starts - emote visible in the entire zone (Nagrand)'),
(19556,1,0,'At long last, I am home...',14,1,100,22,0,0,16996,2,'Thrall event starts - yell visible in the entire zone (Nagrand)'),
(19556,2,0,'Hellscream! Blessed ancestors! He is the mirrored reflection of Grom, Drek''Thar.',12,1,100,25,0,0,17080,0,'Thrall meeting Garrosh, part 1'),
(19556,3,0,'I am sorry that I did not come sooner, young Hellscream. There is so much that I have to tell you about your father, but first you must tell me where I may find the Greatmother.',12,1,100,1,0,0,17096,0,'Thrall meeting Garrosh, part 1'),
(19556,4,0,'I thank you, Garrosh. We have much to discuss when I return from my visit with the Greatmother.',12,1,100,1,0,0,17100,0,'Thrall meeting Garrosh, part 1'),
(19556,5,0,'Greatmother...',12,1,100,1,0,0,17102,0,'Thrall meeting Greatmother, part 1'),
(19556,6,0,'Greatmother...Am I...',12,1,100,6,0,0,17113,0,'Thrall meeting Greatmother, part 1'),
(19556,7,0,'They... did not, Greatmother. They were killed shortly after I was born. I never knew them. I was raised as a slave. To this day, I carry the name of Thrall.',12,1,100,1,0,0,17122,0,'Thrall meeting Greatmother, part 1'),
(19556,8,0,'I have dreamed of this moment all my life, Greatmother. ''Till now, all I''ve had were Orgrim''s stories about my parents and their adventures on Draenor. He was my greatest teacher and dearest friend. He died a hero... They all died as heroes - and for all of them, a song of honor remains.',12,1,100,1,0,0,17928,0,'Thrall meeting Greatmother, part 1'),
(19556,9,0,'They died honorably, Greatmother.',12,1,100,273,0,0,17124,0,'Thrall meeting Greatmother, part 1'),
(19556,10,0,'He died our greatest hero. It was Grom who freed us all... I was by his side when he struck down Mannoroth and ended the curse forever.',12,1,100,1,0,0,17128,0,'Thrall meeting Greatmother, part 1'),
(19556,11,0,'Tell him? Greatmother, that boy''s father died so that all of us could live free of the blood curse. I will tell him nothing. I will show him! Show him and any that would doubt Hellscream''s resolve exactly what Grom Hellscream did for all orcs!',12,1,100,1,0,0,17132,0,'Thrall meeting Greatmother, part 1'),
(19556,12,0,'Please excuse me, Greatmother. I will return soon.',12,1,100,2,0,0,17133,0,'Thrall meeting Greatmother, part 1'),
(19556,13,0,'Garrosh, son of Hellscream, your father lived and died as our greatest hero. Honor me by allowing me to show you what your father sacrificed so that we could live free of the demon''s grasp.',12,1,100,25,0,0,17134,0,'Thrall meeting Garrosh, part 2'),
(19556,14,0,'Spirits give me strength! Take from my soul these old wounds and expose them for all to see! Let this child know his father! Let these people know their savior!',12,1,100,25,0,0,17136,0,'Event at the blue circle'),
(19556,15,0,'%s places a hand on Garrosh''s shoulder.',16,0,100,0,0,0,17172,0,'Event at the blue circle'),
(19556,16,0,'You need not thank me, Garrosh. Your father was a brother to me. I would do anything for you and the Mag''har. I must now return to the Greatmother.',12,1,100,1,0,0,17173,0,'Event at the blue circle'),
(19556,17,0,'I have returned, Greatmother. Garrosh has found his heart and his fury.',12,1,100,1,0,0,17175,0,'Thrall meeting Greatmother, part 2');

DELETE FROM `creature_text` WHERE `CreatureID` IN (18063);
INSERT INTO `creature_text` (`CreatureID`,`GroupID`,`ID`,`Text`,`Type`,`Language`,`Probability`,`Emote`,`Duration`,`Sound`,`BroadcastTextId`,`TextRange`,`comment`)
VALUES
(18063,0,0,'We are honored by your presence, son of Durotan. The Greatmother awaits you at the hospice.',12,1,100,2,0,0,17098,0,'Thrall meeting Garrosh, part 1'),
(18063,1,0,'%s points towards the hospice.',16,0,100,25,0,0,17099,0,'Thrall meeting Garrosh, part 1'),
(18063,2,0,'As you wish, Thrall, son of Durotan.',12,1,100,1,0,0,17135,0,'Thrall meeting Garrosh, part 2'),
(18063,3,0,'%s collapses.',16,0,100,0,0,0,17163,0,'Event at the blue circle'),
(18063,4,0,'For my entire life I have thought my bloodline cursed. I have lived beneath the shadow of my father''s greatest failure.',12,1,100,1,0,0,17164,0,'Event at the blue circle'),
(18063,5,0,'I hated him for what he had done. I hated him for the burden he left me. But now...',12,1,100,1,0,0,17166,0,'Event at the blue circle'),
(18063,6,0,'You have shown me truths that I would have never known. You and your allies have gifted me with something that cannot bear a price: Redemption. Thrall, redeemer of the Mag''har, you honor me as none ever have...',12,1,100,1,0,0,17167,0,'Event at the blue circle'),
(18063,7,0,'On this day, a great burden has been lifted from my chest. My heart swells with pride. And for the first time, I can proudly proclaim who I am. I can finally unleash the fury in my heart.',12,1,100,1,0,0,17168,0,'Event at the blue circle'),
(18063,8,0,'I am Garrosh Hellscream, son of Grom, chieftain of the Mag''har! Let the battle call of Hellscream give you courage and strength! Be lifted by my rallying cry.',14,1,100,15,0,0,17169,0,'Event at the blue circle'),
(18063,9,0,'Thank you, son of Durotan.',12,1,100,2,0,0,17171,0,'Event at the blue circle');

DELETE FROM `creature_text` WHERE `CreatureID` IN (18141);
INSERT INTO `creature_text` (`CreatureID`,`GroupID`,`ID`,`Text`,`Type`,`Language`,`Probability`,`Emote`,`Duration`,`Sound`,`BroadcastTextId`,`TextRange`,`comment`)
VALUES
(18141,0,0,'I have been expecting you, young one. Come closer - my eyes are not as sharp as they once were.',12,1,100,273,0,0,17101,0,'Thrall meeting Greatmother, part 1'),
(18141,1,0,'Yes, you move like my son. You have his broad shoulders - ahh, and your mother''s fierce eyes.',12,1,100,1,0,0,17120,0,'Thrall meeting Greatmother, part 1'),
(18141,2,0,'There is no doubt - you are the heir of Durotan... my grandson. Draka told me she was with child before she and your father left our world, but I never dared dream that they would survive...',12,1,100,1,0,0,17123,0,'Thrall meeting Greatmother, part 1'),
(18141,3,0,'Thrall? You''ve been a slave only to the past, grandson! But no more! When last I saw him, Durotan told me the name he would give his unborn son... He was... so proud...',12,1,100,1,0,0,17126,0,'Thrall meeting Greatmother, part 1'),
(18141,4,0,'%s wipes a tear away.',16,0,100,0,0,0,17926,0,'Thrall meeting Greatmother, part 1'),
(18141,5,0,'Go''el. You are Go''el, son of Durotan - rightful chieftain of the Frostwolves. This day, grandson - you are the great joy of my heart.',12,1,100,1,0,0,17927,0,'Thrall meeting Greatmother, part 1'),
(18141,6,0,'I see that you hold the Doomhammer. Have all of our greatest heroes fallen, grandson?',12,1,100,1,0,0,17929,0,'Thrall meeting Greatmother, part 1'),
(18141,7,0,'What of Grommash? What of Hellscream?',12,1,100,6,0,0,17930,0,'Thrall meeting Greatmother, part 1'),
(18141,8,0,'Blessed spirits! For twenty years, all we knew was that Grom was the first to drink from the cursed chalice and bring damnation down upon our people... It is the only truth his son, Garrosh has ever known.',12,1,100,1,0,0,17129,0,'Thrall meeting Greatmother, part 1'),
(18141,9,0,'Grandson, will you... Will you tell Garrosh what you have told me about his father?',12,1,100,1,0,0,17131,0,'Thrall meeting Greatmother, part 1');

DELETE FROM `creature_text` WHERE `CreatureID` IN (18075);
INSERT INTO `creature_text` (`CreatureID`,`GroupID`,`ID`,`Text`,`Type`,`Language`,`Probability`,`Emote`,`Duration`,`Sound`,`BroadcastTextId`,`TextRange`,`comment`)
VALUES
(18075,0,0,'%s laughs.',16,0,100,0,0,10624,17137,0,'Event at the blue circle'),
(18075,1,0,'So predictable. I knew you would come. And I see you''ve brought the mighty Hellscream.',12,1,100,1,0,10625,17138,0,'Event at the blue circle'),
(18075,2,0,'His blood is mine, as is your whole misbegotten race.',12,1,100,1,0,10626,17139,0,'Event at the blue circle'),
(18075,3,0,'A worthy effort, but futile.',12,1,100,1,0,10627,17141,0,'Event at the blue circle'),
(18075,4,0,'%s laughs.',16,0,100,0,0,0,17137,0,'Event at the blue circle'),
(18075,5,0,'The boy believed you could be saved, but he didn''t know what burns within your soul when in your heart, you know we are the same.',12,1,100,1,0,10628,17142,0,'Event at the blue circle');

DELETE FROM `creature_text` WHERE `CreatureID` IN (18076);
INSERT INTO `creature_text` (`CreatureID`,`GroupID`,`ID`,`Text`,`Type`,`Language`,`Probability`,`Emote`,`Duration`,`Sound`,`BroadcastTextId`,`TextRange`,`comment`)
VALUES
(18076,0,0,'NOOOO!',12,1,100,15,0,0,17144,0,'Event at the blue circle'),
(18076,1,0,'Thrall... The blood haze has lifted.',12,1,100,0,0,10629,17150,0,'Event at the blue circle'),
(18076,2,0,'Grom''s eyes go dim as the blood curse is lifted.',16,0,100,0,0,0,17151,0,'Event at the blue circle'),
(18076,3,0,'The demon''s fire has burnt out in my veins. I have... freed myself.',12,1,100,0,0,10630,17152,0,'Event at the blue circle');

DELETE FROM `creature_text` WHERE `CreatureID` IN (19647);
INSERT INTO `creature_text` (`CreatureID`,`GroupID`,`ID`,`Text`,`Type`,`Language`,`Probability`,`Emote`,`Duration`,`Sound`,`BroadcastTextId`,`TextRange`,`comment`)
VALUES
(19647,0,0,'%s roars in defiance.',16,0,100,15,0,0,17140,0,'Event at the blue circle'),
(19647,1,0,'No, old friend. You''ve freed us all...',12,1,100,0,0,10631,17153,0,'Event at the blue circle');

DELETE FROM `creature_text` WHERE `CreatureID` IN (18489);
INSERT INTO `creature_text` (`CreatureID`,`GroupID`,`ID`,`Text`,`Type`,`Language`,`Probability`,`Emote`,`Duration`,`Sound`,`BroadcastTextId`,`TextRange`,`comment`)
VALUES
(18489,0,0,'Who is he? He looks so familiar.',12,1,100,1,0,0,17005,0,'Garadar Defender greets Thrall - random text'),
(18489,0,1,'Are the rumors true? Does he truly carry the Greatmother''s bloodline?',12,1,100,1,0,0,17006,0,'Garadar Defender greets Thrall - random text'),
(18489,0,2,'Could it really be? The son of Durotan?',12,1,100,1,0,0,17007,0,'Garadar Defender greets Thrall - random text'),
(18489,0,3,'Has he come to lead us?',12,1,100,1,0,0,17008,0,'Garadar Defender greets Thrall - random text'),
(18489,0,4,'I have never felt such strength radiate from an orc. Is he... mortal...',12,1,100,1,0,0,17009,0,'Garadar Defender greets Thrall - random text'),
(18489,0,5,'He carries the Doomhammer!',12,1,100,1,0,0,17010,0,'Garadar Defender greets Thrall - random text'),
(18489,0,6,'For the first time, I feel safe. I do not know you, stranger, but I know that I would lay down my life for you if only you asked.',12,1,100,1,0,0,17011,0,'Garadar Defender greets Thrall - random text'),
(18489,0,7,'Son of Durotan... Grandson of Garad and Geyah... Bow your heads for a Warchief is among us...',12,1,100,1,0,0,17012,0,'Garadar Defender greets Thrall - random text');

DELETE FROM `smart_scripts` WHERE `entryorguid` = 18489 AND `source_type` = 0;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`)
VALUES
(18489,0,0,0,75,0,100,1,0,19556,5,0,0,80,1848900,2,0,0,0,0,1,0,0,0,0,0,0,0,0,'Garadar Defender - On Within 5 Yards of Thrall (19556) - Run Script');

DELETE FROM `smart_scripts` WHERE `entryorguid` = 1848900 AND `source_type` = 9;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`)
VALUES
(1848900,9,0,0,0,0,100,0,4000,6000,0,0,0,66,0,0,0,0,0,0,11,19556,20,1,0,0,0,0,0,'Garadar Defender - On Script - Set Orientation'),
(1848900,9,1,0,0,0,75,0,2000,2000,0,0,0,1,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Garadar Defender - On Script - Say Line 0'),
(1848900,9,2,0,0,0,100,0,4000,4000,0,0,0,90,8,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Garadar Defender - On Script - Set ''UNIT_STAND_STATE_KNEEL'''),
(1848900,9,3,0,0,0,100,0,600000,600000,0,0,0,91,8,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Garadar Defender - On Script - Remove ''UNIT_STAND_STATE_KNEEL'''),
(1848900,9,4,0,0,0,100,0,1000,1000,0,0,0,66,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Garadar Defender - On Script - Reset Orientation'),
(1848900,9,5,0,0,0,100,0,0,0,0,0,0,78,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Garadar Defender - On Script - Reset Script');

DELETE FROM `smart_scripts` WHERE `entryorguid` = 18141 AND `id` = 3 AND `source_type` = 0;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`)
VALUES
(18141,0,3,0,20,0,100,1,10212,0,0,0,0,80,1814100,2,0,0,0,0,1,0,0,0,0,0,0,0,0,'Greatmother Geyah - On Quest ''Hero of the Mag''har'' Rewarded - Run Script');

DELETE FROM `smart_scripts` WHERE `entryorguid` = 1814100 AND `source_type` = 9;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`)
VALUES
(1814100,9,0,0,0,0,100,0,0,0,0,0,0,48,1,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Greatmother Geyah - On Script - Set Active On'), -- Set active or otherwise the despawn timer won't work if no player is near
(1814100,9,1,0,0,0,100,0,0,0,0,0,0,12,19590,3,5000,0,0,0,1,0,0,0,0,0,0,0,0,'Greatmother Geyah - On Script - Summon Thrall Event Generator (19590)'),
(1814100,9,2,0,0,0,100,0,0,0,0,0,0,41,21600000,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Greatmother Geyah - On Script - Force Despawn after 6h');

SET @ENTRY := 182753;
DELETE FROM `smart_scripts` WHERE `entryorguid` BETWEEN @ENTRY AND @ENTRY + 19 AND `source_type` = 0;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`)
VALUES
(@ENTRY,0,0,1,63,0,100,1,0,0,0,0,0,48,1,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Kor''kron Honor Guard - On Just Created - Set Active On'), -- Set active or otherwise the despawn timer won't work if no player is near
(@ENTRY,0,1,2,61,0,100,1,0,0,0,0,0,53,1,@ENTRY * 10,0,0,0,0,1,0,0,0,0,0,0,0,0,'Kor''kron Honor Guard - Linked - Start Waypoint Movement'),
(@ENTRY,0,2,0,61,0,100,1,0,0,0,0,0,54,20000,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Kor''kron Honor Guard - Linked - Pause Waypoint Movement'),
(@ENTRY,0,3,0,58,0,100,1,0,0,0,0,0,67,1,500,500,0,0,0,8,0,0,0,0,0,0,0,0,'Kor''kron Honor Guard - On Waypoint Ended - Create Timed Event ID 1'),
(@ENTRY,0,4,0,59,0,100,1,1,0,0,0,0,66,0,0,0,0,0,0,8,0,0,0,0,0,0,0,2.513274,'Kor''kron Honor Guard - On Timed Event ID 1 - Set Orientation'),
(@ENTRY := @ENTRY + 1,0,0,1,63,0,100,1,0,0,0,0,0,48,1,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Kor''kron Honor Guard - On Just Created - Set Active On'), -- Set active or otherwise the despawn timer won't work if no player is near
(@ENTRY,0,1,2,61,0,100,1,0,0,0,0,0,53,1,@ENTRY * 10,0,0,0,0,1,0,0,0,0,0,0,0,0,'Kor''kron Honor Guard - Linked - Start Waypoint Movement'),
(@ENTRY,0,2,0,61,0,100,1,0,0,0,0,0,54,18000,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Kor''kron Honor Guard - Linked - Pause Waypoint Movement'),
(@ENTRY,0,3,0,58,0,100,1,0,0,0,0,0,67,1,500,500,0,0,0,8,0,0,0,0,0,0,0,0,'Kor''kron Honor Guard - On Waypoint Ended - Create Timed Event ID 1'),
(@ENTRY,0,4,0,59,0,100,1,1,0,0,0,0,66,0,0,0,0,0,0,8,0,0,0,0,0,0,0,5.689773,'Kor''kron Honor Guard - On Timed Event ID 1 - Set Orientation'),
(@ENTRY := @ENTRY + 1,0,0,1,63,0,100,1,0,0,0,0,0,53,1,@ENTRY * 10,0,0,0,0,1,0,0,0,0,0,0,0,0,'Kor''kron Warrior - On Just Created - Start Waypoint Movement'),
(@ENTRY,0,1,0,61,0,100,1,0,0,0,0,0,54,20700,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Kor''kron Warrior - Linked - Pause Waypoint Movement'),
(@ENTRY,0,2,0,58,0,100,1,0,0,0,0,0,67,1,500,500,0,0,0,8,0,0,0,0,0,0,0,0,'Kor''kron Warrior - On Waypoint Ended - Create Timed Event ID 1'),
(@ENTRY,0,3,0,59,0,100,1,1,0,0,0,0,66,0,0,0,0,0,0,8,0,0,0,0,0,0,0,2.513227,'Kor''kron Warrior - On Timed Event ID 1 - Set Orientation'),
(@ENTRY := @ENTRY + 1,0,0,1,63,0,100,1,0,0,0,0,0,53,1,@ENTRY * 10,0,0,0,0,1,0,0,0,0,0,0,0,0,'Kor''kron Warrior - On Just Created - Start Waypoint Movement'),
(@ENTRY,0,1,0,61,0,100,1,0,0,0,0,0,54,20000,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Kor''kron Warrior - Linked - Pause Waypoint Movement'),
(@ENTRY,0,2,0,58,0,100,1,0,0,0,0,0,67,1,500,500,0,0,0,8,0,0,0,0,0,0,0,0,'Kor''kron Warrior - On Waypoint Ended - Create Timed Event ID 1'),
(@ENTRY,0,3,0,59,0,100,1,1,0,0,0,0,66,0,0,0,0,0,0,8,0,0,0,0,0,0,0,2.590019,'Kor''kron Warrior - On Timed Event ID 1 - Set Orientation'),
(@ENTRY := @ENTRY + 1,0,0,1,63,0,100,1,0,0,0,0,0,53,1,@ENTRY * 10,0,0,0,0,1,0,0,0,0,0,0,0,0,'Kor''kron Warrior - On Just Created - Start Waypoint Movement'),
(@ENTRY,0,1,0,61,0,100,1,0,0,0,0,0,54,20000,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Kor''kron Warrior - Linked - Pause Waypoint Movement'),
(@ENTRY,0,2,0,58,0,100,1,0,0,0,0,0,67,1,500,500,0,0,0,8,0,0,0,0,0,0,0,0,'Kor''kron Warrior - On Waypoint Ended - Create Timed Event ID 1'),
(@ENTRY,0,3,0,59,0,100,1,1,0,0,0,0,66,0,0,0,0,0,0,8,0,0,0,0,0,0,0,2.703437,'Kor''kron Warrior - On Timed Event ID 1 - Set Orientation'),
(@ENTRY := @ENTRY + 1,0,0,1,63,0,100,1,0,0,0,0,0,53,1,@ENTRY * 10,0,0,0,0,1,0,0,0,0,0,0,0,0,'Kor''kron Warrior - On Just Created - Start Waypoint Movement'),
(@ENTRY,0,1,0,61,0,100,1,0,0,0,0,0,54,20500,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Kor''kron Warrior - Linked - Pause Waypoint Movement'),
(@ENTRY,0,2,0,58,0,100,1,0,0,0,0,0,67,1,500,500,0,0,0,8,0,0,0,0,0,0,0,0,'Kor''kron Warrior - On Waypoint Ended - Create Timed Event ID 1'),
(@ENTRY,0,3,0,59,0,100,1,1,0,0,0,0,66,0,0,0,0,0,0,8,0,0,0,0,0,0,0,2.331536,'Kor''kron Warrior - On Timed Event ID 1 - Set Orientation'),
(@ENTRY := @ENTRY + 1,0,0,1,63,0,100,1,0,0,0,0,0,53,1,@ENTRY * 10,0,0,0,0,1,0,0,0,0,0,0,0,0,'Kor''kron Warrior - On Just Created - Start Waypoint Movement'),
(@ENTRY,0,1,0,61,0,100,1,0,0,0,0,0,54,20700,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Kor''kron Warrior - Linked - Pause Waypoint Movement'),
(@ENTRY,0,2,0,58,0,100,1,0,0,0,0,0,67,1,500,500,0,0,0,8,0,0,0,0,0,0,0,0,'Kor''kron Warrior - On Waypoint Ended - Create Timed Event ID 1'),
(@ENTRY,0,3,0,59,0,100,1,1,0,0,0,0,66,0,0,0,0,0,0,8,0,0,0,0,0,0,0,2.752744,'Kor''kron Warrior - On Timed Event ID 1 - Set Orientation'),
(@ENTRY := @ENTRY + 1,0,0,1,63,0,100,1,0,0,0,0,0,53,1,@ENTRY * 10,0,0,0,0,1,0,0,0,0,0,0,0,0,'Kor''kron Warrior - On Just Created - Start Waypoint Movement'),
(@ENTRY,0,1,0,61,0,100,1,0,0,0,0,0,54,20500,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Kor''kron Warrior - Linked - Pause Waypoint Movement'),
(@ENTRY,0,2,0,58,0,100,1,0,0,0,0,0,67,1,500,500,0,0,0,8,0,0,0,0,0,0,0,0,'Kor''kron Warrior - On Waypoint Ended - Create Timed Event ID 1'),
(@ENTRY,0,3,0,59,0,100,1,1,0,0,0,0,66,0,0,0,0,0,0,8,0,0,0,0,0,0,0,2.397198,'Kor''kron Warrior - On Timed Event ID 1 - Set Orientation'),
(@ENTRY := @ENTRY + 1,0,0,1,63,0,100,1,0,0,0,0,0,53,1,@ENTRY * 10,0,0,0,0,1,0,0,0,0,0,0,0,0,'Kor''kron Warrior - On Just Created - Start Waypoint Movement'),
(@ENTRY,0,1,0,61,0,100,1,0,0,0,0,0,54,20000,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Kor''kron Warrior - Linked - Pause Waypoint Movement'),
(@ENTRY,0,2,0,58,0,100,1,0,0,0,0,0,67,1,500,500,0,0,0,8,0,0,0,0,0,0,0,0,'Kor''kron Warrior - On Waypoint Ended - Create Timed Event ID 1'),
(@ENTRY,0,3,0,59,0,100,1,1,0,0,0,0,66,0,0,0,0,0,0,8,0,0,0,0,0,0,0,2.455589,'Kor''kron Warrior - On Timed Event ID 1 - Set Orientation'),
(@ENTRY := @ENTRY + 1,0,0,1,63,0,100,1,0,0,0,0,0,53,1,@ENTRY * 10,0,0,0,0,1,0,0,0,0,0,0,0,0,'Kor''kron Warrior - On Just Created - Start Waypoint Movement'),
(@ENTRY,0,1,0,61,0,100,1,0,0,0,0,0,54,20700,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Kor''kron Warrior - Linked - Pause Waypoint Movement'),
(@ENTRY,0,2,0,58,0,100,1,0,0,0,0,0,67,1,500,500,0,0,0,8,0,0,0,0,0,0,0,0,'Kor''kron Warrior - On Waypoint Ended - Create Timed Event ID 1'),
(@ENTRY,0,3,0,59,0,100,1,1,0,0,0,0,66,0,0,0,0,0,0,8,0,0,0,0,0,0,0,2.578252,'Kor''kron Warrior - On Timed Event ID 1 - Set Orientation'),
(@ENTRY := @ENTRY + 1,0,0,1,63,0,100,1,0,0,0,0,0,53,1,@ENTRY * 10,0,0,0,0,1,0,0,0,0,0,0,0,0,'Kor''kron Warrior - On Just Created - Start Waypoint Movement'),
(@ENTRY,0,1,0,61,0,100,1,0,0,0,0,0,54,19800,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Kor''kron Warrior - Linked - Pause Waypoint Movement'),
(@ENTRY,0,2,0,58,0,100,1,0,0,0,0,0,67,1,500,500,0,0,0,8,0,0,0,0,0,0,0,0,'Kor''kron Warrior - On Waypoint Ended - Create Timed Event ID 1'),
(@ENTRY,0,3,0,59,0,100,1,1,0,0,0,0,66,0,0,0,0,0,0,8,0,0,0,0,0,0,0,2.519927,'Kor''kron Warrior - On Timed Event ID 1 - Set Orientation'),
(@ENTRY := @ENTRY + 1,0,0,1,63,0,100,1,0,0,0,0,0,53,1,@ENTRY * 10,0,0,0,0,1,0,0,0,0,0,0,0,0,'Kor''kron Warrior - On Just Created - Start Waypoint Movement'),
(@ENTRY,0,1,0,61,0,100,1,0,0,0,0,0,54,18300,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Kor''kron Warrior - Linked - Pause Waypoint Movement'),
(@ENTRY,0,2,0,58,0,100,1,0,0,0,0,0,67,1,500,500,0,0,0,8,0,0,0,0,0,0,0,0,'Kor''kron Warrior - On Waypoint Ended - Create Timed Event ID 1'),
(@ENTRY,0,3,0,59,0,100,1,1,0,0,0,0,66,0,0,0,0,0,0,8,0,0,0,0,0,0,0,-0.4967001,'Kor''kron Warrior - On Timed Event ID 1 - Set Orientation'),
(@ENTRY := @ENTRY + 1,0,0,1,63,0,100,1,0,0,0,0,0,53,1,@ENTRY * 10,0,0,0,0,1,0,0,0,0,0,0,0,0,'Kor''kron Warrior - On Just Created - Start Waypoint Movement'),
(@ENTRY,0,1,0,61,0,100,1,0,0,0,0,0,54,18000,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Kor''kron Warrior - Linked - Pause Waypoint Movement'),
(@ENTRY,0,2,0,58,0,100,1,0,0,0,0,0,67,1,500,500,0,0,0,8,0,0,0,0,0,0,0,0,'Kor''kron Warrior - On Waypoint Ended - Create Timed Event ID 1'),
(@ENTRY,0,3,0,59,0,100,1,1,0,0,0,0,66,0,0,0,0,0,0,8,0,0,0,0,0,0,0,-0.4495628,'Kor''kron Warrior - On Timed Event ID 1 - Set Orientation'),
(@ENTRY := @ENTRY + 1,0,0,1,63,0,100,1,0,0,0,0,0,53,1,@ENTRY * 10,0,0,0,0,1,0,0,0,0,0,0,0,0,'Kor''kron Warrior - On Just Created - Start Waypoint Movement'),
(@ENTRY,0,1,0,61,0,100,1,0,0,0,0,0,54,18000,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Kor''kron Warrior - Linked - Pause Waypoint Movement'),
(@ENTRY,0,2,0,58,0,100,1,0,0,0,0,0,67,1,500,500,0,0,0,8,0,0,0,0,0,0,0,0,'Kor''kron Warrior - On Waypoint Ended - Create Timed Event ID 1'),
(@ENTRY,0,3,0,59,0,100,1,1,0,0,0,0,66,0,0,0,0,0,0,8,0,0,0,0,0,0,0,-0.7155372,'Kor''kron Warrior - On Timed Event ID 1 - Set Orientation'),
(@ENTRY := @ENTRY + 1,0,0,1,63,0,100,1,0,0,0,0,0,53,1,@ENTRY * 10,0,0,0,0,1,0,0,0,0,0,0,0,0,'Kor''kron Warrior - On Just Created - Start Waypoint Movement'),
(@ENTRY,0,1,0,61,0,100,1,0,0,0,0,0,54,18500,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Kor''kron Warrior - Linked - Pause Waypoint Movement'),
(@ENTRY,0,2,0,58,0,100,1,0,0,0,0,0,67,1,500,500,0,0,0,8,0,0,0,0,0,0,0,0,'Kor''kron Warrior - On Waypoint Ended - Create Timed Event ID 1'),
(@ENTRY,0,3,0,59,0,100,1,1,0,0,0,0,66,0,0,0,0,0,0,8,0,0,0,0,0,0,0,-0.647477,'Kor''kron Warrior - On Timed Event ID 1 - Set Orientation'),
(@ENTRY := @ENTRY + 1,0,0,1,63,0,100,1,0,0,0,0,0,53,1,@ENTRY * 10,0,0,0,0,1,0,0,0,0,0,0,0,0,'Kor''kron Warrior - On Just Created - Start Waypoint Movement'),
(@ENTRY,0,1,0,61,0,100,1,0,0,0,0,0,54,18000,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Kor''kron Warrior - Linked - Pause Waypoint Movement'),
(@ENTRY,0,2,0,58,0,100,1,0,0,0,0,0,67,1,500,500,0,0,0,8,0,0,0,0,0,0,0,0,'Kor''kron Warrior - On Waypoint Ended - Create Timed Event ID 1'),
(@ENTRY,0,3,0,59,0,100,1,1,0,0,0,0,66,0,0,0,0,0,0,8,0,0,0,0,0,0,0,-0.647477,'Kor''kron Warrior - On Timed Event ID 1 - Set Orientation'),
(@ENTRY := @ENTRY + 1,0,0,1,63,0,100,1,0,0,0,0,0,53,1,@ENTRY * 10,0,0,0,0,1,0,0,0,0,0,0,0,0,'Kor''kron Warrior - On Just Created - Start Waypoint Movement'),
(@ENTRY,0,1,0,61,0,100,1,0,0,0,0,0,54,18000,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Kor''kron Warrior - Linked - Pause Waypoint Movement'),
(@ENTRY,0,2,0,58,0,100,1,0,0,0,0,0,67,1,500,500,0,0,0,8,0,0,0,0,0,0,0,0,'Kor''kron Warrior - On Waypoint Ended - Create Timed Event ID 1'),
(@ENTRY,0,3,0,59,0,100,1,1,0,0,0,0,66,0,0,0,0,0,0,8,0,0,0,0,0,0,0,-0.7702758,'Kor''kron Warrior - On Timed Event ID 1 - Set Orientation'),
(@ENTRY := @ENTRY + 1,0,0,1,63,0,100,1,0,0,0,0,0,53,1,@ENTRY * 10,0,0,0,0,1,0,0,0,0,0,0,0,0,'Kor''kron Warrior - On Just Created - Start Waypoint Movement'),
(@ENTRY,0,1,0,61,0,100,1,0,0,0,0,0,54,18000,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Kor''kron Warrior - Linked - Pause Waypoint Movement'),
(@ENTRY,0,2,0,58,0,100,1,0,0,0,0,0,67,1,500,500,0,0,0,8,0,0,0,0,0,0,0,0,'Kor''kron Warrior - On Waypoint Ended - Create Timed Event ID 1'),
(@ENTRY,0,3,0,59,0,100,1,1,0,0,0,0,66,0,0,0,0,0,0,8,0,0,0,0,0,0,0,-0.4417686,'Kor''kron Warrior - On Timed Event ID 1 - Set Orientation'),
(@ENTRY := @ENTRY + 1,0,0,1,63,0,100,1,0,0,0,0,0,53,1,@ENTRY * 10,0,0,0,0,1,0,0,0,0,0,0,0,0,'Kor''kron Warrior - On Just Created - Start Waypoint Movement'),
(@ENTRY,0,1,0,61,0,100,1,0,0,0,0,0,54,18700,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Kor''kron Warrior - Linked - Pause Waypoint Movement'),
(@ENTRY,0,2,0,58,0,100,1,0,0,0,0,0,67,1,500,500,0,0,0,8,0,0,0,0,0,0,0,0,'Kor''kron Warrior - On Waypoint Ended - Create Timed Event ID 1'),
(@ENTRY,0,3,0,59,0,100,1,1,0,0,0,0,66,0,0,0,0,0,0,8,0,0,0,0,0,0,0,-0.5087496,'Kor''kron Warrior - On Timed Event ID 1 - Set Orientation'),
(@ENTRY := @ENTRY + 1,0,0,1,63,0,100,1,0,0,0,0,0,53,1,@ENTRY * 10,0,0,0,0,1,0,0,0,0,0,0,0,0,'Kor''kron Warrior - On Just Created - Start Waypoint Movement'),
(@ENTRY,0,1,0,61,0,100,1,0,0,0,0,0,54,18000,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Kor''kron Warrior - Linked - Pause Waypoint Movement'),
(@ENTRY,0,2,0,58,0,100,1,0,0,0,0,0,67,1,500,500,0,0,0,8,0,0,0,0,0,0,0,0,'Kor''kron Warrior - On Waypoint Ended - Create Timed Event ID 1'),
(@ENTRY,0,3,0,59,0,100,1,1,0,0,0,0,66,0,0,0,0,0,0,8,0,0,0,0,0,0,0,-0.3588311,'Kor''kron Warrior - On Timed Event ID 1 - Set Orientation');

SET @ENTRY := 182753;
DELETE FROM `smart_scripts` WHERE `entryorguid` = 19590 AND `source_type` = 0;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`)
VALUES
(19590,0,0,1,63,0,100,1,0,0,0,0,0,12,19556,3,21600000,0,0,0,8,0,0,0,0,-1349.914,6332.778,43.74491,2.426008,'Thrall Event Generator - On Just Created - Spawn Thrall - Despawn after 6h'),
(19590,0,1,2,61,0,100,1,0,0,0,0,0,12,19604,3,1800000,0,0,0,8,0,0,0,0,-1352.526,6329.687,43.60197,2.426008,'Thrall Event Generator - Linked - Spawn Drek''thar - Despawn after 30m'),
(19590,0,2,3,61,0,100,1,0,0,0,0,0,12,@ENTRY,3,1800000,0,0,0,8,0,0,0,0,-1335.208,6313.925,45.51422,2.391101,'Thrall Event Generator - Linked - Spawn Kor''kron Honor Guard - Despawn after 30m'),
(19590,0,3,4,61,0,100,1,0,0,0,0,0,12,@ENTRY := @ENTRY + 1,3,1800000,0,0,0,8,0,0,0,0,-1346.921,6327.715,43.98703,2.373648,'Thrall Event Generator - Linked - Spawn Kor''kron Honor Guard - Despawn after 30m'),
(19590,0,4,5,61,0,100,1,0,0,0,0,0,12,@ENTRY := @ENTRY + 1,3,1800000,0,0,0,8,0,0,0,0,-1333.763,6317.533,44.76424,2.356194,'Thrall Event Generator - Linked - Spawn Kor''kron Warrior - Despawn after 30m'),
(19590,0,5,6,61,0,100,1,0,0,0,0,0,12,@ENTRY := @ENTRY + 1,3,1800000,0,0,0,8,0,0,0,0,-1329.355,6321.17,44.81275,2.478368,'Thrall Event Generator - Linked - Spawn Kor''kron Warrior - Despawn after 30m'),
(19590,0,6,7,61,0,100,1,0,0,0,0,0,12,@ENTRY := @ENTRY + 1,3,1800000,0,0,0,8,0,0,0,0,-1325.298,6324.27,43.78838,2.600541,'Thrall Event Generator - Linked - Spawn Kor''kron Warrior - Despawn after 30m'),
(19590,0,7,8,61,0,100,1,0,0,0,0,0,12,@ENTRY := @ENTRY + 1,3,1800000,0,0,0,8,0,0,0,0,-1321.754,6328.901,41.62631,2.513274,'Thrall Event Generator - Linked - Spawn Kor''kron Warrior - Despawn after 30m'),
(19590,0,8,9,61,0,100,1,0,0,0,0,0,12,@ENTRY := @ENTRY + 1,3,1800000,0,0,0,8,0,0,0,0,-1336.72,6309.458,46.23232,2.373648,'Thrall Event Generator - Linked - Spawn Kor''kron Warrior - Despawn after 30m'),
(19590,0,9,10,61,0,100,1,0,0,0,0,0,12,@ENTRY := @ENTRY + 1,3,1800000,0,0,0,8,0,0,0,0,-1339.819,6305.84,45.90306,2.373648,'Thrall Event Generator - Linked - Spawn Kor''kron Warrior - Despawn after 30m'),
(19590,0,10,11,61,0,100,1,0,0,0,0,0,12,@ENTRY := @ENTRY + 1,3,1800000,0,0,0,8,0,0,0,0,-1341.407,6302.393,45.42799,2.356194,'Thrall Event Generator - Linked - Spawn Kor''kron Warrior - Despawn after 30m'),
(19590,0,11,12,61,0,100,1,0,0,0,0,0,12,@ENTRY := @ENTRY + 1,3,1800000,0,0,0,8,0,0,0,0,-1313.597,6337.389,37.4875,2.373648,'Thrall Event Generator - Linked - Spawn Kor''kron Warrior - Despawn after 30m'),
(19590,0,12,13,61,0,100,1,0,0,0,0,0,12,@ENTRY := @ENTRY + 1,3,1800000,0,0,0,8,0,0,0,0,-1317.676,6332.954,39.39396,2.565634,'Thrall Event Generator - Linked - Spawn Kor''kron Warrior - Despawn after 30m'),
(19590,0,13,14,61,0,100,1,0,0,0,0,0,12,@ENTRY := @ENTRY + 1,3,1800000,0,0,0,8,0,0,0,0,-1346.398,6323.436,44.13105,2.303835,'Thrall Event Generator - Linked - Spawn Kor''kron Warrior - Despawn after 30m'),
(19590,0,14,15,61,0,100,1,0,0,0,0,0,12,@ENTRY := @ENTRY + 1,3,1800000,0,0,0,8,0,0,0,0,-1343.658,6326.059,44.25003,2.513274,'Thrall Event Generator - Linked - Spawn Kor''kron Warrior - Despawn after 30m'),
(19590,0,15,16,61,0,100,1,0,0,0,0,0,12,@ENTRY := @ENTRY + 1,3,1800000,0,0,0,8,0,0,0,0,-1341.659,6328.948,44.39948,2.408554,'Thrall Event Generator - Linked - Spawn Kor''kron Warrior - Despawn after 30m'),
(19590,0,16,17,61,0,100,1,0,0,0,0,0,12,@ENTRY := @ENTRY + 1,3,1800000,0,0,0,8,0,0,0,0,-1342.175,6320.706,44.54397,2.600541,'Thrall Event Generator - Linked - Spawn Kor''kron Warrior - Despawn after 30m'),
(19590,0,17,18,61,0,100,1,0,0,0,0,0,12,@ENTRY := @ENTRY + 1,3,1800000,0,0,0,8,0,0,0,0,-1339.956,6323.307,44.4758,2.251475,'Thrall Event Generator - Linked - Spawn Kor''kron Warrior - Despawn after 30m'),
(19590,0,18,19,61,0,100,1,0,0,0,0,0,12,@ENTRY := @ENTRY + 1,3,1800000,0,0,0,8,0,0,0,0,-1337.861,6326.29,44.63207,2.530727,'Thrall Event Generator - Linked - Spawn Kor''kron Warrior - Despawn after 30m'),
(19590,0,19,20,61,0,100,1,0,0,0,0,0,12,@ENTRY := @ENTRY + 1,3,1800000,0,0,0,8,0,0,0,0,-1338.36,6318.153,45.01073,2.600541,'Thrall Event Generator - Linked - Spawn Kor''kron Warrior - Despawn after 30m'),
(19590,0,20,21,61,0,100,1,0,0,0,0,0,12,@ENTRY := @ENTRY + 1,3,1800000,0,0,0,8,0,0,0,0,-1336.097,6321.046,44.63943,2.565634,'Thrall Event Generator - Linked - Spawn Kor''kron Warrior - Despawn after 30m'),
(19590,0,21,0,61,0,100,1,0,0,0,0,0,12,@ENTRY := @ENTRY + 1,3,1800000,0,0,0,8,0,0,0,0,-1333.939,6323.755,44.85339,2.513274,'Thrall Event Generator - Linked - Spawn Kor''kron Warrior - Despawn after 30m');

DELETE FROM `smart_scripts` WHERE `entryorguid` = 19556 AND `source_type` = 0;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`)
VALUES
(19556,0,0,1,63,0,100,1,0,0,0,0,0,48,1,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Thrall - On Just Created - Set Active On'), -- Set active or otherwise the despawn timer won't work if no player is near
(19556,0,1,2,61,0,100,1,0,0,0,0,0,53,1,195560,0,0,0,0,1,0,0,0,0,0,0,0,0,'Thrall - Linked - Start Waypoint Movement'),
(19556,0,2,3,61,0,100,1,0,0,0,0,0,54,25000,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Thrall - Linked - Pause Waypoint Movement'),
(19556,0,3,4,61,0,100,1,0,0,0,0,0,1,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Thrall - Linked - Zone Emote ''War drums echo in the distance.'''),
(19556,0,4,0,61,0,100,1,0,0,0,0,0,67,1,1000,1000,0,0,0,1,0,0,0,0,0,0,0,0,'Thrall - Linked - Create Timed Event ID 1'),
(19556,0,5,6,59,0,100,1,1,0,0,0,0,216,6146,0,1,0,0,0,1,0,0,0,0,0,0,0,0,'Thrall - On Timed Event ID 1 - Play Zone Music'),
(19556,0,6,7,61,0,100,1,0,0,0,0,0,67,2,63000,63000,0,0,0,1,0,0,0,0,0,0,0,0,'Thrall - Linked - Create Timed Event ID 2'),
(19556,0,7,8,61,0,100,1,0,0,0,0,0,67,3,126000,126000,0,0,0,1,0,0,0,0,0,0,0,0,'Thrall - Linked - Create Timed Event ID 3'),
(19556,0,8,12,61,0,100,1,0,0,0,0,0,67,4,189000,189000,0,0,0,1,0,0,0,0,0,0,0,0,'Thrall - Linked - Create Timed Event ID 4'),
(19556,0,9,0,59,0,100,1,2,0,0,0,0,216,6146,0,1,0,0,0,1,0,0,0,0,0,0,0,0,'Thrall - On Timed Event ID 2 - Play Zone Music'),
(19556,0,10,0,59,0,100,1,3,0,0,0,0,216,6146,0,1,0,0,0,1,0,0,0,0,0,0,0,0,'Thrall - On Timed Event ID 3 - Play Zone Music'),
(19556,0,11,0,59,0,100,1,4,0,0,0,0,216,6146,0,1,0,0,0,1,0,0,0,0,0,0,0,0,'Thrall - On Timed Event ID 4 - Play Zone Music'),
(19556,0,12,0,61,0,100,1,0,0,0,0,0,67,5,6000,6000,0,0,0,1,0,0,0,0,0,0,0,0,'Thrall - Linked - Create Timed Event ID 5'),
(19556,0,13,14,59,0,100,1,5,0,0,0,0,1,1,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Thrall - On Timed Event ID 5 - Zone Yell ''At long last, I am home...'''),
(19556,0,14,0,61,0,100,1,0,0,0,0,0,67,6,4000,4000,0,0,0,1,0,0,0,0,0,0,0,0,'Thrall - Linked - Create Timed Event ID 6'),
(19556,0,15,0,59,0,100,1,6,0,0,0,0,5,25,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Thrall - On Timed Event ID 6 - Play Emote ''Point'''),
(19556,0,16,17,40,0,100,1,25,195560,0,0,0,43,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Thrall - On Waypoint 25 Reached - Dismount'),
(19556,0,17,0,61,0,100,1,0,0,0,0,0,59,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Thrall - Linked - Set Run Off'),
(19556,0,18,19,40,0,100,1,26,195560,0,0,0,45,1,1,0,0,0,0,11,19604,50,1,0,0,0,0,0,'Thrall - On Waypoint 26 Reached - Set Data 1 1 (Drek''thar)'),
(19556,0,19,0,61,0,100,1,0,0,0,0,0,53,0,195561,0,0,0,0,1,0,0,0,0,0,0,0,0,'Thrall - Linked - Start Waypoint Movement'),
(19556,0,20,21,40,0,100,1,21,195561,0,0,0,54,12000,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Thrall - On Waypoint 21 Reached - Pause Waypoint Movement'),
(19556,0,21,0,61,0,100,1,0,0,0,0,0,80,1955600,2,0,0,0,0,1,0,0,0,0,0,0,0,0,'Thrall - Linked - Run Script'),
(19556,0,22,23,40,0,100,1,24,195561,0,0,0,54,29000,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Thrall - On Waypoint 24 Reached - Pause Waypoint Movement'),
(19556,0,23,24,61,0,100,1,0,0,0,0,0,80,1955601,2,0,0,0,0,1,0,0,0,0,0,0,0,0,'Thrall - Linked - Run Script'),
(19556,0,24,0,61,0,100,1,0,0,0,0,0,80,1806300,2,0,0,0,0,11,18063,50,1,0,0,0,0,0,'Thrall - Linked - Run Script (Garrosh)'),
(19556,0,25,26,40,0,100,1,37,195561,0,0,0,54,6000,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Thrall - On Waypoint 37 Reached - Pause Waypoint Movement'),
(19556,0,26,27,61,0,100,1,0,0,0,0,0,80,1955602,2,0,0,0,0,1,0,0,0,0,0,0,0,0,'Thrall - Linked - Run Script'),
(19556,0,27,0,61,0,100,1,0,0,0,0,0,80,1814101,2,0,0,0,0,11,18141,50,1,0,0,0,0,0,'Thrall - Linked - Run Script (Greatmother)'),
(19556,0,28,29,40,0,100,1,39,195561,0,0,0,54,140000,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Thrall - On Waypoint 39 Reached - Pause Waypoint Movement'),
(19556,0,29,30,61,0,100,1,0,0,0,0,0,80,1955603,2,0,0,0,0,1,0,0,0,0,0,0,0,0,'Thrall - Linked - Run Script'),
(19556,0,30,0,61,0,100,1,0,0,0,0,0,80,1814102,2,0,0,0,0,11,18141,50,1,0,0,0,0,0,'Thrall - Linked - Run Script (Greatmother)'),
(19556,0,31,32,40,0,100,1,49,195561,0,0,0,54,18000,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Thrall - On Waypoint 49 Reached - Pause Waypoint Movement'),
(19556,0,32,33,61,0,100,1,0,0,0,0,0,80,1955604,2,0,0,0,0,1,0,0,0,0,0,0,0,0,'Thrall - Linked - Run Script'),
(19556,0,33,0,61,0,100,1,0,0,0,0,0,80,1806301,2,0,0,0,0,11,18063,50,1,0,0,0,0,0,'Thrall - Linked - Run Script (Garrosh)'),
(19556,0,34,35,40,0,100,1,55,195561,0,0,0,54,254000,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Thrall - On Waypoint 55 Reached - Pause Waypoint Movement'),
(19556,0,35,0,61,0,100,1,0,0,0,0,0,80,1955605,2,0,0,0,0,1,0,0,0,0,0,0,0,0,'Thrall - Linked - Run Script'),
(19556,0,36,0,40,0,100,1,66,195561,0,0,0,80,1955607,2,0,0,0,0,1,0,0,0,0,0,0,0,0,'Thrall - On Waypoint 66 Reached - Pause Waypoint Movement');

DELETE FROM `smart_scripts` WHERE `entryorguid` = 18063 AND `source_type` = 0;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`)
VALUES
(18063,0,0,1,40,0,100,0,7,180630,0,0,0,54,256000,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Garrosh - On Waypoint 7 Reached - Pause Waypoint Movement'),
(18063,0,1,0,61,0,100,0,0,0,0,0,0,80,1806302,2,0,0,0,0,1,0,0,0,0,0,0,0,0,'Garrosh - Linked - Run Script'),
(18063,0,2,0,40,0,100,0,14,180630,0,0,0,67,1,2000,2000,0,0,0,1,0,0,0,0,0,0,0,0,'Garrosh - On Waypoint 14 Reached - Create Timed Event ID 1'),
(18063,0,3,0,59,0,100,0,1,0,0,0,0,66,0,0,0,0,0,0,8,0,0,0,0,0,0,0,5.55015,'Garrosh - On Timed Event ID 1 - Set Orientation');

-- Thrall meeting Garrosh, part 1
DELETE FROM `smart_scripts` WHERE `entryorguid` = 1955600 AND `source_type` = 9;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`)
VALUES
(1955600,9,0,0,0,0,100,0,2000,2000,0,0,0,66,0,0,0,0,0,0,11,18063,50,1,0,0,0,0,0,'Thrall - On Script - Set Orientation'),
(1955600,9,1,0,0,0,100,0,2000,2000,0,0,0,1,2,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Thrall - On Script - Say Line 2'),
(1955600,9,2,0,0,0,100,0,3000,3000,0,0,0,5,5,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Thrall - On Script - Play Emote ''Exclamation'''),
(1955600,9,3,0,0,0,100,0,4000,4000,0,0,0,59,1,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Thrall - On Script - Set Run On');

DELETE FROM `smart_scripts` WHERE `entryorguid` = 1955601 AND `source_type` = 9;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`)
VALUES
(1955601,9,0,0,0,0,100,0,1000,1000,0,0,0,66,0,0,0,0,0,0,11,18063,50,1,0,0,0,0,0,'Thrall - On Script - Set Orientation'),
(1955601,9,1,0,0,0,100,0,2000,2000,0,0,0,5,2,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Thrall - On Script - Play Emote ''Bow'''),
(1955601,9,2,0,0,0,100,0,2000,2000,0,0,0,1,3,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Thrall - On Script - Say Line 3'),
(1955601,9,3,0,0,0,100,0,4000,4000,0,0,0,5,6,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Thrall - On Script - Play Emote ''Question'''),
(1955601,9,4,0,0,0,100,0,14000,14000,0,0,0,1,4,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Thrall - On Script - Say Line 4'),
(1955601,9,5,0,0,0,100,0,3000,3000,0,0,0,5,273,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Thrall - On Script - Play Emote ''Yes'''),
(1955601,9,6,0,0,0,100,0,1000,1000,0,0,0,59,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Thrall - On Script - Set Run Off');

DELETE FROM `smart_scripts` WHERE `entryorguid` = 1806300 AND `source_type` = 9;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`)
VALUES
(1806300,9,0,0,0,0,100,0,3000,3000,0,0,0,66,0,0,0,0,0,0,11,19556,50,1,0,0,0,0,0,'Garrosh - On Script - Set Orientation (Thrall)'),
(1806300,9,1,0,0,0,100,0,9000,9000,0,0,0,1,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Garrosh - On Script - Say Line 0'),
(1806300,9,2,0,0,0,100,0,2000,2000,0,0,0,5,1,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Thrall - On Script - Play Emote ''Talk'''),
(1806300,9,3,0,0,0,100,0,4000,4000,0,0,0,66,0,0,0,0,0,0,8,0,0,0,0,0,0,0,5.72468,'Garrosh - On Script - Set Orientation (Hospice)'),
(1806300,9,4,0,0,0,100,0,1000,1000,0,0,0,1,1,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Garrosh - On Script - Say Line 1'),
(1806300,9,5,0,0,0,100,0,2000,2000,0,0,0,66,0,0,0,0,0,0,11,19556,50,1,0,0,0,0,0,'Garrosh - On Script - Set Orientation (Thrall)');

-- Thrall meeting Greatmother, part 1
DELETE FROM `smart_scripts` WHERE `entryorguid` = 1955602 AND `source_type` = 9;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`)
VALUES
(1955602,9,0,0,0,0,100,0,0,0,0,0,0,59,1,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Thrall - On Script - Set Run On'),
(1955602,9,1,0,0,0,100,0,2000,2000,0,0,0,1,5,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Thrall - On Script - Say Line 5');

DELETE FROM `smart_scripts` WHERE `entryorguid` = 1814101 AND `source_type` = 9;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`)
VALUES
(1814101,9,0,0,0,0,100,0,3000,3000,0,0,0,1,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Greatmother Geyah - On Script - Say Line 0');

DELETE FROM `smart_scripts` WHERE `entryorguid` = 1814102 AND `source_type` = 9;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`)
VALUES
(1814102,9,0,0,0,0,100,0,5000,5000,0,0,0,1,1,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Greatmother Geyah - On Script - Say Line 1'),
(1814102,9,1,0,0,0,100,0,10000,10000,0,0,0,1,2,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Greatmother Geyah - On Script - Say Line 2'),
(1814102,9,2,0,0,0,100,0,23000,23000,0,0,0,1,3,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Greatmother Geyah - On Script - Say Line 3'),
(1814102,9,3,0,0,0,100,0,8000,8000,0,0,0,1,4,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Greatmother Geyah - On Script - Say Line 4'),
(1814102,9,4,0,0,0,100,0,3000,3000,0,0,0,1,5,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Greatmother Geyah - On Script - Say Line 5'),
(1814102,9,5,0,0,0,100,0,29000,29000,0,0,0,1,6,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Greatmother Geyah - On Script - Say Line 6'),
(1814102,9,6,0,0,0,100,0,14000,14000,0,0,0,1,7,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Greatmother Geyah - On Script - Say Line 7'),
(1814102,9,7,0,0,0,100,0,12000,12000,0,0,0,5,18,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Greatmother - On Script - Play Emote ''Cry'''),
(1814102,9,8,0,0,0,100,0,4000,4000,0,0,0,1,8,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Greatmother Geyah - On Script - Say Line 8'),
(1814102,9,9,0,0,0,100,0,5000,5000,0,0,0,5,1,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Greatmother - On Script - Play Emote ''Talk'''),
(1814102,9,10,0,0,0,100,0,5000,5000,0,0,0,1,9,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Greatmother Geyah - On Script - Say Line 9');

DELETE FROM `smart_scripts` WHERE `entryorguid` = 1955603 AND `source_type` = 9;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`)
VALUES
(1955603,9,0,0,0,0,100,0,0,0,0,0,0,66,0,0,0,0,0,0,11,18141,50,1,0,0,0,0,0,'Thrall - On Script - Set Orientation (Greatmother)'),
(1955603,9,1,0,0,0,100,0,2000,2000,0,0,0,90,1,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Thrall - On Script - Set ''UNIT_STAND_STATE_SIT'''),
(1955603,9,2,0,0,0,100,0,10000,10000,0,0,0,1,6,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Thrall - On Script - Say Line 6'),
(1955603,9,3,0,0,0,100,0,13000,13000,0,0,0,5,274,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Thrall - On Script - Play Emote ''No'''),
(1955603,9,4,0,0,0,100,0,2000,2000,0,0,0,1,7,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Thrall - On Script - Say Line 7'),
(1955603,9,5,0,0,0,100,0,31000,31000,0,0,0,91,1,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Thrall - On Script - Remove ''UNIT_STAND_STATE_SIT'''),
(1955603,9,6,0,0,0,100,0,2000,2000,0,0,0,90,8,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Thrall - On Script - Set ''UNIT_STAND_STATE_KNEEL'''),
(1955603,9,7,0,0,0,100,0,5000,5000,0,0,0,1,8,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Thrall - On Script - Say Line 8'),
(1955603,9,8,0,0,0,100,0,21000,21000,0,0,0,1,9,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Thrall - On Script - Say Line 9'),
(1955603,9,9,0,0,0,100,0,12000,12000,0,0,0,1,10,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Thrall - On Script - Say Line 10'),
(1955603,9,10,0,0,0,100,0,25000,25000,0,0,0,91,8,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Thrall - On Script - Remove ''UNIT_STAND_STATE_KNEEL'''),
(1955603,9,11,0,0,0,100,0,1000,1000,0,0,0,1,11,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Thrall - On Script - Say Line 11'),
(1955603,9,12,0,0,0,100,0,5000,5000,0,0,0,5,5,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Thrall - On Script - Play Emote ''Exclamation'''),
(1955603,9,13,0,0,0,100,0,4000,4000,0,0,0,5,15,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Thrall - On Script - Play Emote ''Roar'''),
(1955603,9,14,0,0,0,100,0,4000,4000,0,0,0,1,12,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Thrall - On Script - Say Line 12');

-- Thrall meeting Garrosh, part 2
DELETE FROM `smart_scripts` WHERE `entryorguid` = 1955604 AND `source_type` = 9;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`)
VALUES
(1955604,9,0,0,0,0,100,0,1000,1000,0,0,0,66,0,0,0,0,0,0,11,18063,50,1,0,0,0,0,0,'Thrall - On Script - Set Orientation (Garrosh)'),
(1955604,9,1,0,0,0,100,0,2000,2000,0,0,0,1,13,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Thrall - On Script - Say Line 13'),
(1955604,9,2,0,0,0,100,0,4000,4000,0,0,0,5,5,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Thrall - On Script - Play Emote ''Exclamation''');

DELETE FROM `smart_scripts` WHERE `entryorguid` = 1806301 AND `source_type` = 9;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`)
VALUES
(1806301,9,0,0,0,0,100,0,1000,1000,0,0,0,66,0,0,0,0,0,0,11,19556,50,1,0,0,0,0,0,'Garrosh - On Script - Set Orientation (Thrall)'),
(1806301,9,1,0,0,0,100,0,11000,11000,0,0,0,5,273,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Garrosh - On Script - Play Emote ''Yes'''),
(1806301,9,2,0,0,0,100,0,3000,3000,0,0,0,1,2,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Garrosh - On Script - Say Line 2'),
(1806301,9,3,0,0,0,100,0,3000,3000,0,0,0,53,1,180630,0,0,0,0,1,0,0,0,0,0,0,0,0,'Garrosh - On Script - Start Waypoint Movement');

-- Event at the blue circle
DELETE FROM `smart_scripts` WHERE `entryorguid` = 1955605 AND `source_type` = 9;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`)
VALUES
(1955605,9,0,0,0,0,100,0,1000,1000,0,0,0,59,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Thrall - On Script - Set Run Off'),
(1955605,9,1,0,0,0,100,0,1000,1000,0,0,0,66,0,0,0,0,0,0,8,0,0,0,0,0,0,0,3.682645,'Thrall - On Script - Set Orientation'),
(1955605,9,2,0,0,0,100,0,2000,2000,0,0,0,1,14,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Thrall - On Script - Say Line 14'),
(1955605,9,3,0,0,0,100,0,5000,5000,0,0,0,5,15,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Thrall - On Script - Play Emote ''Roar'''),
(1955605,9,4,0,0,0,100,0,4000,4000,0,0,0,11,34378,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Thrall - On Script - Cast ''Thrall Calls Thunder'''),
(1955605,9,5,0,0,0,100,0,0,0,0,0,0,86,33271,0,10,70074,19646,0,1,0,0,0,0,0,0,0,0,'Thrall - On Script - Cross Cast ''Thrall Event Dummy'' (Internal Shake Camera w/ rumble sound)'),
(1955605,9,6,0,0,0,100,0,0,0,0,0,0,86,33271,0,10,70075,19646,0,1,0,0,0,0,0,0,0,0,'Thrall - On Script - Cross Cast ''Thrall Event Dummy'' (Internal Shake Camera w/ rumble sound)'),
(1955605,9,7,0,0,0,100,0,0,0,0,0,0,86,33271,0,10,70076,19646,0,1,0,0,0,0,0,0,0,0,'Thrall - On Script - Cross Cast ''Thrall Event Dummy'' (Internal Shake Camera w/ rumble sound)'),
(1955605,9,8,0,0,0,100,0,0,0,0,0,0,86,33271,0,10,70077,19646,0,1,0,0,0,0,0,0,0,0,'Thrall - On Script - Cross Cast ''Thrall Event Dummy'' (Internal Shake Camera w/ rumble sound)'),
(1955605,9,9,0,0,0,100,0,0,0,0,0,0,86,33271,0,10,70078,19646,0,1,0,0,0,0,0,0,0,0,'Thrall - On Script - Cross Cast ''Thrall Event Dummy'' (Internal Shake Camera w/ rumble sound)'),
(1955605,9,10,0,0,0,100,0,0,0,0,0,0,86,33271,0,10,70079,19646,0,1,0,0,0,0,0,0,0,0,'Thrall - On Script - Cross Cast ''Thrall Event Dummy'' (Internal Shake Camera w/ rumble sound)'),
(1955605,9,11,0,0,0,100,0,15000,15000,0,0,0,12,19647,3,151000,0,0,0,8,0,0,0,0,-1422.789,7280.642,25.68812,5.358161,'Thrall - On Script - Spawn Mini Thrall - Despawn after 151s'),
(1955605,9,12,0,0,0,100,0,0,0,0,0,0,12,18075,3,111000,0,0,0,8,0,0,0,0,-1415.731,7271.584,25.49314,2.408554,'Thrall - On Script - Spawn Mannoroth - Despawn after 111s'),
(1955605,9,13,0,0,0,100,0,0,0,0,0,0,12,18076,3,151000,0,0,0,8,0,0,0,0,-1425.996,7276.042,25.80751,5.88176,'Thrall - On Script - Spawn Grom Hellscream - Despawn after 151s'),
(1955605,9,14,0,0,0,100,0,0,0,0,0,0,80,1807500,2,0,0,0,0,11,18075,50,1,0,0,0,0,0,'Thrall - On Script - Run Script (Mannoroth)'),
(1955605,9,15,0,0,0,100,0,0,0,0,0,0,80,1964700,2,0,0,0,0,11,19647,50,1,0,0,0,0,0,'Thrall - On Script - Run Script (Mini Thrall)'),
(1955605,9,16,0,0,0,100,0,0,0,0,0,0,80,1807600,2,0,0,0,0,11,18076,50,1,0,0,0,0,0,'Thrall - On Script - Run Script (Grom)');

DELETE FROM `smart_scripts` WHERE `entryorguid` = 1807500 AND `source_type` = 9;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`)
VALUES
(1807500,9,0,0,0,0,100,0,5000,5000,0,0,0,1,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Mannoroth - On Script - Say Line 0'),
(1807500,9,1,0,0,0,100,0,4000,4000,0,0,0,1,1,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Mannoroth - On Script - Say Line 1'),
(1807500,9,2,0,0,0,100,0,5000,5000,0,0,0,5,1,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Mannoroth - On Script - Play Emote ''Talk'''),
(1807500,9,3,0,0,0,100,0,4000,4000,0,0,0,5,1,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Mannoroth - On Script - Play Emote ''Talk'''),
(1807500,9,4,0,0,0,100,0,14000,14000,0,0,0,1,2,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Mannoroth - On Script - Say Line 2'),
(1807500,9,5,0,0,0,100,0,7000,7000,0,0,0,5,1,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Mannoroth - On Script - Play Emote ''Talk'''),
(1807500,9,6,0,0,0,100,0,17000,17000,0,0,0,5,442,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Mannoroth - On Script - Play Emote ''Parry2H'''),
(1807500,9,7,0,0,0,100,0,3000,3000,0,0,0,1,3,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Mannoroth - On Script - Say Line 3'),
(1807500,9,8,0,0,0,100,0,8700,8700,0,0,0,53,1,180750,0,0,0,0,1,0,0,0,0,0,0,0,0,'Mannoroth - On Script - Start Waypoint Movement'),
(1807500,9,9,0,0,0,100,0,1300,1300,0,0,0,11,34391,0,0,0,0,0,11,19647,50,1,0,0,0,0,0,'Mannoroth - On Script - Cast ''Mannoroth Attacks'''),
(1807500,9,10,0,0,0,100,0,0,0,0,0,0,5,393,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Mannoroth - On Script - Play Emote ''CreatureSpecial'''),
(1807500,9,11,0,0,0,100,0,3000,3000,0,0,0,1,4,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Mannoroth - On Script - Say Line 4'),
(1807500,9,12,0,0,0,100,0,3000,3000,0,0,0,66,0,0,0,0,0,0,11,18076,50,1,0,0,0,0,0,'Mannoroth - On Script - Set Orientation (Grom)'),
(1807500,9,13,0,0,0,100,0,1000,1000,0,0,0,1,5,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Mannoroth - On Script - Say Line 5'),
(1807500,9,14,0,0,0,100,0,5000,5000,0,0,0,5,1,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Mannoroth - On Script - Play Emote ''Talk'''),
(1807500,9,15,0,0,0,100,0,6000,6000,0,0,0,5,1,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Mannoroth - On Script - Play Emote ''Talk'''),
(1807500,9,16,0,0,0,100,0,12000,12000,0,0,0,11,60081,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Mannoroth - On Script - Cast ''Cosmetic - Explosion'''),
(1807500,9,17,0,0,0,100,0,0,0,0,0,0,90,7,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Mannoroth - On Script - Set ''UNIT_STAND_STATE_DEAD''');

DELETE FROM `smart_scripts` WHERE `entryorguid` = 1964700 AND `source_type` = 9;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`)
VALUES
(1964700,9,0,0,0,0,100,0,51000,51000,0,0,0,1,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Mini Thrall - On Script - Say Line 0'),
(1964700,9,1,0,0,0,100,0,2000,2000,0,0,0,11,34388,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Mini Thrall - On Script - Cast ''Thunderstomp'''),
(1964700,9,2,0,0,0,100,0,2500,2500,0,0,0,5,61,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Mini Thrall - On Script - Play Emote ''AttackThrown'''),
(1964700,9,3,0,0,0,100,0,500,500,0,0,0,11,34389,0,0,0,0,0,11,18075,50,1,0,0,0,0,0,'Mini Thrall - On Script - Cast ''Throw Doomhammer'''),
(1964700,9,4,0,0,0,100,0,0,0,0,0,0,17,27,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Mini Thrall - On Script - Emote State ''ReadyUnarmed'''),
(1964700,9,5,0,0,0,100,0,0,0,0,0,0,71,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Mini Thrall - On Script - Unequip Weapon'),
(1964700,9,6,0,0,0,100,0,14000,14000,0,0,0,90,7,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Mini Thrall - On Script - Set ''UNIT_STAND_STATE_DEAD'''),
(1964700,9,7,0,0,0,100,0,35000,35000,0,0,0,91,7,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Mini Thrall - On Script - Remove ''UNIT_STAND_STATE_DEAD'''),
(1964700,9,8,0,0,0,100,0,2000,2000,0,0,0,53,0,196470,0,0,0,0,1,0,0,0,0,0,0,0,0,'Mini Thrall - On Script - Start Waypoint Movement'),
(1964700,9,9,0,0,0,100,0,2000,2000,0,0,0,90,8,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Mini Thrall - On Script - Set ''UNIT_STAND_STATE_KNEEL'''),
(1964700,9,10,0,0,0,100,0,28000,28000,0,0,0,1,1,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Mini Thrall - On Script - Say Line 1'),
(1964700,9,11,0,0,0,100,0,9000,9000,0,0,0,91,8,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Mini Thrall - On Script - Remove ''UNIT_STAND_STATE_KNEEL'''),
(1964700,9,12,0,0,0,100,0,0,0,0,0,0,5,15,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Mini Thrall - On Script - Play Emote ''Roar''');

DELETE FROM `smart_scripts` WHERE `entryorguid` = 1807600 AND `source_type` = 9;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`)
VALUES
(1807600,9,0,0,0,0,100,0,71000,71000,0,0,0,66,0,0,0,0,0,0,11,18075,50,1,0,0,0,0,0,'Grom - On Script - Set Orientation (Mannoroth)'),
(1807600,9,1,0,0,0,100,0,24000,24000,0,0,0,1,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Grom - On Script - Say Line 0'),
(1807600,9,2,0,0,0,100,0,2000,2000,0,0,0,53,1,180760,0,0,0,0,1,0,0,0,0,0,0,0,0,'Grom - On Script - Start Waypoint Movement'),
(1807600,9,3,0,0,0,100,0,1000,1000,0,0,0,5,37,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Grom - On Script - Play Emote ''Attack2HTight'''),
(1807600,9,4,0,0,0,100,0,1000,1000,0,0,0,11,60081,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Grom - On Script - Cast ''Cosmetic - Explosion'''),
(1807600,9,5,0,0,0,100,0,1000,1000,0,0,0,90,7,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Grom - On Script - Set ''UNIT_STAND_STATE_DEAD'''),
(1807600,9,6,0,0,0,100,0,11000,11000,0,0,0,1,1,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Grom - On Script - Say Line 1'),
(1807600,9,7,0,0,0,100,0,0,0,0,0,0,1,2,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Grom - On Script - Say Line 2'),
(1807600,9,8,0,0,0,100,0,8000,8000,0,0,0,1,3,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Grom - On Script - Say Line 3');

DELETE FROM `smart_scripts` WHERE `entryorguid` = 1806302 AND `source_type` = 9;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`)
VALUES
(1806302,9,0,0,0,0,100,0,0,0,0,0,0,59,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Garrosh - On Script - Set Run Off'),
(1806302,9,1,0,0,0,100,0,2000,2000,0,0,0,66,0,0,0,0,0,0,8,0,0,0,0,0,0,0,3.612832,'Garrosh - On Script - Set Orientation'),
(1806302,9,2,0,0,0,100,0,176000,176000,0,0,0,90,8,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Garrosh - On Script - Set ''UNIT_STAND_STATE_KNEEL'''),
(1806302,9,3,0,0,0,100,0,0,0,0,0,0,1,3,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Garrosh - On Script - Say Line 3'),
(1806302,9,4,0,0,0,100,0,4000,4000,0,0,0,1,4,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Garrosh - On Script - Say Line 4'),
(1806302,9,5,0,0,0,100,0,9000,9000,0,0,0,1,5,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Garrosh - On Script - Say Line 5'),
(1806302,9,6,0,0,0,100,0,7000,7000,0,0,0,1,6,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Garrosh - On Script - Say Line 6'),
(1806302,9,7,0,0,0,100,0,16000,16000,0,0,0,1,7,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Garrosh - On Script - Say Line 7'),
(1806302,9,8,0,0,0,100,0,14000,14000,0,0,0,91,8,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Garrosh - On Script - Remove ''UNIT_STAND_STATE_KNEEL'''),
(1806302,9,9,0,0,0,100,0,0,0,0,0,0,1,8,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Garrosh - On Script - Say Line 8'),
(1806302,9,10,0,0,0,100,0,0,0,0,0,0,86,34410,0,10,70146,19660,0,1,0,0,0,0,0,0,0,0,'Garrosh - On Script - Cross Cast ''Garrosh''s Buff Bots'' (Hellscream''s Warsong)'),
(1806302,9,11,0,0,0,100,0,0,0,0,0,0,86,34410,0,10,70147,19660,0,1,0,0,0,0,0,0,0,0,'Garrosh - On Script - Cross Cast ''Garrosh''s Buff Bots'' (Hellscream''s Warsong)'),
(1806302,9,12,0,0,0,100,0,0,0,0,0,0,86,34410,0,10,70148,19660,0,1,0,0,0,0,0,0,0,0,'Garrosh - On Script - Cross Cast ''Garrosh''s Buff Bots'' (Hellscream''s Warsong)'),
(1806302,9,13,0,0,0,100,0,0,0,0,0,0,86,34410,0,10,70149,19660,0,1,0,0,0,0,0,0,0,0,'Garrosh - On Script - Cross Cast ''Garrosh''s Buff Bots'' (Hellscream''s Warsong)'),
(1806302,9,14,0,0,0,100,0,0,0,0,0,0,86,34410,0,10,70150,19660,0,1,0,0,0,0,0,0,0,0,'Garrosh - On Script - Cross Cast ''Garrosh''s Buff Bots'' (Hellscream''s Warsong)'),
(1806302,9,15,0,0,0,100,0,0,0,0,0,0,86,34410,0,10,70151,19660,0,1,0,0,0,0,0,0,0,0,'Garrosh - On Script - Cross Cast ''Garrosh''s Buff Bots'' (Hellscream''s Warsong)'),
(1806302,9,16,0,0,0,100,0,0,0,0,0,0,86,34410,0,10,70152,19660,0,1,0,0,0,0,0,0,0,0,'Garrosh - On Script - Cross Cast ''Garrosh''s Buff Bots'' (Hellscream''s Warsong)'),
(1806302,9,17,0,0,0,100,0,0,0,0,0,0,86,34410,0,10,70153,19660,0,1,0,0,0,0,0,0,0,0,'Garrosh - On Script - Cross Cast ''Garrosh''s Buff Bots'' (Hellscream''s Warsong)'),
(1806302,9,18,0,0,0,100,0,0,0,0,0,0,86,34410,0,10,70154,19660,0,1,0,0,0,0,0,0,0,0,'Garrosh - On Script - Cross Cast ''Garrosh''s Buff Bots'' (Hellscream''s Warsong)'),
(1806302,9,19,0,0,0,100,0,0,0,0,0,0,86,34410,0,10,70155,19660,0,1,0,0,0,0,0,0,0,0,'Garrosh - On Script - Cross Cast ''Garrosh''s Buff Bots'' (Hellscream''s Warsong)'),
(1806302,9,20,0,0,0,100,0,0,0,0,0,0,86,34410,0,10,70156,19660,0,1,0,0,0,0,0,0,0,0,'Garrosh - On Script - Cross Cast ''Garrosh''s Buff Bots'' (Hellscream''s Warsong)'),
(1806302,9,21,0,0,0,100,0,0,0,0,0,0,86,34410,0,10,70157,19660,0,1,0,0,0,0,0,0,0,0,'Garrosh - On Script - Cross Cast ''Garrosh''s Buff Bots'' (Hellscream''s Warsong)'),
(1806302,9,22,0,0,0,100,0,0,0,0,0,0,86,34410,0,10,70158,19660,0,1,0,0,0,0,0,0,0,0,'Garrosh - On Script - Cross Cast ''Garrosh''s Buff Bots'' (Hellscream''s Warsong)'),
(1806302,9,23,0,0,0,100,0,0,0,0,0,0,86,34410,0,10,70159,19660,0,1,0,0,0,0,0,0,0,0,'Garrosh - On Script - Cross Cast ''Garrosh''s Buff Bots'' (Hellscream''s Warsong)'),
(1806302,9,24,0,0,0,100,0,11000,11000,0,0,0,66,0,0,0,0,0,0,11,19556,50,1,0,0,0,0,0,'Garrosh - On Script - Set Orientation (Thrall)'),
(1806302,9,25,0,0,0,100,0,1000,1000,0,0,0,1,9,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Garrosh - On Script - Say Line 9'),
(1806302,9,26,0,0,0,100,0,0,0,0,0,0,80,1955606,2,0,0,0,0,11,19556,50,1,0,0,0,0,0,'Garrosh - On Script - Run Script (Thrall)');

DELETE FROM `smart_scripts` WHERE `entryorguid` = 1955606 AND `source_type` = 9;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`)
VALUES
(1955606,9,0,0,0,0,100,0,5000,5000,0,0,0,66,0,0,0,0,0,0,11,18063,50,1,0,0,0,0,0,'Thrall - On Script - Set Orientation (Garrosh)'),
(1955606,9,1,0,0,0,100,0,1000,1000,0,0,0,1,15,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Thrall - On Script - Say Line 15'),
(1955606,9,2,0,0,0,100,0,0,0,0,0,0,1,16,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Thrall - On Script - Say Line 16');

-- Thrall meeting Greatmother, part 2
DELETE FROM `smart_scripts` WHERE `entryorguid` = 1955607 AND `source_type` = 9;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`)
VALUES
(1955607,9,0,0,0,0,100,0,1000,1000,0,0,0,66,0,0,0,0,0,0,11,18141,50,1,0,0,0,0,0,'Thrall - On Script - Set Orientation (Greatmother)'),
(1955607,9,1,0,0,0,100,0,1000,1000,0,0,0,1,17,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Thrall - On Script - Say Line 17'),
(1955607,9,2,0,0,0,100,0,0,0,0,0,0,90,1,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Thrall - On Script - Set ''UNIT_STAND_STATE_SIT''');

-- Drek'thar
DELETE FROM `smart_scripts` WHERE `entryorguid` = 19604 AND `source_type` = 0;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`)
VALUES
(19604,0,0,1,63,0,100,1,0,0,0,0,0,48,1,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Drek''thar - On Just Created - Set Active On'), -- Set active or otherwise the despawn timer won't work if no player is near
(19604,0,1,2,61,0,100,1,0,0,0,0,0,53,1,196040,0,0,0,0,1,0,0,0,0,0,0,0,0,'Drek''thar - Linked - Start Waypoint Movement'),
(19604,0,2,0,61,0,100,1,0,0,0,0,0,54,17000,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Drek''thar - Linked - Pause Waypoint Movement'),
(19604,0,3,0,40,0,100,1,25,196040,0,0,0,59,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Drek''thar - On Waypoint 25 Reached - Set Run Off'),
(19604,0,4,5,40,0,100,1,26,196040,0,0,0,43,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Drek''thar - On Waypoint 26 Reached - Dismount'),
(19604,0,5,0,61,0,100,1,0,0,0,0,0,67,2,1000,1000,0,0,0,1,0,0,0,0,0,0,0,0,'Drek''thar - Linked - Create Timed Event ID 2'),
(19604,0,6,0,59,0,100,1,2,0,0,0,0,66,0,0,0,0,0,0,8,0,0,0,0,0,0,0,4.328416,'Drek''thar - On Timed Event ID 2 - Set Orientation'),
(19604,0,7,0,38,0,100,1,1,1,0,0,0,53,0,196041,0,0,0,0,1,0,0,0,0,0,0,0,0,'Drek''thar - On Data Set 1 1 - Start Waypoint Movement'),
(19604,0,8,0,40,0,100,1,26,196041,0,0,0,54,100000,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Drek''thar - On Waypoint 26 Reached - Pause Waypoint Movement'),
(19604,0,9,0,40,0,100,1,32,196041,0,0,0,67,3,2000,2000,0,0,0,1,0,0,0,0,0,0,0,0,'Drek''thar - On Waypoint 32 Reached - Create Timed Event ID 3'),
(19604,0,10,0,59,0,100,1,3,0,0,0,0,66,0,0,0,0,0,0,8,0,0,0,0,0,0,0,1.902409,'Drek''thar - On Timed Event ID 3 - Set Orientation');

DELETE FROM `waypoints` WHERE `entry` = 195560;
INSERT INTO `waypoints`
(`entry`,`pointid`,`position_x`,`position_y`,`position_z`,`point_comment`)
VALUES
(195560,1,-1349.914,6332.778,43.74491,'Thrall - Start movement at spawn area'),
(195560,2,-1376.285,6354.012,41.92145,''),
(195560,3,-1395.761,6371.578,39.37491,''),
(195560,4,-1416.581,6393.08,36.97689,''),
(195560,5,-1437.672,6413.039,34.79077,''),
(195560,6,-1461.674,6437.356,32.08894,''),
(195560,7,-1490.398,6468.24,28.98989,''),
(195560,8,-1505.137,6496.36,25.37372,''),
(195560,9,-1512.865,6527.001,22.66885,''),
(195560,10,-1518.474,6552.888,21.60993,''),
(195560,11,-1521.708,6568.282,20.96366,''),
(195560,12,-1512.913,6632.7,22.39752,''),
(195560,13,-1507.126,6655.43,23.85226,''),
(195560,14,-1504.92,6662.7,24.48247,''),
(195560,15,-1494.251,6690.354,24.47311,''),
(195560,16,-1474.878,6730.709,24.92821,''),
(195560,17,-1455.4,6765.879,27.22983,''),
(195560,18,-1442.034,6784.493,28.29723,''),
(195560,19,-1425.776,6805.609,27.78597,''),
(195560,20,-1409.667,6827.436,27.14842,''),
(195560,21,-1389.377,6852.119,29.1224,''),
(195560,22,-1354.932,6887.59,30.6786,''),
(195560,23,-1331.892,6912.893,31.86545,''),
(195560,24,-1322.652,6923.154,31.96082,'Thrall - Before the gates of Garadar'),
(195560,25,-1303.386,6958.170,32.13569,''),
(195560,26,-1298.432,6965.858,32.94059,'Thrall - Dismount - Walk');

DELETE FROM `waypoints` WHERE `entry` = 195561;
INSERT INTO `waypoints`
(`entry`,`pointid`,`position_x`,`position_y`,`position_z`,`point_comment`)
VALUES
(195561,1,-1293.26,6975.769,32.75947,'Thrall - Start movement through Garadar'),
(195561,2,-1286.796,6986.640,32.85235,''),
(195561,3,-1294.618,6995.853,32.5695,''),
(195561,4,-1313.708,7015.143,33.21278,''),
(195561,5,-1329.178,7025.363,33.85265,''),
(195561,6,-1330.332,7026.19,33.9671,''),
(195561,7,-1346.047,7031.633,33.79149,''),
(195561,8,-1364.008,7041.4,34.14558,''),
(195561,9,-1377.8,7054.752,34.563,''),
(195561,10,-1389.566,7071.121,34.33751,''),
(195561,11,-1394.765,7085.715,33.5165,''),
(195561,12,-1397.299,7094.352,33.29916,''),
(195561,13,-1400.27,7112.666,33.44453,''),
(195561,14,-1401.772,7126.559,33.73253,''),
(195561,15,-1387.934,7139.022,34.12173,''),
(195561,16,-1375.81,7152.083,34.76439,''),
(195561,17,-1371.634,7156.53,34.37251,''),
(195561,18,-1363.432,7166.782,33.74737,''),
(195561,19,-1357.394,7173.279,33.81808,''),
(195561,20,-1343.675,7202.677,33.50021,'Thrall - Seeing Garrosh'),
(195561,21,-1342.671,7205.199,33.11827,''),
(195561,22,-1353.912,7233.381,33.27534,''),
(195561,23,-1351.352,7235.671,33.12692,''),
(195561,24,-1347.005,7234.933,33.40887,'Thrall - Talking to Garrosh, part 1'),
(195561,25,-1348.088,7241.893,33.00979,''),
(195561,26,-1337.396,7244.912,33.15238,''),
(195561,27,-1329.12,7243.791,33.08465,''),
(195561,28,-1325.884,7241.624,33.29979,''),
(195561,29,-1319.027,7225.425,33.70268,''),
(195561,30,-1317.728,7215.848,33.89096,''),
(195561,31,-1307.45,7212.678,36.13881,''),
(195561,32,-1292.464,7206.452,41.56324,''),
(195561,33,-1276.794,7193.433,51.69974,''),
(195561,34,-1268.383,7186.156,56.23711,''),
(195561,35,-1266.264,7184.318,56.86266,''),
(195561,36,-1254.841,7178.258,57.42343,''),
(195561,37,-1239.085,7171.389,57.26868,'Thrall - Seeing Greatmother'),
(195561,38,-1225.519,7166.836,57.57937,''),
(195561,39,-1223.953,7164.284,57.39006,'Thrall - Talking to Greatmother, part 1'),
(195561,40,-1233.731,7174.257,57.32937,''),
(195561,41,-1262.29,7187.34,57.1386,''),
(195561,42,-1279.026,7195.141,50.25358,''),
(195561,43,-1294.919,7206.255,40.83135,''),
(195561,44,-1315.554,7213.983,34.63311,''),
(195561,45,-1320.284,7215.999,34.15732,''),
(195561,46,-1318.225,7233.313,33.19328,''),
(195561,47,-1326.275,7243.778,33.27525,''),
(195561,48,-1343.156,7245.558,33.18895,''),
(195561,49,-1347.993,7235.135,33.38955,'Thrall - Talking to Garrosh, part 2'),
(195561,50,-1371.615,7232.133,32.4465,''),
(195561,51,-1386.802,7236.177,27.61976,''),
(195561,52,-1394.828,7251.646,26.03636,''),
(195561,53,-1395.564,7253.929,25.8459,''),
(195561,54,-1397.073,7265.799,25.74383,''),
(195561,55,-1413.108,7284.411,25.42705,'Thrall - At the blue circle'),
(195561,56,-1392.792,7241.064,26.05975,''),
(195561,57,-1371.25,7232.395,32.27535,''),
(195561,58,-1364.153,7229.902,33.38591,''),
(195561,59,-1343.806,7212.792,32.92739,''),
(195561,60,-1319.785,7213.119,33.79593,''),
(195561,61,-1295.407,7206.193,41.04809,''),
(195561,62,-1270.321,7188.29,55.51945,''),
(195561,63,-1262.263,7183.662,57.41998,''),
(195561,64,-1246.086,7175.857,57.5472,''),
(195561,65,-1223.763,7174.583,57.60546,''),
(195561,66,-1223.883,7164.478,57.39006,'Thrall - Talking to Greatmother, part 2');

DELETE FROM `waypoints` WHERE `entry` = 196040;
INSERT INTO `waypoints`
(`entry`,`pointid`,`position_x`,`position_y`,`position_z`,`point_comment`)
VALUES
(196040,1,-1352.526,6329.687,43.60197,'Drek''thar - Start movement at spawn area'),
(196040,2,-1379.341,6356.216,41.59998,''),
(196040,3,-1395.792,6371.465,39.58159,''),
(196040,4,-1416.514,6393.018,36.98659,''),
(196040,5,-1437.613,6412.975,34.79754,''),
(196040,6,-1461.614,6437.551,32.09557,''),
(196040,7,-1490.277,6468.115,29.00541,''),
(196040,8,-1504.959,6496.419,25.39698,''),
(196040,9,-1512.75,6527.013,22.70193,''),
(196040,10,-1518.42,6552.887,21.62595,''),
(196040,11,-1521.663,6568.327,20.96966,''),
(196040,12,-1512.938,6632.651,22.39684,''),
(196040,13,-1507.196,6655.35,24.0721,''),
(196040,14,-1505.012,6662.614,24.45829,''),
(196040,15,-1494.345,6690.549,24.45761,''),
(196040,16,-1475.062,6730.891,24.92339,''),
(196040,17,-1455.289,6765.832,27.25725,''),
(196040,18,-1442.161,6784.633,28.08929,''),
(196040,19,-1425.53,6805.518,27.79475,''),
(196040,20,-1409.624,6827.367,27.13184,''),
(196040,21,-1389.318,6852.164,29.07919,''),
(196040,22,-1355.029,6887.561,30.71885,''),
(196040,23,-1332.001,6912.789,31.89273,''),
(196040,24,-1322.774,6923.111,31.98964,'Drek''thar - Before the gates of Garadar'),
(196040,25,-1302.877,6958.549,32.20076,'Drek''thar - Walk'), 
(196040,26,-1300.874,6966.982,32.62271,'Drek''thar - Dismount');

DELETE FROM `waypoints` WHERE `entry` = 196041;
INSERT INTO `waypoints`
(`entry`,`pointid`,`position_x`,`position_y`,`position_z`,`point_comment`)
VALUES
(196041,1,-1299.381,6969.558,32.77773,'Drek''thar - Start movement through Garadar'),
(196041,2,-1297.687,6974.454,32.50555,''),
(196041,3,-1292.62,6980.152,32.60894,''),
(196041,4,-1288.638,6984.105,32.85603,''),
(196041,5,-1289.818,6987.569,32.64879,''),
(196041,6,-1292.822,6991.643,32.63162,''),
(196041,7,-1299.464,6997.273,32.3705,''),
(196041,8,-1305.716,7004.623,32.50484,''),
(196041,9,-1317.576,7016.176,33.53638,''),
(196041,10,-1319.509,7018.285,33.6684,''),
(196041,11,-1324.291,7021.535,33.94361,''),
(196041,12,-1330.862,7025.661,33.89574,''),
(196041,13,-1343.045,7027.846,33.59311,''),
(196041,14,-1354.73,7033.678,33.77676,''),
(196041,15,-1367.055,7040.773,34.13885,''),
(196041,16,-1378.019,7051.014,34.56979,''),
(196041,17,-1388.98,7063.224,34.51899,''),
(196041,18,-1398.752,7089.976,33.52263,''),
(196041,19,-1399.983,7095.379,33.30988,''),
(196041,20,-1403.015,7114.424,33.53225,''),
(196041,21,-1402.203,7127.854,33.56348,''),
(196041,22,-1387.106,7138.031,34.09302,''),
(196041,23,-1373.571,7158.026,34.36966,''),
(196041,24,-1364.84,7166.027,33.91392,''),
(196041,25,-1364.164,7167.939,33.84708,''),
(196041,26,-1349.336,7199.349,33.86401,'Drek''thar - Stop at the bonfire'),
(196041,27,-1348.172,7212.101,32.80852,''),
(196041,28,-1360.009,7228.346,33.11093,''),
(196041,29,-1387.203,7234.722,27.29422,''),
(196041,30,-1406.162,7259.292,26.40471,''),
(196041,31,-1413.271,7262.43,26.42888,''),
(196041,32,-1418.196,7265.354,25.66155,'Drek''thar - Stop at the blue circle');

DELETE FROM `waypoints` WHERE `entry` = 180630;
INSERT INTO `waypoints`
(`entry`,`pointid`,`position_x`,`position_y`,`position_z`,`point_comment`)
VALUES
(180630,1,-1367.4,7230.706,32.98071,'Garrosh - Start movement in the bonfire'),
(180630,2,-1379.76,7232.02,30.05685,''),
(180630,3,-1386.526,7234.678,27.79641,''),
(180630,4,-1391.604,7241.841,26.46104,''),
(180630,5,-1396.907,7256.348,25.74905,''),
(180630,6,-1399.196,7265.486,25.62899,''),
(180630,7,-1410.123,7281.435,25.55205,'Garrosh - At the blue circle'),
(180630,8,-1399.196,7265.486,25.62899,''),
(180630,9,-1396.907,7256.348,25.74905,''),
(180630,10,-1391.604,7241.841,26.46104,''),
(180630,11,-1386.526,7234.678,27.79641,''),
(180630,12,-1379.76,7232.02,30.05685,''),
(180630,13,-1367.4,7230.706,32.98071,''),
(180630,14,-1344.674,7232.623,33.56076,'Garrosh - Back at the bonfire');

DELETE FROM `waypoints` WHERE `entry` = 180750;
INSERT INTO `waypoints`
(`entry`,`pointid`,`position_x`,`position_y`,`position_z`,`point_comment`)
VALUES
(180750,1,-1415.731,7271.584,25.49314,''),
(180750,2,-1421.56,7279.064,25.67705,'');

DELETE FROM `waypoints` WHERE `entry` = 196470;
INSERT INTO `waypoints`
(`entry`,`pointid`,`position_x`,`position_y`,`position_z`,`point_comment`)
VALUES
(196470,1,-1422.789,7280.642,25.68812,''),
(196470,2,-1422.97,7278.72,25.6325,'');

DELETE FROM `waypoints` WHERE `entry` = 180760;
INSERT INTO `waypoints`
(`entry`,`pointid`,`position_x`,`position_y`,`position_z`,`point_comment`)
VALUES
(180760,1,-1425.996,7276.042,25.80751,''),
(180760,2,-1423.213,7277.938,25.67705,'');

DELETE FROM `broadcast_text` WHERE `ID` = 94157;
INSERT INTO `broadcast_text` (`ID`,`Language`,`MaleText`,`FemaleText`,`EmoteID0`,`EmoteID1`,`EmoteID2`,`EmoteDelay0`,`EmoteDelay1`,`EmoteDelay2`,`SoundId`,`Unk1`,`Unk2`,`VerifiedBuild`) VALUES (94157,0,'We all live in the world of Azeroth.','',0,0,0,0,0,0,0,0,0,0);
UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` IN (11943,2307,37072,11940,11941,17804,19064,32743);
DELETE FROM `creature_text` WHERE `CreatureID` IN (11943,2307,37072,11940,11941,17804,19064,32743);
INSERT INTO `creature_text` (`CreatureID`,`GroupID`,`ID`,`Text`,`Type`,`Language`,`Probability`,`Emote`,`Duration`,`Sound`,`BroadcastTextId`,`TextRange`,`comment`) VALUES (11943,0,0,'',15,0,100,0,0,0,94157,0,''),(2307,0,0,'',15,0,100,0,0,0,94157,0,''),(37072,0,0,'',15,0,100,0,0,0,94157,0,''),(11940,0,0,'',15,0,100,0,0,0,94157,0,''),(11941,0,0,'',15,0,100,0,0,0,94157,0,''),(17804,0,0,'',15,0,100,0,0,0,94157,0,''),(19064,0,0,'',15,0,100,0,0,0,94157,0,''),(32743,0,0,'',15,0,100,0,0,0,94157,0,'');
DELETE FROM `smart_scripts` WHERE `source_type` = 0 AND `entryorguid` IN (11943,2307,37072,11940,11941,17804,19064,32743);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES (11943, 0, 0, 0, 22, 0, 100, 0, 95, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, ''),(2307, 0, 0, 0, 22, 0, 100, 0, 95, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, ''),(37072, 0, 0, 0, 22, 0, 100, 0, 95, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, ''),(11940, 0, 0, 0, 22, 0, 100, 0, 95, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, ''),(11941, 0, 0, 0, 22, 0, 100, 0, 95, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, ''),(17804, 0, 0, 0, 22, 0, 100, 0, 95, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, ''),(19064, 0, 0, 0, 22, 0, 100, 0, 95, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, ''),(32743, 0, 0, 0, 22, 0, 100, 0, 95, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, '');

SET @POINT := 0;
DELETE FROM `waypoints` WHERE `entry` = 1827530;
INSERT INTO `waypoints`
(`entry`,`pointid`,`position_x`,`position_y`,`position_z`,`point_comment`)
VALUES
(1827530,@POINT := @POINT + 1,-1335.208,6313.925,45.51422,'Kor''kron Honor Guard - start movement at spawn area'),
(1827530,@POINT := @POINT + 1,-1370.963,6349.604,42.44443,''),
(1827530,@POINT := @POINT + 1,-1388.865,6366.901,40.37408,''),
(1827530,@POINT := @POINT + 1,-1412.882,6389.243,37.57892,''),
(1827530,@POINT := @POINT + 1,-1439.271,6416.663,34.78931,''),
(1827530,@POINT := @POINT + 1,-1461.663,6438.391,32.23282,''),
(1827530,@POINT := @POINT + 1,-1477.928,6453.506,30.47572,''),
(1827530,@POINT := @POINT + 1,-1492.937,6469.55,28.93468,''),
(1827530,@POINT := @POINT + 1,-1506.934,6498.086,25.10762,''),
(1827530,@POINT := @POINT + 1,-1511.489,6515.687,23.48201,''),
(1827530,@POINT := @POINT + 1,-1513.084,6527.153,22.48186,''),
(1827530,@POINT := @POINT + 1,-1517.572,6552.807,21.63368,''),
(1827530,@POINT := @POINT + 1,-1520.962,6580.408,20.6239,''),
(1827530,@POINT := @POINT + 1,-1513.673,6622.252,21.37939,''),
(1827530,@POINT := @POINT + 1,-1505.733,6653.425,23.88755,''),
(1827530,@POINT := @POINT + 1,-1503.204,6662.354,24.24408,''),
(1827530,@POINT := @POINT + 1,-1489.222,6698.047,24.55171,''),
(1827530,@POINT := @POINT + 1,-1472.453,6733.013,25.15502,''),
(1827530,@POINT := @POINT + 1,-1456.333,6762.938,26.8497,''),
(1827530,@POINT := @POINT + 1,-1447.986,6777.398,28.01004,''),
(1827530,@POINT := @POINT + 1,-1430.961,6801.701,28.01143,''),
(1827530,@POINT := @POINT + 1,-1417.353,6824.057,27.24986,''),
(1827530,@POINT := @POINT + 1,-1401.949,6847.906,27.6743,''),
(1827530,@POINT := @POINT + 1,-1374.873,6866.761,30.08648,''),
(1827530,@POINT := @POINT + 1,-1364.208,6876.673,30.61027,''),
(1827530,@POINT := @POINT + 1,-1352.93,6886.95,30.93086,''),
(1827530,@POINT := @POINT + 1,-1322.323,6914.781,32.49161,''),
(1827530,@POINT := @POINT + 1,-1317.948,6917.533,32.90894,'Kor''kron Honor Guard - before the gates of Garadar');

SET @POINT := 0;
DELETE FROM `waypoints` WHERE `entry` = 1827540;
INSERT INTO `waypoints`
(`entry`,`pointid`,`position_x`,`position_y`,`position_z`,`point_comment`)
VALUES
(1827540,@POINT := @POINT + 1,-1346.921,6327.715,43.98703,'Kor''kron Honor Guard - start movement at spawn area'),
(1827540,@POINT := @POINT + 1,-1385.748,6361.829,40.84011,''),
(1827540,@POINT := @POINT + 1,-1399.725,6375.522,39.03989,''),
(1827540,@POINT := @POINT + 1,-1414.304,6390.69,37.17965,''),
(1827540,@POINT := @POINT + 1,-1428.223,6404.804,36.00574,''),
(1827540,@POINT := @POINT + 1,-1452.067,6426.114,33.09519,''),
(1827540,@POINT := @POINT + 1,-1464.908,6440.203,31.77184,''),
(1827540,@POINT := @POINT + 1,-1490.506,6468.814,28.84116,''),
(1827540,@POINT := @POINT + 1,-1506.089,6501.073,24.8507,''),
(1827540,@POINT := @POINT + 1,-1512.866,6529.669,22.53263,''),
(1827540,@POINT := @POINT + 1,-1519.981,6574.273,21.05044,''),
(1827540,@POINT := @POINT + 1,-1516.592,6602.926,21.30149,''),
(1827540,@POINT := @POINT + 1,-1507.95,6655.633,23.95883,''),
(1827540,@POINT := @POINT + 1,-1505.954,6664.893,24.49434,''),
(1827540,@POINT := @POINT + 1,-1490.85,6696.347,24.39755,''),
(1827540,@POINT := @POINT + 1,-1467.245,6747.524,25.85784,''),
(1827540,@POINT := @POINT + 1,-1455.335,6767.127,27.21014,''),
(1827540,@POINT := @POINT + 1,-1441.818,6786.843,28.33891,''),
(1827540,@POINT := @POINT + 1,-1428.624,6802.308,27.77453,''),
(1827540,@POINT := @POINT + 1,-1418.503,6822.202,27.28543,''),
(1827540,@POINT := @POINT + 1,-1409.673,6844.438,27.4851,''),
(1827540,@POINT := @POINT + 1,-1392.207,6855.187,28.61077,''),
(1827540,@POINT := @POINT + 1,-1366.374,6876.586,30.37937,''),
(1827540,@POINT := @POINT + 1,-1333.158,6911.208,31.68118,''),
(1827540,@POINT := @POINT + 1,-1331.007,6913.661,31.89906,''),
(1827540,@POINT := @POINT + 1,-1329.025,6928.554,32.16651,'Kor''kron Honor Guard - before the gates of Garadar');

SET @POINT := 0;
DELETE FROM `waypoints` WHERE `entry` = 1827550;
INSERT INTO `waypoints`
(`entry`,`pointid`,`position_x`,`position_y`,`position_z`,`point_comment`)
VALUES
(1827550,@POINT := @POINT + 1,-1333.763,6317.533,44.76424,'Kor''kron Warrior - start movement at spawn area'),
(1827550,@POINT := @POINT + 1,-1363.905,6343.13,42.91702,''),
(1827550,@POINT := @POINT + 1,-1370.023,6348.561,42.31838,''),
(1827550,@POINT := @POINT + 1,-1378.516,6356.66,41.4787,''),
(1827550,@POINT := @POINT + 1,-1390.295,6368.313,40.27466,''),
(1827550,@POINT := @POINT + 1,-1399.076,6376.377,39.21536,''),
(1827550,@POINT := @POINT + 1,-1408.187,6384.929,38.12248,''),
(1827550,@POINT := @POINT + 1,-1417.009,6392.926,37.11723,''),
(1827550,@POINT := @POINT + 1,-1420.307,6396.715,36.50815,''),
(1827550,@POINT := @POINT + 1,-1433.707,6410.693,35.37553,''),
(1827550,@POINT := @POINT + 1,-1436.64,6413.748,34.57877,''),
(1827550,@POINT := @POINT + 1,-1450.413,6427.477,33.34807,''),
(1827550,@POINT := @POINT + 1,-1458.148,6434.958,32.6637,''),
(1827550,@POINT := @POINT + 1,-1461.805,6438.347,32.01699,''),
(1827550,@POINT := @POINT + 1,-1471.092,6446.86,30.9089,''),
(1827550,@POINT := @POINT + 1,-1484.458,6459.56,29.76557,''),
(1827550,@POINT := @POINT + 1,-1491.493,6467.949,28.84589,''),
(1827550,@POINT := @POINT + 1,-1499.084,6476.817,28.1244,''),
(1827550,@POINT := @POINT + 1,-1502.818,6487.976,26.59095,''),
(1827550,@POINT := @POINT + 1,-1507.241,6498.776,25.0731,''),
(1827550,@POINT := @POINT + 1,-1509.246,6507.414,24.03932,''),
(1827550,@POINT := @POINT + 1,-1511.655,6515.82,23.08534,''),
(1827550,@POINT := @POINT + 1,-1513.323,6527.424,22.3445,''),
(1827550,@POINT := @POINT + 1,-1516.321,6546.909,21.60966,''),
(1827550,@POINT := @POINT + 1,-1519.096,6558.417,21.15165,''),
(1827550,@POINT := @POINT + 1,-1521.865,6569.838,20.69001,''),
(1827550,@POINT := @POINT + 1,-1521.074,6580.762,20.57644,''),
(1827550,@POINT := @POINT + 1,-1521.409,6593.634,20.6136,''),
(1827550,@POINT := @POINT + 1,-1518.83,6604.96,20.96532,''),
(1827550,@POINT := @POINT + 1,-1515.401,6616.24,21.21825,''),
(1827550,@POINT := @POINT + 1,-1512.263,6626.467,22.02513,''),
(1827550,@POINT := @POINT + 1,-1509.62,6637.625,23.04537,''),
(1827550,@POINT := @POINT + 1,-1508.07,6643.548,23.31059,''),
(1827550,@POINT := @POINT + 1,-1505.011,6655.951,24.2037,''),
(1827550,@POINT := @POINT + 1,-1499.99,6670.876,24.71427,''),
(1827550,@POINT := @POINT + 1,-1495.02,6683.651,24.56915,''),
(1827550,@POINT := @POINT + 1,-1490.671,6694.655,24.31915,''),
(1827550,@POINT := @POINT + 1,-1485.896,6705.44,24.31023,''),
(1827550,@POINT := @POINT + 1,-1480.961,6716.088,24.24273,''),
(1827550,@POINT := @POINT + 1,-1476.005,6726.78,24.58745,''),
(1827550,@POINT := @POINT + 1,-1473.608,6730.999,24.95835,''),
(1827550,@POINT := @POINT + 1,-1468.324,6741.463,25.38992,''),
(1827550,@POINT := @POINT + 1,-1464.55,6748.065,25.98542,''),
(1827550,@POINT := @POINT + 1,-1458.849,6758.314,26.61341,''),
(1827550,@POINT := @POINT + 1,-1453.858,6767.143,27.12453,''),
(1827550,@POINT := @POINT + 1,-1444.201,6783.815,28.18245,''),
(1827550,@POINT := @POINT + 1,-1437.69,6794.885,28.26914,''),
(1827550,@POINT := @POINT + 1,-1431.503,6801.295,27.90124,''),
(1827550,@POINT := @POINT + 1,-1421.835,6812.321,27.47453,''),
(1827550,@POINT := @POINT + 1,-1417.677,6823.269,26.97453,''),
(1827550,@POINT := @POINT + 1,-1412.783,6834.058,26.78658,''),
(1827550,@POINT := @POINT + 1,-1405.642,6843.262,27.14766,''),
(1827550,@POINT := @POINT + 1,-1399.677,6850.853,27.89092,''),
(1827550,@POINT := @POINT + 1,-1395.241,6853.676,28.38161,''),
(1827550,@POINT := @POINT + 1,-1381.865,6862.517,29.2046,''),
(1827550,@POINT := @POINT + 1,-1375.528,6867.126,29.80379,''),
(1827550,@POINT := @POINT + 1,-1364.123,6876.721,30.63628,''),
(1827550,@POINT := @POINT + 1,-1352.062,6887.736,30.68115,''),
(1827550,@POINT := @POINT + 1,-1344.626,6896.469,30.88867,''),
(1827550,@POINT := @POINT + 1,-1341.484,6900.029,31.53562,''),
(1827550,@POINT := @POINT + 1,-1329.528,6909.881,31.87608,''),
(1827550,@POINT := @POINT + 1,-1320.009,6914.573,32.7706,'Kor''kron Warrior - before the gates of Garadar');

SET @POINT := 0;
DELETE FROM `waypoints` WHERE `entry` = 1827560;
INSERT INTO `waypoints`
(`entry`,`pointid`,`position_x`,`position_y`,`position_z`,`point_comment`)
VALUES
(1827560,@POINT := @POINT + 1,-1329.355,6321.17,44.81275,'Kor''kron Warrior - start movement at spawn area'),
(1827560,@POINT := @POINT + 1,-1361.635,6336.36,43.08705,''),
(1827560,@POINT := @POINT + 1,-1372.819,6346.113,42.01437,''),
(1827560,@POINT := @POINT + 1,-1384.142,6356.921,40.8881,''),
(1827560,@POINT := @POINT + 1,-1388.693,6361.057,40.47346,''),
(1827560,@POINT := @POINT + 1,-1399.952,6371.858,39.02798,''),
(1827560,@POINT := @POINT + 1,-1407.791,6379.146,38.0183,''),
(1827560,@POINT := @POINT + 1,-1419.109,6389.892,36.66923,''),
(1827560,@POINT := @POINT + 1,-1423.201,6394.178,36.01923,''),
(1827560,@POINT := @POINT + 1,-1434.259,6405.518,35.04535,''),
(1827560,@POINT := @POINT + 1,-1439.697,6411.308,34.23424,''),
(1827560,@POINT := @POINT + 1,-1447.909,6419.515,33.35559,''),
(1827560,@POINT := @POINT + 1,-1455.809,6426.935,32.38613,''),
(1827560,@POINT := @POINT + 1,-1464.235,6435.105,31.66226,''),
(1827560,@POINT := @POINT + 1,-1474.721,6445.096,30.66137,''),
(1827560,@POINT := @POINT + 1,-1481.802,6451.782,29.92131,''),
(1827560,@POINT := @POINT + 1,-1491.77,6462.492,29.19061,''),
(1827560,@POINT := @POINT + 1,-1501.547,6473.975,28.09883,''),
(1827560,@POINT := @POINT + 1,-1505.847,6485.064,26.83763,''),
(1827560,@POINT := @POINT + 1,-1509.41,6493.93,25.15765,''),
(1827560,@POINT := @POINT + 1,-1511.947,6502.635,23.95799,''),
(1827560,@POINT := @POINT + 1,-1516.025,6518.239,22.95268,''),
(1827560,@POINT := @POINT + 1,-1517.373,6533.151,22.13318,''),
(1827560,@POINT := @POINT + 1,-1519.741,6544.64,21.32426,''),
(1827560,@POINT := @POINT + 1,-1521.564,6553.415,21.1659,''),
(1827560,@POINT := @POINT + 1,-1525.302,6567.618,20.69001,''),
(1827560,@POINT := @POINT + 1,-1525.084,6580.297,20.44001,''),
(1827560,@POINT := @POINT + 1,-1525.247,6592.177,20.43892,''),
(1827560,@POINT := @POINT + 1,-1522.817,6593.657,20.63129,''),
(1827560,@POINT := @POINT + 1,-1519.499,6616.019,21.0576,''),
(1827560,@POINT := @POINT + 1,-1516.541,6625.611,21.77748,''),
(1827560,@POINT := @POINT + 1,-1513.549,6637.813,22.7097,''),
(1827560,@POINT := @POINT + 1,-1512.125,6643.132,23.04766,''),
(1827560,@POINT := @POINT + 1,-1509.588,6653.51,23.81737,''),
(1827560,@POINT := @POINT + 1,-1505.081,6667.459,24.41676,''),
(1827560,@POINT := @POINT + 1,-1499.122,6683.763,24.44415,''),
(1827560,@POINT := @POINT + 1,-1494.774,6694.767,24.25445,''),
(1827560,@POINT := @POINT + 1,-1489.985,6705.788,24.63848,''),
(1827560,@POINT := @POINT + 1,-1485.05,6716.437,24.32402,''),
(1827560,@POINT := @POINT + 1,-1480.095,6727.128,24.5125,''),
(1827560,@POINT := @POINT + 1,-1476.938,6733.173,24.82853,''),
(1827560,@POINT := @POINT + 1,-1472.807,6741.392,25.30933,''),
(1827560,@POINT := @POINT + 1,-1466.335,6753.203,26.52328,''),
(1827560,@POINT := @POINT + 1,-1463.646,6757.479,26.76385,''),
(1827560,@POINT := @POINT + 1,-1456.647,6770.112,27.49985,''),
(1827560,@POINT := @POINT + 1,-1451.989,6777.806,28.08868,''),
(1827560,@POINT := @POINT + 1,-1441.726,6795.631,28.46372,''),
(1827560,@POINT := @POINT + 1,-1436.475,6801.089,28.19376,''),
(1827560,@POINT := @POINT + 1,-1427.71,6811.352,27.80988,''),
(1827560,@POINT := @POINT + 1,-1421.77,6823.58,27.14934,''),
(1827560,@POINT := @POINT + 1,-1416.875,6834.373,26.91182,''),
(1827560,@POINT := @POINT + 1,-1409.534,6844.566,27.13716,''),
(1827560,@POINT := @POINT + 1,-1402.18,6853.799,27.7806,''),
(1827560,@POINT := @POINT + 1,-1392.777,6860.603,28.95402,''),
(1827560,@POINT := @POINT + 1,-1385.382,6864.938,29.17112,''),
(1827560,@POINT := @POINT + 1,-1373.838,6873.02,29.70639,''),
(1827560,@POINT := @POINT + 1,-1364.647,6881.427,30.05615,''),
(1827560,@POINT := @POINT + 1,-1356.832,6888.598,30.68036,''),
(1827560,@POINT := @POINT + 1,-1348.453,6897.952,30.87292,''),
(1827560,@POINT := @POINT + 1,-1342.007,6905.345,31.53397,''),
(1827560,@POINT := @POINT + 1,-1330.482,6914.278,31.69605,''),
(1827560,@POINT := @POINT + 1,-1327.207,6915.976,32.05476,''),
(1827560,@POINT := @POINT + 1,-1319.087,6921.402,32.82956,''),
(1827560,@POINT := @POINT + 1,-1316.287,6921.044,32.98755,'Kor''kron Warrior - before the gates of Garadar');

SET @POINT := 0;
DELETE FROM `waypoints` WHERE `entry` = 1827570;
INSERT INTO `waypoints`
(`entry`,`pointid`,`position_x`,`position_y`,`position_z`,`point_comment`)
VALUES
(1827570,@POINT := @POINT + 1,-1325.298,6324.27,43.78838,'Kor''kron Warrior - start movement at spawn area'),
(1827570,@POINT := @POINT + 1,-1361.908,6333.863,42.91473,''),
(1827570,@POINT := @POINT + 1,-1374.653,6345.039,42.23245,''),
(1827570,@POINT := @POINT + 1,-1380.988,6351.012,41.40088,''),
(1827570,@POINT := @POINT + 1,-1386.777,6356.614,40.50622,''),
(1827570,@POINT := @POINT + 1,-1401.021,6369.923,39.22643,''),
(1827570,@POINT := @POINT + 1,-1405.866,6374.74,38.51777,''),
(1827570,@POINT := @POINT + 1,-1417.919,6385.975,37.13863,''),
(1827570,@POINT := @POINT + 1,-1420.83,6388.933,36.39534,''),
(1827570,@POINT := @POINT + 1,-1432.503,6400.78,35.28744,''),
(1827570,@POINT := @POINT + 1,-1438.209,6406.566,34.57018,''),
(1827570,@POINT := @POINT + 1,-1448.355,6417.047,33.47414,''),
(1827570,@POINT := @POINT + 1,-1458.702,6427.233,32.2258,''),
(1827570,@POINT := @POINT + 1,-1466.381,6434.671,31.23962,''),
(1827570,@POINT := @POINT + 1,-1475.041,6442.662,30.76212,''),
(1827570,@POINT := @POINT + 1,-1482.087,6449.107,30.03783,''),
(1827570,@POINT := @POINT + 1,-1492.048,6460.012,29.59447,''),
(1827570,@POINT := @POINT + 1,-1498.249,6466.949,29.06971,''),
(1827570,@POINT := @POINT + 1,-1505.504,6479.773,27.49609,''),
(1827570,@POINT := @POINT + 1,-1510.314,6490.878,25.71376,''),
(1827570,@POINT := @POINT + 1,-1513.284,6500.401,23.8247,''),
(1827570,@POINT := @POINT + 1,-1517.095,6514.258,23.00713,''),
(1827570,@POINT := @POINT + 1,-1519.037,6529.052,22.07376,''),
(1827570,@POINT := @POINT + 1,-1519.89,6532.946,21.64196,''),
(1827570,@POINT := @POINT + 1,-1523.678,6552.211,20.64897,''),
(1827570,@POINT := @POINT + 1,-1526.459,6563.681,20.64311,''),
(1827570,@POINT := @POINT + 1,-1527.088,6576.715,20.44001,''),
(1827570,@POINT := @POINT + 1,-1527.25,6588.595,20.49604,''),
(1827570,@POINT := @POINT + 1,-1522.972,6593.719,20.72314,''),
(1827570,@POINT := @POINT + 1,-1519.17,6604.853,21.03719,''),
(1827570,@POINT := @POINT + 1,-1519.057,6623.997,21.66499,''),
(1827570,@POINT := @POINT + 1,-1517.823,6626.511,21.79336,''),
(1827570,@POINT := @POINT + 1,-1515.169,6637.853,22.81165,''),
(1827570,@POINT := @POINT + 1,-1512.427,6650.387,23.70753,''),
(1827570,@POINT := @POINT + 1,-1508.854,6662.672,24.46819,''),
(1827570,@POINT := @POINT + 1,-1502.337,6681.211,24.6262,''),
(1827570,@POINT := @POINT + 1,-1497.989,6692.215,24.5152,''),
(1827570,@POINT := @POINT + 1,-1493.342,6703.426,24.63262,''),
(1827570,@POINT := @POINT + 1,-1488.407,6714.075,24.44316,''),
(1827570,@POINT := @POINT + 1,-1483.451,6724.766,24.39556,''),
(1827570,@POINT := @POINT + 1,-1479.773,6731.986,24.80669,''),
(1827570,@POINT := @POINT + 1,-1474.442,6742.433,25.19432,''),
(1827570,@POINT := @POINT + 1,-1472.166,6746.609,25.7476,''),
(1827570,@POINT := @POINT + 1,-1467.675,6754.612,26.72865,''),
(1827570,@POINT := @POINT + 1,-1458.197,6771.545,27.48715,''),
(1827570,@POINT := @POINT + 1,-1452.299,6781.779,28.68779,''),
(1827570,@POINT := @POINT + 1,-1446.893,6790.88,29.0572,''),
(1827570,@POINT := @POINT + 1,-1437.404,6803.47,28.13591,''),
(1827570,@POINT := @POINT + 1,-1436.547,6803.941,28.29537,''),
(1827570,@POINT := @POINT + 1,-1427.776,6816.596,27.67589,''),
(1827570,@POINT := @POINT + 1,-1420.213,6831.984,27.09953,''),
(1827570,@POINT := @POINT + 1,-1413.353,6843.065,27.26216,''),
(1827570,@POINT := @POINT + 1,-1406,6852.297,27.6003,''),
(1827570,@POINT := @POINT + 1,-1396.472,6860.553,28.81346,''),
(1827570,@POINT := @POINT + 1,-1391.937,6862.945,28.96782,''),
(1827570,@POINT := @POINT + 1,-1378.505,6871.798,29.84812,''),
(1827570,@POINT := @POINT + 1,-1368.653,6880.533,29.83139,''),
(1827570,@POINT := @POINT + 1,-1363.03,6885.771,30.37303,''),
(1827570,@POINT := @POINT + 1,-1355.941,6892.935,31.19475,''),
(1827570,@POINT := @POINT + 1,-1345.186,6904.807,31.7437,''),
(1827570,@POINT := @POINT + 1,-1334.584,6914.144,31.65829,''),
(1827570,@POINT := @POINT + 1,-1322.627,6911.815,32.51368,'Kor''kron Warrior - before the gates of Garadar');

SET @POINT := 0;
DELETE FROM `waypoints` WHERE `entry` = 1827580;
INSERT INTO `waypoints`
(`entry`,`pointid`,`position_x`,`position_y`,`position_z`,`point_comment`)
VALUES
(1827580,@POINT := @POINT + 1,-1321.754,6328.901,41.62631,'Kor''kron Warrior - start movement at spawn area'),
(1827580,@POINT := @POINT + 1,-1363.824,6335.642,43.18006,''),
(1827580,@POINT := @POINT + 1,-1367.532,6339.687,42.49469,''),
(1827580,@POINT := @POINT + 1,-1380.589,6351.53,41.40108,''),
(1827580,@POINT := @POINT + 1,-1384.635,6355.611,40.75982,''),
(1827580,@POINT := @POINT + 1,-1394.609,6365.187,39.9352,''),
(1827580,@POINT := @POINT + 1,-1406.167,6375.746,38.3701,''),
(1827580,@POINT := @POINT + 1,-1413.226,6382.483,37.68437,''),
(1827580,@POINT := @POINT + 1,-1422.299,6391.198,36.60815,''),
(1827580,@POINT := @POINT + 1,-1431.174,6400.623,35.34938,''),
(1827580,@POINT := @POINT + 1,-1437.401,6406.901,34.66608,''),
(1827580,@POINT := @POINT + 1,-1442.998,6412.431,34.03405,''),
(1827580,@POINT := @POINT + 1,-1455.305,6424.911,32.85349,''),
(1827580,@POINT := @POINT + 1,-1464.485,6433.617,31.67649,''),
(1827580,@POINT := @POINT + 1,-1466.622,6435.914,31.27636,''),
(1827580,@POINT := @POINT + 1,-1478.637,6446.881,30.35589,''),
(1827580,@POINT := @POINT + 1,-1484.988,6453.343,29.77198,''),
(1827580,@POINT := @POINT + 1,-1496.301,6465.876,29.07766,''),
(1827580,@POINT := @POINT + 1,-1504.334,6478.234,27.72208,''),
(1827580,@POINT := @POINT + 1,-1509.015,6489.258,26.03633,''),
(1827580,@POINT := @POINT + 1,-1512.598,6499.547,24.256,''),
(1827580,@POINT := @POINT + 1,-1513.652,6503.067,23.52419,''),
(1827580,@POINT := @POINT + 1,-1517.402,6521.195,22.66558,''),
(1827580,@POINT := @POINT + 1,-1518.43,6528.76,21.92763,''),
(1827580,@POINT := @POINT + 1,-1522.037,6548.449,20.92362,''),
(1827580,@POINT := @POINT + 1,-1524.814,6559.92,20.59037,''),
(1827580,@POINT := @POINT + 1,-1526.32,6572.684,20.53047,''),
(1827580,@POINT := @POINT + 1,-1526.482,6584.563,20.43049,''),
(1827580,@POINT := @POINT + 1,-1526.42,6597.86,20.69001,''),
(1827580,@POINT := @POINT + 1,-1519.963,6605.205,21.00993,''),
(1827580,@POINT := @POINT + 1,-1519.591,6620.319,21.0576,''),
(1827580,@POINT := @POINT + 1,-1517.531,6626.107,21.74467,''),
(1827580,@POINT := @POINT + 1,-1515.495,6634.917,22.55741,''),
(1827580,@POINT := @POINT + 1,-1512.44,6647.406,23.40374,''),
(1827580,@POINT := @POINT + 1,-1509.398,6658.883,24.10394,''),
(1827580,@POINT := @POINT + 1,-1503.16,6677.19,24.61741,''),
(1827580,@POINT := @POINT + 1,-1498.812,6688.194,24.48883,''),
(1827580,@POINT := @POINT + 1,-1494.395,6699.459,24.31915,''),
(1827580,@POINT := @POINT + 1,-1489.46,6710.108,24.41777,''),
(1827580,@POINT := @POINT + 1,-1484.505,6720.799,24.35967,''),
(1827580,@POINT := @POINT + 1,-1480.978,6728.063,24.67559,''),
(1827580,@POINT := @POINT + 1,-1476.514,6736.513,25.30963,''),
(1827580,@POINT := @POINT + 1,-1472.124,6745.334,25.66236,''),
(1827580,@POINT := @POINT + 1,-1466.02,6756.479,26.92971,''),
(1827580,@POINT := @POINT + 1,-1458.721,6769.361,27.14414,''),
(1827580,@POINT := @POINT + 1,-1453.228,6778.674,28.32249,''),
(1827580,@POINT := @POINT + 1,-1450.315,6783.542,28.74957,''),
(1827580,@POINT := @POINT + 1,-1439.5,6800.013,28.5634,''),
(1827580,@POINT := @POINT + 1,-1436.334,6803.384,28.27963,''),
(1827580,@POINT := @POINT + 1,-1427.068,6816.092,27.68509,''),
(1827580,@POINT := @POINT + 1,-1421.5,6827.609,27.3265,''),
(1827580,@POINT := @POINT + 1,-1415.314,6839.459,27.16231,''),
(1827580,@POINT := @POINT + 1,-1407.96,6848.691,27.38716,''),
(1827580,@POINT := @POINT + 1,-1401.463,6855.691,28.08788,''),
(1827580,@POINT := @POINT + 1,-1389.879,6863.914,29.1686,''),
(1827580,@POINT := @POINT + 1,-1382.767,6867.549,29.61892,''),
(1827580,@POINT := @POINT + 1,-1371.147,6877.273,29.73129,''),
(1827580,@POINT := @POINT + 1,-1362.207,6885.481,30.25134,''),
(1827580,@POINT := @POINT + 1,-1355.52,6892.045,30.93396,''),
(1827580,@POINT := @POINT + 1,-1351.276,6896.914,31.4434,''),
(1827580,@POINT := @POINT + 1,-1339.372,6909.605,31.79743,''),
(1827580,@POINT := @POINT + 1,-1327.955,6917.349,32.14788,''),
(1827580,@POINT := @POINT + 1,-1314.081,6923.662,33.38514,'Kor''kron Warrior - before the gates of Garadar');

SET @POINT := 0;
DELETE FROM `waypoints` WHERE `entry` = 1827590;
INSERT INTO `waypoints`
(`entry`,`pointid`,`position_x`,`position_y`,`position_z`,`point_comment`)
VALUES
(1827590,@POINT := @POINT + 1,-1336.72,6309.458,46.23232,'Kor''kron Warrior - start movement at spawn area'),
(1827590,@POINT := @POINT + 1,-1356.145,6332.302,43.40115,''),
(1827590,@POINT := @POINT + 1,-1364.42,6340.505,42.69855,''),
(1827590,@POINT := @POINT + 1,-1371.569,6347.124,42.21515,''),
(1827590,@POINT := @POINT + 1,-1380.569,6356.029,41.34633,''),
(1827590,@POINT := @POINT + 1,-1392.035,6366.903,40.15483,''),
(1827590,@POINT := @POINT + 1,-1399.837,6374.239,39.07078,''),
(1827590,@POINT := @POINT + 1,-1409.898,6383.486,37.99396,''),
(1827590,@POINT := @POINT + 1,-1418.975,6392.333,36.75255,''),
(1827590,@POINT := @POINT + 1,-1423.055,6396.651,36.05185,''),
(1827590,@POINT := @POINT + 1,-1435.306,6409.424,35.18626,''),
(1827590,@POINT := @POINT + 1,-1438.91,6412.784,34.33749,''),
(1827590,@POINT := @POINT + 1,-1451.973,6426.07,33.13849,''),
(1827590,@POINT := @POINT + 1,-1459.658,6433.544,32.40159,''),
(1827590,@POINT := @POINT + 1,-1468.793,6442.378,31.23444,''),
(1827590,@POINT := @POINT + 1,-1473.118,6446.19,30.62062,''),
(1827590,@POINT := @POINT + 1,-1480.416,6453.123,29.88379,''),
(1827590,@POINT := @POINT + 1,-1490.209,6463.719,29.06587,''),
(1827590,@POINT := @POINT + 1,-1499.841,6476.373,28.08873,''),
(1827590,@POINT := @POINT + 1,-1505.097,6488.159,26.31472,''),
(1827590,@POINT := @POINT + 1,-1508.56,6497.284,24.97636,''),
(1827590,@POINT := @POINT + 1,-1511.203,6506.818,23.98714,''),
(1827590,@POINT := @POINT + 1,-1514.122,6520.388,22.96544,''),
(1827590,@POINT := @POINT + 1,-1514.864,6527.256,22.52153,''),
(1827590,@POINT := @POINT + 1,-1518.363,6546.622,21.38066,''),
(1827590,@POINT := @POINT + 1,-1520.082,6554.287,21.28659,''),
(1827590,@POINT := @POINT + 1,-1523.14,6570.088,20.69001,''),
(1827590,@POINT := @POINT + 1,-1522.832,6579.914,20.5603,''),
(1827590,@POINT := @POINT + 1,-1524.179,6594.422,20.7082,''),
(1827590,@POINT := @POINT + 1,-1520.75,6605.702,20.9326,''),
(1827590,@POINT := @POINT + 1,-1517.351,6616.88,21.0576,''),
(1827590,@POINT := @POINT + 1,-1514.478,6626.123,21.90445,''),
(1827590,@POINT := @POINT + 1,-1511.412,6638.479,22.90358,''),
(1827590,@POINT := @POINT + 1,-1510.284,6642.396,23.00464,''),
(1827590,@POINT := @POINT + 1,-1507.214,6655.433,23.98821,''),
(1827590,@POINT := @POINT + 1,-1502.887,6668.721,24.71677,''),
(1827590,@POINT := @POINT + 1,-1496.857,6684.585,24.37945,''),
(1827590,@POINT := @POINT + 1,-1492.652,6695.744,24.19415,''),
(1827590,@POINT := @POINT + 1,-1487.717,6706.392,24.35918,''),
(1827590,@POINT := @POINT + 1,-1482.761,6717.083,24.02666,''),
(1827590,@POINT := @POINT + 1,-1479.379,6724.283,24.27056,''),
(1827590,@POINT := @POINT + 1,-1474.643,6733.743,25.07562,''),
(1827590,@POINT := @POINT + 1,-1469.978,6743.022,25.55116,''),
(1827590,@POINT := @POINT + 1,-1466.778,6748.466,26.04319,''),
(1827590,@POINT := @POINT + 1,-1460.668,6759.355,26.73457,''),
(1827590,@POINT := @POINT + 1,-1455.618,6768.268,27.25087,''),
(1827590,@POINT := @POINT + 1,-1447.447,6782.421,28.36941,''),
(1827590,@POINT := @POINT + 1,-1438.87,6795.957,28.37095,''),
(1827590,@POINT := @POINT + 1,-1434.356,6800.853,28.01996,''),
(1827590,@POINT := @POINT + 1,-1424.343,6813.511,27.45817,''),
(1827590,@POINT := @POINT + 1,-1419.461,6824.308,26.97453,''),
(1827590,@POINT := @POINT + 1,-1414.499,6835.437,26.9521,''),
(1827590,@POINT := @POINT + 1,-1407.145,6844.669,27.09224,''),
(1827590,@POINT := @POINT + 1,-1401.381,6852.377,27.69153,''),
(1827590,@POINT := @POINT + 1,-1391.105,6859.356,28.94751,''),
(1827590,@POINT := @POINT + 1,-1383.203,6863.225,29.20696,''),
(1827590,@POINT := @POINT + 1,-1377.708,6867.614,29.69486,''),
(1827590,@POINT := @POINT + 1,-1362.461,6881.135,30.49602,''),
(1827590,@POINT := @POINT + 1,-1353.834,6889.062,30.55615,''),
(1827590,@POINT := @POINT + 1,-1346.1,6897.9,30.8667,''),
(1827590,@POINT := @POINT + 1,-1344.104,6900.306,31.19846,''),
(1827590,@POINT := @POINT + 1,-1325.029,6908.24,32.16651,'Kor''kron Warrior - before the gates of Garadar');

SET @POINT := 0;
DELETE FROM `waypoints` WHERE `entry` = 1827600;
INSERT INTO `waypoints`
(`entry`,`pointid`,`position_x`,`position_y`,`position_z`,`point_comment`)
VALUES
(1827600,@POINT := @POINT + 1,-1339.819,6305.84,45.90306,'Kor''kron Warrior - start movement at spawn area'),
(1827600,@POINT := @POINT + 1,-1353.48,6334.996,43.66293,''),
(1827600,@POINT := @POINT + 1,-1362.379,6343.898,42.91652,''),
(1827600,@POINT := @POINT + 1,-1367.995,6349.569,42.41758,''),
(1827600,@POINT := @POINT + 1,-1377.233,6358.242,41.58788,''),
(1827600,@POINT := @POINT + 1,-1388.462,6369.133,40.42139,''),
(1827600,@POINT := @POINT + 1,-1399.024,6379.229,39.05355,''),
(1827600,@POINT := @POINT + 1,-1406.374,6386.012,38.21695,''),
(1827600,@POINT := @POINT + 1,-1414.845,6394.005,37.23859,''),
(1827600,@POINT := @POINT + 1,-1420.882,6400.272,36.36848,''),
(1827600,@POINT := @POINT + 1,-1430.344,6410.01,35.60098,''),
(1827600,@POINT := @POINT + 1,-1440.757,6420.681,34.60674,''),
(1827600,@POINT := @POINT + 1,-1445.65,6425.55,34.0351,''),
(1827600,@POINT := @POINT + 1,-1452.061,6431.742,33.1847,''),
(1827600,@POINT := @POINT + 1,-1461.734,6441.119,32.12207,''),
(1827600,@POINT := @POINT + 1,-1468.27,6447.396,31.4397,''),
(1827600,@POINT := @POINT + 1,-1482.441,6460.692,29.94483,''),
(1827600,@POINT := @POINT + 1,-1488.617,6467.914,29.13134,''),
(1827600,@POINT := @POINT + 1,-1493.086,6474.166,28.36966,''),
(1827600,@POINT := @POINT + 1,-1501.126,6489.077,26.41469,''),
(1827600,@POINT := @POINT + 1,-1504.175,6497.065,25.4574,''),
(1827600,@POINT := @POINT + 1,-1507.244,6508.102,24.20155,''),
(1827600,@POINT := @POINT + 1,-1509.338,6516.578,23.3781,''),
(1827600,@POINT := @POINT + 1,-1510.842,6531.006,22.51495,''),
(1827600,@POINT := @POINT + 1,-1514.373,6547.584,21.8433,''),
(1827600,@POINT := @POINT + 1,-1516.34,6556.983,21.71647,''),
(1827600,@POINT := @POINT + 1,-1518.615,6568.801,21.1698,''),
(1827600,@POINT := @POINT + 1,-1518.762,6576.452,20.7382,''),
(1827600,@POINT := @POINT + 1,-1520.253,6593.228,20.56501,''),
(1827600,@POINT := @POINT + 1,-1517.116,6602.806,21.31131,''),
(1827600,@POINT := @POINT + 1,-1513.424,6615.687,20.98766,''),
(1827600,@POINT := @POINT + 1,-1510.267,6626.063,22.00375,''),
(1827600,@POINT := @POINT + 1,-1508.344,6634.278,23.1557,''),
(1827600,@POINT := @POINT + 1,-1507.029,6645.714,23.42168,''),
(1827600,@POINT := @POINT + 1,-1503.431,6656.319,24.25469,''),
(1827600,@POINT := @POINT + 1,-1499.531,6666.327,24.6426,''),
(1827600,@POINT := @POINT + 1,-1493.04,6683.077,24.71661,''),
(1827600,@POINT := @POINT + 1,-1488.928,6694.018,24.46026,''),
(1827600,@POINT := @POINT + 1,-1483.993,6704.666,24.63152,''),
(1827600,@POINT := @POINT + 1,-1479.038,6715.357,24.42681,''),
(1827600,@POINT := @POINT + 1,-1475.725,6722.415,24.52056,''),
(1827600,@POINT := @POINT + 1,-1472.728,6728.397,25.43655,''),
(1827600,@POINT := @POINT + 1,-1465.142,6743.202,25.48757,''),
(1827600,@POINT := @POINT + 1,-1460.47,6751.648,26.24237,''),
(1827600,@POINT := @POINT + 1,-1456.114,6759.298,26.59552,''),
(1827600,@POINT := @POINT + 1,-1451.801,6766.744,27.27498,''),
(1827600,@POINT := @POINT + 1,-1441.826,6783.814,28.01914,''),
(1827600,@POINT := @POINT + 1,-1435.78,6793.256,28.14414,''),
(1827600,@POINT := @POINT + 1,-1427.951,6802.209,27.77189,''),
(1827600,@POINT := @POINT + 1,-1420.604,6811.819,27.59953,''),
(1827600,@POINT := @POINT + 1,-1416.269,6821.467,27.32209,''),
(1827600,@POINT := @POINT + 1,-1411.288,6832.88,26.89982,''),
(1827600,@POINT := @POINT + 1,-1404.953,6840.652,27.33624,''),
(1827600,@POINT := @POINT + 1,-1402.676,6843.914,27.67545,''),
(1827600,@POINT := @POINT + 1,-1393.608,6852.47,28.47785,''),
(1827600,@POINT := @POINT + 1,-1381.98,6859.235,29.29785,''),
(1827600,@POINT := @POINT + 1,-1374.512,6865.038,30.02347,''),
(1827600,@POINT := @POINT + 1,-1361.955,6876.102,30.91434,''),
(1827600,@POINT := @POINT + 1,-1350.745,6886.359,31.10339,''),
(1827600,@POINT := @POINT + 1,-1343.011,6895.198,31.09607,''),
(1827600,@POINT := @POINT + 1,-1339.523,6899.669,31.71791,''),
(1827600,@POINT := @POINT + 1,-1329.859,6907.137,32.01398,''),
(1827600,@POINT := @POINT + 1,-1323.755,6911.395,32.40355,''),
(1827600,@POINT := @POINT + 1,-1316.075,6920.817,33.43444,''),
(1827600,@POINT := @POINT + 1,-1310.894,6927.241,33.46534,'Kor''kron Warrior - before the gates of Garadar');

SET @POINT := 0;
DELETE FROM `waypoints` WHERE `entry` = 1827610;
INSERT INTO `waypoints`
(`entry`,`pointid`,`position_x`,`position_y`,`position_z`,`point_comment`)
VALUES
(1827610,@POINT := @POINT + 1,-1341.407, 6302.393, 45.42799,'Kor''kron Warrior - start movement at spawn area'),
(1827610,@POINT := @POINT + 1,-1356.481,6342.938,43.68281,''),
(1827610,@POINT := @POINT + 1,-1363.912,6349.947,42.85905,''),
(1827610,@POINT := @POINT + 1,-1366.549,6352.468,42.10332,''),
(1827610,@POINT := @POINT + 1,-1380.979,6366.597,41.29876,''),
(1827610,@POINT := @POINT + 1,-1386.748,6372.003,40.48656,''),
(1827610,@POINT := @POINT + 1,-1398.057,6382.577,39.40562,''),
(1827610,@POINT := @POINT + 1,-1405.383,6389.329,38.26128,''),
(1827610,@POINT := @POINT + 1,-1409.753,6393.589,37.33056,''),
(1827610,@POINT := @POINT + 1,-1423.213,6407.106,36.67622,''),
(1827610,@POINT := @POINT + 1,-1428.669,6412.862,35.93699,''),
(1827610,@POINT := @POINT + 1,-1433.392,6417.77,35.1549,''),
(1827610,@POINT := @POINT + 1,-1448.793,6433.094,33.939,''),
(1827610,@POINT := @POINT + 1,-1457.254,6441.08,32.99157,''),
(1827610,@POINT := @POINT + 1,-1465.784,6449.263,32.03704,''),
(1827610,@POINT := @POINT + 1,-1468.854,6452.028,31.38842,''),
(1827610,@POINT := @POINT + 1,-1480.479,6463.497,30.03848,''),
(1827610,@POINT := @POINT + 1,-1488.483,6472.706,29.03189,''),
(1827610,@POINT := @POINT + 1,-1492.575,6479.296,28.29099,''),
(1827610,@POINT := @POINT + 1,-1498.857,6492.003,26.45962,''),
(1827610,@POINT := @POINT + 1,-1503.028,6503.524,24.94066,''),
(1827610,@POINT := @POINT + 1,-1505.62,6514.442,24.0824,''),
(1827610,@POINT := @POINT + 1,-1506.442,6518.199,23.33497,''),
(1827610,@POINT := @POINT + 1,-1509.159,6539.377,22.88285,''),
(1827610,@POINT := @POINT + 1,-1511.308,6548.729,22.50923,''),
(1827610,@POINT := @POINT + 1,-1514.715,6562.369,22.19242,''),
(1827610,@POINT := @POINT + 1,-1515.34,6570.028,21.6797,''),
(1827610,@POINT := @POINT + 1,-1515.469,6574.358,21.28422,''),
(1827610,@POINT := @POINT + 1,-1516.477,6594.837,20.65022,''),
(1827610,@POINT := @POINT + 1,-1516.902,6604.506,21.0576,''),
(1827610,@POINT := @POINT + 1,-1514.445,6616.547,21.24002,''),
(1827610,@POINT := @POINT + 1,-1508.058,6625.792,21.91331,''),
(1827610,@POINT := @POINT + 1,-1506.093,6631.804,23.22029,''),
(1827610,@POINT := @POINT + 1,-1503.04,6642.187,23.83239,''),
(1827610,@POINT := @POINT + 1,-1499.573,6656.231,24.7088,''),
(1827610,@POINT := @POINT + 1,-1493.495,6673.371,25.03741,''),
(1827610,@POINT := @POINT + 1,-1489.146,6684.375,25.18414,''),
(1827610,@POINT := @POINT + 1,-1484.966,6695.089,24.83734,''),
(1827610,@POINT := @POINT + 1,-1480.031,6705.738,24.9793,''),
(1827610,@POINT := @POINT + 1,-1480.376,6710.648,24.69341,''),
(1827610,@POINT := @POINT + 1,-1471.724,6723.333,25.10112,''),
(1827610,@POINT := @POINT + 1,-1470.277,6726.524,25.60709,''),
(1827610,@POINT := @POINT + 1,-1461.107,6743.953,25.84206,''),
(1827610,@POINT := @POINT + 1,-1455.313,6754.208,26.23757,''),
(1827610,@POINT := @POINT + 1,-1453.078,6758.27,26.84344,''),
(1827610,@POINT := @POINT + 1,-1448.506,6765.93,27.46867,''),
(1827610,@POINT := @POINT + 1,-1437.778,6784.493,27.84568,''),
(1827610,@POINT := @POINT + 1,-1431.677,6793.172,28.20726,''),
(1827610,@POINT := @POINT + 1,-1423.848,6802.126,27.98259,''),
(1827610,@POINT := @POINT + 1,-1416.842,6812.671,27.47453,''),
(1827610,@POINT := @POINT + 1,-1414.297,6818.924,27.30181,''),
(1827610,@POINT := @POINT + 1,-1407.185,6832.984,26.72453,''),
(1827610,@POINT := @POINT + 1,-1400.904,6840.816,28.24083,''),
(1827610,@POINT := @POINT + 1,-1400.227,6841.266,28.28441,''),
(1827610,@POINT := @POINT + 1,-1386.227,6853.785,29.51977,''),
(1827610,@POINT := @POINT + 1,-1374.765,6860.334,30.52347,''),
(1827610,@POINT := @POINT + 1,-1366.714,6869.74,30.79688,''),
(1827610,@POINT := @POINT + 1,-1357.342,6876.917,31.34941,''),
(1827610,@POINT := @POINT + 1,-1352.119,6882.848,31.68382,''),
(1827610,@POINT := @POINT + 1,-1338.908,6895.112,31.57471,''),
(1827610,@POINT := @POINT + 1,-1332.152,6902.58,31.87061,''),
(1827610,@POINT := @POINT + 1,-1326.822,6904.981,32.16651,'Kor''kron Warrior - before the gates of Garadar');

SET @POINT := 0;
DELETE FROM `waypoints` WHERE `entry` = 1827620;
INSERT INTO `waypoints`
(`entry`,`pointid`,`position_x`,`position_y`,`position_z`,`point_comment`)
VALUES
(1827620,@POINT := @POINT + 1,-1313.597,6337.389,37.4875,'Kor''kron Warrior - start movement at spawn area'),
(1827620,@POINT := @POINT + 1,-1359.693,6346.81,43.19638,''),
(1827620,@POINT := @POINT + 1,-1364.922,6352.55,42.59476,''),
(1827620,@POINT := @POINT + 1,-1369.896,6357.029,41.85905,''),
(1827620,@POINT := @POINT + 1,-1381.821,6368.407,40.9967,''),
(1827620,@POINT := @POINT + 1,-1391.916,6377.785,39.96706,''),
(1827620,@POINT := @POINT + 1,-1400.53,6385.863,39.10284,''),
(1827620,@POINT := @POINT + 1,-1406.36,6391.117,37.89444,''),
(1827620,@POINT := @POINT + 1,-1413.876,6398.687,37.02804,''),
(1827620,@POINT := @POINT + 1,-1424.018,6409.253,36.37014,''),
(1827620,@POINT := @POINT + 1,-1433.688,6419,35.56779,''),
(1827620,@POINT := @POINT + 1,-1437.977,6423.128,34.93929,''),
(1827620,@POINT := @POINT + 1,-1446.935,6432.176,33.93854,''),
(1827620,@POINT := @POINT + 1,-1456.124,6440.876,33.02568,''),
(1827620,@POINT := @POINT + 1,-1466.673,6450.998,31.70663,''),
(1827620,@POINT := @POINT + 1,-1475.548,6459.017,30.87277,''),
(1827620,@POINT := @POINT + 1,-1484.04,6468.685,29.51413,''),
(1827620,@POINT := @POINT + 1,-1487.605,6472.462,29.06737,''),
(1827620,@POINT := @POINT + 1,-1495.546,6485.818,27.76912,''),
(1827620,@POINT := @POINT + 1,-1498.868,6494.208,26.57964,''),
(1827620,@POINT := @POINT + 1,-1502.378,6505.083,25.10668,''),
(1827620,@POINT := @POINT + 1,-1505.957,6518.528,23.62728,''),
(1827620,@POINT := @POINT + 1,-1506.435,6521.307,23.20864,''),
(1827620,@POINT := @POINT + 1,-1509.414,6543.474,22.99638,''),
(1827620,@POINT := @POINT + 1,-1510.507,6547.068,22.54298,''),
(1827620,@POINT := @POINT + 1,-1514.974,6566.465,21.8892,''),
(1827620,@POINT := @POINT + 1,-1514.887,6574.351,21.43412,''),
(1827620,@POINT := @POINT + 1,-1515.179,6579.391,20.93638,''),
(1827620,@POINT := @POINT + 1,-1514.619,6598.497,21.06501,''),
(1827620,@POINT := @POINT + 1,-1516.263,6604.566,21.04718,''),
(1827620,@POINT := @POINT + 1,-1514.327,6616.664,21.30777,''),
(1827620,@POINT := @POINT + 1,-1507.054,6628.653,22.35204,''),
(1827620,@POINT := @POINT + 1,-1502.045,6643.439,23.70916,''),
(1827620,@POINT := @POINT + 1,-1501.096,6647.112,24.02633,''),
(1827620,@POINT := @POINT + 1,-1497.411,6660.161,24.85114,''),
(1827620,@POINT := @POINT + 1,-1492.361,6674.188,25.39454,''),
(1827620,@POINT := @POINT + 1,-1486.998,6687.872,25.31915,''),
(1827620,@POINT := @POINT + 1,-1482.62,6698.457,25.09234,''),
(1827620,@POINT := @POINT + 1,-1477.685,6709.105,25.07549,''),
(1827620,@POINT := @POINT + 1,-1476.32,6716.775,24.97911,''),
(1827620,@POINT := @POINT + 1,-1470.686,6724.645,25.53253,''),
(1827620,@POINT := @POINT + 1,-1469.197,6727.644,25.71964,''),
(1827620,@POINT := @POINT + 1,-1458.498,6747.121,26.23098,''),
(1827620,@POINT := @POINT + 1,-1453.149,6756.342,26.57982,''),
(1827620,@POINT := @POINT + 1,-1447.825,6766.161,27.63328,''),
(1827620,@POINT := @POINT + 1,-1443.567,6773.123,27.92666,''),
(1827620,@POINT := @POINT + 1,-1435.113,6787.614,28.14414,''),
(1827620,@POINT := @POINT + 1,-1428.479,6795.746,28.33226,''),
(1827620,@POINT := @POINT + 1,-1420.651,6804.699,27.93254,''),
(1827620,@POINT := @POINT + 1,-1415.639,6814.097,27.74125,''),
(1827620,@POINT := @POINT + 1,-1412.37,6821.203,27.2022,''),
(1827620,@POINT := @POINT + 1,-1404.11,6835.702,26.98396,''),
(1827620,@POINT := @POINT + 1,-1399.67,6841.119,28.38387,''),
(1827620,@POINT := @POINT + 1,-1389.798,6851.24,28.69209,''),
(1827620,@POINT := @POINT + 1,-1383.237,6854.666,29.92945,''),
(1827620,@POINT := @POINT + 1,-1374.695,6860.173,30.43272,''),
(1827620,@POINT := @POINT + 1,-1361.51,6864.02,31.7169,''),
(1827620,@POINT := @POINT + 1,-1360.469,6870.775,31.4648,''),
(1827620,@POINT := @POINT + 1,-1343.444,6888.847,31.55615,''),
(1827620,@POINT := @POINT + 1,-1335.71,6897.685,31.68115,''),
(1827620,@POINT := @POINT + 1,-1328.344,6904.109,31.89698,''),
(1827620,@POINT := @POINT + 1,-1319.173,6909.735,32.70131,''),
(1827620,@POINT := @POINT + 1,-1308.543,6930.477,33.48413,'Kor''kron Warrior - before the gates of Garadar');

SET @POINT := 0;
DELETE FROM `waypoints` WHERE `entry` = 1827630;
INSERT INTO `waypoints`
(`entry`,`pointid`,`position_x`,`position_y`,`position_z`,`point_comment`)
VALUES
(1827630,@POINT := @POINT + 1,-1317.676, 6332.954, 39.39396,'Kor''kron Warrior - start movement at spawn area'),
(1827630,@POINT := @POINT + 1,-1359.257,6345.074,43.34771,''),
(1827630,@POINT := @POINT + 1,-1368.19,6352.651,42.49956,''),
(1827630,@POINT := @POINT + 1,-1375.154,6358.975,41.6422,''),
(1827630,@POINT := @POINT + 1,-1383.779,6367.35,40.95704,''),
(1827630,@POINT := @POINT + 1,-1396.65,6379.477,39.46555,''),
(1827630,@POINT := @POINT + 1,-1403.281,6385.548,38.55353,''),
(1827630,@POINT := @POINT + 1,-1412.604,6394.293,37.48947,''),
(1827630,@POINT := @POINT + 1,-1418.6,6400.475,36.68916,''),
(1827630,@POINT := @POINT + 1,-1427.218,6409.628,35.92756,''),
(1827630,@POINT := @POINT + 1,-1437.633,6420.145,35.16815,''),
(1827630,@POINT := @POINT + 1,-1445.191,6427.698,34.26686,''),
(1827630,@POINT := @POINT + 1,-1450.923,6433.204,33.47472,''),
(1827630,@POINT := @POINT + 1,-1458.861,6440.643,32.50407,''),
(1827630,@POINT := @POINT + 1,-1468.669,6449.949,31.56035,''),
(1827630,@POINT := @POINT + 1,-1480.044,6460.676,30.33904,''),
(1827630,@POINT := @POINT + 1,-1485.207,6466.816,29.43354,''),
(1827630,@POINT := @POINT + 1,-1495.248,6478.29,28.2853,''),
(1827630,@POINT := @POINT + 1,-1497.596,6485.762,27.17497,''),
(1827630,@POINT := @POINT + 1,-1503.672,6500.326,25.22203,''),
(1827630,@POINT := @POINT + 1,-1504.671,6504.808,24.54926,''),
(1827630,@POINT := @POINT + 1,-1509.076,6522.18,23.12732,''),
(1827630,@POINT := @POINT + 1,-1510.112,6534.35,22.4539,''),
(1827630,@POINT := @POINT + 1,-1512.242,6546.448,22.09916,''),
(1827630,@POINT := @POINT + 1,-1514.545,6556.838,22.00279,''),
(1827630,@POINT := @POINT + 1,-1517.014,6566.905,21.35402,''),
(1827630,@POINT := @POINT + 1,-1517.121,6576.429,20.90148,''),
(1827630,@POINT := @POINT + 1,-1517.534,6592.283,20.56501,''),
(1827630,@POINT := @POINT + 1,-1518.955,6593.444,20.68521,''),
(1827630,@POINT := @POINT + 1,-1512.585,6611.89,21.36403,''),
(1827630,@POINT := @POINT + 1,-1508.72,6624.953,21.73949,''),
(1827630,@POINT := @POINT + 1,-1506.413,6634.521,23.35396,''),
(1827630,@POINT := @POINT + 1,-1507.465,6638.425,23.13417,''),
(1827630,@POINT := @POINT + 1,-1500.776,6656.853,24.52659,''),
(1827630,@POINT := @POINT + 1,-1499.383,6658.492,24.59208,''),
(1827630,@POINT := @POINT + 1,-1491.949,6680.928,24.94891,''),
(1827630,@POINT := @POINT + 1,-1487.6,6691.932,24.61969,''),
(1827630,@POINT := @POINT + 1,-1482.987,6702.544,24.90264,''),
(1827630,@POINT := @POINT + 1,-1478.052,6713.193,24.7166,''),
(1827630,@POINT := @POINT + 1,-1473.097,6723.884,24.85259,''),
(1827630,@POINT := @POINT + 1,-1470.751,6728.055,25.65412,''),
(1827630,@POINT := @POINT + 1,-1464.127,6741.162,25.6028,''),
(1827630,@POINT := @POINT + 1,-1458.537,6751.225,25.98757,''),
(1827630,@POINT := @POINT + 1,-1455.162,6756.965,26.59436,''),
(1827630,@POINT := @POINT + 1,-1451.703,6763.026,27.24188,''),
(1827630,@POINT := @POINT + 1,-1441.028,6781.611,27.76914,''),
(1827630,@POINT := @POINT + 1,-1435.079,6791.719,28.14414,''),
(1827630,@POINT := @POINT + 1,-1427.685,6799.772,28.08226,''),
(1827630,@POINT := @POINT + 1,-1419.856,6808.726,27.72453,''),
(1827630,@POINT := @POINT + 1,-1416.225,6817.652,27.46122,''),
(1827630,@POINT := @POINT + 1,-1410.866,6829.031,26.88726,''),
(1827630,@POINT := @POINT + 1,-1403.508,6839.725,27.26216,''),
(1827630,@POINT := @POINT + 1,-1401.932,6841.426,27.75581,''),
(1827630,@POINT := @POINT + 1,-1390.278,6852.666,28.81154,''),
(1827630,@POINT := @POINT + 1,-1384.662,6856.315,29.36012,''),
(1827630,@POINT := @POINT + 1,-1369.815,6866.48,30.70022,''),
(1827630,@POINT := @POINT + 1,-1363.649,6872.149,31.21793,''),
(1827630,@POINT := @POINT + 1,-1350.489,6883.946,31.42383,''),
(1827630,@POINT := @POINT + 1,-1342.648,6892.873,31.25073,''),
(1827630,@POINT := @POINT + 1,-1334.913,6901.711,31.64841,''),
(1827630,@POINT := @POINT + 1,-1329.679,6901.374,32.04248,'Kor''kron Warrior - before the gates of Garadar');

SET @POINT := 0;
DELETE FROM `waypoints` WHERE `entry` = 1827640;
INSERT INTO `waypoints`
(`entry`,`pointid`,`position_x`,`position_y`,`position_z`,`point_comment`)
VALUES
(1827640,@POINT := @POINT + 1,-1346.398,6323.436,44.13105,'Kor''kron Warrior - start movement at spawn area'),
(1827640,@POINT := @POINT + 1,-1375.75,6352.643,41.81343,''),
(1827640,@POINT := @POINT + 1,-1386.413,6362.125,40.76291,''),
(1827640,@POINT := @POINT + 1,-1394.859,6370.748,39.64816,''),
(1827640,@POINT := @POINT + 1,-1402.946,6378.722,38.64111,''),
(1827640,@POINT := @POINT + 1,-1408.646,6384.408,37.85543,''),
(1827640,@POINT := @POINT + 1,-1416.046,6392.416,36.95772,''),
(1827640,@POINT := @POINT + 1,-1424.231,6400.856,35.89214,''),
(1827640,@POINT := @POINT + 1,-1438.505,6414.223,34.73194,''),
(1827640,@POINT := @POINT + 1,-1447.235,6422.037,33.93885,''),
(1827640,@POINT := @POINT + 1,-1455.295,6429.046,32.72091,''),
(1827640,@POINT := @POINT + 1,-1458.611,6432.946,32.30492,''),
(1827640,@POINT := @POINT + 1,-1467.951,6443.736,31.22492,''),
(1827640,@POINT := @POINT + 1,-1475.274,6451.741,30.49423,''),
(1827640,@POINT := @POINT + 1,-1487.13,6465.033,29.41993,''),
(1827640,@POINT := @POINT + 1,-1494.225,6473.047,28.60011,''),
(1827640,@POINT := @POINT + 1,-1498.577,6483.967,27.50839,''),
(1827640,@POINT := @POINT + 1,-1502.863,6493.575,25.85901,''),
(1827640,@POINT := @POINT + 1,-1508.28,6506.335,24.16001,''),
(1827640,@POINT := @POINT + 1,-1509.035,6510.974,23.54728,''),
(1827640,@POINT := @POINT + 1,-1511.6,6522.404,22.68517,''),
(1827640,@POINT := @POINT + 1,-1514.619,6536.917,22.02852,''),
(1827640,@POINT := @POINT + 1,-1517.407,6553.438,21.25566,''),
(1827640,@POINT := @POINT + 1,-1519.008,6565.207,21.03715,''),
(1827640,@POINT := @POINT + 1,-1519.755,6571.952,20.86309,''),
(1827640,@POINT := @POINT + 1,-1519.178,6588.365,20.44001,''),
(1827640,@POINT := @POINT + 1,-1517.295,6600.117,20.9326,''),
(1827640,@POINT := @POINT + 1,-1515.428,6611.833,21.1826,''),
(1827640,@POINT := @POINT + 1,-1513.559,6623.591,21.45103,''),
(1827640,@POINT := @POINT + 1,-1512.845,6627.281,21.88989,''),
(1827640,@POINT := @POINT + 1,-1510.815,6637.101,22.88312,''),
(1827640,@POINT := @POINT + 1,-1508.53,6651.39,23.69955,''),
(1827640,@POINT := @POINT + 1,-1506.259,6664.806,24.5883,''),
(1827640,@POINT := @POINT + 1,-1498.989,6679.93,24.34894,''),
(1827640,@POINT := @POINT + 1,-1493.872,6690.641,24.31915,''),
(1827640,@POINT := @POINT + 1,-1488.799,6701.26,24.39556,''),
(1827640,@POINT := @POINT + 1,-1484.892,6712.443,24.14556,''),
(1827640,@POINT := @POINT + 1,-1480.606,6723.452,24.27056,''),
(1827640,@POINT := @POINT + 1,-1475.714,6732.932,24.9554,''),
(1827640,@POINT := @POINT + 1,-1470.24,6742.168,25.22824,''),
(1827640,@POINT := @POINT + 1,-1463.485,6753.477,26.435,''),
(1827640,@POINT := @POINT + 1,-1461.195,6757.306,26.60432,''),
(1827640,@POINT := @POINT + 1,-1454.66,6768.044,27.35494,''),
(1827640,@POINT := @POINT + 1,-1446.97,6779.56,28.1712,''),
(1827640,@POINT := @POINT + 1,-1439.703,6790.031,28.26914,''),
(1827640,@POINT := @POINT + 1,-1431.824,6798.763,27.95726,''),
(1827640,@POINT := @POINT + 1,-1425.258,6805.846,27.74768,''),
(1827640,@POINT := @POINT + 1,-1419.951,6818.376,27.18107,''),
(1827640,@POINT := @POINT + 1,-1415.991,6828.374,27.02785,''),
(1827640,@POINT := @POINT + 1,-1411.301,6840.22,27.01216,''),
(1827640,@POINT := @POINT + 1,-1406.986,6850.981,27.51216,''),
(1827640,@POINT := @POINT + 1,-1395.876,6852.983,28.06596,''),
(1827640,@POINT := @POINT + 1,-1386.497,6858.125,29.04535,''),
(1827640,@POINT := @POINT + 1,-1377.48,6865.975,29.5562,''),
(1827640,@POINT := @POINT + 1,-1369.061,6873.784,30.05341,''),
(1827640,@POINT := @POINT + 1,-1359.177,6883.299,30.66475,''),
(1827640,@POINT := @POINT + 1,-1350.448,6892.708,30.55615,''),
(1827640,@POINT := @POINT + 1,-1343.185,6900.402,31.31773,''),
(1827640,@POINT := @POINT + 1,-1334.397,6909.835,31.33322,''),
(1827640,@POINT := @POINT + 1,-1332.969,6914.566,31.75934,''),
(1827640,@POINT := @POINT + 1,-1327.05,6931.745,31.9987,'Kor''kron Warrior - before the gates of Garadar');

SET @POINT := 0;
DELETE FROM `waypoints` WHERE `entry` = 1827650;
INSERT INTO `waypoints`
(`entry`,`pointid`,`position_x`,`position_y`,`position_z`,`point_comment`)
VALUES
(1827650,@POINT := @POINT + 1,-1343.658, 6326.059, 44.25003,'Kor''kron Warrior - start movement at spawn area'),
(1827650,@POINT := @POINT + 1,-1378.534,6350.313,41.66693,''),
(1827650,@POINT := @POINT + 1,-1388.357,6359.078,40.54196,''),
(1827650,@POINT := @POINT + 1,-1398.773,6369.112,39.55496,''),
(1827650,@POINT := @POINT + 1,-1406.175,6376.542,38.37215,''),
(1827650,@POINT := @POINT + 1,-1412.92,6383.467,37.59019,''),
(1827650,@POINT := @POINT + 1,-1418.568,6389.211,36.75541,''),
(1827650,@POINT := @POINT + 1,-1431.257,6402.656,35.61509,''),
(1827650,@POINT := @POINT + 1,-1439.397,6409.976,34.48,''),
(1827650,@POINT := @POINT + 1,-1445,6414.716,33.94336,''),
(1827650,@POINT := @POINT + 1,-1456.038,6424.469,32.72306,''),
(1827650,@POINT := @POINT + 1,-1459.961,6429.107,32.03804,''),
(1827650,@POINT := @POINT + 1,-1468.075,6438.094,31.00072,''),
(1827650,@POINT := @POINT + 1,-1478.442,6449.612,30.19709,''),
(1827650,@POINT := @POINT + 1,-1486.321,6458.416,29.59192,''),
(1827650,@POINT := @POINT + 1,-1492.912,6465.67,28.97868,''),
(1827650,@POINT := @POINT + 1,-1500.022,6478.217,27.64638,''),
(1827650,@POINT := @POINT + 1,-1506.207,6491.387,25.75857,''),
(1827650,@POINT := @POINT + 1,-1510.741,6502.491,24.13481,''),
(1827650,@POINT := @POINT + 1,-1511.523,6505.471,23.73208,''),
(1827650,@POINT := @POINT + 1,-1515.01,6520.876,22.84591,''),
(1827650,@POINT := @POINT + 1,-1517.076,6529.952,21.94379,''),
(1827650,@POINT := @POINT + 1,-1520.715,6551.218,21.36644,''),
(1827650,@POINT := @POINT + 1,-1522.64,6563.296,20.85136,''),
(1827650,@POINT := @POINT + 1,-1524.231,6575,20.56501,''),
(1827650,@POINT := @POINT + 1,-1523.208,6587.589,20.44001,''),
(1827650,@POINT := @POINT + 1,-1521.325,6599.341,20.81501,''),
(1827650,@POINT := @POINT + 1,-1519.458,6611.052,21.0576,''),
(1827650,@POINT := @POINT + 1,-1517.589,6622.81,21.25951,''),
(1827650,@POINT := @POINT + 1,-1516.886,6626.5,21.74069,''),
(1827650,@POINT := @POINT + 1,-1514.855,6638.132,22.83069,''),
(1827650,@POINT := @POINT + 1,-1511.569,6656.433,24.13942,''),
(1827650,@POINT := @POINT + 1,-1510.797,6661.103,24.48184,''),
(1827650,@POINT := @POINT + 1,-1503.074,6680.326,24.60838,''),
(1827650,@POINT := @POINT + 1,-1497.957,6691.036,24.38653,''),
(1827650,@POINT := @POINT + 1,-1492.884,6701.656,24.49053,''),
(1827650,@POINT := @POINT + 1,-1488.996,6712.535,24.32927,''),
(1827650,@POINT := @POINT + 1,-1484.71,6723.543,24.39556,''),
(1827650,@POINT := @POINT + 1,-1479.312,6734.657,24.96642,''),
(1827650,@POINT := @POINT + 1,-1474.186,6743.023,25.43917,''),
(1827650,@POINT := @POINT + 1,-1468.801,6752.157,26.63392,''),
(1827650,@POINT := @POINT + 1,-1466.015,6756.524,26.82364,''),
(1827650,@POINT := @POINT + 1,-1457.199,6771.321,27.56836,''),
(1827650,@POINT := @POINT + 1,-1452.714,6778,28.1131,''),
(1827650,@POINT := @POINT + 1,-1443.589,6791.209,28.56992,''),
(1827650,@POINT := @POINT + 1,-1435.599,6800.373,28.09538,''),
(1827650,@POINT := @POINT + 1,-1431.061,6805.124,27.90274,''),
(1827650,@POINT := @POINT + 1,-1424.054,6818.486,27.32915,''),
(1827650,@POINT := @POINT + 1,-1419.752,6829.417,26.97453,''),
(1827650,@POINT := @POINT + 1,-1415.403,6840.348,27.17305,''),
(1827650,@POINT := @POINT + 1,-1411.088,6851.117,27.51216,''),
(1827650,@POINT := @POINT + 1,-1398.206,6856.158,28.38711,''),
(1827650,@POINT := @POINT + 1,-1395.161,6857.694,28.75363,''),
(1827650,@POINT := @POINT + 1,-1382.798,6866.727,29.61779,''),
(1827650,@POINT := @POINT + 1,-1370.541,6877.841,29.67905,''),
(1827650,@POINT := @POINT + 1,-1362.016,6885.826,30.30615,''),
(1827650,@POINT := @POINT + 1,-1356.169,6892.381,30.76448,''),
(1827650,@POINT := @POINT + 1,-1351.74,6897.006,31.26509,''),
(1827650,@POINT := @POINT + 1,-1338.171,6911.449,31.49594,''),
(1827650,@POINT := @POINT + 1,-1334.682,6918.354,32.19947,''),
(1827650,@POINT := @POINT + 1,-1331.262,6925.238,32.00757,'Kor''kron Warrior - before the gates of Garadar');

SET @POINT := 0;
DELETE FROM `waypoints` WHERE `entry` = 1827660;
INSERT INTO `waypoints`
(`entry`,`pointid`,`position_x`,`position_y`,`position_z`,`point_comment`)
VALUES
(1827660,@POINT := @POINT + 1,-1341.659, 6328.948, 44.39948,'Kor''kron Warrior - start movement at spawn area'),
(1827660,@POINT := @POINT + 1,-1380.612,6349.274,41.58778,''),
(1827660,@POINT := @POINT + 1,-1385.343,6353.736,40.93915,''),
(1827660,@POINT := @POINT + 1,-1397.229,6364.835,40.12361,''),
(1827660,@POINT := @POINT + 1,-1403.984,6371.511,39.07477,''),
(1827660,@POINT := @POINT + 1,-1412.692,6380.291,37.90898,''),
(1827660,@POINT := @POINT + 1,-1420.837,6389.006,36.80255,''),
(1827660,@POINT := @POINT + 1,-1430.494,6398.682,35.75403,''),
(1827660,@POINT := @POINT + 1,-1436.734,6404.804,34.78491,''),
(1827660,@POINT := @POINT + 1,-1442.952,6410.318,33.9302,''),
(1827660,@POINT := @POINT + 1,-1456.231,6421.826,32.75629,''),
(1827660,@POINT := @POINT + 1,-1464.758,6431.269,31.73908,''),
(1827660,@POINT := @POINT + 1,-1466.817,6433.488,31.08584,''),
(1827660,@POINT := @POINT + 1,-1480.376,6448.64,30.41516,''),
(1827660,@POINT := @POINT + 1,-1484.741,6453.449,29.78321,''),
(1827660,@POINT := @POINT + 1,-1494.131,6463.981,29.18576,''),
(1827660,@POINT := @POINT + 1,-1501.111,6475.72,28.12764,''),
(1827660,@POINT := @POINT + 1,-1506.504,6487.33,26.4983,''),
(1827660,@POINT := @POINT + 1,-1511.44,6498.415,24.56813,''),
(1827660,@POINT := @POINT + 1,-1513.386,6505.983,23.74737,''),
(1827660,@POINT := @POINT + 1,-1516.659,6518.935,22.72642,''),
(1827660,@POINT := @POINT + 1,-1519.553,6532.539,21.69878,''),
(1827660,@POINT := @POINT + 1,-1521.607,6544.357,21.18198,''),
(1827660,@POINT := @POINT + 1,-1524.195,6559.498,20.66459,''),
(1827660,@POINT := @POINT + 1,-1525.786,6571.201,20.56501,''),
(1827660,@POINT := @POINT + 1,-1525.797,6584.404,20.44001,''),
(1827660,@POINT := @POINT + 1,-1523.914,6596.157,20.66633,''),
(1827660,@POINT := @POINT + 1,-1519.333,6600.693,20.9326,''),
(1827660,@POINT := @POINT + 1,-1520.173,6619.622,21.0576,''),
(1827660,@POINT := @POINT + 1,-1518.731,6626.779,21.80373,''),
(1827660,@POINT := @POINT + 1,-1517.421,6633.771,22.55753,''),
(1827660,@POINT := @POINT + 1,-1514.69,6651.229,24.08424,''),
(1827660,@POINT := @POINT + 1,-1513.437,6656.185,24.46212,''),
(1827660,@POINT := @POINT + 1,-1506.458,6678.003,24.86069,''),
(1827660,@POINT := @POINT + 1,-1501.341,6688.714,24.69895,''),
(1827660,@POINT := @POINT + 1,-1496.268,6699.333,24.43365,''),
(1827660,@POINT := @POINT + 1,-1492.893,6708.465,25.2211,''),
(1827660,@POINT := @POINT + 1,-1487.911,6720.975,24.91521,''),
(1827660,@POINT := @POINT + 1,-1482.895,6732.655,25.03032,''),
(1827660,@POINT := @POINT + 1,-1476.822,6742.843,25.44615,''),
(1827660,@POINT := @POINT + 1,-1473.385,6748.403,26.21559,''),
(1827660,@POINT := @POINT + 1,-1469.606,6754.548,27.15837,''),
(1827660,@POINT := @POINT + 1,-1465.293,6766.604,27.83254,''),
(1827660,@POINT := @POINT + 1,-1455.3,6778.652,28.62343,''),
(1827660,@POINT := @POINT + 1,-1453.138,6781.721,28.85696,''),
(1827660,@POINT := @POINT + 1,-1439.526,6799.18,28.53892,''),
(1827660,@POINT := @POINT + 1,-1436.493,6802.1,28.2517,''),
(1827660,@POINT := @POINT + 1,-1427.267,6815.933,27.50004,''),
(1827660,@POINT := @POINT + 1,-1422.961,6826.859,27.2924,''),
(1827660,@POINT := @POINT + 1,-1418.628,6837.809,27.28462,''),
(1827660,@POINT := @POINT + 1,-1413.37,6841.077,27.26216,''),
(1827660,@POINT := @POINT + 1,-1403.026,6854.753,27.89473,''),
(1827660,@POINT := @POINT + 1,-1391.112,6862.237,28.9684,''),
(1827660,@POINT := @POINT + 1,-1385.771,6866.773,29.46068,''),
(1827660,@POINT := @POINT + 1,-1378.875,6873.118,29.87896,''),
(1827660,@POINT := @POINT + 1,-1365.895,6885.013,29.97705,''),
(1827660,@POINT := @POINT + 1,-1363.382,6887.824,30.50175,''),
(1827660,@POINT := @POINT + 1,-1354.931,6896.595,31.29555,''),
(1827660,@POINT := @POINT + 1,-1343.919,6902.882,31.2645,''),
(1827660,@POINT := @POINT + 1,-1336.662,6915.724,31.84787,''),
(1827660,@POINT := @POINT + 1,-1325.15,6934.722,31.59662,'Kor''kron Warrior - before the gates of Garadar');

SET @POINT := 0;
DELETE FROM `waypoints` WHERE `entry` = 1827670;
INSERT INTO `waypoints`
(`entry`,`pointid`,`position_x`,`position_y`,`position_z`,`point_comment`)
VALUES
(1827670,@POINT := @POINT + 1,-1342.175, 6320.706, 44.54397,'Kor''kron Warrior - start movement at spawn area'),
(1827670,@POINT := @POINT + 1,-1372.273,6342.793,42.46829,''),
(1827670,@POINT := @POINT + 1,-1383.514,6352.7,41.29501,''),
(1827670,@POINT := @POINT + 1,-1387.597,6356.548,40.48121,''),
(1827670,@POINT := @POINT + 1,-1401.675,6370.026,39.38797,''),
(1827670,@POINT := @POINT + 1,-1406.577,6375.133,38.40147,''),
(1827670,@POINT := @POINT + 1,-1418.743,6387.831,36.8916,''),
(1827670,@POINT := @POINT + 1,-1427.17,6396.301,35.9618,''),
(1827670,@POINT := @POINT + 1,-1435.577,6404.816,34.91903,''),
(1827670,@POINT := @POINT + 1,-1438.604,6407.3,34.29092,''),
(1827670,@POINT := @POINT + 1,-1449.016,6416.472,33.43275,''),
(1827670,@POINT := @POINT + 1,-1458.147,6425.441,32.39808,''),
(1827670,@POINT := @POINT + 1,-1465.064,6432.76,31.51849,''),
(1827670,@POINT := @POINT + 1,-1477.103,6446.082,30.67208,''),
(1827670,@POINT := @POINT + 1,-1481.972,6451.62,29.98962,''),
(1827670,@POINT := @POINT + 1,-1490.895,6461.439,29.24962,''),
(1827670,@POINT := @POINT + 1,-1499.37,6473.488,28.39513,''),
(1827670,@POINT := @POINT + 1,-1502.818,6481.416,27.19888,''),
(1827670,@POINT := @POINT + 1,-1508.669,6494.02,25.3214,''),
(1827670,@POINT := @POINT + 1,-1513.487,6508.12,23.68432,''),
(1827670,@POINT := @POINT + 1,-1515.776,6518.226,23.12634,''),
(1827670,@POINT := @POINT + 1,-1518.476,6530.767,21.98259,''),
(1827670,@POINT := @POINT + 1,-1518.956,6532.777,21.61776,''),
(1827670,@POINT := @POINT + 1,-1522.944,6555.589,20.74931,''),
(1827670,@POINT := @POINT + 1,-1524.535,6567.292,20.69001,''),
(1827670,@POINT := @POINT + 1,-1525.733,6580.3,20.44001,''),
(1827670,@POINT := @POINT + 1,-1523.849,6592.053,20.56501,''),
(1827670,@POINT := @POINT + 1,-1521.973,6603.761,20.8076,''),
(1827670,@POINT := @POINT + 1,-1520.104,6615.518,21.0576,''),
(1827670,@POINT := @POINT + 1,-1518.202,6626.26,21.83834,''),
(1827670,@POINT := @POINT + 1,-1516.171,6638.447,22.79996,''),
(1827670,@POINT := @POINT + 1,-1515.399,6643.262,23.21204,''),
(1827670,@POINT := @POINT + 1,-1512.422,6658.966,24.61795,''),
(1827670,@POINT := @POINT + 1,-1508.42,6670.814,25.09698,''),
(1827670,@POINT := @POINT + 1,-1502.44,6684.759,24.70554,''),
(1827670,@POINT := @POINT + 1,-1497.367,6695.379,24.44073,''),
(1827670,@POINT := @POINT + 1,-1493,6705.942,24.89348,''),
(1827670,@POINT := @POINT + 1,-1488.714,6716.95,24.95012,''),
(1827670,@POINT := @POINT + 1,-1484.352,6728.818,25.10112,''),
(1827670,@POINT := @POINT + 1,-1480.346,6735.334,25.34388,''),
(1827670,@POINT := @POINT + 1,-1473.339,6747.305,25.85029,''),
(1827670,@POINT := @POINT + 1,-1467.821,6756.479,27.10916,''),
(1827670,@POINT := @POINT + 1,-1465.279,6766.771,27.75237,''),
(1827670,@POINT := @POINT + 1,-1455.377,6777.396,28.34966,''),
(1827670,@POINT := @POINT + 1,-1441.767,6795.742,28.64548,''),
(1827670,@POINT := @POINT + 1,-1435.939,6801.635,28.20957,''),
(1827670,@POINT := @POINT + 1,-1428.646,6811.188,27.97573,''),
(1827670,@POINT := @POINT + 1,-1423.775,6822.836,27.34953,''),
(1827670,@POINT := @POINT + 1,-1419.466,6833.791,27.13716,''),
(1827670,@POINT := @POINT + 1,-1415.164,6844.568,27.38716,''),
(1827670,@POINT := @POINT + 1,-1404.544,6854.381,27.60042,''),
(1827670,@POINT := @POINT + 1,-1398.603,6856.841,28.29176,''),
(1827670,@POINT := @POINT + 1,-1388.402,6863.486,29.21328,''),
(1827670,@POINT := @POINT + 1,-1381.444,6869.968,29.5867,''),
(1827670,@POINT := @POINT + 1,-1368.356,6881.729,29.81626,''),
(1827670,@POINT := @POINT + 1,-1362.995,6887.222,30.43941,''),
(1827670,@POINT := @POINT + 1,-1357.201,6893.19,31.05112,''),
(1827670,@POINT := @POINT + 1,-1346.377,6904.452,31.80281,''),
(1827670,@POINT := @POINT + 1,-1336.479,6911.624,31.3558,''),
(1827670,@POINT := @POINT + 1,-1333.499,6921.922,32.06613,'Kor''kron Warrior - before the gates of Garadar');

SET @POINT := 0;
DELETE FROM `waypoints` WHERE `entry` = 1827680;
INSERT INTO `waypoints`
(`entry`,`pointid`,`position_x`,`position_y`,`position_z`,`point_comment`)
VALUES
(1827680,@POINT := @POINT + 1,-1339.956, 6323.307, 44.4758,'Kor''kron Warrior - start movement at spawn area'),
(1827680,@POINT := @POINT + 1,-1368.229,6343.505,42.38843,''),
(1827680,@POINT := @POINT + 1,-1376.405,6350.433,41.51878,''),
(1827680,@POINT := @POINT + 1,-1385.077,6358.317,40.85873,''),
(1827680,@POINT := @POINT + 1,-1396.861,6369.953,39.58881,''),
(1827680,@POINT := @POINT + 1,-1404.479,6377.443,38.51379,''),
(1827680,@POINT := @POINT + 1,-1414.66,6388.139,37.20406,''),
(1827680,@POINT := @POINT + 1,-1418.349,6391.627,36.76189,''),
(1827680,@POINT := @POINT + 1,-1431.219,6405.005,35.39329,''),
(1827680,@POINT := @POINT + 1,-1438.439,6411.544,34.69069,''),
(1827680,@POINT := @POINT + 1,-1444.181,6416.549,34.01598,''),
(1827680,@POINT := @POINT + 1,-1456.311,6427.807,32.57023,''),
(1827680,@POINT := @POINT + 1,-1464.313,6436.554,31.73014,''),
(1827680,@POINT := @POINT + 1,-1469,6441.723,30.99605,''),
(1827680,@POINT := @POINT + 1,-1477.396,6451.247,30.28961,''),
(1827680,@POINT := @POINT + 1,-1485.232,6460.004,29.57026,''),
(1827680,@POINT := @POINT + 1,-1495.834,6472.948,28.39309,''),
(1827680,@POINT := @POINT + 1,-1499.167,6480.516,27.4149,''),
(1827680,@POINT := @POINT + 1,-1505.23,6493.864,25.51022,''),
(1827680,@POINT := @POINT + 1,-1509.711,6505.815,24.04025,''),
(1827680,@POINT := @POINT + 1,-1510.595,6509.879,23.64782,''),
(1827680,@POINT := @POINT + 1,-1513.831,6524.116,22.76105,''),
(1827680,@POINT := @POINT + 1,-1515.901,6532.979,21.90339,''),
(1827680,@POINT := @POINT + 1,-1519.473,6553.398,21.25566,''),
(1827680,@POINT := @POINT + 1,-1521.064,6565.102,20.88066,''),
(1827680,@POINT := @POINT + 1,-1522.507,6575.797,20.70988,''),
(1827680,@POINT := @POINT + 1,-1521.163,6588.951,20.44001,''),
(1827680,@POINT := @POINT + 1,-1519.275,6600.605,20.9326,''),
(1827680,@POINT := @POINT + 1,-1517.413,6612.419,21.0576,''),
(1827680,@POINT := @POINT + 1,-1515.518,6624.047,21.50572,''),
(1827680,@POINT := @POINT + 1,-1514.58,6628.744,21.90982,''),
(1827680,@POINT := @POINT + 1,-1512.566,6640.292,22.85365,''),
(1827680,@POINT := @POINT + 1,-1510.559,6652.706,23.68124,''),
(1827680,@POINT := @POINT + 1,-1507.507,6664.105,24.4008,''),
(1827680,@POINT := @POINT + 1,-1500.74,6681.023,24.50169,''),
(1827680,@POINT := @POINT + 1,-1495.667,6691.643,24.31915,''),
(1827680,@POINT := @POINT + 1,-1491.027,6702.343,24.39556,''),
(1827680,@POINT := @POINT + 1,-1486.741,6713.351,24.15691,''),
(1827680,@POINT := @POINT + 1,-1483.002,6724.942,24.72393,''),
(1827680,@POINT := @POINT + 1,-1476.963,6735.037,24.9149,''),
(1827680,@POINT := @POINT + 1,-1473.484,6740.938,25.39617,''),
(1827680,@POINT := @POINT + 1,-1466.005,6753.583,26.57142,''),
(1827680,@POINT := @POINT + 1,-1462.96,6758.391,26.76372,''),
(1827680,@POINT := @POINT + 1,-1455.813,6770.197,27.49258,''),
(1827680,@POINT := @POINT + 1,-1451.966,6775.794,27.83999,''),
(1827680,@POINT := @POINT + 1,-1441.275,6791.667,28.26914,''),
(1827680,@POINT := @POINT + 1,-1433.286,6800.193,27.90617,''),
(1827680,@POINT := @POINT + 1,-1428.875,6805.096,27.80177,''),
(1827680,@POINT := @POINT + 1,-1421.812,6819.231,27.22453,''),
(1827680,@POINT := @POINT + 1,-1417.525,6830.174,26.82341,''),
(1827680,@POINT := @POINT + 1,-1413.23,6840.947,27.13716,''),
(1827680,@POINT := @POINT + 1,-1405.411,6850.369,27.51216,''),
(1827680,@POINT := @POINT + 1,-1398.093,6853.629,28.15615,''),
(1827680,@POINT := @POINT + 1,-1392.859,6856.943,28.67517,''),
(1827680,@POINT := @POINT + 1,-1380.59,6866.38,29.42494,''),
(1827680,@POINT := @POINT + 1,-1368.13,6877.631,29.83994,''),
(1827680,@POINT := @POINT + 1,-1359.903,6885.618,30.30615,''),
(1827680,@POINT := @POINT + 1,-1351.923,6894.134,30.61035,''),
(1827680,@POINT := @POINT + 1,-1345.898,6900.377,31.35025,''),
(1827680,@POINT := @POINT + 1,-1333.704,6908.6,31.27341,''),
(1827680,@POINT := @POINT + 1,-1333.241,6917.5,31.90567,''),
(1827680,@POINT := @POINT + 1,-1332.708,6919.739,32.08533,''),
(1827680,@POINT := @POINT + 1,-1324.533,6934.592,31.75507,''),
(1827680,@POINT := @POINT + 1,-1322.315,6938.502,31.12214,'Kor''kron Warrior - before the gates of Garadar');

SET @POINT := 0;
DELETE FROM `waypoints` WHERE `entry` = 1827690;
INSERT INTO `waypoints`
(`entry`,`pointid`,`position_x`,`position_y`,`position_z`,`point_comment`)
VALUES
(1827690,@POINT := @POINT + 1,-1337.861, 6326.29, 44.63207,'Kor''kron Warrior - start movement at spawn area'),
(1827690,@POINT := @POINT + 1,-1364.772,6345.735,42.80714,''),
(1827690,@POINT := @POINT + 1,-1373.721,6353.521,41.99775,''),
(1827690,@POINT := @POINT + 1,-1387.278,6366.063,40.59365,''),
(1827690,@POINT := @POINT + 1,-1392.797,6371.437,39.77093,''),
(1827690,@POINT := @POINT + 1,-1403.06,6381.823,38.73808,''),
(1827690,@POINT := @POINT + 1,-1410.467,6389.75,37.63493,''),
(1827690,@POINT := @POINT + 1,-1414.636,6393.965,36.7886,''),
(1827690,@POINT := @POINT + 1,-1423.64,6402.972,36.05109,''),
(1827690,@POINT := @POINT + 1,-1432.655,6411.805,35.17282,''),
(1827690,@POINT := @POINT + 1,-1445.957,6423.377,33.95522,''),
(1827690,@POINT := @POINT + 1,-1454.444,6431.731,33.02517,''),
(1827690,@POINT := @POINT + 1,-1462.44,6440.473,32.03544,''),
(1827690,@POINT := @POINT + 1,-1470.026,6449.052,31.41499,''),
(1827690,@POINT := @POINT + 1,-1475.17,6454.822,30.95397,''),
(1827690,@POINT := @POINT + 1,-1483.699,6464.271,29.8011,''),
(1827690,@POINT := @POINT + 1,-1491.675,6474.137,28.81781,''),
(1827690,@POINT := @POINT + 1,-1496.74,6485.046,27.3991,''),
(1827690,@POINT := @POINT + 1,-1499.738,6492.024,26.34745,''),
(1827690,@POINT := @POINT + 1,-1505.32,6505.56,24.59105,''),
(1827690,@POINT := @POINT + 1,-1508.117,6517.336,23.43144,''),
(1827690,@POINT := @POINT + 1,-1509.333,6522.255,23.00387,''),
(1827690,@POINT := @POINT + 1,-1512.363,6536.441,22.17827,''),
(1827690,@POINT := @POINT + 1,-1515.406,6553.952,21.59428,''),
(1827690,@POINT := @POINT + 1,-1516.998,6565.655,21.27836,''),
(1827690,@POINT := @POINT + 1,-1517.698,6570.252,21.03073,''),
(1827690,@POINT := @POINT + 1,-1517.11,6588.301,20.57429,''),
(1827690,@POINT := @POINT + 1,-1515.579,6598.076,21.34782,''),
(1827690,@POINT := @POINT + 1,-1514.088,6610.3,21.32484,''),
(1827690,@POINT := @POINT + 1,-1511.476,6623.333,21.54515,''),
(1827690,@POINT := @POINT + 1,-1509.906,6632.761,22.80927,''),
(1827690,@POINT := @POINT + 1,-1509.058,6635.81,23.06611,''),
(1827690,@POINT := @POINT + 1,-1506.276,6652.978,23.78559,''),
(1827690,@POINT := @POINT + 1,-1502.883,6666.354,24.59722,''),
(1827690,@POINT := @POINT + 1,-1497.037,6679.254,24.66412,''),
(1827690,@POINT := @POINT + 1,-1491.964,6689.874,24.31915,''),
(1827690,@POINT := @POINT + 1,-1487.203,6700.854,24.3687,''),
(1827690,@POINT := @POINT + 1,-1482.917,6711.862,24.02227,''),
(1827690,@POINT := @POINT + 1,-1479.477,6722.841,24.27056,''),
(1827690,@POINT := @POINT + 1,-1473.851,6732.225,25.08501,''),
(1827690,@POINT := @POINT + 1,-1470.531,6737.682,25.33077,''),
(1827690,@POINT := @POINT + 1,-1464.446,6748.051,25.89157,''),
(1827690,@POINT := @POINT + 1,-1459.438,6756.29,26.52866,''),
(1827690,@POINT := @POINT + 1,-1452.879,6767.207,27.27745,''),
(1827690,@POINT := @POINT + 1,-1449.322,6772.238,27.66038,''),
(1827690,@POINT := @POINT + 1,-1438.278,6788.863,28.14414,''),
(1827690,@POINT := @POINT + 1,-1430.284,6797.393,28.08263,''),
(1827690,@POINT := @POINT + 1,-1422.313,6806.797,27.60637,''),
(1827690,@POINT := @POINT + 1,-1417.992,6817.732,27.1591,''),
(1827690,@POINT := @POINT + 1,-1414.596,6826.728,27.01875,''),
(1827690,@POINT := @POINT + 1,-1409.422,6839.417,27.01216,''),
(1827690,@POINT := @POINT + 1,-1403.775,6846.313,27.63791,''),
(1827690,@POINT := @POINT + 1,-1396.692,6849.87,28.08527,''),
(1827690,@POINT := @POINT + 1,-1385.115,6857.051,29.32163,''),
(1827690,@POINT := @POINT + 1,-1375.624,6865.091,29.95016,''),
(1827690,@POINT := @POINT + 1,-1370.572,6869.667,30.18852,''),
(1827690,@POINT := @POINT + 1,-1356.908,6882.812,30.66455,''),
(1827690,@POINT := @POINT + 1,-1348.929,6891.328,30.60046,''),
(1827690,@POINT := @POINT + 1,-1341.654,6899.07,31.40217,''),
(1827690,@POINT := @POINT + 1,-1333.316,6905.102,31.73031,''),
(1827690,@POINT := @POINT + 1,-1335.736,6918.606,32.00241,'Kor''kron Warrior - before the gates of Garadar');

SET @POINT := 0;
DELETE FROM `waypoints` WHERE `entry` = 1827700;
INSERT INTO `waypoints`
(`entry`,`pointid`,`position_x`,`position_y`,`position_z`,`point_comment`)
VALUES
(1827700,@POINT := @POINT + 1,-1338.36, 6318.153, 45.01073,'Kor''kron Warrior - start movement at spawn area'),
(1827700,@POINT := @POINT + 1,-1366.543,6351.105,42.68403,''),
(1827700,@POINT := @POINT + 1,-1371.533,6355.523,42.09822,''),
(1827700,@POINT := @POINT + 1,-1385.443,6368.981,40.6408,''),
(1827700,@POINT := @POINT + 1,-1395.111,6378.121,39.68797,''),
(1827700,@POINT := @POINT + 1,-1401.881,6385.123,38.72647,''),
(1827700,@POINT := @POINT + 1,-1408.552,6392.328,37.76111,''),
(1827700,@POINT := @POINT + 1,-1416.718,6400.788,36.93539,''),
(1827700,@POINT := @POINT + 1,-1425.904,6409.821,36.24522,''),
(1827700,@POINT := @POINT + 1,-1434.806,6417.924,35.38934,''),
(1827700,@POINT := @POINT + 1,-1443.599,6425.717,34.32959,''),
(1827700,@POINT := @POINT + 1,-1449.083,6431.053,33.56381,''),
(1827700,@POINT := @POINT + 1,-1457.52,6439.897,32.70525,''),
(1827700,@POINT := @POINT + 1,-1465.884,6449.283,31.82249,''),
(1827700,@POINT := @POINT + 1,-1475.257,6459.549,30.88913,''),
(1827700,@POINT := @POINT + 1,-1482.354,6467.568,29.99044,''),
(1827700,@POINT := @POINT + 1,-1490.457,6478.491,28.95247,''),
(1827700,@POINT := @POINT + 1,-1495.564,6489.765,27.24007,''),
(1827700,@POINT := @POINT + 1,-1498.951,6497.493,26.42055,''),
(1827700,@POINT := @POINT + 1,-1502.904,6509.288,24.59679,''),
(1827700,@POINT := @POINT + 1,-1504.438,6515.886,24.09046,''),
(1827700,@POINT := @POINT + 1,-1508.089,6532.022,22.93646,''),
(1827700,@POINT := @POINT + 1,-1511.046,6545.221,22.47978,''),
(1827700,@POINT := @POINT + 1,-1511.188,6547.367,22.46651,''),
(1827700,@POINT := @POINT + 1,-1513.87,6567.742,22.36155,''),
(1827700,@POINT := @POINT + 1,-1514.555,6574.309,21.56895,''),
(1827700,@POINT := @POINT + 1,-1513.588,6590.408,20.8719,''),
(1827700,@POINT := @POINT + 1,-1511.71,6602.129,21.02513,''),
(1827700,@POINT := @POINT + 1,-1515.465,6610.355,21.32606,''),
(1827700,@POINT := @POINT + 1,-1508.023,6624.962,21.99387,''),
(1827700,@POINT := @POINT + 1,-1507.305,6630.812,22.88379,''),
(1827700,@POINT := @POINT + 1,-1502.065,6645.726,23.84869,''),
(1827700,@POINT := @POINT + 1,-1501.956,6648.019,24.02696,''),
(1827700,@POINT := @POINT + 1,-1498.538,6668.55,24.92349,''),
(1827700,@POINT := @POINT + 1,-1493.063,6680.28,24.91315,''),
(1827700,@POINT := @POINT + 1,-1487.99,6690.899,24.63922,''),
(1827700,@POINT := @POINT + 1,-1483.316,6702.171,24.94744,''),
(1827700,@POINT := @POINT + 1,-1479.03,6713.18,24.42827,''),
(1827700,@POINT := @POINT + 1,-1475.426,6723.497,24.52056,''),
(1827700,@POINT := @POINT + 1,-1472.072,6728.462,25.23941,''),
(1827700,@POINT := @POINT + 1,-1463.461,6743.594,25.55983,''),
(1827700,@POINT := @POINT + 1,-1457.324,6753.719,26.04616,''),
(1827700,@POINT := @POINT + 1,-1453.892,6759.395,26.72756,''),
(1827700,@POINT := @POINT + 1,-1449.559,6766.19,27.40085,''),
(1827700,@POINT := @POINT + 1,-1440.567,6779.784,27.76914,''),
(1827700,@POINT := @POINT + 1,-1434.18,6788.641,28.14414,''),
(1827700,@POINT := @POINT + 1,-1426.186,6797.178,28.27855,''),
(1827700,@POINT := @POINT + 1,-1418.42,6808.097,27.79228,''),
(1827700,@POINT := @POINT + 1,-1415.963,6815.124,27.51456,''),
(1827700,@POINT := @POINT + 1,-1411.446,6825.967,26.9746,''),
(1827700,@POINT := @POINT + 1,-1405.521,6840.692,27.03707,''),
(1827700,@POINT := @POINT + 1,-1402.425,6841.922,27.65872,''),
(1827700,@POINT := @POINT + 1,-1392.36,6848.608,28.49327,''),
(1827700,@POINT := @POINT + 1,-1383.227,6854.804,29.80693,''),
(1827700,@POINT := @POINT + 1,-1373.103,6863.215,30.30895,''),
(1827700,@POINT := @POINT + 1,-1365.268,6870.637,30.89865,''),
(1827700,@POINT := @POINT + 1,-1352.81,6882.587,31.15894,''),
(1827700,@POINT := @POINT + 1,-1344.83,6891.103,31.11914,''),
(1827700,@POINT := @POINT + 1,-1336.76,6899.715,31.68115,''),
(1827700,@POINT := @POINT + 1,-1326.483,6909.889,32.31619,''),
(1827700,@POINT := @POINT + 1,-1325.027,6921.406,31.72394,''),
(1827700,@POINT := @POINT + 1,-1321.302,6936.862,31.40089,''),
(1827700,@POINT := @POINT + 1,-1320.953,6938.078,31.34834,''),
(1827700,@POINT := @POINT + 1,-1320.078,6941.819,31.07783,'Kor''kron Warrior - before the gates of Garadar');

SET @POINT := 0;
DELETE FROM `waypoints` WHERE `entry` = 1827710;
INSERT INTO `waypoints`
(`entry`,`pointid`,`position_x`,`position_y`,`position_z`,`point_comment`)
VALUES
(1827710,@POINT := @POINT + 1,-1336.097, 6321.046, 44.63943,'Kor''kron Warrior - start movement at spawn area'),
(1827710,@POINT := @POINT + 1,-1370.502,6355.803,42.25064,''),
(1827710,@POINT := @POINT + 1,-1380.13,6364.811,41.54261,''),
(1827710,@POINT := @POINT + 1,-1386.938,6371.178,40.70809,''),
(1827710,@POINT := @POINT + 1,-1397.002,6380.986,39.58918,''),
(1827710,@POINT := @POINT + 1,-1403.385,6387.948,38.50368,''),
(1827710,@POINT := @POINT + 1,-1413.577,6398.449,37.25796,''),
(1827710,@POINT := @POINT + 1,-1422.063,6406.963,36.73124,''),
(1827710,@POINT := @POINT + 1,-1430.369,6414.89,35.83902,''),
(1827710,@POINT := @POINT + 1,-1433.165,6417.463,35.16513,''),
(1827710,@POINT := @POINT + 1,-1447.673,6430.199,34.06244,''),
(1827710,@POINT := @POINT + 1,-1450.407,6433.349,33.52631,''),
(1827710,@POINT := @POINT + 1,-1460.509,6444.11,32.54182,''),
(1827710,@POINT := @POINT + 1,-1467.069,6451.264,31.76574,''),
(1827710,@POINT := @POINT + 1,-1475.899,6461.506,30.59028,''),
(1827710,@POINT := @POINT + 1,-1486.507,6473.29,29.33908,''),
(1827710,@POINT := @POINT + 1,-1491.514,6482.734,28.33359,''),
(1827710,@POINT := @POINT + 1,-1496.431,6493.94,26.91046,''),
(1827710,@POINT := @POINT + 1,-1500.691,6503.52,25.34488,''),
(1827710,@POINT := @POINT + 1,-1502.961,6512.604,24.74237,''),
(1827710,@POINT := @POINT + 1,-1506.207,6525.995,23.50779,''),
(1827710,@POINT := @POINT + 1,-1508.052,6535.492,22.99776,''),
(1827710,@POINT := @POINT + 1,-1510.246,6546.973,22.54517,''),
(1827710,@POINT := @POINT + 1,-1512.071,6560.218,22.83521,''),
(1827710,@POINT := @POINT + 1,-1513.472,6569.841,22.21292,''),
(1827710,@POINT := @POINT + 1,-1513.806,6575.564,21.33661,''),
(1827710,@POINT := @POINT + 1,-1512.245,6594.287,21.09675,''),
(1827710,@POINT := @POINT + 1,-1510.371,6606.009,20.98973,''),
(1827710,@POINT := @POINT + 1,-1509.369,6612.409,21.33319,''),
(1827710,@POINT := @POINT + 1,-1506.946,6625.794,21.89964,''),
(1827710,@POINT := @POINT + 1,-1504.622,6639.592,23.56047,''),
(1827710,@POINT := @POINT + 1,-1503.587,6646.04,23.87176,''),
(1827710,@POINT := @POINT + 1,-1501.306,6658.846,24.68228,''),
(1827710,@POINT := @POINT + 1,-1497.472,6668.724,24.93933,''),
(1827710,@POINT := @POINT + 1,-1490.677,6683.62,25.0003,''),
(1827710,@POINT := @POINT + 1,-1485.604,6694.239,24.86297,''),
(1827710,@POINT := @POINT + 1,-1481.185,6705.679,24.84087,''),
(1827710,@POINT := @POINT + 1,-1476.899,6716.688,24.66521,''),
(1827710,@POINT := @POINT + 1,-1472.744,6726.604,24.97881,''),
(1827710,@POINT := @POINT + 1,-1471.711,6727.618,25.49656,''),
(1827710,@POINT := @POINT + 1,-1460.75,6746.675,25.84645,''),
(1827710,@POINT := @POINT + 1,-1456.739,6753.44,26.31558,''),
(1827710,@POINT := @POINT + 1,-1452.209,6760.691,26.80779,''),
(1827710,@POINT := @POINT + 1,-1445.248,6771.42,27.56945,''),
(1827710,@POINT := @POINT + 1,-1437.656,6782.677,27.76914,''),
(1827710,@POINT := @POINT + 1,-1430.971,6791.019,28.33226,''),
(1827710,@POINT := @POINT + 1,-1429.988,6797.279,28.09618,''),
(1827710,@POINT := @POINT + 1,-1417.094,6810.665,27.86192,''),
(1827710,@POINT := @POINT + 1,-1414.659,6817.459,27.35814,''),
(1827710,@POINT := @POINT + 1,-1409.454,6829.344,26.97355,''),
(1827710,@POINT := @POINT + 1,-1404.38,6841.547,27.32084,''),
(1827710,@POINT := @POINT + 1,-1401.402,6842.54,27.87748,''),
(1827710,@POINT := @POINT + 1,-1389.501,6849.632,29.05975,''),
(1827710,@POINT := @POINT + 1,-1375.869,6859.638,30.38395,''),
(1827710,@POINT := @POINT + 1,-1372.46,6862.975,30.57833,''),
(1827710,@POINT := @POINT + 1,-1357.812,6876.392,31.20166,''),
(1827710,@POINT := @POINT + 1,-1349.526,6885.049,31.4071,''),
(1827710,@POINT := @POINT + 1,-1341.547,6893.565,31.34277,''),
(1827710,@POINT := @POINT + 1,-1333.476,6902.177,31.64841,''),
(1827710,@POINT := @POINT + 1,-1337.2,6915.83,31.86057,'Kor''kron Warrior - before the gates of Garadar');

SET @POINT := 0;
DELETE FROM `waypoints` WHERE `entry` = 1827720;
INSERT INTO `waypoints`
(`entry`,`pointid`,`position_x`,`position_y`,`position_z`,`point_comment`)
VALUES
(1827720,@POINT := @POINT + 1,-1333.939, 6323.755, 44.85339,'Kor''kron Warrior - start movement at spawn area'),
(1827720,@POINT := @POINT + 1,-1372.985,6355.595,42.17725,''),
(1827720,@POINT := @POINT + 1,-1380.701,6362.483,41.38876,''),
(1827720,@POINT := @POINT + 1,-1393.165,6374.485,39.9179,''),
(1827720,@POINT := @POINT + 1,-1402.02,6383.17,38.7765,''),
(1827720,@POINT := @POINT + 1,-1406.116,6387.854,38.10735,''),
(1827720,@POINT := @POINT + 1,-1412.967,6394.518,37.09569,''),
(1827720,@POINT := @POINT + 1,-1421.718,6403.776,36.40208,''),
(1827720,@POINT := @POINT + 1,-1433.083,6414.556,35.46972,''),
(1827720,@POINT := @POINT + 1,-1443.613,6423.717,34.36494,''),
(1827720,@POINT := @POINT + 1,-1452.461,6431.774,33.27463,''),
(1827720,@POINT := @POINT + 1,-1456.169,6436.205,32.68983,''),
(1827720,@POINT := @POINT + 1,-1467.681,6449.085,31.61221,''),
(1827720,@POINT := @POINT + 1,-1468.975,6450.537,31.22228,''),
(1827720,@POINT := @POINT + 1,-1480.555,6463.545,30.09472,''),
(1827720,@POINT := @POINT + 1,-1489.658,6473.817,28.77167,''),
(1827720,@POINT := @POINT + 1,-1493.37,6481.848,28.15433,''),
(1827720,@POINT := @POINT + 1,-1499.813,6495.99,26.26503,''),
(1827720,@POINT := @POINT + 1,-1503.464,6504.888,24.87642,''),
(1827720,@POINT := @POINT + 1,-1504.956,6512.256,23.917,''),
(1827720,@POINT := @POINT + 1,-1506.791,6519.463,23.35355,''),
(1827720,@POINT := @POINT + 1,-1511.303,6540.132,22.49645,''),
(1827720,@POINT := @POINT + 1,-1513.397,6552.567,21.83549,''),
(1827720,@POINT := @POINT + 1,-1514.997,6564.336,22.05741,''),
(1827720,@POINT := @POINT + 1,-1515.498,6569.117,21.4177,''),
(1827720,@POINT := @POINT + 1,-1515.803,6579.856,20.84326,''),
(1827720,@POINT := @POINT + 1,-1513.709,6598.121,21.06501,''),
(1827720,@POINT := @POINT + 1,-1515.313,6600.002,21.0576,''),
(1827720,@POINT := @POINT + 1,-1514.25,6616.754,21.18175,''),
(1827720,@POINT := @POINT + 1,-1508.643,6631.316,22.7814,''),
(1827720,@POINT := @POINT + 1,-1510.231,6634.844,22.60852,''),
(1827720,@POINT := @POINT + 1,-1505.241,6651.351,23.9668,''),
(1827720,@POINT := @POINT + 1,-1503.262,6661.042,24.23788,''),
(1827720,@POINT := @POINT + 1,-1497.549,6674.138,24.95181,''),
(1827720,@POINT := @POINT + 1,-1490.997,6687.711,24.55401,''),
(1827720,@POINT := @POINT + 1,-1485.924,6698.331,24.56915,''),
(1827720,@POINT := @POINT + 1,-1481.808,6709.736,24.41008,''),
(1827720,@POINT := @POINT + 1,-1477.522,6720.744,24.40557,''),
(1827720,@POINT := @POINT + 1,-1472.883,6730.477,25.19499,''),
(1827720,@POINT := @POINT + 1,-1468.464,6737.824,25.67717,''),
(1827720,@POINT := @POINT + 1,-1460.654,6750.778,25.8965,''),
(1827720,@POINT := @POINT + 1,-1457.139,6756.591,26.43946,''),
(1827720,@POINT := @POINT + 1,-1452.093,6764.842,27.14405,''),
(1827720,@POINT := @POINT + 1,-1442.268,6779.769,27.95688,''),
(1827720,@POINT := @POINT + 1,-1437.285,6786.764,27.85752,''),
(1827720,@POINT := @POINT + 1,-1429.967,6795.103,28.20726,''),
(1827720,@POINT := @POINT + 1,-1421.984,6803.646,28.02373,''),
(1827720,@POINT := @POINT + 1,-1418.864,6812.066,27.69678,''),
(1827720,@POINT := @POINT + 1,-1413.823,6823.541,27.11336,''),
(1827720,@POINT := @POINT + 1,-1408.24,6837.485,26.88716,''),
(1827720,@POINT := @POINT + 1,-1404.643,6846.632,27.44936,''),
(1827720,@POINT := @POINT + 1,-1396.571,6848.583,27.98872,''),
(1827720,@POINT := @POINT + 1,-1387.114,6853.479,29.23651,''),
(1827720,@POINT := @POINT + 1,-1375.791,6862.607,29.83341,''),
(1827720,@POINT := @POINT + 1,-1373.306,6864.989,30.35759,''),
(1827720,@POINT := @POINT + 1,-1361.352,6876.015,31.13771,''),
(1827720,@POINT := @POINT + 1,-1348.593,6889.046,30.91431,''),
(1827720,@POINT := @POINT + 1,-1340.614,6897.562,31.35022,''),
(1827720,@POINT := @POINT + 1,-1332.543,6906.174,31.57373,''),
(1827720,@POINT := @POINT + 1,-1327.795,6915.716,32.14365,''),
(1827720,@POINT := @POINT + 1,-1318.258,6944.237,31.36799,'Kor''kron Warrior - before the gates of Garadar');


--
-- END UPDATING QUERIES
--
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
