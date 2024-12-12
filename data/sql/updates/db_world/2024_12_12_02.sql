-- DB update 2024_12_12_01 -> 2024_12_12_02
--
UPDATE `conditions` SET `Comment` = 'Player must have aura Lance Equipped' WHERE (`SourceTypeOrReferenceId` = 16) AND (`SourceGroup` = 0) AND (`SourceEntry` IN (35644, 36588)) AND (`ConditionValue1` = 62853);
