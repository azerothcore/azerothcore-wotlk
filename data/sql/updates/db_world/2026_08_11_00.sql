-- DB update 2026_08_10_02 -> 2026_08_11_00
--
DELETE FROM `conditions` WHERE (`SourceTypeOrReferenceId` = 19) AND (`SourceGroup` = 0) AND (`SourceEntry` = 13120);
