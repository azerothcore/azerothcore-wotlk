-- DB update 2025_09_11_00 -> 2025_09_11_01
--
-- Remove movement override
UPDATE `creature` SET `wander_distance`=0, `MovementType`=0 WHERE `id1` = 28617 AND `guid` IN (114829, 114830, 114831, 114832);

-- Set target to self
DELETE FROM `smart_scripts` WHERE (`entryorguid` IN (-114831, -114829)) AND (`source_type` = 0) AND (`id` IN (0));
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(-114831, 0, 0, 0, 38, 0, 100, 0, 1, 1, 0, 0, 0, 0, 11, 52089, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Drakuramas Teleport Bunny 01 - On Data Set 1 1 - Cast \'Drakuramas Teleport Script 01\''),
(-114829, 0, 0, 0, 38, 0, 100, 0, 1, 1, 0, 0, 0, 0, 11, 52676, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Drakuramas Teleport Bunny 01 - On Data Set 1 1 - Cast \'Drakuramas Teleport Script 03\'');

-- Remove hack, use condition instead
DELETE FROM `areatrigger_scripts` WHERE `entry`=5079 AND `ScriptName`='at_voltarus_middle';
DELETE FROM `conditions` WHERE (`SourceTypeOrReferenceId` = 22) AND (`SourceGroup` = 1) AND (`SourceEntry` = 5079) AND (`SourceId` = 2) AND (`ElseGroup` = 0) AND (`ConditionTypeOrReference` = 1) AND (`ConditionTarget` = 0) AND (`ConditionValue1` = 52678) AND (`ConditionValue2` = 0) AND (`ConditionValue3` = 0);
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `ErrorType`, `ErrorTextId`, `ScriptName`, `Comment`) VALUES
(22, 1, 5079, 2, 0, 1, 0, 52678, 0, 0, 0, 0, 0, '', 'SAI areatrigger triggers only if player has aura Teleporter Scepter Aura');
