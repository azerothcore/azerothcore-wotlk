--
UPDATE `creature_template` SET `AIName` = 'SmartAI', `ScriptName` = '' WHERE `entry` = 18879;
DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = 18879);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(18879, 0, 0, 0, 25, 0, 100, 0, 0, 0, 0, 0, 0, 0, 11, 34804, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Phase Hunter - On Reset - Cast \'Materialize\''),
(18879, 0, 2, 0, 2, 0, 100, 0, 0, 35, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Phase Hunter - Between 0-35% Health - Say Line 0'),
(18879, 0, 3, 0, 23, 0, 100, 0, 8000, 16000, 20000, 31000, 0, 0, 11, 37176, 0, 0, 0, 0, 0, 5, 0, 0, 1, 0, 0, 0, 0, 0, 'Phase Hunter - In Combat - Cast \'Mana Burn\''),
(18879, 0, 1, 0, 0, 0, 100, 0, 3600, 3600, 3600, 3600, 0, 0, 11, 36574, 32, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Phase Hunter - In Combat - Cast \'Phase Slip\'');

DELETE FROM `conditions` WHERE (`SourceTypeOrReferenceId` = 22) AND (`SourceGroup` = 2) AND (`SourceEntry` = 18879) AND (`SourceId` = 0);
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `ErrorType`, `ErrorTextId`, `ScriptName`, `Comment`) VALUES
(22, 2, 18879, 0, 0, 102, 1, 26, 0, 0, 0, 0, 0, '', 'Only execute SAI if Phase Hunter is under a Root effect'),
(22, 2, 18879, 0, 1, 102, 1, 33, 0, 0, 0, 0, 0, '', 'Only execute SAI if Phase Hunter is under a Move Speed Decrease effect');
