--
-- Black Temple: Akama's gossip reads the Illidan gate data instead of boss state 8 (now Illidan)
UPDATE `conditions` SET `ConditionValue1` = 18, `ConditionValue3` = 0, `Comment` = 'If Illidan gate data is DONE'
WHERE `SourceTypeOrReferenceId` IN (14, 15) AND `SourceGroup` = 8713 AND `ConditionTypeOrReference` = 13
AND `ConditionValue1` = 8 AND `ConditionValue3` = 2 AND `NegativeCondition` = 0;
UPDATE `conditions` SET `ConditionValue1` = 18, `ConditionValue3` = 0, `Comment` = 'If Illidan gate data is not DONE'
WHERE `SourceTypeOrReferenceId` IN (14, 15) AND `SourceGroup` = 8713 AND `ConditionTypeOrReference` = 13
AND `ConditionValue1` = 8 AND `ConditionValue3` = 2 AND `NegativeCondition` = 1;
