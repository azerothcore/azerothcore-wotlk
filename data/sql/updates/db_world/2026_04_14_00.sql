-- DB update 2026_04_12_06 -> 2026_04_14_00
-- Move npc_vh_sinclari (30658) and go_vh_activation_crystal (193611) from C++ to DB

UPDATE `creature_template` SET `gossip_menu_id` = 9997, `AIName` = 'SmartAI', `ScriptName` = '' WHERE `entry` = 30658;

-- (9997, 13853) already exists for NOT_STARTED
DELETE FROM `gossip_menu` WHERE `MenuID` = 9997 AND `TextID` IN (14271, 13910);
INSERT INTO `gossip_menu` (`MenuID`, `TextID`) VALUES
(9997, 14271),
(9997, 13910);

DELETE FROM `gossip_menu_option` WHERE `MenuID` = 9997 AND `OptionID` = 1;
INSERT INTO `gossip_menu_option` (`MenuID`, `OptionID`, `OptionIcon`, `OptionText`, `OptionBroadcastTextID`, `OptionType`, `OptionNpcFlag`, `ActionMenuID`, `ActionPoiID`, `BoxCoded`, `BoxMoney`, `BoxText`, `BoxBroadcastTextID`, `VerifiedBuild`)
VALUES (9997, 1, 0, 'I''m not fighting, so send me in now!', 33204, 1, 1, 0, 0, 0, 0, '', 0, 0);

-- Gossip menu text conditions (CONDITION_INSTANCE_INFO on DATA_ENCOUNTER_STATUS)
DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId` = 14 AND `SourceGroup` = 9997;
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `ErrorType`, `ErrorTextId`, `ScriptName`, `Comment`) VALUES
(14, 9997, 13853, 0, 0, 13, 0, 30, 0, 0, 0, 0, 0, '', 'Sinclari - Show text 13853 when encounter NOT_STARTED'),
(14, 9997, 14271, 0, 0, 13, 0, 30, 1, 0, 0, 0, 0, '', 'Sinclari - Show text 14271 when encounter IN_PROGRESS'),
(14, 9997, 13910, 0, 0, 13, 0, 30, 2, 0, 0, 0, 0, '', 'Sinclari - Show text 13910 when encounter DONE');

-- Gossip option conditions
DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId` = 15 AND `SourceGroup` = 9997;
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `ErrorType`, `ErrorTextId`, `ScriptName`, `Comment`) VALUES
(15, 9997, 0, 0, 0, 13, 0, 30, 0, 0, 0, 0, 0, '', 'Sinclari - Show option 0 (start) only when NOT_STARTED'),
(15, 9997, 1, 0, 0, 13, 0, 30, 1, 0, 0, 0, 0, '', 'Sinclari - Show option 1 (late join) only when IN_PROGRESS');

DELETE FROM `smart_scripts` WHERE `entryorguid` = 30658 AND `source_type` = 0;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(30658, 0, 0, 0, 62, 0, 100, 0, 9998, 0, 0, 0, 0, 0, 72, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Sinclari - On Gossip Select (Start) - Close Gossip'),
(30658, 0, 1, 0, 62, 0, 100, 0, 9998, 0, 0, 0, 0, 0, 223, 1, 0, 1, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Sinclari - On Gossip Select (Start) - DoAction ACTION_START_INSTANCE on Instance'),
(30658, 0, 2, 0, 62, 0, 100, 0, 9997, 1, 0, 0, 0, 0, 62, 608, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 1830.531006, 803.939758, 44.340508, 6.281611, 'Sinclari - On Gossip Select (Late Join) - Teleport Player'),
(30658, 0, 3, 0, 62, 0, 100, 0, 9997, 1, 0, 0, 0, 0, 72, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Sinclari - On Gossip Select (Late Join) - Close Gossip');

-- Activation Crystal: invoker casts spell 57804 → SPELL_EFFECT_SEND_EVENT(20001) → ProcessEvent
UPDATE `gameobject_template` SET `AIName` = 'SmartGameObjectAI', `ScriptName` = '' WHERE `entry` = 193611;

DELETE FROM `smart_scripts` WHERE `entryorguid` = 193611 AND `source_type` = 1;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(193611, 1, 0, 0, 64, 0, 100, 0, 0, 0, 0, 0, 0, 0, 134, 57804, 2, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Activation Crystal - On Gossip Hello - Invoker Cast Crystal Activation'),
(193611, 1, 1, 0, 64, 0, 100, 0, 0, 0, 0, 0, 0, 0, 105, 16, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Activation Crystal - On Gossip Hello - Add GO_FLAG_NOT_SELECTABLE');
