--
UPDATE `conditions` SET `Comment` = 'Spell \'In the Maws of the Old God\' targets (effect mask 1) - Target is creature Yogg-Saron' WHERE (`SourceTypeOrReferenceId` = 13) AND (`SourceGroup` = 1) AND (`SourceEntry` = 64184) AND (`SourceId` = 0) AND (`ElseGroup` = 0) AND (`ConditionTypeOrReference` = 31) AND (`ConditionTarget` = 0) AND (`ConditionValue1` = 3) AND (`ConditionValue2` = 33288) AND (`ConditionValue3` = 0);
UPDATE `creature_loot_template`  SET `QuestRequired` = 1 WHERE (`Entry` = 33955) AND (`Item` IN (45897));
