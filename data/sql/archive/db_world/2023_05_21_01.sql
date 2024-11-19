-- DB update 2023_05_21_00 -> 2023_05_21_01
--
SET @NPC := 151089 * 10;
DELETE FROM `waypoint_data` WHERE `id` = @NPC;
INSERT INTO `waypoint_data` (`id`, `point`, `position_x`, `position_y`, `position_z`, `orientation`) VALUES
(@NPC, 1, 184.78966, 290.3699, -8.18139, 0),
(@NPC, 2, 178.51125, 287.97794, -8.183065, 0),
(@NPC, 3, 171.82281, 289.97687, -8.185595, 0),
(@NPC, 4, 178.51125, 287.97794, -8.183065, 0);

UPDATE `creature` SET `MovementType` = 2 WHERE `ID1` IN (16807, 20568);

DELETE FROM `creature_template_addon` WHERE `entry` IN (16807, 20568);
INSERT INTO `creature_template_addon` (`entry`, `path_id`) VALUES
(16807, @NPC),
(20568, @NPC);

DELETE FROM `smart_scripts` WHERE (`entryorguid` = 17083) AND (`source_type` = 0) AND (`id` IN (1, 2, 3));
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(17083, 0, 2, 0, 4, 0, 100, 512, 0, 0, 0, 0, 0, 45, 1, 1, 0, 0, 0, 0, 19, 16807, 50, 0, 0, 0, 0, 0, 0, 'Fel Orc Convert - On Aggro - Set Data 1 1'),
(17083, 0, 3, 0, 6, 0, 100, 512, 0, 0, 0, 0, 0, 45, 1, 2, 0, 0, 0, 0, 19, 16807, 50, 0, 0, 0, 0, 0, 0, 'Fel Orc Convert - On Just Died - Set Data 1 2');

DELETE FROM `conditions` WHERE (`SourceTypeOrReferenceId` = 22) AND (`SourceGroup` = 3) AND (`SourceEntry` = 17083) AND (`SourceId` = 0);
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `ErrorType`, `ErrorTextId`, `ScriptName`, `Comment`) VALUES
(22, 3, 17083, 0, 0, 31, 0, 4, 0, 0, 0, 0, 0, '', 'Only play SAI Event if Invoker is a Player');

DELETE FROM `spell_script_names` WHERE `ScriptName` = 'spell_tsh_shadow_sear';

DELETE FROM `conditions` WHERE (`SourceTypeOrReferenceId` = 13) AND (`SourceGroup` = 3) AND (`SourceEntry` = 30741);
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `ErrorType`, `ErrorTextId`, `ScriptName`, `Comment`) VALUES
(13, 3, 30741, 0, 0, 31, 0, 3, 17083, 151090, 0, 0, 0, '', 'Death Coil (30741) can only target Fel Orc Convert (17083) of specific guids'),
(13, 3, 30741, 0, 1, 31, 0, 3, 17083, 151091, 0, 0, 0, '', 'Death Coil (30741) can only target Fel Orc Convert (17083) of specific guids'),
(13, 3, 30741, 0, 2, 31, 0, 3, 17083, 151092, 0, 0, 0, '', 'Death Coil (30741) can only target Fel Orc Convert (17083) of specific guids'),
(13, 3, 30741, 0, 3, 31, 0, 3, 17083, 151093, 0, 0, 0, '', 'Death Coil (30741) can only target Fel Orc Convert (17083) of specific guids');

DELETE FROM `spell_script_names` WHERE `spell_id` = 30745;
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES
(30745, 'spell_target_fissures');

DELETE FROM `conditions` WHERE (`SourceTypeOrReferenceId` = 13) AND (`SourceGroup` = 1) AND (`SourceEntry` = 30745);
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `ErrorType`, `ErrorTextId`, `ScriptName`, `Comment`) VALUES
(13, 1, 30745, 0, 0, 31, 0, 3, 17083, 151090, 0, 0, 0, '', 'Target Fissures (30745) can only target Fel Orc Convert (17083) of specific guids'),
(13, 1, 30745, 0, 1, 31, 0, 3, 17083, 151091, 0, 0, 0, '', 'Target Fissures (30745) can only target Fel Orc Convert (17083) of specific guids'),
(13, 1, 30745, 0, 2, 31, 0, 3, 17083, 151092, 0, 0, 0, '', 'Target Fissures (30745) can only target Fel Orc Convert (17083) of specific guids'),
(13, 1, 30745, 0, 3, 31, 0, 3, 17083, 151093, 0, 0, 0, '', 'Target Fissures (30745) can only target Fel Orc Convert (17083) of specific guids');
