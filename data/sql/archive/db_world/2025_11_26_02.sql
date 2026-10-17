-- DB update 2025_11_26_01 -> 2025_11_26_02
--
-- Quest item Ahunae's Knife can target dead Heb'Drakkar Headhunter or dead Heb'Drakkar Striker
DELETE FROM `conditions` WHERE (`SourceTypeOrReferenceId` = 17) AND (`SourceEntry` = 52090);
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `ErrorType`, `ErrorTextId`, `ScriptName`, `Comment`) VALUES
(17, 0, 52090, 0, 0, 31, 1, 3, 28600, 0, 0, 173, 0, '', 'Item 38731 "Ahunae\'s Knife" targets 28600 dead "Heb\'Drakkar Headhunter"'),
(17, 0, 52090, 0, 0, 36, 1, 0, 0, 0, 1, 173, 0, '', 'Item 38731 "Ahunae\'s Knife" targets 28600 dead "Heb\'Drakkar Headhunter"'),
(17, 0, 52090, 0, 1, 31, 1, 3, 28465, 0, 0, 173, 0, '', 'Item 38731 "Ahunae\'s Knife" targets 28465 dead "Heb\'Drakkar Striker"'),
(17, 0, 52090, 0, 1, 36, 1, 0, 0, 0, 1, 173, 0, '', 'Item 38731 "Ahunae\'s Knife" targets 28465 dead "Heb\'Drakkar Striker"');
