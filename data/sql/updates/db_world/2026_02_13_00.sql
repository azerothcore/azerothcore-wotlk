-- DB update 2026_02_12_01 -> 2026_02_13_00

-- Set Avenging Fury target on self
UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 30680;

DELETE FROM `smart_scripts` WHERE (`entryorguid` = 30680) AND (`source_type` = 0) AND (`id` IN (3));
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(30680, 0, 3, 0, 6, 0, 100, 0, 0, 0, 0, 0, 0, 0, 11, 57742, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Onyx Brood General - On Just Died - Cast \'Avenging Fury\'');

-- Set Condition
DELETE FROM `conditions` WHERE (`SourceTypeOrReferenceId` = 13) AND (`SourceGroup` = 3) AND (`SourceEntry` = 57742) AND (`SourceId` = 0) AND (`ElseGroup` = 0) AND (`ConditionTypeOrReference` = 35) AND (`ConditionTarget` = 0) AND (`ConditionValue1` = 1) AND (`ConditionValue2` = 2) AND (`ConditionValue3` = 4);
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `ErrorType`, `ErrorTextId`, `ScriptName`, `Comment`) VALUES
(13, 3, 57742, 0, 0, 35, 0, 1, 2, 4, 0, 0, 0, '', 'Avenging Fury (57742) - Only hit targets within 2 yards of caster');
