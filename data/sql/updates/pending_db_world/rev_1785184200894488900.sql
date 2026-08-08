--
UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 24210;
DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = 24210);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(24210, 0, 0, 0, 6, 0, 100, 0, 0, 0, 0, 0, 0, 0, 11, 43287, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Riven Widow Cocoon - On Just Died - Cast \'Rivenwood Captives: Player On Quest\''),
(24210, 0, 1, 0, 6, 0, 100, 0, 0, 0, 0, 0, 0, 0, 11, 43288, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Riven Widow Cocoon - On Just Died - Cast \'Rivenwood Captives: Player Not On Quest\'');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 24211;
DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = 24211);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(24211, 0, 0, 0, 54, 0, 100, 0, 0, 0, 0, 0, 0, 0, 69, 1, 0, 0, 0, 1, 0, 21, 60, 0, 0, 0, 0, 0, 0, 0, 'Freed Winterhoof Longrunner - On Just Summoned - Move To Closest Player'),
(24211, 0, 1, 2, 34, 0, 100, 0, 8, 1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Freed Winterhoof Longrunner - On Reached Player - Say Line'),
(24211, 0, 2, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 41, 3600, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Freed Winterhoof Longrunner - On Reached Player - Despawn In 3600 ms');

DELETE FROM `spell_script_names` WHERE `spell_id` IN (43287, 43288);
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES
(43287, 'spell_q11296_rivenwood_captives'),
(43288, 'spell_q11296_rivenwood_captives');

DELETE FROM `conditions` WHERE (`SourceTypeOrReferenceId` = 22) AND (`SourceEntry` = 24210) AND (`SourceId` = 0) AND (`ElseGroup` = 0) AND (`ConditionTypeOrReference` = 47);
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `ErrorType`, `ErrorTextId`, `ScriptName`, `Comment`) VALUES
(22, 1, 24210, 0, 0, 47, 0, 11296, 10, 0, 0, 0, 0, '', 'Cast \'Rivenwood Captives: Player On Quest\' if its namesake is true'),
(22, 2, 24210, 0, 0, 47, 0, 11296, 10, 0, 1, 0, 0, '', 'Cast \'Rivenwood Captives: Player Not On Quest\' if its namesake is true');
