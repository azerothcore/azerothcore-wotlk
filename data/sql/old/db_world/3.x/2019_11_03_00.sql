-- DB update 2019_11_02_00 -> 2019_11_03_00
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2019_11_02_00';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2019_11_02_00 2019_11_03_00 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1571608072211416530'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1571608072211416530');

-- Enable the teleporter after "Opening the Backdoor" is rewarded
DELETE FROM `areatrigger_scripts` WHERE `entry` IN (5187,5190);
INSERT INTO `areatrigger_scripts` (`entry`, `ScriptName`)
VALUES
(5187,'SmartTrigger'),
(5190,'SmartTrigger');

DELETE FROM `smart_scripts` WHERE `source_type` = 2 AND `entryorguid` IN (5187,5190);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`)
VALUES
(5187,2,0,0,46,0,100,0,0,0,0,0,0,62,571,0,0,0,0,0,7,0,0,0,0,6151.64,-1071.89,402.783,2.22078,'Garm Teleporter - Areatrigger On Trigger - Teleport To K3'),
(5190,2,0,0,46,0,100,0,0,0,0,0,0,62,571,0,0,0,0,0,7,0,0,0,0,6313.08,-1760.21,457.134,2.06762,'K3 Teleporter - Areatrigger On Trigger - Teleport To Garm');

DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId` = 22 AND `SourceGroup` = 1 AND `SourceId` = 2 AND `SourceEntry` IN (5187,5190);
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `ErrorType`, `ErrorTextId`, `ScriptName`, `Comment`)
VALUES
(22,1,5187,2,0,8,0,12821,0,0,0,0,0,'','Enable the Garm teleporter after ''Opening the Backdoor'' is rewarded'),
(22,1,5190,2,0,8,0,12821,0,0,0,0,0,'','Enable the K3 teleporter after ''Opening the Backdoor'' is rewarded');

-- Remove spawns from Garm cave and re-use them for a few additional Goblin Sappers
DELETE FROM `creature` WHERE `guid` IN (202437,202439,152097,202440,202434,202433,202431,209161,209160,209159,209158,209157,209156,209155,209154,209153);
INSERT INTO `creature` (`guid`, `id`, `map`, `zoneId`, `areaId`, `spawnMask`, `phaseMask`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `spawndist`, `currentwaypoint`, `curhealth`, `curmana`, `MovementType`, `npcflag`, `unit_flags`, `dynamicflags`, `ScriptName`, `VerifiedBuild`)
VALUES
(209153,29555,571,0,0,1,2,0,1,6265.72,-1601.95,421.895,0.393914,30,0,0,1,0,0,0,0,0,'',0),
(209154,29555,571,0,0,1,2,0,1,6263.44,-1605.55,421.339,0.303593,30,0,0,1,0,0,0,0,0,'',0),
(209155,29555,571,0,0,1,2,0,1,6262.23,-1599.02,420.814,0.252542,30,0,0,1,0,0,0,0,0,'',0),
(209156,29555,571,0,0,1,2,0,1,6264.93,-1594.77,421.205,0.401767,30,0,0,1,0,0,0,0,0,'',0),
(209157,29555,571,0,0,1,2,0,1,6267.98,-1597.87,422.207,0.210075,30,0,0,1,0,0,0,0,0,'',0),
(209158,29555,571,0,0,1,2,0,1,6261.15,-1592.43,420.682,0.202207,30,0,0,1,0,0,0,0,0,'',0);

-- Waypoint movement
UPDATE `creature` SET `spawndist` = 0,`MovementType` = 2 WHERE `guid` = 202412;                                                                        -- Garm Watcher
UPDATE `creature` SET `spawndist` = 0,`MovementType` = 2 WHERE `guid` = 202418;                                                                        -- Garm Watcher
UPDATE `creature` SET `spawndist` = 0,`MovementType` = 2,`position_x` = 6464.83, `position_y` = -1637.3, `position_z` = 425.412 WHERE `guid` = 202414; -- Garm Watcher
UPDATE `creature` SET `spawndist` = 0,`MovementType` = 2 WHERE `guid` = 202432;                                                                        -- Snowblind Devotee
DELETE FROM `creature_addon` WHERE `guid` IN (202412,202414,202432,202418);
INSERT INTO `creature_addon` (`guid`, `path_id`, `mount`, `bytes1`, `bytes2`, `emote`, `isLarge`, `auras`)
VALUES
(202412,20241200,0,0,0,0,0,''),
(202414,20241400,0,0,0,0,0,''),
(202432,20243200,0,0,0,0,0,''),
(202418,20241800,0,0,0,0,0,'');

-- Goblin Sapper: Run into Garm cave and explode when near enemies
UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 29555;
DELETE FROM `smart_scripts` WHERE `source_type` = 0 AND `entryorguid` IN (-209153,-209154,-209155,-209156,-209157,-209158);
DELETE FROM `smart_scripts` WHERE `source_type` = 9 AND `entryorguid` = 2955500;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`)
VALUES
(-209153,0,0,0,11,0,100,0,0,0,0,0,0,20,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Goblin Sapper - On Respawn - Disable Auto Attack'),
(-209153,0,1,0,1,0,100,0,1000,30000,0,0,0,53,1,2955500,0,0,0,2,1,0,0,0,0,0,0,0,0,'Goblin Sapper - OOC - Start Waypoint Movement'),
(-209153,0,2,0,9,0,100,0,0,2,0,0,0,80,2955500,2,0,0,0,0,1,0,0,0,0,0,0,0,0,'Goblin Sapper - Victim In Range 0-2 Yards - Call Action List'),
(-209153,0,3,0,58,0,100,0,0,0,0,0,0,80,2955500,2,0,0,0,0,1,0,0,0,0,0,0,0,0,'Goblin Sapper - On Waypoint Path Ended - Call Action List'),

(-209154,0,0,0,11,0,100,0,0,0,0,0,0,20,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Goblin Sapper - On Respawn - Disable Auto Attack'),
(-209154,0,1,0,1,0,100,0,1000,30000,0,0,0,53,1,2955500,0,0,0,2,1,0,0,0,0,0,0,0,0,'Goblin Sapper - OOC - Start Waypoint Movement'),
(-209154,0,2,0,9,0,100,0,0,2,0,0,0,80,2955500,2,0,0,0,0,1,0,0,0,0,0,0,0,0,'Goblin Sapper - Victim In Range 0-2 Yards - Call Action List'),
(-209154,0,3,0,58,0,100,0,0,0,0,0,0,80,2955500,2,0,0,0,0,1,0,0,0,0,0,0,0,0,'Goblin Sapper - On Waypoint Path Ended - Call Action List'),

(-209155,0,0,0,11,0,100,0,0,0,0,0,0,20,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Goblin Sapper - On Respawn - Disable Auto Attack'),
(-209155,0,1,0,1,0,100,0,1000,30000,0,0,0,53,1,2955500,0,0,0,2,1,0,0,0,0,0,0,0,0,'Goblin Sapper - OOC - Start Waypoint Movement'),
(-209155,0,2,0,9,0,100,0,0,2,0,0,0,80,2955500,2,0,0,0,0,1,0,0,0,0,0,0,0,0,'Goblin Sapper - Victim In Range 0-2 Yards - Call Action List'),
(-209155,0,3,0,58,0,100,0,0,0,0,0,0,80,2955500,2,0,0,0,0,1,0,0,0,0,0,0,0,0,'Goblin Sapper - On Waypoint Path Ended - Call Action List'),

(-209156,0,0,0,11,0,100,0,0,0,0,0,0,20,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Goblin Sapper - On Respawn - Disable Auto Attack'),
(-209156,0,1,0,1,0,100,0,1000,30000,0,0,0,53,1,2955500,0,0,0,2,1,0,0,0,0,0,0,0,0,'Goblin Sapper - OOC - Start Waypoint Movement'),
(-209156,0,2,0,9,0,100,0,0,2,0,0,0,80,2955500,2,0,0,0,0,1,0,0,0,0,0,0,0,0,'Goblin Sapper - Victim In Range 0-2 Yards - Call Action List'),
(-209156,0,3,0,58,0,100,0,0,0,0,0,0,80,2955500,2,0,0,0,0,1,0,0,0,0,0,0,0,0,'Goblin Sapper - On Waypoint Path Ended - Call Action List'),

(-209157,0,0,0,11,0,100,0,0,0,0,0,0,20,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Goblin Sapper - On Respawn - Disable Auto Attack'),
(-209157,0,1,0,1,0,100,0,1000,30000,0,0,0,53,1,2955500,0,0,0,2,1,0,0,0,0,0,0,0,0,'Goblin Sapper - OOC - Start Waypoint Movement'),
(-209157,0,2,0,9,0,100,0,0,2,0,0,0,80,2955500,2,0,0,0,0,1,0,0,0,0,0,0,0,0,'Goblin Sapper - Victim In Range 0-2 Yards - Call Action List'),
(-209157,0,3,0,58,0,100,0,0,0,0,0,0,80,2955500,2,0,0,0,0,1,0,0,0,0,0,0,0,0,'Goblin Sapper - On Waypoint Path Ended - Call Action List'),

(-209158,0,0,0,11,0,100,0,0,0,0,0,0,20,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Goblin Sapper - On Respawn - Disable Auto Attack'),
(-209158,0,1,0,1,0,100,0,1000,30000,0,0,0,53,1,2955500,0,0,0,2,1,0,0,0,0,0,0,0,0,'Goblin Sapper - OOC - Start Waypoint Movement'),
(-209158,0,2,0,9,0,100,0,0,2,0,0,0,80,2955500,2,0,0,0,0,1,0,0,0,0,0,0,0,0,'Goblin Sapper - Victim In Range 0-2 Yards - Call Action List'),
(-209158,0,3,0,58,0,100,0,0,0,0,0,0,80,2955500,2,0,0,0,0,1,0,0,0,0,0,0,0,0,'Goblin Sapper - On Waypoint Path Ended - Call Action List'),

(2955500,9,0,0,0,0,100,0,0,0,0,0,0,11,59687,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Goblin Sapper - On Script - Cast ''Explosion'''),
(2955500,9,1,0,0,0,100,0,0,0,0,0,0,41,0,0,0,0,0,0,11,29556,1,0,0,0,0,0,0,'Goblin Sapper - On Script - Despawn (Goblin Sapper Backpack)'),
(2955500,9,2,0,0,0,100,0,0,0,0,0,0,41,5000,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Goblin Sapper - On Script - Despawn After 5 Seconds'),
(2955500,9,3,0,0,0,100,0,1000,1000,0,0,0,37,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Goblin Sapper - On Script - Die');

-- Add missing Snowblind Devotee SAI
DELETE FROM `smart_scripts` WHERE `entryorguid` IN (-152077,-152072,-152079,-152073) AND `source_type` = 0;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`)
VALUES
(-152077,0,0,0,2,0,100,0,0,30,120000,130000,0,11,56410,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Snowblind Devotee - Between 0-30% Health - Cast ''Blind Faith'''),
(-152077,0,1,0,1,0,100,0,2000,3000,2000,3000,0,5,51,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Snowblind Devotee - Out of Combat - Play Emote ''ONESHOT_SPELLCAST'''),

(-152072,0,0,0,2,0,100,0,0,30,120000,130000,0,11,56410,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Snowblind Devotee - Between 0-30% Health - Cast ''Blind Faith'''),
(-152072,0,1,0,1,0,100,0,2000,3000,2000,3000,0,5,51,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Snowblind Devotee - Out of Combat - Play Emote ''ONESHOT_SPELLCAST'''),

(-152079,0,0,0,2,0,100,0,0,30,120000,130000,0,11,56410,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Snowblind Devotee - Between 0-30% Health - Cast ''Blind Faith'''),
(-152079,0,1,0,1,0,100,0,2000,3000,2000,3000,0,5,51,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Snowblind Devotee - Out of Combat - Play Emote ''ONESHOT_SPELLCAST'''),

(-152073,0,0,0,2,0,100,0,0,30,120000,130000,0,11,56410,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Snowblind Devotee - Between 0-30% Health - Cast ''Blind Faith'''),
(-152073,0,1,0,1,0,100,0,2000,3000,2000,3000,0,5,51,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Snowblind Devotee - Out of Combat - Play Emote ''ONESHOT_SPELLCAST''');

-- Fix phasing in Garm
DELETE FROM `spell_area` WHERE `area` = 4421;
INSERT INTO `spell_area` (`spell`, `area`, `quest_start`, `quest_end`, `aura_spell`, `racemask`, `gender`, `autocast`, `quest_start_status`, `quest_end_status`)
VALUES
(54635,4421,12822,0,0,0,2,1,74,0);

UPDATE `creature` SET `phaseMask` = 2 WHERE `id` = 29999;     -- Cave Explosion Bunny
UPDATE `gameobject` SET `phaseMask` = 3 WHERE `guid` = 56766; -- Frostgut's Altar
UPDATE `creature` SET `phaseMask` = 3 WHERE `guid` = 152091;  -- Garm Watcher
UPDATE `creature` SET `phaseMask` = 3 WHERE `guid` = 152092;  -- Garm Watcher

-- Gino waypoint movement
SET @POINT := 0;
DELETE FROM `waypoint_data` WHERE `id` = 203829;
INSERT INTO `waypoint_data` (`id`, `point`, `position_x`, `position_y`, `position_z`, `orientation`, `delay`, `move_type`, `action`, `action_chance`, `wpguid`)
VALUES
(203829,@POINT := @POINT + 1,6321.47,-1738.69,457.084,0,0,0,0,100,0),
(203829,@POINT := @POINT + 1,6322.6,-1746.3,457.709,0,0,0,0,100,0),
(203829,@POINT := @POINT + 1,6326.16,-1749.07,458.459,0,60000,0,1133,100,0),
(203829,@POINT := @POINT + 1,6320.99,-1727.97,456.09,0,0,0,0,100,0),
(203829,@POINT := @POINT + 1,6321.51,-1713.54,455.509,0,1000,0,1134,100,0),
(203829,@POINT := @POINT + 1,6321.51,-1713.54,455.509,0,60000,0,1135,100,0);

DELETE FROM `waypoint_scripts` WHERE `id` BETWEEN 1133 AND 1135;
INSERT INTO `waypoint_scripts` (`id`, `delay`, `command`, `datalong`, `datalong2`, `dataint`, `x`, `y`, `z`, `o`, `guid`)
VALUES
(1133,0,30,0,0,0,0,0,0,4.08361,696),
(1134,0,30,0,0,0,0,0,0,0.104771,697),
(1135,0,1,1,0,0,0,0,0,0,698);

-- Tormar Frostgut waypoint movement
SET @POINT := 0;
DELETE FROM `waypoints` WHERE `entry` = 29626;
INSERT INTO `waypoints` (`entry`, `pointid`, `position_x`, `position_y`, `position_z`, `point_comment`)
VALUES
(29626,@POINT := @POINT + 1,6450.07,-1730.54,481.072,'Tormar Frostgut'),
(29626,@POINT := @POINT + 1,6454.98,-1734.05,481.898,''),
(29626,@POINT := @POINT + 1,6459.59,-1737.34,484.043,''),
(29626,@POINT := @POINT + 1,6461.15,-1738.46,484.48,''),
(29626,@POINT := @POINT + 1,6468.11,-1741.17,486.465,''),
(29626,@POINT := @POINT + 1,6477.17,-1744.23,487.096,''),
(29626,@POINT := @POINT + 1,6485.93,-1746.22,487.792,''),
(29626,@POINT := @POINT + 1,6495.36,-1746.14,489.513,'');

-- Goblin Sapper waypoint path
SET @POINT := 0;
DELETE FROM `waypoints` WHERE `entry` = 2955500;
INSERT INTO `waypoints` (`entry`, `pointid`, `position_x`, `position_y`, `position_z`, `point_comment`)
VALUES
(2955500,@POINT := @POINT + 1,6272.38,-1598.42,423.442,'Goblin Sapper'),
(2955500,@POINT := @POINT + 1,6282.42,-1594.98,424.872,''),
(2955500,@POINT := @POINT + 1,6293.28,-1592.27,425.002,''),
(2955500,@POINT := @POINT + 1,6305.98,-1588.77,424.457,''),
(2955500,@POINT := @POINT + 1,6318.92,-1584.83,425.138,''),
(2955500,@POINT := @POINT + 1,6329.35,-1584,425.437,''),
(2955500,@POINT := @POINT + 1,6339.57,-1584.85,425.163,''),
(2955500,@POINT := @POINT + 1,6349.23,-1588.58,428.443,''),
(2955500,@POINT := @POINT + 1,6359,-1593.78,427.067,''),
(2955500,@POINT := @POINT + 1,6368.28,-1600.04,423.786,''),
(2955500,@POINT := @POINT + 1,6376.83,-1606.72,420.207,''),
(2955500,@POINT := @POINT + 1,6386.05,-1614.59,418.733,''),
(2955500,@POINT := @POINT + 1,6393.03,-1623.59,418.229,''),
(2955500,@POINT := @POINT + 1,6400.62,-1632.87,418.539,''),
(2955500,@POINT := @POINT + 1,6411.01,-1638.04,419.292,''),
(2955500,@POINT := @POINT + 1,6422.29,-1638.02,418.993,''),
(2955500,@POINT := @POINT + 1,6434.9,-1635.69,418.54,''),
(2955500,@POINT := @POINT + 1,6446.77,-1635.18,418.54,''),
(2955500,@POINT := @POINT + 1,6459.66,-1637.91,424.067,''),
(2955500,@POINT := @POINT + 1,6465.12,-1639.16,425.64,''),
(2955500,@POINT := @POINT + 1,6468.73,-1641.3,426.709,''),
(2955500,@POINT := @POINT + 1,6470.61,-1645.3,428.206,''),
(2955500,@POINT := @POINT + 1,6469.99,-1650.96,430.413,''),
(2955500,@POINT := @POINT + 1,6465.68,-1655.19,432.279,''),
(2955500,@POINT := @POINT + 1,6460.28,-1659.65,434.123,''),
(2955500,@POINT := @POINT + 1,6455.05,-1664.59,435.955,''),
(2955500,@POINT := @POINT + 1,6450.72,-1671.92,435.908,''),
(2955500,@POINT := @POINT + 1,6447.04,-1678.69,435.85,''),
(2955500,@POINT := @POINT + 1,6443.22,-1685.77,435.698,''),
(2955500,@POINT := @POINT + 1,6439.69,-1693.13,435.558,''),
(2955500,@POINT := @POINT + 1,6436.61,-1701.42,435.354,''),
(2955500,@POINT := @POINT + 1,6437.65,-1708.23,435.143,''),
(2955500,@POINT := @POINT + 1,6440.81,-1713.39,434.906,''),
(2955500,@POINT := @POINT + 1,6445.5,-1719.78,435.27,''),
(2955500,@POINT := @POINT + 1,6450.69,-1726.96,435.339,''),
(2955500,@POINT := @POINT + 1,6455.46,-1733.44,435.255,''),
(2955500,@POINT := @POINT + 1,6460.82,-1739.59,434.373,''),
(2955500,@POINT := @POINT + 1,6467.05,-1745.22,434.115,''),
(2955500,@POINT := @POINT + 1,6475.03,-1748.13,434.69,''),
(2955500,@POINT := @POINT + 1,6483.06,-1750.11,435.193,''),
(2955500,@POINT := @POINT + 1,6490.36,-1750.57,435.36,''),
(2955500,@POINT := @POINT + 1,6498.3,-1749.28,435.549,''),
(2955500,@POINT := @POINT + 1,6505.54,-1746.45,435.806,''),
(2955500,@POINT := @POINT + 1,6513.4,-1742.87,435.929,''),
(2955500,@POINT := @POINT + 1,6520.67,-1738.07,436.13,''),
(2955500,@POINT := @POINT + 1,6526.04,-1732.45,436.617,''),
(2955500,@POINT := @POINT + 1,6529.72,-1725.31,438.323,''),
(2955500,@POINT := @POINT + 1,6532.19,-1718.28,440.431,''),
(2955500,@POINT := @POINT + 1,6533.88,-1712.21,442.19,'');

-- Garm Watcher waypoint movement
SET @POINT := 0;
DELETE FROM `waypoint_data` WHERE `id` = 20241200;
INSERT INTO `waypoint_data` (`id`, `point`, `position_x`, `position_y`, `position_z`, `orientation`, `delay`, `move_type`, `action`, `action_chance`, `wpguid`)
VALUES
(20241200,@POINT := @POINT + 1,6366.62,-1602.65,423.721,0,1000,0,0,100,0),
(20241200,@POINT := @POINT + 1,6372.84,-1605.61,421.734,0,0,0,0,100,0),
(20241200,@POINT := @POINT + 1,6380.53,-1610,419.393,0,0,0,0,100,0),
(20241200,@POINT := @POINT + 1,6386.97,-1615.72,418.459,0,0,0,0,100,0),
(20241200,@POINT := @POINT + 1,6394.19,-1621.21,418.329,0,0,0,0,100,0),
(20241200,@POINT := @POINT + 1,6402.65,-1625.77,418.402,0,0,0,0,100,0),
(20241200,@POINT := @POINT + 1,6411.25,-1628.99,418.538,0,0,0,0,100,0),
(20241200,@POINT := @POINT + 1,6420.55,-1631.45,418.538,0,0,0,0,100,0),
(20241200,@POINT := @POINT + 1,6430.43,-1633.31,418.538,0,0,0,0,100,0),
(20241200,@POINT := @POINT + 1,6439.61,-1634.82,418.538,0,0,0,0,100,0),
(20241200,@POINT := @POINT + 1,6447.88,-1635.64,418.538,0,0,0,0,100,0),
(20241200,@POINT := @POINT + 1,6455.74,-1636.03,421.25,0,1000,0,0,100,0),
(20241200,@POINT := @POINT + 1,6447.88,-1635.64,418.538,0,0,0,0,100,0),
(20241200,@POINT := @POINT + 1,6439.61,-1634.82,418.538,0,0,0,0,100,0),
(20241200,@POINT := @POINT + 1,6430.43,-1633.31,418.538,0,0,0,0,100,0),
(20241200,@POINT := @POINT + 1,6420.55,-1631.45,418.538,0,0,0,0,100,0),
(20241200,@POINT := @POINT + 1,6411.25,-1628.99,418.538,0,0,0,0,100,0),
(20241200,@POINT := @POINT + 1,6402.65,-1625.77,418.402,0,0,0,0,100,0),
(20241200,@POINT := @POINT + 1,6394.19,-1621.21,418.329,0,0,0,0,100,0),
(20241200,@POINT := @POINT + 1,6386.97,-1615.72,418.459,0,0,0,0,100,0),
(20241200,@POINT := @POINT + 1,6380.53,-1610,419.393,0,0,0,0,100,0),
(20241200,@POINT := @POINT + 1,6372.84,-1605.61,421.734,0,0,0,0,100,0);

-- Garm Watcher waypoint movement
SET @POINT := 0;
DELETE FROM `waypoint_data` WHERE `id` = 20241400;
INSERT INTO `waypoint_data` (`id`, `point`, `position_x`, `position_y`, `position_z`, `orientation`, `delay`, `move_type`, `action`, `action_chance`, `wpguid`)
VALUES
(20241400,@POINT := @POINT + 1,6464.83,-1637.3,425.412,0,1000,0,0,100,0),
(20241400,@POINT := @POINT + 1,6470.97,-1640.89,426.886,0,0,0,0,100,0),
(20241400,@POINT := @POINT + 1,6472,-1646.27,428.936,0,0,0,0,100,0),
(20241400,@POINT := @POINT + 1,6468.4,-1652.36,430.889,0,0,0,0,100,0),
(20241400,@POINT := @POINT + 1,6462.7,-1657.53,433.544,0,0,0,0,100,0),
(20241400,@POINT := @POINT + 1,6456.28,-1664.14,435.482,0,0,0,0,100,0),
(20241400,@POINT := @POINT + 1,6450.43,-1671.25,435.958,0,0,0,0,100,0),
(20241400,@POINT := @POINT + 1,6445.6,-1680.55,435.852,0,0,0,0,100,0),
(20241400,@POINT := @POINT + 1,6441.72,-1689.17,435.643,0,0,0,0,100,0),
(20241400,@POINT := @POINT + 1,6439.56,-1699.13,435.428,0,0,0,0,100,0),
(20241400,@POINT := @POINT + 1,6441.27,-1709.02,435.339,0,0,0,0,100,0),
(20241400,@POINT := @POINT + 1,6445.61,-1718.57,435.361,0,0,0,0,100,0),
(20241400,@POINT := @POINT + 1,6450.91,-1728.04,435.324,0,0,0,0,100,0),
(20241400,@POINT := @POINT + 1,6458.23,-1736.4,434.824,0,0,0,0,100,0),
(20241400,@POINT := @POINT + 1,6467.87,-1743.33,434.628,0,0,0,0,100,0),
(20241400,@POINT := @POINT + 1,6478.03,-1747.64,435.053,0,0,0,0,100,0),
(20241400,@POINT := @POINT + 1,6488.46,-1749.28,435.357,0,0,0,0,100,0),
(20241400,@POINT := @POINT + 1,6500.38,-1747.37,435.667,0,0,0,0,100,0),
(20241400,@POINT := @POINT + 1,6509.76,-1743.02,435.843,0,0,0,0,100,0),
(20241400,@POINT := @POINT + 1,6521.4,-1735.27,436.277,0,0,0,0,100,0),
(20241400,@POINT := @POINT + 1,6527.57,-1728.36,437.331,0,1000,0,0,100,0),
(20241400,@POINT := @POINT + 1,6521.4,-1735.27,436.277,0,0,0,0,100,0),
(20241400,@POINT := @POINT + 1,6509.76,-1743.02,435.843,0,0,0,0,100,0),
(20241400,@POINT := @POINT + 1,6500.38,-1747.37,435.667,0,0,0,0,100,0),
(20241400,@POINT := @POINT + 1,6488.46,-1749.28,435.357,0,0,0,0,100,0),
(20241400,@POINT := @POINT + 1,6478.03,-1747.64,435.053,0,0,0,0,100,0),
(20241400,@POINT := @POINT + 1,6467.87,-1743.33,434.628,0,0,0,0,100,0),
(20241400,@POINT := @POINT + 1,6458.23,-1736.4,434.824,0,0,0,0,100,0),
(20241400,@POINT := @POINT + 1,6450.91,-1728.04,435.324,0,0,0,0,100,0),
(20241400,@POINT := @POINT + 1,6445.61,-1718.57,435.361,0,0,0,0,100,0),
(20241400,@POINT := @POINT + 1,6441.27,-1709.02,435.339,0,0,0,0,100,0),
(20241400,@POINT := @POINT + 1,6439.56,-1699.13,435.428,0,0,0,0,100,0),
(20241400,@POINT := @POINT + 1,6441.72,-1689.17,435.643,0,0,0,0,100,0),
(20241400,@POINT := @POINT + 1,6445.6,-1680.55,435.852,0,0,0,0,100,0),
(20241400,@POINT := @POINT + 1,6450.43,-1671.25,435.958,0,0,0,0,100,0),
(20241400,@POINT := @POINT + 1,6456.28,-1664.14,435.482,0,0,0,0,100,0),
(20241400,@POINT := @POINT + 1,6462.7,-1657.53,433.544,0,0,0,0,100,0),
(20241400,@POINT := @POINT + 1,6468.4,-1652.36,430.889,0,0,0,0,100,0),
(20241400,@POINT := @POINT + 1,6472,-1646.27,428.936,0,0,0,0,100,0),
(20241400,@POINT := @POINT + 1,6470.97,-1640.89,426.886,0,0,0,0,100,0);

-- Garm Watcher waypoint movement
SET @POINT := 0;
DELETE FROM `waypoint_data` WHERE `id` = 20241800;
INSERT INTO `waypoint_data` (`id`, `point`, `position_x`, `position_y`, `position_z`, `orientation`, `delay`, `move_type`, `action`, `action_chance`, `wpguid`)
VALUES
(20241800,@POINT := @POINT + 1,6502.19,-1743.21,490.453,0,1000,0,0,100,0),
(20241800,@POINT := @POINT + 1,6495.33,-1744.65,489.529,0,0,0,0,100,0),
(20241800,@POINT := @POINT + 1,6486.32,-1745.81,487.853,0,0,0,0,100,0),
(20241800,@POINT := @POINT + 1,6476.91,-1744.21,487.079,0,0,0,0,100,0),
(20241800,@POINT := @POINT + 1,6466.42,-1740.31,486.043,0,0,0,0,100,0),
(20241800,@POINT := @POINT + 1,6456.42,-1734.82,482.538,0,0,0,0,100,0),
(20241800,@POINT := @POINT + 1,6448.65,-1727.67,480.735,0,0,0,0,100,0),
(20241800,@POINT := @POINT + 1,6444.01,-1716.64,478.178,0,0,0,0,100,0),
(20241800,@POINT := @POINT + 1,6441.22,-1704.38,476.383,0,0,0,0,100,0),
(20241800,@POINT := @POINT + 1,6441.47,-1693.55,472.755,0,0,0,0,100,0),
(20241800,@POINT := @POINT + 1,6443.34,-1683.38,471.745,0,0,0,0,100,0),
(20241800,@POINT := @POINT + 1,6448.34,-1673.27,469.668,0,1000,0,0,100,0),
(20241800,@POINT := @POINT + 1,6443.34,-1683.38,471.745,0,0,0,0,100,0),
(20241800,@POINT := @POINT + 1,6441.47,-1693.55,472.755,0,0,0,0,100,0),
(20241800,@POINT := @POINT + 1,6441.22,-1704.38,476.383,0,0,0,0,100,0),
(20241800,@POINT := @POINT + 1,6444.01,-1716.64,478.178,0,0,0,0,100,0),
(20241800,@POINT := @POINT + 1,6448.65,-1727.67,480.735,0,0,0,0,100,0),
(20241800,@POINT := @POINT + 1,6456.42,-1734.82,482.538,0,0,0,0,100,0),
(20241800,@POINT := @POINT + 1,6466.42,-1740.31,486.043,0,0,0,0,100,0),
(20241800,@POINT := @POINT + 1,6476.91,-1744.21,487.079,0,0,0,0,100,0),
(20241800,@POINT := @POINT + 1,6486.32,-1745.81,487.853,0,0,0,0,100,0),
(20241800,@POINT := @POINT + 1,6495.33,-1744.65,489.529,0,0,0,0,100,0),
(20241800,@POINT := @POINT + 1,6502.19,-1743.21,490.453,0,0,0,0,100,0);

-- Snowblind Devotee waypoint movement
SET @POINT := 0;
DELETE FROM `waypoint_data` WHERE `id` = 20243200;
INSERT INTO `waypoint_data` (`id`, `point`, `position_x`, `position_y`, `position_z`, `orientation`, `delay`, `move_type`, `action`, `action_chance`, `wpguid`)
VALUES
(20243200,@POINT := @POINT + 1,6467.51,-1653.9,466.434,0,1000,0,0,100,0),
(20243200,@POINT := @POINT + 1,6474.4,-1652.68,465.736,0,0,0,0,100,0),
(20243200,@POINT := @POINT + 1,6482.63,-1651.03,464.416,0,0,0,0,100,0),
(20243200,@POINT := @POINT + 1,6492.02,-1648.64,462.153,0,0,0,0,100,0),
(20243200,@POINT := @POINT + 1,6501.34,-1647.88,460.031,0,0,0,0,100,0),
(20243200,@POINT := @POINT + 1,6510.32,-1650.3,458.2,0,0,0,0,100,0),
(20243200,@POINT := @POINT + 1,6518.13,-1654.58,456.014,0,0,0,0,100,0),
(20243200,@POINT := @POINT + 1,6525.47,-1661.88,455.09,0,0,0,0,100,0),
(20243200,@POINT := @POINT + 1,6529.6,-1670.43,453.983,0,0,0,0,100,0),
(20243200,@POINT := @POINT + 1,6532.05,-1680.61,452.181,0,0,0,0,100,0),
(20243200,@POINT := @POINT + 1,6533.18,-1690.69,449.465,0,0,0,0,100,0),
(20243200,@POINT := @POINT + 1,6533.14,-1701.06,446.341,0,0,0,0,100,0),
(20243200,@POINT := @POINT + 1,6531.36,-1712.34,442.139,0,0,0,0,100,0),
(20243200,@POINT := @POINT + 1,6528.71,-1722.12,439.295,0,0,0,0,100,0),
(20243200,@POINT := @POINT + 1,6523.5,-1731.61,436.583,0,0,0,0,100,0),
(20243200,@POINT := @POINT + 1,6516.99,-1738.18,436.094,0,0,0,0,100,0),
(20243200,@POINT := @POINT + 1,6507.78,-1743.19,435.805,0,0,0,0,100,0),
(20243200,@POINT := @POINT + 1,6497.86,-1746.93,435.578,0,0,0,0,100,0),
(20243200,@POINT := @POINT + 1,6487.45,-1748.4,435.357,0,0,0,0,100,0),
(20243200,@POINT := @POINT + 1,6476.87,-1746.07,435.09,0,0,0,0,100,0),
(20243200,@POINT := @POINT + 1,6466.35,-1741.5,434.742,0,0,0,0,100,0),
(20243200,@POINT := @POINT + 1,6457.97,-1733.76,435.292,0,0,0,0,100,0),
(20243200,@POINT := @POINT + 1,6450.57,-1725.68,435.347,0,0,0,0,100,0),
(20243200,@POINT := @POINT + 1,6444.91,-1715.89,435.364,0,0,0,0,100,0),
(20243200,@POINT := @POINT + 1,6441.73,-1707.02,435.364,0,0,0,0,100,0),
(20243200,@POINT := @POINT + 1,6440.73,-1697.83,435.451,0,0,0,0,100,0),
(20243200,@POINT := @POINT + 1,6443.66,-1687.93,435.65,0,0,0,0,100,0),
(20243200,@POINT := @POINT + 1,6447.3,-1680.37,435.773,0,0,0,0,100,0),
(20243200,@POINT := @POINT + 1,6450.85,-1672.88,435.851,0,0,0,0,100,0),
(20243200,@POINT := @POINT + 1,6455.59,-1664.32,435.724,0,0,0,0,100,0),
(20243200,@POINT := @POINT + 1,6461.37,-1657.93,433.769,0,0,0,0,100,0),
(20243200,@POINT := @POINT + 1,6467.62,-1652.32,430.883,0,0,0,0,100,0),
(20243200,@POINT := @POINT + 1,6473.59,-1646.94,429.269,0,0,0,0,100,0),
(20243200,@POINT := @POINT + 1,6478.46,-1641.58,427.914,0,0,0,0,100,0),
(20243200,@POINT := @POINT + 1,6484.59,-1638.73,428.369,0,0,0,0,100,0),
(20243200,@POINT := @POINT + 1,6492.65,-1634.78,428.12,0,0,0,0,100,0),
(20243200,@POINT := @POINT + 1,6499.1,-1634.24,427.63,0,0,0,0,100,0),
(20243200,@POINT := @POINT + 1,6507.66,-1636.37,426.775,0,1000,0,0,100,0),
(20243200,@POINT := @POINT + 1,6499.1,-1634.24,427.63,0,0,0,0,100,0),
(20243200,@POINT := @POINT + 1,6492.65,-1634.78,428.12,0,0,0,0,100,0),
(20243200,@POINT := @POINT + 1,6484.59,-1638.73,428.369,0,0,0,0,100,0),
(20243200,@POINT := @POINT + 1,6478.46,-1641.58,427.914,0,0,0,0,100,0),
(20243200,@POINT := @POINT + 1,6473.59,-1646.94,429.269,0,0,0,0,100,0),
(20243200,@POINT := @POINT + 1,6467.62,-1652.32,430.883,0,0,0,0,100,0),
(20243200,@POINT := @POINT + 1,6461.37,-1657.93,433.769,0,0,0,0,100,0),
(20243200,@POINT := @POINT + 1,6455.59,-1664.32,435.724,0,0,0,0,100,0),
(20243200,@POINT := @POINT + 1,6450.85,-1672.88,435.851,0,0,0,0,100,0),
(20243200,@POINT := @POINT + 1,6447.3,-1680.37,435.773,0,0,0,0,100,0),
(20243200,@POINT := @POINT + 1,6443.66,-1687.93,435.65,0,0,0,0,100,0),
(20243200,@POINT := @POINT + 1,6440.73,-1697.83,435.451,0,0,0,0,100,0),
(20243200,@POINT := @POINT + 1,6441.73,-1707.02,435.364,0,0,0,0,100,0),
(20243200,@POINT := @POINT + 1,6444.91,-1715.89,435.364,0,0,0,0,100,0),
(20243200,@POINT := @POINT + 1,6450.57,-1725.68,435.347,0,0,0,0,100,0),
(20243200,@POINT := @POINT + 1,6457.97,-1733.76,435.292,0,0,0,0,100,0),
(20243200,@POINT := @POINT + 1,6466.35,-1741.5,434.742,0,0,0,0,100,0),
(20243200,@POINT := @POINT + 1,6476.87,-1746.07,435.09,0,0,0,0,100,0),
(20243200,@POINT := @POINT + 1,6487.45,-1748.4,435.357,0,0,0,0,100,0),
(20243200,@POINT := @POINT + 1,6497.86,-1746.93,435.578,0,0,0,0,100,0),
(20243200,@POINT := @POINT + 1,6507.78,-1743.19,435.805,0,0,0,0,100,0),
(20243200,@POINT := @POINT + 1,6516.99,-1738.18,436.094,0,0,0,0,100,0),
(20243200,@POINT := @POINT + 1,6523.5,-1731.61,436.583,0,0,0,0,100,0),
(20243200,@POINT := @POINT + 1,6528.71,-1722.12,439.295,0,0,0,0,100,0),
(20243200,@POINT := @POINT + 1,6531.36,-1712.34,442.139,0,0,0,0,100,0),
(20243200,@POINT := @POINT + 1,6533.14,-1701.06,446.341,0,0,0,0,100,0),
(20243200,@POINT := @POINT + 1,6533.18,-1690.69,449.465,0,0,0,0,100,0),
(20243200,@POINT := @POINT + 1,6532.05,-1680.61,452.181,0,0,0,0,100,0),
(20243200,@POINT := @POINT + 1,6529.6,-1670.43,453.983,0,0,0,0,100,0),
(20243200,@POINT := @POINT + 1,6525.47,-1661.88,455.09,0,0,0,0,100,0),
(20243200,@POINT := @POINT + 1,6518.13,-1654.58,456.014,0,0,0,0,100,0),
(20243200,@POINT := @POINT + 1,6510.32,-1650.3,458.2,0,0,0,0,100,0),
(20243200,@POINT := @POINT + 1,6501.34,-1647.88,460.031,0,0,0,0,100,0),
(20243200,@POINT := @POINT + 1,6492.02,-1648.64,462.153,0,0,0,0,100,0),
(20243200,@POINT := @POINT + 1,6482.63,-1651.03,464.416,0,0,0,0,100,0),
(20243200,@POINT := @POINT + 1,6474.4,-1652.68,465.736,0,0,0,0,100,0);

--
-- END UPDATING QUERIES
--
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
