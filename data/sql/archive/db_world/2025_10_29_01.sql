-- DB update 2025_10_29_00 -> 2025_10_29_01
DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId`=15 AND `SourceGroup`=7866 AND `SourceEntry`=2;
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `ErrorType`, `ErrorTextId`, `ScriptName`, `Comment`) VALUES
(15, 7866, 2, 0, 0, 9, 0, 10098, 0, 0, 0, 0, 0, '', 'Show gossip option 2 if player has quest 10098'),
(15, 7866, 2, 0, 0, 2, 0, 32888, 1, 0, 1, 0, 0, '', 'Show gossip option 2 if player does NOT have item 32888');

UPDATE `creature_template` SET `AIName`='SmartAI', `ScriptName`='' WHERE `entry`=18933;

DELETE FROM `smart_scripts` WHERE `entryorguid`=18933 AND `source_type`=0;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(18933, 0, 0, 1, 62, 0, 100, 0, 7866, 2, 0, 0, 56, 32888, 1, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 'Isfar - On Gossip Option 2 Selected - Add Item The Relics of Terokk'),
(18933, 0, 1, 0, 61, 0, 100, 0, 0, 0, 0, 0, 72, 0, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 'Isfar - Link - Close Gossip');
