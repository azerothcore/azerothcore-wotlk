-- DB update 2026_01_17_00 -> 2026_01_17_01
--
DELETE FROM `smart_scripts` WHERE (`entryorguid` = 26261) AND (`source_type` = 0) AND (`id` IN (0));
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(26261, 0, 0, 0, 8, 0, 100, 512, 47394, 0, 0, 0, 0, 0, 80, 2626100, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Grizzly Hills Giant - On Spellhit \'Kurun\'s Blessing\' - Run Script');

DELETE FROM `conditions` WHERE (`SourceTypeOrReferenceId` = 17) AND (`SourceGroup` = 0) AND (`SourceEntry` = 47394) AND (`SourceId` = 0) AND (`ElseGroup` = 0) AND (`ConditionTypeOrReference` = 29) AND (`ConditionTarget` = 1) AND (`ConditionValue1` = 26417) AND (`ConditionValue2` = 15) AND (`ConditionValue3` = 0);
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `ErrorType`, `ErrorTextId`, `ScriptName`, `Comment`) VALUES
(17, 0, 47394, 0, 0, 29, 1, 26417, 15, 0, 0, 0, 0, '', 'For Kurun\'s Blessing (47394) to have an effect the target Grizzly Hills Giant (26261) must be engaged with a Runed Giant (26417)');

UPDATE `creature` SET `spawntimesecs` = 120 WHERE `id1` = 26261;
