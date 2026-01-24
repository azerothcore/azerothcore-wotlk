-- DB update 2026_01_19_00 -> 2026_01_19_01

-- Edit Spawn Time (Captured Rageclaw & Drakuru Shackles)
UPDATE `creature` SET `spawntimesecs` = 30 WHERE (`id1` IN (29700, 29686));

-- Remove C++ script and set SAI for Drakuru Shackles & Captured Rageclaw
UPDATE `creature_template` SET `AIName` = 'SmartAI', `ScriptName` = '' WHERE (`entry` IN (29700, 29686));

DELETE FROM `smart_scripts` WHERE (`source_type` = 0) AND (`entryorguid` IN (29700, 29686));
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(29700, 0, 0, 0, 8, 0, 100, 0, 54990, 0, 0, 0, 0, 0, 11, 55009, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Drakuru Shackles - On Spellhit \'Chains of the Scourge\' - Cast \'Chains of the Scourge\''),
(29700, 0, 1, 2, 8, 0, 100, 0, 55083, 0, 0, 0, 0, 0, 33, 29686, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Drakuru Shackles - On Spellhit \'Unlock Shackle\' - Quest Credit \'Captured Rageclaw\''),
(29700, 0, 2, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 223, 27, 0, 0, 0, 0, 0, 9, 29686, 0, 5, 1, 0, 0, 0, 0, 'Drakuru Shackles - On Spellhit \'Unlock Shackle\' - Do Action ID 27'),
(29686, 0, 0, 1, 11, 0, 100, 0, 0, 0, 0, 0, 0, 0, 90, 8, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Captured Rageclaw - On Respawn - Set Flag Standstate Kneel'),
(29686, 0, 1, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 11, 54990, 0, 0, 0, 0, 0, 9, 29700, 0, 5, 1, 0, 0, 0, 0, 'Captured Rageclaw - On Respawn - Cast \'Chains of the Scourge\''),
(29686, 0, 2, 3, 72, 0, 100, 0, 27, 0, 0, 0, 0, 0, 91, 8, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Captured Rageclaw - On Action 27 Done - Remove FlagStandstate Kneel'),
(29686, 0, 3, 4, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 28, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Captured Rageclaw - On Action 27 Done - Remove Aura \'all\''),
(29686, 0, 4, 5, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 11, 55085, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Captured Rageclaw - On Action 27 Done - Cast \'Unshackled!\''),
(29686, 0, 5, 6, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Captured Rageclaw - On Action 27 Done - Say Line 0'),
(29686, 0, 6, 7, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 89, 5, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Captured Rageclaw - On Action 27 Done - Start Random Movement'),
(29686, 0, 7, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 41, 12000, 30000, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Captured Rageclaw - On Action 27 Done - Despawn In 12000 ms');

-- Set condition for Chains of the Scourge
DELETE FROM `conditions` WHERE (`SourceTypeOrReferenceId` = 13) AND (`SourceGroup` = 1) AND (`SourceEntry` = 54990) AND (`SourceId` = 0) AND (`ElseGroup` = 0) AND (`ConditionTypeOrReference` = 31) AND (`ConditionTarget` = 0) AND (`ConditionValue1` = 3) AND (`ConditionValue2` = 29700) AND (`ConditionValue3` = 0);
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `ErrorType`, `ErrorTextId`, `ScriptName`, `Comment`) VALUES
(13, 1, 54990, 0, 0, 31, 0, 3, 29700, 0, 0, 0, 0, '', 'Chains of the Scourge has Drakuru Shackles as implicit target');

-- Set condition for Unlock Shackle (prevent item spamming if Rageclaw is not chained/present)
DELETE FROM `conditions` WHERE (`SourceTypeOrReferenceId` = 13) AND (`SourceGroup` = 3) AND (`SourceEntry` = 55083) AND (`SourceId` = 0) AND (`ElseGroup` = 0) AND (`ConditionTypeOrReference` = 1) AND (`ConditionTarget` = 0) AND (`ConditionValue1` = 54990) AND (`ConditionValue2` = 0) AND (`ConditionValue3` = 0);
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `ErrorType`, `ErrorTextId`, `ScriptName`, `Comment`) VALUES
(13, 3, 55083, 0, 0, 1, 0, 54990, 0, 0, 0, 0, 0, '', 'Unlock Shackle target must have Chains of the Scourge aura.');
