-- DB update 2026_03_13_02 -> 2026_03_13_03

-- Update SAI.
UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 28557;

DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = 28557);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(28557, 0, 0, 1, 25, 0, 100, 0, 0, 0, 0, 0, 0, 0, 22, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Scarlet Peasant - On Reset - Set Event Phase 1'),
(28557, 0, 1, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 8, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Scarlet Peasant - On Reset - Set Reactstate Passive'),
(28557, 0, 2, 0, 4, 1, 100, 0, 0, 0, 0, 0, 0, 0, 80, 2855700, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Scarlet Peasant - On Aggro - Run Script (Phase 1)'),
(28557, 0, 3, 0, 101, 1, 100, 1, 1, 3, 3000, 0, 0, 0, 80, 2855701, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Scarlet Peasant - On 1 or More Players in Range - Run Script (Phase 1) (No Repeat)'),
(28557, 0, 4, 0, 102, 2, 100, 0, 1, 3, 30000, 30000, 30000, 0, 24, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Scarlet Peasant - On Less Than 1 Players in Range - Evade (Phase 2)'),
(28557, 0, 5, 0, 4, 1, 100, 0, 0, 0, 0, 0, 0, 0, 8, 2, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Scarlet Peasant - On Aggro - Set Reactstate Aggressive (Phase 1)');

-- Set Actionlist.
DELETE FROM `smart_scripts` WHERE (`source_type` = 9) AND (`entryorguid` IN (2855700, 2855701));
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(2855700, 9, 0, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 8, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Scarlet Peasant - Actionlist - Set Reactstate Passive'),
(2855700, 9, 1, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 66, 0, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Scarlet Peasant - Actionlist - Set Orientation Invoker'),
(2855700, 9, 2, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 11, 51604, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Scarlet Peasant - Actionlist - Cast \'Serverside - Stun Self\''),
(2855700, 9, 3, 0, 0, 0, 100, 0, 500, 500, 0, 0, 0, 0, 4, 14561, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Scarlet Peasant - Actionlist - Play Sound 14561'),
(2855700, 9, 4, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 17, 431, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Scarlet Peasant - Actionlist - Set Emote State 431'),
(2855700, 9, 5, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Scarlet Peasant - Actionlist - Say Line 0'),
(2855700, 9, 6, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 22, 2, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Scarlet Peasant - Actionlist - Set Event Phase 2'),
(2855701, 9, 0, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 8, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Scarlet Peasant - Actionlist - Set Reactstate Passive'),
(2855701, 9, 1, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 66, 0, 0, 0, 0, 0, 0, 21, 5, 0, 0, 0, 0, 0, 0, 0, 'Scarlet Peasant - Actionlist - Set Orientation Closest Player'),
(2855701, 9, 2, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 11, 51604, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Scarlet Peasant - Actionlist - Cast \'Serverside - Stun Self\''),
(2855701, 9, 3, 0, 0, 0, 100, 0, 500, 500, 0, 0, 0, 0, 4, 14561, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Scarlet Peasant - Actionlist - Play Sound 14561'),
(2855701, 9, 4, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 17, 431, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Scarlet Peasant - Actionlist - Set Emote State 431'),
(2855701, 9, 5, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 21, 5, 0, 0, 0, 0, 0, 0, 0, 'Scarlet Peasant - Actionlist - Say Line 0'),
(2855701, 9, 6, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 22, 2, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Scarlet Peasant - Actionlist - Set Event Phase 2');

-- Set Conditions
DELETE FROM `conditions` WHERE (`SourceTypeOrReferenceId` = 22) AND (`SourceGroup` IN (3, 6)) AND (`SourceEntry` = 28557) AND (`SourceId` = 0) AND (`ElseGroup` = 0) AND (`ConditionTypeOrReference` = 31) AND (`ConditionTarget` = 0) AND (`ConditionValue1` IN (3, 4)) AND (`ConditionValue2` = 0) AND (`ConditionValue3` = 0);
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `ErrorType`, `ErrorTextId`, `ScriptName`, `Comment`) VALUES
(22, 3, 28557, 0, 0, 31, 0, 4, 0, 0, 0, 0, 0, '', 'The event only occurs if the attacker is a player.'),
(22, 6, 28557, 0, 0, 31, 0, 3, 0, 0, 0, 0, 0, '', 'The event only occurs if the attacker is not a player.');
