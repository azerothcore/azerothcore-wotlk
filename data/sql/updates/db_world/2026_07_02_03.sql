-- DB update 2026_07_02_02 -> 2026_07_02_03
-- Cross-talk text for Infected Kodo Beast delivery
DELETE FROM `creature_text` WHERE `CreatureID` = 25596 AND `GroupID` IN (1, 2);
INSERT INTO `creature_text` (`CreatureID`, `GroupID`, `ID`, `Text`, `Type`, `Language`, `Probability`, `Emote`, `Duration`, `Sound`, `BroadcastTextId`, `TextRange`, `comment`) VALUES
(25596, 1, 0, 'One more beast saved from certain death!', 12, 0, 0, 0, 0, 0, 26284, 0, ''),
(25596, 1, 1, 'Here\'s your kodo, Torp!', 12, 0, 0, 0, 0, 0, 24881, 0, ''),
(25596, 1, 2, 'Door-to-door kodo delivery!', 12, 0, 0, 0, 0, 0, 24882, 0, ''),
(25596, 1, 3, 'The Scourge are no match for me, Torp!', 12, 0, 0, 0, 0, 0, 26285, 0, ''),
(25596, 1, 4, 'Delivered as promised, Torp!', 12, 0, 0, 0, 0, 0, 26286, 0, '');

-- Cross-talk text for Farmer Torp
DELETE FROM `creature_text` WHERE `CreatureID` = 25607 AND `GroupID` IN (0, 1);
INSERT INTO `creature_text` (`CreatureID`, `GroupID`, `ID`, `Text`, `Type`, `Language`, `Probability`, `Emote`, `Duration`, `Sound`, `BroadcastTextId`, `TextRange`, `comment`) VALUES
(25607, 0, 0, 'YES! It worked!', 12, 0, 0, 4, 0, 0, 24883, 0, ''),
(25607, 0, 1, 'Great job!', 12, 0, 0, 4, 0, 0, 24884, 0, '');

-- Sniffed aura for Infected Kodo Beast (was missing; SAI used to cast the wrong spell instead)
UPDATE `creature_template_addon` SET `auras` = '45771' WHERE `entry` = 25596;
UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 25596;

-- Infected Kodo Beast SAI: despawn 2s after dismount instead of standing stuck
DELETE FROM `smart_scripts` WHERE `entryorguid` = 25596 AND `source_type` = 0;
INSERT INTO `smart_scripts`
    (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`,
     `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`,
     `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`,
     `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`,
     `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`,
     `target_x`, `target_y`, `target_z`, `target_o`, `comment`)
VALUES
    (25596, 0, 0, 1, 27, 0, 100, 512, 0, 0, 0, 0, 0, 0, 28, 45771, 0, 0, 0, 0, 0,
     1, 0, 0, 0, 0, 0, 0, 0, 0, 'Infected Kodo Beast - On Passenger Boarded - Remove Aura \'Scourge Infection\''),
    (25596, 0, 1, 2, 61, 0, 100, 512, 0, 0, 0, 0, 0, 0, 91, 7, 0, 0, 0, 0, 0,
     1, 0, 0, 0, 0, 0, 0, 0, 0, 'Infected Kodo Beast - On Passenger Boarded - Remove Flag Standstate Dead'),
    (25596, 0, 2, 0, 61, 0, 100, 512, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0,
     1, 0, 0, 0, 0, 0, 0, 0, 0, 'Infected Kodo Beast - On Passenger Boarded - Say Line 0'),
    (25596, 0, 3, 4, 8, 0, 100, 512, 45877, 0, 0, 0, 0, 0, 84, 1, 0, 0, 0, 0, 0,
     29, 0, 0, 0, 0, 0, 0, 0, 0, 'Infected Kodo Beast - On Spellhit \'Deliver Kodo\' - Say Line 1'),
    (25596, 0, 4, 5, 61, 0, 100, 512, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 3000, 0, 0,
     10, 42652, 25607, 0, 0, 0, 0, 0, 0, 'Infected Kodo Beast - On Spellhit \'Deliver Kodo\' - Torp Say Line 0'),
    (25596, 0, 5, 0, 61, 0, 100, 512, 0, 0, 0, 0, 0, 0, 203, 0, 0, 0, 0, 0, 0,
     29, 0, 0, 0, 0, 0, 0, 0, 0, 'Infected Kodo Beast - On Spellhit \'Deliver Kodo\' - Exit Vehicle'),
    (25596, 0, 6, 0, 28, 0, 100, 0, 0, 0, 0, 0, 0, 0, 41, 2000, 0, 0, 0, 0, 0,
     1, 0, 0, 0, 0, 0, 0, 0, 0, 'Infected Kodo Beast - On Passenger Removed - Despawn In 2000 ms');

-- Add missing allowed dismount zone (Warsong Slaughterhouse); 3537/4141/4144 already exist
DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId` = 16 AND `SourceGroup` = 0 AND `SourceEntry` = 25596 AND `SourceId` = 0 AND `ElseGroup` = 3;
INSERT INTO `conditions`
    (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`,
     `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`,
     `ConditionValue3`, `NegativeCondition`, `ErrorType`, `ErrorTextId`, `ScriptName`, `Comment`)
VALUES
    (16, 0, 25596, 0, 3, 23, 0, 4143, 0, 0, 0, 0, 0, '', 'Dismount player when not in intended zone');

-- Set quest timer to 10 minutes as its own log text describes
UPDATE `quest_template` SET `TimeAllowed` = 600 WHERE `ID` = 11690;
