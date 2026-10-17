-- DB update 2025_01_07_02 -> 2025_01_07_03
--
DELETE FROM `conditions` WHERE (`SourceTypeOrReferenceId` = 17) AND (`SourceGroup` = 0) AND (`SourceEntry` IN (17160, 17159));
