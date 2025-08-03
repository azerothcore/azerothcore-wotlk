-- DB update 2025_08_01_00 -> 2025_08_01_01
-- fix quest 12616 'Chamber of Secrets'
UPDATE `gameobject_template` SET `AIName` = 'SmartGameObjectAI' WHERE `entry` = 190610;

DELETE FROM `smart_scripts` WHERE (`source_type` = 1 AND `entryorguid` = 190610);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(190610, 1, 0, 0, 70, 0, 100, 0, 2, 0, 0, 0, 0, 0, 56, 38629, 1, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Orders from the Lich King - On Gameobject State Changed - Add Item \'Orders from the Lich King\' 1 Time');

DELETE FROM `conditions` WHERE (`SourceTypeOrReferenceId` = 22) AND (`SourceGroup` = 1) AND (`SourceEntry` = 190610) AND (`ConditionTypeOrReference` IN (2, 9)) AND (`ConditionValue1` IN (38629, 12616));
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `ErrorType`, `ErrorTextId`, `ScriptName`, `Comment`) VALUES
(22, 1, 190610, 1, 0, 9, 0, 12616, 0, 0, 0, 0, 0, '', '\'Orders from the Lich King\' requires quest \'Chamber of Secrets\''),
(22, 1, 190610, 1, 0, 2, 0, 38629, 1, 0, 1, 0, 0, '', 'Can\'t receive more than one \'Orders from the Lich King\'');
