-- Fix Jagged Shard quest chain (Issue #23949)
-- 1. Jagged Shard should drop after completing Spill Their Blood (not while active)
UPDATE `conditions` SET `ConditionTypeOrReference`=8, `Comment`='Jagged Shard drops after completing Spill Their Blood' WHERE `SourceTypeOrReferenceId`=1 AND `SourceGroup`=30597 AND `SourceEntry`=43242;

-- 2. I'm Smelting... Smelting! and The Runesmiths of Malykriss require Jagged Shards completed
UPDATE `quest_template_addon` SET `PrevQuestID`=13136 WHERE `ID`=13138;
UPDATE `quest_template_addon` SET `PrevQuestID`=13136 WHERE `ID`=13140;
