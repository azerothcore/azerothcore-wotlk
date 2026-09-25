-- DB update 2025_12_29_07 -> 2025_12_29_08
-- Fix Jagged Shard quest chain (Issue #23949)
-- 1. Jagged Shard should drop while Spill Their Blood is active OR completed
-- Remove PrevQuestID from Jagged Shards quest so loot conditions control the drop
UPDATE `quest_template_addon` SET `PrevQuestID`=0 WHERE `ID`=13136;
DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId`=1 AND `SourceGroup`=30597 AND `SourceEntry`=43242;
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `ErrorType`, `ErrorTextId`, `ScriptName`, `Comment`) VALUES
(1, 30597, 43242, 0, 0, 9, 0, 13134, 0, 0, 0, 0, 0, '', 'Jagged Shard drops if Spill Their Blood is active'),
(1, 30597, 43242, 0, 1, 8, 0, 13134, 0, 0, 0, 0, 0, '', 'Jagged Shard drops if Spill Their Blood is completed');

-- 2. I'm Smelting... Smelting! and The Runesmiths of Malykriss require Jagged Shards completed
UPDATE `quest_template_addon` SET `PrevQuestID`=13136 WHERE `ID`=13138;
UPDATE `quest_template_addon` SET `PrevQuestID`=13136 WHERE `ID`=13140;
