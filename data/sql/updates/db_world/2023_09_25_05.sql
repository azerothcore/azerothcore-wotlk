-- DB update 2023_09_25_04 -> 2023_09_25_05
--
UPDATE `conditions` SET `ConditionValue1` = 6, `ConditionValue3` = 2 WHERE `SourceTypeOrReferenceId` = 15 AND `SourceGroup` = 7139 AND `SourceEntry` = 3;
UPDATE `spell_target_position` SET `PositionX` = -11165.2, `PositionY` = -1911.95, `PositionZ` = 232.009, `Orientation` = 2.14352, VerifiedBuild = 51845 WHERE `ID` = 39567;
