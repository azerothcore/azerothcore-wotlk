-- DB update 2025_02_07_04 -> 2025_02_09_00
-- Kaylaan smart ai
SET @ENTRY := 20780;
UPDATE `creature_template` SET `AIName` = 'SmartAI', `ScriptName` = '' WHERE `entry` = @ENTRY;
DELETE FROM `smart_scripts` WHERE `source_type` = 0 AND `entryOrGuid` = @ENTRY;
DELETE FROM `smart_scripts` WHERE `source_type` = 9 AND `entryOrGuid` IN (@ENTRY * 100);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(@ENTRY, 0, 0, 0, 1, 0, 100, 0, 0, 0, 74000, 105000, 0, 0, 80, @ENTRY * 100, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Kaylaan - Out of Combat - Run Script'),
(@ENTRY * 100, 9, 0, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Kaylaan - Actionlist - Say Line 0'),
(@ENTRY * 100, 9, 1, 0, 0, 0, 100, 0, 2000, 2000, 0, 0, 0, 0, 11, 35746, 0, 0, 0, 0, 0, 19, 20922, 10, 0, 0, 0, 0, 0, 'Kaylaan - Actionlist - Cast \'Resurrection\''),
(@ENTRY * 100, 9, 2, 0, 0, 0, 100, 0, 8000, 8000, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Kaylaan - Actionlist - Say Line 1');

-- Add creature spawn
SET @CGUID := 425;
DELETE FROM `creature` WHERE `id1` = 20922 AND `guid` = @CGUID;
INSERT INTO `creature` (`guid`, `id1`, `id2`, `id3`, `map`, `zoneId`, `areaId`, `spawnMask`, `phaseMask`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `wander_distance`, `currentwaypoint`, `curhealth`, `curmana`, `MovementType`, `npcflag`, `unit_flags`, `dynamicflags`, `ScriptName`, `VerifiedBuild`) VALUES
(@CGUID, 20922, 0, 0, 530, 3523, 3852, 1, 1, 0, 4034.83203125, 3545.646728515625, 121.47908782958984, 2.670353651046753, 120, 0, 0, 6986, 0, 0, 0, 0, 0, '', 58629);

-- aura 29266 Permanent Feign Death
DELETE FROM `creature_addon` WHERE (`guid` IN (@CGUID));
INSERT INTO `creature_addon` (`guid`, `path_id`, `mount`, `bytes1`, `bytes2`, `emote`, `visibilityDistanceType`, `auras`) VALUES
(@CGUID, 0, 0, 0, 1, 0, 0, '29266');

-- add creature_text
DELETE FROM `creature_text` WHERE `CreatureID` = 20780;
INSERT INTO `creature_text` (`CreatureID`, `GroupID`, `ID`, `Text`, `Type`, `Language`, `Probability`, `Emote`, `Duration`, `Sound`, `BroadcastTextId`, `TextRange`, `comment`) VALUES
(20780, 0, 1, 'Light!  Do not fail me!', 12, 0, 100, 274, 0, 0, 18385, 0, 'Kaylaan'),
(20780, 0, 2, 'Do not die on me, vindicator!', 12, 0, 100, 0, 0, 0, 18386, 0, 'Kaylaan'),
(20780, 0, 3, 'Kael\'thas and the Legion... just what we needed!', 12, 0, 100, 0, 0, 0, 18387, 0, 'Kaylaan'),
(20780, 1, 0, 'It is hopeless... I\'ve done all I can.', 12, 0, 100, 274, 0, 0, 18594, 0, 'Kaylaan'),
(20780, 1, 1, 'I\'ve failed.  The Light has abandoned me.', 12, 0, 100, 274, 0, 0, 18595, 0, 'Kaylaan');
