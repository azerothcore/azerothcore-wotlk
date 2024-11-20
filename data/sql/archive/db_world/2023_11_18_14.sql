-- DB update 2023_11_18_13 -> 2023_11_18_14
--
UPDATE `conditions` SET `SourceTypeOrReferenceId` = 17, `SourceGroup` = 0, `ConditionTarget` = 1, `Comment` = 'Releases the force of Neltharaku upon an enslaved netherwing drake.' WHERE (`SourceTypeOrReferenceId` = 13) AND (`SourceGroup` = 1) AND (`SourceEntry` = 38762) AND (`SourceId` = 0) AND (`ElseGroup` = 0) AND (`ConditionTypeOrReference` = 31) AND (`ConditionTarget` = 0) AND (`ConditionValue1` = 3) AND (`ConditionValue2` = 21722) AND (`ConditionValue3` = 0);
