-- DB update 2025_10_24_01 -> 2025_10_24_02
--
DELETE FROM `smart_scripts` WHERE (`entryorguid` = -114830) AND (`source_type` = 0) AND (`id` IN (0));
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(-114830, 0, 0, 0, 38, 0, 100, 0, 1, 1, 0, 0, 0, 0, 11, 52239, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Drakuramas Teleport Bunny 01 - On Data Set 1 1 - Cast \'Drakuramas Teleport Script 02\'');

DELETE FROM `areatrigger_scripts`  WHERE `entry` = 5079;
INSERT INTO `areatrigger_scripts` (`entry`, `ScriptName`) VALUES
(5079, 'SmartTrigger');

DELETE FROM `areatrigger_teleport` WHERE `ID` = 5079;
INSERT INTO `areatrigger_teleport` (`ID`, `Name`, `target_map`, `target_position_x`, `target_position_y`, `target_position_z`, `target_orientation`) VALUES
(5079, 'Zul''drak - Voltarus, middle floor -> top', 571, 6242.67, -1972.10, 484.783, 0.6);

DELETE FROM `spell_target_position` WHERE `ID` = 52240;
INSERT INTO `spell_target_position` (`ID`, `EffectIndex`, `MapID`, `PositionX`, `PositionY`, `PositionZ`, `Orientation`, `VerifiedBuild`) VALUES
(52240, 0, 571, 6242.67, -1972.10, 484.783, 0.6, 0);

DELETE FROM `areatrigger_scripts` WHERE `entry` = 5079;
INSERT INTO `areatrigger_scripts` (`entry`, `ScriptName`) VALUES (5079, 'SmartTrigger');

DELETE FROM `smart_scripts` WHERE (`source_type` = 2 AND `entryorguid` = 5079);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(5079, 2, 0, 0, 46, 0, 100, 0, 5079, 0, 0, 0, 0, 0, 45, 1, 1, 0, 0, 0, 0, 10, 114830, 28617, 0, 0, 0, 0, 0, 0, 'Areatrigger - On Trigger - Set Data 1 1');

DELETE FROM `conditions` WHERE (`SourceTypeOrReferenceId` = 13) AND (`SourceGroup` = 1) AND (`SourceEntry` = 52239) AND (`SourceId` = 0) AND (`ElseGroup` = 0) AND (`ConditionTypeOrReference` = 31) AND (`ConditionTarget` = 0) AND (`ConditionValue1` = 4) AND (`ConditionValue2` = 0) AND (`ConditionValue3` = 0);
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `ErrorType`, `ErrorTextId`, `ScriptName`, `Comment`) VALUES
(13, 1, 52239, 0, 0, 31, 0, 4, 0, 0, 0, 0, 0, '', 'Spell only hits player');

UPDATE `creature` SET `Comment` = 'GUID SAI' WHERE (`id1` = 28617) AND (`guid` = 114830);

DELETE FROM `spell_linked_spell` WHERE `spell_trigger` = 52239;
INSERT INTO `spell_linked_spell` (`spell_trigger`, `spell_effect`, `type`, `comment`) VALUES
(52239, 52240, 1, 'Teleport');
