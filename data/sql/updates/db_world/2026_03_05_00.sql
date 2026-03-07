-- DB update 2026_03_04_03 -> 2026_03_05_00
DELETE FROM `spell_script_names` WHERE `spell_id` IN (64436, 64444);
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES
(64436, 'spell_mimiron_magnetic_core_aura'),
(64444, 'spell_mimiron_magnetic_core_summon');

DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId` = 13 AND `SourceEntry` = 64436;
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `ErrorType`, `ErrorTextId`, `ScriptName`, `Comment`) VALUES
(13, 2, 64436, 0, 0, 31, 0, 3, 33670, 0, 0, 0, 0, '', 'Mimiron - Magnetic Core hits Aerial Command Unit only');

UPDATE `creature_template` SET `unit_flags` = `unit_flags`&~4 WHERE `entry` IN (33670, 34109);

UPDATE `creature_template` SET `AIName` = 'SmartAI', `ScriptName` = '' WHERE `entry` = 34068;

DELETE FROM `smart_scripts` WHERE `entryorguid` = 34068 AND `source_type` = 0;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(34068, 0, 0, 1, 25, 0, 100, 0, 0, 0, 0, 0, 8, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Mimiron - Magnetic Core - On Reset - Set React State Passive'),
(34068, 0, 1, 0, 61, 0, 100, 0, 0, 0, 0, 0, 11, 64436, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Mimiron - Magnetic Core - Linked - Cast Magnetic Core Triggered');
