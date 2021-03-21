-- DB update 2019_09_20_00 -> 2019_09_27_00
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2019_09_20_00';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2019_09_20_00 2019_09_27_00 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1567979349335198995'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1567979349335198995');

-- Fix a few quest chain conditions
UPDATE `quest_template` SET `RewardNextQuest` = 12211 WHERE `ID` = 12206;   -- Show "Let Them Not Rise!" instantly when "Blighted Last Rites" is rewarded
UPDATE `quest_template_addon` SET `PrevQuestID` = 12206 WHERE `ID` = 12211; -- "Blighted Last Rites" has to be completed before "Let Them Not Rise!" can be started
UPDATE `quest_template_addon` SET `PrevQuestID` = 12230 WHERE `ID` = 12240; -- "Stealing from the Siegesmiths" has to be completed before "A Means to an End" can be started

DELETE FROM `quest_template_addon` WHERE `ID` IN (12230,12234,12214);
INSERT INTO `quest_template_addon` (`ID`, `MaxLevel`, `AllowableClasses`, `SourceSpellID`, `PrevQuestID`, `NextQuestID`, `ExclusiveGroup`, `RewardMailTemplateID`, `RewardMailDelay`, `RequiredSkillID`, `RequiredSkillPoints`, `RequiredMinRepFaction`, `RequiredMaxRepFaction`, `RequiredMinRepValue`, `RequiredMaxRepValue`, `ProvidedItemCount`, `SpecialFlags`)
VALUES
(12214,0,0,0,12209,0,0,0,0,0,0,0,0,0,0,0,0), -- "Materiel Plunder" has to be completed before "Fresh Remounts" can be started
(12230,0,0,0,12211,0,0,0,0,0,0,0,0,0,0,0,0), -- "Let Them Not Rise!" has to be completed before "Stealing from the Siegesmiths" can be started
(12234,0,0,0,12230,0,0,0,0,0,0,0,0,0,0,0,0); -- "Stealing from the Siegesmiths" has to be completed before "Need to Know" can be started


-- There are two versions of "Deathguard Molder" in Venomspite, delete one of them
DELETE FROM `creature` WHERE `guid` = 113330;

-- The other one needs waypoint movement
UPDATE `creature` SET `spawndist` = 0, `MovementType` = 2, `position_x` = 3242.083, `position_y` = -683.1053, `position_z` = 166.9898 WHERE `guid` = 113329;

DELETE FROM `creature_addon` WHERE `guid` = 113329;
INSERT INTO `creature_addon` (`guid`, `path_id`, `mount`, `bytes1`, `bytes2`, `emote`, `auras`)
VALUES
(113329,1133290,0,0,1,0,'');

DELETE FROM `waypoint_data` WHERE `id` = 1133290;
INSERT INTO `waypoint_data` (`id`, `point`, `position_x`, `position_y`, `position_z`, `orientation`, `delay`, `move_type`, `action`, `action_chance`, `wpguid`)
VALUES
(1133290,1,3234.21,-662.994,166.701,0,60000,0,0,100,0),
(1133290,2,3242.08,-683.105,166.99,0,0,0,0,100,0),
(1133290,3,3244.74,-697.864,167.014,0,0,0,0,100,0),
(1133290,4,3248.02,-702.584,167.379,0,0,0,0,100,0),
(1133290,5,3252.1,-710.594,167.641,0,0,0,0,100,0),
(1133290,6,3257.55,-721.548,168.042,0,0,0,0,100,0),
(1133290,7,3260.51,-729.258,168.591,0,60000,0,0,100,0),
(1133290,8,3257.55,-721.548,168.042,0,0,0,0,100,0),
(1133290,9,3252.1,-710.594,167.641,0,0,0,0,100,0),
(1133290,10,3248.02,-702.584,167.379,0,0,0,0,100,0),
(1133290,11,3245.56,-698.432,167.145,0,0,0,0,100,0);


-- Roleplay event "Blighted Last Rites"
-- "Scarlet Onslaught Prisoner": Instead of just despawning the prisoner should show an emote "The Scarlet Onslaught Prisoner moans but seems otherwise unaffected by the blight."
UPDATE `smart_scripts` SET `action_type` = 1, `comment`='Scarlet Onslaught Prisoner - On Spellhit ''Flask of Blight'' - Say Line 0' WHERE `entryorguid` = 27349 AND `id` = 1 AND `source_type` = 0;

-- "Junior Apothecary Schlemiel": Decrease the wait time until he dies from 5 to 3 seconds
UPDATE `smart_scripts` SET `event_param1` = 3000, `event_param2` = 3000 WHERE `entryorguid` = 27250 AND `id` = 3;

-- "Apothecary Vicky Levine": Provide a new action list and call it only during event phase 1; enter event phase 1 on reset
UPDATE `smart_scripts` SET `event_phase_mask` = 1 WHERE `entryorguid` = 27248 AND `id` = 0 AND `source_type` = 0;

DELETE FROM `smart_scripts` WHERE `entryorguid` = 27248 AND `id` = 1 AND `source_type` = 0;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`)
VALUES
(27248,0,1,0,25,0,100,0,0,0,0,0,0,22,1,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Apothecary Vicky Levine - On Reset - Set Event Phase 1');

DELETE FROM `smart_scripts` WHERE `entryorguid` = 2724800 AND `source_type` = 9;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`)
VALUES
(2724800,9,0,0,0,0,100,0,0,0,0,0,0,22,2,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Apothecary Vicky Levine - On Script - Set Event Phase 2'),
(2724800,9,1,0,0,0,100,0,0,0,0,0,0,70,0,0,0,0,0,0,10,106544,27250,0,0,0,0,0,0,'Apothecary Vicky Levine - On Script - Respawn Junior Apothecary Schlemiel'),
(2724800,9,2,0,0,0,100,0,0,0,0,0,0,17,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Apothecary Vicky Levine - On Script - Set Emote State 0'),
(2724800,9,3,0,0,0,100,0,0,0,0,0,0,66,0,0,0,0,0,0,19,27250,0,0,0,0,0,0,0,'Apothecary Vicky Levine - On Script - Set Orientation ''Junior Apothecary Schlemiel'''),
(2724800,9,4,0,0,0,100,0,2000,2000,0,0,0,1,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Apothecary Vicky Levine - On Script - Say Line 1'),
(2724800,9,5,0,0,0,100,0,2000,2000,0,0,0,1,0,0,0,0,0,0,19,27250,0,0,0,0,0,0,0,'Apothecary Vicky Levine - On Script - Say Line 1 (Junior Apothecary Schlemiel)'),
(2724800,9,6,0,0,0,100,0,4000,4000,0,0,0,1,1,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Apothecary Vicky Levine - On Script - Say Line 2'),
(2724800,9,7,0,0,0,100,0,4000,4000,0,0,0,1,1,0,0,0,0,0,19,27250,0,0,0,0,0,0,0,'Apothecary Vicky Levine - On Script - Say Line 2 (Junior Apothecary Schlemiel)'),
(2724800,9,8,0,0,0,100,0,5000,5000,0,0,0,1,2,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Apothecary Vicky Levine - On Script - Say Line 3'),
(2724800,9,9,0,0,0,100,0,3000,3000,0,0,0,11,48201,0,0,0,0,0,19,27250,0,0,0,0,0,0,0,'Apothecary Vicky Levine - On Script - Cast Throw Blight'),
(2724800,9,10,0,0,0,100,0,7000,7000,0,0,0,1,3,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Apothecary Vicky Levine - On Script - Say Line 4'),
(2724800,9,11,0,0,0,100,0,6000,6000,0,0,0,1,4,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Apothecary Vicky Levine - On Script - Say Line 5'),
(2724800,9,12,0,0,0,100,0,3000,3000,0,0,0,66,0,0,0,0,0,0,8,0,0,0,0,0,0,0,2.63545,'Apothecary Vicky Levine - On Script - Reset Orientation'),
(2724800,9,13,0,0,0,100,0,0,0,0,0,0,17,133,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Apothecary Vicky Levine - On Script - Set Emote State 133'),
(2724800,9,14,0,0,0,100,0,0,0,0,0,0,22,1,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Apothecary Vicky Levine - On Script - Set Event Phase 1');

DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId` = 13 AND `SourceEntry` = 48201;
DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId` = 17 AND `SourceEntry` = 48188;
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `ErrorType`, `ErrorTextId`, `ScriptName`, `Comment`)
VALUES
(13,1,48201,0,0,31,0,3,27250,0,0,0,0,'','Spell ''Throw Blight'' targets ''Junior Apothecary Schlemiel'''),
(17,0,48188,0,0,29,0,27349,3,0,0,0,0,'','Spell ''Flask of Blight'' can only be used within 3 yards of ''Scarlet Onslaught Prisoner''');


-- Add more Onslaught Warhorses to New Hearthglen (two of them with waypoint movement) and a Transformed Warhorse to Venomspite
DELETE FROM `creature` WHERE `guid` IN (102757,102772,102773,102776,102777,102778);
INSERT INTO `creature` (`guid`, `id`, `map`, `zoneId`, `areaId`, `spawnMask`, `phaseMask`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `spawndist`, `currentwaypoint`, `curhealth`, `curmana`, `MovementType`, `npcflag`, `unit_flags`, `dynamicflags`, `ScriptName`, `VerifiedBuild`)
VALUES
(102757,27213,571,0,0,1,1,0,0,3108.18,-554.998,118.26,5.33756,300,0,0,11614,0,0,0,0,0,'',0),   -- Onslaught Warhorses
(102772,27213,571,0,0,1,1,0,0,3133.18,-543.726,121.418,0.530924,300,0,0,11614,0,0,0,0,0,'',0), -- Onslaught Warhorses
(102773,27213,571,0,0,1,1,0,0,2984.51,-423.93,123.224,5.70277,300,0,0,11614,0,2,0,0,0,'',0),   -- Onslaught Warhorses (waypoint movement)
(102776,27213,571,0,0,1,1,0,0,3129.03,-570.809,115.711,1.94386,300,0,0,12013,0,2,0,0,0,'',0),  -- Onslaught Warhorses (waypoint movement)
(102777,27213,571,0,0,1,1,0,0,2893.53,-382.92,112.461,5.45183,300,0,0,12013,0,0,0,0,0,'',0),   -- Onslaught Warhorses
(102778,28014,571,0,0,1,1,0,0,3263.77,-629.451,165.484,3.12117,300,0,0,4050,0,0,0,0,0,'',0);   -- Transformed Warhorse

DELETE FROM `creature_addon` WHERE `guid` IN (102773,102776);
INSERT INTO `creature_addon` (`guid`, `path_id`, `mount`, `bytes1`, `bytes2`, `emote`, `auras`)
VALUES
(102773,1027730,0,0,0,0,''),
(102776,1027760,0,0,0,0,'');
 
DELETE FROM `waypoint_data` WHERE `id` IN (1027730,1027760);
INSERT INTO `waypoint_data` (`id`, `point`, `position_x`, `position_y`, `position_z`, `orientation`, `delay`, `move_type`, `action`, `action_chance`, `wpguid`)
VALUES
(1027730,1,2984.51,-423.93,123.224,0,0,0,0,100,0),
(1027730,2,3000.06,-426.271,123.349,0,0,0,0,100,0),
(1027730,3,3010.3,-436.453,123.267,0,0,0,0,100,0),
(1027730,4,3017.67,-443.929,123.258,0,0,0,0,100,0),
(1027730,5,3027.81,-453.585,123.233,0,0,0,0,100,0),
(1027730,6,3037.95,-463.24,123.169,0,0,0,0,100,0),
(1027730,7,3045.73,-472.101,122.985,0,0,0,0,100,0),
(1027730,8,3057.24,-483.007,122.816,0,0,0,0,100,0),
(1027730,9,3067.22,-492.821,122.799,0,0,0,0,100,0),
(1027730,10,3079.74,-505.049,122.077,0,0,0,0,100,0),
(1027730,11,3089.92,-514.665,121.38,0,0,0,0,100,0),
(1027730,12,3103.55,-528.854,119.918,0,0,0,0,100,0),
(1027730,13,3111.06,-543.581,118.274,0,0,0,0,100,0),
(1027730,14,3118.16,-559.575,116.799,0,0,0,0,100,0),
(1027730,15,3124.19,-573.252,115.412,0,5000,0,0,100,0),
(1027730,16,3118.16,-559.575,116.799,0,0,0,0,100,0),
(1027730,17,3111.06,-543.581,118.274,0,0,0,0,100,0),
(1027730,18,3103.55,-528.854,119.918,0,0,0,0,100,0),
(1027730,19,3089.92,-514.665,121.38,0,0,0,0,100,0),
(1027730,20,3079.74,-505.049,122.077,0,0,0,0,100,0),
(1027730,21,3067.22,-492.821,122.799,0,0,0,0,100,0),
(1027730,22,3057.24,-483.007,122.816,0,0,0,0,100,0),
(1027730,23,3045.73,-472.101,122.985,0,0,0,0,100,0),
(1027730,24,3037.95,-463.24,123.169,0,0,0,0,100,0),
(1027730,25,3027.81,-453.585,123.233,0,0,0,0,100,0),
(1027730,26,3017.67,-443.929,123.258,0,0,0,0,100,0),
(1027730,27,3010.3,-436.453,123.267,0,0,0,0,100,0),
(1027730,28,3000.06,-426.271,123.349,0,0,0,0,100,0),
(1027730,29,2984.51,-423.93,123.224,0,5000,0,0,100,0),
(1027760,1,3129.03,-570.809,115.71,0,5000,0,0,100,0),
(1027760,2,3125.87,-563.25,116.529,0,0,0,0,100,0),
(1027760,3,3119.03,-544.31,118.424,0,0,0,0,100,0),
(1027760,4,3112.63,-533.246,119.408,0,0,0,0,100,0),
(1027760,5,3106.95,-524.416,120.375,0,0,0,0,100,0),
(1027760,6,3086.58,-504.918,121.973,0,0,0,0,100,0),
(1027760,7,3071.78,-491.184,122.731,0,0,0,0,100,0),
(1027760,8,3058.89,-479.356,123.066,0,0,0,0,100,0),
(1027760,9,3045.99,-467.528,123.076,0,0,0,0,100,0),
(1027760,10,3035.67,-458.065,123.201,0,0,0,0,100,0),
(1027760,11,3019.24,-441.917,123.276,0,0,0,0,100,0),
(1027760,12,3007.6,-429.769,123.268,0,0,0,0,100,0),
(1027760,13,2995.92,-424.297,123.336,0,0,0,0,100,0),
(1027760,14,2982.66,-420.311,123.225,0,5000,0,0,100,0),
(1027760,15,2995.92,-424.297,123.336,0,0,0,0,100,0),
(1027760,16,3007.6,-429.769,123.268,0,0,0,0,100,0),
(1027760,17,3019.24,-441.917,123.276,0,0,0,0,100,0),
(1027760,18,3035.67,-458.065,123.201,0,0,0,0,100,0),
(1027760,19,3045.99,-467.528,123.076,0,0,0,0,100,0),
(1027760,20,3058.89,-479.356,123.066,0,0,0,0,100,0),
(1027760,21,3071.78,-491.184,122.731,0,0,0,0,100,0),
(1027760,22,3086.58,-504.918,121.973,0,0,0,0,100,0),
(1027760,23,3106.95,-524.416,120.375,0,0,0,0,100,0),
(1027760,24,3112.63,-533.246,119.408,0,0,0,0,100,0),
(1027760,25,3119.03,-544.31,118.424,0,0,0,0,100,0),
(1027760,26,3125.87,-563.25,116.529,0,0,0,0,100,0),
(1027760,27,3129.03,-570.809,115.71,0,0,0,0,100,0);


-- "Onslaught Knight": Do not cast "Ride Vehicle" out of combat (will be handled via vehicle_template_accessory); instead exit vehicle after death
DELETE FROM `smart_scripts` WHERE `entryorguid` = 27206 AND `source_type` = 0 AND `id` = 0;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`)
VALUES
(27206,0,0,0,6,0,100,0,0,0,0,0,0,203,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Onslaught Knight - On Death - Exit Vehicle');

-- SAI for capturing and handing over Onslaught Warhorses
DELETE FROM `smart_scripts` WHERE `entryorguid` IN (-98539,27213) AND `source_type` = 0;
DELETE FROM `smart_scripts` WHERE `entryorguid` IN (2721300,2721301) AND `source_type` = 9;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`)
VALUES
(27213,0,0,1,11,0,100,0,0,0,0,0,0,211,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Onslaught Warhorse - On Respawn - Set Event Phase Flag Reset Off'),
(27213,0,1,0,61,0,100,0,0,0,0,0,0,22,1,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Onslaught Warhorse - Linked - Set Event Phase 1'),
(27213,0,2,3,28,5,100,0,0,0,0,0,0,22,2,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Onslaught Warhorse - Passenger Removed (Phase 1 & 3) - Set Event Phase 2'),
(27213,0,3,4,61,2,100,0,0,0,0,0,0,101,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Onslaught Warhorse - Linked (Phase 2) - Set Home Position'),
(27213,0,4,5,61,2,100,0,0,0,0,0,0,2,35,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Onslaught Warhorse - Linked (Phase 2) - Set Faction ''Friendly'''),
(27213,0,5,6,61,2,100,0,0,0,0,0,0,18,131072,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Onslaught Warhorse - Linked (Phase 2) - Set Unit Flag ''UNIT_FLAG_PACIFIED'''),
(27213,0,6,0,61,2,100,0,0,0,0,0,0,80,2721300,2,0,0,0,0,1,0,0,0,0,0,0,0,0,'Onslaught Warhorse - Linked (Phase 2) - Call Action List'),
(27213,0,7,0,59,2,100,0,1,0,0,0,0,41,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Onslaught Warhorse - On Timed Event ID 1 (Phase 2) - Despawn'),
(27213,0,8,9,23,2,100,0,48290,1,500,500,0,74,1,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Onslaught Warhorse - On Has Aura ''Onslaught Riding Crop'' (Phase 2) - Remove Timed Event ID 1'),
(27213,0,9,0,61,2,100,0,0,0,0,0,0,22,3,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Onslaught Warhorse - Linked (Phase 2) - Set Event Phase 3'),
(27213,0,10,11,31,4,100,1,48297,0,0,0,0,22,4,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Onslaught Warhorse - On Spell Hit ''Hand Over Reins'' (Phase 3) - Set Event Phase 4 (No Repeat)'),
(27213,0,11,0,61,8,100,0,0,0,0,0,0,80,2721301,2,0,0,0,0,1,0,0,0,0,0,0,0,0,'Onslaught Warhorse - Linked (Phase 4) - Call Action List'),

(2721300,9,1,0,0,2,100,0,1000,1000,0,0,0,212,1,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Onslaught Warhorse - On Script (Phase 2) - Stop WP Movement'),
(2721300,9,2,0,0,2,100,0,0,0,0,0,0,67,1,30000,30000,0,0,0,1,0,0,0,0,0,0,0,0,'Onslaught Warhorse - On Script (Phase 2) - Create Timed Event ID 1'),

(2721301,9,0,0,0,8,100,0,0,0,0,0,0,11,50630,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Onslaught Warhorse - On Script (Phase 4) - Cast Spell ''Eject All Passengers'''),
(2721301,9,1,0,0,8,100,0,0,0,0,0,0,59,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Onslaught Warhorse - On Script (Phase 4) - Set Run Off'),
(2721301,9,2,0,0,8,100,0,0,0,0,0,0,29,0,0,0,0,0,0,10,98539,23837,0,0,0,0,0,0,'Onslaught Warhorse - On Script (Phase 4) - Follow'),
(2721301,9,3,0,0,8,100,0,3000,3000,0,0,0,45,0,1,0,0,0,0,10,98539,23837,0,0,0,0,0,0,'Onslaught Warhorse - On Script (Phase 4) - Set Data 0 1 On ''ELM General Purpose Bunny'''),
(2721301,9,4,0,0,8,100,0,3000,3000,0,0,0,11,48304,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Onslaught Warhorse - On Script (Phase 4) - Cast Spell ''Fresh Remounts: Skeletal Warhorse Transform'''),
(2721301,9,5,0,0,8,100,0,4000,4000,0,0,0,69,0,0,0,0,0,0,8,0,0,0,0,3231.09,-659.989,166.621,1.0592,'Onslaught Warhorse - On Script (Phase 4) - Move To Pos'),
(2721301,9,6,0,0,8,100,0,13000,13000,0,0,0,41,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Onslaught Warhorse - On Script (Phase 4) - Despawn'),

(-98539,0,0,0,38,0,100,0,0,1,0,0,0,11,48298,0,0,0,0,0,19,27213,20,0,0,0,0,0,0,'ELM General Purpose Bunny - On Data Set 0 1 - Cast Spell ''Fresh Remounts: Plague Spigot''');

-- Mount Onslaught Knight on the Onslaught Warhorse
DELETE FROM `vehicle_template_accessory` WHERE `entry` = 27213;
INSERT INTO `vehicle_template_accessory` (`entry`, `accessory_entry`, `seat_id`, `minion`, `description`, `summontype`, `summontimer`)
VALUES
(27213,27206,0,0,'Onslaught Warhorse - Onslaught Knight',8,30000);

-- Restrict the usage for "Onslaught Riding Crop"
DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId` = 17 AND `SourceEntry` = 48290;
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `ErrorType`, `ErrorTextId`, `ScriptName`, `Comment`)
VALUES
(17,0,48290,0,0,1,1,43671,0,0,1,0,0,'','''Onslaught Riding Crop'' can only be used on targets without aura ''Ride Vehicle'' (43671)'),
(17,0,48290,0,0,23,1,4186,0,0,1,0,0,'','''Onslaught Riding Crop'' cannot be used in area ''Venomspite'' (4186)'),
(17,0,48290,0,0,31,1,3,27213,0,0,0,0,'','''Onslaught Riding Crop'' can only target ''Onslaught Warhorse''');

-- "Onslaught Warhorse": Cast ''Ride Vehicle'' on spellclick and restrict spellclick to NPCs only
DELETE FROM `npc_spellclick_spells` WHERE `npc_entry` = 27213;
INSERT INTO `npc_spellclick_spells` (`npc_entry`, `spell_id`, `cast_flags`, `user_type`)
VALUES
(27213,43671,0,0);

DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId` = 18 AND `SourceGroup` = 27213 AND `SourceEntry` = 43671;
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `ErrorType`, `ErrorTextId`, `ScriptName`, `Comment`)
VALUES
(18,27213,43671,0,0,31,0,3,0,0,0,0,0,'','Onslaught Warhorse - Restrict spellclick to NPCs only');

--
-- END UPDATING QUERIES
--
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
