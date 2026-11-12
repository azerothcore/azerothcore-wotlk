-- DB update 2026_10_16_05 -> 2026_10_16_06
-- Pool of Blood: Mostly-eaten Bonescale Snapper for players not on Blood Is Thicker
DELETE FROM `gameobject_loot_template` WHERE `Entry` = 27003 AND `Item` = 45907;
INSERT INTO `gameobject_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(27003, 45907, 0, 100, 0, 1, 0, 1, 1, 'Pool of Blood - Mostly-eaten Bonescale Snapper');

-- Hide the snapper while Blood Is Thicker is incomplete
DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId` = 4 AND `SourceGroup` = 27003 AND `SourceEntry` = 45907;
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `ErrorType`, `ErrorTextId`, `ScriptName`, `Comment`) VALUES
(4, 27003, 45907, 0, 0, 9, 0, 13833, 0, 0, 1, 0, 0, '', 'Item: Mostly-eaten Bonescale Snapper [45907] doesn''t drop if Quest: Blood Is Thicker is incomplete');
