-- Update Infected Kodo Beast SAI (Standstate Dead on Reset/Passenger Removed)
DELETE FROM `smart_scripts` WHERE `entryorguid` = 25596 AND `source_type` = 0;
INSERT INTO `smart_scripts`
    (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`,
     `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`,
     `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`,
     `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`,
     `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`,
     `target_x`, `target_y`, `target_z`, `target_o`, `comment`)
VALUES
    (25596, 0, 0, 0, 25, 0, 100, 512, 0, 0, 0, 0, 0, 0, 11, 32423, 0, 0, 0, 0, 0,
     1, 0, 0, 0, 0, 0, 0, 0, 0, 'Infected Kodo Beast - On Reset - Cast \'Blue Radiation\''),
    (25596, 0, 1, 0, 27, 0, 100, 512, 0, 0, 0, 0, 0, 0, 91, 7, 0, 0, 0, 0, 0,
     1, 0, 0, 0, 0, 0, 0, 0, 0, 'Infected Kodo Beast - On Passenger Boarded - Remove Flag Standstate Dead'),
    (25596, 0, 2, 0, 31, 0, 100, 512, 45877, 0, 0, 0, 0, 0, 41, 0, 0, 0, 0, 0, 0,
     1, 0, 0, 0, 0, 0, 0, 0, 0, 'Infected Kodo Beast - On Target Spellhit \'Deliver Kodo\' - Despawn Instant'),
    (25596, 0, 3, 0, 25, 0, 100, 512, 0, 0, 0, 0, 0, 0, 90, 7, 0, 0, 0, 0, 0,
     1, 0, 0, 0, 0, 0, 0, 0, 0, 'Infected Kodo Beast - On Reset - Set Flag Standstate Dead'),
    (25596, 0, 4, 0, 28, 0, 100, 0, 0, 0, 0, 0, 0, 0, 90, 7, 0, 0, 0, 0, 0,
     1, 0, 0, 0, 0, 0, 0, 0, 0, 'Infected Kodo Beast - On Passenger Removed - Set Flag Standstate Dead');

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
