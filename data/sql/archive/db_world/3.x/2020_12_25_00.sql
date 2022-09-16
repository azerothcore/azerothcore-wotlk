-- DB update 2020_12_24_01 -> 2020_12_25_00
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2020_12_24_01';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2020_12_24_01 2020_12_25_00 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1601870525065182700'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1601981411342865100');

-- ULDUAR SHIELD BUNNY
UPDATE `creature_template` SET `InhabitType`=4, `AIName`='SmartAI' WHERE `entry`=33779;

DELETE FROM `creature` WHERE (`id` = 33779);
INSERT INTO `creature` (`guid`, `id`, `map`, `zoneId`, `areaId`, `spawnMask`, `phaseMask`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `wander_distance`, `currentwaypoint`, `curhealth`, `curmana`, `MovementType`, `npcflag`, `unit_flags`, `dynamicflags`, `ScriptName`, `VerifiedBuild`) VALUES
(137509, 33779, 603, 0, 0, 3, 1, 0, 0, -689.106, -50.0527, 428.213, 0, 180, 0, 0, 1, 0, 0, 0, 0, 0, '', 0),
(137510, 33779, 603, 0, 0, 3, 1, 0, 0, -666.392, -4.951, 518.596, 0, 120, 0, 0, 1, 0, 0, 0, 0, 0, '', 0),
(137511, 33779, 603, 0, 0, 3, 1, 0, 0, -642.508, -101.339, 518.981, 0, 120, 0, 0, 1, 0, 0, 0, 0, 0, '', 0);

DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = -137509);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(-137509, 0, 0, 0, 38, 0, 100, 0, 0, 1, 0, 0, 0, 11, 63660, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Ulduar Shield Bunny - On Data Set 0 1 - Cast \'Empowered Arcane Explosion\'');

-- Kirin Tor Battle-Mage
UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 33662;

DELETE FROM `creature` WHERE (`id` = 33662);
INSERT INTO `creature` (`guid`, `id`, `map`, `zoneId`, `areaId`, `spawnMask`, `phaseMask`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `wander_distance`, `currentwaypoint`, `curhealth`, `curmana`, `MovementType`, `npcflag`, `unit_flags`, `dynamicflags`, `ScriptName`, `VerifiedBuild`) VALUES
(137508, 33662, 603, 0, 0, 3, 1, 28886, 1, -673.059, -77.446, 426.35, 5.35086, 604800, 0, 0, 1, 0, 0, 0, 0, 0, '', 0),
(137507, 33662, 603, 0, 0, 3, 1, 28886, 1, -675.671, -19.437, 426.35, 1.30916, 604800, 0, 0, 1, 0, 0, 0, 0, 0, '', 0),
(136529, 33662, 603, 0, 0, 3, 1, 28780, 1, -800.668, -233.616, 429.967, 4.62572, 180, 5, 0, 75600, 39940, 1, 0, 0, 0, '', 0),
(136530, 33662, 603, 0, 0, 3, 1, 28886, 1, -775.323, -158.514, 429.821, 0.836248, 180, 0, 0, 75600, 39940, 0, 0, 0, 0, '', 0),
(136527, 33662, 603, 0, 0, 3, 1, 28886, 1, -704.212, -94.6969, 430.024, 2.44346, 180, 0, 0, 75600, 39940, 0, 0, 0, 0, '', 0),
(136524, 33662, 603, 0, 0, 3, 1, 28884, 1, -718.091, -60.1257, 429.924, 0.959931, 180, 0, 0, 75600, 39940, 0, 0, 0, 0, '', 0),
(136523, 33662, 603, 0, 0, 3, 1, 28886, 1, -815.095, -204.22, 429.841, 1.55333, 180, 0, 0, 75600, 39940, 0, 0, 0, 0, '', 0),
(136522, 33662, 603, 0, 0, 3, 1, 28885, 1, -752.114, -102.089, 429.714, 6.17846, 180, 0, 0, 75600, 39940, 0, 0, 0, 0, '', 0),
(136521, 33662, 603, 0, 0, 3, 1, 28885, 1, -786.215, -84.7696, 429.792, 1.44862, 180, 0, 0, 75600, 39940, 0, 0, 0, 0, '', 0);

DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = -137508);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(-137508, 0, 0, 0, 1, 0, 100, 1, 500, 500, 500, 500, 0, 11, 48310, 0, 0, 0, 0, 0, 10, 137511, 33779, 0, 0, 0, 0, 0, 0, 'Kirin Tor Battle-Mage - Out of Combat - Cast \'Transitus Shield Beam\' (No Repeat)'),
(-137508, 0, 1, 2, 38, 0, 100, 0, 0, 1, 0, 0, 0, 69, 1, 0, 0, 0, 0, 0, 8, 0, 0, 0, 0, -673.399, -87.85, 426.51, 0.021254, 'Kirin Tor Battle-Mage - On Data Set 0 1 - Move To Position'),
(-137508, 0, 2, 0, 61, 0, 100, 0, 0, 1, 0, 0, 0, 41, 0, 0, 0, 0, 0, 0, 10, 137511, 33779, 0, 0, 0, 0, 0, 0, 'Kirin Tor Battle-Mage - On Data Set 0 1 - Despawn Instant'),
(-137508, 0, 3, 0, 34, 0, 100, 0, 0, 1, 0, 0, 0, 66, 0, 0, 0, 0, 0, 0, 8, 0, 0, 0, 0, 0, 0, 0, 6.2797, 'Kirin Tor Battle-Mage - On Reached Point 1 - Set Orientation 6.2797'),
(-137508, 0, 4, 0, 60, 0, 100, 1, 0, 0, 0, 0, 0, 62, 603, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, -673.399, -87.85, 426.51, 6.2797, 'Kirin Tor Battle-Mage - On Update - Teleport (No Repeat)');

DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = -137507);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(-137507, 0, 0, 0, 1, 0, 100, 1, 500, 500, 500, 500, 0, 11, 48310, 0, 0, 0, 0, 0, 10, 137510, 33779, 0, 0, 0, 0, 0, 0, 'Kirin Tor Battle-Mage - Out of Combat - Cast \'Transitus Shield Beam\' (No Repeat)'),
(-137507, 0, 1, 2, 38, 0, 100, 0, 0, 1, 0, 0, 0, 69, 1, 0, 0, 0, 0, 0, 8, 0, 0, 0, 0, -674.524, -2.496, 425.95, 0.042202, 'Kirin Tor Battle-Mage - On Data Set 0 1 - Move To Position'),
(-137507, 0, 2, 0, 61, 0, 100, 0, 0, 1, 0, 0, 0, 41, 0, 0, 0, 0, 0, 0, 10, 137510, 33779, 0, 0, 0, 0, 0, 0, 'Kirin Tor Battle-Mage - On Data Set 0 1 - Despawn Instant'),
(-137507, 0, 3, 0, 34, 0, 100, 0, 0, 1, 0, 0, 0, 66, 0, 0, 0, 0, 0, 0, 8, 0, 0, 0, 0, 0, 0, 0, 6.2797, 'Kirin Tor Battle-Mage - On Reached Point 1 - Set Orientation 6.2797'),
(-137507, 0, 4, 0, 60, 0, 100, 1, 0, 0, 0, 0, 0, 62, 603, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, -674.524, -2.496, 425.95, 6.2797, 'Kirin Tor Battle-Mage - On Update - Teleport (No Repeat)');

DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = -136524);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(-136524, 0, 0, 0, 38, 0, 100, 0, 1, 1, 0, 0, 0, 29, 1, 135, 0, 0, 0, 0, 10, 136281, 33624, 0, 0, 0, 0, 0, 0, 'Kirin Tor Battle-Mage - On Data Set 1 1 - Start Follow Closest Creature \'Archmage Pentarus\''),
(-136524, 0, 1, 0, 60, 0, 100, 1, 0, 0, 0, 0, 0, 62, 603, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, -679.573, -82.066, 427.233, 0.054839, 'Kirin Tor Battle-Mage - On Update - Teleport (No Repeat)');

DELETE FROM `conditions` WHERE (`SourceEntry` = -136524) AND (`SourceTypeOrReferenceId` = 22) AND (`SourceGroup` = 2);
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `ErrorType`, `ErrorTextId`, `ScriptName`, `Comment`) VALUES
(22, 2, -136524, 0, 0, 13, 1, 800, 3, 0, 0, 0, 0, '', '');

DELETE FROM `conditions` WHERE (`SourceEntry` IN (-137507,-137508)) AND (`SourceTypeOrReferenceId` = 22) AND (`SourceGroup` IN (1,5));
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `ErrorType`, `ErrorTextId`, `ScriptName`, `Comment`) VALUES
(22, 1, -137507, 0, 0, 13, 1, 800, 0, 0, 0, 0, 0, '', ''),
(22, 1, -137508, 0, 0, 13, 1, 800, 0, 0, 0, 0, 0, '', ''),
(22, 5, -137507, 0, 0, 13, 1, 800, 3, 0, 0, 0, 0, '', ''),
(22, 5, -137508, 0, 0, 13, 1, 800, 3, 0, 0, 0, 0, '', '');

DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = -136527);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(-136527, 0, 0, 0, 10, 0, 100, 1, 1, 20, 0, 0, 1, 80, 3366200, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Kirin Tor Battle-Mage - Within 1-20 Range Out of Combat LoS - Run Script (No Repeat)'),
(-136527, 0, 1, 0, 10, 0, 100, 0, 1, 20, 90000, 120000, 1, 80, 3366200, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Kirin Tor Battle-Mage - Within 1-20 Range Out of Combat LoS - Run Script');

DELETE FROM `smart_scripts` WHERE (`source_type` = 9 AND `entryorguid` = 3369600); -- This has a invalid guid, it has Archmage Rhydian guid but it is for Kirin Tor Battle-Mage

DELETE FROM `smart_scripts` WHERE (`source_type` = 9 AND `entryorguid` = 3366200);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(3366200, 9, 0, 0, 0, 0, 100, 0, 5000, 5000, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Kirin Tor Battle-Mage - Script - Say Line 0'),
(3366200, 9, 1, 0, 0, 0, 100, 0, 5000, 5000, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 19, 33626, 0, 0, 0, 0, 0, 0, 0, 'Kirin Tor Battle-Mage - Script - Say Line 0 (Hired Engineer)'),
(3366200, 9, 2, 0, 0, 0, 100, 0, 7000, 7000, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Kirin Tor Battle-Mage - Script - Say Line 1'),
(3366200, 9, 3, 0, 0, 0, 100, 0, 10000, 10000, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 19, 33626, 0, 0, 0, 0, 0, 0, 0, 'Kirin Tor Battle-Mage - Script - Say Line 1 (Hired Engineer)');

DELETE FROM `conditions` WHERE (`SourceTypeOrReferenceId` = 22) AND (`SourceGroup` = 1) AND (`SourceEntry` = 136527);
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `ErrorType`, `ErrorTextId`, `ScriptName`, `Comment`) VALUES
(22, 1, 136527, 0, 0, 13, 0, 0, 0, 0, 1, 0, 0, '', 'Kirin Tor Battle-Mage - Base Camp Transporter');

DELETE FROM `conditions` WHERE (`SourceTypeOrReferenceId` = 22) AND (`SourceGroup` = 2) AND (`SourceEntry` = 136527);
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `ErrorType`, `ErrorTextId`, `ScriptName`, `Comment`) VALUES
(22, 2, 136527, 0, 0, 13, 0, 0, 0, 0, 1, 0, 0, '', '');

DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = -136523);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(-136523, 0, 0, 0, 60, 0, 100, 1, 0, 0, 0, 0, 0, 11, 39550, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Kirin Tor Battle-Mage - On Update - Cast \'Arcane Channeling\' (No Repeat)');

-- Kirin Tor Mage
UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 33672;

DELETE FROM `creature` WHERE (`id` = 33672) AND (`guid` IN (136553, 136552));
INSERT INTO `creature` (`guid`, `id`, `map`, `zoneId`, `areaId`, `spawnMask`, `phaseMask`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `wander_distance`, `currentwaypoint`, `curhealth`, `curmana`, `MovementType`, `npcflag`, `unit_flags`, `dynamicflags`, `ScriptName`, `VerifiedBuild`) VALUES
(136553, 33672, 603, 0, 0, 3, 1, 0, 0, -814.096, -201.356, 429.84, 6.25175, 30, 0, 0, 9416, 8459, 0, 0, 0, 0, '', 0),
(136552, 33672, 603, 0, 0, 3, 1, 0, 0, -814.096, -201.356, 429.84, 6.25175, 30, 0, 0, 2500, 8459, 0, 0, 0, 0, '', 0);

DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = -136537);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(-136537, 0, 0, 0, 38, 0, 100, 0, 1, 1, 0, 0, 0, 29, 1, 225, 0, 0, 0, 0, 10, 136281, 33624, 0, 0, 0, 0, 0, 0, 'Kirin Tor Mage - On Data Set 1 1 - Start Follow Closest Creature \'Archmage Pentarus\''),
(-136537, 0, 1, 0, 60, 0, 100, 1, 0, 0, 0, 0, 0, 62, 603, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, -679.255, -87.855, 427.228, 0.054839, 'Kirin Tor Mage - On Update - Teleport (No Repeat)');

DELETE FROM `conditions` WHERE (`SourceEntry` = -136537) AND (`SourceTypeOrReferenceId` = 22) AND (`SourceGroup` = 2);
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `ErrorType`, `ErrorTextId`, `ScriptName`, `Comment`) VALUES
(22, 2, -136537, 0, 0, 13, 1, 800, 3, 0, 0, 0, 0, '', '');

DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = -136552);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(-136552, 0, 0, 0, 60, 0, 100, 1, 0, 0, 0, 0, 0, 11, 12980, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Kirin Tor Mage - On Update - Cast \'Teleport Visual\' (No Repeat)'),
(-136552, 0, 1, 0, 60, 0, 100, 1, 2000, 2000, 0, 0, 0, 53, 0, 3367200, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Kirin Tor Mage - On Update - Start Waypoint (No Repeat)'),
(-136552, 0, 2, 0, 40, 0, 100, 0, 6, 3367200, 0, 0, 0, 54, 10000, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Kirin Tor Mage - On Waypoint 6 Reached - Pause Waypoint'),
(-136552, 0, 3, 0, 40, 0, 100, 0, 6, 3367200, 0, 0, 0, 80, 3367200, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Kirin Tor Mage - On Waypoint 6 Reached - Run Script'),
(-136552, 0, 4, 5, 58, 0, 100, 0, 0, 3367200, 0, 0, 0, 41, 1000, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Kirin Tor Mage - On Waypoint Finished - Despawn In 1000 ms'),
(-136552, 0, 5, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 11, 12980, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Kirin Tor Mage - On Update - Cast \'Teleport Visual\' (No Repeat)');

DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = -136553);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(-136553, 0, 0, 0, 60, 0, 100, 1, 0, 0, 0, 0, 0, 11, 12980, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Kirin Tor Mage - On Update - Cast \'Teleport Visual\' (No Repeat)'),
(-136553, 0, 1, 0, 60, 0, 100, 1, 2000, 2000, 0, 0, 0, 53, 0, 3367201, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Kirin Tor Mage - On Update - Start Waypoint (No Repeat)'),
(-136553, 0, 2, 0, 40, 0, 100, 0, 4, 3367201, 0, 0, 0, 54, 10000, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Kirin Tor Mage - On Waypoint 4 Reached - Pause Waypoint'),
(-136553, 0, 3, 0, 40, 0, 100, 0, 4, 3367201, 0, 0, 0, 80, 3367200, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Kirin Tor Mage - On Waypoint 4 Reached - Run Script'),
(-136553, 0, 4, 5, 58, 0, 100, 0, 0, 3367201, 0, 0, 0, 41, 1000, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Kirin Tor Mage - On Waypoint Finished - Despawn In 1000 ms'),
(-136553, 0, 5, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 11, 12980, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Kirin Tor Mage - On Update - Cast \'Teleport Visual\' (No Repeat)');

DELETE FROM `smart_scripts` WHERE (`source_type` = 9 AND `entryorguid` = 3367200);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(3367200, 9, 0, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 75, 68442, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Kirin Tor Mage - Actionlist - Add Aura \'Kneel\''),
(3367200, 9, 1, 0, 0, 0, 100, 0, 8500, 8500, 0, 0, 0, 28, 68442, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Kirin Tor Mage - Actionlist - Remove Aura \'Kneel\'');

DELETE FROM `waypoints` WHERE `entry`=3367200;
INSERT INTO `waypoints` (`entry`, `pointid`, `position_x`, `position_y`, `position_z`, `point_comment`) VALUES
(3367200, 1, -812.01, -201.99, 429.8, 'Kirin Tor Mage - Boxes Middle Ulduar'),
(3367200, 2, -810.91, -203.51, 429.8, 'Kirin Tor Mage - Boxes Middle Ulduar'),
(3367200, 3, -810.72, -206.63, 429.8, 'Kirin Tor Mage - Boxes Middle Ulduar'),
(3367200, 4, -811.23, -217.11, 429.8, 'Kirin Tor Mage - Boxes Middle Ulduar'),
(3367200, 5, -812.88, -222.94, 429.8, 'Kirin Tor Mage - Boxes Middle Ulduar'),
(3367200, 6, -815.95, -228.36, 429.8, 'Kirin Tor Mage - Boxes Middle Ulduar'),
(3367200, 7, -812.88, -222.94, 429.8, 'Kirin Tor Mage - Boxes Middle Ulduar'),
(3367200, 8, -811.23, -217.11, 429.8, 'Kirin Tor Mage - Boxes Middle Ulduar'),
(3367200, 9, -810.72, -206.63, 429.8, 'Kirin Tor Mage - Boxes Middle Ulduar'),
(3367200, 10, -810.91, -203.51, 429.8, 'Kirin Tor Mage - Boxes Middle Ulduar'),
(3367200, 11, -812.01, -201.99, 429.8, 'Kirin Tor Mage - Boxes Middle Ulduar'),
(3367200, 12, -814.09, -201.35, 429.8, 'Kirin Tor Mage - Boxes Middle Ulduar');

DELETE FROM `waypoints` WHERE `entry`=3367201;
INSERT INTO `waypoints` (`entry`, `pointid`, `position_x`, `position_y`, `position_z`, `point_comment`) VALUES
(3367201, 1, -812.83, -202.50, 429.8, 'Kirin Tor Mage - Boxes Right Ulduar'),
(3367201, 2, -812.35, -205.30, 429.8, 'Kirin Tor Mage - Boxes Right Ulduar'),
(3367201, 3, -815.29, -207.55, 429.8, 'Kirin Tor Mage - Boxes Right Ulduar'),
(3367201, 4, -818.87, -207.92, 429.8, 'Kirin Tor Mage - Boxes Right Ulduar'),
(3367201, 5, -815.29, -207.55, 429.8, 'Kirin Tor Mage - Boxes Right Ulduar'),
(3367201, 6, -812.35, -205.30, 429.8, 'Kirin Tor Mage - Boxes Right Ulduar'),
(3367201, 7, -812.83, -202.50, 429.8, 'Kirin Tor Mage - Boxes Right Ulduar'),
(3367201, 8, -814.09, -201.35, 429.8, 'Kirin Tor Mage - Boxes Right Ulduar');

DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = -136546);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(-136546, 0, 0, 0, 1, 0, 100, 0, 3000, 4000, 3000, 4000, 0, 10, 273, 1, 6, 274, 5, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, '');

DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = -136545);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(-136545, 0, 0, 0, 1, 0, 100, 0, 3000, 4000, 3000, 4000, 0, 10, 273, 1, 6, 274, 5, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, '');

DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = -136539);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(-136539, 0, 0, 0, 1, 0, 100, 0, 3000, 4000, 3000, 4000, 0, 10, 273, 1, 6, 274, 5, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, '');

DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = -136538);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(-136538, 0, 0, 0, 1, 0, 100, 0, 3000, 4000, 3000, 4000, 0, 10, 273, 1, 6, 274, 5, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, '');

-- Goran Steelbreaker
DELETE FROM `creature` WHERE (`id` = 33622);
INSERT INTO `creature` (`guid`, `id`, `map`, `zoneId`, `areaId`, `spawnMask`, `phaseMask`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `wander_distance`, `currentwaypoint`, `curhealth`, `curmana`, `MovementType`, `npcflag`, `unit_flags`, `dynamicflags`, `ScriptName`, `VerifiedBuild`) VALUES
(136271, 33622, 603, 0, 0, 3, 1, 0, 1, -870.116, -159.637, 458.86, 6.2623, 604800, 0, 0, 1, 0, 0, 0, 0, 0, '', 0);

DELETE FROM `waypoints` WHERE `entry` = 13627100;
INSERT INTO `waypoints` (`entry`, `pointid`, `position_x`, `position_y`, `position_z`, `point_comment`) VALUES
(13627100, 1, -856.854, -159.629, 458.894, 'Goran Steelbreaker'),
(13627100, 2, -815.381, -160.206, 429.841, 'Goran Steelbreaker'),
(13627100, 3, -812.063, -160.252, 429.841, 'Goran Steelbreaker'),
(13627100, 4, -787.449, -186.878, 429.841, 'Goran Steelbreaker'),
(13627100, 5, -764.428, -185.599, 429.841, 'Goran Steelbreaker'),
(13627100, 6, -756.902, -183.903, 429.824, 'Goran Steelbreaker'),
(13627100, 7, -743.469, -190.483, 429.841, 'Goran Steelbreaker'),
(13627100, 8, -735.021, -155.349, 429.84, 'Goran Steelbreaker'),
(13627100, 9, -733.845, -123.15, 429.84, 'Goran Steelbreaker'),
(13627100, 10, -735.325, -104.313, 429.84, 'Goran Steelbreaker'),
(13627100, 11, -726.365, -86.0322, 429.84, 'Goran Steelbreaker'),
(13627100, 12, -710.154, -81.27, 429.84, 'Goran Steelbreaker'),
(13627100, 13, -700.494, -81.3369, 429.402, 'Goran Steelbreaker'),
(13627100, 14, -723.062, -81.6906, 429.842, 'Goran Steelbreaker'),
(13627100, 15, -735.383, -98.9337, 429.842, 'Goran Steelbreaker'),
(13627100, 16, -736.991, -134.149, 429.841, 'Goran Steelbreaker'),
(13627100, 17, -740.398, -157.068, 429.842, 'Goran Steelbreaker'),
(13627100, 18, -746.407, -170.483, 429.842, 'Goran Steelbreaker'),
(13627100, 19, -748.094, -175.932, 429.801, 'Goran Steelbreaker'),
(13627100, 20, -776.031, -186.115, 429.84, 'Goran Steelbreaker'),
(13627100, 21, -795.367, -180.787, 429.84, 'Goran Steelbreaker'),
(13627100, 22, -803.027, -151.463, 429.84, 'Goran Steelbreaker'),
(13627100, 23, -800.079, -131.901, 429.614, 'Goran Steelbreaker'),
(13627100, 24, -798.208, -85.7146, 429.842, 'Goran Steelbreaker'),
(13627100, 25, -796.247, -66.4749, 429.843, 'Goran Steelbreaker'),
(13627100, 26, -803.578, -54.884, 429.843, 'Goran Steelbreaker');

DELETE FROM `waypoints` WHERE `entry` IN (13627101);
INSERT INTO `waypoints` (`entry`, `pointid`, `position_x`, `position_y`, `position_z`, `point_comment`) VALUES
(13627101, 1, -759.514, -46.609, 429.84, 'Goran Steelbreaker 1'),
(13627101, 2, -709.315, -26.547, 429.84, 'Goran Steelbreaker 1'),
(13627101, 3, -702.395, -11.965, 429.73, 'Goran Steelbreaker 1'),
(13627101, 4, -679.813, -8.959, 426.88, 'Goran Steelbreaker 1');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE (`entry` = 33622);

DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = -136271);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(-136271, 0, 0, 0, 1, 0, 100, 1, 0, 0, 0, 0, 0, 53, 0, 13627100, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Goran Steelbreaker - Out of Combat - Start Waypoint (No Repeat)'),
(-136271, 0, 1, 0, 40, 0, 100, 0, 7, 13627100, 0, 0, 0, 54, 45000, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Goran Steelbreaker - On Waypoint 7 Reached - Pause Waypoint'),
(-136271, 0, 2, 0, 40, 0, 100, 0, 13, 13627100, 0, 0, 0, 54, 45000, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Goran Steelbreaker - On Waypoint 13 Reached - Pause Waypoint'),
(-136271, 0, 3, 4, 38, 0, 100, 0, 0, 1, 0, 0, 0, 55, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Goran Steelbreaker - On Data Set 0 1 - Stop Waypoint'),
(-136271, 0, 4, 0, 61, 0, 100, 0, 0, 1, 0, 0, 0, 53, 1, 13627101, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Goran Steelbreaker - On Data Set 0 1 - Start Waypoint'),
(-136271, 0, 5, 6, 58, 0, 100, 0, 0, 13627101, 0, 0, 0, 66, 0, 0, 0, 0, 0, 0, 8, 0, 0, 0, 0, 0, 0, 0, 6.2797, 'Goran Steelbreaker - On Waypoint Finished - Set Orientation 6.2797'),
(-136271, 0, 6, 7, 61, 0, 100, 0, 0, 13627101, 0, 0, 0, 45, 0, 1, 0, 0, 0, 0, 10, 136525, 33620, 0, 0, 0, 0, 0, 0, 'Goran Steelbreaker - On Waypoint Finished - Set Data 0 1'),
(-136271, 0, 7, 0, 61, 0, 100, 0, 0, 13627101, 0, 0, 0, 45, 0, 1, 0, 0, 0, 0, 10, 136526, 33620, 0, 0, 0, 0, 0, 0, 'Goran Steelbreaker - On Waypoint Finished - Set Data 0 1'),
(-136271, 0, 8, 9, 60, 0, 100, 1, 0, 0, 0, 0, 0, 62, 603, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, -679.813, -8.959, 426.88, 6.2797, 'Goran Steelbreaker - On Update - Teleport (No Repeat)'),
(-136271, 0, 9, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 55, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Goran Steelbreaker - On Update - Stop Waypoint (No Repeat)');

DELETE FROM `conditions` WHERE (`SourceEntry` = -136271) AND (`SourceTypeOrReferenceId` = 22) AND (`SourceGroup` = 9);
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `ErrorType`, `ErrorTextId`, `ScriptName`, `Comment`) VALUES
(22, 9, -136271, 0, 0, 13, 1, 800, 3, 0, 0, 0, 0, '', '');

-- Earthen Stoneshaper
DELETE FROM `creature` WHERE (`id` = 33620);
INSERT INTO `creature` (`guid`, `id`, `map`, `zoneId`, `areaId`, `spawnMask`, `phaseMask`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `wander_distance`, `currentwaypoint`, `curhealth`, `curmana`, `MovementType`, `npcflag`, `unit_flags`, `dynamicflags`, `ScriptName`, `VerifiedBuild`) VALUES
(136526, 33620, 603, 0, 0, 3, 1, 0, 1, -873.232, -163.121, 458.848, 6.2623, 604800, 0, 0, 1, 0, 0, 0, 0, 0, '', 0),
(136525, 33620, 603, 0, 0, 3, 1, 0, 1, -873.089, -156.242, 458.849, 6.2623, 604800, 0, 0, 1, 0, 0, 0, 0, 0, '', 0);

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 33620;

DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = -136525);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(-136525, 0, 0, 0, 1, 0, 100, 1, 500, 500, 500, 500, 0, 29, 2, 135, 0, 0, 0, 0, 10, 136271, 33622, 0, 0, 0, 0, 0, 0, 'Earthen Stoneshaper - Out of Combat - Start Follow Closest Creature \'Goran Steelbreaker\' (No Repeat)'),
(-136525, 0, 1, 2, 38, 0, 100, 0, 0, 1, 0, 0, 0, 29, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Earthen Stoneshaper - On Data Set 0 1 - Stop Follow '),
(-136525, 0, 2, 0, 61, 0, 100, 0, 0, 1, 0, 0, 0, 69, 1, 0, 0, 0, 0, 0, 10, 136271, 33622, 0, 0, -3, 3, 0, 0, 'Earthen Stoneshaper - On Data Set 0 1 - Move To Closest Creature \'Goran Steelbreaker\''),
(-136525, 0, 3, 0, 34, 0, 100, 0, 0, 1, 0, 0, 0, 66, 0, 0, 0, 0, 0, 0, 8, 0, 0, 0, 0, 0, 0, 0, 6.2797, 'Earthen Stoneshaper - On Reached Point 1 - Set Orientation 6.2797'),
(-136525, 0, 4, 5, 60, 0, 100, 1, 0, 0, 0, 0, 0, 62, 603, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, -682.924, -5.959, 427.28, 6.2797, 'Earthen Stoneshaper - On Update - Teleport (No Repeat)'),
(-136525, 0, 5, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 29, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Earthen Stoneshaper - On Update - Stop Follow  (No Repeat)');

DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = -136526);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(-136526, 0, 0, 0, 1, 0, 100, 1, 500, 500, 500, 500, 0, 29, 2, 225, 0, 0, 0, 0, 10, 136271, 33622, 0, 0, 0, 0, 0, 0, 'Earthen Stoneshaper - Out of Combat - Start Follow Closest Creature \'Goran Steelbreaker\' (No Repeat)'),
(-136526, 0, 1, 2, 38, 0, 100, 0, 0, 1, 0, 0, 0, 29, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Earthen Stoneshaper - On Data Set 0 1 - Stop Follow '),
(-136526, 0, 2, 0, 61, 0, 100, 0, 0, 1, 0, 0, 0, 69, 1, 0, 0, 0, 0, 0, 10, 136271, 33622, 0, 0, -3, -3, 0.1, 0, 'Earthen Stoneshaper - On Data Set 0 1 - Move To Closest Creature \'Goran Steelbreaker\''),
(-136526, 0, 3, 0, 34, 0, 100, 0, 0, 1, 0, 0, 0, 66, 0, 0, 0, 0, 0, 0, 8, 0, 0, 0, 0, 0, 0, 0, 6.2797, 'Earthen Stoneshaper - On Reached Point 1 - Set Orientation 6.2797'),
(-136526, 0, 4, 5, 60, 0, 100, 1, 0, 0, 0, 0, 0, 62, 603, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, -682.812, -11.959, 427.25, 6.2797, 'Earthen Stoneshaper - On Update - Teleport (No Repeat)'),
(-136526, 0, 5, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 29, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Earthen Stoneshaper - On Update - Stop Follow  (No Repeat)');

DELETE FROM `conditions` WHERE (`SourceEntry` = -136525) AND (`SourceTypeOrReferenceId` = 22) AND (`SourceGroup` = 5);
DELETE FROM `conditions` WHERE (`SourceEntry` = -136526) AND (`SourceTypeOrReferenceId` = 22) AND (`SourceGroup` = 5);
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `ErrorType`, `ErrorTextId`, `ScriptName`, `Comment`) VALUES
(22, 5, -136525, 0, 0, 13, 1, 800, 3, 0, 0, 0, 0, '', ''),
(22, 5, -136526, 0, 0, 13, 1, 800, 3, 0, 0, 0, 0, '', '');

-- Archmage Rhydian
UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 33696;

DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = 33696);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(33696, 0, 0, 1, 38, 0, 100, 0, 1, 1, 0, 0, 0, 1, 0, 2000, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Archmage Rhydian - On Data Set 1 1 - Say Line 0'),
(33696, 0, 1, 0, 61, 0, 100, 0, 1, 1, 0, 0, 0, 22, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Archmage Rhydian - On Data Set 1 1 - Set Event Phase 1'),
(33696, 0, 2, 0, 52, 1, 100, 0, 0, 33696, 0, 0, 0, 53, 1, 33696, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Archmage Rhydian - On Text 0 Over - Start Waypoint (Phase 1)'),
(33696, 0, 3, 0, 40, 1, 100, 0, 7, 33696, 0, 0, 0, 59, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Archmage Rhydian - On Waypoint 7 Reached - Set Run Off (Phase 1)'),
(33696, 0, 4, 5, 40, 1, 100, 0, 9, 33696, 0, 0, 0, 54, 8000, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Archmage Rhydian - On Waypoint 9 Reached - Pause Waypoint (Phase 1)'),
(33696, 0, 5, 6, 61, 1, 100, 0, 9, 33696, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Archmage Rhydian - On Waypoint 9 Reached - Say Line 1 (Phase 1)'),
(33696, 0, 6, 0, 61, 1, 100, 0, 9, 33696, 0, 0, 0, 59, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Archmage Rhydian - On Waypoint 9 Reached - Set Run On (Phase 1)'),
(33696, 0, 7, 0, 40, 1, 100, 0, 13, 33696, 0, 0, 0, 59, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Archmage Rhydian - On Waypoint 13 Reached - Set Run Off (Phase 1)'),
(33696, 0, 8, 0, 40, 1, 100, 0, 14, 33696, 0, 0, 0, 66, 0, 0, 0, 0, 0, 0, 8, 0, 0, 0, 0, 0, 0, 0, 5.91667, 'Archmage Rhydian - On Waypoint 14 Reached - Set Orientation 5.91667 (Phase 1)'),
(33696, 0, 9, 10, 38, 1, 100, 0, 1, 2, 0, 0, 0, 69, 1, 0, 0, 0, 0, 0, 8, 0, 0, 0, 0, -773.48, -144.13, 429.91, 0, 'Archmage Rhydian - On Data Set 1 2 - Move To Position (Phase 1)'),
(33696, 0, 10, 0, 61, 0, 100, 0, 1, 2, 0, 0, 0, 59, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Archmage Rhydian - On Data Set 1 2 - Set Run On (Phase 1)'),
(33696, 0, 11, 12, 34, 1, 100, 0, 8, 1, 0, 0, 0, 66, 0, 0, 0, 0, 0, 0, 8, 0, 0, 0, 0, 0, 0, 0, 5.91667, 'Archmage Rhydian - On Reached Point 1 - Set Orientation 5.91667 (Phase 1)'),
(33696, 0, 12, 0, 61, 1, 100, 0, 8, 1, 0, 0, 0, 55, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Archmage Rhydian - On Reached Point 1 - Stop Waypoint (Phase 1)');

DELETE FROM `waypoints` WHERE `entry`=33696;
INSERT INTO `waypoints` (`entry`, `pointid`, `position_x`, `position_y`, `position_z`, `point_comment`) VALUES
(33696, 1, -769.512, -120.811, 429.55, 'Archmage Rhydian'),
(33696, 2, -769.143, -104.085, 429.86, 'Archmage Rhydian'),
(33696, 3, -763.094, -86.176, 429.95, 'Archmage Rhydian'),
(33696, 4, -755.04, -68.305, 429.95, 'Archmage Rhydian'),
(33696, 5, -746.373, -54.038, 429.96, 'Archmage Rhydian'),
(33696, 6, -738.985, -49.878, 429.96, 'Archmage Rhydian'),
(33696, 7, -729.148, -49.885, 429.96, 'Archmage Rhydian'),
(33696, 8, -721.175, -49.993, 429.84, 'Archmage Rhydian'),
(33696, 9, -718.606, -52.745, 429.84, 'Archmage Rhydian'),
(33696, 10, -743.976, -62.591, 429.83, 'Archmage Rhydian'),
(33696, 11, -760.337, -82.492, 429.83, 'Archmage Rhydian'),
(33696, 12, -766.435, -98.779, 429.83, 'Archmage Rhydian'),
(33696, 13, -768.557, -112.185, 429.83, 'Archmage Rhydian'),
(33696, 14, -773.48, -144.13, 429.91, 'Archmage Rhydian');

-- Lore Keeper of Norgannon Projection Unit
DELETE FROM `creature` WHERE (`id` = 33721) AND (`guid` IN (136778));
INSERT INTO `creature` (`guid`, `id`, `map`, `zoneId`, `areaId`, `spawnMask`, `phaseMask`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `wander_distance`, `currentwaypoint`, `curhealth`, `curmana`, `MovementType`, `npcflag`, `unit_flags`, `dynamicflags`, `ScriptName`, `VerifiedBuild`) VALUES
(136778, 33721, 603, 0, 0, 3, 1, 26937, 0, -759.845, -151.133, 438.61, 0, 604800, 0, 0, 12600, 3994, 0, 0, 0, 0, '', 0);

-- Lore Keeper of Norgannon
UPDATE `creature_template` SET `AIName` = 'SmartAI', `ScriptName` = '' WHERE (`entry` = 33686);

DELETE FROM `creature` WHERE (`id` = 33686);
INSERT INTO `creature` (`guid`, `id`, `map`, `zoneId`, `areaId`, `spawnMask`, `phaseMask`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `wander_distance`, `currentwaypoint`, `curhealth`, `curmana`, `MovementType`, `npcflag`, `unit_flags`, `dynamicflags`, `ScriptName`, `VerifiedBuild`) VALUES
(136605, 33686, 603, 0, 0, 3, 1, 6589, 0, -764.599, -147.708, 430.172, 3.19395, 604800, 0, 0, 17010, 0, 0, 0, 0, 0, '', 0);

DELETE FROM `creature_text` WHERE `CreatureID`=33686;
INSERT INTO `creature_text` (`CreatureID`, `GroupID`, `ID`, `Text`, `Type`, `Language`, `Probability`, `Emote`, `Duration`, `Sound`, `BroadcastTextId`, `TextRange`, `comment`) VALUES
(33686, 0, 0, 'I was constructed to serve as a repository for essential information regarding this complex. My primary functions include communicating the status of the frontal defense systems and assessing the status of the entity that this complex was built to imprison.', 12, 0, 0, 0, 0, 0, 33703, 0, 'Norgannon SAY_EVENT_1'),
(33686, 1, 0, 'Access to the interior of the complex is currently restricted. Primary defensive emplacements are active. Secondary systems are currently non-active.', 12, 0, 0, 0, 0, 0, 33705, 0, 'Norgannon SAY_EVENT_2'),
(33686, 2, 0, 'Compromise of complex detected, security override enabled - query permitted.', 12, 0, 0, 0, 0, 0, 33707, 0, 'Norgannon SAY_EVENT_3'),
(33686, 3, 0, 'Primary defensive emplacements consist of iron constructs and Storm Beacons, which will generate additional constructs as necessary. Secondary systems consist of orbital defense emplacements.', 12, 0, 0, 0, 0, 0, 33712, 0, 'Norgannon SAY_EVENT_4'),
(33686, 4, 0, 'Entity designate: Yogg-Saron. Security has been compromised. Prison operational status unknown. Unable to contact Watchers for notification purposes.', 12, 0, 0, 0, 0, 0, 33711, 0, 'Norgannon SAY_EVENT_5'),
(33686, 5, 0, 'Deactivating.', 12, 0, 0, 0, 0, 0, 33808, 0, 'Norgannon SAY_EVENT_6');

DELETE FROM `gossip_menu_option` WHERE (`MenuID` = 10366);
INSERT INTO `gossip_menu_option` (`MenuID`, `OptionID`, `OptionIcon`, `OptionText`, `OptionBroadcastTextID`, `OptionType`, `OptionNpcFlag`, `ActionMenuID`, `ActionPoiID`, `BoxCoded`, `BoxMoney`, `BoxText`, `BoxBroadcastTextID`, `VerifiedBuild`) VALUES
(10366, 0, 0, 'Activate secondary defensive systems.', 34420, 1, 1, 0, 0, 0, 0, NULL, 0, 0);

DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = 33686);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(33686, 0, 0, 0, 62, 0, 100, 0, 10366, 0, 0, 0, 0, 98, 10477, 14496, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Lore Keeper of Norgannon - On Gossip Option 0 Selected - Send Gossip'),
(33686, 0, 1, 0, 10, 0, 100, 0, 1, 20, 90000, 180000, 1, 80, 3368600, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Lore Keeper of Norgannon - Within 1-20 Range Out of Combat LoS - Run Script'),
(33686, 0, 2, 0, 10, 0, 100, 1, 1, 20, 0, 0, 1, 80, 3368600, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Lore Keeper of Norgannon - Within 1-20 Range Out of Combat LoS - Run Script (No Repeat)'),
(33686, 0, 3, 4, 62, 0, 100, 0, 10477, 0, 0, 0, 0, 83, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Lore Keeper of Norgannon - On Gossip Option 0 Selected - Remove Npc Flags Gossip'),
(33686, 0, 4, 5, 61, 0, 100, 0, 10477, 0, 0, 0, 0, 72, 0, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Lore Keeper of Norgannon - On Gossip Option 0 Selected - Close Gossip'),
(33686, 0, 5, 6, 61, 0, 100, 0, 10477, 0, 0, 0, 0, 64, 1, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Lore Keeper of Norgannon - On Gossip Option 0 Selected - Store Targetlist'),
(33686, 0, 6, 7, 61, 0, 100, 0, 10477, 0, 0, 0, 0, 100, 1, 0, 0, 0, 0, 0, 10, 136767, 33701, 0, 0, 0, 0, 0, 0, 'Lore Keeper of Norgannon - On Gossip Option 0 Selected - Send Target 1'),
(33686, 0, 7, 8, 61, 0, 100, 0, 10477, 0, 0, 0, 0, 80, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Lore Keeper of Norgannon - On Gossip Option 0 Selected - Run Script'),
(33686, 0, 8, 9, 61, 0, 100, 0, 10477, 0, 0, 0, 0, 45, 1, 1, 0, 0, 0, 0, 10, 136767, 33701, 0, 0, 0, 0, 0, 0, 'Lore Keeper of Norgannon - On Gossip Option 0 Selected - Set Data 1 1'),
(33686, 0, 9, 0, 61, 0, 100, 0, 10477, 0, 0, 0, 0, 83, 1, 0, 0, 0, 0, 0, 10, 136253, 33579, 0, 0, 0, 0, 0, 0, 'Lore Keeper of Norgannon - On Gossip Option 0 Selected - Remove Npc Flags Gossip'),
(33686, 0, 10, 0, 60, 0, 100, 1, 0, 0, 0, 0, 0, 83, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Lore Keeper of Norgannon - On Update - Remove Npc Flags Gossip (No Repeat)'),
(33686, 0, 11, 14, 38, 0, 100, 0, 0, 1, 0, 0, 0, 41, 2000, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Lore Keeper of Norgannon - On Data Set 0 1 - Despawn In 2000 ms'),
(33686, 0, 12, 0, 60, 0, 100, 1, 0, 0, 0, 0, 0, 41, 2000, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Lore Keeper of Norgannon - On Update - Despawn In 2000 ms (No Repeat)'),
(33686, 0, 13, 0, 38, 0, 100, 0, 1, 2, 0, 0, 0, 80, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Lore Keeper of Norgannon - On Data Set 1 2 - Run Script'),
(33686, 0, 14, 15, 61, 0, 100, 0, 0, 1, 0, 0, 0, 1, 5, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Lore Keeper of Norgannon - On Data Set 0 1 - Say Line 5'),
(33686, 0, 15, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 41, 2000, 0, 0, 0, 0, 0, 10, 136778, 33721, 0, 0, 0, 0, 0, 0, 'Lore Keeper of Norgannon - On Data Set 0 1 - Despawn In 2000 ms');

DELETE FROM `smart_scripts` WHERE (`source_type` = 9 AND `entryorguid` = 3368600);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(3368600, 9, 0, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 64, 1, 0, 0, 0, 0, 0, 10, 136767, 33701, 0, 0, 0, 0, 0, 0, 'Lore Keeper of Norgannon - Actionlist - Store Targetlist'),
(3368600, 9, 1, 0, 0, 0, 100, 0, 5000, 5000, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 12, 1, 0, 0, 0, 0, 0, 0, 0, 'Lore Keeper of Norgannon - Actionlist - High Explorer Dellorah Say Line 0'),
(3368600, 9, 2, 0, 0, 0, 100, 0, 10000, 10000, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Lore Keeper of Norgannon - Actionlist - Say Line 0'),
(3368600, 9, 3, 0, 0, 0, 100, 0, 10000, 10000, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 12, 1, 0, 0, 0, 0, 0, 0, 0, 'Lore Keeper of Norgannon - Actionlist - High Explorer Dellorah Say Line 1'),
(3368600, 9, 4, 0, 0, 0, 100, 0, 10000, 10000, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Lore Keeper of Norgannon - Actionlist - Say Line 1'),
(3368600, 9, 5, 0, 0, 0, 100, 0, 6000, 6000, 0, 0, 0, 1, 2, 0, 0, 0, 0, 0, 12, 1, 0, 0, 0, 0, 0, 0, 0, 'Lore Keeper of Norgannon - Actionlist - High Explorer Dellorah Say Line 2'),
(3368600, 9, 6, 0, 0, 0, 100, 0, 8000, 8000, 0, 0, 0, 1, 2, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Lore Keeper of Norgannon - Actionlist - Say Line 2'),
(3368600, 9, 7, 0, 0, 0, 100, 0, 8000, 8000, 0, 0, 0, 1, 3, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Lore Keeper of Norgannon - Actionlist - Say Line 3'),
(3368600, 9, 8, 0, 0, 0, 100, 0, 14000, 14000, 0, 0, 0, 1, 3, 0, 0, 0, 0, 0, 12, 1, 0, 0, 0, 0, 0, 0, 0, 'Lore Keeper of Norgannon - Actionlist - High Explorer Dellorah Say Line 3'),
(3368600, 9, 9, 0, 0, 0, 100, 0, 6000, 6000, 0, 0, 0, 1, 4, 0, 0, 0, 0, 0, 12, 1, 0, 0, 0, 0, 0, 0, 0, 'Lore Keeper of Norgannon - Actionlist - High Explorer Dellorah Say Line 4'),
(3368600, 9, 11, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 45, 1, 1, 0, 0, 0, 0, 10, 136761, 33696, 0, 0, 0, 0, 0, 0, 'Lore Keeper of Norgannon - Actionlist - Archmage Rhydian Waypoint Start'),
(3368600, 9, 10, 0, 0, 0, 100, 0, 6000, 6000, 0, 0, 0, 1, 5, 0, 0, 0, 0, 0, 12, 1, 0, 0, 0, 0, 0, 0, 0, 'Lore Keeper of Norgannon - Actionlist - High Explorer Dellorah Say Line 5'),
(3368600, 9, 12, 0, 0, 0, 100, 0, 8000, 8000, 0, 0, 0, 1, 4, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Lore Keeper of Norgannon - Actionlist - Say Line 4'),
(3368600, 9, 13, 0, 0, 0, 100, 0, 12000, 12000, 0, 0, 0, 1, 6, 0, 0, 0, 0, 0, 12, 1, 0, 0, 0, 0, 0, 0, 0, 'Lore Keeper of Norgannon - Actionlist - High Explorer Dellorah Say Line 6');

DELETE FROM `conditions` WHERE (`SourceEntry` = 33686) AND (`SourceTypeOrReferenceId` = 22) AND (`SourceGroup` IN (11,13));
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `ErrorType`, `ErrorTextId`, `ScriptName`, `Comment`) VALUES
(22, 11, 33686, 0, 0, 13, 1, 800, 0, 0, 1, 0, 0, '', 'Lore Keeper of Norgannon - Remove Gossip Flag - Ulduar Base Camp Intro Started'),
(22, 13, 33686, 0, 0, 13, 1, 800, 3, 0, 0, 0, 0, '', 'Lore Keeper of Norgannon - Change Phase - Ulduar Base Camp Intro Done');

-- High Explorer Dellorah
UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 33701;

DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = 33701);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(33701, 0, 1, 0, 38, 0, 100, 1, 1, 1, 0, 0, 0, 80, 3370100, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'High Explorer Dellorah - On Data Set 1 1 - Run Script (No Repeat)'),
(33701, 0, 2, 3, 40, 0, 100, 0, 6, 0, 0, 0, 0, 1, 8, 5000, 1, 0, 0, 0, 12, 1, 0, 0, 0, 0, 0, 0, 0, 'High Explorer Dellorah - On Waypoint 6 Reached - Say Line 8'),
(33701, 0, 3, 0, 61, 0, 100, 0, 6, 0, 0, 0, 0, 54, 5000, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'High Explorer Dellorah - On Waypoint 6 Reached - Pause Waypoint'),
(33701, 0, 4, 0, 60, 0, 100, 1, 0, 0, 0, 0, 0, 41, 2000, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'High Explorer Dellorah - On Update - Despawn In 2000 ms (No Repeat)'),
(33701, 0, 5, 0, 58, 0, 100, 0, 0, 0, 0, 0, 0, 41, 2000, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'High Explorer Dellorah - On Waypoint Finished - Despawn In 2000 ms'),
(33701, 0, 6, 0, 52, 0, 100, 0, 8, 33701, 0, 0, 0, 45, 0, 1, 0, 0, 0, 0, 10, 136253, 33579, 0, 0, 0, 0, 0, 0, 'High Explorer Dellorah - On Text 8 Over - Set Data 0 1'),
(33701, 0, 7, 0, 38, 0, 100, 0, 1, 2, 0, 0, 0, 80, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'High Explorer Dellorah - On Data Set 1 2 - Run Script');

DELETE FROM `smart_scripts` WHERE (`source_type` = 9 AND `entryorguid` = 3370100);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(3370100, 9, 0, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 45, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'High Explorer Dellorah - Actionlist - Set Data 1 0'),
(3370100, 9, 1, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 1, 7, 0, 1, 0, 0, 0, 12, 1, 0, 0, 0, 0, 0, 0, 0, 'High Explorer Dellorah - Actionlist - Say Line 7'),
(3370100, 9, 2, 0, 0, 0, 100, 0, 5000, 5000, 0, 0, 0, 53, 1, 33701, 0, 0, 2000, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'High Explorer Dellorah - Actionlist - Start Waypoint');

DELETE FROM `conditions` WHERE (`SourceEntry` = 33701) AND (`SourceTypeOrReferenceId` = 22) AND (`SourceGroup` = 5);
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `ErrorType`, `ErrorTextId`, `ScriptName`, `Comment`) VALUES
(22, 5, 33701, 0, 0, 13, 1, 800, 3, 0, 0, 0, 0, '', 'High Explorer Dellorah - Change Phase - Base Camp Intro Done');

DELETE FROM `creature` WHERE (`id` = 33701);
INSERT INTO `creature` (`guid`, `id`, `map`, `zoneId`, `areaId`, `spawnMask`, `phaseMask`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `wander_distance`, `currentwaypoint`, `curhealth`, `curmana`, `MovementType`, `npcflag`, `unit_flags`, `dynamicflags`, `ScriptName`, `VerifiedBuild`) VALUES
(136767, 33701, 603, 0, 0, 3, 1, 28826, 0, -771.144, -147.649, 430.055, 0.069813, 3600, 0, 0, 12600, 0, 0, 0, 0, 0, '', 0);

DELETE FROM `creature_text` WHERE `CreatureID`=33701;
INSERT INTO `creature_text` (`CreatureID`, `GroupID`, `ID`, `Text`, `Type`, `Language`, `Probability`, `Emote`, `Duration`, `Sound`, `BroadcastTextId`, `TextRange`, `comment`) VALUES
(33701, 0, 0, 'I heard a story or two of a Lore Keeper in Uldaman that fit your description. Do you serve a similar purpose?', 12, 0, 100, 0, 0, 0, 33702, 0, 'High Explorer Dellorah to Player'),
(33701, 1, 0, 'Frontal defense systems? Is there something I should let Brann know before he has anyone attempt to enter the complex?', 12, 0, 100, 0, 0, 0, 33704, 0, 'High Explorer Dellorah to Player'),
(33701, 2, 0, 'Can you detail the nature of these defense systems?', 12, 0, 100, 0, 0, 0, 33706, 0, 'High Explorer Dellorah to Player'),
(33701, 3, 0, 'Got it. At least we don\'t have to deal with those orbital emplacements.', 12, 0, 100, 0, 0, 0, 33708, 0, 'High Explorer Dellorah to Player'),
(33701, 4, 0, 'Rhydian, make sure you let Brann and Archmage Pentarus know about those defenses immediately.', 12, 0, 100, 0, 0, 0, 33709, 0, 'High Explorer Dellorah to Player'),
(33701, 5, 0, 'And you mentioned an imprisoned entity? What is the nature of this entity and what is its status?', 12, 0, 100, 0, 0, 0, 33710, 0, 'High Explorer Dellorah to Player'),
(33701, 6, 0, 'Yogg-Saron is here? It sounds like we really will have our hands full then.', 12, 0, 100, 0, 0, 0, 33713, 0, 'High Explorer Dellorah to Player'),
(33701, 7, 0, 'What... What did you just do, $N?! Brann! Braaaaannn!', 14, 0, 100, 0, 0, 0, 34446, 0, 'High Explorer Dellorah to Player'),
(33701, 8, 0, 'Brann! $N just activated the orbital defense system! If we don\'t get out here soon, we\'re going to be toast!', 14, 0, 100, 0, 0, 0, 34447, 0, 'High Explorer Dellorah to Player');

DELETE FROM `gossip_menu_option` WHERE (`MenuID` = 10366);
INSERT INTO `gossip_menu_option` (`MenuID`, `OptionID`, `OptionIcon`, `OptionText`, `OptionBroadcastTextID`, `OptionType`, `OptionNpcFlag`, `ActionMenuID`, `ActionPoiID`, `BoxCoded`, `BoxMoney`, `BoxText`, `BoxBroadcastTextID`, `VerifiedBuild`) VALUES
(10366, 0, 0, 'Activate secondary defensive systems.', 34420, 1, 1, 0, 0, 0, 0, NULL, 0, 0);

DELETE FROM `waypoints` WHERE `entry`=33701;
INSERT INTO `waypoints` (`entry`, `pointid`, `position_x`, `position_y`, `position_z`, `point_comment`) VALUES
(33701, 1, -767.794, -126.79, 429.83, 'High Explorer Dellorah'),
(33701, 2, -767.925, -97.062, 429.83, 'High Explorer Dellorah'),
(33701, 3, -757.399, -75.726, 429.83, 'High Explorer Dellorah'),
(33701, 4, -742.995, -59.801, 429.83, 'High Explorer Dellorah'),
(33701, 5, -729.309, -50.896, 429.83, 'High Explorer Dellorah'),
(33701, 6, -720.001, -53.098, 429.83, 'High Explorer Dellorah'),
(33701, 7, -723.54, -53.823, 429.83, 'High Explorer Dellorah'),
(33701, 8, -746.544, -62.526, 429.83, 'High Explorer Dellorah'),
(33701, 9, -815.776, -128.782, 429.82, 'High Explorer Dellorah'),
(33701, 10, -856.608, -134.5, 458.89, 'High Explorer Dellorah'),
(33701, 11, -899.84, -140.921, 458.89, 'High Explorer Dellorah'),
(33701, 12, -917.893, -143.652, 464.3, 'High Explorer Dellorah');

-- Hired Enginner
UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 33626;

DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = -136348);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(-136348, 0, 0, 0, 38, 0, 100, 0, 1, 1, 0, 0, 0, 69, 0, 0, 0, 0, 0, 0, 8, 0, 0, 0, 0, -792.043, -44.357, 429.84, 2.41935, 'Hired Engineer - On Data Set 1 1 - Move To Position'),
(-136348, 0, 1, 0, 60, 0, 100, 1, 0, 0, 0, 0, 0, 62, 603, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, -792.043, -44.357, 429.84, 2.41935, 'Hired Engineer - On Update - Teleport (No Repeat)');

DELETE FROM `conditions` WHERE (`SourceEntry` = -136348) AND (`SourceTypeOrReferenceId` = 22) AND (`SourceGroup` = 2);
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `ErrorType`, `ErrorTextId`, `ScriptName`, `Comment`) VALUES
(22, 2, -136348, 0, 0, 13, 1, 800, 3, 0, 0, 0, 0, '', 'Hired Enginner - Set Correct Properties');

-- Brann Bronzebear
UPDATE `creature_template` SET `AIName` = 'SmartAI', `ScriptName` = '' WHERE (`entry` = 33579);

DELETE FROM `waypoints` WHERE `entry`=33579;
INSERT INTO `waypoints` (`entry`, `pointid`, `position_x`, `position_y`, `position_z`, `point_comment`) VALUES
(33579, 1, -699.407, -48.602, 429.42, 'Brann Bronzebeard'),
(33579, 2, -674.782, -45.877, 426.2, 'Brann Bronzebeard');

DELETE FROM `creature_text` WHERE `CreatureID`=33579;
INSERT INTO `creature_text` (`CreatureID`, `GroupID`, `ID`, `Text`, `Type`, `Language`, `Probability`, `Emote`, `Duration`, `Sound`, `BroadcastTextId`, `TextRange`, `comment`) VALUES
(33579, 0, 0, 'Pentarus, you heard the $gman:woman;. Have your mages release the shield and let these brave souls through!', 14, 0, 100, 0, 0, 0, 33671, 0, 'Brann Bronzebeard - Ulduar'),
(33579, 1, 0, 'Okay! Let\'s move out. Get into your machines; I\'ll speak to you from here via the radio.', 12, 0, 100, 0, 0, 0, 33684, 0, 'Brann Bronzebeard - Ulduar'),
(33579, 2, 0, 'Our allies are ready. Bring down the shield and make way!', 14, 0, 100, 0, 0, 0, 33687, 0, 'Brann Bronzebeard - Ulduar'),
(33579, 3, 0, 'The iron dwarves have been seen emerging from the bunkers at the base of the pillars straight ahead of you! Destroy the bunkers, and they\'ll be forced to fall back!', 12, 0, 100, 0, 0, 0, 34145, 0, 'Brann Bronzebeard - Ulduar');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 33579;

DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = 33579);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(33579, 0, 0, 1, 38, 0, 100, 0, 0, 1, 0, 0, 0, 1, 4, 0, 1, 0, 0, 0, 19, 33701, 0, 0, 0, 0, 0, 0, 0, 'Brann Bronzebeard - On Data Set 0 1 - Say Line 0'),
(33579, 0, 1, 0, 61, 0, 100, 0, 0, 1, 0, 0, 0, 45, 1, 1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Brann Bronzebeard - On Data Set 0 1 - Set Data 1 1'),
(33579, 0, 2, 3, 62, 0, 100, 0, 10355, 0, 0, 0, 0, 1, 0, 0, 1, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Brann Bronzebeard - On Gossip Option 0 Selected - Say Line 0'),
(33579, 0, 3, 4, 61, 0, 100, 0, 10355, 0, 0, 0, 0, 45, 1, 1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Brann Bronzebeard - On Gossip Option 0 Selected - Set Data 1 1'),
(33579, 0, 4, 5, 61, 0, 100, 0, 10355, 0, 0, 0, 0, 72, 0, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Brann Bronzebeard - On Gossip Option 0 Selected - Close Gossip'),
(33579, 0, 5, 6, 61, 0, 100, 0, 10355, 0, 0, 0, 0, 83, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Brann Bronzebeard - On Gossip Option 0 Selected - Remove Npc Flags Gossip'),
(33579, 0, 6, 7, 61, 0, 100, 0, 10355, 0, 0, 0, 0, 83, 1, 0, 0, 0, 0, 0, 10, 136605, 33686, 0, 0, 0, 0, 0, 0, 'Brann Bronzebeard - On Gossip Option 0 Selected - Remove Npc Flags Gossip'),
(33579, 0, 7, 0, 61, 0, 100, 0, 10355, 0, 0, 0, 0, 34, 802, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Brann Bronzebeard - On Gossip Option 0 Selected - Set Instance Data 802 to 0'),
(33579, 0, 8, 0, 38, 0, 100, 0, 1, 1, 0, 0, 0, 80, 3357900, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Brann Bronzebeard - On Data Set 1 1 - Run Script'),
(33579, 0, 9, 0, 38, 0, 100, 0, 0, 2, 0, 0, 0, 80, 3357901, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Brann Bronzebeard - On Data Set 0 2 - Run Script'),
(33579, 0, 10, 11, 60, 0, 100, 1, 0, 0, 0, 0, 0, 83, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Brann Bronzebeard - On Update - Remove Npc Flags Gossip (No Repeat)'),
(33579, 0, 11, 12, 61, 0, 100, 0, 0, 0, 0, 0, 0, 62, 603, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, -674.782, -45.877, 426.2, 0.110212, 'Brann Bronzebeard - On Update - Teleport (No Repeat)'),
(33579, 0, 12, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 41, 0, 0, 0, 0, 0, 0, 14, 50363, 194484, 0, 0, 0, 0, 0, 0, 'Brann Bronzebeard - On Update - Despawn Instant (No Repeat)'),
(33579, 0, 13, 0, 60, 0, 100, 1, 0, 0, 0, 0, 0, 34, 100, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Brann Bronzebeard - On Update - Set Instance Data 100 to 0 (No Repeat)'),
(33579, 0, 14, 15, 38, 0, 100, 0, 1, 1, 0, 0, 0, 45, 1, 2, 0, 0, 0, 0, 10, 136761, 33696, 0, 0, 0, 0, 0, 0, 'Brann Bronzebeard - On Data Set 1 1 - Set Data 1 2'),
(33579, 0, 15, 16, 61, 0, 100, 0, 1, 1, 0, 0, 0, 45, 1, 2, 0, 0, 0, 0, 10, 136605, 33686, 0, 0, 0, 0, 0, 0, 'Brann Bronzebeard - On Data Set 1 1 - Set Data 1 2'),
(33579, 0, 16, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 45, 1, 2, 0, 0, 0, 0, 10, 136767, 33701, 0, 0, 0, 0, 0, 0, 'Brann Bronzebeard - On Data Set 1 1 - Set Data 1 2');

DELETE FROM `smart_scripts` WHERE (`source_type` = 9 AND `entryorguid` = 3357900);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(3357900, 9, 0, 0, 0, 0, 100, 0, 8000, 8000, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 10, 136281, 33624, 0, 0, 0, 0, 0, 0, 'Brann Bronzebeard - Actionlist - Say Line 0'),
(3357900, 9, 1, 0, 0, 0, 100, 0, 7000, 7000, 0, 0, 0, 45, 1, 1, 0, 0, 0, 0, 10, 136281, 33624, 0, 0, 0, 0, 0, 0, 'Brann Bronzebeard - Actionlist - Set Data 1 1'),
(3357900, 9, 2, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 45, 1, 1, 0, 0, 0, 0, 10, 136524, 33662, 0, 0, 0, 0, 0, 0, 'Brann Bronzebeard - Actionlist - Set Data 1 1'),
(3357900, 9, 3, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 45, 1, 1, 0, 0, 0, 0, 10, 136537, 33672, 0, 0, 0, 0, 0, 0, 'Brann Bronzebeard - Actionlist - Set Data 1 1'),
(3357900, 9, 4, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 45, 0, 1, 0, 0, 0, 0, 10, 136271, 33622, 0, 0, 0, 0, 0, 0, 'Brann Bronzebeard - Actionlist - Set Data 0 1'),
(3357900, 9, 5, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Brann Bronzebeard - Actionlist - Say Line 1'),
(3357900, 9, 6, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 4, 15807, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Brann Bronzebeard - Actionlist - Play Sound 15807'),
(3357900, 9, 7, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 34, 801, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Brann Bronzebeard - Actionlist - Set Instance Data 801 to 0'),
(3357900, 9, 8, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 45, 0, 1, 0, 0, 0, 0, 11, 33686, 200, 1, 0, 0, 0, 0, 0, 'Brann Bronzebeard - Actionlist - Set Data 0 1'),
(3357900, 9, 9, 0, 0, 0, 100, 0, 3000, 3000, 0, 0, 0, 45, 1, 1, 0, 0, 0, 0, 10, 136348, 33626, 0, 0, 0, 0, 0, 0, 'Brann Bronzebeard - Actionlist - Set Data 1 1'),
(3357900, 9, 10, 0, 0, 0, 100, 0, 2000, 2000, 0, 0, 0, 53, 0, 33579, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Brann Bronzebeard - Actionlist - Start Waypoint');

DELETE FROM `smart_scripts` WHERE (`source_type` = 9 AND `entryorguid` = 3357901);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(3357901, 9, 0, 0, 0, 0, 100, 0, 10000, 10000, 0, 0, 0, 1, 2, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Brann Bronzebeard - Actionlist - Say Line 2'),
(3357901, 9, 1, 0, 0, 0, 100, 0, 8000, 8000, 0, 0, 0, 1, 3, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Brann Bronzebeard - Actionlist - Say Line 3'),
(3357901, 9, 2, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 45, 0, 1, 0, 0, 0, 0, 10, 137508, 33662, 0, 0, 0, 0, 0, 0, 'Brann Bronzebeard - Actionlist - Set Data 0 1'),
(3357901, 9, 3, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 4, 15794, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Brann Bronzebeard - Actionlist - Play Sound 15794'),
(3357901, 9, 4, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 45, 0, 1, 0, 0, 0, 0, 10, 137507, 33662, 0, 0, 0, 0, 0, 0, 'Brann Bronzebeard - Actionlist - Set Data 0 1'),
(3357901, 9, 5, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 45, 0, 1, 0, 0, 0, 0, 10, 137511, 33779, 0, 0, 0, 0, 0, 0, 'Brann Bronzebeard - Actionlist - Set Data 0 1'),
(3357901, 9, 6, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 45, 0, 1, 0, 0, 0, 0, 10, 137510, 33779, 0, 0, 0, 0, 0, 0, 'Brann Bronzebeard - Actionlist - Set Data 0 1'),
(3357901, 9, 7, 0, 0, 0, 100, 0, 5000, 5000, 0, 0, 0, 45, 0, 1, 0, 0, 0, 0, 10, 137509, 33779, 0, 0, 0, 0, 0, 0, 'Brann Bronzebeard - Actionlist - Set Data 0 1'),
(3357901, 9, 8, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 41, 0, 0, 0, 0, 0, 0, 14, 50363, 194484, 0, 0, 0, 0, 0, 0, 'Brann Bronzebeard - Actionlist - Despawn Instant'),
(3357901, 9, 9, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 34, 800, 3, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Brann Bronzebeard - Actionlist - Set Instance Data 800 to 3');

DELETE FROM `conditions` WHERE (`SourceEntry` = 33579) AND (`SourceTypeOrReferenceId` = 22) AND (`SourceGroup` IN (11,14));
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `ErrorType`, `ErrorTextId`, `ScriptName`, `Comment`) VALUES
(22, 11, 33579, 0, 0, 13, 1, 800, 3, 0, 0, 0, 0, '', 'Brann Bronzebeard - Set Correct Properties'),
(22, 14, 33579, 0, 1, 13, 1, 800, 3, 0, 0, 0, 0, '', 'Brann Bronzebeard - Re-spawn vehicles - Intro Completed'),
(22, 14, 33579, 0, 1, 13, 1, 0, 0, 0, 0, 0, 0, '', 'Brann Bronzebeard - Re-spawn vehicles - Leviathan not started');

-- Arch Mage Pentarus
UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 33624;

DELETE FROM `creature_text` WHERE `CreatureID`=33624;
INSERT INTO `creature_text` (`CreatureID`, `GroupID`, `ID`, `Text`, `Type`, `Language`, `Probability`, `Emote`, `Duration`, `Sound`, `BroadcastTextId`, `TextRange`, `comment`) VALUES
(33624, 0, 0, 'Of course, Brann. We will have the shield down momentarily.', 14, 0, 100, 0, 0, 0, 33673, 0, ''),
(33624, 1, 0, 'Mages of the Kirin Tor, on Brann\'s Command, release the shield! Defend this platform and our allies with your lives! For Dalaran!', 14, 0, 100, 0, 0, 0, 33677, 0, '');

DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = 33624);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(33624, 0, 0, 0, 38, 0, 100, 0, 1, 1, 0, 0, 0, 53, 0, 33624, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Archmage Pentarus - On Data Set 1 1 - Start Waypoint'),
(33624, 0, 1, 2, 58, 0, 100, 0, 2, 33624, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Archmage Pentarus - On Waypoint Finished - Say Line 1'),
(33624, 0, 2, 0, 61, 0, 100, 0, 2, 33624, 0, 0, 0, 45, 0, 2, 0, 0, 0, 0, 10, 136253, 33579, 0, 0, 0, 0, 0, 0, 'Archmage Pentarus - On Waypoint Finished - Set Data 0 2'),
(33624, 0, 3, 0, 60, 0, 100, 1, 0, 0, 0, 0, 0, 62, 603, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, -676.52, -84.802, 426.89, 0.054839, 'Archmage Pentarus - On Update - Teleport (No Repeat)');

DELETE FROM `conditions` WHERE (`SourceEntry` = 33624) AND (`SourceTypeOrReferenceId` = 22) AND (`SourceGroup` = 4);
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `ErrorType`, `ErrorTextId`, `ScriptName`, `Comment`) VALUES
(22, 4, 33624, 0, 0, 13, 1, 800, 3, 0, 0, 0, 0, '', 'Archmage Pentarus - Set Correct Properties');

DELETE FROM `waypoints` WHERE `entry`=33624;
INSERT INTO `waypoints` (`entry`, `pointid`, `position_x`, `position_y`, `position_z`, `point_comment`) VALUES
(33624, 1, -696.34, -85.89, 429.24, 'Archmage Pentarus'),
(33624, 2, -676.52, -84.802, 426.89, 'Archmage Pentarus');

-- Teleporter
UPDATE `gameobject_template` SET `ScriptName` = '' WHERE (`entry` = 194569);

DELETE FROM `gameobject` WHERE (`id` = 194569) AND (`guid` IN (56100, 34935, 34923, 34296, 34288, 34283, 34281, 34223, 34219));
INSERT INTO `gameobject` (`guid`, `id`, `map`, `zoneId`, `areaId`, `spawnMask`, `phaseMask`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`, `ScriptName`, `VerifiedBuild`) VALUES
(56100, 194569, 603, 0, 0, 3, 1, 2518.16, 2569.03, 412.299, 0, 0, 0, 0, 1, 180, 255, 1, '', 0),
(34935, 194569, 603, 0, 0, 3, 1, 1498.05, -24.3509, 420.966, 0.034906, 0, 0, 0, 1, 180, 255, 1, '', 0),
(34923, 194569, 603, 0, 0, 3, 1, 1854.82, -11.5608, 334.175, 0, 0, 0, 0, 1, 180, 255, 1, '', 0),
(34296, 194569, 603, 0, 0, 3, 1, 926.292, -11.4635, 418.595, -0.017452, 0, 0, 0, 1, 180, 255, 1, '', 0),
(34288, 194569, 603, 0, 0, 3, 1, 131.248, -35.3802, 409.804, 0, 0, 0, 0, 1, 180, 255, 1, '', 0),
(34283, 194569, 603, 0, 0, 3, 1, -706.122, -92.6024, 429.876, 0, 0, 0, 0, 1, 180, 255, 1, '', 0),
(34281, 194569, 603, 0, 0, 3, 1, 2086.26, -23.9948, 421.316, 0, 0, 0, 0, 1, 180, 255, 1, '', 0),
(34223, 194569, 603, 0, 0, 3, 1, 553.233, -12.3247, 409.679, 0, 0, 0, 0, 1, 180, 255, 1, '', 0),
(34219, 194569, 603, 0, 0, 3, 1, 1859.65, -24.9121, 448.811, 0, 0, 0, 0, 1, 180, 255, 1, '', 0);

DELETE FROM `conditions` WHERE (`SourceTypeOrReferenceId` = 15) AND (`SourceGroup` = 10389);
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `ErrorType`, `ErrorTextId`, `ScriptName`, `Comment`) VALUES
(15, 10389, 0, 0, 0, 13, 1, 0, 0, 0, 1, 0, 0, '', 'Ulduar Teleporter - Expedition Base Camp'),
(15, 10389, 1, 0, 0, 13, 1, 0, 0, 0, 1, 0, 0, '', 'Ulduar Teleporter - Formation Grounds'),
(15, 10389, 2, 0, 0, 13, 1, 0, 3, 0, 0, 0, 0, '', 'Ulduar Teleporter - Colossal Forge'),
(15, 10389, 3, 0, 0, 13, 1, 3, 3, 0, 0, 0, 0, '', 'Ulduar Teleporter - Scrapyard'),
(15, 10389, 4, 0, 0, 13, 1, 3, 3, 0, 0, 0, 0, '', 'Ulduar Teleporter - Antechamber of Ulduar'),
(15, 10389, 5, 0, 0, 13, 1, 5, 3, 0, 0, 0, 0, '', 'Ulduar Teleporter - Shattered Walkway'),
(15, 10389, 6, 0, 0, 13, 1, 6, 3, 0, 0, 0, 0, '', 'Ulduar Teleporter - Conservatory of Life'),
(15, 10389, 7, 0, 0, 13, 1, 710, 0, 0, 1, 0, 0, '', 'Ulduar Teleporter - Spark of Imagination'),
(15, 10389, 8, 0, 0, 13, 1, 11, 3, 0, 0, 0, 0, '', 'Ulduar Teleporter - Prison of Yogg-Saron');

DELETE FROM `conditions` WHERE (`SourceTypeOrReferenceId` = 22) AND (`SourceEntry` = 194569);
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `ErrorType`, `ErrorTextId`, `ScriptName`, `Comment`) VALUES
(22, 2, 194569, 1, 0, 13, 1, 0, 0, 0, 1, 0, 0, '', 'Ulduar Teleporter - Enable');

UPDATE `gameobject_template` SET `AIName` = 'SmartGameObjectAI' WHERE `entry` = 194569;

DELETE FROM `smart_scripts` WHERE (`source_type` = 1 AND `entryorguid` = 194569);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(194569, 1, 0, 0, 60, 0, 100, 1, 0, 0, 0, 0, 0, 105, 16, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Ulduar Teleporter - On Update - Add Gameobject Flags Not Selectable (No Repeat)'),
(194569, 1, 1, 2, 60, 0, 100, 1, 0, 0, 0, 0, 0, 106, 16, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Ulduar Teleporter - On Update - Remove Gameobject Flags Not Selectable (No Repeat)'),
(194569, 1, 2, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 202, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Ulduar Teleporter - On Update - Set GO state to 0 (No Repeat)'),
(194569, 1, 3, 12, 62, 0, 100, 0, 10389, 0, 0, 0, 0, 11, 64014, 2, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Ulduar Teleporter - On Gossip Option 0 Selected - Cast \'Expedition Base Camp Teleport\''),
(194569, 1, 4, 12, 62, 0, 100, 0, 10389, 1, 0, 0, 0, 11, 64032, 2, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Ulduar Teleporter - On Gossip Option 1 Selected - Cast \'Formation Grounds Teleport\''),
(194569, 1, 5, 12, 62, 0, 100, 0, 10389, 2, 0, 0, 0, 11, 64028, 2, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Ulduar Teleporter - On Gossip Option 2 Selected - Cast \'Colossal Forge Teleport\''),
(194569, 1, 6, 12, 62, 0, 100, 0, 10389, 3, 0, 0, 0, 11, 64031, 2, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Ulduar Teleporter - On Gossip Option 3 Selected - Cast \'Scrapyard Teleport\''),
(194569, 1, 7, 12, 62, 0, 100, 0, 10389, 4, 0, 0, 0, 11, 64030, 2, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Ulduar Teleporter - On Gossip Option 4 Selected - Cast \'Antechamber Teleport\''),
(194569, 1, 8, 12, 62, 0, 100, 0, 10389, 5, 0, 0, 0, 11, 64029, 2, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Ulduar Teleporter - On Gossip Option 5 Selected - Cast \'Shattered Walkway Teleport\''),
(194569, 1, 9, 12, 62, 0, 100, 0, 10389, 6, 0, 0, 0, 11, 64024, 2, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Ulduar Teleporter - On Gossip Option 6 Selected - Cast \'Conservatory Teleport\''),
(194569, 1, 10, 12, 62, 0, 100, 0, 10389, 7, 0, 0, 0, 11, 64025, 2, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Ulduar Teleporter - On Gossip Option 7 Selected - Cast \'Halls of Invention Teleport\''),
(194569, 1, 11, 12, 62, 0, 100, 0, 10389, 8, 0, 0, 0, 11, 65042, 2, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Ulduar Teleporter - On Gossip Option 8 Selected - Cast \'Prison of Yogg-Saron Teleport\''),
(194569, 1, 12, 0, 61, 0, 100, 0, 10389, 0, 0, 0, 0, 72, 0, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Ulduar Teleporter - On Gossip Option 0 Selected - Close Gossip');

DELETE FROM `spell_target_position` WHERE (ID IN (64014,64032,64028,64031,64030,64029));
INSERT INTO `spell_target_position` (`ID`, `EffectIndex`, `MapID`, `PositionX`, `PositionY`, `PositionZ`, `Orientation`, `VerifiedBuild`) VALUES 
(64014, 1, 603, -706.122, -92.602, 430.27, 0.110212, 0),
(64032, 1, 603, 131.248, -35.38, 410.2, 3.176500, 0),
(64028, 1, 603, 553.233, -12.324, 410.07, 3.176500, 0),
(64031, 1, 603, 926.292, -11.463, 418.99, 3.134592, 0),
(64030, 1, 603, 1498.09, -24.246, 421.36, 6.276185, 0),
(64029, 1, 603, 1859.72, -24.884, 449.21, 3.110162, 0),
(64024, 1, 603, 2086.28, -23.963, 421.71, 3.110162, 0),
(64025, 1, 603, 1854.8, -11.46, 334.57, 4.792662, 0),
(65042, 1, 603, 2518.22, 2569.11, 412.69, 3.106680, 0);

DELETE FROM `gossip_menu_option` WHERE (`MenuID` = 10389);
INSERT INTO `gossip_menu_option` (`MenuID`, `OptionID`, `OptionIcon`, `OptionText`, `OptionBroadcastTextID`, `OptionType`, `OptionNpcFlag`, `ActionMenuID`, `ActionPoiID`, `BoxCoded`, `BoxMoney`, `BoxText`, `BoxBroadcastTextID`, `VerifiedBuild`) VALUES
(10389, 0, 0, 'Teleport to the Expedition Base Camp.', 33919, 1, 0, 0, 0, 0, 0, '', 0, 0),
(10389, 1, 0, 'Teleport to the Formation Grounds.', 33920, 1, 0, 0, 0, 0, 0, '', 0, 0),
(10389, 2, 0, 'Teleport to the Colossal Forge.', 33921, 1, 0, 0, 0, 0, 0, '', 0, 0),
(10389, 3, 0, 'Teleport to the Scrapyard.', 33922, 1, 0, 0, 0, 0, 0, '', 0, 0),
(10389, 4, 0, 'Teleport to the Antechamber of Ulduar.', 33923, 1, 0, 0, 0, 0, 0, '', 0, 0),
(10389, 5, 0, 'Teleport to the Shattered Walkway.', 33924, 1, 0, 0, 0, 0, 0, '', 0, 0),
(10389, 6, 0, 'Teleport to the Conservatory of Life.', 33926, 1, 0, 0, 0, 0, 0, '', 0, 0),
(10389, 7, 0, 'Teleport to the Spark of Imagination.', 33927, 1, 0, 0, 0, 0, 0, '', 0, 0),
(10389, 8, 0, 'Teleport to the Prison of Yogg-Saron.', 33928, 1, 0, 0, 0, 0, 0, '', 0, 0); 

-- Add the script to the 48310 id spell
DELETE FROM `spell_script_names` WHERE `spell_id`=48310;
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES (48310, 'spell_transitus_shield_beam');

--
-- END UPDATING QUERIES
--
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
