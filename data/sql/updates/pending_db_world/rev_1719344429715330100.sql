-- Lashh'an Wing Guard
DELETE FROM `creature_text` WHERE `CreatureID` = 19944;
INSERT INTO `creature_text` (`CreatureID`, `GroupID`, `ID`, `Text`, `Type`, `Language`, `Probability`, `Emote`, `Duration`, `Sound`, `BroadcastTextId`, `TextRange`, `comment`) VALUES
(19944, 0, 0, '%s makes a break for the nearest rune circle.', 16, 0, 100, 0, 0, 0, 19473, 0, 'Lashh\'an Wing Guard - Run to circle');

DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` IN (21470,19944));
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(19944, 0, 0, 0, 0, 0, 100, 0, 3500, 4000, 10500, 14500, 0, 0, 11, 37577, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Lashh\'an Wing Guard - In Combat - Cast \'Debilitating Strike\''),
(19944, 0, 1, 0, 2, 0, 100, 0, 0, 20, 0, 0, 0, 0, 80, 1994400, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Lashh\'an Wing Guard - Between 0-20% Health - Run Script'),
(19944, 0, 2, 0, 34, 0, 100, 0, 8, 0, 0, 0, 0, 0, 80, 1994401, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Lashh\'an Wing Guard - On Reached Point 0 - Run Script'),
(19944, 0, 3, 0, 17, 0, 100, 0, 0, 0, 0, 0, 0, 0, 49, 0, 0, 0, 0, 0, 0, 5, 0, 0, 0, 0, 0, 0, 0, 0, 'Lashh\'an Wing Guard - On Summoned Unit - Start Attacking'),
(19944, 0, 4, 0, 25, 0, 100, 0, 0, 0, 0, 0, 0, 0, 8, 2, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Lashh\'an Wing Guard - On Reset - Set Reactstate Aggressive');

DELETE FROM `smart_scripts` WHERE (`source_type` = 9 AND `entryorguid` IN (1994400,1994401));
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(1994400, 9, 0, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Lashh\'an Wing Guard - Actionlist - Say Line 0'),
(1994400, 9, 1, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 69, 0, 0, 0, 0, 0, 0, 20, 184826, 100, 0, 0, 0, 0, 0, 0, 'Lashh\'an Wing Guard - Actionlist - Move To Closest Object \'Lashh\'an Circle Spell Focus\''),
(1994400, 9, 2, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 8, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Lashh\'an Wing Guard - Actionlist - Set Reactstate Passive'),
(1994400, 9, 3, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 224, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Lashh\'an Wing Guard - Actionlist - Stop Attack'),
(1994401, 9, 0, 0, 0, 0, 100, 0, 1000, 1000, 0, 0, 0, 0, 12, 21470, 2, 60000, 1, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Lashh\'an Wing Guard - Actionlist - Summon Creature \'Angered Arakkoa Protector\''),
(1994401, 9, 1, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 8, 2, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Lashh\'an Wing Guard - Actionlist - Set Reactstate Aggressive'),
(1994401, 9, 2, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 49, 0, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Lashh\'an Wing Guard - Actionlist - Start Attacking');

DELETE FROM `conditions` WHERE (`SourceTypeOrReferenceId` = 22) AND (`SourceGroup` = 2) AND (`SourceEntry` = 19944);
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `ErrorType`, `ErrorTextId`, `ScriptName`, `Comment`) VALUES
(22, 2, 19944, 0, 0, 30, 1, 184826, 100, 0, 0, 0, 0, '', 'Only execute SAI if Object Lashh\'an Circle Spell Focus is within 100y');

-- Angered Arakkoa Protector
DELETE FROM `creature` WHERE (`id1` = 21470);
UPDATE `creature_template` SET `AIName` = '' WHERE `entry` = 21470;

-- Lashh'an Circle Spell Focus
DELETE FROM `gameobject` WHERE `guid` = 99988 AND `id` = 184826;
INSERT INTO `gameobject` (`guid`, `id`, `map`, `zoneId`, `areaId`, `spawnMask`, `phaseMask`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`, `ScriptName`, `VerifiedBuild`, `Comment`) VALUES
(99988, 184826, 530, 0, 0, 1, 1, 1637.02, 6998.45, 158.32, 1.3090, 0, 0, 0, 0, 180, 0, 1, '', 0, NULL);
