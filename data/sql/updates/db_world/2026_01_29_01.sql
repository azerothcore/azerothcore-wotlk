-- DB update 2026_01_29_00 -> 2026_01_29_01
--
DELETE FROM `spell_script_names` WHERE `spell_id` = 51774 AND `ScriptName` = 'spell_taunt_brann';
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES
(51774, 'spell_taunt_brann');

DELETE FROM `conditions` WHERE (`SourceTypeOrReferenceId` = 13) AND (`SourceGroup` = 1) AND (`SourceEntry` = 51774) AND (`SourceId` = 0) AND (`ElseGroup` = 0) AND (`ConditionTypeOrReference` = 31) AND (`ConditionTarget` = 0) AND (`ConditionValue1` = 3) AND (`ConditionValue2` = 28070) AND (`ConditionValue3` = 0);
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `ErrorType`, `ErrorTextId`, `ScriptName`, `Comment`) VALUES
(13, 1, 51774, 0, 0, 31, 0, 3, 28070, 0, 0, 0, 0, '', 'Target of Taunt (51774) is Brann Bronzebeard (28070) in Halls of Stone Tribunal Event.');

DELETE FROM `smart_scripts` WHERE (`entryorguid` = 27983) AND (`source_type` = 0) AND (`id` IN (2));
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(27983, 0, 2, 0, 11, 0, 100, 0, 0, 0, 0, 0, 0, 0, 11, 51774, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Dark Rune Protector - On Respawn - Cast \'Taunt\'');

DELETE FROM `smart_scripts` WHERE (`entryorguid` = 27984) AND (`source_type` = 0) AND (`id` IN (4));
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(27984, 0, 4, 0, 11, 0, 100, 0, 0, 0, 0, 0, 0, 0, 11, 51774, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Dark Rune Stormcaller - On Respawn - Cast \'Taunt\'');

DELETE FROM `smart_scripts` WHERE (`entryorguid` = 27985) AND (`source_type` = 0) AND (`id` IN (3));
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(27985, 0, 3, 0, 11, 0, 100, 0, 0, 0, 0, 0, 0, 0, 11, 51774, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Iron Golem Custodian - On Respawn - Cast \'Taunt\'');
