-- DB update 2025_11_09_02 -> 2025_11_09_03
--
-- Fixes "Bluff", Set `allowOverride` of action list
UPDATE `smart_scripts` SET `action_param3` = 1 WHERE (`entryorguid` IN (23672, 23673, 23675, 24271)) AND (`source_type` = 0) AND (`event_type` = 8) AND (`event_param1` = 44609);

-- Removes double spawns
DELETE FROM `gameobject` WHERE `id` = 186959 AND `guid` IN (264459, 264460, 264461, 264462, 264463, 264464, 264465);

-- Add missing aura. Usage is unknown
DELETE FROM `creature_template_addon` WHERE (`entry` = 24825);
INSERT INTO `creature_template_addon` (`entry`, `path_id`, `mount`, `bytes1`, `bytes2`, `emote`, `visibilityDistanceType`, `auras`) VALUES
(24825, 0, 0, 0, 0, 0, 0, '44652');

-- Disable flying vehicle, but causes camera stuttering on rocket jump
UPDATE `creature_template_movement` SET `Flight` = 0 WHERE (`CreatureId` = 24825);

DELETE FROM `creature_text` WHERE (`CreatureID` = 24825) AND (`GroupID` = 1);
INSERT INTO `creature_text` (`CreatureID`, `GroupID`, `ID`, `Text`, `Type`, `Language`, `Probability`, `Emote`, `Duration`, `Sound`, `BroadcastTextId`, `TextRange`, `comment`) VALUES
(24825, 1, 0, 'Launching.', 12, 0, 100, 0, 0, 0, 23860, 0, 'Iron Rune Construct');

DELETE FROM `smart_scripts` WHERE (`entryorguid` = 24825) AND (`source_type` = 0) AND (`id` IN (15, 16));
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(24825, 0, 15, 0, 31, 0, 100, 512, 44609, 0, 3000, 3000, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Iron Rune Construct - On Spellhit \'Bluff\' - Say Line 0'),
(24825, 0, 16, 0, 8, 0, 100, 512, 44626, 0, 5000, 5000, 0, 0, 1, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Iron Rune Construct - On Spellhit \'Rocket Jump\' - Say Line 1');
-- Remove unused 'Say Line 0' in actionscripts
DELETE FROM `smart_scripts` WHERE (`entryorguid` IN (2367201, 2367301, 2367501, 2427101)) AND `source_type` = 9 AND `id` = 1 AND `target_type` = 19 AND `target_param1` = 24825 AND `action_type` = 1 AND `target_param2` = 20;

DELETE FROM `conditions` WHERE (`SourceTypeOrReferenceId` = 13) AND (`SourceGroup` IN (2, 4)) AND (`SourceEntry` = 44608) AND (`SourceId` = 0) AND (`ConditionTypeOrReference` = 31);
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `ErrorType`, `ErrorTextId`, `ScriptName`, `Comment`) VALUES
(13, 4, 44608, 0, 0, 31, 0, 3, 24826, 0, 0, 0, 0, '', 'Rocket Jump'),
(13, 4, 44608, 0, 1, 31, 0, 3, 24827, 0, 0, 0, 0, '', 'Rocket Jump'),
(13, 4, 44608, 0, 2, 31, 0, 3, 24828, 0, 0, 0, 0, '', 'Rocket Jump'),
(13, 4, 44608, 0, 3, 31, 0, 3, 24829, 0, 0, 0, 0, '', 'Rocket Jump'),
(13, 4, 44608, 0, 4, 31, 0, 3, 24831, 0, 0, 0, 0, '', 'Rocket Jump'),
(13, 4, 44608, 0, 5, 31, 0, 3, 24832, 0, 0, 0, 0, '', 'Rocket Jump'),
(13, 2, 44608, 0, 0, 31, 0, 5, 186953, 0, 0, 0, 0, '', 'Rocket Jump'),
(13, 2, 44608, 0, 1, 31, 0, 5, 186960, 0, 0, 0, 0, '', 'Rocket Jump'),
(13, 2, 44608, 0, 2, 31, 0, 5, 186961, 0, 0, 0, 0, '', 'Rocket Jump'),
(13, 2, 44608, 0, 3, 31, 0, 5, 186963, 0, 0, 0, 0, '', 'Rocket Jump'),
(13, 2, 44608, 0, 4, 31, 0, 5, 186962, 0, 0, 0, 0, '', 'Rocket Jump'),
(13, 2, 44608, 0, 5, 31, 0, 5, 186964, 0, 0, 0, 0, '', 'Rocket Jump');

DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = 24825);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(24825, 0, 0, 0, 54, 0, 100, 512, 0, 0, 0, 0, 0, 0, 75, 44643, 0, 0, 0, 0, 0, 23, 0, 0, 0, 0, 0, 0, 0, 0, 'Iron Rune Construct - On Just Summoned - Add Aura \'Reputation and Language\''),
(24825, 0, 1, 0, 28, 0, 100, 512, 0, 0, 0, 0, 0, 0, 28, 44643, 0, 0, 0, 0, 0, 23, 0, 0, 0, 0, 0, 0, 0, 0, 'Iron Rune Construct - On Passenger Removed - Remove Aura \'Reputation and Language\''),
(24825, 0, 2, 0, 38, 0, 100, 512, 0, 1, 0, 0, 0, 0, 53, 2, 24826, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Iron Rune Construct - On Data Set 0 1 - Start Waypoint Path 24826'),
(24825, 0, 3, 0, 38, 0, 100, 512, 0, 2, 0, 0, 0, 0, 53, 2, 24827, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Iron Rune Construct - On Data Set 0 2 - Start Waypoint Path 24827'),
(24825, 0, 4, 0, 38, 0, 100, 512, 0, 3, 0, 0, 0, 0, 53, 2, 24828, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Iron Rune Construct - On Data Set 0 3 - Start Waypoint Path 24828'),
(24825, 0, 5, 0, 38, 0, 100, 512, 0, 4, 0, 0, 0, 0, 53, 2, 24831, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Iron Rune Construct - On Data Set 0 4 - Start Waypoint Path 24831'),
(24825, 0, 6, 0, 38, 0, 100, 512, 0, 5, 0, 0, 0, 0, 53, 2, 24829, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Iron Rune Construct - On Data Set 0 5 - Start Waypoint Path 24829'),
(24825, 0, 7, 0, 38, 0, 100, 512, 0, 6, 0, 0, 0, 0, 53, 2, 24832, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Iron Rune Construct - On Data Set 0 6 - Start Waypoint Path 24832'),
(24825, 0, 8, 0, 58, 0, 100, 512, 0, 0, 0, 0, 0, 0, 28, 44626, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Iron Rune Construct - On Path 0 Finished - Remove Aura \'Rocket Jump\''),
(24825, 0, 9, 0, 31, 0, 100, 512, 44609, 0, 3000, 3000, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Iron Rune Construct - On Target Spellhit \'Bluff\' - Say Line 0'),
(24825, 0, 10, 0, 8, 0, 100, 512, 44626, 0, 5000, 5000, 0, 0, 1, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Iron Rune Construct - On Spellhit \'Rocket Jump\' - Say Line 1');
--
UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE (`entry` IN (24826, 24827, 24828, 24829, 24831, 24832));
DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` IN (24826, 24827, 24828, 24829, 24831, 24832));
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(24826, 0, 0, 0, 8, 0, 100, 0, 44608, 0, 0, 0, 0, 0, 45, 0, 1, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'On Spellhit \'Rocket Jump\' - Set Data 0 1'),
(24827, 0, 0, 0, 8, 0, 100, 0, 44608, 0, 0, 0, 0, 0, 45, 0, 2, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'On Spellhit \'Rocket Jump\' - Set Data 0 2'),
(24828, 0, 0, 0, 8, 0, 100, 0, 44608, 0, 0, 0, 0, 0, 45, 0, 3, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'On Spellhit \'Rocket Jump\' - Set Data 0 3'),
(24831, 0, 0, 0, 8, 0, 100, 0, 44608, 0, 0, 0, 0, 0, 45, 0, 4, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'On Spellhit \'Rocket Jump\' - Set Data 0 4'),
(24829, 0, 0, 0, 8, 0, 100, 0, 44608, 0, 0, 0, 0, 0, 45, 0, 5, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'On Spellhit \'Rocket Jump\' - Set Data 0 5'),
(24832, 0, 0, 0, 8, 0, 100, 0, 44608, 0, 0, 0, 0, 0, 45, 0, 6, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'On Spellhit \'Rocket Jump\' - Set Data 0 6');

DELETE FROM `smart_scripts` WHERE `source_type` = 9 AND `entryorguid` IN (2482600, 2482700, 2482800, 2482900, 2483100, 2483200);
