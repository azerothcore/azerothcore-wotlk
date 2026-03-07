-- DB update 2026_03_05_02 -> 2026_03_05_03

-- Remove c++ script and set SAI.
UPDATE `creature_template` SET `AIName` = 'SmartAI', `ScriptName` = '' WHERE (`entry` = 34054);

-- Set Areatrigger Scripts.
DELETE FROM `areatrigger_scripts` WHERE (`entry` IN (5414, 5415, 5416, 5417, 5442, 5443));
INSERT INTO `areatrigger_scripts` (`entry`, `ScriptName`) VALUES
(5414, 'SmartTrigger'),
(5415, 'SmartTrigger'),
(5416, 'SmartTrigger'),
(5417, 'SmartTrigger'),
(5442, 'SmartTrigger'),
(5443, 'SmartTrigger');

-- Set Comments.
UPDATE `creature` SET `Comment` = 'Has Personal GUID SAI' WHERE `id1` = 34054;

-- Set Areatrigger SAI.
DELETE FROM `smart_scripts` WHERE (`source_type` = 2) AND (`entryorguid` IN (5414, 5415, 5416, 5417, 5442, 5443));
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(5414, 2, 0, 0, 46, 0, 100, 0, 5414, 0, 0, 0, 0, 0, 223, 27, 0, 0, 0, 0, 0, 10, 1975200, 34054, 0, 0, 0, 0, 0, 0, 'Areatrigger - On Trigger - Do Action ID 27'),
(5415, 2, 0, 0, 46, 0, 100, 0, 5415, 0, 0, 0, 0, 0, 223, 28, 0, 0, 0, 0, 0, 10, 1975199, 34054, 0, 0, 0, 0, 0, 0, 'Areatrigger - On Trigger - Do Action ID 28'),
(5416, 2, 0, 0, 46, 0, 100, 0, 5416, 0, 0, 0, 0, 0, 223, 26, 0, 0, 0, 0, 0, 10, 1975202, 34054, 0, 0, 0, 0, 0, 0, 'Areatrigger - On Trigger - Do Action ID 26'),
(5417, 2, 0, 0, 46, 0, 100, 0, 5417, 0, 0, 0, 0, 0, 223, 25, 0, 0, 0, 0, 0, 10, 1975203, 34054, 0, 0, 0, 0, 0, 0, 'Areatrigger - On Trigger - Do Action ID 25'),
(5442, 2, 0, 0, 46, 0, 100, 0, 5442, 0, 0, 0, 0, 0, 223, 24, 0, 0, 0, 0, 0, 10, 1975201, 34054, 0, 0, 0, 0, 0, 0, 'Areatrigger - On Trigger - Do Action ID 24'),
(5443, 2, 0, 0, 46, 0, 100, 0, 5443, 0, 0, 0, 0, 0, 223, 23, 0, 0, 0, 0, 0, 10, 1975198, 34054, 0, 0, 0, 0, 0, 0, 'Areatrigger - On Trigger - Do Action ID 24');

-- Set Bronzebeard Radio Personal GUID SAI.
DELETE FROM `smart_scripts` WHERE (`source_type` = 0) AND (`entryorguid` IN (-1975198, -1975199, -1975200, -1975201, -1975202, -1975203));
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(-1975198, 0, 0, 0, 72, 0, 100, 257, 23, 0, 0, 0, 0, 0, 1, 3, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Bronzebeard Radio - On Action 23 Done - Say Line 3 (No Repeat)'),
(-1975199, 0, 0, 0, 72, 0, 100, 257, 28, 0, 0, 0, 0, 0, 1, 8, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Bronzebeard Radio - On Action 28 Done - Say Line 8 (No Repeat)'),
(-1975200, 0, 0, 0, 72, 0, 100, 257, 27, 0, 0, 0, 0, 0, 1, 7, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Bronzebeard Radio - On Action 27 Done - Say Line 7 (No Repeat)'),
(-1975201, 0, 0, 0, 72, 0, 100, 257, 24, 0, 0, 0, 0, 0, 1, 4, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Bronzebeard Radio - On Action 24 Done - Say Line 4 (No Repeat)'),
(-1975202, 0, 0, 0, 72, 0, 100, 257, 26, 0, 0, 0, 0, 0, 1, 6, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Bronzebeard Radio - On Action 26 Done - Say Line 6 (No Repeat)'),
(-1975203, 0, 0, 0, 72, 0, 100, 257, 25, 0, 0, 0, 0, 0, 1, 5, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Bronzebeard Radio - On Action 25 Done - Say Line 5 (No Repeat)');

-- Set Conditions
DELETE FROM `conditions` WHERE (`SourceTypeOrReferenceId` = 22) AND (`SourceEntry` IN (-1975198, -1975199, -1975200, -1975201, -1975202, -1975203)) AND (`SourceId` = 0);
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `ErrorType`, `ErrorTextId`, `ScriptName`, `Comment`) VALUES
(22, 1, -1975198, 0, 0, 13, 1, 0, 0, 2, 0, 0, 0, '', 'Bronzebeard Radio event only occours if Leviathan in not started'),
(22, 1, -1975199, 0, 0, 13, 1, 0, 0, 2, 0, 0, 0, '', 'Bronzebeard Radio event only occours if Leviathan in not started'),
(22, 1, -1975200, 0, 0, 13, 1, 0, 0, 2, 0, 0, 0, '', 'Bronzebeard Radio event only occours if Leviathan in not started'),
(22, 1, -1975201, 0, 0, 13, 1, 0, 0, 2, 0, 0, 0, '', 'Bronzebeard Radio event only occours if Leviathan in not started'),
(22, 1, -1975202, 0, 0, 13, 1, 0, 0, 2, 0, 0, 0, '', 'Bronzebeard Radio event only occours if Leviathan in not started'),
(22, 1, -1975203, 0, 0, 13, 1, 0, 0, 2, 0, 0, 0, '', 'Bronzebeard Radio event only occours if Leviathan in not started');
