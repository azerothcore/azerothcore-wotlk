--
UPDATE `quest_template_addon` SET `ExclusiveGroup` = 0 WHERE `ID` IN (6541, 6542);

DELETE FROM `conditions`
WHERE `SourceTypeOrReferenceId` = 19 AND `SourceGroup` = 0 AND `SourceEntry` = 6541 AND `SourceId` = 0
    AND `ElseGroup` = 0 AND `ConditionTypeOrReference` = 47 AND `ConditionTarget` = 0
    AND `ConditionValue1` = 6542 AND `ConditionValue2` = 65 AND `ConditionValue3` = 0;
DELETE FROM `conditions`
WHERE `SourceTypeOrReferenceId` = 19 AND `SourceGroup` = 0 AND `SourceEntry` = 6542 AND `SourceId` = 0
    AND `ElseGroup` = 0 AND `ConditionTypeOrReference` = 47 AND `ConditionTarget` = 0
    AND `ConditionValue1` = 6541 AND `ConditionValue2` = 65 AND `ConditionValue3` = 0;
/* DELETE safety: exact full condition primary keys removed above. */
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`,
`ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`,
`NegativeCondition`, `ErrorType`, `ErrorTextId`, `ScriptName`, `Comment`) VALUES
(19, 0, 6541, 0, 0, 47, 0, 6542, 65, 0, 0, 0, 0, '', 'Quest 6541 available while quest 6542 is not taken or rewarded'),
(19, 0, 6542, 0, 0, 47, 0, 6541, 65, 0, 0, 0, 0, '', 'Quest 6542 available while quest 6541 is not taken or rewarded');
