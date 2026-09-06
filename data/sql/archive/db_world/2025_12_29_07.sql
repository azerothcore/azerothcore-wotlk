-- DB update 2025_12_29_06 -> 2025_12_29_07
--
UPDATE `conditions` SET `ConditionTypeOrReference` = 105, `ConditionValue1` = 1, `ConditionValue2` = 0, `ConditionValue3` = 0, `Comment` = 'Loot Cache of the Ley-Guardian only when the player is queued via Random Heroic' WHERE `SourceTypeOrReferenceId` = 4 AND `SourceGroup` = 24524 AND `SourceEntry` = 52676 AND `SourceId` = 0 AND `ElseGroup` = 0 AND `ConditionTarget` = 0 AND `ConditionTypeOrReference` = 1;
