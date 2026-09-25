-- DB update 2025_11_15_05 -> 2025_11_15_06
--
DELETE FROM `conditions` WHERE (`SourceTypeOrReferenceId` = 13) AND (`SourceEntry` = 49765);
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `ErrorType`, `ErrorTextId`, `ScriptName`, `Comment`) VALUES
(13, 7, 49765, 0, 0, 31, 0, 3, 27713, 0, 0, 0, 0, '', 'Fordragon Resolve target 7th Legion Elite'),
(13, 7, 49765, 0, 1, 31, 0, 3, 26780, 0, 0, 0, 0, '', 'Fordragon Resolve target 7th Legion Cleric'),
(13, 7, 49765, 0, 2, 31, 0, 3, 27587, 0, 0, 0, 0, '', 'Fordragon Resolve target Legion Commander Yorik'),
(13, 7, 49765, 0, 3, 31, 0, 3, 27858, 0, 0, 0, 0, '', 'Fordragon Resolve target Highlord Bolvar Fordragon'),
(13, 7, 49765, 0, 4, 32, 0, 16, 0, 0, 0, 0, 0, '', 'Fordragon Resolve target players');
