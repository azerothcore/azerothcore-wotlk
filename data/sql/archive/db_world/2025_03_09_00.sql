-- DB update 2025_03_08_01 -> 2025_03_09_00
-- add creature
SET @CGUID := 502;
DELETE FROM `creature` WHERE `id1` = 26280 AND `guid` = @CGUID;
INSERT INTO `creature` (`guid`, `id1`, `id2`, `id3`, `map`, `zoneId`, `areaId`, `spawnMask`, `phaseMask`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `wander_distance`, `currentwaypoint`, `curhealth`, `curmana`, `MovementType`, `npcflag`, `unit_flags`, `dynamicflags`, `ScriptName`, `VerifiedBuild`, `CreateObject`, `Comment`) VALUES
(@CGUID, 26280, 0, 0, 571, 65, 4157, 1, 1, 1, 3373.642822265625, 2584.31494140625, 42.15882492065429687, 1.623156189918518066, 120, 0, 0, 9291, 3231, 0, 0, 0, 0, '', 58629, 0, 'has guid specific SAI');

-- This creature is not a fighting stance
DELETE FROM `creature_addon` WHERE (`guid` IN (@CGUID));
INSERT INTO `creature_addon` (`guid`, `path_id`, `mount`, `bytes1`, `bytes2`, `emote`, `visibilityDistanceType`, `auras`) VALUES
(@CGUID, 0, 0, 0, 1, 0, 0, '');

-- Dragonblight Mage Hunter with guid 502 smart ai
SET @ENTRY := -1 * @CGUID;
UPDATE `creature_template` SET `AIName` = 'SmartAI', `ScriptName` = '' WHERE `entry` = 26280;
DELETE FROM `smart_scripts` WHERE `source_type` = 0 AND `entryOrGuid` = @ENTRY;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(@ENTRY, 0, 0, 0, 21, 0, 100, 0, 0, 0, 0, 0, 0, 0, 45, 0, 1, 0, 0, 0, 0, 10, 200124, 26496, 0, 0, 0, 0, 0, 'On home reached - Creature (26496) with guid 200124 (fetching): Set creature data #0 to 1'),
(@ENTRY, 0, 1, 0, 11, 0, 100, 0, 0, 0, 0, 0, 0, 0, 45, 0, 1, 0, 0, 0, 0, 10, 200124, 26496, 0, 0, 0, 0, 0, 'On respawn - Creature(26496) with guid 200124 (fetching): Set creature data #0 to 1'),
(@ENTRY, 0, 2, 0, 38, 0, 100, 0, 0, 1, 0, 0, 0, 0, 70, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Dragonblight Mage Hunter - On Data Set 0 1 - Respawn Self');

DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId` = 22 AND `SourceEntry` = @ENTRY  AND `SourceId` = 0;
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `Comment`) VALUES
(22, 3, @ENTRY, 0, 0, 36, 1, 0, 0, 0, 1, 'Dragonblight Mage Hunter must be dead to execute SAI (respawn)');

-- 134217728 - CREATURE_FLAG_EXTRA_DONT_OVERRIDE_SAI_ENTRY
UPDATE `creature_template` SET `flags_extra`=`flags_extra`|134217728 WHERE (`entry` = 26280);

-- Wind Trader Mu'fah smart ai
SET @ENTRY := 26496;
UPDATE `creature_template` SET `AIName` = 'SmartAI', `ScriptName` = '' WHERE `entry` = @ENTRY;
DELETE FROM `smart_scripts` WHERE `source_type` = 0 AND `entryOrGuid` = @ENTRY;
DELETE FROM `smart_scripts` WHERE `source_type` = 9 AND `entryOrGuid` IN (@ENTRY * 100);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(@ENTRY, 0, 0, 0, 9, 0, 100, 0, 0, 0, 11000, 15000, 0, 20, 11, 51817, 0, 0, 0, 0, 0, 5, 0, 0, 0, 0, 0, 0, 0, 'Wind Trader Mu\'fah - Within 0-20 Range - Cast \'Typhoon\''),
(@ENTRY, 0, 1, 0, 4, 0, 100, 0, 0, 0, 0, 0, 0, 0, 1, 1, 0, 1, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 'On aggro - Self: Talk 1 to Attacked unit'),
(@ENTRY, 0, 2, 3, 11, 0, 100, 0, 0, 0, 0, 0, 0, 0, 45, 0, 1, 0, 0, 0, 0, 10, @CGUID, 26280, 0, 0, 0, 0, 0, 'On respawn - Creature (26280) with guid 502 (fetching): Set creature data #0 to 1'),
(@ENTRY, 0, 3, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 11, 12980, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Wind Trader Mu\'fah - On Respawn - Cast \'Simple Teleport\''),
(@ENTRY, 0, 4, 0, 1, 0, 100, 0, 1000, 1000, 45000, 60000, 0, 0, 80, @ENTRY * 100, 0, 1, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Wind Trader Mu\'fah - Out of Combat - Run Script'),
(@ENTRY * 100, 9, 0, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Wind Trader Mu\'fah Talk 0 to invoker'),
(@ENTRY * 100, 9, 1, 0, 0, 0, 100, 0, 8000, 8000, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 10, @CGUID, 26280, 0, 0, 0, 0, 0, 'Creature with guid 502 (fetching): Talk 0 to invoker'),
(@ENTRY, 0, 5, 0, 21, 0, 100, 0, 0, 0, 0, 0, 0, 0, 45, 0, 1, 0, 0, 0, 0, 10, @CGUID, 26280, 0, 0, 0, 0, 0, 'On home reached - Creature (26280) with guid 502 (fetching): Set creature data #0 to 1'),
(@ENTRY, 0, 6, 0, 38, 0, 100, 0, 0, 1, 0, 0, 0, 0, 70, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'On data[0] set to 1 - Self: Set respawn timer to 0 ms');

DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId` = 22 AND `SourceEntry` = @ENTRY AND `SourceId` = 0;
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `Comment`) VALUES
(22, 7, @ENTRY, 0, 0, 36, 1, 0, 0, 0, 1, 'Wind Trader Mu\'fah must be dead to execute SAI (respawn)');

DELETE FROM `creature_text` WHERE `CreatureID` = 26496;
INSERT INTO `creature_text` (`CreatureID`, `GroupID`, `ID`, `Text`, `Type`, `Language`, `Probability`, `Emote`, `Duration`, `Sound`, `BroadcastTextId`, `TextRange`, `comment`) VALUES
(26496, 0, 0, 'You will tell your commander that I will not wait a moment longer! Does he want this alliance or not?!', 12, 0, 100, 396, 0, 0, 25707, 0, 'Wind Trader Mu\'fah'),
(26496, 0, 1, 'I have been waiting here for an eternity since our last meeting! When will Goramosh be done with his ritual?', 12, 0, 100, 396, 0, 0, 25708, 0, 'Wind Trader Mu\'fah'),
(26496, 0, 2, 'This is insufferable! I represent a nexus-prince, I am not to be made to wait! Goramosh should be waiting on me!', 12, 0, 100, 15, 0, 0, 25710, 0, 'Wind Trader Mu\'fah'),
(26496, 0, 3, 'I was personally assured by Malygos that your commander would make the details of this accord his top priority. Now let me pass!', 12, 0, 100, 15, 0, 0, 25711, 0, 'Wind Trader Mu\'fah'),
(26496, 0, 4, 'If I have to wait much longer, I will be forced to reconsider the proposed accord between the Ethereum and the Blue Dragonflight!', 12, 0, 100, 15, 0, 0, 25712, 0, 'Wind Trader Mu\'fah'),
(26496, 0, 5, 'You are nothing but an underling! I will not wait a moment longer! Escort me to Goramosh immediately!', 12, 0, 100, 396, 0, 0, 25713, 0, 'Wind Trader Mu\'fah'),
(26496, 0, 6, 'Yes, yes, I am given to understand that the ley line has already been diverted. I will wait no longer... summon Goramosh this instant!', 12, 0, 100, 15, 0, 0, 25735, 0, 'Wind Trader Mu\'fah'),
(26496, 0, 7, 'Your surge needle appears to have worked perfectly.  Surely Goramosh now has time to speak further of the proposed accord?', 12, 0, 100, 396, 0, 0, 25736, 0, 'Wind Trader Mu\'fah'),
(26496, 1, 0, 'What\'s this, more delays?!', 12, 0, 100, 0, 0, 0, 25715, 0, 'Wind Trader Mu\'fah');

DELETE FROM `creature_text` WHERE `CreatureID` = 26280;
INSERT INTO `creature_text` (`CreatureID`, `GroupID`, `ID`, `Text`, `Type`, `Language`, `Probability`, `Emote`, `Duration`, `Sound`, `BroadcastTextId`, `TextRange`, `comment`) VALUES
(26280, 0, 0, 'I cannot.', 12, 0, 100, 396, 0, 0, 25912, 0, 'Dragonblight Mage Hunter'),
(26280, 0, 1, 'No.', 12, 0, 100, 396, 0, 0, 25913, 0, 'Dragonblight Mage Hunter'),
(26280, 0, 2, 'You\'ll have to be patient.', 12, 0, 100, 396, 0, 0, 25914, 0, 'Dragonblight Mage Hunter'),
(26280, 0, 3, 'Goramosh is busy with a ritual right now.', 12, 0, 100, 396, 0, 0, 25915, 0, 'Dragonblight Mage Hunter'),
(26280, 0, 4, 'My orders are that you must wait here.', 12, 0, 100, 396, 0, 0, 25916, 0, 'Dragonblight Mage Hunter'),
(26280, 0, 5, 'The master will be with you momentarily.', 12, 0, 100, 396, 0, 0, 25917, 0, 'Dragonblight Mage Hunter'),
(26280, 0, 6, 'It won\'t be long now.', 12, 0, 100, 396, 0, 0, 25918, 0, 'Dragonblight Mage Hunter'),
(26280, 0, 7, 'My apologies, ambassador. My orders were quite clear.', 12, 0, 100, 396, 0, 0, 25919, 0, 'Dragonblight Mage Hunter');
